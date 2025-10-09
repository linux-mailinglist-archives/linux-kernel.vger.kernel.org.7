Return-Path: <linux-kernel+bounces-846791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8939DBC90CC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC47E4F0A99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE02E22BE;
	Thu,  9 Oct 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="H+q9M6Uf"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3623E334
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013378; cv=none; b=AbyfeAVdCVlgWBoxNRD1qaUlcy941nz4dU0XP+XvgzsOMmsfp0fkajOjoWLKk7HUsK6pTxSc7b9bMM7oOx1rpCD6+GjkzJAzj/QoRjmDD13h3IiojqNFyCxtT4EPcBTDDnXpqC+g/ovCOb0wq+iUfWgyDW5yT+kCeKaeWsb7LXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013378; c=relaxed/simple;
	bh=BUQBsdls6cQatXLZOA94+w4SjQYvJUnlo0PLwrgy6Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJEJMxHCZ2DTviIYu4OKK8CeqxP5eLpafGh7I9uRQCxyRKTFqh+Kll0TyNB0JEX3y+W6OKWcGNhhXA6nxcbqqYS1ANRvgm/ESyTwdzz4wD5BrWGpxP93jCWRC6Ur1GQZG3rKq9wg6yUYg9wO7PVpzuTxFxz9a3BBkFpCIxxZtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=H+q9M6Uf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso204199a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1760013375; x=1760618175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ7LA/T4h3DNmOuWL6uY33mdEOFHAK565EfNiUCOSo0=;
        b=H+q9M6Uf7ZOCyf4D9eGOStqHzKgs03wPvMiEqmcwg1Zjm39Y/S5h6ZZxK8OCXrQWUS
         i15XrD/ScprhlsxCRIUPKzjIqTZh7q+3SgWAp/wbC5Cxri+uAeTorzqdIvnK6NJRVSa9
         2PTXRoydImzC/dKOG3UvT5pKEScMxhI/LwbLIERK8DDccOuh9HXsEr9Q/HRhPNwyzRlS
         p8nLuQCOE8HxRTRGIr2g0ymXY1td+P4Gq9nFyaJ6kV6wUF+y4RZOsLdcrjKn5vhssttD
         OEnbJb3taeZ0C2mjAEhp+OoZtHP1R88+p8F+vZ1eIJNpQ9cn8P+WzgbEpVHqQVpaxt4n
         VgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013375; x=1760618175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ7LA/T4h3DNmOuWL6uY33mdEOFHAK565EfNiUCOSo0=;
        b=S1ADmT5vEyt/rszPvCtr/K+oxnEEmbhVS+nuSJylwC2mF/fqr0qHFT5gOszyXgWL2Z
         F1mKZOFrZMVUhCf/ORFzWh46hpxhEiQuHrxTHzlvJ8yhR0lb3uciEjNFX3X8qxE56saa
         yNkIh0pU/VnuNSMEbIBPtLXAkm8nKhy6f9ZcNUmQzWg9V1J96O5r/ZuKVLeKkHeZe10c
         OAu1z9ANAfLOPTlwIG5oXZyx1t27IRaE90Sp/LcSLHgvO/NlX9CLU/A+sm3B4ZTNNRvM
         jJmmmp6RA88/ylXtoYAnhMVpetcPBmklYhdNKzap4a7m/lVvVGNd0jOyn/4fBNgjnfp7
         TFEg==
X-Forwarded-Encrypted: i=1; AJvYcCWszcHQNTj4S1QZkEzvcrPe8kCGR+gx6kj1Zwkafa63sr4RQpe+aQXixDFlZVLk+ouNuGIXGiPKJgAJOQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOm4KdyQrYcL0JZCF0huFFsJucv5TZo7XC4nqNSm40zzykaHC
	uYfTwqnZLrNkMpPlUJmjVxFYbEeXADhUAlRJS2jD/e4ahRAiquaJZc/Wi0G0z/2boP+YRwt1gTM
	LYSBuyI4OipPILMAzUDYxPgPxG28uxzrIrM+8k1eeRA==
X-Gm-Gg: ASbGncuYQXFJVUROzYPE/NlALa4+tZvS6pmW/Ly0mf61VezAKAli4Jqj3u4NhKwI7qc
	IWLQh3LIApMPgLHV0f7T5zuD1bAx/siJ/FWzgPvrzuZP/FoKpJaS6Po0A4XemDZyrGYiyqPe92N
	wUag0kcMIfRx8vyrtvzkf+BjnNHrVgGzItpBLGhD6XE7B3LmDcG3KrehRMnRtiGh2DqDmyV5C8J
	8KUO9cb0z14pmiBEOKpfZCKjmjhxQ2qAp3/7k0vcXlVWg3NLZtoynET99c+UlT5EuKqTud/7VM=
X-Google-Smtp-Source: AGHT+IHJ8z481edk/FUZpuigBukQXZbkdJtKkxIGpR5Pp6sBuc9y6b/F+9D3teWcKjV6zHaGl4KJbHZLgTQpFDypgC4=
X-Received: by 2002:a05:6402:51cf:b0:639:e56a:86e3 with SMTP id
 4fb4d7f45d1cf-639e56a89d2mr2886563a12.0.1760013374886; Thu, 09 Oct 2025
 05:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <539FC243.2070906@redhat.com> <20140617060500.GA20764@minantech.com>
 <FFEF5F78-D9E6-4333-BC1A-78076C132CBF@jnielsen.net> <6850B127-F16B-465F-BDDB-BA3F99B9E446@jnielsen.net>
 <jpgioafjtxb.fsf@redhat.com> <74412BDB-EF6F-4C20-84C8-C6EF3A25885C@jnielsen.net>
 <558AD1B0.5060200@redhat.com> <FAFB2BA9-E924-4E70-A84A-E5F2D97BC2F0@jnielsen.net>
 <CACzj_yVTyescyWBRuA3MMCC0Ymg7TKF-+sCW1N+Xwfffvw_Wsg@mail.gmail.com>
 <CAMGffE=P5HJkJxh2mj3c_oh6busFKYb0TGuhAc36toc5_uD72w@mail.gmail.com>
 <aOaJbHPBXHwxlC1S@google.com> <CAMGffEn1i-qTVRD+9PWDfNUMvbBCp9dV2f=Cgu=VLtoHs-6JTA@mail.gmail.com>
 <CAMGffEmt2ZEL3uxRd+mWkKB=K8Q3seo9Kp-T06rZahxsX4Wm4Q@mail.gmail.com>
In-Reply-To: <CAMGffEmt2ZEL3uxRd+mWkKB=K8Q3seo9Kp-T06rZahxsX4Wm4Q@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 9 Oct 2025 14:36:03 +0200
X-Gm-Features: AS18NWAmupOn1O4hEzb4k_VO4TcMTsQQpt_O9Kr2x-6kehxqYdY-BDwFQ4XLvpw
Message-ID: <CAMGffEmin4HAwoQUjkkoq+_z0sherZcCnkXgMu4PahnM8UmO+A@mail.gmail.com>
Subject: Re: Hang on reboot in multi-core FreeBSD guest on Linux KVM host with
 Intel Sierra Forest CPU
To: Sean Christopherson <seanjc@google.com>
Cc: fanwenyi0529@gmail.com, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org, 
	vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:21=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> wr=
ote:
>
> On Thu, Oct 9, 2025 at 5:44=E2=80=AFAM Jinpu Wang <jinpu.wang@ionos.com> =
wrote:
> >
> > Hi Sean,
> >
> > On Wed, Oct 8, 2025 at 5:55=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > Trimmed Cc: to drop people from the original thread.  In the future, =
just start
> > > a new bug report.  Piggybacking a 10 year old bug just because the sy=
mptoms are
> > > similar does more harm than good.  Whatever the old thread was chasin=
g was already
> > > fixed, _10 years_ ago; they were just trying to identy exactly what c=
ommit fixed
> > > the problem.  I.e. whatever they were chasing _can't_ be the same roo=
t cause,
> > > because even if it's literally the same code bug, it would require a =
code change
> > > and thus a regression between v4.0 and v6.1.
> > Thx for the reply,  it makes sense. I will remember this next time.
> > >
> > > On Wed, Oct 08, 2025, Jinpu Wang wrote:
> > > > On Wed, Oct 8, 2025 at 2:44=E2=80=AFPM Jack Wang <jinpu.wang@ionos.=
com> wrote:
> > > > > Sorry for bump this old thread, we hit same issue on Intel Sierra=
 Forest
> > > > > machines with LTS kernel 6.1/6.12, maybe KVM comunity could help =
fix it.
> > >
> > > Are there any host kernels that _do_ work?  E.g. have you tried a ble=
eding edge
> > > host kernel?
> > I will try linus/master today.
> > >
> > > > > ### **[BUG] Hang on FreeBSD Guest Reboot under KVM on Intel Sierr=
aForest (Xeon 6710E)**
> > > > >
> > > > > **Summary:**
> > > > > Multi-cores FreeBSD guests hang during reboot under KVM on system=
s with
> > > > > Intel(R) Xeon(R) 6710E (SierraForest). The issue is fully reprodu=
cible with
> > > > > APICv enabled and disappears when disabling APICv (`enable_apicv=
=3DN`). The
> > > > > same configuration works correctly on Ice Lake (Xeon Gold 6338).
> > >
> > > Does Sierra Forest have IPI virtualization?  If so, you could try run=
ning with
> > > APICv enabled, but enable_ipiv=3Dfalse to specifically disable IPI vi=
rtualization.
> > Yes, it does:
> > $  grep . /sys/module/kvm_intel/parameters/*
> > /sys/module/kvm_intel/parameters/allow_smaller_maxphyaddr:N
> > /sys/module/kvm_intel/parameters/dump_invalid_vmcs:N
> > /sys/module/kvm_intel/parameters/emulate_invalid_guest_state:Y
> > /sys/module/kvm_intel/parameters/enable_apicv:Y
> > /sys/module/kvm_intel/parameters/enable_ipiv:Y
> > /sys/module/kvm_intel/parameters/enable_shadow_vmcs:Y
> > /sys/module/kvm_intel/parameters/ept:Y
> > /sys/module/kvm_intel/parameters/eptad:Y
> > /sys/module/kvm_intel/parameters/error_on_inconsistent_vmcs_config:Y
> > /sys/module/kvm_intel/parameters/fasteoi:Y
> > /sys/module/kvm_intel/parameters/flexpriority:Y
> > /sys/module/kvm_intel/parameters/nested:Y
> > /sys/module/kvm_intel/parameters/nested_early_check:N
> > /sys/module/kvm_intel/parameters/ple_gap:128
> > /sys/module/kvm_intel/parameters/ple_window:4096
> > /sys/module/kvm_intel/parameters/ple_window_grow:2
> > /sys/module/kvm_intel/parameters/ple_window_max:4294967295
> > /sys/module/kvm_intel/parameters/ple_window_shrink:0
> > /sys/module/kvm_intel/parameters/pml:Y
> > /sys/module/kvm_intel/parameters/preemption_timer:Y
> > /sys/module/kvm_intel/parameters/sgx:N
> > /sys/module/kvm_intel/parameters/unrestricted_guest:Y
> > /sys/module/kvm_intel/parameters/vmentry_l1d_flush:not required
> > /sys/module/kvm_intel/parameters/vnmi:Y
> > /sys/module/kvm_intel/parameters/vpid:Y
> >
> > I tried to disable ipiv, but it doesn't help. freebsd hang on reboot.
> > sudo modprobe -r kvm_intel
> > sudo modprobe  kvm_intel enable_ipiv=3DN
> > /sys/module/kvm_intel/parameters/enable_ipiv:N
> >
> > Thx!
> +cc Vitaly
> Sorry, I missed one detail, we are use hyper-V enlightment features:
> "+hv-relaxed,+hv-vapic,+hv-time,+hv-runtime,hv-spinlocks=3D0x1fff,+hv-vpi=
ndex,+hv-synic,+hv-stimer,+hv-tlbflush,hv-ipi."
>
> did a lot tests with different features, and looks the hang is related
> to  +hv-synic,+hv-stimer.  hv-synic seems the key which causes boot
> hang of Freebsd 14.
>
> But the problem seems fixed with FreeBSD 15?  I guess it's this fix:
https://reviews.freebsd.org/D43508

>
> Seems it's a bug from freebsd side, rather than on kvm side to me, but
> I'm puzzled by disable apicv helps?
>
> Thx!

