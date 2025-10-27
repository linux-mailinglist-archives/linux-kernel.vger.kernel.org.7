Return-Path: <linux-kernel+bounces-871907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E41C0ECD7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 890C24FBC90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FDE308F36;
	Mon, 27 Oct 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X/36PQcf"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974E2D239B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577155; cv=none; b=RexJOSKBhXAoSBmw2kL9kbsdbSb02m9PV7JxM1+urp21IyYk/O8WbSAD/QNtmtbhcZfsWmtWQXfFKmNhWsuuEbf4YuDzXeTNZIOih5YvwBNjd+ikhVw6QFrHA36hbjPv3g3iWx3Czl2jOGbiw1z3UP9otRTbXgHm6//a5N9v4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577155; c=relaxed/simple;
	bh=7wL4+1onpcS68N8zd7qV0fUv0eIqqqeHEAHM6Nw9pSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/RGxqbuYW8Xaa+6nqq65e9sx62/WqNNfgRcMC3YvPRhXeK4QgAU67czLU/XG1KkrD5DkZJiCJOlA28zIkDr91SGwCxoFZKwTuDAxytsLqmMlog0YpMgrjMP3PagoXE0TVtxASJCObnbE0+EJ1eT5F6PW0YCpc8mMKwNhP3dnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X/36PQcf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d275090417so1375204fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761577152; x=1762181952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42PPEESTPRM1MqRXwgq0RfVuUgixMW7zVQ9CGj4vqjk=;
        b=X/36PQcfCZBVZF/dPsIyUvxa/CJMFGvsJ0hTekYcOxUk3SyIdaN+3lmWUPcqkeqTck
         AQGE62bhBkWyHB9ZJZtQZMnqnSY/iy4jaCSrkGahSFMjGl3+q2URy2Q+Xi2XeKm6WQfa
         CQgOPwGbBaychxI7ZLwg9pjb6FlfjsCCSR7iyRua88EpUcvoo5DaqVRrsuj7KplYynpA
         BJnXU36gPehHoLXyUtqpVJR8gA6T4VIyzSVywFuYGbvvsi50MlZZaPFVCeRDtZkODf5O
         I7/qf1NY/Qdpu+bcOoyOpfpBaQweiO49Z+SpawHFr8V6xNyGnG6tB5clajx4qJfruYDt
         Pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577152; x=1762181952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42PPEESTPRM1MqRXwgq0RfVuUgixMW7zVQ9CGj4vqjk=;
        b=pDAttj1QPqEqil0DWM4EgQoWfxzQqDnKFNpbf1FH7vH9e7kdND3C8Qyrl/PWG9fLNM
         SYJy8I57fPSLDUSSj64YB3S5LN9iBEmRvCnJkT9BcPsJtV0kcE1hZFGGC+0VsfNNMRwS
         iCLjzLS91dgOdYOSczp/VQFY3mJueHk2jPnERYqKKZODITRU2ScABBcwleRPVoaI8kn4
         6qLyQu5QmvQh0V/B0M8F5SH1kO4AH4WzEU5HczQIzb5sh/PjdiIisqzh08Ys7tLCjJEq
         CseWG1EyIxKOBkqxj9ShbLOX2kfBqNOgnXnR5NopX1F2bnafZPm++GbpYQu3PJr0OR7+
         vR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn1CfMlaQbG7oxpbaDPjJZGkB5UX+42PDSYh5bxBl9TUHtNB7q3vc92QhRLp5L7q+oKHh0RyLmxbl9BVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BfdKMwbcVKQjW2rzyrVQ5oZawN+bN1Rf0HoDZjvt0E9uBGhN
	WQpguH9/lbiDG0b3Z+2UQJGR1kCMeJWoigpKbVc6E828MoAVwkHUus1YeYMPhxBUfbc=
X-Gm-Gg: ASbGncvRzpFbMY8Hkr91/eMtsznXMNH659oZEZyBNggoWOZWzj0w8tnUCDTE1WWIUv0
	hdOsVoe+5xi2iz782DOivQO8aRte2g2wDYbQJtcEmvfsNSuw/nli0DSrcEpj/9a+zQaQDm/SqHg
	N4lqtB1GOcsSSZ8OgyarQ/znDFNr4boo24myKkUBnIdg7wwt/wHUorFqg/h8A24olALAnxssR9F
	k+0VMNRnBiJBwEVe10a5xkVcmp2iDxwe7pGRHBi9HxFTpbpxGijZhabvmytEg4BvFDo0FSl+/7N
	w6m8ZCZQ9EO7nsf3JT7mgwT8u3qhhoh6Bhvp4YagOltkAPY1+GCimumw9Ru2vnI5/IocWqmB48L
	WC82gUD6KcNoeIc6rPrlGxMMANHTx5j6S9SIC8DCEJwDxY8eRUu1fvVUTOogfy5zbOU5SmRZORj
	kyOtZjVDGs6HXZFQ/jNgib6OH8jJb6WTqL7//7VitirN7FGM/Y8Q==
X-Google-Smtp-Source: AGHT+IHzuM7f2/mhqN6TNTjfjdCykv8WqRrQS182YAqAkII2xhAQD50KGvCHAYvbwychNayps4clAw==
X-Received: by 2002:a05:6871:ac0e:b0:343:13e4:9d3 with SMTP id 586e51a60fabf-3c98d18e2bdmr17563909fac.49.1761577152296;
        Mon, 27 Oct 2025 07:59:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e2c30b50sm2536302fac.11.2025.10.27.07.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:59:11 -0700 (PDT)
Message-ID: <66c8f410-6bba-41d2-88e2-46dbe133adaa@baylibre.com>
Date: Mon, 27 Oct 2025 09:59:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_2/6=5D_units=3A_Add_value_of_=CF=80_*_1?=
 =?UTF-8?B?MOKBuQ==?=
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
 <20251027145213.7c93a3e2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027145213.7c93a3e2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 9:52 AM, Jonathan Cameron wrote:
> On Mon, 27 Oct 2025 15:34:51 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> There are a few drivers that want to have this value, and at least one
>> known to come soon. Let's define a value for them.
> 
> Is there any way we can make the x10^9 bit obvious in the naming?  Or do
> something a bit nasty like defining a macro along the lines of
> 
> PI(scale)?
> e.g. PI(NANO), PI(10000) 
> 
This was my first thought when looking at this as well.

Or something like PI_x10(6).

