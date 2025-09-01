Return-Path: <linux-kernel+bounces-794486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7235B3E282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE8201B50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2E212556;
	Mon,  1 Sep 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEWxgWgJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9226D4C1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729238; cv=none; b=VpPol9+SIwIpIAIQwHAsbciyt1QPTfRUkwX1JMFg6G5R4TytnKHYFfqw0eBDzntrlGdpsMv2qulJlfecXTWuEQzO/41qfY4HZSYgvpS1s6QjxRuo1q9DnVQKR/oS3ch3/InlLrRcK3kd5QJUXIj04mfdJT0MnDCiHFB5ojtXaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729238; c=relaxed/simple;
	bh=bGXiQWuP2joVtz5mi9GkdStz5k7fcbMaeihQjtKUsLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V9oF0ENctJPy7KglTnxE1Qd0TWOBPDdTPzSi7SAXFj2VQ5xS06QJ47DxdAiled1t+242jriZBdDAxHQgz3nZDV5DdQKEZq+eyhbpnlbKd+Mn08V08WLad7neLZj8awkE2avarqCreYnW6acdiZB9DwoWjG91ou6h2bu3ku8qyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEWxgWgJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so6026085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729235; x=1757334035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjeTTnIl0jOEJud+l5JHju8hS4DYKMB3s9qvufpCuog=;
        b=AEWxgWgJitRvGS2LydjpbzyeL1jgpTB8uOYuCyeHzNjRI0G+9fQBK9/ngRSa90Ybuy
         gGy6Mq8ubHw9X8QqEPq99MvUoySHGmpUjK2gMtN2RLuGFlznkS7iPx5ytB8MMNkqHaLb
         0dTPD/d21idn1UmsXx2LzEXUgNV1ELtfIyHu2awDrEmQdNmq7qkqq5jnYAOsN2vLjVya
         J5/0R4jkV1vTTttGzx0ZbAVqhwqBpF4IWbLxw1+G7GMZxu4zxnjLT5md+pQeiTBuli7k
         UvTkVQov7/I+rfSddL1Vdi4QngoqZvRUN2u0ns+BUhNFuWJcaiCbTP3RsuvbrJ1UTxjC
         7uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729235; x=1757334035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WjeTTnIl0jOEJud+l5JHju8hS4DYKMB3s9qvufpCuog=;
        b=GZCVBN23snIJl07zieWmDMlSHLXRfYmvhAO/iy9VOZLTp9XRSkcLxSCT42iZyxqZrq
         nyE9zaBqL6n1BbgNHNrYEK0Ytk8IyZllGq6Ns6BS6E1b66uXi2V676LgfqTHgQqlQobg
         hmfPNof5zCSwX2HN1KhDj7thdr+1IUP6EguvNFgfD4s+Tit55Qx6Xr95vy6xFFUWivp3
         3rU1TaG4XbhcJOcaRdJTBJfw9twwiOSzs9uddLgXqRKKUIfVcyB+KvtitO6z4TRmqolS
         wBvT3gWtO9i9+Ur/M9qw4pdQZ6+EU33od2Y8OOGVQXy0gGz/C84clWeVrv5H2o+Njm6T
         1Ptg==
X-Forwarded-Encrypted: i=1; AJvYcCW7w9oWwempmMyE0fHVZAbsjXGKvxXqZf7aPRfhAFEDSca4eTtZTrvG7XMHRxeWDIyLz8XNkL7901+Ik8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fnk47+DxlXEAlYD1EpWErEv6zA+YX0BzlzXiO5QYp9iU4fqQ
	X98Choh5lv/1el9RLwnqzaV7gr6TazmvuBj78lOBbTqmORjzkRbEGtpQqYgG3hD80QI=
X-Gm-Gg: ASbGncuSAHsz44Xz+qH1SQxi9Rzkkx551GJThWWrIgEzqh15T4G8G0AGIRsoNwzCDMx
	u82ai7cvZ1GQ4qPZ3CYi8K89TiYsseK9/D3TarB4DD0xZlWWJnjwfJihZKVoymxATJOWw1fwz5m
	705MEgt8Jaz/dl+xAkNXHHeH17BYiVNXJZwgRf3j66qrsr8O4WZXyAXvQZn8BZ831KFrQAF+/NQ
	bYxdF75OIg6YSAkq6IAd6wF4nZW37G7SOT2rl/roAAIh25G68A9CVsLCYHRkBltIQSTzfYhCH6d
	HMYbLHMSh09yy3rd1wdG4q7/8ldYVb/E7zPo/SvXMQ4kPk5pmWNAz43XRGxQ0cMvVom0U0OQcCj
	9SlUBtU9ERJR+bw7/SNHg7hs4XgqRuGKgAvqOOEE0nCatwoBbPuP/gmitiOQpy8VG34qcLS538J
	0wQX2Gw9c=
X-Google-Smtp-Source: AGHT+IFRNIETqpB+2jIgi5Tu/QDZHVgu9dKwYHLpUPiWYKQcXey9hx08WJgHdQv+NvmQy5/dFQ/3Qg==
X-Received: by 2002:a05:600c:524d:b0:45b:8a10:e5a7 with SMTP id 5b1f17b1804b1-45b8a10e8c5mr45748725e9.37.1756729234802;
        Mon, 01 Sep 2025 05:20:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a? ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d45daf3293sm7429476f8f.48.2025.09.01.05.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:20:34 -0700 (PDT)
Message-ID: <0d471827-16f2-4eb4-9212-82ca20a1c0ba@linaro.org>
Date: Mon, 1 Sep 2025 14:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250725074019.8765-1-johan@kernel.org>
 <aK7U7-ebrPcxwEIj@hovoldconsulting.com>
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
In-Reply-To: <aK7U7-ebrPcxwEIj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2025 11:50, Johan Hovold wrote:
> On Fri, Jul 25, 2025 at 09:40:19AM +0200, Johan Hovold wrote:
>> Make sure to drop the reference to the secure monitor device taken by
>> of_find_device_by_node() when looking up its driver data on behalf of
>> other drivers (e.g. during probe).
>>
>> Note that holding a reference to the platform device does not prevent
>> its driver data from going away so there is no point in keeping the
>> reference after the helper returns.
>>
>> Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
>> Cc: stable@vger.kernel.org	# 5.5
>> Cc: Carlo Caione <ccaione@baylibre.com>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Can someone pick this one up (along with the compile-test patch)?

I'll pick it.

Neil

> 
> Johan


