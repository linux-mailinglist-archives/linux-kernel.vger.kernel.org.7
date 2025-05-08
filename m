Return-Path: <linux-kernel+bounces-639758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44CAAFBF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263299C308B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58743227E99;
	Thu,  8 May 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi4/rBQt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308511C1ADB
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712069; cv=none; b=uepT7lb2VA7zgEa22AeyfdG+/ZgCdQc96Hgl8ZToGQGt+K0uks2H/0oJbMmzqwIH9sKWLzNZBn6aecfalwNkruc49fdC5MZqBg4ZY7vS43jalwoThRLxAzfI4Q2uwjX4SjZHfBTV+mDyqu3UQxykNmfg+jRO/vNAlPP0LUsaC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712069; c=relaxed/simple;
	bh=rzsPdT++zOraCmcSidgiXEPUZobjQZKmnP6vWb74DBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iSHayApEDucze+Ju3C7+VYNCalPmVDq7dx5xi1gwxRl/WVgOwm4Ha6drouu0cnxceYKZh+0zVhlEHKHyH3lD8ozMYsH2fcm/FwX3XvqjqZ85l3IggLERI6gcO0SVWpbOFFn/JUJUKsbtO5xYLVBmaNTOVQJVWmCKAPLYE2/GVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gi4/rBQt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742360cec7eso98245b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746712067; x=1747316867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qVc6/TX2bExqc/mP07lavjif1Fs21N6CV6T1fKAfzw=;
        b=gi4/rBQtzICwT8bVleNVvfvV3bhuVOAKG1hc0fgCn8Lmi8g9esBHWnpBGMCXDCMXOm
         h9FID+jGQx4zVu0nvGgSY3D2B/lN2wRN6+Gf508l3ZJZyO0qaCD3aQdvjpo9D55Urv0q
         Ljv1HwNg2hPsXVMYJEhWsCpvKI6Fie6aB3sFs9MR0Hheih/yTfJAlLKJkyINEYiFncGR
         0NIvoVNFV5dJYskUAoH8AUs1tdv4rXxK6vrnUHRudIu70pGd+vgxTZHJJVRLvreRrp+W
         2y3SYwWWL5cOUBwJYYen6VzgOIFg5sPoZ456PKz2oZPi+i71MTbHqt1AduNK1Xz3ZgAD
         Nw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746712067; x=1747316867;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/qVc6/TX2bExqc/mP07lavjif1Fs21N6CV6T1fKAfzw=;
        b=YTYaMBj1W7z0/Cry8E3ejOMFZJ6q7m1M1yjubxtcwsISq4XLRoFbxqEfaCJB4lOyhf
         ffe25J5+F1RewTaUvqKkZGJ1FsMtAxAj4dI1O2ln0OOBE7Xhro7SQGZEIHJm2H0npKYk
         NNMyJmwXhpEdnuymiznFYLRBPszOtL1wJre1Su+NT6cYrM6BNRJlG5W3bUtZscXId9tg
         AlLolFS66aPqbhQuO2qvhL1rSUuZTcU1TDY0Vh8d/Wu+1eUjhzKc3NZuKcZGep1aIMwj
         VoZ1ya/88jDl7Lzdqkko9QXbm3ILUcGPPHFixtT124ZYuM9OKM87fzBa/I6D2wk2ivj2
         Vmxw==
X-Forwarded-Encrypted: i=1; AJvYcCVsNcbRy8DJb/ZOWoPaQtEZ4ofad7kObIJougEZ/GMOTx6HE1Z3JRSSdncMMcoInJHHKm8RjO+DD4kssIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMCFjMhoRE/yqq6DSepWTjmK5fIEZWrbFq45bkQ5kijBWYqWI
	LtNNnYS2yub4Ksm1VAjs/a84q7jP0zNF2Yt9TTiH3reXGq+Jv/aAYoqe90nwIyRAa314ifqERQC
	45Q==
X-Google-Smtp-Source: AGHT+IHEFGM+mr5sAwMAAOVCtuuSqYx117lvI3PWz4iuDvjUST6lb99Vkq928HvLliTrrTGNh8DqA5LPHP8=
X-Received: from pfbct10.prod.google.com ([2002:a05:6a00:f8a:b0:742:22b3:d8b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3394:b0:73d:ff02:8d83
 with SMTP id d2e1a72fcca58-7409ced9480mr12781153b3a.3.1746712067294; Thu, 08
 May 2025 06:47:47 -0700 (PDT)
Date: Thu, 8 May 2025 06:47:44 -0700
In-Reply-To: <d78cd913-69eb-415f-ac30-1677642a5f1a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250426001355.1026530-1-seanjc@google.com> <701a94eb-feac-4578-850c-5b1f015877af@linux.intel.com>
 <aBTe6dpaQs6bmFwh@google.com> <d78cd913-69eb-415f-ac30-1677642a5f1a@linux.intel.com>
Message-ID: <aBy2AGIFi34q031x@google.com>
Subject: Re: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
 with vCPU's value.
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025, Dapeng Mi wrote:
>=20
> On 5/2/2025 11:04 PM, Sean Christopherson wrote:
> > On Sun, Apr 27, 2025, Dapeng Mi wrote:
> >> On 4/26/2025 8:13 AM, Sean Christopherson wrote:
> >> Currently we have this Sean's fix, only the guest PEBS event bits of
> >> IA32_PEBS_ENABLE MSR are enabled in non-root mode, suppose we can simp=
ly
> >> change global_ctrl guest value calculation to this.
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index 09d2d66c9f21..5bc56bb616ec 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -4342,9 +4342,12 @@ static struct perf_guest_switch_msr
> >> *intel_guest_get_msrs(int *nr, void *data)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arr[global_ctrl] =3D (struc=
t perf_guest_switch_msr){
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .msr =3D MSR_CORE_PERF_GLOBAL_CTRL,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .host =3D intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .guest =3D intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs=
_mask,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .guest =3D intel_ctrl & ~cpuc->intel_ctrl_host_mask,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > Hmm, that's not as clear cut.  PEBS needs to be disabled because leavin=
g it enabled
> > will crash the guest.  For the counter itself, unless leaving it enable=
d breaks
> > perf and/or degrades the sampling, I don't think there's an obvious rig=
ht/wrong
> > approach.
> >
> > E.g. if the host wants to profile host and guest, then keeping the coun=
t running
> > while the guest is active might be a good thing.  It's still far, far f=
rom
> > perfect, as a counter that overflows when the guest is active won't gen=
erate a
> > PEBS record, but without digging further, it's not obvious that even th=
at flaw
> > is overall worse than always disabling the counter.
>=20
> Hmm, if the host PEBS event only samples host side, whether the HW counte=
r
> or the PEBS engine would be disabled once VM enters non-root mode, the KV=
M
> PEBS implementation is correct. But for the host PEBS events which sampli=
ng
> both host and guest, the implementation seems incorrect.

Well, yeah, because there is no correct implementation.

> As the below code shows, as long as there are host PEBS events regardless
> of the host PEBS events only sample guest or both host and guest, the hos=
t
> PEBS events would be disabled on both HW counters and PEBS engine once VM
> enters non-root mode.
>=20
> =C2=A0=C2=A0=C2=A0 arr[global_ctrl] =3D (struct perf_guest_switch_msr){
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .msr =3D MSR_CORE_PERF_GLOBAL_=
CTRL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .host =3D intel_ctrl & ~cpuc->=
intel_ctrl_guest_mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .guest =3D intel_ctrl & ~cpuc-=
>intel_ctrl_host_mask & ~pebs_mask,
> =C2=A0=C2=A0=C2=A0 };
>=20
> =C2=A0=C2=A0=C2=A0 if (arr[pebs_enable].host) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Disable guest PEBS if host =
PEBS is enabled. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arr[pebs_enable].guest =3D 0;
>=20
> =C2=A0=C2=A0=C2=A0 }
>=20
> So the host PEBS events which hopes to sample both host and guest only
> samples host side in fact. This is unexpected.

It's only unexpected in the sense that it's probably not well documented.  =
Because
the DS buffer is virtually address, there simply isn't a sane way to enable=
 PEBS
(or any feature that utizies the DS buffer) while running a KVM guest that =
isn't
enlightened to explicitly allow profiling via host PEBS (and AFAIK, no such=
 guest
exists).

Even when KVM is using shadowing paging, i.e. fully controls the page table=
s used
while the guest is running, enabling PEBS isn't feasible as KVM has no way =
to
prevent the guest from using the virtual address.  E.g. KVM could shove in =
mappings
for the DS buffer, but that DoS the guest if the guest wants to use the sam=
e
virtual address range for its own purposes, and would be a massive data lea=
k to
the guest since the guest could read host data from the buffer.

