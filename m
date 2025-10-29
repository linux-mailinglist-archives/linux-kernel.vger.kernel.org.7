Return-Path: <linux-kernel+bounces-877108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E435C1D35B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DB240002F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA2286D7E;
	Wed, 29 Oct 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/AdxRXv"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC3283FEA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769924; cv=none; b=FMJvUhEY9rP8SCZ8uxZY0mduZRVOHZiFoLIzIbA9u5QliYkUh4ndF+23Md9s5c8gpiVE+cmOYuI/zd6DUxCwfFaJYKIWS1v+ZzC3dedzUMpmfSvZdDxk6xrrwNXT56wfFUKFGrYtEEh43tC1keyWmxwtbIp3HTsmIrjFzNQvvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769924; c=relaxed/simple;
	bh=YaHtD09W7I9VYtLMrk7MCUuLeIYkfwLpiWs2SkdvK4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7fGq1p7FPljtclh/oCY8zTo3Cgq3DuIq5zFN4Ops+l27hf0yyVpX1gk76GpgbQhSUE8OfBp9izBZ1C+4dlYopgNf0jyR2RqfGOPXGuD0m7wT9nLA5/NGXVngAl7Un68geTQiDnvgnGOUNngFGy0/OwI/Fl/mq4ZZ8Fok9sUlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/AdxRXv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso380900b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761769922; x=1762374722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wOfwJ8bWKZa4YFr/NutNmAuLp8W/TU0LOxvVKX01rbE=;
        b=B/AdxRXv4tvXaGrZCx2HDA7LoS/HfSQtXSp5WH7mpZk+Qp3ad5gvG05Etwat/kMHdX
         /JmVBoRU1awUG8YotIQAKXj3bgM5C0jsr+00uQrVuH79cvPxFyj8NG7BzqjPgp1x085n
         8zCu/zAD4MZxA2T8Qxy5c09uYLtCvkZhY2P10ppl077sd3M5jXUiOxxjC8+DHPHyqX4i
         Zll3fXqT45GuUT82JFbZbBCBjVYp6vaLFc+HBrB/9nQB3yxpmOXXBimyNKN89Syfp3ht
         zg3qcURgmHlbUPagoxGPLxCW4+c7OqUDeXW2WK4Lz6pjiH0hM1MfI54ivee/Xuwa136r
         oXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761769922; x=1762374722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOfwJ8bWKZa4YFr/NutNmAuLp8W/TU0LOxvVKX01rbE=;
        b=ugwt81u6ca2Wgnppq1l7NRc/I7kDyE/MvyKp60B+HvmPhauEnvzwDAdKMAGSd39QFP
         nKf3/SWPjMy82HvhPvAj9nWFb6qyRXmhG1j3QqEn8lZ6aG0kopjjNXCBmUJ8mCb86wl6
         oC7nmRcb+N5AjliZ2QNcUnTyAhBgjbXtknzO/Oq+XHqEYk2iQI1+rsRw50zTrfJypWLT
         6vY2RRk4S6O1O1eu22i5c2l38T0pv6W9q2STKIhY/EU30pzhZRWVcIIsgcdixFAg3Sut
         g6vQjdUhmoQ5XB1HaZnLUM70lMN4NLV6+WkYQcuM4eqT6Ol8wD2aR2lNM/kr34RbTXJB
         YAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6Qy4NAZX8W3xD5NEnLKCUJnovx6yrZ8v1sOjycOyKF56O1x/7I0V8U3fAvIhwnoemZ3lWvD8QYh7L2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjf4rgd9bnLytrgTOzb3QLRipMqztIUIaK6ZCZp6vJ+VrPzCW7
	ZT9psZl2SPdQ7VAYrlaYT626gl4sc11gqeJNubjIumeddaD2XuyijUJO
X-Gm-Gg: ASbGncuv94JRsRFm8QFMoz6DdFxOPbktCYK2U3DuA3DqeR2QHFdezYQRg3wT3lLGjP6
	+NXoH3SkRe8mUDEw9GM73qx4ex5yid+BjHVr3pGV154nmMD2o3KaGV7IbbL8NO44XnkkR7w4K3d
	ZSsdZ7a9eZ+Xc3eIoJuDvi/E5ICssNjbJ6NuYG1H+vq8mtFBHSgrDpUtQfKw1pKoHLH7i6zJYRO
	qWX6T74NIUHF29Ui3vYwwd+2vTfqYpIoQzyh2sv6Dq2GkGh4h6FQRywFmDdH6tmVSeabQNcO1Ah
	NnIfiLboaFG/w57mZk9o6Fz3vAiGiJH2Y40XiV7POnLJbKevsiDBjINRCuf1IYdZbGsf6iOIGM8
	xfzHtnpaqWaXb5oU8VyUcKgwaL1MRl6CP/gqzs7NySf15Vz9Lg16fZM1PPkDLnSMosTEwMdEFMF
	uRaRgS7hZfsbhvX53f2MxjdfixV5we9rKavE/Zr4AHde0iGns2
X-Google-Smtp-Source: AGHT+IFpShubPNxGrw+11hp3PVUyV7xz2+3u2+DGXZIeSF8hccmhTEB6eMksfzjbjPtC3NenMVVflg==
X-Received: by 2002:a05:6a21:3288:b0:341:e79b:9495 with SMTP id adf61e73a8af0-3478768fb4cmr1044825637.54.1761769922069;
        Wed, 29 Oct 2025 13:32:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm16398977b3a.45.2025.10.29.13.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:32:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <049ec6bc-d869-4f93-891a-13a0640f882e@roeck-us.net>
Date: Wed, 29 Oct 2025 13:32:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: temperature: add support for EMC1812
To: Marius Cristea <marius.cristea@microchip.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
 <20251029-hw_mon-emc1812-v1-2-be4fd8af016a@microchip.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251029-hw_mon-emc1812-v1-2-be4fd8af016a@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 08:50, Marius Cristea wrote:
> This is the hwmon driver for Microchip EMC1812/13/14/15/33
> Multichannel Low-Voltage Remote Diode Sensor Family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
...
> +			convrate = find_closest_descending(interval, emc1812_conv_time,
> +							   ARRAY_SIZE(emc1812_conv_time));

This needs to include linux/util_macros.h.

Guenter


