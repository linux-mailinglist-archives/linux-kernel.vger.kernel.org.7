Return-Path: <linux-kernel+bounces-776039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F1B2C7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29237B27A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26444280023;
	Tue, 19 Aug 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EexxtQRT"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EE27FD7C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615330; cv=none; b=YvCMgq2vdmDAshOw9xt1ZsIfaVbS0BPqfbmSA1EhzNdF2v85dr328ZDMcQ8TXW44VpWL/BuXiWbuQGIeAhlaQOjsMh4nF1fNb6owmYeXq1nW0QKD+bufqU5FeYIu3AHZ6dBlCUwlZgSSxL+D2a7ZvU5EegeUb8n0ImLWgnMYP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615330; c=relaxed/simple;
	bh=rZi4e4mNoKCg92RzZ+sQYlS+mPo/zTE1yqe24FKrvK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMmliK873e7hAHUe22fp7MhtRra/JKvmlXY/2kCWfHAYjalp6CG8zQ/KlLbkfsuXVdaHi+W9H95LsjpDoCWXBkehhdVK/5W9WFaTcxU70Wd7ipxR1Px/Y99s08pNQjs7ZcHDOFS13KiUENornqhJvLJx2lNBtwpxnsk27HgrQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EexxtQRT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30ccea6239bso3772152fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615327; x=1756220127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNYz6zBor3BO7K/f9oFMseiDraaZC+D39dcIGBw1HiY=;
        b=EexxtQRTdRgOg7tJQj+7VVhGr09xhsXxjtDGqL+4Znk28dFR4nCCXAb+tWPbwK2hGf
         2qs1WfJsCyQrwCel4MYdJO3m9db5VNijRUv8+pkUf11uxoE+HAdLjPlyC6JRXwN9JtG6
         elzdDCC2q0NUyI+ogi/YuZTN6m8qnNC+GtfiDmOdN7JRlnfXFRWClkmt+9b5noNM03k6
         6zq3yDbu8hnKoPRbW60ewEWNL0b3rLkF5OV1rRQpl6mcTwQsSZT4abPf7Rd0ZLIGzw36
         MlD8610IuAK/BtoGFCFsvAmMZzMGI4aA7eygaqeIhZicEDxvQpbi+hUwC6uRN+YB/rbf
         30CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615327; x=1756220127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNYz6zBor3BO7K/f9oFMseiDraaZC+D39dcIGBw1HiY=;
        b=fA9ZmZJIwrZ9NmEwmrSL3VjG7XhnVcTCQUyhy13mhDUOoDj5N3jvv4foj2OzkqsLe1
         aaL8n4ngu/cB6HqmPg7oWrO088AP2/PVUBkoibx+WKJabhaFlshezbNPhjWnhwLPXyWb
         oHvlarSkExv5+AnFdW0Ly1nijSPVsAbdxSUtDCYwrA/59umTK2ZhrlCMJIgrS8wICZH7
         SFbYdaudGpiZe0kVd/Hvj7rW6O7KA8ll6zEC3VG1A54+vpPDG5au/MQff8tMrXvSUBPf
         iKpzO9XDPOg61jRsSKL3s9AX2AdMtSeDD9OGmzp9OxhfGRiVLqigoely1UyELc92vnOY
         dGIA==
X-Forwarded-Encrypted: i=1; AJvYcCUFKa+dzr5voA1OYU3MpK/10hvNVKiiEtHGzWukwC0aUwJMOGvPEkB2+9gGh1T2p628SLfdKStS/M2UBqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyogNzIR/olQ2WlXIozhGOyIdOZoucytHmvCbwxfIaeNsB+5xX8
	Rc1k3jMU7gDS2MpQg5G6tXc8BWyZ35VRwEXBqj9Zpjf6vrff5QdTyWEBd0NJuR11pkXctINOMrC
	tAutW
X-Gm-Gg: ASbGncv2BaTu9Vxbw4iUnpwM+1c2Cy7NDXgnZ5XXHOwBPneeo5AUq06SKD4ujP/3K/9
	pstMBd0NhdURGHLEcf3mevCBJMmkTdzNgrz7GiexoUBvaeWBKHEMLyKz/PKo38hfsucVs49ePNQ
	dYbEyQZLKZsly67pxHHnWFdoAk8xWDmMgdDwI+LsjQip8p2zpxuJIgJZ7w1juvXruunIXOmpsaL
	ZrMXiXBywuV4XhRSg+U//fL7o/YLGWJ13Apr3WVNkaM39imreMOeoUdB7urIaRmdqyULmlTJDv6
	I+qR0XaVHLn+XSoa6bdcNVL0cE/K9YxMaqcyal8+JUZlLeHmjOGZiapTXn71VcSeN5lT2UkBWoE
	/f0yj5LEvnBoQ7ao7+ehfKn1EnZE7mZ4MdadEOyqIlw6+8yyZq9tMAW85oGgWswcYJ2DwOk21RB
	w=
X-Google-Smtp-Source: AGHT+IGJKUtR0KedPrLrV9OrX3clCWOEdUIRgfULW86bsxgtpHLFlVjx2/761XN0QdxXUzPLpNJfSA==
X-Received: by 2002:a05:6870:709d:b0:307:b28:48e3 with SMTP id 586e51a60fabf-3110c3be255mr1744806fac.18.1755615326961;
        Tue, 19 Aug 2025 07:55:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf8442sm3444800fac.31.2025.08.19.07.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:55:26 -0700 (PDT)
Message-ID: <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
Date: Tue, 19 Aug 2025 09:55:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: mcp9600: White space and fixed width cleanup
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-4-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-4-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> Make tabs consistent for register definitions and also fix width
> to byte size.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibrc.com>

