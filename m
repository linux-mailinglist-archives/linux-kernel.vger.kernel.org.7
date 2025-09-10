Return-Path: <linux-kernel+bounces-810959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD08B5225A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3783583215
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE02F0C78;
	Wed, 10 Sep 2025 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="x0VoysvS"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E018FDBE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536420; cv=none; b=s6COedbjxS4gUi/JxLXhYGL6nlIfclfD0JZiHDJueV/ZN3vCWiPHms+2RlRS4LlNnLXv/WdS6m6vFksePcREdqHBW/WG/+jadO6oktT3j0WpEaECc4wCHa3y3tBN9Da8uyXsC5tun7a3NNHMxo0OqDa8QVugxrQY+gisYC6k9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536420; c=relaxed/simple;
	bh=YhHcGR6NcktdDika/H79AEJwmn9xeexlbfC0CIPF2GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSeDJcSeHKDeOd3+vNcRlqz8tKdmkLzkYit2CVaPKKekwLoUHBnvvCB1isqCzEi9PboYghaczByXVhj5cpCU4s8J8eAum1zM0hDQoe8iQb+0O1Wvzyu22y3yhr9dABphT99sNO7OhdD04/ONDEcNxbGyrOUo738+6NPM0uiJmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=x0VoysvS; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8876462a34aso213951639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1757536416; x=1758141216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZC/n9aPRKkY1e246SyhB/Q8BzMW4BNCrjlHrCKsg/4Q=;
        b=x0VoysvStrMaIlndpVjY3ix2GqeW/1mfjunZQzmzcpriHQWch0fhIOXQr6ds5OT8lS
         0LfcsQFACVbaqIRFTZLrbOHzzhqyK6XHbHXMVEVKyXqPW03w13T2Lu/SFneNhoZirELH
         vQk+0MHOsdT+xpo2ja8GhC1YwonVCXeMVesXFhHAo7WV9qf/EmAwRcpI+ISdQxZqWVLu
         5msDyFr+zoQB19lmMLNWt9pWgLm0WfpPTzH1COWHiBiCA4Vq+1GW1cyzSBwOWb1bp2jd
         m5vm+PQO5PpFqj25eReYrRbbNztrmnuSU9x6L09b4b5TrPTargwAj0oG58MVuz75NYE/
         hJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536416; x=1758141216;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC/n9aPRKkY1e246SyhB/Q8BzMW4BNCrjlHrCKsg/4Q=;
        b=Ly5mLDF/raXiZRnvP+QWXgAgYQwHXPnfgkN3ywkog/VOEwbGaYN0yZsb+NWUKz1EP8
         YKf77tvJ8cIU1lRpdI1eBw/YM0qEKIJnEOy5U/iSk7OeSEc2BUMbQdLbiRr07hWle1on
         Il3hngCUMklHGjm50D4IIwaKZNJ1r7f7UbliKyEbjGP0IBrqzLMXG5VIJWT6X4n+WZOx
         ON1zigIYxrtVUIFkR8hhxLiKgEtw/xNRkkyVkTGkeTcWpxzw9P8IfrF4OcxQ+FrW1nqL
         s+/XGgmrmL5/3Zt7OKUX4e9D4Kek2qpK6w4jRmyGAovibUETJg7P8R94m7d60BW7fF2T
         MAIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjSwj2T0Hq3HE4F6GlktYVLEMSwpKQD6oswYRfgDcW2fPwyaRWhgblidLoqyYDGicAawXAMN8z4nGGF3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG9rEWNvsGSXvVRwYTMISNGH1P5cbxx2D0ckXrAv7tuYMyuG4
	ThCa2FnaYQ2CthAn3yr85lHjsq6cKZyVo3v5RaAH9okdLlV2ocTyhzE/lyVLvuYU6aU=
X-Gm-Gg: ASbGncvTB5oYd1ijSmuCdDYTxPb6oykjjlNjqzDFf27Sl0B+fvmBKTLLtAxjbLgKpZA
	D3zanRgCBg67bCqnIvDKN37Fr/594Pujhpz2riNiq3ydz+VwbGasoVjxqhrtMeUOlbHKYCSWzfz
	iHPxK+ZkbjeiCvfYwZ/CKw6eP1MqggiB0ttO3vSY8bChk/TxHwAvCM28O7mif2w5XintqGA3SAo
	8zkxcda3dFblFCelc13McFQCiOAeft2+SM/ormBQXEYjJy1H0I82W8U975M+uaWdA3ba3kqQGI3
	iXcrOokYhV6Z4PhwyKSD//wCRxMbUkXBDV+pQnlCy6Qdur/BMS+L4xXsLWK3Dr0kxdPbZqUTy4Y
	pJXeaJcFrKNBcnl3FfOcFw8Aatv0IYQ==
X-Google-Smtp-Source: AGHT+IFUIt/o0aTDvAKsDPoZqNCzU+WEORCP4SO4/NIgvZhEvVZboD+hqTS72AUl6+6DUmBYDzCqDg==
X-Received: by 2002:a05:6602:36ce:b0:88d:9dce:2916 with SMTP id ca18e2360f4ac-88d9dce2a43mr691914239f.8.1757536416124;
        Wed, 10 Sep 2025 13:33:36 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cfaa:41d:2536:6680:5b26:e8b0])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511ee8f8e5csm129110173.10.2025.09.10.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:33:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 15:33:29 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki"  <rafael@kernel.org>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mmikowski@kfocus.org
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20250910153329.10dcef9d@kf-m2g5>
In-Reply-To: <dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	<20250910113650.54eafc2b@kf-m2g5>
	<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
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

On Wed, 10 Sep 2025 10:15:00 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:
> > On Wed, 30 Apr 2025 16:29:09 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >  =20
> > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote: =20
> > > >=20
> > > > When turbo mode is unavailable on a Skylake-X system, executing
> > > > the
> > > > command:
> > > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > results in an unchecked MSR access error: WRMSR to 0x199
> > > > (attempted to write 0x0000000100001300).
> > > >=20
> > > > This issue was reproduced on an OEM (Original Equipment
> > > > Manufacturer) system and is not a common problem across all
> > > > Skylake-X systems.
> > > >=20
> > > > This error occurs because the MSR 0x199 Turbo Engage Bit (bit
> > > > 32) is set when turbo mode is disabled. The issue arises when
> > > > intel_pstate fails to detect that turbo mode is disabled. Here
> > > > intel_pstate relies on MSR_IA32_MISC_ENABLE bit 38 to determine
> > > > the
> > > > status of turbo mode. However, on this system, bit 38 is not set
> > > > even when turbo mode is disabled.
> > > >=20
> > > > According to the Intel Software Developer's Manual (SDM), the
> > > > BIOS
> > > > sets this bit during platform initialization to enable or
> > > > disable opportunistic processor performance operations.
> > > > Logically, this bit
> > > > should be set in such cases. However, the SDM also specifies
> > > > that "OS and applications must use CPUID leaf 06H to detect
> > > > processors with opportunistic processor performance operations
> > > > enabled."
> > > >=20
> > > > Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38,
> > > > verify that CPUID.06H:EAX[1] is 0 to accurately determine if
> > > > turbo
> > > > mode is disabled.
> > > >=20
> > > > Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current
> > > > no_turbo state correctly") Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> Cc: stable@vger.kernel.org
> > > > ---
> > > > =C2=A0drivers/cpufreq/intel_pstate.c | 3 +++
> > > > =C2=A01 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c index
> > > > f41ed0b9e610..ba9bf06f1c77 100644 ---
> > > > a/drivers/cpufreq/intel_pstate.c +++
> > > > b/drivers/cpufreq/intel_pstate.c @@ -598,6 +598,9 @@ static
> > > > bool turbo_is_disabled(void) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 misc_en;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_feature_enabled(X86_=
FEATURE_IDA))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_IA32_MISC_ENA=
BLE, misc_en);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!(misc_en & MSR_=
IA32_MISC_ENABLE_TURBO_DISABLE);
> > > > --=C2=A0  =20
> > >=20
> > > Applied as a fix for 6.15-rc, thanks!
> > >  =20
> >=20
> > FYI, this seems to have broken turbo boost on some Clevo systems
> > with an Intel Core i9-14900HX CPU. These CPUs obviously support
> > turbo boost,
> > and kernels without this commit have turbo boost working properly,
> > but
> > after this commit turbo boost is stuck disabled and cannot be
> > enabled by writing to /sys/devices/system/cpu/intel_pstate/no_turbo.
> > I
> > made a bug report about this against Ubuntu's kernel at [1], which
> > is the only report I know that is able to point to this commit as
> > having broken things. However, it looks like an Arch Linux user [2]
> > and a Gentoo user [3] are running into the same thing.
> >  =20
>=20
> As the bug report suggested, the system boots with no turbo, it must
> be forcefully turned ON by writing to this attribute.
> I wonder if there is a BIOS option to turn ON turbo on this system?

I just double-checked the BIOS settings, there does not appear to be
any setting related to turbo boost there. The closest there is, is
overclocking settings, which comes with warnings about possibly causing
the system to become unbootable, thus I think those settings are for
true overclocking and not turbo boost.

> This processor itself is capable of up to 5.8 GHz turbo.
>=20
>=20
> I will try to find contact at Clevo.
>=20
> We can try to reduce scope of this change to non HWP only where there
> is unchecked MSR issue.

That sounds like a good idea to me.

> Thanks,
> Srinivas
>=20
> > [1]
> > https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2122531
> >=20
> > [2] https://bbs.archlinux.org/viewtopic.php?id=3D305564
> >=20
> > [3]
> > https://forums.gentoo.org/viewtopic-p-8866128.html?sid=3De97619cff0d9c7=
9c2eea2cfe8f60b0d3
> > =20
>=20


