Return-Path: <linux-kernel+bounces-840065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE8BB372B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26E51889EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8B2C028B;
	Thu,  2 Oct 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KvidH+Rm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EB2D4813
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397091; cv=none; b=Txihwy89RblhlOQlMJ5fWYCXf3W67OHWgenCoH+6HrzD701X1hl2x4r+BpD9sYt0jG0FY9EDAb931T3NJCLAMTsVIouEeys5qpU/JRPtpZ1gOPiXFZtpcZrRPfrCwp3fyBppdzmvszM26Vrt5dEQ+d+/fLm75D91xX+fN+FVQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397091; c=relaxed/simple;
	bh=tgbk9RmYdZkYbnbWwPdLH3MSImob3q/BtvIzQHc5jT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K/CvovFZDIzsCO7AqCAdzSARrMseQefavbMlbAodC3+UBRXbuIBxnL3BHjG5f4wqVNoVfLn2SApil+FM/zSQHfZmCB99Q3rIUuvDJFLwJpHX0hZ+GL3mDw9CoQfl8h38lm1NQnRFTH7vz8iXbVRqs8/b/u2kQsyHMu525BgWH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KvidH+Rm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso6058385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759397088; x=1760001888; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/t1/wksIDf3jPXIxuPylTLhtA9vOxDXIa8eokU2PmXw=;
        b=KvidH+RmjryCCrLhcRpCrL5Bjjk+5Y4jVCHB4bl1E1bQql3Wk+qkXRCnDqJZlgeeIc
         etyJrS/UwhgOv+vPsL6YJWzIaADzZqzPH3NwIt8Fq5bjLDrkdwVy44Pu4FwCcTEhqqPZ
         1Op6D+PlErVCUJrakENrb3CibeDnzgsDH1k1PUk6ZBHgbp8WG+17jRhrtThOtj9TaHtc
         1sYqsQUcYfBtWn/LwmHIqjqF2MYY+pKGYv0eg8Gdi9Lf5xTAODXRJ64wbMG0c1g+IpP+
         XNkXOzRJ8PZG7PrGu6LiAXMsqBHTjW7UCpWKBGdB56uZqxguw1rb03rI8jKwaqhtOj/r
         4zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397088; x=1760001888;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t1/wksIDf3jPXIxuPylTLhtA9vOxDXIa8eokU2PmXw=;
        b=WwCFP6EqkXYSJp9Xn5WYKu0ATCe2mxGDRAXT9X4rXMaxJy4IQhuF76dh3KYVzmbGrf
         66BLJ5MwS5rg9W61zWIGrzlZF0jMY4vVU6lscNb/EmEixFpRH1PqPfNqW4QXPWn/85lx
         PZvdhtm7nkjO55h8/JLYcgFJpXYmH9cc6nZq+UkzX1ZGZtPNKFkCWc2fkJJZmjDLfhuH
         H32mb4SQuscdIIuk7kftMmOPhTetZ/IrfmZKmfgx19ZiV/XMVIp91PE4scBYwDPhc2IW
         WfakxEKCcdfaPL2WllIPnX4Kd/hGffqIQyUcJVp8QiNq3Ipsh2jvC2tkVhAct+5aVrVK
         eoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAr8ZYve164TEFGw0S8hVPxYYSukcA2wUpDBujuDV5wwnmCq+Wx19ZmaQo0ILt24y7E1l2tG2o6PVrp8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26BKIklBaXQcFzJaBBZdZKvLeg8WKbqH8EMHqTs885Vb+ZDqv
	YU2yZpyPR2XBPrs9AkuPonJpXzF/beGNYSyJICYSVGvkThZAKBO+SNxt3SEyjeGaSv2pkl638a+
	tLIpmODk=
X-Gm-Gg: ASbGncvWhZFbQqyYJyQnhMLXn/nQE2ITi92xiQcadsQYQLe1GRlmGsOFBzG9XP1YUBq
	WOJ6u0/mSoCXZYQk6sQ8h/WN2Ee+hjEdPhc15mBBX6L0f2qiwNg5Ns+F/CxohysJusK2otRfW3I
	5U0y7cRxgVPs3b4f8ESQ9qrwCAzqLv+k0MEY9iCAJ3e8g7n/0kiHD1y9qftN7iFfoa5IwGaYZBW
	GfRpYl+90r6Kw9Fl43acMhDClP3iBTlboBme2Nih85EVO0I8OynltFR+DxwqrZ+lTu4uGB+hSSl
	ewMc5LPCmoP6M0nDnytUBj+oCSoiY8BwB6JApRA42GJZ/aGylB08sIFwlMMVxbLbiNUXqc/Qx2R
	S/DTdWK3Zi6ed2n9qr2of63X6IzqIIKKW8Da8HwoO6ij9egNrbpe8L/sF+yBXaRvP6Z8U/A==
X-Google-Smtp-Source: AGHT+IESV0coqhnpEDbT2Ff0mcbG5fodwxZU2sbL8zxaucsaY4KXStaV0RqhFdHkaqlu6kxIwfCbrA==
X-Received: by 2002:a05:600c:a08e:b0:46d:cfc9:1d20 with SMTP id 5b1f17b1804b1-46e612bab6cmr44711815e9.22.1759397087719;
        Thu, 02 Oct 2025 02:24:47 -0700 (PDT)
Received: from localhost (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e619b8343sm74081805e9.2.2025.10.02.02.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=18a92e2b6b60e172e39476fc52257f0148eab3545fa353d7b0b0e342ab6f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 02 Oct 2025 11:24:38 +0200
Message-Id: <DD7Q7NSX0HGG.GTQPPTS7H1FB@baylibre.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>
Subject: Re: [PATCH v3 0/6] arm64: dts: ti: k3-am62: Add wakeup-sources for
 low power modes
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>
In-Reply-To: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>

--18a92e2b6b60e172e39476fc52257f0148eab3545fa353d7b0b0e342ab6f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 1, 2025 at 4:34 PM CEST, Markus Schneider-Pargmann (TI.com) wrot=
e:
> Hi,
>
> This series adds devicetree changes needed for Partial-IO support on TI
> am62, am62a, and am62p SoCs. It defines system states for various low
> power modes and configures the wakeup-sources for devices in the CANUART
> group. Depending on the SoC and board details, some low power modes may
> not be available, so the wakeup-sources are described in the board
> files. The series also adds the necessary pinctrl settings required for
> proper wakeup functionality.
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

I missed updating the lore links, here they are:

> 1. m_can driver series: Implements device-specific wakeup functionality
>    for m_can devices, allowing them to be set as wakeup sources.
>     https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-sourc=
e/v6.17?ref_type=3Dheads
>     https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-=
0-6972a810d63b@baylibre.com

v10:
https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab=
508ac5d1e@baylibre.com

> 2. This series (devicetree): Defines system states and wakeup sources in
>    the devicetree for am62, am62a and am62p.
>
> 3. TI-SCI firmware series: Implements the firmware interface to enter
>    Partial-IO mode when appropriate wakeup sources are enabled.
>     https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v=
6.17?ref_type=3Dheads

v8:
https://lore.kernel.org/r/20251001-topic-am62-partialio-v6-12-b4-v8-0-76a74=
2605110@baylibre.com

Best
Markus

>
> Devicetree Bindings
> -------------------
> This series depends on the dt-schema pull request that adds bindings for
> system-idle-states and updates the binding for wakeup-source:
>   https://github.com/devicetree-org/dt-schema/pull/150
>
> This is merged now in upstream dt-schema. These new bindings allow us to
> define the system states and reference them from device wakeup-source
> properties.
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
> I tested these patches on am62-lp-sk.
>
> Best,
> Markus
>
> Previous versions
> -----------------
>  - Link to v2: https://lore.kernel.org/r/20250812-topic-am62-dt-partialio=
-v6-15-v2-0-25352364a0ac@baylibre.com
>  - Link to v1: https://lore.kernel.org/r/20250421-topic-am62-dt-partialio=
-v6-15-v1-0-6ced30aafddb@baylibre.com
>  - As part of the series "firmware: ti_sci: Partial-IO support"
>    https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-=
f9323d3744a2@baylibre.com
>
> Changes in v3:
>  - Drop patch to add WKUP_EN and rebase to linux-next to base on the
>    patch that accepted which adds PIN_WKUP_EN instead
>    https://lore.kernel.org/all/20250909044108.2541534-1-a-kaur@ti.com/
>  - Fix small typos in the commit messages
>  - Use AM62AX_MCU_IOPAD for am62a and AM62PX_MCU_IOPAD for am62p
>
> Changes in v2:
>  - Combine k3-am62a7-sk.dts devicetree nodes with existing ones
>  - Combine k3-am62p5-sk.dts devicetree nodes with existing ones
>  - Update the idle-state-name properties to the new names from the
>    dt-schema
>  - Rebase to 6.17-rc1
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (TI.com) (6):
>       arm64: dts: ti: k3-am62: Define possible system states
>       arm64: dts: ti: k3-am62a: Define possible system states
>       arm64: dts: ti: k3-am62p: Define possible system states
>       arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
>       arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
>       arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states
>
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 ++++++++++++++++++++++++++=
+
>  arch/arm64/boot/dts/ti/k3-am62.dtsi      | 22 ++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a.dtsi     | 27 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts  | 71 ++++++++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi     | 27 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts  | 71 ++++++++++++++++++++++++++=
++++++
>  6 files changed, 278 insertions(+)
> ---
> base-commit: 24c4d4041c2ec11c47baf6ea54f9379cf88809fc
> change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da
> prerequisite-change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931=
bd8:v10
> prerequisite-patch-id: 40ff771d13dccae91c04ab120aa1b5e406b66e47
> prerequisite-patch-id: 830b339ea452edd750b04f719da91e721be630cb
> prerequisite-patch-id: 2c9142d2bc47e64c49b7b8a7ca20a62a0be14870
> prerequisite-patch-id: aa64f7e9fcc3fcbb3cb871a05a07f398f3aa8231
>
> Best regards,


--18a92e2b6b60e172e39476fc52257f0148eab3545fa353d7b0b0e342ab6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaN5E1hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMF
7wEA7A4kvhpKpIXHOpsMVN+m1MRqhXoWJbGNbNUBBD4uYrsBAI4lCf/2jOr1yVOR
fH3WH1xRgsOtHu5d0YNiT9ea7LwO
=XyLo
-----END PGP SIGNATURE-----

--18a92e2b6b60e172e39476fc52257f0148eab3545fa353d7b0b0e342ab6f--

