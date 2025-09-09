Return-Path: <linux-kernel+bounces-808349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE9B4FEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A74E2DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5E322C63;
	Tue,  9 Sep 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElpAUPfg"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EB2EB853
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426602; cv=none; b=KMd/wavYMTni/z6h7HUm/0cs94+b0To5wT3gkPt7+AwlaidqdBdv42rgm4NXUehbuo+T34y0x/AE5Vh1lGI5u8j91rb65nUPDGeuHHwbZdUTflrv7yowij+8Ux07W1/Cw7EhlnjR93rcJi0fV1yIzrhaxoifPEWQYthAc0SzrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426602; c=relaxed/simple;
	bh=q45CxhQhD0f4Z1JjVjqiatYI0JZBd8Wv+yGFW41DUnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSPSFrEU4iU+b+Vw94Fw5tH49zJlBf1QSdH4ZyNGE/uEwWgZ0L42i+3cic/pJg0zQ9RX7dJjQGUnotrYdj6B2pa/uk10IhuRZTbVO61cRPV16jtN+uxQnLm9436kHcgJ7T2j/8g0lS8oTKkUqiNiN43kq8Mx+zFdXcxlJGSFxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElpAUPfg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746c0ee5d77so3510955a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757426598; x=1758031398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=ElpAUPfg8H0rQCQBhmOm4tawRQUVCZBM9kyOgQ6B/1AHs08XLLQBU3bb6RtYSou13S
         oedr1SzopfT3Q62Gvfajj3gBwJyiuPUaYxW+AHaxh3qyn1ASM+LATePnkkPGiNIIIOpg
         cFpXAg2amvj3nPI33GnJJIuxzTl0WeTJ6jBdgSB/t9UySgd4S1iTbjb0X0MjDjdPyEOS
         N2dCvLqi/iowLxBu0v4x+PiwD8mkZyZJmtWaPVHyORTV6j9PLL83j2aUWllXpIkjUnqQ
         gPMqlVdjn/OqQ9C6h+aRMVXLZQO9nJHP/SOUweouQEm0q/1gqL2ww6GpPD+UN/+DZZzt
         AdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426598; x=1758031398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=W2PfQoxDRPviYN4GayPmqtuyQ90VdJOfvptmy666ARa4L4NxgICM9D0uPpXLO+MYlX
         0hZ9BzLMSLB9uoH0yJrxIGE5pkDuwm13TfblFDay7Qd1/ZbAMnWnKjzxHatpjtIPBxAw
         8Qu+/AxTdSLvD2TOwa3i2T0iVZLozx0nJxIEcan3WaSF/Q+BtNTIWDZuRTCLqIgy8XK+
         fh/o/KqlI+1izC0lulVLs9i8FnJtfM0BxDJ+/T8MEaMui3BRmF6n18PCGvVV52Op78Qo
         l4gPJ3KpDm2h4LrjdfmuZx4XZSqNoV3kuMas2hxtF4bGzwkB8u80cw19pLYaVA+LQbGG
         9KXg==
X-Forwarded-Encrypted: i=1; AJvYcCWlXaahe/qSwcr+0nSQIfZxRZUdSL5O/6eqJ22qoC2dKX6E09NiQEcpyhLo7q4q1p5O0v3yGq7PU8YtqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYpYzx5tDdc2XSUlRW8WwNkGHxfYGRh+l2bAM5sMnA5O8S4RG
	X4Af77R8ulEnY8I4DqeRi5vNcyEIrQr29jV+V7p/oBui+42nlrSZQas0+YWAJpRNAwU=
X-Gm-Gg: ASbGnctr66l+KZ+kFOCmqzfixzCC9FgV0NBLuAj3xNcCuLJMtAtMqp51F1AbCtM2dqY
	0RDK0WJ0rrxOGPgMSzwvvqF+bcKgFmlP50vHgCEIrDKdI1syGKX0H99iICLiEthPvwxJ9IW9FAG
	/4/v2CWnUlCB6Pa1wTbs9zqNSOwDeDobMFDlJNstQ9aJLG/+aUDbE9ACKZqQMe2Iak5PsvkYbbl
	uOS524wc6/dCnbsdQXtyWpUHf+1jzgqXTQ5fFiRQZW9tOCPT31fge8B418ffa0PH4nyvnKjBMpP
	6rhztcUyPVv3lYKujbbykGYF4sMw4lzGRt9AarBo9LEip2gczxgzfNecuH9Ad/roh9NzaH6GdGF
	2rXachazT/1LXAeczjGjrgaLvioyF5XbWY8Onx34yXksxQ6ue3RvXl8X1F/VTwCDrcX2fUAKOeQ
	WRMw4q21c=
X-Google-Smtp-Source: AGHT+IGBODO1pzDIKXSlNVnZ1VymhDBL90KIRXoVOSdBF5kuyeZU2GyRm2nEjTxrDqEYWt0BWjhcgQ==
X-Received: by 2002:a05:6830:6ab4:b0:743:968b:3440 with SMTP id 46e09a7af769-74c75e4fe75mr5174495a34.20.1757426597538;
        Tue, 09 Sep 2025 07:03:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0? ([2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6218ac3645dsm1067679eaf.8.2025.09.09.07.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:03:16 -0700 (PDT)
Message-ID: <0cdc56d2-091c-4d60-851e-788beec5e3d6@baylibre.com>
Date: Tue, 9 Sep 2025 09:03:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
 <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 2:11 AM, Sean Nyekjaer wrote:
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

(I wouldn't mind seeing the "obvious" reference counting comments
removed either).

