Return-Path: <linux-kernel+bounces-723810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23EAFEB26
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA7854694E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CC2E7181;
	Wed,  9 Jul 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzOVu1vH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD52E6D22
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069338; cv=none; b=Psi+oySh/jx8fnEjjpk0Xn2e40DU1Yfy4gNL2rXTa0UH8ERc0HPV253va6NsGNlW9U+WkUw1zn9vhg5YpUf60sUVE4kc+LAEWI3TjGhqqltytnYh1gZ9+3m010rYQLg8C2+Ri6tL1swvgqdxkvPmDq6nTdMn3xGbMLQnt5ld3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069338; c=relaxed/simple;
	bh=0h9vbjsgJ4KM4kpziRTulPuUJGQOT13eleRpBAru710=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8sVCIauD08divPigKi+EL5jKoBBtZPPGidR7VaYDJuK9Pl6pQYvR+6tf1rw/GKWq55JKXPLX6hnTzpj/G8b4gstUvvYLFwSiIh25lnTFz7JotBAdgVeImzu1nSUiigFWCaP+gsHgWUFQStXEXvqdD/nNE8n/9IASMXunspAD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzOVu1vH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315b60c19d4so4316665a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069336; x=1752674136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hB2pq64+EiT3q+LG5n2vE09OllB22A/8i32Rf86ziks=;
        b=IzOVu1vHAiZQEW1SK9aITiCIGPOggzl8NHWRVQJBgoLcGSg2u/0on9W2TcDLu6JHny
         Ugz1GTUMT2tGgQkTI3WJXqTCzVXvsRdVAxrObAnSaMhd3EuRXcWzffk+1eRMuZnrflg0
         ATpR7ptMUXiAil3evEELHgLyEEn68SCHZFUsK9zV43w6C5QwBWkO+UV+9Jw9HoZnObYM
         8QdAj8VdML8ieYhklbw9GfwqSFBfHsQX5Ef4ADBG0f2MRElJ5Xkxpu78AxA76NEad84e
         v6OLA75Wu9vSZHwFiBdDMJyzs7+Cm3wFCtms3jO96QwWZcw9NsLmA915hMd+rRDxq7pK
         b8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069337; x=1752674137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB2pq64+EiT3q+LG5n2vE09OllB22A/8i32Rf86ziks=;
        b=Wh4oJO9mzY2Af/xklKde/oJ0S+CnLYi92W7rM741+QwfROatyLGluptn2rgvb/YRRu
         HXYwWyHFZ7UM3mwtzuvjto9YY+ejp044gedyW0NcUb7HWCO7sqwYcbtP08wss/RR248e
         ZzmAFg5R4kaOhTD4rmcOIwmUL7ay4zqMc7bTgIa3nfbhjbpah/5IBTwn7pc5WlLa9LUU
         OnFcw1Uw3Vu4z/iNyVTvJibhBzqWRt1kOVsHKD9E880e2kPuVeuqL5PdmkX/UMtSBRf5
         c6SQa5MxKeX5xG3tCSLpZsP9l2L38HZV8SCcCTqdnDizm3YSqQeEvCbQaJBQw6qPQ5JI
         Uoiw==
X-Forwarded-Encrypted: i=1; AJvYcCWUTWXi3XsU+JmcxQwL1tdtbPKmZVn42Bhh9jl7dx6tYuG9z+/G4JVUVaCUi+etT5lmGHy6cjdn7XtME0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpNaUxjcv/kCratrbZQ1lyimEm9FHffom8uSAHI/9+a18SDX7
	Ct+l0PtzB1E7enHHr2lRKRwivPVorftj/A8JZcdJaP6gWdeZ+KR/zCjS1mQemwFFbsQ/25Hs20G
	BpRF1Yg==
X-Google-Smtp-Source: AGHT+IEoqYqG05CCJJatVWyMPh8LvhP8g90wNpXynV+lVfyOqsEL9Ixv2ihGPj+7dKMNBozMlFC5A8s1AoU=
X-Received: from pjbta13.prod.google.com ([2002:a17:90b:4ecd:b0:311:ea2a:3919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5345:b0:31a:bc78:7fe1
 with SMTP id 98e67ed59e1d1-31c3c2d4748mr6038a91.18.1752069336491; Wed, 09 Jul
 2025 06:55:36 -0700 (PDT)
Date: Wed, 9 Jul 2025 06:55:35 -0700
In-Reply-To: <aG4ph7gNK4o3+04i@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1752038725.git.kai.huang@intel.com> <1eaa9ba08d383a7db785491a9bdf667e780a76cc.1752038726.git.kai.huang@intel.com>
 <aG4ph7gNK4o3+04i@intel.com>
Message-ID: <aG501qKTDjmcLEyV@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Reject KVM_SET_TSC_KHZ VM ioctl when vCPU
 has been created
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, nikunj@amd.com, bp@alien8.de, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Chao Gao wrote:
> On Wed, Jul 09, 2025 at 05:38:00PM +1200, Kai Huang wrote:
> >Reject the KVM_SET_TSC_KHZ VM ioctl when there's vCPU has already been
> >created.
> >
> >The VM scope KVM_SET_TSC_KHZ ioctl is used to set up the default TSC
> >frequency that all subsequent created vCPUs use.  It is only intended to
> >be called before any vCPU is created.  Allowing it to be called after
> >that only results in confusion but nothing good.
> >
> >Note this is an ABI change.  But currently in Qemu (the de facto
> >userspace VMM) only TDX uses this VM ioctl, and it is only called once
> >before creating any vCPU, therefore the risk of breaking userspace is
> >pretty low.
> >
> >Suggested-by: Sean Christopherson <seanjc@google.com>
> >Signed-off-by: Kai Huang <kai.huang@intel.com>
> >---
> > arch/x86/kvm/x86.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >index 699ca5e74bba..e5e55d549468 100644
> >--- a/arch/x86/kvm/x86.c
> >+++ b/arch/x86/kvm/x86.c
> >@@ -7194,6 +7194,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> > 		u32 user_tsc_khz;
> > 
> > 		r = -EINVAL;
> >+
> >+		if (kvm->created_vcpus)
> >+			goto out;
> >+
> 
> shouldn't kvm->lock be held?

Yep.

