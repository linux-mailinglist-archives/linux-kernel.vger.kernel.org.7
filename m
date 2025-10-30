Return-Path: <linux-kernel+bounces-877755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E35C1EEED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 297634E7747
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1A30E83E;
	Thu, 30 Oct 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jw2Z6WZ4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7832D320E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812266; cv=none; b=JrhxV3J8Nzrvv+SqXL2C/KMngkQy1Wr8behH4/0Efp+2WY4UvbhkNvlomgUcbkx1XJ8VgFPH1WFQFZKHEwaQXs0IiX2jhpZyJKfjMiOaAy/ETWtquBiKkXTC/HU38AFQVg1dQX/pXRtNctW1/4a20+2/DjJ2wx48jr4hyyAcY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812266; c=relaxed/simple;
	bh=zP3YBLdnAN++d9NP2XCFHXb0nsnZpFzGgmTGgvfZMtE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s/Rw72GlRJYt/AsI95wTr9ivolqv5zABvYzcnRJBCMgg89C9jautcQ7XbgdCi7exS7Tsenh8zUNMZLMZU+3g2yW6psgffsNyQ5O3Bf1eiojvC4BZu8ga0hkbXx1inYB/gny4ZErQLEIPpXBoiAOLEpyQ0Wmes29cUpyqtnRWCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jw2Z6WZ4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece1102998so503437f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812261; x=1762417061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gVKZ9YN8sZoUBOLwjil9dfNLuOB/p2Y81xFPY004kY=;
        b=Jw2Z6WZ4vu/B5WW/F6o1aN6aL1VBThEEURGeA1ydfyL1U6IAAt/InheoYAwIPI3Jq0
         RxmN+yJm8swHT79QEc2LUEKSupiBUqY58s2j22X81T9fN1Vd5x8vbe80TRelpP5j9vwI
         3TKYZCN/Ul0zqtrG507ef9s4XW2L6Ckhj9tfwSZ70v5wZfwWlwGNEBg4i3tioNfGE0Bu
         e3kaWHvSILpx2kbrz7IMf8FGu7sHXBr3cjIRC4FAyzcz6reDBHvjSo6QDJjr8hxQXZXD
         jNoqfREnEKB122HiLqnleCH+OYqVSdRndKGOu1UXu8jkgeFgmEijN/MuR45/QGjSxxTE
         QUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812261; x=1762417061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1gVKZ9YN8sZoUBOLwjil9dfNLuOB/p2Y81xFPY004kY=;
        b=NaJWnvQlXKCleEDX9t/fPl590CJA+eQw7uHsICwxScOESV40xEVuzkPOVJA7Dfn4Wp
         T1lLUUD658aCh064QTdVLhVaVd66I9LNY9mzFpMDtL8SqMWdazBjXsLf37GlPb8Vy3Xn
         i6tDysGmpr+WssRG0x54hdjY9Yn2QiXJ50mhLPk2ERntIAszj4PeogDXMtua9M48qAOP
         FwegjWeoaa3iWJNaqyhwbO7cmSEuSGyTTukvBy9qHCX20ChXjlNzzMTGGB9tehs1WL0W
         kK6znpwklNkmhj2UIT+S3Rgba0Yoj9zTh87HTv0RzfXCmDjDqcbd1NhEfXuuJMD+xyQo
         XG5w==
X-Forwarded-Encrypted: i=1; AJvYcCV0ba1szwUN2BF3nk4zGmev2I6dNb1ESy4zmfctpzGdpNj0pud2k3Fmedb3ycSBQinsek04zTvw7GtiD0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoUGFZ2L6mpvthCMmV1qU3ShoR3nH3rjTGFU3uY+zDGvw7cSD
	644hel1GYgbxBeoc/uXKF7mHeC5hMbce+s3GgBNlJXwb0suR/+aIYa6/TZDf6HWt3lY=
X-Gm-Gg: ASbGncsS46Ag9s2enPz9qrpgXctgYMJ6jvcQIW5HILb7uYGNR6lQtdCdz9zcXPGI9H2
	ONTpl4qmuPC1t8+GgEWb/4GCk85Z0g+GYvM/nVSpb9OrQcJtg0dCvYoytYiHWpO5sv+RutEpyV2
	7wRXvRTlB5YkwkqDDSb/+uw6KSz11NsFjJwUWHCZcAOTDvADyYn5kZNYQB0zMwOBHGfLw0SU1ls
	MD8aYKiUcjLQQ75GN0l2/SqIAIUmcPKkKK6ipAzWlNyl4kOWSwnGt9G/Jcppi7NJZtnfdSSYBKQ
	EaSUV6RtbKQXhHxAwN6pSXHhWa1g+9AZcAMgwrv9Aav7jL0SwvQJcMEXgY5UubVKsPtHQEPLAVA
	OYhNi21E2WTpLb0QBTISewhGBWZg7oibyrmMhIancoXVaZStkrCV6s2rD4s6ijjoqmfnnoZVfXK
	QCxCedZcfA+MDom9bzetOoAfSvPxBmKXgOcxTiRLMDIYpdTdHnVrJ6
X-Google-Smtp-Source: AGHT+IGRMDnVKGMZu+9Y1CP/bFmSno7jyht49nowkG0CEnVkboBLPR5O/60eu2OsoH0/Yi48rzAk5g==
X-Received: by 2002:a05:6000:43c6:20b0:407:23f7:51 with SMTP id ffacd0b85a97d-429aef715c1mr3237226f8f.1.1761812261194;
        Thu, 30 Oct 2025 01:17:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477? ([2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa8a9dsm26326715e9.13.2025.10.30.01.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:17:40 -0700 (PDT)
Message-ID: <8cd614ea-fed9-423e-a90d-8c4831426cbd@linaro.org>
Date: Thu, 30 Oct 2025 09:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: linux-next: manual merge of the backlight tree with the drm-misc
 tree
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Lee Jones <lee@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20251030151428.3c1f11ea@canb.auug.org.au>
 <86a0cf86-42e6-430b-b193-f60d6182f416@suse.de>
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
In-Reply-To: <86a0cf86-42e6-430b-b193-f60d6182f416@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 09:14, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.10.25 um 05:14 schrieb Stephen Rothwell:
>> Hi all,
>>
>> After merging the backlight tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:41:41: error: array type has incomplete element type 'struct regulator_bulk_data'
>>     41 | static const struct regulator_bulk_data tddi_supplies[] = {
>>        |                                         ^~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c: In function 'tddi_prepare':
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:72:15: error: implicit declaration of function 'regulator_bulk_enable' [-Wimplicit-function-declaration]
>>     72 |         ret = regulator_bulk_enable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
>>        |               ^~~~~~~~~~~~~~~~~~~~~
>> In file included from include/linux/dev_printk.h:14,
>>                   from include/linux/device.h:15,
>>                   from include/linux/backlight.h:12,
>>                   from drivers/gpu/drm/panel/panel-synaptics-tddi.c:8:
>> include/linux/compiler.h:201:82: error: expression in static assertion is not an integer
>>    201 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>>        |                                                                                  ^
>> include/linux/compiler.h:206:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>    206 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>>        |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
>>     11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>        |                                                           ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:72:37: note: in expansion of macro 'ARRAY_SIZE'
>>     72 |         ret = regulator_bulk_enable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
>>        |                                     ^~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c: In function 'tddi_unprepare':
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:101:9: error: implicit declaration of function 'regulator_bulk_disable' [-Wimplicit-function-declaration]
>>    101 |         regulator_bulk_disable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
>>        |         ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:201:82: error: expression in static assertion is not an integer
>>    201 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>>        |                                                                                  ^
>> include/linux/compiler.h:206:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>    206 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>>        |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
>>     11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>        |                                                           ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:101:32: note: in expansion of macro 'ARRAY_SIZE'
>>    101 |         regulator_bulk_disable(ARRAY_SIZE(tddi_supplies), ctx->supplies);
>>        |                                ^~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c: In function 'tddi_probe':
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:183:15: error: implicit declaration of function 'devm_regulator_bulk_get_const' [-Wimplicit-function-declaration]
>>    183 |         ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(tddi_supplies),
>>        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:201:82: error: expression in static assertion is not an integer
>>    201 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>>        |                                                                                  ^
>> include/linux/compiler.h:206:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>    206 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>>        |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
>>     11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>        |                                                           ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:183:50: note: in expansion of macro 'ARRAY_SIZE'
>>    183 |         ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(tddi_supplies),
>>        |                                                  ^~~~~~~~~~
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c: At top level:
>> drivers/gpu/drm/panel/panel-synaptics-tddi.c:41:41: error: 'tddi_supplies' defined but not used [-Werror=unused-variable]
>>     41 | static const struct regulator_bulk_data tddi_supplies[] = {
>>        |                                         ^~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> Caused by commit
>>
>>    243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header file")
>>
>> interacting with commit
>>
>>    3eae82503f4f ("drm: panel: add support for Synaptics TDDI series DSI panels")
>>
>> from the drm-misc tree.
>>
>> I have applied the following merge fix patch.  It (or something linke it)
>> should be applied to the drm-misc tree.
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Thu, 30 Oct 2025 14:57:03 +1100
>> Subject: [PATCH] fix up for "backlight: Do not include <linux/fb.h> in header file"
>>
>> interacting with commit
>>
>>    3eae82503f4f ("drm: panel: add support for Synaptics TDDI series DSI panels")
>>
>> from the drm-misc tree.
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> I think we can take your patch into drm-misc. Thanks for fixing this.

I'm preparing the patch right now.

Thanks,
Neil

> 
> Best regards
> Thomas
> 
>> ---
>>   drivers/gpu/drm/panel/panel-synaptics-tddi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-synaptics-tddi.c b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
>> index a4b3cbdebb6c..0aea1854710e 100644
>> --- a/drivers/gpu/drm/panel/panel-synaptics-tddi.c
>> +++ b/drivers/gpu/drm/panel/panel-synaptics-tddi.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <video/mipi_display.h>
> 


