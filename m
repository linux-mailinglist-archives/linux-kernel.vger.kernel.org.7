Return-Path: <linux-kernel+bounces-773960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD185B2ACE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F76189C914
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBD25B67D;
	Mon, 18 Aug 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5PLG6WY"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7048259C9A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531335; cv=none; b=dgm/7swr5UkBVTi/y+pIGuSxyV2eNaNA8Uh6ETHnpdZ5Jicg2ph85UisLDOyKZwrL/G+vEczmxt3F98UqRhWe1EReKXWfV2L+d5oQVva/TODb5QrktLk/Z1TuwF2kGDldtGzmHEv/ELkQWhktMJx7joA/jaEr9PR7g3+juf0wOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531335; c=relaxed/simple;
	bh=UnqrP5abvUiakRDvE9o1lg1568CGAvypnHLNsDdEFQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YS4LG0rWCRXq9F6Bo7QDJm5gdPWUnXIEP1YPblsAP+1NVYgjuvtgnlpLNKRcCb3XF+OiZRkyQMapD3yTtIEQCPqUTnbYkrQJIfHeKysBOP+OHmD8TaTIo4uZKFcF5sXsRS4ZDAD/Kncitul+3m05q+SnW8VRO/upA0Mr8strWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5PLG6WY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e1f439so4161845a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755531333; x=1756136133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/kp9zi42UnlgmEI1JQtoaYRqGEVU63+3Wn/82V05Lg=;
        b=C5PLG6WY5ToeiX1V5B2UN8Id9ErV1dXZRq0Y2YIfCW6gx2RnuXrhe/Jg9ejI0qCAvH
         nU/o7FoYU6QS0JAQX9R6FplXyvasf1WMBk9jPxFRWCvCQpSBUSC4kbA+fTyRY8QmLqLX
         CQ4hDSxFqOqWB3XRV9szVbcf3UlFfEI4Lqwb0gSzZ3TttWYK7xpZdqXv5EOKN22ua6f5
         in6v77x0BBs662unWdvywtCrzB0JOhMg83G0L3g5aWvWWVDIOqVVg8vbdcVku+wfwecb
         QwUQGX/22zfOUD2ahdr1DWnZXpe7LM/MOQUPsF3g/kSgO67+gbeu8c31rO5kB3GSdPzz
         wQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531333; x=1756136133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/kp9zi42UnlgmEI1JQtoaYRqGEVU63+3Wn/82V05Lg=;
        b=OVL3Koq4z81Gwhllk9SzAmG3ROeR3Q9SWhxm6kgE7NvzvUwnNYYKNOU4MIaiGOHotC
         BJhP29h7nIONYRXP7MYFhOZCLa41JcMS2q268LMnckBcd8O9jpnS0ZVXBy4GaWSGSuuQ
         btkHoQSK16c7tdzmjUZ2pkvKnCeOeZX5xaoeODHz05yEoAeVOCQCvAlSIlgWXq6eX8Y5
         fZYiptD7Fuah4QndPB+XAMu6kVg0J3pxyvoym5BXsKdlJ5hQvfmPZ/QUtQlKbpJMcJi+
         e8GCCwetivjeNPl5iWT63GXIRuYoM22F+I0XagJEUcUfMpmueeEFyINfqgLfpmTpHec5
         5+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOz3CoEEZ85ENcgrujtDCRaQG75Ct6paW7XBtKbxLF9ktbUo2Ri4xfZRQuKqBaEVqsV82n+3IQdd5++bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxem/0LuEsD5sUBaAl0qmWoySocw5wxHedcW62wL4oeXPerAgyC
	oKsbTPL8NLyF8rJZveSy49Ku2lDdRxNU9IpIKURmhmZbPStJzAacsgZR2llQOgUWS8oNpVi0upp
	QKBt/xA==
X-Google-Smtp-Source: AGHT+IFrPKVsWtGyoRgDes4/BkgZ4mpLnvlNMsvJYH0IEb2aj1UmFzpIXxupJE0I5pJ/TaxOfupkVw2RxQU=
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:312:151d:c818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c7:b0:321:265a:e0c2
 with SMTP id 98e67ed59e1d1-3234218c09dmr14775914a91.32.1755531332713; Mon, 18
 Aug 2025 08:35:32 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:35:31 -0700
In-Reply-To: <20250818143126.GHaKM5PsVZPXwr5sPi@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aIKehTDgP-Nu36ol@google.com> <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com> <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
 <aJ-pJvrPyHyPI0qS@google.com> <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
 <aJ-5XDXp1CxKB_7J@google.com> <20250816084218.GAaKBEaukeGa6b5UBj@fat_crate.local>
 <aKM3moQgdlqr6qIy@google.com> <20250818143126.GHaKM5PsVZPXwr5sPi@fat_crate.local>
Message-ID: <aKNIQ9b4fixOVSP4@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>, 
	David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 18, 2025, Borislav Petkov wrote:
> On Mon, Aug 18, 2025 at 07:24:26AM -0700, Sean Christopherson wrote:
> > Most definitely not if the guest owner and host owner are not one and the same.
> > The example use case is where the platform owner is running one of _their_ kernels
> > in a VM, in which case that kernel probably does want to know why the platform
> > reboot.
> 
> Except that can you control who uses that feature? If it ends up being used by
> a VM stack where the guest owner should not know the reboot reason, you've
> lost.

Yeah, but "expose/advertise XYZ to the wrong VM and you've lost" holds true for
so many things.  In all honesty, of the many ways a hypervisor/CSP can screw up,
this one doesn't scare me at all.

> > The same thing that guarantees hardware vendors adhere to specs: the desire to
> > get paid.
> 
> So you're basically saying all HV vendors return -1 for an unimplemented
> register and we should be fine there?

For this type of register, yes, they should.

> > And QEMU did return an error value, 0xffffffff, a.k.a. PCI Master Abort / PCIe
> > Unsupported Request.  I would be amazed if any real world, general purpose VMM
> > did anything else for an MMIO access to an unknown/unsupported range.
> 
> Ok, I guess we will know soon enough. :-)
> 
> > Huh?  Handle a read of all 0xffs as proposed in this patch, and this is unnecessary.
> 
> I don't trust that all HVs will DTRT. But ok, I'll take your word for it.

Heh, I don't I trust hypervisors/VMMs either, but if they don't behave, then we
yell at them and/or send patches.

