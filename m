Return-Path: <linux-kernel+bounces-827440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46DB91C53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2732A188CA81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2C2820A0;
	Mon, 22 Sep 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QOPfvEsM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655A274B50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552167; cv=none; b=iI4CSrH1kr3J9Tq6eSdGvDiX7LgwWoqrD2iJQ8/JHvZrkGcW+RA4SeFGYaOiJUotC3hc+1beGy8hmNs/CQ37zTVClXt5hWMrRb14UqFcwEPGbkol1GG2u9NmeKjXY+ayr+UN3o0tWXA2SmmR0npyoxByYT4CacJzfHWlCB0FkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552167; c=relaxed/simple;
	bh=cbgpVXooeJQoxtDkq+orZaKLHLZsU4tUaffVgtq1Mcc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1t2QLehnkJ4HBhX4Dz9p21sarqaGY+lzvBwpmkkTbWLXCC0xOzCqNYoQfEv9Fpn5uW+rksXXLhRUzJJ0o4P6XGbhws62OFPUGHaX8YpvwabZxorD0ZH+vC0+E4lBt4ULMZJhMOnkbUvNcAF6wldthpW6O+n0bIAiCOfHpl4N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QOPfvEsM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36a6a39752bso13563201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758552164; x=1759156964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbgpVXooeJQoxtDkq+orZaKLHLZsU4tUaffVgtq1Mcc=;
        b=QOPfvEsMMEXAemiKfxrmMO9uFUY2th96vvKPTOtvxV3ikdb1FmTLRwjoX6RFivconY
         PzG+pCtxzyOFf6sAWFAL1bCvAhVXdEOunLbTe4jq4ABp1PZaeOVgGrIkpbyS4XLfJFnM
         0MVNU4sVv5x8nltBGXfhfxal9mmCyZ3v13vt/pitpGzJO8EAWgwjAKakptw3mYq+tZ7V
         4idRp4EOMvgLCUuBGCfE9pQIflKYxXhO3LX8RwmmTwHBG7njzouZWsRxufMSHT14TzVX
         u/Qok1HhHFGrKRw1rXVJbdVdYiQ1aCPuBsREu5ilKCuCjd3AEHvbwQGn+L4v57f9G3sX
         3Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552164; x=1759156964;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbgpVXooeJQoxtDkq+orZaKLHLZsU4tUaffVgtq1Mcc=;
        b=cWox/OPEFxDzKYwyrGrQGLAS+Uco3iciovUSrm1lQA7/3a5UJUkpqm2goudRqfckt4
         VpALgfywmQXNITW9bBeFtE6Th53aD6P5fJ5lN59Kdl9YhecNy7UCVqbHp5F5oxGhg/Ks
         6G9JxrjexLRmZw35r8+1CaFVs35609zCIG0aD3FY4hsN3ggot+JtK4agAg4So7vAHwCK
         rpLff2MHN662oFJQRMIuHlnRMAQB6SF/qFTfD7StenBr4PwAkLBelPbZxPsuW4PmcuSf
         n8u67t6XAjCGhVL7e3stmXCS7QsoT+9hD4pr+699ll/d5ItC05+lCdod4KPM+KaFDG2l
         4SVA==
X-Forwarded-Encrypted: i=1; AJvYcCWynmi0azkFmjpRaWqdLaadjO7XHwCAOwtSkygwJF/l79xn6u4Ickd0kI6+qByzYVyCDNWgT94A5gdJWP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28yyIjvz+BEAeO+QCAtxZbBseK5+oYUpV8wLEQB/IxzGItoF9
	Q8Bn9iGxVTXhNjyCpDKsd+IBaIX5NYWubGMYZsxEhSXYaOhwLdYxZK7Pb5Iuvn13QEeQjS2iSF3
	R7j3g/zXyHduHOYdl7Am8okJgF+722/nvmPWAWSVgiA==
X-Gm-Gg: ASbGncswOo7VlT4JY6xS3/xBCtV7C77Vzd1sKQyEi19LMzhVdPPuUkxDOIU2SN2TNeQ
	s0VzUZze+o01OjWqHDRA2w8d0R6hnHHJKUbwIA6j8K3vgjV3iGp1XEPB2zexL4f/6riP1wy2Cjs
	JUmenvGQTeJzrnFaD4EjJFzEczkdw01BCHSmE2xo5MX43Oo3Ayj4mI46oY/9NSNw2Jup70TqW14
	kStCjCuVf4s5wNn/7mhq/36rP0fBEQ8CJCQHQ==
X-Google-Smtp-Source: AGHT+IHaE9nqceFLj+JInNghJEvz7NuUskN6MHfzPYyLxUjABx4E3I4QkTLcuqh8bctTyJSvA4j3CUuzt28CZtnMZP8=
X-Received: by 2002:a05:6512:2395:b0:57a:501:54ab with SMTP id
 2adb3069b0e04-57a05015577mr5016702e87.50.1758552164438; Mon, 22 Sep 2025
 07:42:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:42:43 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 07:42:43 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250922-i2c-mux-v1-5-28c94a610930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com> <20250922-i2c-mux-v1-5-28c94a610930@gmail.com>
Date: Mon, 22 Sep 2025 07:42:43 -0700
X-Gm-Features: AS18NWA6jseTsU1-el3RwI7NaUjcbCUkPeK98Ko-CDeIjcGra6Ar6whhs_lBYGo
Message-ID: <CAMRc=MdMMQxFfkMPHaUg9nMWuW9F1p+PT2i-ggcU5SSFKOVGKQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Michael Hennerich <michael.hennerich@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sep 2025 08:21:00 +0200, Marcus Folkesson
<marcus.folkesson@gmail.com> said:
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
>
> Stick to Hz.
>

This looks good but would you mind also changing the name of the field to
bus_freq_hz in order to leave zero change of misinterpreting it in the future?

Bartosz

