Return-Path: <linux-kernel+bounces-812366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41177B53706
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433BD583967
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECA346A0C;
	Thu, 11 Sep 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0dxe1ZU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F93469EB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603505; cv=none; b=MnDFfIPdnRgWL0iYyZppoO0jr7slZAjzvV+LVTIEP46exYFBM4gaZbmQszEHnxzVa4hyZo/rwnlQxGDww6Cc8A7WJk9ZilDvRDWfi4+GqSwkvylt+49zxkiOgL406UICrqj41w54UthQe2qwCAAmJCAkNFPjvHnNEVsTQsADtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603505; c=relaxed/simple;
	bh=e9kv85eYZpW09Sz+LBjMWCQsY/b15orHC+8wBoqJAFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf7bu/IFdR07Erfxo4fFFHGVW3jiCAK+WL4+CkMflj7+TlRjWP7QoKvCVLyAg7ls46w7iJaS4+jlvPh1jAUxmrKQxOCRnk0klirI5Xcox7Cox8Jd6qE6ECgJn4V5tpSKj67G25cCtYhsFPMHp9bkEdX0cQk4WEZZiLS97/8CU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0dxe1ZU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so1747498a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757603502; x=1758208302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJXD0d9dznPgcTPNThW/LqxiTrPZwdyiS6ep+9wlnic=;
        b=b0dxe1ZUOP9q83YrjVN5dEeNykK1nkVZ5ttP6fYQQ65yhPNinj6wrjYyKq97Zeu6KO
         OU1WhS/tSlFkggMR0S55m3VzrzEgnwG/XfS2m6wjCS1Q6b0izTZQ0g1PWzGJEsTVROV0
         9GhQ+7W5VCRIrMqmMlMjQ3U+HCZNdHC/fsRrELJPEAK+pLmA1W+10lo2ZkHsRY7+PYuc
         iZF8Bu6YN8PpaMNc0cjMPyjkyCerm+VLS8tT6zLxAPIlsZSAb1JHNREcxa2m6YHKnLq5
         kkM2p7+gup70AzZHOlzmRE7iTSZ6/squHvZYlKEgjND3GmpeYliqGQjZM+/2uw96vNkm
         4ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603502; x=1758208302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJXD0d9dznPgcTPNThW/LqxiTrPZwdyiS6ep+9wlnic=;
        b=WCHVyfHmCM1CPsFokJ4x5lApOFxNUkV8hjmuqc9BThlMgAXiVsey3tjlGaZyXfsWMb
         3jWAmwgydPIhAearT8686EBgo01iCtP62HfhswtU6Fr9c/gqba48oVZ5OAszsKNq/f2j
         Hw2dO/E+bWvM3nHEG5te0iQDbiFAhIxI1iLXU0eXI0OpPSrV/DAC1MWGM1SMBId/D+3P
         dATuUWGrlYBsGnJTErUmkTDeKzul3+GL24jiCPP0lGTkfTjeU/xTHpZr1y5OM5X0mfO3
         zlDSMw3I+X/O/6+EbYiPAK/ueg6nEP/iCF8Q2fXAl4SUzS1p0Jw3Pg5Wb5eqYikpPuK8
         xVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVY3vmOO2BznRmN85anHVcr19UbYwkMKgxBoQdvjLFXxYLnllYlobQyK3HlX9FXdGFTv/o7M11gZeja8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFv5Tcqn+dIXz4zU6Uezwc7OIpcMzJnSn+ExYnDnwXeqlTuQ/B
	P56ZVXEf1zksE+CHoqHTE5uhURMQ6ooCmCZno7nIWXAOhgllVoBmhhna
X-Gm-Gg: ASbGnctPiD6A4G/2rVq4MFrRq4TXfd4P+pdYpiAhYVc+Hh2EvA8XMQsgiTmYrRIFil9
	aBN2TiIpF4V3MhMGZ5s2Gxn6Dxh9+WjkzMl9jwk0IZPtKog+KAJPq6RxDsROotYPccvSZx52p+m
	HAY91RMytuMHxJYeHhl4kBa8VkJUfXORgyNB48CKMurs20UfoqY4iYTmRGgI4Wu385jBteG0YPy
	axWj5rF9DcmdrSVyeQ2Mfm2yn4NO7r2FeMdrfUOikNKcjYPGpPmC3IX4rluWOl/YaLG5flfrWF8
	AP3H10P3HR5Y0XZohs0sA8QHMMcRPBo2IF0p8a6DmsPJYL5bMX770UfQ96t3DzD8ZfP1Yl+cxuI
	vTj9jrLo00MiD55GLaCQ2aWFv68pIyuNQPqrAakceWVMXPplD8AYUW37sdZXL/zJB4RsnGMg=
X-Google-Smtp-Source: AGHT+IFu/p3XCl9aAF361ZEinW5yYkUkoSXzrLLXvUd2NuKZyhoe8iX783XV/nHzhkHTR9LYfTKaug==
X-Received: by 2002:a17:907:3ea8:b0:b04:25e6:2dbe with SMTP id a640c23a62f3a-b04b16d8182mr1906360766b.63.1757603502321;
        Thu, 11 Sep 2025 08:11:42 -0700 (PDT)
Received: from ?IPV6:2a02:8109:8617:d700:fe0f:5a9d:7cd0:4679? ([2a02:8109:8617:d700:fe0f:5a9d:7cd0:4679])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3efsm148194566b.55.2025.09.11.08.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:11:41 -0700 (PDT)
Message-ID: <bfe25a26-fef3-4ab3-9ae2-ac9245fd5830@gmail.com>
Date: Thu, 11 Sep 2025 17:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: i2c: alvium: cleanup media bus formats
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, michael.roeder@avnet.eu,
 martin.hecht@avnet.eu, Tommaso Merciai <tomm.merciai@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
References: <20250909135938.2841635-1-mhecht73@gmail.com>
 <aMK9PQ62EYeJpgeo@kekkonen.localdomain>
Content-Language: en-US
From: Martin Hecht <mhecht73@gmail.com>
In-Reply-To: <aMK9PQ62EYeJpgeo@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,


On 9/11/25 14:14, Sakari Ailus wrote:
> Hi Martin,
> 
> On Tue, Sep 09, 2025 at 03:59:37PM +0200, Martin Hecht wrote:
>> This patch removes MEDIA_BUS_FMT_RBG888_1X24 and MEDIA_BUS_FMT_BGR888_1X24
>> as of that formats are not supported by Alvium currently.
>> The missing and supported MEDIA_BUS_FMT_RGB565_1X16 has been added.
> 
> What's the pixel order used by the format in Alvium case?
> 

The Alvium has a fixed pixel order currently what should be BGR during 
transmission of any RGB format as described in MIPI-CSI2 spec 1.3. We 
tested with MEDIA_BUS_FMT_RGB888_1X24 as well as 
MEDIA_BUS_FMT_RGB888_3X8 for RGB24 in several SoCs like imx8mm, imx8mp 
and Xilinx CSI2RX subsystem on ZynqMP and Versal.
Does that answer your question?

BR Martin


