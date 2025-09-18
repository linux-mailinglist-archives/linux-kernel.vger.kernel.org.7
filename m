Return-Path: <linux-kernel+bounces-823537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EAB86C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2834E0271
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07131DF74F;
	Thu, 18 Sep 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uhTVDOEL"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CD2EC0AE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225088; cv=none; b=dR+VO5UNZI2Gdov/PejUM0z58muxngwxU4jg1Zb3X80MCroLQ7C+S/Rx+ahCGW/XQCpb2ClxbBhuVVLT04jH632+9Yxi5esNwa07oKmxfYje5jOAuh8UwCFna2KWp1p70BUdhhYuN3zthCUulFLuVfHkZmJpvUWgr/oBHpz9Uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225088; c=relaxed/simple;
	bh=+vCpNQP3gmwChNJcUCWInLDRRa5HHP5yLhQ1psOMqTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMNDOr6aXOpabqgVnZrDaeMRUW9uBK2A4czRazdttrsnZ0M905hPxYPWru83c6tRgbV+LUFbqY/nVtrwYn0gd15MAxkRi2Cz5GLnH/VbkBXaw/Pi4a8PGEHwgwYMcb6tzRJZwkS5h67MOsfj6ipRa+8DO7A8hju8iAn1DyBaDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uhTVDOEL; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-621b4d2b2f3so1080728eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758225086; x=1758829886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ycb6BrVm3o3tgecg3NZ2b8GKaDVhR9xxtrfWCgsW3GI=;
        b=uhTVDOEL13vWSEZ+PHy9Gpzci9lgihjB94UiPff8m4ZgUOMFrr5L0r7eMZae+JHgHm
         Owmm7nu1rKxAgMtXT101hm6pTxVpL64qQObvWJ99wzS4ysBmGGu2ke+o4aeGLmDtWL0w
         6EoPS660WndQ4blKQujTf/FNMPzqsAk9sg+ZLKWUx0lDp3YinE1ajinBxjC4hCgY+dW5
         V6IqF7Ncryaafpgc6WTcdHN0PLvzp98GYFOW7TeQW3jORpjR1K3baX5NNbMULS1y56Ac
         fPMEm52zXPcIb5saHVoZbTll7zFao4S0n7n+T6jgjEacSeQqUe7Z/k14iE/sOgv8D2lv
         sRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225086; x=1758829886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycb6BrVm3o3tgecg3NZ2b8GKaDVhR9xxtrfWCgsW3GI=;
        b=ReOJ9DxHJlp2ITiy4TkZjOt5zgin0vH3KTjaT9ti5CDp3iw/LLgtbI7OA1Kxq2f35n
         5GaOowD5EVB8Q0Du6k0m4cX7taECIB9bnOOpzt66g5XA/gJdHOzESpMZOTZdsCPqHxhb
         GQLc+YZ2WaO6tmqksy9GjIGBRcw3rA7z53bo4aiayMs1WWXs9TIkEgTSNErCjKSR3nov
         thKJ2CM2T4/14sWJJl98+rruDZf5dw7WhiZOkf1aq+nlRk4Zh+1+vVg2XwEmaNbq0x1F
         ZMX5Ap8FMZqNS6iHjVICFzuUC55dMSAU+j55s7mg7JouN9E6Ph5QIbKhhI7vKO8j6Sah
         rFvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/8p/2yEWc9qJ3u7554itOnfNCeWA+ZoCtK4Lbcq3+MmK1Fi8Z64ggtwBxI3rz5196FwJYinTe8q+8Utc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMiNOhoFa7vfR8AwRxwUL3fumU+AWPsNrfkub9LlJprh9wqZua
	+nwbCe6lLebDcdrmX7rrtgaaLaksTqaH65Qe0xQd/DckEv8hJacjKr9Zq/ztDb8jNEk=
X-Gm-Gg: ASbGncsV+7GVlsXlsIVE0d7XatUKE9ECb6bBMeRUPam0eSEBaNJztTHutAoVJ1AERxh
	Jv0k2vJvyXmRPM/8Nh7E6GZSO0Gm7gYsKDCe6cgJHgwtJJ5GMxlUPNi3s0q1lG4ck6wThbhAGMz
	YMYFeunVMWQG9N88w4PYnnhPHei5rmqpe0PNmwW6rm2tSmBqoSGtifFuQcuIEPOKwjNBVjQJUB6
	cq5Z15Nhz/D5QqF6Kn5ez3PduADFAgkfj6M264MwnekIapinHGqoX3OZAHVsTphv/wZ8CRbWzx+
	Y4YnI7ItxodcbpyUghzg1Pika6pYaqkEy4niitFiWhH+RfPkOCYpdsR3VUU6gLJI0EEmFDMyJA6
	JiTI+bwzqaUJYwHlxIH0QlMB8xQ0kkNklXfqdlS6r+ItxPuC0HnigZ0SiNHM73nqViRTiMnYcrE
	/fX1Q2OMxX2laIm3GaIztejMtEdULF
X-Google-Smtp-Source: AGHT+IH4gnu5ZviVz4ulNiX2L97wXpeu2HQYjfDnnt0qWqu/Pap+ivM2yq37UDqW5VBY04FXNOqo9w==
X-Received: by 2002:a05:6870:8088:b0:315:60a6:c28f with SMTP id 586e51a60fabf-33bb3aa16afmr568561fac.3.1758225085748;
        Thu, 18 Sep 2025 12:51:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af73f5sm1892886fac.6.2025.09.18.12.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:51:25 -0700 (PDT)
Message-ID: <46575acd-9e7b-4462-989b-d74de4d86311@baylibre.com>
Date: Thu, 18 Sep 2025 14:51:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> In setups designed for high speed data rate capture, a PWM is used to
> generate the CNV signal that issues data captures from the ADC. Document
> the use of a PWM for AD4030 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


