Return-Path: <linux-kernel+bounces-786719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F1B364F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E07A7E61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80D1ACEDA;
	Tue, 26 Aug 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5FDo8Ic"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A032264B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215779; cv=none; b=cfPFSIDAcG1x9Ll4gUa44CDCAKBwXsHkppS5eHPiawFGWe47+1mebNa8K+dJbvO7b363psA3mOtEo2z6c2cY/q1cFteV0gORRji/0AA3ES1YWI6FJFZxqM97UQTkCR01KrOZEV6FUl25wrexIQCGmK/cDYWarpnfK3rLvEOJeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215779; c=relaxed/simple;
	bh=IMNmI65FVUCbqdK9+JcQuv1rtH/SRuBK0q4ZgqSMeEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=phc4AlIQW9nU2X9kSskYg+i8UFlZQHserN5F1NdowhUrk1BwPlTK9DTAvz21iDqtfrsI56LRGqUQ9Jl0FO2Krtm+qyzJQtXnV/qqfvlT6IULeZpyLqenkQcyXKnCE82PlJK2KQHMgXTX/aXIbaxqiDDQEKx7leA8SLzNcvRayE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5FDo8Ic; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61c13125417so539761eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756215776; x=1756820576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCSAaSZeoixOuMj1nuyEP4c108bz3Jb04yCTbdf3I2k=;
        b=P5FDo8IcsRn2a8V/Kme9fyG/EKymZKLzBQmdtMYb2itTY7DKOlOkZ96w3+obLG+UK+
         dhPmhgHPSoeNRR3AkVVuE9FkwX/WrbXKcsVvxdbT8n5jrUuEx0rRx1fMHd5c4FUlAJoC
         IZI9zaKCQtX/VXVZtkfsuhPtHj/FemaLx8V5Vmf6YwZ6lwrIaT9Z18VzedY+ZMgO3bnh
         aQ3xAsznGqlAG+xhpEqRgSPGLULLl2O/3IwaGmCyykm9nZYySeCt+hX563WvgAOeu2gX
         71g4whmzHpjZJ7OTqXP7g7h44BLObuuAt3c2sj1EA58mQZ9ZTixlDet8+AC+Hl/llM4/
         k62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215776; x=1756820576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCSAaSZeoixOuMj1nuyEP4c108bz3Jb04yCTbdf3I2k=;
        b=S4mlrBcK9Nicxdxr+TyLsuJyy6xYtbqRo6geOyUQ4xeN22xwor9bKKzXlwjG7Jp3P8
         bHGqZnKzKyRlf1Axx3tUdzJ5Ky/W52C5x4iGleu7PNXo4Ayxbi/o1Kzuek1FFJK/0Kll
         2HRh8UTZIOAelYraRzSk09XlitReX4ltSsK+YXR7xxs2q5iSTjm6u2oaHSt1VxejgrKn
         d8L42YEn2br4CFN/x9wBOUVaskXAQzh5i7Ly5bc4RnKWPVJE/ysV61wrhaj/6p7mqhsf
         ewzCyFuxNVBjBOLoY1K13Fns426ce0aNscW08MraYFWJvlEp98G3dgcDH9USeqQB1GAv
         pk0w==
X-Forwarded-Encrypted: i=1; AJvYcCXYBRjgAdarbMg/JWVb0iYj+akyiPln1AMKogBHnJZT5mxwtLkTHJlPZ6TojvqISvZqakPdZ0OZscQp9kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJda++SoQ3ErZjBaG40tjoEVB5jcUA2I0fKharBQSAbjbwMRF/
	pNSAJR1xyKPs3IENiMsbjM+m/RNJP0UmQ68RjOGW80QLyD3BgbGtLZZJR0xqVc9DnvE=
X-Gm-Gg: ASbGncs4QP8HawpqbUMlFs1KEtMAEy6zvXuS5t2UIy3hECgu//SNIa6OJNo8SlXRNK6
	vw22qzw+3JveudxC5jDIxuI3QIEcoi+yotYuFZ6lWWJbLCiCOpSa2EC5PZQUbGOyempV+q9oxqe
	hO73IBkzX31IfHrGyIlAMCQOs4gHvYNAR0dv5vJRgUjGu8+wSPMrL+Hjw3PkvS6OJ6v8BPU6TYl
	RNhidedLsEUEk/5r/zlRdExZW8pTkecqf1V24i/5HhxgX3Vy42c97q06Pv8nCMsP/SzIar4iIaG
	cLYlyXQBlrkv84uzZxW70YhX/REaAl3B2FK1qFyRw3JMgcaK8Emv+DxuH4qTH8m8GKQm+uESJlm
	GYl/jU91+jQFxq1RGFZKxtsQRtsKr5efU/zj4Mnbz3INjsYhQS3zlU3J+JwKGlUKrgPE2bZl4sC
	M=
X-Google-Smtp-Source: AGHT+IH6oPmZUM4auc6eQuClGqcGHr3sDngRnQiYwGTgC1rN0Xhp7/AEI77Wl05/zubuIG3oVUhsMw==
X-Received: by 2002:a05:6870:7056:20b0:315:26b8:8ee4 with SMTP id 586e51a60fabf-31526b894a3mr2347972fac.8.1756215775994;
        Tue, 26 Aug 2025 06:42:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5075:40f3:ff25:c24c? ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e4bcecbsm2335437a34.45.2025.08.26.06.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:42:55 -0700 (PDT)
Message-ID: <d6716d57-ed8b-4dcc-b16b-2528780a387c@baylibre.com>
Date: Tue, 26 Aug 2025 08:42:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: use int instead of u32 to store error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826101825.248167-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250826101825.248167-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 5:18 AM, Qianfeng Rong wrote:
> Use int instead of unsigned int for 'ret' variable to store negative error
> codes returned by ad5421_write_unlocked() and ad5360_write_unlocked().
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


