Return-Path: <linux-kernel+bounces-844377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7DBC1C22
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D93B3E22B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C82E03FB;
	Tue,  7 Oct 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kme6tXru"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A91F3FF8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847562; cv=none; b=H5AusIWL6C2ZAild291J6IX8Q6Nz1D3oMTjZD8IKrkdIRKCT5NJDHBp6Inu76xPU6bNBWVX9jZFg2uSOVpMPiSvW0X2fZZB60xvyXHg+N2SnGhFvIIhARerskGIAV5OKuNDcQ9aXsJmkCX7hpMt5rfd51PyBNCYr3GeVov/fpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847562; c=relaxed/simple;
	bh=nsPAIctrIJysjDJphYW6JckvkqC/Wzx7w+aZj9zKjOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+udz+WsR98hg5qQpjWGaY9ax7aeIG/Zuc1VKJQa4lL0lGF1IkzUF6arGyWTBNAdUoyNi0yUeDFP1rfWp+cLu7wmDUx8PY3Oc4iezRrHmenNF21ESLRjOj/xEUNNbNd8lIsz7WR6XYNsT+tUwvA7YuMFv+vwbwqYk4aOt09ine0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kme6tXru; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87499a3cd37so47779096d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759847559; x=1760452359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Ko9EuByB72AmPY68qaHZeiB7esoLxBKg9O0pS8bew=;
        b=Kme6tXru5j21Xay7GawF7B3eokvH5plviWSqXyvk04PYtvlrGG04x2cDne8ygSbcNi
         SkzvK9Z2tx+bxn5o77veoKjxdXmoZ8rADS5YgKUqISjgQDqMxYovJ/83JmaR1GE2tuqv
         AMR9L9DGE8kqVgQr1tb/x8dFaLKD+zSoFl4VAOrfHRkhgdiYGbG3nSg+m8h2ogaoY7xI
         vH2dnZkQy+cHQ3cPP4APlVB6js0a56w8zwJYy2dkp3C9RMTolcM6qvfLSrxzLbxhxcO1
         +zcZ+Lsrz/fFFvqzZ00Tzqfxt2VQVqCmsqp9tBy/12iA/SyM/XUn5a2Pve9GKAnn9VWH
         1e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847559; x=1760452359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Ko9EuByB72AmPY68qaHZeiB7esoLxBKg9O0pS8bew=;
        b=oK9Fv+RkcUelL+bo9mIkQ8gDvPe34Czts/bMCxAQ+sGSJTzflyFu5YkwwJN23qN/gK
         W+gLZvz4eeqlLU3lk6rJ3Hjs5R9iIUEDFUaAGd4imdIILw8rM0xplN7WSY2gji6+7oxH
         tXxcV973RgxPbOjIbPqHEfEjueAmKbIHUAsmYkRzJabqccblp3uKBFx2BPi/gQYjkDLw
         yit8SieJAFEzd51it2b9j7cRKZ9I5dr5E/4oWZWM7lIFQNItsD5sIW9uAm9aLrKOeyQA
         RgOCjjHi60OpiW1pqz4MFohb5OirDQ7GA0ZfC836ugWwfPbzphE1/gqddTqCfHuYil+k
         lYQw==
X-Forwarded-Encrypted: i=1; AJvYcCUNBmfIqDUWP3NevXPRSo+/xnmaawpHQbU67fvaKWyxJY1KVLd19l7d38SFoBTGiI1HdiIDmVJmJlBl4pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqoqgu1Nf+28rHmFhSc/NtnWRxjvV4XRZp7tW5suyrjJmqw+YV
	WHCM5Ov4sr2ybBao8a11zHr4BqNFGLTF5E3wkxW+pCBSYE/1+4RfN6fOiB3GhF8OrJg7EBfB/bv
	nWvUHjU6By6VeKmQhIf22cX6zgCujBoI=
X-Gm-Gg: ASbGncu1ghHMoIfknHiu1tX4u66FiMUWyPz5lB2NKWDKZPmhacgClC3ONc2jiEfh5ec
	pqXkuCMXqOgv4lsJ3M7fLX1LkhOmyQkG8nNRCC6qTsI68PqSj9ezmaBQkbWJJfgVuAd2u44bewL
	uo/wzaQeq0IEcGwKnkMFEyT1mLNMTiwlRolNfxMrojcFwdovHIVs9CYd+CMqalp3c7Dn8wXLG7z
	6CDCDsMdKDPhYuwy+BFSfd6oi5peTTRA0eAq0HEIJA=
X-Google-Smtp-Source: AGHT+IEyCKpYps/3BGc22BxSR5vdUK9H945UNs5mFpXR5FmYYn0yozFBPVoQCqHwhbvW2Mk1hUuA7PjHSd59EhPjCTw=
X-Received: by 2002:a05:6214:1c4d:b0:78d:63c4:9d5c with SMTP id
 6a1803df08f44-879dc7abcf0mr199677706d6.5.1759847559189; Tue, 07 Oct 2025
 07:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
In-Reply-To: <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
From: jjm2473 <jjm2473@gmail.com>
Date: Tue, 7 Oct 2025 22:32:26 +0800
X-Gm-Features: AS18NWBCvYOruCThhN8XGst8DvyIOMmZ1iSy5xv_cE-cTej27zRd1fN4u0hMtEY
Message-ID: <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com, 
	honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com, 
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org, 
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org, 
	jbx6244@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2025=E5=B9=B410=E6=9C=886=E6=97=A5=E5=
=91=A8=E4=B8=80 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> > +&gmac0 {
> > +     phy-mode =3D "rgmii";
>
> Did i really miss this patch series in its earlier version, or did you
> ignore me?
>
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bi=
ndings/net/ethernet-controller.yaml#L287
>
> > +     tx_delay =3D <0x3c>;
> > +     rx_delay =3D <0x2f>;
>
> Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> us the schematics which clearly show extra long clock lines.
>
> > +/* Micro SD card slot is not mounted */
> > +&sdmmc0 {
> > +     max-frequency =3D <150000000>;
> > +     no-sdio;
> > +     no-mmc;
> > +     bus-width =3D <4>;
> > +     cap-mmc-highspeed;
> > +     cap-sd-highspeed;
> > +     disable-wp;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > +     vmmc-supply =3D <&vcc3v3_sd>;
> > +     vqmmc-supply =3D <&vccio_sd>;
> > +     status =3D "disabled";
> > +};
> > +
> > +/* Wifi module is not mounted */
> > +&sdmmc2 {
>
> What do you mean by "not mounted"?
>
> Often you would say "not populated", to indicate the PCB has all the
> tracks in place, but the chip has simply not been soldered in place.
>
> Or is there a connector here, and nothing plugged into the connector?
>
>    Andrew

Andrew:
 Hello! I ran `./scripts/get_maintainer.pl
patches-v4/v4-0003-arm64-dts-rockchip-add-LinkEase-EasePi-R1.patch`
to get maintainer list, and got:
```
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS,commit_signer:3/41=3D7%)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
Heiko Stuebner <heiko@sntech.de> (maintainer:ARM/Rockchip SoC
support,commit_signer:43/41=3D100%,authored:4/41=3D10%,added_lines:12/117=
=3D10%,commit_signer:5/6=3D83%)
Quentin Schulz <quentin.schulz@cherry.de>
(commit_signer:10/41=3D24%,authored:8/41=3D20%,added_lines:63/117=3D54%)
Dragan Simic <dsimic@manjaro.org> (commit_signer:5/41=3D12%,commit_signer:1=
/6=3D17%)
FUKAUMI Naoki <naoki@radxa.com>
(commit_signer:3/41=3D7%,authored:3/41=3D7%,removed_lines:1/1=3D100%)
Peter Robinson <pbrobinson@gmail.com>
(added_lines:9/117=3D8%,commit_signer:1/6=3D17%,authored:1/6=3D17%)
Alexey Charkov <alchark@gmail.com> (added_lines:6/117=3D5%)
Diederik de Haas <didi.debian@cknow.org>
(commit_signer:4/6=3D67%,authored:3/6=3D50%)
Liangbin Lian <jjm2473@gmail.com> (commit_signer:1/6=3D17%,authored:1/6=3D1=
7%)
Johan Jonker <jbx6244@gmail.com> (authored:1/6=3D17%)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC suppo=
rt)
linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
linux-kernel@vger.kernel.org (open list)
```
your email address is not listed above.
And I did not receive your comment on the previou versions.

The latest v4 version is here
https://lore.kernel.org/all/20250930055017.67610-1-jjm2473@gmail.com/
.

> What do you mean by "not mounted"?
>
> Often you would say "not populated", to indicate the PCB has all the
> tracks in place, but the chip has simply not been soldered in place.
>
> Or is there a connector here, and nothing plugged into the connector?

The chip/slot has not been soldered. So here should be "not
populated", forgive my poor English.

> Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> us the schematics which clearly show extra long clock lines.

In fact, the RTL8211F's RXDLY and TXDLY signals are both pulled low,
just like the Banana Pi BPI-R2 Pro, so the configuration is also referenced=
:
https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/rockchip/=
rk3568-bpi-r2-pro.dts#L237

The tx_delay and rx_delay values were obtained using Rockchip's
automatic scanning tool:
https://github.com/istoreos/istoreos/blob/54746dfdb5bd34d1f281cf41d1d1620d0=
c3ee686/target/linux/rockchip/files/drivers/net/ethernet/stmicro/stmmac/dwm=
ac-rk-tool.c
https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Roc=
kchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
https://github.com/axlrose/rkdocs/blob/main/Common/GMAC/Rockchip_Developer_=
Guide_Linux_GMAC_RGMII_Delayline_EN.pdf

I will try changing phy-mode =3D "rgmii-id" later to see if gmac
continues to work properly.

  Liangbin Lian

