Return-Path: <linux-kernel+bounces-900086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59413C59936
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 148D5342A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A031618E;
	Thu, 13 Nov 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGtumTY5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FD2D7397
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060052; cv=none; b=r5AHCB9QPJdP1JzA8Y7VYLCOZe12r7JCYmw9QiJqAHjAA1pnNy+IyF5oswZnkaRTw3geU6YrNBA9BARlXcWasTW/Nu3rncU/8JBj1CU7jjSIXqRjr1fzksT3WoxWj//pg5Sstl47glzGEOni1+uw/+/y6tJSIO7dSRCAM8NNVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060052; c=relaxed/simple;
	bh=ImyLRSldVokJNTwxQD8uL+Aad8g9eoYs7zgGRDjZ8Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRQLphcTBHvgIOI7d1n/akmfP6zuHOdYWs1ZeCakc6W8K84mjeb+Jx2HY/ZGDsnQvYWIEAlm15oQRRpDjyKKQn1+0TQByPeYbgtQTIQc7RcvcMzumJRCCZ4VT/X/gmW5NZdGnSUSaX+gWH+sCou+i/++5mUjCpaRUAobUCq79VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGtumTY5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b387483bbso960005f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763060049; x=1763664849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0za6nc+aCXQm8KF/y6TMG9+/t9XbwHnz+7+385lRJ0w=;
        b=WGtumTY5f+hp9Jl3OH7Dr9fDE3PVEL2vqCA5IFMUthmdMZ2vAzPHHqsd1JZjizwKFA
         rLWbMfuOOm/+XU84wemFDsiDbDGvXzgi8dzao4F1xQEcGo+yKLdXWOmQ7Z1dF3+WT6Sg
         v/Sz1xfR+nbHFtcSzfhr5vI0WG7pjkt0LMp/GR6DSj029wleELq6OasX49G0XN4cfhza
         OgCQFCS0CTgT1kW3PouAC40a84om8KE6fqtXEUNZPXZuru02BsByFPiyi/Xh2fNpzhGe
         JksTmgfTe2ahBOfOqYcP/ZNK8MRMivML32XeqKUaIq+W3sEspz6IXNWyg7g/yE3w7Tl5
         9K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060049; x=1763664849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0za6nc+aCXQm8KF/y6TMG9+/t9XbwHnz+7+385lRJ0w=;
        b=PTdwC7OK5Qgg7RBiXgo+S1Wu8f3zMyZycDWHspcoYmRh0ubJFRNGsQ2+AQrIvxS1Zd
         ltcQYputowCmwJ/sBICyrEIirhQqAgpNPdGb3U9ZFx/5wvJWnIVvDNgGTtJfbmYbn8mM
         aKZi15OxeGHSIWOO9LoMIiI/mIbgf/GnfQN8dxlZomTnX+C9Wjf8eLLYOrOqbk4IodgO
         I0mJcmkwvZaRhzq5PglZMz0ftvnTkIvzurt0jOGG0+/wv+I8S0Xui8j38mUjjFdClMmW
         o5+qJED+FPLcJLWE8WEyTrCw/xaH7yCCydC0hNiaKvqcL9vQwN1mduL+v4i2pZ0df6TC
         RHQw==
X-Forwarded-Encrypted: i=1; AJvYcCXpkVubFoABj8W9XSK3pyoHSZ9gbvS1UX1oP8Z/ZQNK5UgmfkjKclpTHclKvI9SoZ8Ua8gCBcihisItwAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JQRsTKpCr0SCxqPp7nIIxxq2tBHlzL58pMwzhtL6FzVHY4gi
	CIZmbusf/R2ERoLC1Xi9TdNxyFmQDAB3FrTguj2kF2wMqUKKi+8qtOErM+ux5ccoXhc9Td17j/u
	iXjIhVwnXvdGoV1W87ogM6DTFYS9dVkM=
X-Gm-Gg: ASbGncsolIZ1954e35kGHXVNAyEG5wHwahPTG0wOrMXnORqpghd5GdZK9+VyWV40ajC
	y3wR5RsKyVY7Jw/oJvisLRzW/k9i+rLDtSMuVQq6hrdTZkrr/bZB+5+3q50YgUlu7nyUsbFjRTA
	QjtE/tPvNLDB+r6Qnegf7FEqbfVjHobEJ06sTW0K+SAMoQ4Td5bm1VobZTDMNF3AdA0vtx4jUKn
	zSCqFDYM/qxOWZwYc5QmPpi8a8oOwvx5pHhZgs56IZaD5/RE9R8oCQNkXt49A==
X-Google-Smtp-Source: AGHT+IGTSBrTIDYDjncilT4tzbDR8Dtp04aGMzl96p2G9sbZioO58z/jxSqd5HKBnz20COtjN+8hMikzMSLxwBPwrho=
X-Received: by 2002:a05:6000:26c3:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42b59372315mr442629f8f.29.1763060048361; Thu, 13 Nov 2025
 10:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <de098757-2088-4b34-8a9a-407f9487991c@lunn.ch>
In-Reply-To: <de098757-2088-4b34-8a9a-407f9487991c@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 13 Nov 2025 18:53:41 +0000
X-Gm-Features: AWmQ_bmzRimk8gYF_4YjJuq9mGlvR6GBPwMMkQlI3Mtuob5q5ystweObvaU2JrE
Message-ID: <CA+V-a8vgJcJ+EsxSwQzQbprjqhxy-QS84=wE6co+D50wOOOweA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic:
 Add renesas,miic-phylink-active-low property
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Nov 12, 2025 at 8:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Nov 12, 2025 at 08:19:36PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add the boolean DT property `renesas,miic-phylink-active-low` to the RZ=
N1
> > MIIC binding schema. This property allows configuring the active level
> > of the PHY-link signals used by the Switch, EtherCAT, and SERCOS III
> > interfaces.
> >
> > The signal polarity is controlled by fields in the MIIC_PHYLINK registe=
r:
> >   - SWLNK[3:0]: configures the Switch interface link signal level
> >       0 - Active High
> >       1 - Active Low
> >   - CATLNK[6:4]: configures the EtherCAT interface link signal level
> >       0 - Active Low
> >       1 - Active High
> >   - S3LNK[9:8]: configures the SERCOS III interface link signal level
> >       0 - Active Low
> >       1 - Active High
> >
> > When the `renesas,miic-phylink-active-low` property is present, the
> > PHY-link signal is configured as active-low. When omitted, the signal
> > defaults to active-high.
>
> Sorry, but i asked in a previous version, what is phy-link? You still
> don't explain what this signal is. phylib/phylink tells you about the
> link state, if there is a link partner, what link speed has been
> negotiated, duplex, pause etc. What does this signal indicate?
>

                                   +----> Ethernet Switch -------->
GMAC (Synopsys IP)
                                    |
                                    |
MII Converter ----------+
                                    |
                                   +----> EtherCAT Slave Controller
                                   |
                                   |
                                   +----> SERCOS Controller

Each of these IPs has its own link status pin as an input to the SoC:

SWITCH_MII_LINK: Switch PHY link status input
S3_MII_LINKP: SERCOS III link status from PHY
CAT_MII_LINK: EtherCAT link status from PHY

The above architecture is for the RZ/N1 SoC. For RZ/T2H SoC we dont
have a SERCOS Controller. So in the case of RZ/T2H EVK the
SWITCH_MII_LINK status pin is connected to the LED1 of VSC8541 PHY.

The PHYLNK register [0] (section 10.2.5 page 763) allows control of
the active level of the link.
0: High active (Default)
1: Active Low

For example the SWITCH requires link-up to be reported to the switch
via the SWITCH_MII_LINK input pin.

[0] https://www.renesas.com/en/document/mah/rzn1d-group-rzn1s-group-rzn1l-g=
roup-users-manual-r-engine-and-ethernet-peripherals?r=3D1054561

Cheers,
Prabhakar

