Return-Path: <linux-kernel+bounces-846694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C614BC8C35
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652923C2665
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795212E0419;
	Thu,  9 Oct 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="G+C2wxQs"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19C2DA762
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008926; cv=none; b=HLrm1/gxPcVVeXJGkIf9The1CzEE5iVRW8BMCLfWXZYFsRN/WVsst15qIU6SO/Vt7GAb0yVzrE0jZHvJTl4B8aBFcPNd/yA92AlByQV06KqjmY+dCJ+jXhYxfECcUqqL4Vse7mLcbuUvd6pT6M7cv5gt5qV7yXD/0/VB5sODBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008926; c=relaxed/simple;
	bh=ErU4lw654VyAZDi7wVcxdHxruO1loqWA67S3hT4noSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6ciN3LgaytqIo/neWnnjewkw5gUNnYVRbpsO1gATdy7BdQ7hNkoFnlwQkCSybIOSKooOo+LjKbbOWxfshVGqq3YLVkCsY7KUQyPkHb/Rg4nujXru5pb+6lc6K8Klo9lV2GVZUpVwzRpw/jeMYltQyteRep4XDzIkWWpfigg/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=G+C2wxQs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso190517a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1760008921; x=1760613721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfZE6iML9B9Ue3mbffKK3pISp/+/VS1P47NXc80zsa0=;
        b=G+C2wxQsDfDyQRIX+GI+gf9G0chVo4LeMLDMbB6NL98hVcIQy6CWxvZlUEnLkLWjKS
         JGZsTntp8yF5WT4vC/rlZBsV6iebyfKsXhgwC0g8u2JAO+eSIQhj5mfVhtFLRYwKUBzQ
         3WEn7xeBpjnP97VdKpW0fE0kK1box5YPuJGx6oELoi19fQgaNujVydUThWpr8/YY4uaa
         H4q4ps67cxD3Ym8BGQ6vHoq3yplLyLGyvqKMPjslP2pUkItgc5amg3Fcf86NZzYWjqfv
         I639yZ+sXeRv8dJ9st/uF93euJ7aS9O5loBGEr0UnZqPqV2xZvs1gG3ihuA8Zl671D5/
         AV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008921; x=1760613721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfZE6iML9B9Ue3mbffKK3pISp/+/VS1P47NXc80zsa0=;
        b=egw3GuwimT58igVOsYMvIntefmar7FqZur4H/sV/kL4UtEx9uOASHaahLifbUoUtB5
         5Hm41i+Sejvn+pso3zHWTm0ywyNY41Tq05IGqGs3IlIIZsnH8LiYLpEMN0EpabH/ddBt
         tL3pCHLnMmv43wMo8fuPyPiryGTA6Fs4mzoKa7HdoEXYVMw1YXM0eSk0uSic6WZVIiZI
         8rThTJVXdV8308/ekb/tW5PFR5WOPXEuXCQ2DwENe6a89Q0GNXDL/Id/fRDgTSJJjUO1
         zenCuLy+4V8iDvrchSgBxfCuH++kiS87gCT1AzNGIhnjYpEOjvzCiqQf/Px2EGxqXr35
         1q0g==
X-Forwarded-Encrypted: i=1; AJvYcCXa5gVx39mnqQumQ1H70u9rK7lb/xxcKYvrmYaOhaxBzOVQOzqJY0rsGr+a6XM1OiAObHI7iKiJvmmAc10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Ejdbokb7gXrz0+BZSkhGo9MepZz82BP+wERI6jpn8hHnr53+
	7FgdIcmsN5FnLsZvgESw7drYwBYDAy+Cy1EjxuTdUsIBtR8ado6rVMmiItC8tYuqOTj70jjS1TB
	TWBBBSCTt/8s6aaYJW5dEZmac/Ab3UuDNLjg5IaLu1w==
X-Gm-Gg: ASbGncuahJ4aON04BYpQQSUsODKeHQiarHaiOLwPk6YHVt5rDetXSbTkl40YVpcf+BY
	9PrqkcpQpgDF9ZyIC8RpfOobIBbeKljuhHXIP7KFHo29VDtYkw07rl/gy2A2kQ9SnT4ZYUF2C+y
	0buljOuVGbPwoBcdiDkTYEpMLbyCbyfKxI5rdpdw/ra+3XdCUVU2nA+fSh5TaZSpFixqlWFw0P6
	BwRy4NANWqumtMlHFuS5j2KNeq6svaOZ25aq/ktBYU/iu9QXmzIUa8GcCexjMJ+
X-Google-Smtp-Source: AGHT+IEWtg6iCIgXsSapKkzgukSJTm4yJYAvEW+SFKlLEkSV8dVJEuv+31I22UcncTcGrxnBi575UEtN45DwJxtGA14=
X-Received: by 2002:a05:6402:2399:b0:639:dbe7:37e6 with SMTP id
 4fb4d7f45d1cf-639dbe73bcbmr2270471a12.2.1760008921446; Thu, 09 Oct 2025
 04:22:01 -0700 (PDT)
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
In-Reply-To: <CAMGffEn1i-qTVRD+9PWDfNUMvbBCp9dV2f=Cgu=VLtoHs-6JTA@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 9 Oct 2025 13:21:50 +0200
X-Gm-Features: AS18NWARL_xe63diYACbpaNo_4POMqNwxhtIptV6jbjGnAzTswFEutdQTgn79zI
Message-ID: <CAMGffEmt2ZEL3uxRd+mWkKB=K8Q3seo9Kp-T06rZahxsX4Wm4Q@mail.gmail.com>
Subject: Re: Hang on reboot in multi-core FreeBSD guest on Linux KVM host with
 Intel Sierra Forest CPU
To: Sean Christopherson <seanjc@google.com>
Cc: fanwenyi0529@gmail.com, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org, 
	vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 5:44=E2=80=AFAM Jinpu Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Hi Sean,
>
> On Wed, Oct 8, 2025 at 5:55=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Trimmed Cc: to drop people from the original thread.  In the future, ju=
st start
> > a new bug report.  Piggybacking a 10 year old bug just because the symp=
toms are
> > similar does more harm than good.  Whatever the old thread was chasing =
was already
> > fixed, _10 years_ ago; they were just trying to identy exactly what com=
mit fixed
> > the problem.  I.e. whatever they were chasing _can't_ be the same root =
cause,
> > because even if it's literally the same code bug, it would require a co=
de change
> > and thus a regression between v4.0 and v6.1.
> Thx for the reply,  it makes sense. I will remember this next time.
> >
> > On Wed, Oct 08, 2025, Jinpu Wang wrote:
> > > On Wed, Oct 8, 2025 at 2:44=E2=80=AFPM Jack Wang <jinpu.wang@ionos.co=
m> wrote:
> > > > Sorry for bump this old thread, we hit same issue on Intel Sierra F=
orest
> > > > machines with LTS kernel 6.1/6.12, maybe KVM comunity could help fi=
x it.
> >
> > Are there any host kernels that _do_ work?  E.g. have you tried a bleed=
ing edge
> > host kernel?
> I will try linus/master today.
> >
> > > > ### **[BUG] Hang on FreeBSD Guest Reboot under KVM on Intel SierraF=
orest (Xeon 6710E)**
> > > >
> > > > **Summary:**
> > > > Multi-cores FreeBSD guests hang during reboot under KVM on systems =
with
> > > > Intel(R) Xeon(R) 6710E (SierraForest). The issue is fully reproduci=
ble with
> > > > APICv enabled and disappears when disabling APICv (`enable_apicv=3D=
N`). The
> > > > same configuration works correctly on Ice Lake (Xeon Gold 6338).
> >
> > Does Sierra Forest have IPI virtualization?  If so, you could try runni=
ng with
> > APICv enabled, but enable_ipiv=3Dfalse to specifically disable IPI virt=
ualization.
> Yes, it does:
> $  grep . /sys/module/kvm_intel/parameters/*
> /sys/module/kvm_intel/parameters/allow_smaller_maxphyaddr:N
> /sys/module/kvm_intel/parameters/dump_invalid_vmcs:N
> /sys/module/kvm_intel/parameters/emulate_invalid_guest_state:Y
> /sys/module/kvm_intel/parameters/enable_apicv:Y
> /sys/module/kvm_intel/parameters/enable_ipiv:Y
> /sys/module/kvm_intel/parameters/enable_shadow_vmcs:Y
> /sys/module/kvm_intel/parameters/ept:Y
> /sys/module/kvm_intel/parameters/eptad:Y
> /sys/module/kvm_intel/parameters/error_on_inconsistent_vmcs_config:Y
> /sys/module/kvm_intel/parameters/fasteoi:Y
> /sys/module/kvm_intel/parameters/flexpriority:Y
> /sys/module/kvm_intel/parameters/nested:Y
> /sys/module/kvm_intel/parameters/nested_early_check:N
> /sys/module/kvm_intel/parameters/ple_gap:128
> /sys/module/kvm_intel/parameters/ple_window:4096
> /sys/module/kvm_intel/parameters/ple_window_grow:2
> /sys/module/kvm_intel/parameters/ple_window_max:4294967295
> /sys/module/kvm_intel/parameters/ple_window_shrink:0
> /sys/module/kvm_intel/parameters/pml:Y
> /sys/module/kvm_intel/parameters/preemption_timer:Y
> /sys/module/kvm_intel/parameters/sgx:N
> /sys/module/kvm_intel/parameters/unrestricted_guest:Y
> /sys/module/kvm_intel/parameters/vmentry_l1d_flush:not required
> /sys/module/kvm_intel/parameters/vnmi:Y
> /sys/module/kvm_intel/parameters/vpid:Y
>
> I tried to disable ipiv, but it doesn't help. freebsd hang on reboot.
> sudo modprobe -r kvm_intel
> sudo modprobe  kvm_intel enable_ipiv=3DN
> /sys/module/kvm_intel/parameters/enable_ipiv:N
>
> Thx!
+cc Vitaly
Sorry, I missed one detail, we are use hyper-V enlightment features:
"+hv-relaxed,+hv-vapic,+hv-time,+hv-runtime,hv-spinlocks=3D0x1fff,+hv-vpind=
ex,+hv-synic,+hv-stimer,+hv-tlbflush,hv-ipi."

did a lot tests with different features, and looks the hang is related
to  +hv-synic,+hv-stimer.  hv-synic seems the key which causes boot
hang of Freebsd 14.

But the problem seems fixed with FreeBSD 15?  I guess it's this fix:
https://github.com/systemd/systemd/issues/28001

Seems it's a bug from freebsd side, rather than on kvm side to me, but
I'm puzzled by disable apicv helps?

Thx!

