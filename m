Return-Path: <linux-kernel+bounces-793090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0359B3CE26
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A9118968C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A8218AAB;
	Sat, 30 Aug 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="isE7FOyN"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75127278E63
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574868; cv=none; b=QEHMwWNUn/Mwx9MTKWa161A/B7GSl9K08+clKPQn9tsFfXYOGn4G58b9FQ/CjiMWCL5LUNOINntRcmb1tyhQZJJ+uzSdLGtjPTfUCx4V+/LU2GRzvoNRtqRfkAeet9j1R5W1nYlH8ZET9pd0L9ldI2HdDMJNAox6hbO4AYJq4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574868; c=relaxed/simple;
	bh=1/ysBXym+F4ed535scygMvAdX/CCxBkFCgLW9wVuzJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drLbsurdj+QGVa8cVHlcnMg7TnO+Woot1RqUO5GYDdhHpxJAmlv/Y/3a/R0PefVZ57AYwDpTsT5bvRwRFiMzA5rtfoh4J/58Iz2UrwdwKIdoohVyE3Wu3gck1QFohUuKr7DzZl2EXxPhC2h05cjDvOrsaeeEHHQSwPWOO9sdpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=isE7FOyN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-315bab2917bso1807794fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756574865; x=1757179665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTyHRy33PmQnftPGTy/Bo7T/OCDGNcWJjyWm9Y1PPiA=;
        b=isE7FOyNdJq2dhIlADbgCS3ItFbOG8V4AeLpv/Esobi6ifxuuXz8v7mTFUOi8fjWjw
         GfBePZFHw4Y+LF3xHNjm2w8nbB1BvOoYJDbI7yW724YntpnhPi7SEhA1X9kk/EH/IFXO
         jSZDz1m04ydU6cQ8Q2RpVHGmad2NtWMkeXnRIOqbisxJZ4c42RbRCMZrmKE8LMFmXILb
         /zAwBahujtJ8QdlNPySLCwcp6A6fV4C9rYNunb7SRaTMJSmDoIg5UV9nTPkdSgPwoNyd
         /dhAa9ee+XyWydgXJpzjSr6pdH6d+fPeaji1e1uQbIsdtgsMN8mkyDLt+H8WojD9FtIf
         Sxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756574865; x=1757179665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTyHRy33PmQnftPGTy/Bo7T/OCDGNcWJjyWm9Y1PPiA=;
        b=gtgMZsU1OkmEjO81kNgCn1xGPCEuPc7gLERE30QBYCA9DtOAOYphG75mawfuCR6pKY
         6u10xTiUujzUQXrMhCQq/gSgim4FCpY+Oj1wAN3IAgPTxgOndT5jwTbxevQmXWy9KO2p
         vb8gr7kAUXUJUTkkOSncCI1G0hbBbuvVCoMBr8P6c0C58p4xyL9nCYKAPf0bQfxjNeqH
         zqn6P6cTcDVJfXu4lRz0eJjqXsFoBjFsnTEJTvoFspdg123TWA5KQORbjQ+aHKD2hjII
         sXR4Tr33WjdJVtj/cQ7yoLih9e1i0tI5VCxgxthdGJ2gqC40/EIv2Tlp808v1Zjfij/9
         FPHg==
X-Forwarded-Encrypted: i=1; AJvYcCWX7IKXUXZ1wIqND5XH9RhEavCPFoWDaeiq9k4ZT/pm2a2C3IlRi+GicOOsLlDR1R3e7mHVk+8rZK2uozk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRp+pf2gWDoxqa5FDQRma77JN2gitJp5A/lUNqhbauuFgplCmL
	QweNVv97IHBQT86ck0I8uKxg8W1fEjCFfPA7kvyVImTa8rUkYc20TKnqDljpHLwRAGI=
X-Gm-Gg: ASbGncttnQfAGwoM9Ib4aleBo5CqwY3IDvaVBZASYqXEXXsEzMdcZ8finJsHcXU8OXl
	A4Rnvs3ymPZ57zciHOHkcEqyMQdVi8WeAXVnQ5m9RI/sJnrAQcHmFnTuw/hybqtcrVcqBuObUmK
	y13SommqNk2MhbhvanEuXzGMr/QynPNraXcCwKehOW/zdLmrA3c3zkaSKJYtAvOwxS7ux8xp1N7
	P0p/JmNSJpmIyKTM3XWhOrnSlBn+hMgnL8lfr7jxXipQP73u9MKmBkcNcsk8eMdNU8CREu8/6C6
	uw/fdouzJkgdqbXoZhFj8yt6X2UBS92GZJc9VbXBhOi12VfSup7/Jr4tRPxnraPSjXekfutBfx5
	1cBDEh1dz7+u2CHofSQ329YCno5MPD/cl66ohqNgUgrgyNUQtEdj4gu/6vP+/0wEIqNdDq9zEcm
	g=
X-Google-Smtp-Source: AGHT+IFru+arWS/AceeMu4bhAm1TOj/b+D2hCYkTnV2EgYzzfyEcSXDo/b8XHFyG33V9MkQqa25uBQ==
X-Received: by 2002:a05:6871:8a7:b0:315:3453:5a1a with SMTP id 586e51a60fabf-31963386930mr1249422fac.14.1756574865348;
        Sat, 30 Aug 2025 10:27:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d24601csm373137fac.2.2025.08.30.10.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 10:27:43 -0700 (PDT)
Message-ID: <5d03a10f-5281-49a7-b578-b45d7b69209c@baylibre.com>
Date: Sat, 30 Aug 2025 12:27:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] dt-bindings: iio: adc: adi,ad4030: Add
 adi,dual-data-rate
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <e65b8b6b14c8083a48915a7bc40b7521fc246860.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e65b8b6b14c8083a48915a7bc40b7521fc246860.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:44 PM, Marcelo Schmitt wrote:
> On echo and host clock modes, AD4030 and similar devices can do two data
> bit transitions per clock cycle per active lane. Document how to specify
> dual data rate (DDR) feature for AD4030 series devices in device tree.
> 
I don't think this needs to be in the devicetree. Dual data rate doesn't
depend on wiring, it only depends on if the SPI controller supports it
or not. The core SPI code in Linux already has dtr_caps for SPI controllers
to indicate that they have DDR support. So an ADC driver can just check
this flag to see if the controller supports it. No devicetree flags required.


