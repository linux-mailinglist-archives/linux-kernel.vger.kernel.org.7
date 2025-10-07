Return-Path: <linux-kernel+bounces-844575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98295BC2406
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D0C4E44E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A72E7BB4;
	Tue,  7 Oct 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdmKeMvW"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0822E7BA3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858214; cv=none; b=ZLB4HfCYkoe4HYDh9jw7g965/i733KkzyYQ0n/uLZYBki3XpYA+t1dYq0tfRhe0yWbIT5g8j9f06MEU6hKPH61soMKX4xj/QC/kCJKfvWTwhZQx9fsJaNzwr9h5N4Lpo5I/2dYZqbdBWtMNxOdoaP7BRbbJxW3LWviXC793Ffb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858214; c=relaxed/simple;
	bh=ymtKH/86nnVE10cOxvy7YF/kwCVKux3lBOpB8deHHBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuFmCRdyhoWC7U2WbSl/Bo3mwAsRPCS+eZd0DHTLJm2gcY8So97xyhTTN9QCSGOrCiQoqPdViXEhbpLVvR0Kd5z78ZxL94F/Mt0n3F6era2EwwF4ayWQDDLQgZtzvIfUWyYWCUPQWQhhanoH91+xskgnCMTKxdj8sWj5oFcy1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdmKeMvW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4da894db6e9so57179121cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759858211; x=1760463011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMAj+aiM1byyV8qUW2iRSeox1tE1lo5J3rRUTQoSTSc=;
        b=fdmKeMvWIavgTo1QkTMRGeheFo0Xn2d04dqJ4HN6z71yjQLTegLtMYo7Bn/bfU6ljr
         d8OOA+YzRKm7HinaajhAnOquDH6xvDDkty2PgN0zE0jnPM8vEy8UZWk0vPEjJJ6GdmFZ
         5vYlJHcvjGDk9sD0J3iYd50bZlUoVT0Y5MGNp5YiGav5E98urQ0nuOPjfiA55Ui2XZ8v
         dilee9gjehp/XlyM8yn2NIVD0h5fSCllwQ/Cx9y3WTvJd60EFnft1hbcskPE3AmLdJI7
         GumZdbUnWs48bdRkWcbeSJy2EKXPlcxlCliwnk6bxC6YwqbOQ7i0e9BcgDfp0deJWuER
         hUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759858211; x=1760463011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMAj+aiM1byyV8qUW2iRSeox1tE1lo5J3rRUTQoSTSc=;
        b=eC9WQWHtFRJlmjh9ZbPqKKJ2Ga0VjV1hDZy7nhGPPWN31BOCQ/DnJP3Rzr6063Er71
         7Leq99TtGSwMAdFRxvL8cI/ffxleiK/N6T8pCyy+uMHFcw94cK6F1VVh+WuNCrSeVHvS
         4bVVu1qKFyKHpT7rC2T2GDooBg/gY9JyanYrCXGkvrD/9Nv+tV3D9qzWbykYisqCOyH/
         TPpUHCQ+SSsgT+vMQn7/rL9NWYvt4z2YxPm9269FnHb4JiGaT22tsRdmNHzZV0VohB8W
         LFg3yFw9VVB50GFm5u/+bH5Wo8qrAiY/tgc5oJ6DbH4J8mCp6LVfqCWxgaJ8EfW1NGjP
         fCkw==
X-Forwarded-Encrypted: i=1; AJvYcCVUH6Cfbr3r1kDgqIVODnq/S1M31D3u/kGd4m+IGaGcOOL3DWUjFTwGMbW9TZlBqusR7F4/bFGk/uX2Ym8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFp1ZqtwqBXAHHWIJGCG/tUw0EbGKcQrSXHSAyIJGj9Jub52f
	5dKGTMmdf47keAPgKvTBf6m/2YhbLHvPQ179dmNZ2lLsHnWmu8bR4cr5gErNSJ1ikjo5BZefZaN
	VxZb0Vc4xoPTa/wyhOTJVuHGiFtfHWME=
X-Gm-Gg: ASbGncskPZeu6dU8QFdBQTNG9TU24qgobsiiPTWqvHNOSxqUM30OGmEm0yFoBZ4ltvB
	ZonEQqtUKBH/8ZbYWRGhWa8sDrWPz0hRjw+5c7ZS+pJeZuoo2c4NjsZ6IugYvkfh8DOnq1Mn5Wa
	nyeDy1ug5Hy/qzTn1duc7DPjBm+oyVKc3R4thTw2fhvAKgb8eME9plFFhVOLRaIQ3bFuHjPTLPd
	5e+n3q2zAAqkR+XLWMd4YSF3OhKA5Pf
X-Google-Smtp-Source: AGHT+IGJRfUjE/oeQKG0hRpMB1UxYS7CMPbyUsEgb4VJAH4jITPPVIHBmZKNXDNSbvw+FOss5T4/jom7TqKt2zeh/lw=
X-Received: by 2002:a05:622a:28b:b0:4df:504:ef88 with SMTP id
 d75a77b69052e-4e6eacd88a2mr6233551cf.23.1759858210804; Tue, 07 Oct 2025
 10:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch> <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
In-Reply-To: <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
From: jjm2473 <jjm2473@gmail.com>
Date: Wed, 8 Oct 2025 01:29:57 +0800
X-Gm-Features: AS18NWBZUMXa0jkDLOJvcTfIew6vRsl83_rLRSuXeQfl3Nd8OcKbfEdsvkWXLgw
Message-ID: <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
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

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2025=E5=B9=B410=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=BA=8C 22:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 10:32:26PM +0800, jjm2473 wrote:
> > Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2025=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80 23:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > +&gmac0 {
> > > > +     phy-mode =3D "rgmii";
> > >
> > > Did i really miss this patch series in its earlier version, or did yo=
u
> > > ignore me?
> > >
> > > https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetre=
e/bindings/net/ethernet-controller.yaml#L287
> > >
> > > > +     tx_delay =3D <0x3c>;
> > > > +     rx_delay =3D <0x2f>;
> > >
> > > Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> > > us the schematics which clearly show extra long clock lines.
> > >
> > > > +/* Micro SD card slot is not mounted */
> > > > +&sdmmc0 {
> > > > +     max-frequency =3D <150000000>;
> > > > +     no-sdio;
> > > > +     no-mmc;
> > > > +     bus-width =3D <4>;
> > > > +     cap-mmc-highspeed;
> > > > +     cap-sd-highspeed;
> > > > +     disable-wp;
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_d=
et>;
> > > > +     vmmc-supply =3D <&vcc3v3_sd>;
> > > > +     vqmmc-supply =3D <&vccio_sd>;
> > > > +     status =3D "disabled";
> > > > +};
> > > > +
> > > > +/* Wifi module is not mounted */
> > > > +&sdmmc2 {
> > >
> > > What do you mean by "not mounted"?
> > >
> > > Often you would say "not populated", to indicate the PCB has all the
> > > tracks in place, but the chip has simply not been soldered in place.
> > >
> > > Or is there a connector here, and nothing plugged into the connector?
> > >
> > >    Andrew
> >
> > Andrew:
> >  Hello! I ran `./scripts/get_maintainer.pl
> > patches-v4/v4-0003-arm64-dts-rockchip-add-LinkEase-EasePi-R1.patch`
> > to get maintainer list, and got:
> > ```
> > Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS)
> > Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS,commit_signer:3/41=3D7%)
> > Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS)
> > Heiko Stuebner <heiko@sntech.de> (maintainer:ARM/Rockchip SoC
> > support,commit_signer:43/41=3D100%,authored:4/41=3D10%,added_lines:12/1=
17=3D10%,commit_signer:5/6=3D83%)
> > Quentin Schulz <quentin.schulz@cherry.de>
> > (commit_signer:10/41=3D24%,authored:8/41=3D20%,added_lines:63/117=3D54%=
)
> > Dragan Simic <dsimic@manjaro.org> (commit_signer:5/41=3D12%,commit_sign=
er:1/6=3D17%)
> > FUKAUMI Naoki <naoki@radxa.com>
> > (commit_signer:3/41=3D7%,authored:3/41=3D7%,removed_lines:1/1=3D100%)
> > Peter Robinson <pbrobinson@gmail.com>
> > (added_lines:9/117=3D8%,commit_signer:1/6=3D17%,authored:1/6=3D17%)
> > Alexey Charkov <alchark@gmail.com> (added_lines:6/117=3D5%)
> > Diederik de Haas <didi.debian@cknow.org>
> > (commit_signer:4/6=3D67%,authored:3/6=3D50%)
> > Liangbin Lian <jjm2473@gmail.com> (commit_signer:1/6=3D17%,authored:1/6=
=3D17%)
> > Johan Jonker <jbx6244@gmail.com> (authored:1/6=3D17%)
> > devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS)
> > linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC s=
upport)
> > linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
> > linux-kernel@vger.kernel.org (open list)
> > ```
> > your email address is not listed above.
>
> What i eventually found is that you posted v3 separately, and then
> threaded v4 to v2, which makes no sense.
>
> Please always start a new thread for each patchset.
>
> > > What do you mean by "not mounted"?
> > >
> > > Often you would say "not populated", to indicate the PCB has all the
> > > tracks in place, but the chip has simply not been soldered in place.
> > >
> > > Or is there a connector here, and nothing plugged into the connector?
> >
> > The chip/slot has not been soldered. So here should be "not
> > populated", forgive my poor English.
>
> Thanks for the clarification. I'm not sure it is worth adding these DT
> properties. When a new board is produced which does populate these
> devices, you are going to need a new .dts file. So you can put the
> properties into that new file.
>
> >
> > > Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> > > us the schematics which clearly show extra long clock lines.
> >
> > In fact, the RTL8211F's RXDLY and TXDLY signals are both pulled low,
> > just like the Banana Pi BPI-R2 Pro, so the configuration is also refere=
nced:
> > https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/rockc=
hip/rk3568-bpi-r2-pro.dts#L237
>
> Pull low makes no difference to the 2ns RGMII delays.
>
> > The tx_delay and rx_delay values were obtained using Rockchip's
> > automatic scanning tool:
> > https://github.com/istoreos/istoreos/blob/54746dfdb5bd34d1f281cf41d1d16=
20d0c3ee686/target/linux/rockchip/files/drivers/net/ethernet/stmicro/stmmac=
/dwmac-rk-tool.c
> > https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC=
/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> > https://github.com/axlrose/rkdocs/blob/main/Common/GMAC/Rockchip_Develo=
per_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
>
> Vendors get things wrong, including this. 'rgmii' means the PCB adds
> the 2ns delay. Nearly every Rockchip board follows Rockchip broken
> vendor recommendations, and then i come along, point out how it is
> wrong, and ask for it to be fixed, before being merged to Mainline.
>
>         Andrew

Andrew:
 Hello!

>
> What i eventually found is that you posted v3 separately, and then
> threaded v4 to v2, which makes no sense.
>

This is v2 link
https://lore.kernel.org/all/20250925092037.13582-1-jjm2473@gmail.com/
.
I don't see 'v4' in there. I have no idea why you see 'v4', can you
please share a link?

This is v3 link
https://lore.kernel.org/all/20250929065714.27741-1-jjm2473@gmail.com/
.
I don't see threading issue.
I use `git send-email --to '***' --cc '***' patches-v3` to send email,
should be OK.
(`patches-v3` is a folder contains patches generaterated by `git
format-patch --base=3Dmaster --cover-letter -v3 HEAD -3 -o patches-v3`).

> When a new board is produced which does populate these
> devices, you are going to need a new .dts file. So you can put the
> properties into that new file.

These two nodes just describe the gpio and regulator found in the schematic=
.
If some users solder these connectors or modules themselves,
they only need to change the status to ok and they can use them.
If this will cause confusion, I can delete these two nodes.

> Vendors get things wrong, including this. 'rgmii' means the PCB adds
> the 2ns delay. Nearly every Rockchip board follows Rockchip broken
> vendor recommendations, and then i come along, point out how it is
> wrong, and ask for it to be fixed, before being merged to Mainline.

I will try `rgmii-id` and rescan {tx|rx}_delay, just like
https://lore.kernel.org/all/20250925092923.2184187-3-heiko@sntech.de/

I also notice that you suggest use {tx|rx}-internal-delay-ps instead
of  {tx|rx}_delay in
https://lore.kernel.org/all/e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.ch/ ,
but I think this depends on stmmac driver.

  Liangbin Lian

