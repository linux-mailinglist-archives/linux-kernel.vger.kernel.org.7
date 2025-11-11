Return-Path: <linux-kernel+bounces-894378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4AC49E28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FF4EADD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82014244186;
	Tue, 11 Nov 2025 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="mzVG6MCQ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8323D7D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821494; cv=none; b=jwMX2KWG59ujOTaNLyZGLC2hAAk/J5LTJYL1Ww20VqlXtLjGE8ioaS9MFJUJtGlTycdpY0jW324xLc5aZzxQa1D/PSb5eYNZ6DWogV+VxB9/FWNxJVet2JU8/20y8T7BTlTVts45WFK6eYJczPxRw4v1O+WY3P8MYY7p6PsXj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821494; c=relaxed/simple;
	bh=Tbnwr8IK5LBoPIAfMZ5tbJaZXcRuEAy5r7dLTMDViO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZzF73CQCOKn5hY4eGE7IQYpZMkSDlwP+qwku6c5d6gU97AodidNiL62XlNcMVRO/IQ60/LLzGIuc9Mc8JY2dMmpVkNJ1tSvqeloVzqNWi6jr67hrBToNseyPHAUot5BIXi8lVIPMg/wj2zlcSeIqK8+7KTr+0BMmOtjnPloDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=mzVG6MCQ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88703c873d5so116791839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1762821491; x=1763426291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIHWY8Hd5dvxYbOti1GySgc71IEsRnMp93te/J/W5Fk=;
        b=mzVG6MCQ+wcl6aJypgl9bJpQbOSRhS8+mtc6AF1UZgxz+oX8FDx0frbLEr0CbNBnjU
         0GrBV+PXepWmsPuLMBv8H37OfzX4SsVODCErF3XY7XjEVK33BYWH8WqDUG6UzK40hDme
         DLZEFUM0y3mM5Q+2AHH+TYkQhcD8QqBOjHiu0EldHwzHolV18P1fU8BRXY7IApDmWYAb
         hF7M7YrFdSYdx4gpl77YxugblpP7q3blJwdVHT/S8Buv0OW8FvOUzW/GDibunDH5nc5K
         Qor4FSxpzDEGJjiVxEyxCxfk3P1pEFWsbIQLY7eU12hy4+JaWa9/muHffRoNH5k3ua8h
         j8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762821491; x=1763426291;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIHWY8Hd5dvxYbOti1GySgc71IEsRnMp93te/J/W5Fk=;
        b=X/uj04ZZ/z03Itsahw5mdEN+RjI4TRiVIaqZQKqM3gxkz1JKg2zmVqLP7Jxwpny+SN
         IdMpm6XKpfhfY0ZyJ3KNpQpcPsIct8xV7hhZ9wxDIFU98pHFOWi64iqJWlFyKhSp9ttX
         LtpVFQ5OCxa2z6wuanVbXguuFzr11c29j38LFQrFnvL0vymCt9FX17M+keRS+CLX33rp
         5e8bsnvS8azO2SKf3pzvyZ7BFJOwkDtrHxDnm6rcKDQKsYp4Qje3gNXu5DLAjo2hFb7U
         FMunuoEhix7wFo4YUAUk8Z8x8W9E5Ub3IlV/8oRw6a8G3IVLIhGAAnh6U3VtDvxU3FpE
         3b7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFscLQcyKDa/8IpISXrl4zxL7zVoTRw2uqZQQaJ/W+/GG50rGBJ0dsqz7o0qYI9Sqe7To/od+5A2WVrNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLk7b2US0ujFp/x2h5Oc2Gv6nZBhjEsYnqsEh/louKBEFMBt3V
	DtSv5XNBcn7jsvxRd7fZKqB1CfXvwN2OdmLzd3Puk/ZE6FYvH9cJQzFqxjvcHJ4wRiI=
X-Gm-Gg: ASbGnctYJwrk24fYEqU4FCBS4zs+nZwwjxkcHYPrMigLfPT0BjQaQH3nQqUdSHFYWHp
	RR9yQTkYadzlzFicRumrqhkZ3QS3tlqdfLGX7+4Spa5rUl9Pz9SNT2pDi/6EPzTQeBj9nRrxv9T
	Jpv7Vl9zVWmMrIEt4aP/ZqkrIEztLXYjStnWQm5hFoVFWB0X6bb6tlKOJGSAnEz473mL6iqAmhJ
	SsLsKkRFBKecQNjtzJf94rm4CWb2z020oKu9/0UgKyju6RTPRuhSv1vL0uV6vzfTJKXUJ0zKD0c
	e4izKvk2jTg+c1Z2ka29K6z63JKKciSo+cfSzwh5Q1WcAKSi6Fm14kz8Y3uq4s62iywANf1rvFA
	uMguXNxYIWz0XcztbYziwnBLmA6t76WBx67WfpqXtXgvAntmzInPzF8WidCEfIRWN0SE+m9hv/f
	t3ATiKZHXvEiUBJbcazw==
X-Google-Smtp-Source: AGHT+IGthNqIagv55kF0Wd2Uz3Ldf9tLbit06qhXgVu08R2WGCWTBsVBOwTX6jhP6aibmkIjA6MDog==
X-Received: by 2002:a05:6602:13c1:b0:948:786f:4a54 with SMTP id ca18e2360f4ac-94895f66cc1mr1416806639f.2.1762821491382;
        Mon, 10 Nov 2025 16:38:11 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:cf2c:12ad:fbac:adde:dd4:8441])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888d8bbd0sm429555739f.18.2025.11.10.16.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 16:38:10 -0800 (PST)
Date: Mon, 10 Nov 2025 18:38:07 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mmikowski@kfocus.org, Thomas Renninger
 <trenn@suse.de>
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20251110183807.5288bf8e@kf-m2g5>
In-Reply-To: <aa8d90214822829fb392022f0c7f4148822a6aa7.camel@linux.intel.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	<20250910113650.54eafc2b@kf-m2g5>
	<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
	<20250910153329.10dcef9d@kf-m2g5>
	<db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
	<20251106113137.5b83bb3f@kf-m2g5>
	<8794c34dc127ee1bd3ed4d746ca7c1235ca3cb93.camel@linux.intel.com>
	<aa8d90214822829fb392022f0c7f4148822a6aa7.camel@linux.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 08:58:55 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> + Thomas
>=20
> Please verify so that I can post the patch.
>=20
> Thanks,
> Srinivas

Hi Srinivas,

I have tested the newest patch against KFocus's 6.14 kernel on the
affected hardware, and can confirm that this patch also allows Turbo
Boost to function correctly. High-frequency modes are available in
cpupower-gui, and the "Turbo disabled by BIOS or unavailable on
processor" messages stop occurring in dmesg shortly after boot.

Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>

--
Aaron

>=20
> On Thu, 2025-11-06 at 17:48 -0800, srinivas pandruvada wrote:
> > Hi Aaron,
> >=20
> > Please again verify this change. This limits the scope.
> > Patch attached.
> >=20
> > Thanks,
> > Srinivas
> >=20
> > On Thu, 2025-11-06 at 11:31 -0600, Aaron Rainbolt wrote: =20
> > > On Thu, 06 Nov 2025 07:23:14 -0800
> > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > >  =20
> > > > Hi Aaron,
> > > >=20
> > > > On Wed, 2025-09-10 at 15:33 -0500, Aaron Rainbolt wrote: =20
> > > > > On Wed, 10 Sep 2025 10:15:00 -0700
> > > > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > wrote:
> > > > > =C2=A0  =20
> > > > > > On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:=C2=A0 =
 =20
> > > > > > > On Wed, 30 Apr 2025 16:29:09 +0200
> > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > > =C2=A0=C2=A0=C2=A0  =20
> > > > > > > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > > > > > > <srinivas.pandruvada@linux.intel.com> wrote:=C2=A0=C2=A0=C2=
=A0  =20
> > > > > > > > >=20
> > > > > > > > > When turbo mode is unavailable on a Skylake-X system,
> > > > > > > > > executing
> > > > > > > > > the
> > > > > > > > > command:
> > > > > > > > > "echo 1 >
> > > > > > > > > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > > > > > > results in an unchecked MSR access error: WRMSR to
> > > > > > > > > 0x199
> > > > > > > > > (attempted to write 0x0000000100001300).=C2=A0  =20
> > > > Please try the attached patch, if this address this issue. =20
> > >=20
> > > I can confirm that this patch does resolve the issue when applied
> > > to
> > > Kubuntu Focus's 6.14 kernel. CPU frequencies are available that
> > > require
> > > turbo boost, and `cat /sys/devices/system/cpu/intel_pstate`
> > > returns `0`. The logs from `dmesg` also indicate that turbo was
> > > disabled earlier in boot, but the warnings about turbo being
> > > disabled stop appearing later on, even when manipulating the
> > > `no_turbo` file:
> > >=20
> > > [=C2=A0=C2=A0 25.893012] intel_pstate: Turbo is disabled
> > > [=C2=A0=C2=A0 25.893019] intel_pstate: Turbo disabled by BIOS or unav=
ailable
> > > on
> > > processor
> > > [=C2=A0=C2=A0 25.950587] NET: Registered PF_QIPCRTR protocol family
> > > [=C2=A0=C2=A0 26.599013] Realtek Internal NBASE-T PHY r8169-0-6c00:00:
> > > attached
> > > PHY driver (mii_bus:phy_addr=3Dr8169-0-6c00:00, irq=3DMAC)
> > > [=C2=A0=C2=A0 26.725959] ACPI BIOS Error (bug): Could not resolve sym=
bol
> > > [\_TZ.ETMD], AE_NOT_FOUND (20240827/psargs-332)
> > >=20
> > > [=C2=A0=C2=A0 26.725976] No Local Variables are initialized for Method
> > > [_OSC]
> > >=20
> > > [=C2=A0=C2=A0 26.725978] Initialized Arguments for Method [_OSC]:=C2=
=A0 (4
> > > arguments
> > > defined for method invocation)
> > > [=C2=A0=C2=A0 26.725979]=C2=A0=C2=A0 Arg0:=C2=A0=C2=A0 0000000030ddf1=
66 <Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > Buffer(16)
> > > 5D A8 3B B2 B7 C8 42 35
> > > [=C2=A0=C2=A0 26.725991]=C2=A0=C2=A0 Arg1:=C2=A0=C2=A0 0000000002bd3a=
c4 <Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Integer
> > > 0000000000000001
> > > [=C2=A0=C2=A0 26.725996]=C2=A0=C2=A0 Arg2:=C2=A0=C2=A0 0000000033eb04=
7e <Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Integer
> > > 0000000000000002
> > > [=C2=A0=C2=A0 26.725999]=C2=A0=C2=A0 Arg3:=C2=A0=C2=A0 00000000de6cf5=
f1 <Obj>
> > > Buffer(8) 00 00 00 00 05 00 00 00
> > >=20
> > > [=C2=A0=C2=A0 26.726010] ACPI Error: Aborting method \_SB.IETM._OSC d=
ue to
> > > previous error (AE_NOT_FOUND) (20240827/psparse-529)
> > > [=C2=A0=C2=A0 26.726056] Consider using thermal netlink events interf=
ace
> > > [=C2=A0=C2=A0 26.769209] r8169 0000:6c:00.0 enp108s0: Link is Down
> > > [=C2=A0=C2=A0 26.857318] zram0: detected capacity change from 0 to 19=
5035136
> > > [=C2=A0=C2=A0 26.864390] vboxdrv: Found 32 processor cores/threads
> > > [=C2=A0=C2=A0 26.873227] Adding 97517564k swap on /dev/zram0.=C2=A0 P=
riority:-2
> > > extents:1 across:97517564k SS
> > > [=C2=A0=C2=A0 26.880588] vboxdrv: TSC mode is Invariant, tentative fr=
equency
> > > 2419194640 Hz
> > > [=C2=A0=C2=A0 26.880592] vboxdrv: Successfully loaded version 7.2.4 r=
170995
> > > (interface 0x00340001)
> > > [=C2=A0=C2=A0 26.895725] intel_pstate: Turbo is disabled
> > > [=C2=A0=C2=A0 26.895730] intel_pstate: Turbo disabled by BIOS or unav=
ailable
> > > on
> > > processor
> > > [=C2=A0=C2=A0 26.943715] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICAT=
ION:
> > > 0x20
> > > [=C2=A0=C2=A0 26.943746] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICA=
TION:
> > > 0x1f
> > > [=C2=A0=C2=A0 26.943755] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
> > > [=C2=A0=C2=A0 26.943765] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9:=
 0x0
> > > [=C2=A0=C2=A0 26.944901] iwlwifi 0000:00:14.3: RFIm is deactivated, r=
eason =3D
> > > 5
> > > [=C2=A0=C2=A0 27.045437] iwlwifi 0000:00:14.3: Registered PHC clock:
> > > iwlwifi- PTP, with index: 0
> > > [=C2=A0=C2=A0 27.098590] VBoxNetFlt: Successfully started.
> > > [=C2=A0=C2=A0 27.101687] VBoxNetAdp: Successfully started.
> > > [=C2=A0=C2=A0 27.153602] bridge: filtering via arp/ip/ip6tables is no=
 longer
> > > available by default. Update your scripts to load br_netfilter if
> > > you
> > > need this.
> > > [=C2=A0=C2=A0 27.851014] loop14: detected capacity change from 0 to 8
> > > [=C2=A0=C2=A0 27.895706] r8169 0000:6c:00.0: invalid VPD tag 0xff (si=
ze 0)
> > > at offset 0; assume missing optional EEPROM
> > > [=C2=A0=C2=A0 28.898015] intel_pstate: Turbo is disabled
> > > [=C2=A0=C2=A0 28.898021] intel_pstate: Turbo disabled by BIOS or unav=
ailable
> > > on
> > > processor
> > > [=C2=A0=C2=A0 31.900781] intel_pstate: Turbo is disabled
> > > [=C2=A0=C2=A0 31.900788] intel_pstate: Turbo disabled by BIOS or unav=
ailable
> > > on
> > > processor
> > > [=C2=A0=C2=A0 33.959448] Bluetooth: RFCOMM TTY layer initialized
> > > [=C2=A0=C2=A0 33.959456] Bluetooth: RFCOMM socket layer initialized
> > > [=C2=A0=C2=A0 33.959462] Bluetooth: RFCOMM ver 1.11
> > > [=C2=A0=C2=A0 36.903768] intel_pstate: Turbo is disabled
> > > [=C2=A0=C2=A0 36.903777] intel_pstate: Turbo disabled by BIOS or unav=
ailable
> > > on
> > > processor
> > > [=C2=A0=C2=A0 38.054345] systemd-journald[883]:
> > > /var/log/journal/a9e8e3d2041547169b107e1e1a23f2ce/user-
> > > 1000.journal:
> > > Journal file uses a different sequence number ID, rotating.
> > > [=C2=A0=C2=A0 39.799560] warning: `kded5' uses wireless extensions wh=
ich
> > > will stop working for Wi-Fi 7 hardware; use nl80211
> > > [=C2=A0=C2=A0 40.884365] wlp0s20f3: authenticate with 18:ee:86:8b:16:=
a2
> > > (local
> > > address=3D98:bd:80:8a:e9:27)
> > > [=C2=A0=C2=A0 40.885147] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (t=
ry 1/3)
> > > [=C2=A0=C2=A0 40.968595] wlp0s20f3: authenticate with 18:ee:86:8b:16:=
a2
> > > (local
> > > address=3D98:bd:80:8a:e9:27)
> > > [=C2=A0=C2=A0 40.968603] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (t=
ry 1/3)
> > > [=C2=A0=C2=A0 40.980941] wlp0s20f3: authenticated
> > > [=C2=A0=C2=A0 40.981904] wlp0s20f3: associate with 18:ee:86:8b:16:a2 =
(try
> > > 1/3)
> > > [=C2=A0=C2=A0 41.042933] wlp0s20f3: RX AssocResp from 18:ee:86:8b:16:=
a2
> > > (capab=3D0x1431 status=3D0 aid=3D14)
> > > [=C2=A0=C2=A0 41.046917] wlp0s20f3: associated
> > >=20
> > > If you post the patch, I'm happy to add a `Tested-by` tag for it.
> > > Thank you for your help!
> > >  =20
> > > > Thanks,
> > > > Srinivas =20
> > >=20
> > >  =20


