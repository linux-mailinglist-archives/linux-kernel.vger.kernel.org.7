Return-Path: <linux-kernel+bounces-748387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552FB1408B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B7E3A7CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B4274FD4;
	Mon, 28 Jul 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VWD9rWi5"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A54218ABD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721018; cv=none; b=KBteaa3mNuj53diZzrAI7HgxhVSpfvvH5OYpTY0pCoAPSz/mtKoxPifSVNIt1S28hYXsCtDS25mgpbycpATC+4lXCuGOb3a1nYKJPyUleYqdQaEI6soKO9CMSU+fF7ensF00XlP+dVmfY9aAOaeF5YP+J7xJBaWcBUYo4DX4iwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721018; c=relaxed/simple;
	bh=rhjEXzsTwnZFAF5osPavXR0nQ1U3valXq3FCuGUvhIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfgcfFABqFjrd7cnaZRgbworZ9J9EkHn4SIeho0YqIg3pZiAGMlSrujKaBTB3P1XzdyLsGccjX7cdj8CLGXDWykKRwkGhK7p1qg5tE3M6d8ZyQjI1J7Jbc+9YFrXseM3XDWeuYVCb3sluJNr1Z8R5yH53FxhpgJXWk7lwXMBlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VWD9rWi5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-879c214fe6dso86515039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753721015; x=1754325815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldQSwkThGxTZIExSscNpx1zCzTVrhc9kUZXUJm0UXLk=;
        b=VWD9rWi5UNPMCHl7NEdL4Ys7wh/esp6/e/I/jIPXpju6XdeXEdXn21Xn0izSlqe4N1
         SnMTazPnnxo2KTbusPTfh8U9QpeHn4380vwAwd5kcaDqqpLASZSdOcPX4jPP0Tb05Lw1
         5Wo0RjcVP35m84lspTgoemGsQiH08rN3kYjJMsUS+3IqFn7p+iaXEG3VUNCMkTOhPGxz
         GQDajRTZK+cVWnxOt/Y/5oetlqYt9Gh5vILY8F7q6ltSPGLlYu1vsSy++f1/Lv90uASr
         fTst6mgHuW9rdf6BFqLKMGL0GWxxF5yy8Q65kkPbf1S1mDIFz3jMoKQ0+5Le+Pue35q4
         3ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721015; x=1754325815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldQSwkThGxTZIExSscNpx1zCzTVrhc9kUZXUJm0UXLk=;
        b=ABsfRHam5/nO68MDSDxncaDfjx/PAhmQ3Ylyq2U3HhH5LafCYJyjgkGVgNGYSR14WK
         NRTPEXdEF9MSomgufj13eKGZ7M7nIKIUlXdxpcOVPrS7aiQxZxk/hptgKPYnVz0EsCuk
         MybcR/89gKsfZcQRA0sCTAkJ6vcU4n84c/44IWEfwfxbIUDLiUdctOmjRdMfAPF4OfBx
         YMMJToh6T1Es/v8MYgCxMQS/59x4cnpYjZSlVGu+Ijxa8FrIJeoPvwuHOMsUL8JbgaSG
         A5qiO1xWMvQgLJPZiMvdrpXA8NGyNlatgNXy4+8OA0UYm5J4ZCHG+0PKE8LgGR46T7Re
         1GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJkNNrzpf4DRHGTJq49b/BFcSXn5Spm1egbWGL9gNVTcP06JN3HAiz027l/OYGJOQ3jA7yxkqBn0tgcSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNh3kcrYoGVeuFZW23rpKC9M0f/IdiKxp57ZcrHnpcklFzx+b
	BdeQWA4pqZnPpcTG6qrZOswXeGh65d9FMOtSrJL5FPtNm6FQKwj6hklyOHQCgF0X/f0=
X-Gm-Gg: ASbGnctxPStvvZM1IHN1rppq5ITgUwPXsX37v8C29elj0/R/ed97kyZmsbMUkiacZQA
	TuhKZF4CC+BZUAIB8jYxvYN2n76usLvxoeaLOCvnYC1Hgxp+utMck/T9YGwcYaRGNVwKx01Mxxc
	BqOq6qGwCR++YgDRQcsG5maBqvGYcG1Hb+UU/zYbooSLH/opEfPGzHhY47pq2Ama21Ss7TLV0Yt
	X6Lor0bC2PWlv7kZ5+mjUFSPeAfehKMTi+5Q/caRzkvcZtsGipJ1zLoJ9bkn8m82MKSXhrUe9oo
	OElzcVdwOmQOknvWtv/g4cSGOL4QuN4GfwrZJEbNVelkoVcoEzSUbFJjmrdapNXiPq2ukEF0AoI
	Weho9TIncPQe2I0m3FbEjEAFkbp07ttrIX0Ro6hUwQIkolBlneP8q20knr1Ro1zg=
X-Google-Smtp-Source: AGHT+IEKf13G5VVtKix2Gq667g//FiBaGINonaogdX3yn8hZwcFv6711Pe8N6gMwP+Vbi5i7MjtaZg==
X-Received: by 2002:a05:6e02:1805:b0:3e2:9f1e:e291 with SMTP id e9e14a558f8ab-3e3c53125b1mr209554715ab.21.1753721014595;
        Mon, 28 Jul 2025 09:43:34 -0700 (PDT)
Received: from [172.22.22.234] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3cad13c7csm25861755ab.61.2025.07.28.09.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:43:34 -0700 (PDT)
Message-ID: <ef2b4526-3725-4a25-9118-ab77a1d91362@riscstar.com>
Date: Mon, 28 Jul 2025 11:43:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] regulator: spacemit: support SpacemiT P1
 regulators
To: kernel test robot <lkp@intel.com>, lee@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, alexandre.belloni@bootlin.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
 Necip Fazil Yildiran <fazilyildiran@gmail.com>,
 oe-kbuild-all@lists.linux.dev, mat.jonczyk@o2.pl, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux.amoon@gmail.com, troymitchell988@gmail.com,
 guodong@riscstar.com, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250726131003.3137282-5-elder@riscstar.com>
 <202507281558.lZ0NYtth-lkp@intel.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <202507281558.lZ0NYtth-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 2:37 AM, kernel test robot wrote:
> Hi Alex,
> 
> kernel test robot noticed the following build warnings:

I have a fix for this, and will include it in v11 of this series
when I publish it.  I will wait to do that until I get additional
feedback.

The fix is to make REGULATOR_SPACEMIT_P1 depend on I2C, in addition
to ARCH_SPACEMIT || COMPILE_TEST.

					-Alex

> 
> [auto build test WARNING on d7af19298454ed155f5cf67201a70f5cf836c842]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/dt-bindings-mfd-add-support-the-SpacemiT-P1-PMIC/20250726-211530
> base:   d7af19298454ed155f5cf67201a70f5cf836c842
> patch link:    https://lore.kernel.org/r/20250726131003.3137282-5-elder%40riscstar.com
> patch subject: [PATCH v10 4/8] regulator: spacemit: support SpacemiT P1 regulators
> config: alpha-kismet-CONFIG_MFD_SPACEMIT_P1-CONFIG_REGULATOR_SPACEMIT_P1-0-0 (https://download.01.org/0day-ci/archive/20250728/202507281558.lZ0NYtth-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20250728/202507281558.lZ0NYtth-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507281558.lZ0NYtth-lkp@intel.com/
> 
> kismet warnings: (new ones prefixed by >>)
>>> kismet: WARNING: unmet direct dependencies detected for MFD_SPACEMIT_P1 when selected by REGULATOR_SPACEMIT_P1
>     WARNING: unmet direct dependencies detected for MFD_SPACEMIT_P1
>       Depends on [n]: HAS_IOMEM [=y] && I2C [=n]
>       Selected by [y]:
>       - REGULATOR_SPACEMIT_P1 [=y] && REGULATOR [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y])
> 


