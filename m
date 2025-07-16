Return-Path: <linux-kernel+bounces-733762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D61B078A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885C73B8AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD12F5334;
	Wed, 16 Jul 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH7sqO4v"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E326E6EC;
	Wed, 16 Jul 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677541; cv=none; b=Ng1pojmm9fgqvetxM8fGsG0VILRtl483MEjtt8K3oxk8gOyHfsfCKJjTeZ0qgHI/mw7duOkIK8A+FH8BRBNUwFsnyC++Bmvw5Ov/l8/QFrOY+yQolCZbL0QVsOeJLWUDqeNEh8XhCh0g3pjCIZxNPjsDTq/ZgXMn8HCRHKse1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677541; c=relaxed/simple;
	bh=00t3f5fFpc0TcNGhJsGnbORylIqmc4eZX3Z3+T+rvaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7bbBFBi7TwLEKduLi4dzgy2yaCDXhJFp11bpoScsQyZv2aC5+wN9DhDjoBgbu56+Gll3XymoVy10KOYD08nsyFtmV6xeESoVazbVh8O/z3v+96FDDhfQghJo6JyKS7AlEoGYU9fjJldGqpZjCkfxPq7yTFg68+xwkFLlKjR+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH7sqO4v; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so6681206a12.3;
        Wed, 16 Jul 2025 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677538; x=1753282338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEn/yNAcCZyIEV3FDNWtqBgyQzfyrvjBlDe3jR1D9o0=;
        b=gH7sqO4v6www1tppka5qVRVdN9sY5yjXqOyRmolxuRKD01qXXt50nf8zIq5HI1MnLD
         SnYWMROfHcZKYtnsHHW3u9O5BtxohJeJZrNAaRUVf/+IxFpUKQVWWVdbMkOQ69dX2yG3
         s1+cKNHmY4P70QYK7P81xJVwOf6/RCNyUiPn9j+iwr86yt3XNnrXWp2MCvNz66izEriI
         cjw7CjAlMHTKfeGrjJxyN2kEAO/LUZ0kNIW7IDjrgA9dDJ0iVGrllLcIkWLkpQetVtYR
         jhglMZ7IZ9C3lg9+8wiXnYyQDtRMSWWFyEiV+QBOL9Cxn3PDsok3heZhmL1Q7RcaPgjz
         qAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677538; x=1753282338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEn/yNAcCZyIEV3FDNWtqBgyQzfyrvjBlDe3jR1D9o0=;
        b=TEAd7CsuN/AcEdzlGsxi/5mWpSR49Z4spCGIhnblJf1uyYAmJTRtJbuuWu8+u3rq5Y
         V5gckvR/Z0hysf14zEy2+2Z/Kahshp/J6u4MPq9vIiMSpqGDhlWvKZhVd3VD0cv/HkDT
         cjhv5Rms05oDxjFxg2x50so2lX0w1q2MxnOLzhzxxbsUUsTryjdJdQsBS6xwI02Y3AHX
         e/cDDdU4xUhmvenXRTXNophf93eokcwcnkUqCPK3gWuAyh3WhdzksskifW+vnNYC5GbA
         /KJicdPRzuG4RcfbP+w5MAiXGNobPcZPznzRr9hzDMJybKiN09HrnFa9BmBKQbUG/j1i
         A+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVBpwe6qsXc5Yhb0hnyOfSdn/XScA6yBerKU9RiesaaedMJJVitgLsqS3H8X+NgOdYReQVyag45Pas+@vger.kernel.org, AJvYcCVDo3n3E61M9UGxrpM4EyguYOYpFM7Tk61nkHlJvgs5lE6+wUHos9ZGzLtgh6x+4vPtqYBedEcKS2ta@vger.kernel.org, AJvYcCVyTYswlN+FG3nGKpBrtgVmPSiY+RJbbzcUhDNFa6YpI5jyZCGs2P6W9aTMh84u+cmFb3CO6QMzYGLEEN4=@vger.kernel.org, AJvYcCWPbrW2JVJppT4J/78hna1Q4xG+VH1ADv7mzwUyBnnIyEUYHIhR3R1rE02v/v2OUm5/1h4i1KefIUrmpLUz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76MttVihhGqPnkzCMk4cJshlKV+iqoRj65aGRWIcZqK1apMBY
	ZcqhIJShkrBeHLHMV3s6V7mVLumuPlhS2Z+Abfi0z7ZwlHIdL7xcYQ4c
X-Gm-Gg: ASbGncu/FE8AX6wSbqIIxO8mS5QVTOj/4hYqiFwHcBJX/FlALz48eXSMnHVD5WlEYXC
	l7bqyHB8APfteez2fyNSiZx2n/KpY8Vb4gpoHisOV8g56ZNpWXI6d+AgNChNBDaDby4umVJbI+v
	mUGSHJQrOdIQMS+cJvRSv+dYvdDXJJRjup3APjoA760Y+nkKes9d8CesXE1/KjDlAFEomUPsZ/B
	pBZxSgbIy1IOGahnLYqKA824/E+WA4pvN4EY/FJPGLArz8eQi4Tmi5dAiLrRNv/Dd8OUzxy4uM3
	JSO1FU31lplIILgxILQlvh4VxFuzLdYYvqdtkluvbClJlRVihLAwXb/tPgm2pvCmWlD57aI+LYx
	l0FVM8YAT1sQocgawd7xfhwf4vC4zZhm53V4=
X-Google-Smtp-Source: AGHT+IEvTyYKIFNFKtos+Q7xGTJwGDjkxtH9YEdOcir9X6sczH/cSaEvxgJwhnxHV55E/V1jFMVXTQ==
X-Received: by 2002:a17:90b:5485:b0:311:b0ec:135b with SMTP id 98e67ed59e1d1-31c9f47c799mr4299236a91.24.1752677537737;
        Wed, 16 Jul 2025 07:52:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e83d7sm1552211a91.20.2025.07.16.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:52:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:52:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Radu Sabau <radu.sabau@analog.com>,
	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: (pmbus/adp1050): Add adp1051,
 adp1055 and ltp8800
Message-ID: <0d6d9830-ab41-4f21-99aa-2595ebc4c499@roeck-us.net>
References: <20250709-adp1051-v5-0-539254692252@analog.com>
 <20250709-adp1051-v5-1-539254692252@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-adp1051-v5-1-539254692252@analog.com>

On Wed, Jul 09, 2025 at 01:43:25PM +0800, Cedric Encarnacion wrote:
> Add support for adp1051, adp1055, and ltp8800.
>     ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
>     ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
>     LTP8800-1A/-2/-4A: 150A/135A/200A DC/DC µModule Regulator
> 
> Co-developed-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

