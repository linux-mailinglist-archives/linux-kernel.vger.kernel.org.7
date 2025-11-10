Return-Path: <linux-kernel+bounces-892777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA866C45C86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F03AA29C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4672FF16C;
	Mon, 10 Nov 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CU4X2lut"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE8234964
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768744; cv=none; b=k6vATp7ZaElN7nx7sZ9UFJ6AApI5dEx/BTkrOjeXzWsAprbIoFK4oBvz1AW47LnC//VceGNN84bBgDez47tmfT+s7z5+JVgS8nJ4oo9woRlv9vJkhMplBdvmQNOpQiy7Jun8iST4cUXB0WRoyrGjSGWZm6JWrncCa3e4hYxDOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768744; c=relaxed/simple;
	bh=Ldxb3xiosslpoOJubQchwtbD2Q0t8Tiz2RiN7Ya71NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpV/j4d7qEij7fI406kbmP/wJ0Bdc04dJf4yPqEl8UYaqgjDEArGPzqez4JDcxBD3nwUb4ykWFv3kiUBSW03JnYXQQ3NsdjdFLyLzJ7TFzRgbjYHAXdYJUU8TCukifQ8u4FdVfx+yjYKyo6zWhqSFHbZ7NF/Dcw0CHZM1kUtYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CU4X2lut; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1125842f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762768741; x=1763373541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKdtCn/XoTBMU0W91zbNyyVRdCbCwPGBIxEuE5k5q+8=;
        b=CU4X2lutMaoMp7050vNzWAMZ+EMXpJt11Kci27RsnTIl2yDssByHkBj8jMTgXdJ7dc
         Pi35qWLiOt36vrj4uZGBBRCDvasuLEpJqHQYRoGN+WkhCWagOO2/EvZc/TZy6zBEUOgU
         dOseGOeC5P200rjflSAm7dyWMNiR3jRjYfiiWLOcLf+KqSiURh+hOB8DP587ztAzqgxp
         WpJTeth0Ay0n7WnKSLb2/E9qPQYUEwlNgsGqcDlx4kfd5jfN7zcl212Is8Rz2OSvigRG
         zcAZwSUMNe/W4U8Mj/XLqoLjmUpYRk9LIfSLo9jagpd8NsIexgbap3qnq30iXiB0tUdu
         ZqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768741; x=1763373541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKdtCn/XoTBMU0W91zbNyyVRdCbCwPGBIxEuE5k5q+8=;
        b=CCjqtvo6muHifH92qnUTqUIjP21dbyVh/MgFWXWK5beXZ1l1N9EabgTTNeH9oBH2KB
         GfrD+F3Zdq1hHgAchjjKVS47AM608/cr/3fA1mVFbVV8Eb5wQWbAx0k8KQe/y0tt8rZo
         SS4l86SZA7JDoRWDbDoh41ni1AxzFw/lb3yHUcnkH6igE/JJG4fHVZB0rG0euDNmUgIW
         LXKiGiUAQ0obAXzwkeU0Rh+xv8vnq3rcKncksmVHabBKDDdlRP7l6lihfzUp+SeOxsUH
         3gKDn5vHgTICmaoW0+F+x6czSMd7XW3eNe0t18PSilIE6Jk06XzwkpyunmPGCV63QGXV
         vZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKGwLWuZuhYzR2Fk+G2qIdPG5KXAL9drucA3/WdB6AS2LsTyPCF8dbjMIY05nccVa4i3tYQsBnq+GAM3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnrWpgVv5J8rcUflKNKV0U6bOZ2ohO8XczM57VgQ504m/sBwL
	iPTcY8ffEYth3iXiV6+8djIqp8s2aarYAcWNq6UosE6xidxOzdx7sEW0KGWWYjVL61k=
X-Gm-Gg: ASbGncsR8Ji/oQxWLLDIO6WiKn/3ZdogN+1tfLl82hhaQeEhAMf6oqfol8yfec9tPMa
	3H8gUkMnXRELonAG6WkSdkKZ96jni+taL23+pAphCLnzKNdRrf5aTo2NolaZgrD2tEheUa9TDsl
	rmRKhNBPLCKW0A8iU50n3WkeL5DrMfo7ZMwihwzcyEV4/UsT0SGkwuX4VqtDlD439idoWAPm1N9
	DVdDXISj7CS7Vl7zJi28fN0HouyIPGYKGDlDlA5SJ2vn35YYTblnmzF6hqd7M6urMaZp5YpB3PF
	hP6Wrz5PAk8KMIcFavgyT0wELOzT8Udwf9gG0fGBLTfaWE5mTietR/s9b765k63waJE6c3sAH/W
	ADennrIWo3pgC4xoXnBt1KKO0DHtlGRTodb6X3p0qUc6XLcfmtrLnW7HIHQys9SPKziG8H2zk2o
	1yZM2c5oTXRu5viwPOQR1hCPzvxJZMDmJpEOYaAC0ePWBqS6IgTp+9zOc07BY=
X-Google-Smtp-Source: AGHT+IESDCHlcbXRXRa2TG5aApGtSH2moJB6JVIAkSw02ybwWPI2qmXCnmEZcdOIcRiKJ320ee1qvg==
X-Received: by 2002:a5d:5885:0:b0:429:d19f:d959 with SMTP id ffacd0b85a97d-42b2dc1ab24mr7071023f8f.15.1762768740534;
        Mon, 10 Nov 2025 01:59:00 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm9799000f8f.45.2025.11.10.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:58:59 -0800 (PST)
Date: Mon, 10 Nov 2025 10:01:11 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlight
Message-ID: <aRG359gIeP48V2ZZ@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
 <aQ4a2SBDldYgQb56@aspen.lan>
 <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>

On Mon, Nov 10, 2025 at 09:40:07AM +0100, Maud Spierings wrote:
> On 11/7/25 17:14, Daniel Thompson wrote:
> > On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> > > +/**
> > > + * @brief control the brightness with i2c registers
> > > + *
> > > + * @param regmap trivial
> > > + * @param brt brightness
> > > + * @return int
> > > + */
> > > +static int max25014_register_control(struct regmap *regmap, uint32_t brt)
> >
> > This isn't a good name for a function. It doesn't really say what it
> > does. Please find a more descriptive name.
>
> Having a lot of difficulties find a succinct name that fits better,
> max25014_register_brightness_control()?
> max25014_i2c_brightness_control()?

I'd focus on what it does rather than how it does it meaning something
like max25014_update_brightness() would work.

However, at present, this code is only called from
max25014_update_status() so the simplest thing to do is to move the
code into max25014_update_status() and remove this function entirely
(then it doesn't matter what it is called ;-) ).


> > > +/*
> > > + * 1. disable unused strings
> > > + * 2. set dim mode
> > > + * 3. set initial brightness
> >
> > How does this code set the initial brightness? It doens't set the
> > MAX25014_TON* registers.
>
> Yep forgot to remove that, I discovered the backlight core takes care of the
> default brightness, so I removed it from here.

What do you mean by this? Are you sure you aren't relying on another
driver to enable the backlight rather than the backlight core?

> > > + * 4. set setting register
> > > + * 5. enable the backlight
> > > + */
> > > +static int max25014_configure(struct max25014 *maxim)


> > > +static int max25014_probe(struct i2c_client *cl)
> > > <snip>
> > > +
> > > +	/* Enable can be tied to vin rail wait if either is available */
> > > +	if (maxim->enable || maxim->vin) {
> > > +		/* Datasheet Electrical Characteristics tSTARTUP 2ms */
> > > +		usleep_range(2000, 2500);
> > > +	}
> >
> > If you really want to keep the devm_regulator_get_optional() I guess
> > maybe you could persuade me it's need to avoid this sleep... although
> > I'd be fairly happy to remove the NULL checks here too!
>
> Just wait unconditionally?

If you think it will be unusual for the driver to be used without enable
or regulator then it's ok to wait unconditionally (all examples you
have added so far have an enable pin).


Daniel.

