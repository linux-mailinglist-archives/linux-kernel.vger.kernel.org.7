Return-Path: <linux-kernel+bounces-737239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CBB0A9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F92FAA18A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84642E764B;
	Fri, 18 Jul 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibVC3nxR"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA22E7639;
	Fri, 18 Jul 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860300; cv=none; b=gU6AcH1dOuryqDAwq7iqIzgf5VYNGUpIZ8Y3IOQKggAluOatLapSgB9/9CKDE1ENHM2KarqC+GewVOU2kI0UBmNwzRiC2T1eZIDiY3qXcJcqNYPIow4L4tA7pSBD+B7I0JWY9Ed6T7xu6sfQChBBBY8y7Mt8ELOS/WXxq4yjhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860300; c=relaxed/simple;
	bh=BBrByI1Mib4r2lHIK2Xlx/roasq9l2jl/ntYEFcA3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDotqp2MbbhSWNygK7DPyO2jDB9G4PU19KGNBWxhf+qDDxbl9l9gbnKdN9kcSCYVUgTQN2u7R3K1/3Hsrz0+8C612K60TB368lyGTH/VQApxHYfGeg4+BsuNLvB1KVpvxHNBF3ZPn0oRbZ/n/UMmnDi1sTOhZhL7d9Rhv0+E3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibVC3nxR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso1916660a12.0;
        Fri, 18 Jul 2025 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752860298; x=1753465098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRxtHwjL+3PAWWyF1a/7oZRVkK0KVn9KJJvGvId1t8Y=;
        b=ibVC3nxRI8AmPGXJkCzDGuijVurFY03t82tLCTtt+nh1EgDTQ5io9JEYkp8vaQlajm
         R+K0AW1TyrBea7Ns7fH3ydD8nH+HUzJTDnyzeB2pBes5ADEKmzLVNgP634/pDL3axXSF
         0dXrUHnu/b/tVQusAUu44sR60leaNW5v3zEF6OABHUUV3LZAzOcxHjsfzZAnwHnM3own
         7RWGrE1AHhHhUH9x4d0TN3AfuSH2eY+REszZrusXHKeUmc4EgiINdmftUeG+39K3ebkM
         yo65z59AyL0ZcPOnScDYBC+HAgi0ettv6WZDEweelLzNTXI4QNw+tTuzYNOnPFvilF3W
         9ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752860298; x=1753465098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRxtHwjL+3PAWWyF1a/7oZRVkK0KVn9KJJvGvId1t8Y=;
        b=BT0fbU1lPxEnGxcjYF9EhGQ4TtQWi94do4NSYCdoSiKZrxlfsE3m9FaWtmoWH1mmXt
         JQ0AmJ59h1hHTgn4O9p0pvxO/kVoXqsjc3eH7CPM4TmYbStjzU2J5Xj/v5kflWHyHrM5
         OOxTuUddJRCACW2Tlj97uW+jpA6UjRZD5HKjYyOTGrC3dvT47Q+I5Vy1ZOGvx8zjJzPc
         gHmJWQmncYDrmjH2InS0urcvN6yGvr/NCrvkDAHp9jkK56nth/V1IXEQtXT2Di+vZxnT
         QR94vy4j3y6tKwrnNcqcnuEM3kNum5gdeU7s+G0hmdsg++GfZgyzAb0ecjVOJnXTnvU5
         PGmg==
X-Forwarded-Encrypted: i=1; AJvYcCUh7O2zlV8/HpX4tLqidKURT2KsCvM5KbntsEF4YsPghaGF8iy9rAQ5f1/jl1Zi7JDgTxPFCcFO+kJOZLgf@vger.kernel.org, AJvYcCWi8K2mlM/N09/PVpFCOCwCBRMYfMMRvhrKlkDQFVuCwL5/xfoI8mzZihBHTir+FxBDknbrrNp73BU=@vger.kernel.org, AJvYcCWnMnB9QDQ0i/rkJXPk/U6R0v8LmuQdbHd3Pe33gm2I/ELK1/Vt9CE/RLPybVmHxRuFHKm2j3wzGftYnKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzO/ofzSaSwVVD+hRwgJ1jAyjULXN4Fxzzxs+SajKTYZsE+vr
	XYajlj6CDsfn0uDhXluvjhD6uIFKkc8U1pyqqtX7RABRAhcZKtiMSPSM
X-Gm-Gg: ASbGncuwqlrsgrZ7N37vOMzeT17va+7xX/FyxqsQCeUoLDA/5e1oWlHIj1NdtgPcFQ2
	Gvjwi3DgSn6n1nUFK6pfGekPb+YWtd41TbriYjy5KT4GNrKnF1UqlzdambAV/WW/woNnh0fSVk1
	brDJFcgQLNyfONJCrJ0qNsJ0B4KsMDj0dgBQivrKWnLmhEoBSOarZLXkVGeBJQe9AAP/fLA6NHX
	5So1lEj1lPoWVxX3a46qHL8BF2rgJY0asiUkaK4Hh0p5krq2pou4C9U8vvg3lyW6SGH1RCJkH//
	srJU/B+JK2mdUWCjAiln5lEZWXXuyQkJFX1tMH1aGxdOw0yO637OkQdk3LKJcJqp3H4TSB3BP1p
	gKZvLuc+WUsJhvctY6cwCrc+5/8FyNbB7B2dpDeLsLUvmMA==
X-Google-Smtp-Source: AGHT+IG9jQJTtmQTkXncQ44ZMFFbqIjAxuSaimpVAcOwrGjlk1NlmL1dUL+MD/xaksVSZRO06M5YnQ==
X-Received: by 2002:a17:90b:2685:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c9f4b50d3mr17386475a91.29.1752860297736;
        Fri, 18 Jul 2025 10:38:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb5c5da0csm3228067a91.25.2025.07.18.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:38:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Jul 2025 10:38:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Sung-Chi Li <lschyi@google.com>
Subject: Re: [PATCH v6 2/2] hwmon: (cros_ec) register fans into thermal
 framework cooling devices
Message-ID: <357c26e4-8ec4-4d52-873f-300eb20aa356@roeck-us.net>
References: <20250718-cros_ec_fan-v6-0-8df018396b56@chromium.org>
 <20250718-cros_ec_fan-v6-2-8df018396b56@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718-cros_ec_fan-v6-2-8df018396b56@chromium.org>

On Fri, Jul 18, 2025 at 03:08:30PM +0800, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Register fans connected under EC as thermal cooling devices as well, so
> these fans can then work with the thermal framework.
> 
> During the driver probing phase, we will also try to register each fan
> as a thermal cooling device based on previous probe result (whether the
> there are fans connected on that channel, and whether EC supports fan
> control). The basic get max state, get current state, and set current
> state methods are then implemented as well.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Thanks,
Guenter

