Return-Path: <linux-kernel+bounces-815191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551ECB56109
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5830B1889B85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BE2ED15D;
	Sat, 13 Sep 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROOTANAu"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37932EC57B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768686; cv=none; b=FLqJh0IFDXMXfz7g4kLT7QeHJVBli7tPu3fcbhArnIYCoLx0L4QOalABijwmASaUuo3xq60GA1FnPaEuE/+YeRw/oFkOA1EsiWJBjA0B7oczTq5HruiPq+12rSnH7s77sO+rF0HJRA6H19sFNWgAb+tUSnx6O2RmacW3aMozt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768686; c=relaxed/simple;
	bh=b7tBpzh15qGN8uVwd9Pr+CjEOhF0/2vXJq5OskdvkFI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRzEYoXa1fyK5oORk//waYfAfCH+LoLfN/sireGb4QjXlmJ0w7Jmn1SJggc85LuVfXszbaYTezY1ge81PPfoCwyQHv6LIGyQHSwfj0Q8V+Q/iFg5fXw+RT8OHNu1k1UscCkyXrE9V7NEup4akJA/wzXD2YKQSLGvQkjfwdP2/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROOTANAu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ed646b656so19842145e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757768683; x=1758373483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn5g5etmrQRhW0GOll7653iUOWDP8XBcYnO++0L6iOw=;
        b=ROOTANAuPag/jlv1nGo0RpkMHmO2JTrBDg2Yrw87LzqGxDemmhmp+U5etJ17YVcPl1
         WxCTSa1CnoCQ9h5Y3ID4q+BkPhYPJHWrcj+elvYxZzSJ63kZ/XMjtbDDsAvmbhyKyoxv
         tgS5LtxbLRxKp0B0VKzCg4FTcTnXIrgFLINkSq7uc8DfkaXiOjh8EJZsq0vqyOmjNfS0
         RrcgpJ5Yae/3gol1jHciPc+CP/aPSRyqDTYlNzGfEq8tl+p0H5IrGeUGJ916r0Rw1IoI
         KQ4dHe5K8+mgsBcxZ1A0FMqox0nnqLd5xSjm1r+3ocpoTE+HUVItkSN+4g0V1heE87W6
         ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757768683; x=1758373483;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn5g5etmrQRhW0GOll7653iUOWDP8XBcYnO++0L6iOw=;
        b=PX5Yrx7K1zu8k4amWLthhOz8owtbTKlEVHKc4deY77kJKdQp3VmwWdmAHRVDwCXhCi
         hVQiUlH7mEuE6vVYypJWvwwTO41kaomwxM5NlD6/Ltvwd75rPPrJU7ctmP8/QFxy1S2T
         sXDxcqllJiubp7oDJhf06JQiVN/UO9umZ3hUi3U1jdvUOCws7CLGsS51LuxHhHsfAdYi
         L4uEeVEhnwjj9dmba0QQxne4gSBi1i3HkaP1WLXp2vFedXGOcxrGMT+8/Sn7Yx9jPKQY
         Bi/Z0O6ofu2R5hrIOsowHFzFxIa0rxlpTR33WfOslvxR+s3yDqd7cXUYzUIWwQCssQH9
         z1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNw4Zp9pd+4DbWpObZRLB/UtukOVUsWIT7knLxehSs4r0ESXw4tl12feaeQft1X/ZwmbdAejeIAZ4yAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOR8f84iOpNQdt1T3anbYtNQRMU4P2gNcftZ+64xF4ykLmnMji
	Pc6G4WFv223SIQDsg1I2Uemn1sqm8wE60WURaUpK2lWS++8DRNXlpe6C
X-Gm-Gg: ASbGnctHCVqMV1z6fdcG2r5odXr9rMvoccV9/Po5hG+/X9y+JeJX2/U2NAbUcAAFq1n
	qRT7PzJTOaHr6/eJBnOB6o53/LD/7luAw6cG1pxJmzReiDcaEEpXKnokTCtgGFZYdfbnhtI9MJM
	LMTOvPVxYo4J6etgs2FwgSuJfx99pmtFOJQsdBGnrF8S1WZZkk1rYC4rSmd5c7Y3y+zHp3znqMf
	oxv8UlXE0VCFKPCVGFpETU6nWuK1UH9Tn7QhEQxI1+yD1tAHJwEAiQNfHhgBNU3MzU9dI8zfFsn
	OwQhIEjGYBzpqyNiWN7FZX9Nan4yITlfdfTr0DucVEKwMhc6yOU/gg7I7D/PGz6rksIjKtUUcTK
	is8Nj/iIaAaq9JLK5lkQgkFLRTRa6S/HF81kcEevWoqHPMzDTrCh2bZw/Qzo97FLDEOG+WqHHrP
	qpbj8X
X-Google-Smtp-Source: AGHT+IH7bqCK1wDu540Yv6h59nRCAcKulg0ljt7g6L2IwpwzA60j/nsTl5Zjtr2oKtoo9w4/vWv6Gg==
X-Received: by 2002:a05:600c:a45:b0:45d:dd9c:4467 with SMTP id 5b1f17b1804b1-45f211ca33cmr60235475e9.7.1757768682776;
        Sat, 13 Sep 2025 06:04:42 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015784c3sm105911875e9.10.2025.09.13.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 06:04:42 -0700 (PDT)
Message-ID: <68c56bea.050a0220.a9dbf.b7c8@mx.google.com>
X-Google-Original-Message-ID: <aMVr6Hkskt5mPfFP@Ansuel-XPS.>
Date: Sat, 13 Sep 2025 15:04:40 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v17 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
 <20250911133929.30874-7-ansuelsmth@gmail.com>
 <20250913130137.GL224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913130137.GL224143@horms.kernel.org>

On Sat, Sep 13, 2025 at 02:01:37PM +0100, Simon Horman wrote:
> On Thu, Sep 11, 2025 at 03:39:21PM +0200, Christian Marangi wrote:
> > Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> > switch and a NVMEM provider.
> > 
> > Also make use of the mdio-regmap driver and register a regmap for each
> > internal PHY of the switch.
> > This is needed to handle the double usage of the PHYs as both PHY and
> > Switch accessor.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> ...
> 
> > diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> 
> ...
> 
> > +static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
> > +{
> > +	struct device_node *mdio_np;
> > +	int ret;
> > +
> > +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> > +	if (!mdio_np)
> > +		return -ENODEV;
> > +
> > +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> > +		ret = an8855_phy_register(dev, priv, phy_np);
> > +		if (ret)
> > +			break;
> > +	}
> 
> Hi Christian,
> 
> Maybe it cannot happen, but if the loop above iterates zero times,
> then ret will be used uninitialised below.
> 
> Flagged by Smatch.
>

Do you have hint of how to run smatch on this? Is there a simple arg to
make to enable this?

Anyway yes it goes against schema but it's possible somehow to have a
very broken DT node with no phy in it.

> > +
> > +	of_node_put(mdio_np);
> > +	return ret;
> > +}
> 
> ...

-- 
	Ansuel

