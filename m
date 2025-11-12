Return-Path: <linux-kernel+bounces-898141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0BC5470C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCB3F349E41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A492D8370;
	Wed, 12 Nov 2025 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhCnyOnI"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3A2D73B5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979102; cv=none; b=D71zlYDHA0KeMHfrkl5etzR0uogvlaeC9neGmAHoIs2VKQu2Aw7RuGTadJBLm+nsaIB1daJ1m+aZOfxRbkIjR1zaW7PoZEzUHytOVpe+Cl7j04W4U24Np0rwbJVaLOpaPytwKBh53AyAI3zmeaCEeH2FXeuX9epLSfSf0S6F1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979102; c=relaxed/simple;
	bh=xOBJurVKNAB+JN8ysTBvLTNXtFm6u8VFeaWdmIXvjpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Btlgo+bB7hyKXtLvFLRMlsxsw98BH6dmln+sAWXtLNwWQ0WOsqN5yW/MI8PbLJc5iAsx/UUS35tuYsFrERLjj2Q+sj83Kv5TKoUVHpjrWGJet1u8KizMRfVtkEjoBdSTdcY39yQtEyoIEqm2SlKvZgN6xxkEhZlvN7o0p1K10Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhCnyOnI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso170876a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762979099; x=1763583899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R19jKoKnEOV3T9FY0coy72Eb+Kw/7o9G8gT0tt1VVRU=;
        b=JhCnyOnIGcwn7l6ksRX/pWX3zXo+XDeKvhReY30Pbiwn4nk+nQuvMTLTEsPc17UdrZ
         MhHEfxhMIy/nHQFpa6TNLU5QuuW3VEHCXdZCFQ3lm5HX9wYO+w8rT/lJl/KifE3J0J7H
         pEeDIbmro/hEitmzrsC0uPm2B+mk3gvl3mRFr1k7o5Hujo/VBpSUUc6NSmiTBGo8V8hN
         8IR+VCXWNz2JEH2E73lMtTyt6mtepF7oGdZXf4Tz8dVsk26qPdMEcsyAMGy8OtvB28VM
         FwdAI7DstVQBYggajFUmw859Dlkt1vCD/eE3ccuY9jUjAF5n/WDzzdbIwnMUstkryyJE
         PcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979099; x=1763583899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R19jKoKnEOV3T9FY0coy72Eb+Kw/7o9G8gT0tt1VVRU=;
        b=e+JjgTPO9onpiOcsNbssqUXsDTWruGmycefzbwl/gOK1DwyZkwXCg7Cy9m+1a0y9z0
         H7CcdFHP2Ra8bZZd5jqKp7ue4yiPTnmRux/DxAkYg7MzFLCqdlk+qmqU1JGBHvYzr4+X
         p47XZ8QNLh6XYlnLQw+k04D6f0eEbWnGk5pofRU1oSn7uQbhuFXVgYWnEEk2GUZ8a/D8
         PT6DHekkPK7JvHY6Wg6FI2vd4gbjfcaWlVK4gjaYiOxGP+0/v9ISjj53050w7j3O/EYT
         H2QGuDaY3994AzI9F+mVOtoVphcjDvvxQLdgQB84ekM2NnJU/CR0K6GYS2mLa6o7zp0z
         EWOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTCsqlGAWqQuMOLnV7b/TUyxCSon+CMiX8j9QQkMnl6XzY40TEBP7N2Z05utcWsGcFUM1o9SCUcTZOeXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyh3kJLyvQRVqdDjyj0pARBvwQuU/G0a/pp8jmx5nnpDvvR/Or
	UY4Ns+ta8KsjQEz6iV6cayn637snCbN66ZGvVgEgAZkrtAyOHeXPJ0dk4nkX7YZcHnJGSt+VcJj
	RP8roOg==
X-Google-Smtp-Source: AGHT+IEhrkRuxdVjG9E1wg6vwlC1Maca+rkxHkRIYFv3rPQj/aKYOj4uyC5LCnl4mOfkA9YSmbhXYZTSx+4=
X-Received: from pjbgc20.prod.google.com ([2002:a17:90b:3114:b0:340:bb32:f5cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:340:d569:d295
 with SMTP id 98e67ed59e1d1-343ddec5a1amr5597730a91.24.1762979099327; Wed, 12
 Nov 2025 12:24:59 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:57 -0800
In-Reply-To: <4a2a74e01bfd31bc4bd7a672452c2d3d513c33db.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112171630.3375-1-thorsten.blum@linux.dev> <4a2a74e01bfd31bc4bd7a672452c2d3d513c33db.camel@intel.com>
Message-ID: <aRTtGQlywvaPmb8v@google.com>
Subject: Re: [PATCH RESEND] KVM: TDX: Use struct_size and simplify tdx_get_capabilities
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 12, 2025, Rick P Edgecombe wrote:
> On Wed, 2025-11-12 at 18:16 +0100, Thorsten Blum wrote:
> 
> kvm x86 logs are suggested to start with a short summary of the patch. Maybe:
> 
> Simplify the logic for copying the KVM_TDX_CAPABILITIES struct to userspace.

Yeah, I have this locally as two separate patches:

  KVM: TDX: Use struct_size to simplify tdx_get_capabilities()
  KVM: TDX: Check size of user's kvm_tdx_capabilities array before allocating

Your CI caught me just in time; I applied this locally last week, but haven't
fully pushed it to kvm-x86 yet. :-)

> It looks like you are conducting a treewide pattern matching cleanup?
> 
> > > Retrieve the number of user entries with get_user() first and return
> > > -E2BIG early if 'user_caps' is too small to fit 'caps'.
> > > 
> > > Allocate memory for 'caps' only after checking the user buffer's number
> > > of entries, thus removing two gotos and the need for premature freeing.
> > > 
> > > Use struct_size() instead of manually calculating the number of bytes to
> > > allocate for 'caps', including the nested flexible array.
> > > 
> > > Finally, copy 'caps' to user space with a single copy_to_user() call.
> 
> In the handling of get_user(nr_user_entries, &user_caps->cpuid.nent), the old
> code forced -EFAULT, this patch doesn't. But it leaves the copy_to_user()'s to
> still force EFAULT. Why?

I'll tweak it to explicitly return -EFAULT.  Doesn't matter terribly, but KVM's
standard pattern is to explicitly return -EFAULT.

> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com> (really the TDX CI)

