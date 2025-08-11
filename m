Return-Path: <linux-kernel+bounces-763154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E44B210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B161318A0DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EA23E23C;
	Mon, 11 Aug 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhXavH8u"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96382E1C79;
	Mon, 11 Aug 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927367; cv=none; b=CeeUuQywlHO0yRpQ1t1QzIHxqA6AcqCRQzj7+BYtOdA36CHDSyJnB3c9s4zyYFVZqHgNaE4rWOcxTlGC7fZyrkYo+KHWCYhACvgKt+HXxQ2x1xJt4HB70imEWKZjK1K6IZIe+S8cI7Pu9K6yvhZrzj2E2oBfBdJy/4DYXhkpf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927367; c=relaxed/simple;
	bh=fFCqXuZALC29F1VK+Z1uQMuKiNuiwlcnkDjAG/yluWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4Cc9A95//2CrLwX4G5z4QHNosPh4lEHFFqBOQMRcMYK67lnYlCGLBddvH7AbJRVnQkM1V4kJ3Hm5loCOPLvDlwIHIzBhilwtmTunCBRfzNBIWUrBgKFEhJ2SuhrX5jO7NbGBM0wEk/BdHSj3n4WKv2ahrB8CdJ6v+IBzhrgVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhXavH8u; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so4196365b3a.0;
        Mon, 11 Aug 2025 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754927365; x=1755532165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvKRsb+2NxzrgJY6bF+aJhokFLuTBvZRFJZd69q97xY=;
        b=EhXavH8u/tcCCtYTB+/PmLoD/YAFreLDk0u/7jDfCULGyd/wpsnyLggC1EkwdbEAgr
         h2Hpce5oLT7ta3J91V9MlJWNfAwiAP2s+TPNXxPwURdNUwS0ze2L6ZOdlO64jKUmzmpJ
         4RE06f2H5QRsNDwlhMyTkrUy8c5G6ixuS2zRY2OGATQpSVzpLG+yRpx3C4kwlZJAMrAj
         qzxMwz8dXnwiBCFIF3iTXoqof7C7mVB1Pz5KBiRPImjKpXgmZyMBEmrl05YaZXhtR7Ex
         4hqql4JupSku/d7rGzF8MgZSG4x85fM5a4bGs7kOwdhjluqbuqMD8sRu5CRvgd8hJWQI
         iLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927365; x=1755532165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvKRsb+2NxzrgJY6bF+aJhokFLuTBvZRFJZd69q97xY=;
        b=KrgKlooFzd+e4M12eImKlXKOklzGy4UmbrVTfeeKUpIN8OUaqlCGI6rRoQ46k3txfh
         Q/JGh8EYeBjA9/OZjEeE3mEcI4TkSQL/kptHTpdrULaIbXNa3gIcCOGdo5TmeFy8jwrL
         Uav6G0T/rIUZkHyp1fnrPK/NU8LWYl0vsTzfWPSp6en3uEDZlmsgdlvBzOeX/XZ50sgW
         4PRouFoh63qOmOpJtdYDeulOHI3YzioLqW/LHEtzhGGBaMEd7fHSXkXvGWb7NozFmzJh
         5VgXqfSahZWJpLao0Wdr/Ea7+slJH/HBbssg8Fat/w8bPB1UVwlP3pLv+uu7tSFg6YRM
         BDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpm7H7O6a3XSOZw+JDNjxUJoj60P1aVs50i1bSM5bJOgtUEzfGo/tDj2YAKvVuiKumQ7MKavXwylMVQn0vrE0ClAMMFw==@vger.kernel.org, AJvYcCXWE/nMEzWoAj8L/OT5FTgY37FKURCUt1y+Gs8Wyyw4w9IfiG8psmLE/SQmHTctsilOi6b8vMRFh8RqVNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl22/WlIhJVzEMWgYJBoqOPUJwQuKDgjCZ6eAUghftzRovx+BN
	27SyCyUERzAyvdubxxCg4KFjmBypJ21K27kuwwW6JUWh/An/BHime81S
X-Gm-Gg: ASbGncscKx2b67YeTX9O5gmtjRE7WhIg9JFFmZQoClM/FeBDAo7JJE1sJiDmOp90mau
	5xgSghShdU4t6M4Kl50BM4uqW9v910gC3DgrufCpN6A/q632ztKk/lygckZjvxmkRnCM2JVkhxH
	SVgkAgXFOIWN4bW+l4GDo1HEVSQjSNB8Rs3YpbGD4jfJnAeHT+JLppUJi5sbE7mS5Hi9PrXn0qT
	J97R/0kPQ5a0WIBe48J798f3Z9NGJWahw/VJBdvfmkWsXt4pdtx+hh2otnqj7WBAJxxXyl/zuNe
	pyyIufchRC31y2IOE+yDsu6jZYmS5JDsa+bSyhxwutll+0QwsGN/KXiJ5pFKW0HHxSsH0NuEp/k
	kJYJwxBKq2taVujhd4kK4KrU=
X-Google-Smtp-Source: AGHT+IESHtzGMKtQgCr/tPJaExBT6n+PCzO6JVvlYm7iIsrvswZGZ4XLpeOkp/+bA/wEWgv0r2C2ew==
X-Received: by 2002:a05:6300:218d:b0:240:16ef:ec16 with SMTP id adf61e73a8af0-2405526f4cfmr24386696637.46.1754927364996;
        Mon, 11 Aug 2025 08:49:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b46c08d048esm3517619a12.4.2025.08.11.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:49:24 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:49:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, Peter Korsgaard <peter.korsgaard@barco.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoQE2CQv3nzaSqc@smile.fi.intel.com>

On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> > On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> > > On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > Otherwise LGTM as here it looks like we establish platform device ourselves and
> > > hence no need some additional magic Hans mentioned in the other series.
> > 
> > Not entirely like with the x86-android-tablets patches this
> > declares a software-node for the gpiochip:
> > 
> > static const struct software_node gpiochip_node = {
> > 	.name = DRIVER_NAME,
> > };
> > 
> > and registers that node, but nowhere does it actually
> > get assigned to the gpiochip.
> > 
> > This is going to need a line like this added to probe():
> > 
> > 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> > 
> > note the software_node_fwnode() call MUST be made after
> > registering the software-nodes (group).
> > 
> > Other then needing this single line things are indeed
> > much easier when the code containing the software
> > properties / nodes is the same code as which is
> > registering the gpiochip.
> 
> Ah, good point!

This is wrong though, the software node need not be attached to the
gpiochip (and I wonder if it is even safe to do so). It simply provides
a name by which gpiochip is looked up in swnode_get_gpio_device().

Thanks.

-- 
Dmitry

