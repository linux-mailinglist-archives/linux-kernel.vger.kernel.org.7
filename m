Return-Path: <linux-kernel+bounces-783221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A7B32AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0558D3A1DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6B2EAB66;
	Sat, 23 Aug 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SD2dEGj6"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747952580F0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965590; cv=none; b=iUUFl76XffesWKJHCCgXMZ9WxyScartoe96bh0QHbxVSV6M4lEaNL4O0OtZAoZ3BbnEaMhCV+iMjOsvMjli2txk7QXlXgg3fQTe5y0sKD1Kehiiee3OdiqjwiTE5O2HhXB5i/1wfK9hNrcOhzzNn08jTyE523jEkc9f/gChchCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965590; c=relaxed/simple;
	bh=RTjb+iVn+TsdR5py4kgHTkw66OYfI4TTybYyhR6vIxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqohLSbO6NWVq3/YMgN1fy2kLb7by3w4SOj10XFYlX5tMnzd37KQ/bOEpJSZWaNbHYcKbokYQ7rQvsfdmUfnWORKRjIPD8fDVVYrEQXQNg1NE1lA2suMtPZhHBXZzqcTWSGAsuqHZeCSL1wMne5eXU7NZFAIiW/7T50xOrDQgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SD2dEGj6; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74381df8cf1so1004208a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965587; x=1756570387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qSJXIx/Az+pQiYKBZLEErDNdCpixl/qOO1S4KvmcYg=;
        b=SD2dEGj6I/bkm8wsam5Ocpak+T3zPbOXZWavljpQm/Uj+ppPY/wHMzgdrh8hhnTmzr
         7m7iODT5FJnXof4ytniyd13reS2YCMKTSVfLVTsqz/6SKCCjLlIds2uD/bMX+RTT8D1O
         /CMtH4j7cLwCqVpYdmDDpfNkS17vTfJp4jl3HTXy+kLLNXdXDSyK3o92OVOCPtWYpR6b
         UkP+fqLqlup9hU/X4CW8Ftp2lG9VFh9C/PRKTZMzNpGKBxGEHVFoWLEXhuIj2QrCGKdm
         7+b9IVDSErk/naWKL3AX3NdcnVNFVlZgHwpoTv3mN9h18107HCqAIJ/dnhO2nZl0oAsS
         Vp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965587; x=1756570387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qSJXIx/Az+pQiYKBZLEErDNdCpixl/qOO1S4KvmcYg=;
        b=QbWXXinazp/Lros/bIXeakSWUFkv537vnuFzZRFgQ9vyZ/+zhxQgpfJwHYLFDeVtOp
         A1bILWq13KaFju7wFv32x6XwIOYZiCkLgGsD4f/LKTTr2p0AqRrRCC/OxCavP4iX6TZs
         Sw1TDFTXSkf0ko2CEHoVyBmcLa/JIndu4Bh/HIjyQczw2VaUvKEtd3JM8jULx6pi6Dql
         WAgQnGWMy+ggPVUcWeMrmho/tdVXa/bVdjqYs0uaUMFS71WfkBukD9CgO0Zw5etvIfWF
         qudGAFJaAmSR76Mk/v0gMfbT7GO+ozHe3Pn0AX3DDi+0uDE9XOgYwGMB0sgSCykmeLv0
         iT3g==
X-Forwarded-Encrypted: i=1; AJvYcCWDBGYmf4/gu2yGneUg/lb/uZHnV8nnP09YQBVuQjkL2m5Oe9ViZkdbvC9k2L3bpYJx8EXggqSE84OAlHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGayaQG1cnwUNjiQ0x/9Cq9ntJxfRaoebW038rtD5Xcj8hUiq
	oDpnP7KpVcVGOq0WI0yr0wRxo+lt4VMd7wqGek1xvCZffHWpMnwKOzRJf6TI83moSno=
X-Gm-Gg: ASbGncuy+N3rHjLRf7OL9DlFzKuKZruyx0s4svxXE3whJbG5isq5okWxV5QS5mm3UK9
	qZCRrzBt2XRKBGq79rcdt7jhHdAgHTRDgdJ605YCxHuUqBVa/i2HHG/xjVU2/Fvw96BMp29ad+C
	t/suU2P1hwE+ytC05TX90gs4U6VDmGczYyYX/d3xxUpFFJq30ero+xxUzkCfkCZ1qfGBVKKvNxB
	d3RF1Doqj2U5q9ckQjaOQd41Q60UAqBTfhbhKMqwm4TipHWBlUmsTcist9Uq910D6HwfY5eQjIt
	PovEW/oUQu3FsBIzg0+oTUkGlAZ0jBwhbq/OwBti9sJ+YzkkVIvWZHUpkNsbolNn8W9ZSPpCTXC
	oEsZmr9hiZv89/yV/oOwGQgKHeZ1d73DTl1LGQllsiVsdV17yNCOz39yz+edL+PA1AwhL+88f
X-Google-Smtp-Source: AGHT+IHi+cV4E+X1M0r2JR6jBROtlJPHA685XBWxXWqnrw1xyZGt7gGfo8sipwJMU4bNKZjw4ng8ZA==
X-Received: by 2002:a05:6830:f94:b0:744:f0db:a1a1 with SMTP id 46e09a7af769-74500a8b38fmr3364972a34.29.1755965587401;
        Sat, 23 Aug 2025 09:13:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e26887csm663095a34.3.2025.08.23.09.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:13:07 -0700 (PDT)
Message-ID: <e61c2e01-cd8d-4193-afcf-5ddaef34300e@baylibre.com>
Date: Sat, 23 Aug 2025 11:13:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
To: Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, michal.simek@amd.com,
 krzk@kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250820100519.2272509-1-salih.erim@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250820100519.2272509-1-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 5:05 AM, Salih Erim wrote:
> Anand left AMD/Xilinx some time ago. Salih and Connall are new
> maintainers of xilinx-ams driver.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>

Looks like you forgot to pick up all of the trailers from v1.

Also, there should be a changelog of what changed from v1 to
v2. Just rewording the commit message, I assume.



