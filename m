Return-Path: <linux-kernel+bounces-757869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78EB1C7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36CB189F511
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8628C2D2;
	Wed,  6 Aug 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC5Iu8gx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4611A262D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490915; cv=none; b=ShevBiZXz5+QcnvcJa/1k/5HtFw0ZoMTTHUR6nunEFj/61ZnzHS6pGkQmLYIAK8BXVpOyYVoNl+Y50Gr2YskAv9xX6FdH58sDEYzxjFIpUfLnHX5ggnQpvDhWwmNwTbAJ8wkaUtJono9U6dAgJrqiqgh/I5nNarV653LHpJkb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490915; c=relaxed/simple;
	bh=Gdg2q0nO1eUnubIvR9x26EdENHNoUnaK4hFB9EMutvc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FJ48lKceZFQuFWJyyKODD9je5q15taXbhqi4lBvKjYr78Cfxp6Lyiv4ifAqArgBddBYl3hTaN/g3iSi56bs+7Y8NJyT3yMYkQ5eyrKmZZEgAoGt32dtW4owlcvfIGy2N5nQBI4bZfMlAnOBgPb4OMvR/oIJCTN6NS8TkyBUEHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hC5Iu8gx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b783d851e6so5833508f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754490910; x=1755095710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJzc1Ie8ZeRZJLHRDEZNI9VK1kwQWGby17uL65M37Dc=;
        b=hC5Iu8gxttB+BuPyFgYCyEKyrWctUBPWBZDTApPMmgJBNp19H0I1BT1wZ+tX1Cd18S
         nNzY4IPOwj5fMHJUX0J/H+wvHOw02N8t8N99yaBu5/oK3aKW9o3jU76Y3ZdGbW2dUtu6
         BXWqe7i2bU2XnsKwetmVIP8OH0ALpDUDsVS5p3xVRhYQ6vMKRnZBM733Z6FJM371myHt
         23p6rkduRb0z2ToQ79QyIRXkseL58de8njvavnJNgpuJ73nMH9bGqHc6AGrHwXbOkkZC
         VXpCOD76GVVDjGMN/JZv5JEBoHIYIt+dX+fnmQqgKUtHOta0YUMpIAcL10dSzZIid7j/
         D25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490910; x=1755095710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJzc1Ie8ZeRZJLHRDEZNI9VK1kwQWGby17uL65M37Dc=;
        b=TI8uz6IldbkblXihHIXoFdrly+HBxxIiu4OrSMYEbSj8Ls/iTuwo+fXog1xlbsudXx
         a4SRdhAMLw9patq1RIAGMIb7py5wHlCKTLGXrWFtiWcxQbB/TXEapgWfgdtKdm1Cvfin
         I4SMRgi/njtgGy/rE4AgHHb7DW+MWg9TSGPrQy2VkkMCaZ8ndISWrzqU9xj1dp2/oiQJ
         MacWvHlZwKTb+byyKlIiXsN4DJEyYJa7pE7XFoy/+FYnP0XXNbif/+YymUjrk5KAao5D
         Jml940Da7J1veFAUPcHJoUmtKQc6/mniAERs9UNmJ0yYIYDFDyKRz0sm/zn0/SbaS1DO
         qc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXcAa6m8f7nLpY/v5lYQO6X1nzcnU97EUlGM4+FHyIzDNM8igcd+viaePepxvh/xCv5OajrGbcJl6HaKAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2djqaTEwqoiEVSsOK+eWXmXOpoTBMtoWzy83bu4S2bVOC8+sx
	JW0oX9GuTw0tmGflWIiWNwaQ3ZjJ6Ru1CaqylAOt4LI7er5K/gdodol+GWUcGd6Vbn0=
X-Gm-Gg: ASbGncvIbu+yJtdMEkpy0FSlwbYMOUm9n+vSP07VMy+/MZNFvcWjNq3X448gPjJkU4D
	OMqKNxaJBb9X1HsZzO22nl3CUii4QsMHFz7bV2qMLboXvv544U/0PHwTl+aJMkJ3CyD/c8BpqIR
	hiJwnT4voHk9SzauYmaEjSijnG0MQbfHrPj1xKg+LUcj4h0K0EJAvv0lzffjQmykfREFO7etTUv
	DTGYnrxj7ZT3fURaoU3Hi3qAzzu1qELqUdBj803xjfyNDFxjxcFIMOCkZ+pxcQcvfEV7PBTYY1S
	DB/mgv3ZnCUaTJULKlyEAzsMiL/J9z0/9YY2whszidWi8AOM/KtUM0mMi1miSHibRJ5r43bSWUp
	fTru7DMbZjr3sJwfK8GDNir2Wh4F8Ylfy1Jy3oHekHsWEoPREUZLt4GXWr7Ubvtt5baUnHkvuMC
	JUkvdvvRWeDQ==
X-Google-Smtp-Source: AGHT+IEAXyxlI41OWv3pHMxNrEhn7RvnN6KDG2HHhhaewkU7OtAxqdP/oKZJiYzIeHj2LhKOZvR3QQ==
X-Received: by 2002:a05:6000:144b:b0:3b7:78c8:9380 with SMTP id ffacd0b85a97d-3b8f492ff2cmr2300715f8f.59.1754490910337;
        Wed, 06 Aug 2025 07:35:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm126681535e9.27.2025.08.06.07.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:35:09 -0700 (PDT)
Message-ID: <92042af6-e498-460e-be88-8c1f1b4d74f9@linaro.org>
Date: Wed, 6 Aug 2025 16:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] phy: tegra: xusb: fix device and OF node leak at
 probe
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-phy@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250724131206.2211-1-johan@kernel.org>
 <20250724131206.2211-2-johan@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250724131206.2211-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 15:12, Johan Hovold wrote:
> Make sure to drop the references taken to the PMC OF node and device by
> of_parse_phandle() and of_find_device_by_node() during probe.
> 
> Note the holding a reference to the PMC device does not prevent the
> PMC regmap from going away (e.g. if the PMC driver is unbound) so there
> is no need to keep the reference.
> 
> Fixes: 2d1021487273 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
> Cc: stable@vger.kernel.org	# 5.14
> Cc: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/phy/tegra/xusb-tegra210.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

