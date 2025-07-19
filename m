Return-Path: <linux-kernel+bounces-737932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80332B0B211
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C641899495
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAE230BE5;
	Sat, 19 Jul 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szuodfbs"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CA148832;
	Sat, 19 Jul 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962395; cv=none; b=E9gVJhrZ3z7pqqkDu9+TuEePhLtju9v/kUe4zp7HS8F7ZVgilQqoITuLqJ3CfQC52BqYvn1hkftQzuvvrCF3TPCpIfXBmJlY6C82VrC0GI5tqLWfjFvEUTwohlnKCFIxrPhAyT6ajAQkEOP+soNZqxJ+s4jurfN0BNsd3HeS0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962395; c=relaxed/simple;
	bh=bevhsHl8l+DoOyS9L0Ugu9wtd5dWkZZaONJ4a6TWKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMDc8p0g7NA5xCBgMvdIBxeTVT5txpzUGE6x7sQ7FtP86XoRrgUG2oL/i+B/MTUDS1b4HT7UI+QmvGqFV969m13I2JTX0adOgosWUYWHgG42nkTwy+N2Slr1P1Pkk5ATtRjXs9WTS9iMR7/h3bIKcyNOXVkLuit9QU2ss8EXQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szuodfbs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2352400344aso29029685ad.2;
        Sat, 19 Jul 2025 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962393; x=1753567193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YChmhcAuQ6Yp2l/0qA4EPLqTylrmbaEWKg7bJnpyTvA=;
        b=SzuodfbsNvxIMNOb0qiv/R/ecCuXHApUA5q5uMtXj55yEvgNSulszjCHBKJGzi5280
         TfxkBTaPMcAQc8PTCEI5N0Td2kUTBiEAUNY9y98mrcNgTaAnh/bnhcmMpazIX3zcWis3
         6Gq48MRyKwMIkHa1Gy7UbpvzniQcObNeOOg71HkxraKzyqE0Zlnq46OTsrzxyyGOus0m
         LP8AmfeqwDxT7mfQGoIp3OgF4JdhFtcHpdkHirO6kEOgsK2xPsxDEJlRsSc19s9mz0eu
         myZy50UqqixzHHGAgDAAOW/5iCQthpULRSZ/Fu3Sj5hnZ5HRjfnJ0aoqUPf+3/Mdq+Nq
         aNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962393; x=1753567193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YChmhcAuQ6Yp2l/0qA4EPLqTylrmbaEWKg7bJnpyTvA=;
        b=shCmINmYRXoeNa+0lL7lrz/Eyp9w7dKcQbHNSB8s5NWGfjkGXJHRtzYBy+FCFNn9vl
         Ng1XqAAyBuUMyRfl3EXZPCWH3Nf6eoPnEBTfr/PlHUZC6XxyFLQIxLOPhcQ2N9UqEvy0
         OL5AzMlnoqg7aVvzAjjjw37OHXhmv7MSx2Hu7CF3EdGb8ofndUKN0yppYA5kXeLHp1/m
         a/26SpK1arWpHvXyrPEc+t+uVTzUaZbw8QK7LiYqGmnITvP65wFlz8K+mgp8SL6cLjN5
         mPh+7CMqd9Hk5GI6Cr/cnnv5gDDjt4rGrHSSMs05EXqXdSwDmr8/Bls06vyIoo/jmAo0
         V1tA==
X-Forwarded-Encrypted: i=1; AJvYcCVrPp8b1DEDwkOtO+vzbLgeM6ZicOSF+ah3wNQakNkc4bIJpFeNXKm2UOMntL6ducCfAyP31PykcciV@vger.kernel.org, AJvYcCWICRlnb5AhB2kF9FJLa7DWXEOQnhD8C/XSWIKTb5MPreVaI/MlUjHetV4w2sPcvQ7teIBI3UZeTjcxVdcp@vger.kernel.org, AJvYcCXusTJ9TN7RcQdGNRKfG4crxzxiildVY2+zhR6LdSIPJz3KDkbHkTJZH6pufu0a69G4teMmvMTh7j6skXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbhmYa0HkkIWVwJeXZZkbRPj0p8ftUwl6WEMibj2z6lydfQg8
	/KRZCzIw9BdXyiLw6SWXXmU6SqxMysdnwOlOZgO/e2DtDhpwzl+qoFyV
X-Gm-Gg: ASbGnctt0DzGmvsAnF6+grfTi67TGnSHfg8YDNV/34rVMfNt5izeyMjBNdv8IdGLtOz
	g47NKhFCTUAu9uJCRz8ALsTnnM3yv4fls+vfLD1+g20QimcJvpzqdYOYddqT+ndeO2wNNL1qUZ3
	Zk+9u9NOoZAIcT55GUzcWxWjUaW+mWh2fNnCvls/lGgT5G/+kbR/0FfwwP705Z76a29IJJjp1nG
	RBkhQ8iBQ8y242XB+LaIZSvH7H2drtMlA7dtXhQWRTP5MuW+Xcj9fnVnZRMDxXsW50OpGbj/3dX
	43eFKMqkD4cay+lPAEFd0xJcT0eF4sqtOx47UF0HbnVyAzVA0g9VSG/o3lm4EAkY0/RvdJvM8oo
	sYRN6ySanpMGRCB3Irh2vz4LavOaPOhoALvLCF4C3eJZ5Jw==
X-Google-Smtp-Source: AGHT+IETovopte449BYactpPjvYmFSiBBH8dWuzCI5ys3s27HhH/PRv/o5CpfCqxTo1tR8dBNm2R+w==
X-Received: by 2002:a17:903:19f0:b0:224:910:23f6 with SMTP id d9443c01a7336-23e24ff339bmr228893455ad.45.1752962393406;
        Sat, 19 Jul 2025 14:59:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b2bsm33364915ad.119.2025.07.19.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:59:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 19 Jul 2025 14:59:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] hwmon: ina238: Fix inconsistent whitespace
Message-ID: <fa03ce2c-59dd-428e-a31d-da320fdc5428@roeck-us.net>
References: <20250718-ina228-v2-0-227feb62f709@pengutronix.de>
 <20250718-ina228-v2-1-227feb62f709@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-ina228-v2-1-227feb62f709@pengutronix.de>

On Fri, Jul 18, 2025 at 04:12:48PM +0200, Jonas Rebmann wrote:
> Some purely cosmetic changes in ina238.c:
> 
>  - When aligning definitions, do so consistently with tab stop of 8.
>  - Use spaces instead of tabs around operators.
>  - Align wrapped lines.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Applied.

Thanks,
Guenter

