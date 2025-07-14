Return-Path: <linux-kernel+bounces-730495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A287B0458D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EB74A39AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614826159D;
	Mon, 14 Jul 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwLB0PvJ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410371D5CE5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510968; cv=none; b=qpUyT3oOFbNIjYzd69g4NarF0ojZD0I44DLWS9lHX4WTv25FhA8fnIN5mJwo1neTiW5W3F+Jl3XEtg8m63IdSyRmbzfIwM2dhVur3VpOcrpYpsIYKBhFeJBOnOqSD9bx095Rd3uL+406BLHXB5NXx7FaV4hYPHp2sWBXPyySUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510968; c=relaxed/simple;
	bh=BIE6EqPtzaBB0n3DRQoPZczYKmT+vcSL0I3nilYkTgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxBrfZst7xB2n8A3Ooi81432QDuZ6XDEfvOfHpLuO2F3x7MobhuACe1aFBr6JyT2NNFNRxS0uuo+9/Saaopf47E7GINXgoHeZACdYdH6qK9xVmK4uIPWsu3DKNyjKEXN5Nyzh76MJzSzM7YB86dabL2bEVtUgi8Vi7baVVYRyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwLB0PvJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747ddba7c90so3835086b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752510966; x=1753115766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKOGgh4A0sRsPhNTCXyT6vgu+s7GimHYJMjis7EAfA0=;
        b=rwLB0PvJ9aZdRr7onjIHB2Zx/ucCW15PJCqRznsY8VP1OtcLgUzFYF8CeKhfMFobEB
         /bJzYTvhC2ri9uvkGJDgmT0PlMbgTUMV8KRU6WiYZ/ZqJ4rouDJn4P2rdQ0xxzJrueGp
         GCXRrWOL48KW34zeKJ8WRWRS6NRcMAuOkTd/o9ulo1/Mtywf32BN4JzkTudeprkQKMFL
         Ifmq6zvTogvklzOK59/rQ2gXALX3Kwk0mlp4Os8nwbwv9WzSws5/06KC9FLd1YypS6QS
         u5zzRKjHUDK83ws0LkvFS+H01RTuqY+tWTwMNQ7e589pO0UJ4SQT5PGaj9czubmOG6vF
         xatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752510966; x=1753115766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKOGgh4A0sRsPhNTCXyT6vgu+s7GimHYJMjis7EAfA0=;
        b=nYMCoWeEmdfdYQFJEbEGRyM5R+vQUaHCqIU0nU4n485p+j7dgaou9RCFKhfzmg6ssj
         mEvQ4zqGYcrSKdr6B6qNXMUawvJ1IbxmLnQhPrqtTgb6qeC1uilIh51sZG7JLdAQt4wH
         DTMK7bwVOWlXaTWK1GEs/Gi9NImoz9aNA0wuuAZrSnb6CX28VwBqOCpCivmH7+2+DlOU
         XM3Jka/STIGbHH0ztnRapJ7Fr+wAQqE6jftp9QlWaMLJEfWyJUPf5350fjTAJnqd7+1r
         vYnXq4GllvLf9p3guFfolwguFdTEY7+0ayRfIjmuz2b+QcK/7SPn9gyCje1csZGIMkg7
         d56g==
X-Forwarded-Encrypted: i=1; AJvYcCUdJfvPI9MTD8iVMxnC5sOBFOsyTOidnixjn6+UMcMhRD6BO8NSbnNmuwoCrtiJo9g+wCqZgxiucc9KWeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6IAwMylC7wz9eYrP8XyWwFGBHyTBoomhLBNMPgjuRv8rV6Y5
	HBzmlW5ve6g1MHIS0LaOUafKRCCVTB0h7MruTCVMSs2SnIS5Nt/0pQ8/XHAd0QX//EXWnPixGR/
	ZL5n5xA==
X-Google-Smtp-Source: AGHT+IFoF5TuFmAV8gfZjaznA3MZ9TVlWh+3SerNTx/itMzmqXT8toAj6HT9Xg+ZHr1IiVJIOZxiUJidRP4=
X-Received: from pfbdh2.prod.google.com ([2002:a05:6a00:4782:b0:748:e72f:1148])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d8e:b0:72d:3b2e:fef9
 with SMTP id d2e1a72fcca58-74ee352beb4mr18266664b3a.20.1752510966343; Mon, 14
 Jul 2025 09:36:06 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:36:04 -0700
In-Reply-To: <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711041200.87892-1-nikunj@amd.com> <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com> <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com> <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
Message-ID: <aHUx9ILdUZJHefjZ@google.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted GUEST_TSC_FREQ
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Borislav Petkov wrote:
> On Mon, Jul 14, 2025 at 08:17:13AM -0700, Sean Christopherson wrote:
> > The guest cannot dictate VMM behavior.  If the guest side wants to panic, then
> > so be it, panic.  But don't blame the VMM for taking a conservative approach.
> > 
> > If you want to dictate VMM behavior, then the required behavior needs to be
> > explicitly documented in an "official" spec, e.g. the GHCB.
> 
> Ok, so you want to squash the #GP from an attempted write to a MSR into
> a warning because this is how the hypervisor has been handling it already for
> others. Ok, I guess this is established protocol or whatnot.

Or as Tom suggested, return ES_EXCEPTION and let the kernel's normal machinery
WARN on the bad WRMSR.

> Now, why should it panic when a *read* is then attempted?

Because as you note below, the MSR read should succeed.  __vc_handle_secure_tsc_msrs()
is invoked if and only if secure TSC is enabled for the guest.  If RDMSR #VCs,
then the hypervisor has decided to intercept GUEST_TSC_FREQ despite enabling and
advertising secure TSC to the guest.  The guest kernel can either continue on
with degraded security (potentially dangerously so) or panic/terminate.  

> The APM says:
> 
> "Guests that run with Secure TSC enabled may read the GUEST_TSC_FREQ MSR
> (C001_0134h) which returns the effective frequency in MHz of the guest view of
> TSC. This MSR is read-only and attempting to write the MSR or read it when
> outside of a guest with Secure TSC enabled causes a #GP(0) exception."
> 
> So what is the established protocol for reading non-existent MSRs?

Looks like Linux-as-a-guest will request emulation from the hypervisor.  What
the hypervisor does is completely unknown, at least as far as the guest is
concerned.  E.g. the hypervisor could return an error (i.e. "inject" a #GP), or
it could provide garbage (on RDMSR) and drop writres.

> Also, if secure TSC is enabled, that MSR read should succeed.
> 
> The original text in the patch:
> 
> "Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
> with Secure TSC enabled, as this indicates an unexpected hypervisor
> configuration."
> 
> doesn't make too much sense to me.
> 
> Maybe you need to explain things in detail as virt and I don't understand each
> other too much yet.
> 
> :-)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

