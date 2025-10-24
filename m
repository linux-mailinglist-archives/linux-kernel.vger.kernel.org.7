Return-Path: <linux-kernel+bounces-868476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16179C05457
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90F895030D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79416308F05;
	Fri, 24 Oct 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBUTtTb3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6E2F99A5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297086; cv=none; b=kUhK23HRC8VvQP0ZirTgjLcEpY2RhP0LWuIQNOWLFG0FHJI21iRINBB0SNJiJOIwuGYfHIm17Di3G8kfOjL8JoFQij83sEqt28VmgGhuIajj0+hZhb/hGJBJWO5c0c8Yiv+k5Z5onfJxZX89c5K2z1mowv5I6YUtIYJ2OSIxXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297086; c=relaxed/simple;
	bh=AZWLb7xat4g9t1ezCQiPSrUk4WUvTUV+wJM3BEzMwpw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T9AKCtJzYNJuH0ZYtG0sIJDlRjMpoMcQaTZlB3ih9Htt2ok2b+p35pe4+1dFGDcKrob4ICTl4nNB5fTe4GW3KywN7HybV3hvanYitGLqBi9fBX9Q5nuKxBt2hNAP3y33prWs4ty0JWtxwxQDghNx78MoczGNi4nM/o/FvddMIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBUTtTb3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so10410635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761297083; x=1761901883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sHf7DaVRvXThSGqd+JD4fjtwa2CQ9M1CafBcPaGRls=;
        b=rBUTtTb3q/dtlfNlAWLNI8BFg31N45p7AlcvHR95EMGKPmVbE8H+fOr244tXv7N8Mj
         eaMhpx+oS9BtwhqjN3zw/B8VFRsgAZjh6v1zR9PEo9fafcBH3rjSuxSM+otzmPFeLI3A
         MV2qWTtUTyOdxCOAj+2KKZSVd8luV6BrgZswAldzaECtQwFBnt/ynj4aTnIHRtDnO+p2
         dkH0ZYGN1QH3OG8v/pZ82QuXJzSZbcleGb+pscaAGqHqp82f3k+uUGNnt6ptXpx5JYCe
         Xz006cPfkMKv4xocDUqsb4gRjHztGxOq1gH+UakkzTFs0ApnrujBUoMOydP7hQInnsSQ
         Aqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297083; x=1761901883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4sHf7DaVRvXThSGqd+JD4fjtwa2CQ9M1CafBcPaGRls=;
        b=BYXPb/xrD1aZiD1OOHAe6zwHDhwTztdt04JrtIhH3ZTzhoucJfTMHySHvr7UwmpvDG
         jfA5WH4v63ohAL79ym5pqV8SRTIjpaKLksqz6fIBpRrQmmbYY0VkZCzetM9a9Y7ZyBZl
         8s6WGqNxRLkhO5AHEzIAicZEjdMbtIy5rQW9bpX33a9pNSaK8Q+Muhy4UBBhy1sygiY6
         XXUIyvTsPQXgOA8CXisRJ3LgwboClhuEnB9F+9U/cD8IA2UzWlTdpPwr41x62cg8L/Y3
         b8u0oQuINRJe2l2pLOomjv6bEEFGkNxi2bAULQTdOmzU3VpPKJvjOH7tgw9cthJZ/ig6
         KP4w==
X-Forwarded-Encrypted: i=1; AJvYcCWltuZHQorDYBBznOlAYAlttV2f8qxZxbUHyrHVpGLnokH97OlqBg1RCKc+Uqg6nEzcsRqTXx228xPlluE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qrdHky2BDtIFeOjnYkfR7UiUeral+HM0k+3hwlUmJuVrehVT
	8JmrW6XZepguQTPweelpROFPuh1CA3fJ0vFE+OcMsAckd0N+qajoncQUJN2s4dqq1YA=
X-Gm-Gg: ASbGnct4e9I2X7dTiFatBnRRCJRMn4jMTR3UU0K+Nra1Kl3Iu8XPLv0yQ/V3MkT62x/
	i5S81PcSq2UsOvwJIQT/UTR75SRJ5LmvjaGtxMAvFPx+U6E+uFAOc9BtzaY2WOL4VpgShYEo1YC
	Bx0H1kck/gX/frfTVUe/3C5ZNgrStMsK1JScWo9kl/OU9k/lxnpfmz5Z4rG8iOoEfDwNTlvTcFK
	QGACi9+YH8c9wTn6P1yZLq2y7D6JTstIbJj0rLin+k3gEp28mxXZX8gjt2qCg39UBcgemA5G1df
	zaeBiql7BYnbl9T6kWsaRa5c30wRQi2N3stwIC0Rov1oN84yerOGbIfcQWlaXywCS3sTiddHIzt
	j8i762nmK1bPHqeDQ8usWCkzBsuYGDzvgezi3rQQPg1Mk+n3EeVgqhppLQNeE6kpT1m6IKe1h/w
	eSwv2TcIYkW+yLDYOB0tzk0BF9LosWAW8vZE43SI8wvlvLMhU1fdJjkT61Ej7PvbU=
X-Google-Smtp-Source: AGHT+IG251T5Qj3BqvF34o9YaMYzBuZbQcHBuf37b4a3JGAgb4AOgBBu3wgzWQl6UMZBIMPOtQ1JDA==
X-Received: by 2002:a05:600c:5296:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-475cb044f10mr45397935e9.29.1761297082977;
        Fri, 24 Oct 2025 02:11:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b4ee:479d:354c:6970? ([2a01:e0a:3d9:2080:b4ee:479d:354c:6970])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475d8a38038sm2816935e9.16.2025.10.24.02.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 02:11:22 -0700 (PDT)
Message-ID: <bed92353-da4e-4447-97d2-10e8a333e4e0@linaro.org>
Date: Fri, 24 Oct 2025 11:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a
 driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
 <5d6e7303-cc57-4a50-a9ad-b45d3c89d045@oss.qualcomm.com>
 <25e829f8-60b2-4b69-8d57-ded846b5206a@linaro.org>
 <c79c55fb-3aaa-4256-a71b-fa86cd0166f7@oss.qualcomm.com>
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
In-Reply-To: <c79c55fb-3aaa-4256-a71b-fa86cd0166f7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/25 10:55, Konrad Dybcio wrote:
> On 10/23/25 10:27 AM, Neil Armstrong wrote:
>> On 10/22/25 19:09, Konrad Dybcio wrote:
>>> On 10/22/25 2:44 PM, Neil Armstrong wrote:
>>>> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
>>>> the GCC and GPUCC sync_state would stay pending, leaving the resources in
>>>> full performance:
>>>> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>
>>> Does this *actually* cause any harm, by the way?
>>
>> ?
>>
>>>
>>> For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
>>> to a pair of GCC clocks and GCC refers to VDD_CX
>>>
>>> and I see these prints, yet:
>>>
>>> /sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
>>> /sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0
>>>
>>> /sys/kernel/debug/pm_genpd/cx/current_state:on
>>> /sys/kernel/debug/pm_genpd/cx/perf_state:256 # because of USB3 votes
>>>
>>> I'm not super sure where that sync_state comes from either (maybe
>>> dev_set_drv_sync_state in pmdomain/core?)
>>
>> The way we handle the GMU so far is wrong, it abuses the driver model.
>>
>> And this is a symptom, whatever the impact it has, it needs to be fixed
>> in a proper way.
>>
>> The sync_state is retained because the gmu device is never probed but
>> has some clocks and power domains attached to it, which is clearly wrong.
> 
> Yes I agree, however I'm only debating the commit message claims of
> 'leaving the resources in full performance', which doesn't seem to be
> true

OK so the wording may be a little bit extreme, perhaps something like:
the GCC and GPUCC sync_state would stay pending, leaving the unused
power domains enabled for the lifetime of the system.

Neil

> 
> Konrad


