Return-Path: <linux-kernel+bounces-806887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B7B49D25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594E81B27B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9D2EF671;
	Mon,  8 Sep 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky42+IFu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04C47F4A;
	Mon,  8 Sep 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372274; cv=none; b=cSkW4oZBx48e3tdPreKRwP92M2u6XOPFCcx5QugFUU8s97B4PA/OlswavHXHIV94bkNWK28l7wWeyE5u0Y3r4B8xXXg8z9bCcQB8SmKobBPB2qtJu9DFQiGDithw5teJigul7xj9pobfJMbFjiOjgdoungZJToCAugxzlO4HgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372274; c=relaxed/simple;
	bh=1jo1Vv0Vs8hahvZP85nSL0Whq/0i4fskm9cB+6S7Sb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU7sCocnJzze9bynX4k7vEeNKkvrTha4nLebDTUDfcjJaBVTeBR78TowDgXXwNeidTqqIkLtasRS6JymK8unI/lfpPtUKvznoE5QYKrduJc7g2Kg2KelLPvagdjgHTPHFTvEZy+m4YwnR9Q1V/urlmotGl2gdUkXNj1rxtGsYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky42+IFu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo2046418f8f.1;
        Mon, 08 Sep 2025 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757372268; x=1757977068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUvupcsRCkQfs+P8J05KpMp2C799/IJHD4VTsiVCzQU=;
        b=Ky42+IFuok586UuDQgRhm64bmOx4S+21llvAnCi6OCewr3FWNW6gVBWLw0c+mzXi7i
         YZUTo9USFa5yFSWQGIShg/BYrUpJpu1nnOXmU8Pgcjxf8+CysZAGv29HX9v1++N+P+Z/
         5wSfwIahNXXCA/AiyBjuxUpcvB56s29c45WyNBSAESTAvXSt0C0UnQjUUjmczdOBuQKc
         6YG/6CyZ6wnTHS7jztrKtEQkejQ108Wep3tCSuFZT7rufJRLYZIOIdXUnazofPlTk0fu
         6D6JvPJW8XlMqwMPqayzX6NeSV0Ny3TagGvvCWh5+rw70RlQXVof0nML+vWliQKCepe6
         ZwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372268; x=1757977068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUvupcsRCkQfs+P8J05KpMp2C799/IJHD4VTsiVCzQU=;
        b=C/mLf7bYvocpEj7uSmgNPNucbccrIzE7i5ENLJMnFcZenwZ5d+M5voEnnt2ase1cCg
         j6tamdByhW7kc2Ah5mpnVxYwxLSsDLoi+1ayuR1H71dSFBgkfdMS+neIeA/WthvGN+Do
         LFQVgHlaexjcjdL0vZZeF7QMz3AFbKAbRxNLizC0517mpMm4BzkLP46dYYWejLocDyPL
         FvASCcszVNw/HQcWgGWK2oa13OCifVMQw7j8YZe8CYUvoDpT84diDssdh7lKokJ4RbeN
         MP4HEhSLZxxQy6ArrkMypMh4/IyG72P7G5HyMmf6mVqSmyyl4d9A44UfV489YdRA5yWN
         /8nw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOTydAkymiSSBQu3SEBBLMO1mEhWpqIaRYbyyfx+V0u1sYWu6gE+yZNHCxrSB5MIduqAxHNTzGp45+XRQ@vger.kernel.org, AJvYcCUbECzmCd0qty8dXmsbAzC3+mJTiEXwVSvDggSibQQT5Ge9ypEgnx7PURkbGTP7z6T5yQiW+RwffRqj@vger.kernel.org
X-Gm-Message-State: AOJu0YyRILrI/f2yC0wdo6LB8ACUHbL1ax5d2pOaLR7pPfUiXPZjepqE
	7HFHRXGqwmlpN0mczAiPOlEL6Uur0sKyRVZ1MFrx6kEorZbZCno7pEi5
X-Gm-Gg: ASbGncsUGgfGR2HXexryFfaE95qu1DDAnxXYODlruc3+69l8gtVQ9e3TGsUeIikaQxb
	mGsrFKyWVTqxu+KFVD/eZkXMdXZoH0U/DeShtYaAs+B5KShq8v7P1KbYEk6l+WuZ892B0Qw+wqN
	fRI4uhaPy23yCoJx7XAo93LHDnvq+isSqDm25mqYTktMX8ff7mYCX4xOW17ncPG02g1RnUM3GK4
	0zPG2mEdh3WMJO/7/Q3RZ6ctyT0rFKgI4JNRu/hqs2M32FtFoJpPDM1UaT3DEE8r4PvXPjxxW7o
	R+A/pk0SjW8cdm5jWbJddXQ9w/IMPcHDAbA6+vEkzryuPMD7VXtulaGtqc9oTWHsxcfLSV9pRLe
	645ETMgwUWZpQFvA2HokNFlnTm7/h5nJqeObXkaRQmB4ynoRUadLl7OJeIMPumXmT2LXoVCV9zp
	u4fPDnYeCh
X-Google-Smtp-Source: AGHT+IHNyN6qy4Z/EdCypF+HkDEY2JT93OD46/zVWVzUsfkBn/dv6BYtFe56OQfZXkQXUnUBziSXtw==
X-Received: by 2002:a05:6000:2f87:b0:3d9:2fa8:1009 with SMTP id ffacd0b85a97d-3e64c3acf34mr7435111f8f.45.1757372268165;
        Mon, 08 Sep 2025 15:57:48 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca2aesm56321f8f.26.2025.09.08.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:57:47 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@csie.org,
 samuel@sholland.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: Re: [PATCH] arm64: dts: allwiner: h5: OrangePi PC2: add ethernet LEDs
Date: Tue, 09 Sep 2025 00:57:46 +0200
Message-ID: <12736197.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <5617fd78-32aa-44f4-9f9c-16349b3f8450@wp.pl>
References:
 <20250818163520.1004528-1-olek2@wp.pl> <2012341.PYKUYFuaPT@jernej-laptop>
 <5617fd78-32aa-44f4-9f9c-16349b3f8450@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 9. september 2025 ob 00:11:46 Srednjeevropski poletni =C4=8Das j=
e Aleksander Jan Bajkowski napisal(a):
> Hi Jernej,
>=20
> On 9/8/25 16:45, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 18. avgust 2025 ob 18:35:13 Srednjeevropski poletni =C4=
=8Das je Aleksander Jan Bajkowski napisal(a):
> >> This patch adds support for Ethernet LEDs.
> > How did you tested this? According to linux-sunxi wiki, this board has
> > RTL8211E, while LED control is supported only with RTL8211F driver.
>=20
>=20
> For testing, I used OpenWRT snapshot with kernel 6.12. OpenWRT backported
> patches from kernel 6.16 that add LED control support. Realtek RTL8211E
> supports LED control since commit:
> 708686132ba02659267c0cebcc414348ece389a5 ("net: phy: realtek: Add=20
> support for PHY LEDs on RTL8211E")

Ah, I haven't checked the latest code. Alright.

>=20
> >
> >> Signed-off-by: Aleksander Jan Bajkowski<olek2@wp.pl>
> >> ---
> >>   .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 20 +++++++++++++++++=
++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> >> index 0f29da7d51e6..7688f565ec9b 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> >> @@ -7,6 +7,7 @@
> >>  =20
> >>   #include <dt-bindings/gpio/gpio.h>
> >>   #include <dt-bindings/input/input.h>
> >> +#include <dt-bindings/leds/common.h>
> >>   #include <dt-bindings/pinctrl/sun4i-a10.h>
> >>  =20
> >>   / {
> >> @@ -132,6 +133,25 @@ &external_mdio {
> >>   	ext_rgmii_phy: ethernet-phy@1 {
> >>   		compatible =3D "ethernet-phy-ieee802.3-c22";
> >>   		reg =3D <1>;
> >> +
> >> +		leds {
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <0>;
> >> +
> >> +			led@0 {
> >> +				reg =3D <0>;
> >> +				color =3D <LED_COLOR_ID_GREEN>;
> >> +				function =3D LED_FUNCTION_LAN;
> >> +				linux,default-trigger =3D "netdev";
> >> +			};
> >> +
> >> +			led@1 {
> >> +				reg =3D <1>;
> >> +				color =3D <LED_COLOR_ID_AMBER>;
> >> +				function =3D LED_FUNCTION_LAN;
> >> +				linux,default-trigger =3D "netdev";
> >> +			};
> > Schematic says LED0 is "Yellow" or Amber in this DT. So LED1 should be =
green.
> >
> > Also, I'm not sure if trigger really needs to be added, since PHY netwo=
rk
> > will set it as such.
>=20
> I think there is a mistake in the schematic. Setting the trigger on LED0
> illuminates the green LED. My tests found that the netdev trigger isn't
> set by default.

Ok.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



