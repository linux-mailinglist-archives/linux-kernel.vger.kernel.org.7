Return-Path: <linux-kernel+bounces-730347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537DB04377
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EFA1A6702D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9D25C6EC;
	Mon, 14 Jul 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="teOSROtz"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB125A2C0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506236; cv=none; b=RJPpvdYw28m07Q8rg7nV/NuulMbeu+3U4pKeJnZQL2dFLT9eJ8Fh1TL63RDrkPnTzANWl13o/wKyTJP9MguUikT/fc5cMBW69keT3h0uoJwwx4CdgaMErUHrtaD/DwGqdvSD8l6ym+ebJqot1IuGUCmfVwtvIt3bxGnDf0Z8k90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506236; c=relaxed/simple;
	bh=vL75guMdetT8bg1kaLijPYdRlferqGYTtMt7+vQXB/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTHvqJrS9ZCyQdMRu5uAPjgHY54RxW1Rk/h6tBkrNOAMdWXFhLarXAYCjbBVWI4jC+27mS5OKvGC2/mhrBDDYl8/djbgln552ykYnWJ8MPGh19Uvv+vgzCy98D3pGm2MYZXLFYYlHz1PCjktPAmnYtTB3wb0E8HP12L6CdgmlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=teOSROtz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23827190886so53401405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752506235; x=1753111035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SV9kD0Nq2OJ6HyWBCK/vxyokHGzlhSDgmvsShfvZ+8Q=;
        b=teOSROtzuQKEukU+UXW+Eecusv9x5X1nOR/JRrIDv8UJKpF9ctMAaPoXePCV/KpD+I
         MlKckuHrVQAGRVsNFxUGyyDeSHJx5zeA9N4HVz5yF6n1kHQo1Ywu/23Ft/HYHs1bOpyG
         5hXtivOhbDzdNPqBwmdPf3qI9sG0GcJ31SlpdJm5bcJg27DAcKeVADLrVeS9PynVi+uH
         LK0d/CUmDtg5QuTd9mezkSH01ImDeYRsKf/BCI35CIItgsLna5/PbvjmNM9JseeGYYuh
         Sm6QLFbDXZ0zcPCyRAjP1HjC59ebnjggh6lBI579D+EyOiiSyU6+K+4BXL3Pb2Ii6W0n
         TYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506235; x=1753111035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SV9kD0Nq2OJ6HyWBCK/vxyokHGzlhSDgmvsShfvZ+8Q=;
        b=H2RKIvJ3o+OFQ5bkbuA2/xV3cLxD9SgTYkl6iLzthV1hyQpBIAzQS7RgUTez29THO5
         NHwPAiszyIkUxD6FDqGaKZWxg8tt2HLj+kP6htcvBfGLNYoLl43Q63VE1UdlgtAU2zXe
         QFFYtQcEZRV3g2sk2DFaD4BpCs1TAJ/qVct6oG6b7QKVKETL+5MjyesTobo2GxINW2Uq
         XVIH0yZvWPFo924GnnBsxCFPhb6hf9JbWFGY6yeDE9r5GC9GLNGdhnWtdWzbZTORhCUY
         eFFsNLvKvh0r/FbBIZ5ygpRINGm0BvQRYCiCBDKg29yS9mygaH59prVnxJ6Rw6qCPTYM
         0bOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQVZybXqV36bXq4BQA7oz9Me+UvB8a8s40PPF/ge2yvFKm7XYEt9U3KitxmdVsEWBv+jnCm/Z5nv+MDAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DQ+K+7PWpMmG+u2ef5gaPst9UzvNjNbxQhDyOfIF6GDIaYyx
	VA4JA2HXBjvs/2P9WxbaOI7oI4wBCkQ0LGQVidl5AibKCzwzjKirYf9Db92hiQxl55Yhs2aaVsg
	qITUOJw==
X-Google-Smtp-Source: AGHT+IGnF0kP1Rf6L3RhXJwr88e2CnA0Egzqee2JDqtbwmf2j6w1iemwdT5GZk8FN2e3OozQu4JSAjjxBkE=
X-Received: from plge3.prod.google.com ([2002:a17:902:cf43:b0:23d:dd69:dd08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:234:a779:47cd
 with SMTP id d9443c01a7336-23dede448cemr188894755ad.15.1752506234690; Mon, 14
 Jul 2025 08:17:14 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:17:13 -0700
In-Reply-To: <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711041200.87892-1-nikunj@amd.com> <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com> <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
Message-ID: <aHUfecs9UJPx0v_C@google.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted GUEST_TSC_FREQ
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Tom Lendacky wrote:
> On 7/14/25 09:24, Sean Christopherson wrote:
> > On Mon, Jul 14, 2025, Borislav Petkov wrote:
> >> On Fri, Jul 11, 2025 at 09:42:00AM +0530, Nikunj A Dadhania wrote:
> >>> From: Sean Christopherson <seanjc@google.com>
> >>>
> >>> For Secure TSC enabled guests, don't panic when a guest writes to
> >>> intercepted GUEST_TSC_FREQ MSR. Instead, ignore writes to GUEST_TSC_FREQ,
> >>> similar to MSR_IA32_TSC, and log a warning instead.
> >>
> >> Why?
> >>
> >> Nothing should poke at the TSC MSR and those who do, deserve what they get.
> >>
> >>> Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
> >>> with Secure TSC enabled, as this indicates an unexpected hypervisor
> >>> configuration.
> >>
> >> Huh, this sounds weird.
> >>
> >> What are we "fixing" here?
> > 
> > Returning ES_VMM_ERROR is misleading/wrong, and panicking doesn't match how the
> > kernel handles every other "bad" WRMSR.  How's this for a changelog?
> > 
> >   For Secure TSC enabled guests, don't panic if the kernel hits a #VC due
> >   to attempting to write to GUEST_TSC_FREQ, and instead WARN and drop the
> >   write.  The kernel should never write GUEST_TSC_FREQ as it's read-only,
> >   but panicking with ES_VMM_ERROR is both misleading (it's entirely
> >   reasonable for a VMM to intercept writes to a read-only MSR), and
> >   unnecessary, e.g. the kernel eats #GPs with a WARN on every other "bad"
> >   WRMSR.
> 
> Maybe it should be returning ES_EXCEPTION then instead of ES_VMM_ERROR
> and forward a #GP, which is what would have happened if the guest tried
> to write to the read-only MSR if it wasn't being intercepted.
> 
> I'm still not a fan of intercepting writes to read-only MSRs that are
> passed into the guest. If we're trying to replicate bare-metal behavior,
> then allowing the write to fail with a #GP seems appropriate.

The guest cannot dictate VMM behavior.  If the guest side wants to panic, then
so be it, panic.  But don't blame the VMM for taking a conservative approach.

If you want to dictate VMM behavior, then the required behavior needs to be
explicitly documented in an "official" spec, e.g. the GHCB.

