Return-Path: <linux-kernel+bounces-889928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22AC3EDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C00834C086
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B730F94B;
	Fri,  7 Nov 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGMGIgAd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573130F94D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502488; cv=none; b=dKR/eTlc7IR9IloHC1lUpnU7R9ki1ee4Y3EjsNdEeTsIASbiz61x6zm1J6340HHsnjfNAkeVDvaCkdMvA1fYQ0aiyQ1cFSQi0MbnW6/Rc7ArOLntb9jAsiu/BpOGD4AlkwUK4jxAJ+ttTNga0UagGQCN5huHI9aXunGHaofUatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502488; c=relaxed/simple;
	bh=RcXBtDck6KBjcXruX7jv8Jnj3yRxU66tLdV0Hp8iIIY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNRpyNKrvs9ZbZkH/fkypRofB/K83umNxeXueybwwQ6RYEDVqeYuzR56yxSVer/0TeuLbSJFUNQhaHruVRYJquthJdtl2x3PISeC1Ld/4XnUXW92Z9w30tnQmsUXruFO6uOXPTQfqchVgCpYadWfiJx3b3ac90PfFkujYs8ojws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGMGIgAd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c48e05aeso240314f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502485; x=1763107285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XH3e0FMtRqniqAC/JVU+RFDrXdAf6djMDK3MFCP8upM=;
        b=LGMGIgAdqEe/xgGjf4+4aFrX2Otxab790NzNIU3aB73BZYGwyTIKiMkGkSe8NjLAwJ
         hq4BdUFZJ8Ii+OIPfcLpJuM4CP+TxQrU/oXneA68QbTbzgQ1CPJF2gBDDaG6MXvMulPi
         RYfmroIvWArXTU+3Y36I5oLrK5SdS3Bn5t67G6AoXk0TuPLl84GwYJZBAVYtf9S5QfRB
         TcmotlvuWZlf7RW19sGq6NSsSgaKuzo1kztPjaWqz7Y0S/JJN8BoS4tth6bmGG+o9hGz
         D/KM5Of8WaEoYiCZLu9uCfHcQQVaM8SL7EWJTkbSWcU3BeK7BKYGvseWV+dLQvq4zQMu
         Feow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502485; x=1763107285;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH3e0FMtRqniqAC/JVU+RFDrXdAf6djMDK3MFCP8upM=;
        b=XbgdHxeX7fyr9Wmswdo9KnZtji1cdXRwXu7u5ZL0MIcDaOwEyhFC90wKYKr/8jCoHE
         343HI0tEyWPO1JEJBeMLRxVTqPV6Tuw7tfsiEJKxc8SXESXvl1zVpItLED/yViKiZP50
         xp/FFTHrK6w/OEVy83rmt2mTKLFis9d+3GBIiIRe/2OOURw0GV2tGoNQcqO5nF4mCAPy
         icVcOOP6PEeV1s2a8A+UVN1QTZKbC/7x9HFh5k/VaUp9Q1iGRzdt2XH8lZWKx0anrpZn
         NpgJn22an9SkF9KmaFesfvDmAFjrPC+rnSieQ9ShqjZ1qofxC9I+uFY67/hFlNnsFppz
         lIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU08HU+4B0NvZDYvxChuH/ZkyR2xy3m5+UszOg0zaFAXnE0P/kz6ifQY6pCJrPxBwiepE9mdctEn2APYug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJXkxpz9Og0tboNdSK/HcgdCO0x02Bs+/GUpmZ+Sbi2p5bkBH
	bsSewYE9h+W8zMRPC9u5p8v1qNv5dgeAK08Z5lqaE0lxO/4F24bhBWPq
X-Gm-Gg: ASbGnctZzdmAhPZiCUUiZqGsQTMnn72Gu/x1XLwDu/DvvT/0m7G9v/MIdoR75qri6Nv
	4ZcFdECU8sbBmQJX3csQdR6S57/G+PYQoJ8sxGFEXz51ue3Kn71pDRUx2eRY/pUI1HEFGqUgoXv
	o6hrbiy7ZteUAAQ5VbOeZOQXRzXJACuCLpFHoq8NdYKvsrgmnfsRHpR28j3IDtj9+1XEVHhmVxM
	KqXjoT8UNpqLrLSHEVTd4TtAZqdUFbHlgb1sAlK7nhr4vdtLkHwNmV2NXxR1nwJR5BpHFKGIls0
	EhDcxY+661Oul6LhAbgX+myJQVl2R1ThZNuFVqk1jMYQQLuM79/EH7oNDq21tDsZYa6dBDCVq2L
	haNgNB8atdttl4U9a2afZfUYUNhj6I8OzL86G7hO5ktE2qfS70WicvxBr4JQtEGXjigJolWbPpv
	46DEOpnTtiZ8z4U4hccvrlnZNalCvph6kUr4HIRTQ=
X-Google-Smtp-Source: AGHT+IGjhguXVafyIF03qGRod41P+M5CzC6bL9w38i5cp56iczkE/ksJNNNmhdEHALvIdVe6z6XaRQ==
X-Received: by 2002:a05:6000:2c04:b0:429:cf03:8b2e with SMTP id ffacd0b85a97d-42b26f82e39mr638126f8f.13.1762502485388;
        Fri, 07 Nov 2025 00:01:25 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b1e3sm3742116f8f.4.2025.11.07.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:01:25 -0800 (PST)
Message-ID: <690da755.df0a0220.2a944.8896@mx.google.com>
X-Google-Original-Message-ID: <aQ2nU_UVY2fdSrRA@Ansuel-XPS.>
Date: Fri, 7 Nov 2025 09:01:23 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] clk: en7523: add support for Airoha AN7583 clock
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
 <20251106195935.1767696-6-ansuelsmth@gmail.com>
 <20251107-dramatic-puzzling-cockle-cb9781@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-dramatic-puzzling-cockle-cb9781@kuoka>

On Fri, Nov 07, 2025 at 08:44:14AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 06, 2025 at 08:59:32PM +0100, Christian Marangi wrote:
> > +
> > +static int an7583_clk_hw_init(struct platform_device *pdev,
> > +			      const struct en_clk_soc_data *soc_data,
> > +			      struct clk_hw_onecell_data *clk_data)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct regmap *map, *clk_map;
> > +	void __iomem *base;
> > +	int err;
> > +
> > +	map = syscon_regmap_lookup_by_phandle(dev->of_node, "airoha,chip-scu");
> 
> NAK, undocumented ABI.
> 
> We talked about this last time and you just ignored entire discussion.
> Nothing in the changelog explains why this stayed, why our discussion
> was resolved like this.
> 
> I already complained about very poor changelog and lack of lore links
> and this just adds on top of it.
> 
>

Hi Krzysztof,

profoundly sorry for this, the old patch slipped in for this commit and
I already have the new revision ready.

This will change following how it's done with an7581 that doesn't use
this airoha-chip.

	map = syscon_regmap_lookup_by_compatible("airoha,an7583-chip-scu");
	if (IS_ERR(map))
		return PTR_ERR(map);

After better analyzing the structure is almost the same of an7581 with
only the thermal a bit different.

I hope this clarify the concern we had long time ago, not trying to
ignore stuff, just trying to respin and make progress.

-- 
	Ansuel

