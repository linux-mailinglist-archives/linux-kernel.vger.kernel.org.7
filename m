Return-Path: <linux-kernel+bounces-656575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FDABE823
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCC916A689
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1525F7A5;
	Tue, 20 May 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phYVTxvS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415F25D1F5
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784356; cv=none; b=gSZaTgB+TYARnhLv837QRsu5IKJtZ/RhtmHi0IIdbfIZsUX88wDbRrAktsQqenYiyh6klDeHuXPuTcMOxPBRcj3LZmlaoefdPIiTFEdvtZzymy8DTNBTBHkNYr0bw3Mq/e9o2KarEo8dBADHitSJaZEgfyB8XS5PARFle5NBJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784356; c=relaxed/simple;
	bh=qNW0arWXlRmhF4tOVFZz0ZKha2LDMSjtrVhlYdBNed8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTioAKS+E8Kk4K2HLfoLaGA5mfOiP2GILl2h8YcHtRre9HvKkxLb0AjkMbxbFS14DN1kbP1Wez8NMVsWf8bcT4CzPhocXmdbm4JvMvz9jcUqvA1LtdDbOcro9sI2t3CjV4UbalvKuMxD2MHQ20WFIOn05Na4W8JpOBTAuuD4j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phYVTxvS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-443d4bff5dfso222925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747784352; x=1748389152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRuU/m5dc5FtJi/f3Rrw2anhfRohi0i8yf3iq1OlqJ0=;
        b=phYVTxvSAmpqz/M4n0Rk87yvA4M6W32UAkrZOlT+psyUIysRvKkFuoqSDcX7S/opnV
         KL1GpAF6jpi8WvDGCdm6/uPZxx04PV/Ec/eimFSmmQcEzU6QlJxack6+QC0ZKphw0QNU
         icmO0QZFLgXcvOmizZm0nzwJsg/F+tqJIMNq/yOLB83J6WD9Updphm1gva09AyIA6iq7
         JqZLYj4gII8JO+I/V5Oo0z8XvJJ94Vatwwg9cOVD6VB9kW2jaixtyNHNVR+l6Ejc1/iY
         tzpeGbsD9iIixVs7zVpE11lv45+lShP3mgpinP4pnyN2SFXJnc5rbdRAF2Ql2Chd/18E
         vwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784352; x=1748389152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRuU/m5dc5FtJi/f3Rrw2anhfRohi0i8yf3iq1OlqJ0=;
        b=InZCzMxEP4nKTECgciFB0RMQpXszFK+yx7ri/In/U65sQNWmu82RcfjsqiYmCxR8sq
         +SCUO7QJCt1Le57zziZKS0/WzCBVwC+EWrvcmnr4Fu+SGygjLgfrf131VJmjU8AYAE4U
         iA5+xsP4u5yQ9kmCD92NYVpJzWgyMr24XdZSEDExvAEdJ5oxCyY0itEa82h2YCHJJ1K0
         HsnB2+V2rRD7YX/9mj+Upspw19s8XoHANgMRonqK6MfFfThG9RnuDwmxHpavaLUtmSvg
         9Dj92oJHSu4QIHEbxzLyPegnHTse4rKSrY0NIfVHHDpWtcAClJIC8+8muTwEnXiclN/i
         z+rA==
X-Forwarded-Encrypted: i=1; AJvYcCWPEpPp5DupcNZIhQtIITRoFJBS/LbSt382aakxZ806BwHvZcOXxI8GreOa2+GVUobJsIrtrXBc1z67hl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZN4FVbqpYHuwssaxYSYQ32SAtH7/Co2heUjK/XRRv/r29jzN
	SlxTCmvG9UPHl+coullm7W6tQlY2rl9X7eWQ23NUEbpG+pKN6wOWBkSZTLZwWGw9s/EJdlBGe0B
	2OOUyyjCACCksq1lDqu4mSSemQ5ZmZ9vC5PHpAo02
X-Gm-Gg: ASbGnctCNlAk5s6JMirmBtPLrTVeCpv5H/z2/tzWtTsOvo4cmMSE1ilm9GhWB3Qt7HA
	+iAE2HFDbXtC2fVS1wESpo7xZtWHLdUxwmz9AGl4rEPy7iimJp43MDrzMRym7b4x/sNPInnMK/b
	megYaq2L7Xe4C9Jb5q93yXZjl21S1Xu0DT6/PnLW/Jw/OBVNKtDkisKzor1NaICT0ZixOij/UV
X-Google-Smtp-Source: AGHT+IEmTo+oS9URXfIuKouUY0B0Y62o5TMKaVmZC8slqtUcsFC1AZMBLwucs8WQvvTTsv5lG6xeERtZDgSchwhBuX8=
X-Received: by 2002:a05:600c:2e49:b0:439:961d:fc7d with SMTP id
 5b1f17b1804b1-443ae3dbdfdmr4250875e9.6.1747784352208; Tue, 20 May 2025
 16:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com> <20250505161412.1926643-3-jiaqiyan@google.com>
 <86zffcefk9.wl-maz@kernel.org>
In-Reply-To: <86zffcefk9.wl-maz@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 May 2025 16:39:00 -0700
X-Gm-Features: AX0GCFtfiDim2rVM9--MtRE7iY2zI_cJEhnOXz73-OdjqCpU57FjKEAM9M0zDCo
Message-ID: <CACw3F52v_WSR=HkmeW7be+YRFkUzA-n-=mVHHw4wvJK7ongkYQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] KVM: arm64: Set FnV for VCPU when FAR_EL2 is invalid
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 8:33=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 05 May 2025 17:14:08 +0100,
> Jiaqi Yan <jiaqiyan@google.com> wrote:
> >
> > Certain microarchitectures (e.g. Neoverse V2) do not keep track of
> > the faulting address for a memory load that consumes poisoned data
> > and results in a synchronous external abort (SEA). This means the
> > faulting guest physical address is unavailable when KVM handles such

Actually this is not relevant to the code, I think it is just
sufficient to say "This means that FAR_EL2 holds a garbage value and
therefore kvm_vcpu_get_hfar holds a garbage value too".

> > SEA in EL2, and FAR_EL2 just holds a garbage value.
>
> I don't understand. FAR_ELx holds a *virtual* address, and never a
> physical address (that'd be PFAR_ELx).

Sorry my writing is misleading. If you are still interested, the
scenario I meant to describe is
1. There is a SEA taken by KVM when memory load from the guest
consumes poisoned data.
2. The guest physical address (or IPA) of the poisoned data will not
be available in HPFAR_EL2 per architecture register documentation [1].
3. Although HPFAR_EL2 is unusable, KVM can still attempt address
translation with the guest virtual address in FAR_EL2 to get the
poisoned IPA.
4. However, FAR_EL2 is not valid on certain microarchitectures (e.g.
Neoverse V2), so in the end it is just impossible for KVM to know the
poisoned IPA.

Does this clarify things? But again, it is confusing and will be removed.

[1] https://developer.arm.com/documentation/ddi0601/2025-03/AArch64-Registe=
rs/HPFAR-EL2--Hypervisor-IPA-Fault-Address-Register?lang=3Den


>
> >
> > In case VMM later asks KVM to synchronously inject a SEA into the
> > guest, KVM should set FnV bit
> > - in VCPU's ESR_EL1 to let guest kernel know that FAR_EL1 is invalid
> >   and holds garbage value
> > - in VCPU's ESR_EL2 to let nested virtualization know that FAR_EL2
> >   is invalid and holds garbage value
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  arch/arm64/kvm/inject_fault.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_faul=
t.c
> > index a640e839848e6..b4f9a09952ead 100644
> > --- a/arch/arm64/kvm/inject_fault.c
> > +++ b/arch/arm64/kvm/inject_fault.c
> > @@ -81,6 +81,9 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool =
is_iabt, unsigned long addr
> >       if (!is_iabt)
> >               esr |=3D ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
> >
> > +     if (!kvm_vcpu_sea_far_valid(vcpu))
> > +             esr |=3D ESR_ELx_FnV;
> > +
>
> I don't understand what this has anything to do with the uarch details
> you talk about in the commit message. If the VMM inject an exception,
> surely it has populated the exception context itself. I don't even see
> how we'd end-up here (__kvm_arm_vcpu_set_events? seems unlikely).
>

KVM_SET_VCPU_EVENTS is indeed the case this commit wants to fix.
Instead of populating the exception registers itself, VMM can use
KVM_SET_VCPU_EVENTS to let KVM do that per existing KVM doc [2], e.g.
when VMM handles the KVM_EXIT_ARM_SEA introduced in the previous
commit. The intent is to tell guest, for example, to not use FAR_EL1.

[2] https://www.kernel.org/doc/html/v5.10/virt/kvm/api.html#id3

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

