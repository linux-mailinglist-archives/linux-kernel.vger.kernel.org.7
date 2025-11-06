Return-Path: <linux-kernel+bounces-889167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278DC3CDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCC62352362
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF434C98F;
	Thu,  6 Nov 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="NlYFc3wb"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C12E542A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450305; cv=none; b=aBow1laydKMrCjAu13d0X6m7dKlQ0G0xY/hZuu9+JWU1uR5f8j94V4AUeQ0V12d75VGu/2x8Iqp1CS11XKEjsvl2Vz1PxjkK2UxdiIoqUzHoroyNqEZAQyU2HzBgaIxQgHLESBK6gLz6dx/2LvtaDMgnbPLGAy8FD8PKoBpfzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450305; c=relaxed/simple;
	bh=zvM6cdXMIl2o5YrUYpRcbskZAazZPGSPd0IzRPXWkXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phOtaeD732yknO8gqgbXz2uf2mP7lidJbJMf7iNDdWtud+YMVzP11JYnV6ayR2OjNC2QxnDepXTjl01U3Kv23qsOVO1ftEzfjlMH302islRAVTV+hppKTPQq3zErZ+9A1miuzTO1r5aS6RcqQU11BULElsqojWjYU9HLv+lc8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=NlYFc3wb; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4334f0f9c6cso12635735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1762450302; x=1763055102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nh8x1k2Zf7IvtO+dGH7W6iW6tYC0mC1F9bM8nm3prqk=;
        b=NlYFc3wbbxXyc4dQnyp+qIZ8eAOKxSo53CmJ0eMxpJtPBLU7sz5mSFvb2YQuwTU7+5
         3lwLq1nlgrh/Tj18Ic8fC51ao91R9NFItSt9+yuHqkFcf5klimfMRLi0SPHwxgQpie3X
         jKWFXbd6C3H7HNZLkAJkFqGrD1nK5Jk1XVJg1sRGaS1t/CJXrRhFoJUTp7bl2z5Ts/cO
         b1vnjQsF06JS7rqnvbh702IqDWE8vukL1aTICOREa5JGN5cHRP1vqdc5Jotu7G8/Raix
         agg54M6PuPxRunbmcOsRVy9ocsp/eMkLiA8RsCS3H3NlB7huWYJOQL46zyn+kl5S7PVv
         rfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450303; x=1763055103;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh8x1k2Zf7IvtO+dGH7W6iW6tYC0mC1F9bM8nm3prqk=;
        b=p5VnrVpC4sJxgn+lZKNVsuSviOBnoNbvCdC3Ltd895ygYovBCKTVAI1EbSnA4pUNdK
         q/sVV920vgfvJmgfKN19QkL0mL5NbBUHtrtd480AaJF565kYSzjIoLhiAOSMave1w08Q
         9mqLKdIpSNV8HibqhCwvZtkkTD2zarjOGNqjOP9e6bJVt7AJy6R0H+NQOotnbAxGQI8+
         fbaoLZq8ehexPogMaj/mKHuYtVOH1ge6unNj29WFHMzOwsfi8wvjNCJ03fbGKhHbnoa7
         MgCNaeH885RFX8ql/RswrO9qjNfmBVa7XqvRAKSFdmKBDHPErAFkI7byMLTo2xG/R+Ph
         FS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJg5Ez8SXm8rmomuiPLt6tEo4wPEmITeEtPIgd7D4gCU75zEzUOyWVrTX0Cglkflzs51Y2KzRi6AdCi7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRlqpxp94BgKf6DkJHOvhH2HoefIEYXMVdVuokQDvseq3F/vc
	B/+XPGs+tlWB/J35GHrxCOhDdek3/RGfglyOw9o+9H3LdLEVgqFMijkpRJ/7ALeV4C0=
X-Gm-Gg: ASbGncty39axtpwBFOgyK1anFtuvahSkg8f8x4cbpAQNuizlI96L80dO0S+a2bVRGS9
	PC6XBhAnaos0QArYErTC+mqdFHu8n47qGcWhk/Kf9NmwpA/Gc+vsDMT6gP4mUFafURl8Dfv7xer
	i66WZLwoOOgYolp62T2lwfSbO1QVxfuGtd4yODtg7mSUn47N0EDtb+XfKSjR1sjnSafCS2S+P3y
	zqcADyX6q5uZWMrgA+aXkCQes/VEGN0qJBUNEDLi6slEYGgQ5V4aa/K8XGjg762ugQs0y/sVspB
	t3/nSK3FO5bBd3vxH/dSXVWMLdzZ9m0zsRc1PoBnxkXV3pcXXCRTzb1xsISAGdwBeFQmvCkeXaG
	29RDjJbAY3yv0ixRn33z8B+64QUX3kZMJFrh4p6R0QyVVro/q0/QRPhCTFRWYbMh/UWXB0j+xnw
	==
X-Google-Smtp-Source: AGHT+IFOf38k1P2MZKKvXM296nue+jFu8GBwBsGrU4QKGabNFqUeQWQ05rRExCsPshCvY3hti7+jIg==
X-Received: by 2002:a05:6e02:188f:b0:433:298a:eb17 with SMTP id e9e14a558f8ab-4335f3a165emr3297095ab.4.1762450302486;
        Thu, 06 Nov 2025 09:31:42 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:cf2c:12ad:f89e:38ef:3ffa:2ec1])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f42cad7sm12823155ab.4.2025.11.06.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:31:42 -0800 (PST)
Date: Thu, 6 Nov 2025 11:31:37 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mmikowski@kfocus.org
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20251106113137.5b83bb3f@kf-m2g5>
In-Reply-To: <db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	<20250910113650.54eafc2b@kf-m2g5>
	<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
	<20250910153329.10dcef9d@kf-m2g5>
	<db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
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

On Thu, 06 Nov 2025 07:23:14 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Hi Aaron,
>=20
> On Wed, 2025-09-10 at 15:33 -0500, Aaron Rainbolt wrote:
> > On Wed, 10 Sep 2025 10:15:00 -0700
> > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >  =20
> > > On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote: =20
> > > > On Wed, 30 Apr 2025 16:29:09 +0200
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > =C2=A0  =20
> > > > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com> wrote:=C2=A0  =20
> > > > > >=20
> > > > > > When turbo mode is unavailable on a Skylake-X system,
> > > > > > executing
> > > > > > the
> > > > > > command:
> > > > > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > > > results in an unchecked MSR access error: WRMSR to 0x199
> > > > > > (attempted to write 0x0000000100001300). =20
> Please try the attached patch, if this address this issue.

I can confirm that this patch does resolve the issue when applied to
Kubuntu Focus's 6.14 kernel. CPU frequencies are available that require
turbo boost, and `cat /sys/devices/system/cpu/intel_pstate` returns
`0`. The logs from `dmesg` also indicate that turbo was disabled
earlier in boot, but the warnings about turbo being disabled stop
appearing later on, even when manipulating the `no_turbo` file:

[   25.893012] intel_pstate: Turbo is disabled
[   25.893019] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   25.950587] NET: Registered PF_QIPCRTR protocol family
[   26.599013] Realtek Internal NBASE-T PHY r8169-0-6c00:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-6c00:00, irq=3DMAC)
[   26.725959] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.ETMD],=
 AE_NOT_FOUND (20240827/psargs-332)

[   26.725976] No Local Variables are initialized for Method [_OSC]

[   26.725978] Initialized Arguments for Method [_OSC]:  (4 arguments defin=
ed for method invocation)
[   26.725979]   Arg0:   0000000030ddf166 <Obj>           Buffer(16) 5D A8 =
3B B2 B7 C8 42 35
[   26.725991]   Arg1:   0000000002bd3ac4 <Obj>           Integer 000000000=
0000001
[   26.725996]   Arg2:   0000000033eb047e <Obj>           Integer 000000000=
0000002
[   26.725999]   Arg3:   00000000de6cf5f1 <Obj>           Buffer(8) 00 00 0=
0 00 05 00 00 00

[   26.726010] ACPI Error: Aborting method \_SB.IETM._OSC due to previous e=
rror (AE_NOT_FOUND) (20240827/psparse-529)
[   26.726056] Consider using thermal netlink events interface
[   26.769209] r8169 0000:6c:00.0 enp108s0: Link is Down
[   26.857318] zram0: detected capacity change from 0 to 195035136
[   26.864390] vboxdrv: Found 32 processor cores/threads
[   26.873227] Adding 97517564k swap on /dev/zram0.  Priority:-2 extents:1 =
across:97517564k SS
[   26.880588] vboxdrv: TSC mode is Invariant, tentative frequency 24191946=
40 Hz
[   26.880592] vboxdrv: Successfully loaded version 7.2.4 r170995 (interfac=
e 0x00340001)
[   26.895725] intel_pstate: Turbo is disabled
[   26.895730] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   26.943715] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   26.943746] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   26.943755] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[   26.943765] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   26.944901] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[   27.045437] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[   27.098590] VBoxNetFlt: Successfully started.
[   27.101687] VBoxNetAdp: Successfully started.
[   27.153602] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[   27.851014] loop14: detected capacity change from 0 to 8
[   27.895706] r8169 0000:6c:00.0: invalid VPD tag 0xff (size 0) at offset =
0; assume missing optional EEPROM
[   28.898015] intel_pstate: Turbo is disabled
[   28.898021] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   31.900781] intel_pstate: Turbo is disabled
[   31.900788] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   33.959448] Bluetooth: RFCOMM TTY layer initialized
[   33.959456] Bluetooth: RFCOMM socket layer initialized
[   33.959462] Bluetooth: RFCOMM ver 1.11
[   36.903768] intel_pstate: Turbo is disabled
[   36.903777] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   38.054345] systemd-journald[883]: /var/log/journal/a9e8e3d2041547169b10=
7e1e1a23f2ce/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   39.799560] warning: `kded5' uses wireless extensions which will stop wo=
rking for Wi-Fi 7 hardware; use nl80211
[   40.884365] wlp0s20f3: authenticate with 18:ee:86:8b:16:a2 (local addres=
s=3D98:bd:80:8a:e9:27)
[   40.885147] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (try 1/3)
[   40.968595] wlp0s20f3: authenticate with 18:ee:86:8b:16:a2 (local addres=
s=3D98:bd:80:8a:e9:27)
[   40.968603] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (try 1/3)
[   40.980941] wlp0s20f3: authenticated
[   40.981904] wlp0s20f3: associate with 18:ee:86:8b:16:a2 (try 1/3)
[   41.042933] wlp0s20f3: RX AssocResp from 18:ee:86:8b:16:a2 (capab=3D0x14=
31 status=3D0 aid=3D14)
[   41.046917] wlp0s20f3: associated

If you post the patch, I'm happy to add a `Tested-by` tag for it.
Thank you for your help!

> Thanks,
> Srinivas


