Return-Path: <linux-kernel+bounces-872907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38210C12940
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9DCC4F5850
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F91253351;
	Tue, 28 Oct 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVyto20f"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F58248166
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615857; cv=none; b=AFf7UQkvDpBubB/pVWLV/Nqbb9X9AzRb1RcrzeQ+W+IUkoEAndiVAZdXrmU0bnRNJsp0A01dNEkRKMFI+bob1Z6r4bXHevRADiyjjRal1p7l89qog8LtR9bDT5ZFmsU9N9P+qoeY24JonKUVaU30L/NXeaQw1corNZSIrSK9q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615857; c=relaxed/simple;
	bh=6OI1emRH6YDI+gn1qZLUSdFkdTMpkf3y/4hsnZ2wg50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEPyrGqy0/0pZmNlc8AU+dKQdHWo87kjpTjCVKb4GS2/AMnstnuhXwXukIO/tM9j/WLTKn/Xl4Jmqh2W0r58PDAbzX8AGUEBUv5puCkd0PXlGcUDBREOKFC48oh1ZSXHbUpw+96I6wj5ntG/fXfBWm2vtVv1ml34c5aKSs1l4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVyto20f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c82276592so114245966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761615852; x=1762220652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fuVJcJ3up+Cl+7OOOThez71Iipxn0vlF9LQWy19P8M=;
        b=HVyto20fwQc7JKZqPR5o9cn/cxVz21TNvXmO2EmmWpV+IIosbxgMTBGswrk/On1PJF
         tnyHe0JU6398lga/vIMhRtKOY3P9q4k8AX87KwZ9ugGbbuVPLMIF4vwvyDges8cCgQvZ
         ThiYhF0ecewl+gj7m7dVaHvafTOMDZqyyEAHyWzu5kGFi1gCEaMdAUG7smiaViverZAI
         S9ZT7/3p1b0zEFmF/WHSX1JOd/TeBId5IjbDM7apaxhXtIV2QE8rE7V8PK21SLqKZZot
         MzgtBOLZjzmT05C5Y/ds61U7a3ju0YbaypB6+wiEBuraKnUQ9CIm2lxucnJfXFxB5B8T
         5rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761615852; x=1762220652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fuVJcJ3up+Cl+7OOOThez71Iipxn0vlF9LQWy19P8M=;
        b=cGeZHNlQ1Ud7BP0dAveGOV6rzpBgwGBnKlzsLv6tE2SMznk6f8QtqkrRKpp1zCRL6o
         xJIu/doSwoAKDAfvFbURhsdk0QohFeQPfZg6GC9Um8qizopH8/0Z5K5B72kBYGGC2Zcf
         AodIkBiRrItIFo1q57ebp+jTqSKH0YQyX7yVHajm5mmfAQQQVjmfiWQhgXrmzRzW3aNh
         F2bg9OcBXwfI5hW7Q1tmO9w2xSqCB+D0mR2Wp6w5Xvi63ZpXvqc9HzMBjHGkN0WkCz+2
         lxYu8/dTlQliGoqlPg485jz8AsyYbnIhaXQTlL90eiOOptBqvMTcDUdp/V2p0hWry3zN
         W2/w==
X-Forwarded-Encrypted: i=1; AJvYcCVCsixHB7d/tr7HQBwY22Mjzvx5QSSDm+bbA8oAG0OH11Q4ojgWWVMwFhPmvZFHYggpP2b8IKOCC3Ap5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9aUWGdbEYaTWCdOfdWOaVk4ZVX58a5YSccYdIgBjl3pIMadg
	eGkTQ0bv/xSiUSILBy7ls8Qmc7gArs6inYahslhar8d4XLE/p0BuIBQo
X-Gm-Gg: ASbGnctJOKIGHB4dW0dIBVAoCPEqJJV/Za1ZqIMUDh6STCQ3H9WKLOzx6bAwMElo+nr
	uaCI/vEtJP/IZ+BghRP+cfx8bYN4XZX9qpyB0uEXC0Fc4ywq1QtA2L0zvtyztZOSr3eLs9vycSv
	ZiyeeOaO8ulEvC2cHmVHx/O7+XhX3D8pWVFCrFwxXBlrz2oEr1DgZjGxrlAeuEX2w2SC78MwIAy
	q/Obvmect16Gss6DWpWitvpkdUWoGxrTlyzmzO5XzL8NYXPFJoSQx4NK2a5fWxd+OmbafbS3AiO
	l6zejG6PJ2Radkwerfl4HHUuTo3Cgb3elTvmFiRf6c/NnQb8SOrqHY5waddwCl6hMalq14G2CPJ
	BMdbwk6tONirPXs/isTljDLpVQU0mOLaC8qgqgl+dSoGdsEVolajPLXdx2kMP8x9xmozUk2/nc6
	I0n9I=
X-Google-Smtp-Source: AGHT+IH49TQqSextVqYwy4pwgYt3UARDdD6p/S8FeGOqkGQ3uH9tGtPcW/IIc8ns2pRc0oji4CQ0Gw==
X-Received: by 2002:a17:907:3d46:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b6dba5ffb38mr124389466b.9.1761615852413;
        Mon, 27 Oct 2025 18:44:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm927773866b.44.2025.10.27.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 18:44:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Message-ID: <20251028014407.x5jrwpw6f5rsfi5f@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <869f4ea37de1c54b35eb92f1b8c55a022d125bd3.1761521845.git.daniel@makrotopia.org>
 <20251027233626.d6vzb45gwcfvvorh@skbuf>
 <aQAEyn08Q3DCedUU@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQAEyn08Q3DCedUU@makrotopia.org>

On Mon, Oct 27, 2025 at 11:48:26PM +0000, Daniel Golle wrote:
> On Tue, Oct 28, 2025 at 01:36:26AM +0200, Vladimir Oltean wrote:
> > On Sun, Oct 26, 2025 at 11:47:21PM +0000, Daniel Golle wrote:
> > > Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
> > > the RMII reference clock to be a clock output rather than an input if it
> > > is set.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > index 60a83093cd10..bf38ecc13f76 100644
> > > --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > > @@ -1442,6 +1442,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
> > >  		return;
> > >  	}
> > >  
> > > +	if (of_property_read_bool(dp->dn, "maxlinear,rmii-refclk-out") &&
> > > +	    !(miicfg & GSWIP_MII_CFG_MODE_RGMII))
> > > +		miicfg |= GSWIP_MII_CFG_RMII_CLK;
> > > +
> > 
> > What did you mean with the !(miicfg & GSWIP_MII_CFG_MODE_RGMII) test?
> > If the schema says "Only applicable for RMII mode.", what's the purpose
> > of this extra condition? For example, GSWIP_MII_CFG_MODE_GMII also has
> > the "GSWIP_MII_CFG_MODE_RGMII" bit (0x4) unset. Does this have any significance?
> 
> You are right, probably the best would be to test (if at all) that
> (miicfg == GSWIP_MII_CFG_MODE_RMIIM || miicfg ==
> GSWIP_MII_CFG_MODE_RMIIP) and only in this case allow setting the
> GSWIP_MII_CFG_RMII_CLK bit.
> 
> I forgot that there is older hardware which supports "full" MII, and MII
> MAC as well as MII PHY modes also shouldn't allow to set the
> GSWIP_MII_CFG_RMII_CLK bit to not end up with undefined behavior.

Yeah, actually you'd be looking at FIELD_GET(GSWIP_MII_CFG_MODE_MASK, miicfg)
rather than miicfg directly.

If the schema restricted "maxlinear,rmii-refclk-out" to be used only in
combination with phy-mode = "rmii" and "rev-rmii", in theory that should
be sufficient with no further driver checks. But some checks that at
least make sense don't seem to hurt.

