Return-Path: <linux-kernel+bounces-792351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC6B3C305
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2375A0C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8B23F424;
	Fri, 29 Aug 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MvyacE+V"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16423C50F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495745; cv=none; b=kOiDhbspOWw4FcjtFxicz8fE8dzDS7CGGZC5Ps5nIMHMw4pNW1UGvETUR4W0sLFqrb01fiQ5ptiUXNeb96NnvgQWITNGpxHt63KHbkPARkPoPZpzdnOO0TZsEB41bpCJiJjDuZFRQ1ahXoy3F9xOhCNHe9ykBYLa6U1RX0lOdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495745; c=relaxed/simple;
	bh=i+INH5PIUZ5fungsOczI6sZiAKm2LRX8A3qW19oUiZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aHRsChNP+9dRSLAtNrxeQ+gqeoubOHuwcrA0na2XBgJCvLH6ejG2xFd65ZyZL5/Btf723GrucF1u0u26QQAy58GyJKcYFdwlS1Gzi4itIUYYtYkoQNWc94hSasYSf8T1jO57JQ6e8r4XWs4olujOboxglFO0zkw9K8UFR9W3U7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MvyacE+V; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce86052cso1476661fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756495742; x=1757100542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2+wT5He58Nk4ycI9gGI+sEh59JOmnfZJky17dXY3FY=;
        b=MvyacE+VbzR/rlHHOyYqbkPUt5nGlFnChMysLkH8a3YxpttS96PxUHel1Q8eLws6eb
         m5gRpkTRonUzJ0BCBdr8CQ7ad4+JEOdVx5IJfbjGvsoJTm+10RdjMJyescrNvn3l0Ng+
         8sdEEcZN9Cxl7vYqEYvyrLL0lQTR15jyOcvBVFeEUX9pmmPdIfXlHW1hKARff++srJup
         H9qtx22ULnHgY0Travd7brxt7zPWzfBduUdBlOUMXt9TVzt6ONHc3K+Jll8xI78xubWe
         9Q5FWA5Dq44mOZa1gUueyyARb0BYM62tjay++0scQ7GqdIoeoTlbMJELN5mY7e1x2d5F
         bGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495742; x=1757100542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2+wT5He58Nk4ycI9gGI+sEh59JOmnfZJky17dXY3FY=;
        b=bG9qBKAiT17LX0Q8EjOHRvOtL7YEHNIF6LDjhlkNI1fyixIgJVPkqQf6TeMkWL9ayN
         JweWgx9HB2LFtKCYCUkIvjiGJ+U2XXjaXRgkzKUhAI7EEUDGsrPKs6V409LYFg9mfPuD
         7DLS5zJOEhuA7Yw3oBGD3gSdYavfnGyGf+p7A57rGDULIsiwdcmKd79Z+LPbGk0o0Z+P
         NQU9Dr8/TNWxFhwmmAHhM8bn/j8H4m4pA/sFtOdKVfzzkdN/4m5rpqNKbXPT8G+GO8pR
         uk+fffIswcijffwFdceB+UpAujiG/8dV+gwDRqbwRInSLdOQ7EQKELVxr6ghCKgKy91d
         8wTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdFAXlUAFU/70eD096UG1jWR1nwLFyyI+H0cbfv+wdDbdww3bS5TCV0wyfTvBKFw0as4Y9nWxYujz3GkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUsJ7R9d3WvPsI4JLul9t4BhTMmGi1efeTKwU5uWM+Wd0I9Lu
	oyhfR0ZncLeVFocmd4XY7NPAaDB0plw3DRj9bt+xi/RKh+G9k1FWBwp7Ebhx3Ujc5/w=
X-Gm-Gg: ASbGnctlYqN5s970uEs9exOY4JnGFBnMO0Duo/hGCH8L37Jfip0+21q4eCY/fQal08R
	V4It+PXbsVCExCKRFdN03ogzm1Yhz4uZ/3lYTmWQ4kflvKTC4Qhf9IBf7C36aLIjFwcCstEdHb+
	7cZKHbG4vpALI+uP50mPxhYpwxkzgf1GbKV64WvsJ2jPqQCh2eeTQsgVBxNGRuEu3retUGly0j6
	k6D99Fy3Tuy6kL3rwnLWMb18mImbng1nkfU5IaX4F2ISEsVSbiZFx5nKIGIx0glMf/ZQVxQX20J
	9mn+tk4XGgsKUcK0CRJHtGOKZTSsAz3qvdGCE1FpWkI0rnkJNrIG/9OZJzLlvA4EStz8vnbNqDQ
	sa2l+8qAggRIr8g8YmMyVn7M5Ujjv6SDzPjerue6/FcsMCWZQi51MOjbm47mUHZ3pVMw03grZRF
	2DhvuBkCHEAg==
X-Google-Smtp-Source: AGHT+IFUI0HBrruEpYPUGPVj0o1naQM5URQdPGR0MpXZecuoseh/XCOIleBc4ls6rYo0uNS6K9zvvA==
X-Received: by 2002:a05:6871:4:10b0:315:b558:1584 with SMTP id 586e51a60fabf-315b5582503mr1655470fac.21.1756495742127;
        Fri, 29 Aug 2025 12:29:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe62235sm1585849fac.23.2025.08.29.12.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:29:01 -0700 (PDT)
Message-ID: <9971205b-6e92-46f8-978d-31b074305410@baylibre.com>
Date: Fri, 29 Aug 2025 14:29:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: adc: add ade9000
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +  clock-names:
> +    items:
> +      - const: clkin
> +
https://lore.kernel.org/linux-iio/20250820205838.GA986565-robh@kernel.org/

Rob's comment about dropping clock-names was never addressed.


