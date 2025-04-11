Return-Path: <linux-kernel+bounces-599633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D5A85642
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98321BA42BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFB293B7D;
	Fri, 11 Apr 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPRDJ/7F"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A5293B4E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359248; cv=none; b=Jm8Ho+NmExvn08Zn/ir8kpOjb9XBOMev41IHvzKQyKdmz8YekSv4Xal3o5Pj20rTHL/XQtuM41a3SGdUgeuvhPYE3h8VUW7Ihk1+ehd/DD01MEJkV1DXAWggT/5m/v4R5ZdvXMyIklZ/gqkTSPGP+FHQOLa5x3BTGZvZsirKkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359248; c=relaxed/simple;
	bh=h30t4wZt4Pjn6cUP+0NNMHJSghHGv88Eq9PNP5TL56A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GiHakPO1GAzxznKdVlIhK9CprjRudz2+mduapqIkZFRrsDHS39knuwXPNenuGFe34a9l7li8qElkm0c0YyoozRUGhXego30jjcP91Rc2iqr0XKFjMHIHNOx4Jwij2nx5Eu4dU/xeNuOYduSUzjWCeiImVMFO8AB2d3dHij0noLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPRDJ/7F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso18752595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744359244; x=1744964044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpmSli+/PRnesyTG8X3uYfMysLWZm74irwD8jDox6I8=;
        b=GPRDJ/7F+uxa9gcIrHizf1wZL5K4q+erIKbiKiS/ewb+sMkI0MrQGtw0tzxiU9FVgx
         vjhkpRlcUZvKcv1SMIL3pIUJ+zOA0teoDS37fr54gCyppF4OR1JBRWUQMvahF0g3qsKf
         SEPRnLd/QkbVqEYQYT9ke/ojksobw2LDLo7pFIMJvnubnDrUtW3PtVTIFxaF6vl5CLUC
         Ii7zoqUXn+vrJ4lWRgNqqKYVRupuf/+I+Drv04blAcXGo2sCLVmY8FO6AXMCRX5G8/44
         a26wfE9C06fxUAuw7AhVpXjDUprDmt/vEqV/Wh4Ni6/mndEaeXRh7D7TA4qlwWG6JJjF
         crlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744359244; x=1744964044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jpmSli+/PRnesyTG8X3uYfMysLWZm74irwD8jDox6I8=;
        b=YWSEC+HrMAtWzOPcs7T3jXJmUX5gL8vPqVoOCI0swAaVeQBy2qSXY84AwvZL7SSoxl
         MzsOxtnYLddEz1CK1pTay3xTna+ZofHLfxPD8skD2m0T126EL5ZPuUG5OCKT1t+xOkfu
         wIk6VeEAT/RlolYANzrzKEivcrSWJ2fEzjqU052KPZbIeQh1wJ2Gkc6AbQltCJdR8wWv
         4iCRx2VYLrq5d7sb4YC4/xiiPYgJakwz7ouJDWy4htnC50pEWWB7ksH6gmmKlTSRFnhH
         s3xeRad8OW5eMUH/8Q6//b9sd1936uxRXCT7OpVFXjP4vfRoC+50pgB9TIxj5rHNRAuX
         Jreg==
X-Forwarded-Encrypted: i=1; AJvYcCWnMZR0FlMBbd2dbI7r+AdETe34GQMO5ty6a7bsCAAZQ9HlqPtbITHbKId5vwyTB3QxZy67ilVOJmcgQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUQrnJZiT+ZuSIy4OM63uooeMrS35RVLRteUO+fVjvUqBAgYQ
	ZiVtjqgx4VdbYQX5iE+XxUF2F2yHUIfF9AnU6GjSBvJcgEueJW3FGc1cV3d7sXc=
X-Gm-Gg: ASbGncs+1ZDiudbibuBaP6Eem2mNlIJFzUG3nuauJlmPBj9gnrElnDpzVH5B4hLznMz
	FUENzK/lwbe7lh9ZjLShWaK2QolsUIBtFJl7Gq5a+z0kkcXySNyX5HJN2XtwGE6V0fexFFhhfxG
	bZBVIU66hZJD6sMU7QLXJcJzKkEXp3R7At2TBJkli5Hik1fgO6CdrBdGMM62XvuyDbC+8wVjDHV
	SRel5opbAltym6Xj+O8ex8rJm5peVuuusSRKte/lK2FPaF27CFAIVW6+ZbcvZ5zUKNEpApWg4x+
	cSdcMh2MrlOAZmv57t8Oi1wz7FaQhm+xzPg8kptYA+g2yNcnoN1SQih55aSKWVo36OPASsl4STu
	MQjiJp+tEQcpL8k1Tuw==
X-Google-Smtp-Source: AGHT+IErTQ838bnzLuDWG7azdU/wnoTrkbk2g3cUSADDKy2JWtzBM+/zA8Adup+DY2KRAXkZ7TqHCw==
X-Received: by 2002:a05:600c:8707:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-43f3a9b485amr11552465e9.32.1744359243661;
        Fri, 11 Apr 2025 01:14:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f77b:949e:1d61:69a8? ([2a01:e0a:3d9:2080:f77b:949e:1d61:69a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207c8fb4sm79096785e9.35.2025.04.11.01.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:14:03 -0700 (PDT)
Message-ID: <f637965b-dff5-45d4-b6be-de8c68c6c397@linaro.org>
Date: Fri, 11 Apr 2025 10:14:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v5 1/8] media: qcom: iris: move sm8250 to gen1 catalog
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250410-topic-sm8x50-upstream-iris-catalog-v5-0-44a431574c25@linaro.org>
 <20250410-topic-sm8x50-upstream-iris-catalog-v5-1-44a431574c25@linaro.org>
 <vhfuhjruok7gupoeo2uloe525k7oycd5gkh67zzz4wbiwrczpt@i3qknymfu4px>
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
In-Reply-To: <vhfuhjruok7gupoeo2uloe525k7oycd5gkh67zzz4wbiwrczpt@i3qknymfu4px>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2025 21:44, Dmitry Baryshkov wrote:
> On Thu, Apr 10, 2025 at 06:30:00PM +0200, Neil Armstrong wrote:
>> Re-organize the platform support core into a gen1 catalog C file
>> declaring common platform structure and include platform headers
>> containing platform specific entries and iris_platform_data
>> structure.
>>
>> The goal is to share most of the structure while having
>> clear and separate per-SoC catalog files.
>>
>> The organization is based on the current drm/msm dpu1 catalog
>> entries.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/media/platform/qcom/iris/Makefile          |  2 +-
>>   .../media/platform/qcom/iris/iris_catalog_gen1.c   | 83 ++++++++++++++++++++++
>>   ...ris_platform_sm8250.c => iris_catalog_sm8250.h} | 80 ++-------------------
> 
> I'd suggest _not_ to follow DPU here. I like the per-generation files,
> but please consider keeping platform files as separate C files too.

This would duplicate all tables, do we really want this ?

I want just to add SM8650 support, not to entirely rework the
whole iris driver.

Neil

> 
>>   3 files changed, 89 insertions(+), 76 deletions(-)
>>
> 


