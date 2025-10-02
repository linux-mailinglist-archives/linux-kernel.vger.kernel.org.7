Return-Path: <linux-kernel+bounces-840063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E816BB3718
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F52D3AEB46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071993009D3;
	Thu,  2 Oct 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2JFJzzkD"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1292DCBEE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396890; cv=none; b=kUT1C7f66Froqz506+TmYZQ5R58uDYJioXLmR8krwWKF+nNK/crbEH65vrr0uwdv84/t9+u8yM88Tif68OkhHcPKcbm4FAskEyniH3o+A6Kg29lH7+oMbFMGyHQ9pEtAScpLJykx6tYnzQwIuVTQL1ndhfw2Y0AB67gsvKfxV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396890; c=relaxed/simple;
	bh=aP4Q/oKpg2V/4c35W5p7xVBH/3jIg1fRsoW+lz73mKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qehxZx4Naji99W+OoGvfVQLWt6Apeo/I+sxHcmHqK5xfMA6eVSwQJXY/SEmHUWwEReIXqhBnRhWomE5wr39S2PK5jUyhTI+tO9TD+vPBn/Mcxi43wQ9kbws8IqpdBXWLWPtSiTt7DQ4pXr/vCuBZbAk1MBNgfxGQEoCUE75OQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2JFJzzkD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e5980471eso3963445e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759396885; x=1760001685; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Icgfc3/FElBuJ0BKL8MGnmNZj7OM0/rdBixhQ/A21CE=;
        b=2JFJzzkDVMUUCEwg/tekMdwXw5XbYRIX6BoaVa/2GprHtg6O0ax4Ub9bsvlORLx3P9
         fepnv1lbz/kEMuWNiCujlBgNwpF3IwRnKSyh0dyQ+LEeaRMnTSWWgK4x8N5tS6g6CHto
         /8bRektNfjwnMG46gG9NAjmghZ34kSFNYgBzG7k1CUehfPu+7eIDAojsZeaiO+cus9WR
         GmHb6bAg60a2ilCrZK0YQo2TaSHmswFs2jfWm5h2tYnwCVffgfMjSW+PQ+9+oJTZGatR
         S/ED4BJRF4JADl63UsnL9r0XcQBLzeNu/1/kTzmEBgIvonksk+bt4arnEjbU7/HZvsH6
         zRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396885; x=1760001685;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Icgfc3/FElBuJ0BKL8MGnmNZj7OM0/rdBixhQ/A21CE=;
        b=HkibNpeWsQu6yxP585Vy2jmNEVMkt617Gi/PnMi+7woYb4BNhzq6aP8IejAysXw1ay
         KcpNbFWUCWMbJGHC7tke4f2c+VYpFj9VdN8p+8TURxhzNFeNfKWfZUtQn+vT88fvtxfv
         nbcDsNcgrmCs250AQ4Z7iaOcwmBgEbBS3u4UaGgEJKNYceunfsh3pjaZB30HakZAAXnT
         P74CJJCS/ndrh9OabpkdIxtTRUpPzSPROrLhRVXFjctJIPZzS9JUUQj3af+5dBjWNQk/
         O1S4ZSdARxCC85pjdP2pnNv0PqwP2dtDdhxmucsAIEILXey9po2TbieEtZFhmosUgRJR
         ASoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv3AuA2Ycix+4bcmkwUJhLh5Ljf95e/QcqDcALe7Oz9gGR9mhpUdzNzO6iwtHyLD6XllzLlbuy/qECpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8JEqG0YEoWLC7bPLhdi0QxTiaW/bBeGsQezvIbmXjAVTKBZg
	AP48GSjjFDZIkLhhxNOztuiPMhoJukU4wCScuhP9SIjMmd1uVR7Q9SLoxkXF3e4KJB0=
X-Gm-Gg: ASbGncuY1VC+psKctbXrZ+nsQNDXnRngmeiWIHaenFslU80di8zo5ANl9GjqPLkZ9tP
	7L964+m59FHYxilY2+S2681UOOWNh0M0loPg1rPX2YLW0iRqf+1ayNU1XpdR3PsD/QkpmQZlYI9
	Ayf8dLofLjHNI9fpVXp8XNHvIoXpvJzmn4Q8G/Jb2pBAMHUPR4ccRrbuCR17Ebrpk6BfHgZrpWx
	Skl7NISEJxnkTLjGczAbqIvXvCfiAqnATlQu1YUWhv9RzdKBe5Ole8EEyHtTBvVcqUSB3QEI7rZ
	4I/6BpOVwGfTvLQ3Ktkkvd/qjSmoYUwoJUxzXn3BeoBDlkRDgYbVNkGK6/55F9nD68lqtoMnOpY
	nhTqJ5cGx6AstSc9pMlnyaxMFENvvaFkNTDyXWy/rrBqxLx4qX/qy6FTtLtx8s2gh+lzxL/75VO
	STzNaI
X-Google-Smtp-Source: AGHT+IFJLCQG0wA2+ju9X0SPF2fhZbMkJgtAM7PNHNEQ1jRFNtcgO1QZwCjDBWP7p0tfaSjIaIKbTw==
X-Received: by 2002:a05:600c:528b:b0:46e:1c97:e214 with SMTP id 5b1f17b1804b1-46e612691e2mr46118105e9.19.1759396885462;
        Thu, 02 Oct 2025 02:21:25 -0700 (PDT)
Received: from localhost (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e691820c3sm26320735e9.7.2025.10.02.02.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ca7df36c40fef4aef7d8884e97ac162d203f1e34b5b18ef9a0cb2f1f5dc0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 02 Oct 2025 11:21:16 +0200
Message-Id: <DD7Q531PLMFE.1G07XTKDUF9HR@baylibre.com>
Cc: "Vishal Mahaveer" <vishalm@ti.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] firmware: ti_sci: Partial-IO support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, "Nishanth
 Menon" <nm@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Santosh Shilimkar"
 <ssantosh@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
In-Reply-To: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>

--ca7df36c40fef4aef7d8884e97ac162d203f1e34b5b18ef9a0cb2f1f5dc0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 1, 2025 at 4:37 PM CEST, Markus Schneider-Pargmann (TI.com) wrot=
e:
> Hi,
>
> This series adds support for Partial-IO to the ti-sci driver,
> implementing the firmware interface necessary to enter this low power
> state. It processes the wakeup-source properties from the devicetree and
> communicates with the system firmware to enter Partial-IO mode when
> appropriate wakeup sources are enabled.
>
> Partial-IO Overview
> ------------------
> Partial-IO is a low power system state in which nearly everything is
> turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
> wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
> system on pin activity. Note that this does not resume the system as the
> DDR is off as well. So this state can be considered a power-off state
> with wakeup capabilities.
>
> A documentation can also be found in section 6.2.4 in the TRM:
>   https://www.ti.com/lit/pdf/spruiv7
>
> Implementation Details
> ----------------------
> The complete Partial-IO feature requires three coordinated series, each
> handling a different aspect of the implementation:

I missed updating the lore links, sorry, here are the new ones:

>
> 1. m_can driver series: Implements device-specific wakeup functionality
>    for m_can devices, allowing them to be set as wakeup sources.
>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-source=
/v6.17?ref_type=3Dheads
>    https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-0=
-6972a810d63b@baylibre.com

v10:
https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab=
508ac5d1e@baylibre.com

> 2. Devicetree series: Defines system states and wakeup sources in the
>    devicetree for am62, am62a and am62p.
>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/=
v6.17?ref_type=3Dheads
>    https://lore.kernel.org/r/20250812-topic-am62-dt-partialio-v6-15-v2-0-=
25352364a0ac@baylibre.com

v3:
https://lore.kernel.org/r/20251001-topic-am62-dt-partialio-v6-15-v3-0-7095f=
e263ece@baylibre.com

Best
Markus

> 3. This series (TI-SCI firmware): Implements the firmware interface to
>    enter Partial-IO mode when appropriate wakeup sources are enabled.
>
> Devicetree Bindings
> -------------------
> This series depends on the dt-schema pull request that adds bindings for
> system-idle-states and updates the binding for wakeup-source:
>   https://github.com/devicetree-org/dt-schema/pull/150
>
> This is now merged. These new bindings allow the ti-sci driver to
> identify devices that can act as wakeup sources for specific system
> states like Partial-IO.
>
> Testing
> -------
> A test branch is available here that includes all patches required to
> test Partial-IO:
>
> https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/=
v6.17?ref_type=3Dheads
>
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff
>
> These patches are tested on am62-lp-sk.
>
> Best,
> Markus
>
> Previous versions "firmware: ti_sci: Partial-IO support":
>  v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.c=
om/
>  v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.c=
om/
>  v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-=
0-f7c6c2739681@baylibre.com
>  v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-=
0-1cb8eabd407e@baylibre.com
>  v5: https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-=
0-f9323d3744a2@baylibre.com
>  v6: https://lore.kernel.org/r/20250421-topic-am62-partialio-v6-12-b4-v6-=
0-3b5cefab1339@baylibre.com
>  v7: https://lore.kernel.org/r/20250812-topic-am62-partialio-v6-12-b4-v7-=
0-ac10865c2d87@baylibre.com
>
> Previous versions "can: m_can: Add am62 wakeup support":
>  v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.c=
om/
>  v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.c=
om/
>  v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12=
-v3-0-9752c714ad12@baylibre.com
>  v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4=
-0-fdac1d1e7aa6@baylibre.com
>  v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5=
-0-33edc0aba629@baylibre.com
>  v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6=
-0-1356c7f7cfda@baylibre.com
>
> Changes in v8:
>  - Add a patch to remove constant 0 argument passing to
>    ti_sci_cmd_prepare_sleep
>  - Move partial-io functions further up in the file before the first
>    static const initializations
>
> Changes in v7:
>  - Rebase to v6.17-rc1
>  - Update the idle-state-name used to off-wake as introduced in
>    dt-schema
>
> Changes in v6:
>  - Narrowed down the wakeup-source binding to phandle lists
>  - Split off the mcan and DT changes into separate series
>
> Changes in v5:
>  - Rebased to v6.14-rc1
>  - Merged m_can and ti_sci series to avoid conflicts and show
>    dependencies more easily
>  - Added definitions of system-states for am62/am62a/am62p
>  - Moved wakeup-source definitions into board dts files as they require
>    a bit of support on the board.
>  - Updated ti_sci support to walk through the wakeup-source phandle
>    lists
>  - Added pinctrl settings for mcu_mcan0/1 on all boards
>  - Minor style updates for ti_sci support for transfers without response
>  - Update and move the dt-binding for wakeup-source from the m_can
>    binding to the dt-schema repository
>
> Changes in v4:
>  - Rebased to v6.13-rc1
>  - Removed all regulator related structures from patches and implemented
>    the wakeup-source property use instead.
>
> Changes in v3:
>  - Remove other modes declared for PREPARE_SLEEP as they probably won't
>    ever be used in upstream.
>  - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
>    an emergency_restart if it exits
>  - Remove uarts from DT wakeup sources
>  - Split no response handling in ti_sci_do_xfer() into a separate patch
>    and use goto instead of if ()
>  - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
>    the devices that are in the relevant group that are powered during
>    Partial-IO with the power supplies that are externally provided to
>    the SoC. In this case they are provided through 'vddshv_canuart'. All
>    devices using this regulator can be considered a potential wakeup
>    source if they are wakeup capable and wakeup enabled.
>  - Added devicetree patches adding vcc_3v3_sys regulator and
>    vddshv_canuart for am62-lp-sk
>  - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
>    mcu_mcan1
>
> Changes in v2:
>  - Rebase to v6.11-rc1
>  - dt-binding:
>     - Update commit message
>     - Add more verbose description of the new binding for a better
>       explanation.
>  - ti_sci driver:
>     - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
>       response if a flag is set.
>     - On failure to enter Partial-IO, do emergency_restart()
>     - Add comments
>     - Fix small things
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (TI.com) (3):
>       firmware: ti_sci: Remove constant 0 function arguments
>       firmware: ti_sci: Support transfers without response
>       firmware: ti_sci: Partial-IO support
>
>  drivers/firmware/ti_sci.c | 154 ++++++++++++++++++++++++++++++++++++++++=
++----
>  drivers/firmware/ti_sci.h |   5 ++
>  2 files changed, 146 insertions(+), 13 deletions(-)
> ---
> base-commit: 24c4d4041c2ec11c47baf6ea54f9379cf88809fc
> change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
> prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931=
bd8:v10
> prerequisite-patch-id: 40ff771d13dccae91c04ab120aa1b5e406b66e47
> prerequisite-patch-id: 830b339ea452edd750b04f719da91e721be630cb
> prerequisite-patch-id: 2c9142d2bc47e64c49b7b8a7ca20a62a0be14870
> prerequisite-patch-id: aa64f7e9fcc3fcbb3cb871a05a07f398f3aa8231
> prerequisite-change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17=
da:v3
> prerequisite-patch-id: 707e4619d7b844e1b67ccde28b4484b7b0d27daa
> prerequisite-patch-id: 412feb5d3fc125e489d11b726c0b2d8fd5ff36f3
> prerequisite-patch-id: 4e3ed635267f9548b9ac7a9e440971bb1e54a5ee
> prerequisite-patch-id: 65704d9da41da1fa9fc647c185f412022a16acb5
> prerequisite-patch-id: 95a62b97efdac9bdf1921c1222acefac6e608c84
> prerequisite-patch-id: 87d82194bc278580ae54e8788b4508f743c61061
>
> Best regards,


--ca7df36c40fef4aef7d8884e97ac162d203f1e34b5b18ef9a0cb2f1f5dc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaN5EDRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOl
iwEA5jTiWFP9wpRuXvHetvfzF/s0L087Ei1AlhBbaQXrdwQA/Axf/qVXreqRzBvQ
2j7lSQf3/LEe9NgJclcklnbm+z0J
=0eG3
-----END PGP SIGNATURE-----

--ca7df36c40fef4aef7d8884e97ac162d203f1e34b5b18ef9a0cb2f1f5dc0--

