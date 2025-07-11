Return-Path: <linux-kernel+bounces-728002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F9B0224A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881377B1BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC12EF9A0;
	Fri, 11 Jul 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P7lIZ+Pl"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A02ED14E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253447; cv=none; b=lvjoX1GBfdK30w7L5VNQYAuA0JDhwXaVMIoib+Vhf1zWvUD24ODDApn06e5qSudgaXNaR6IZaHFrrVfnWj4+88WliP7twHaVN4oMM0ve/RVXdjGMlE5dDKyoca3/GSleQ39SNaw/NhUZdbrBNm1EEzS2Lm9BujFZadsUrvRzfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253447; c=relaxed/simple;
	bh=PnT4dFphw7u3i20NU19rEzTxVmci2gy89ixQ4Wn7OdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/qTATiFnEkuAMhUTKLHFjh+uW0qI6W0dmx5XAhfGFP4xRHXQ1/Jax1B/92cXPFr7Q/sRXLIEjzkRTNpRoDwHrvdixN0Jc7KD9FibKM2kU3brsGWDFXKu3rENOe/YeKbTy/lNr3aBSbpa/5YY5Lo1A8IQgjpaaKe9Ms1oFZtrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P7lIZ+Pl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40a4bf1ebb7so1209519b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253445; x=1752858245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25weoVSEgDYzfjwlVT7VVDCe9SsshCl2MvcsP7470sk=;
        b=P7lIZ+PlS75cLi4tCKYz323SXIasRnQhvQ+d27LZ93Zn4MKjF6cs1HhQxeLwW4jvrV
         A9iH0QbwDWbwbNBYb3vnCBITUSAGWnwV3KyGW1dpQYlznjNK5hY96PDgKDG0L0jcAGZt
         aZ2FV3cBqcJLYk56uJAUL1CuUYqLFY/TssCKixOGgO7uhtd+MgVDoFd/qL25t3TqKbaq
         LMnsBbEK2wurNGx5IZIwG/puW5P/4GpYzU8F7evyD6Omg6kSNNTIwxTeogFsDxVRthVt
         pGGBEpXOjo6fypY7QlcXFk1SB7cDqNXNHzwvUUdfhWsKXavVeTg73611QLmIVtXcwP8W
         pM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253445; x=1752858245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25weoVSEgDYzfjwlVT7VVDCe9SsshCl2MvcsP7470sk=;
        b=wxsTVR6xgFeTjnM8ByWZ8PGysJa4SmKeNXpUctx3eNjMsFvxgH/HnOxLsLK/4+KtES
         jRGxZQoH0J0QKzNpvkHl97pUXm1LU0uPKBRojBHCbFsl9OEQf73aolDv3VlOvxvtPn5P
         ypNDW3i1LpzURoye+tNUMGG2anVURky/qo/MbktHtJtnlrg52wy/52yDsTWerEIOEJXU
         wQJRqGhAsVpnBY3NkFTxozC63VjpvFLWkE49yT9B0NXkLuyEs0dfH6qpdFM+Rnh8ubZM
         xYTscdegSnXRct633wai2OPCP46BsQzRURA/71mBU9OmKZE1iRQZxvJFF3CwAKx2DgsY
         x2FA==
X-Forwarded-Encrypted: i=1; AJvYcCUe2++mK6sDb8Apxf/9eNbQB2o7+rjV3E+jWZWSMRoRTfnOUa37EAH704zWBNxVIHBz9RZvDHvxQpt2k/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7UMTfvBWh6gWDYrHGVFkAR/ihpP310X4Hw2KRWPqawZSI1Wg
	VE0c43DefGCUvk1Q3UmGn1kaONw5lkVBua/5mfh16tNSiBR0+mJu7x+WAbY80L/jegY=
X-Gm-Gg: ASbGncusm+pPTFcTbGwPCHWiAsArcHnZ8T+ipaypiiGf3eZe7OW9W3Lt4aW+L7kRikb
	k8neJGzSo3DabkCbo4qx1WAfFL14ALHOc1eBH74da4B9RBOwR0C3g7WPqlVmpU8kME0BJ3BARHG
	HBrlDZB8NJVOjo7xb6z9NrEyyAmYuskSrTUU9y+x7PZfrJjoukAAPbmJSDSYYtWflTohXYzf3kt
	dTPXufMb5X2ACqSF+Pg9mVOIeUfIjQY3AgBFtxcyTuUGeBCKYqf15ZdT51UAiDxGHQBrigvb/kQ
	rVeneWWMcuu9S1fwAVRhoRI7kVhgzfUYpwe8RTZuckv+vqLXnrPIawc7DabLUwlRbcbnZeKIbmC
	18HU5Fgc+DRBxGVBovM4qzqy6jctjLKTvp4+hX/cz1NmhjYvzxQsdKCRWZrL4V7QrKY6O0IPRHr
	4iH6/RuNQGDg==
X-Google-Smtp-Source: AGHT+IGIW9JMEqzi1KelxvvTFcVWg5V5Ue+7oAq7Plm6PnSkbrM8lciOD0X3y2OrpFVIYBz4h/HDhg==
X-Received: by 2002:a05:6808:514b:b0:40a:5356:6569 with SMTP id 5614622812f47-415393d5c38mr2567599b6e.25.1752253444571;
        Fri, 11 Jul 2025 10:04:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141bdc823bsm607742b6e.24.2025.07.11.10.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:04:04 -0700 (PDT)
Message-ID: <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
Date: Fri, 11 Jul 2025 12:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 11:41 AM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
>> Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer used for
>> scan data. There was not any documentation explaining the buffer layout
>> previously, and this makes it self-documenting. The element type is
>> also changed to __be16 to match the format of the data read from the
>> device. This way, the count argument to IIO_DECLARE_DMA_BUFFER_WITH_TS()
>> is just the number of channels rather than needing to calculate the
>> number of bytes required.
> 
> ...
> 
>> +#include <asm/byteorder.h>
> 
> Hmm... I see nothing about this change in the commit message.
> 

It is for __be16. I kind of assumed that would be obvious, but sure,
better to be explicit about it.

