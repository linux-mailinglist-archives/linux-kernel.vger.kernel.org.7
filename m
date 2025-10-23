Return-Path: <linux-kernel+bounces-866496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B5BFFEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF734FD4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B02BDC15;
	Thu, 23 Oct 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7E7vDJF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87262F3C21
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208050; cv=none; b=pxnE3O1uO5lvt8CAhhCKODgzUXXVlvnxvC4sfLxbwsr+excbNLP9d2V2rR2iVZxtjGmQOsPJdFa3sWajC0dqCeIiHgAfXgRKky52gm8TUNmnYV0ZwRTKZ3vWxd37WYuNxIBMlfI0LFnw0UhEEB/lPrB4PvVrXeBGbjl/fsJEqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208050; c=relaxed/simple;
	bh=oFbPADgpzP394iAebsLLLqc5ZyLUNR7re7Y2tuKmMfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uv40pVvGjGA76EvaZf3Tf+csKEEn65SWCEEhkK5vFANExOsHHGbccBJ3i1mQ98OE/FJQ0EILZIRRO1eX7IvFcREbQyUC6f5RN43bn6PIxrQjDYsE0zqFvJNldHYkE2I9hO4ZDciB/KHGflvKl7LVOcZWgAU4bPGU/IWtWnO9Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i7E7vDJF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710022571cso4740815e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761208047; x=1761812847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5NAC18QJKswT+g7496Z32PVkkCkiTwCQISpflqfju0=;
        b=i7E7vDJFgd34yQ5RCmAcpPqcRyBjgTYhqdly/p+Lra/HQP0BO8s4C0LOY66sEEcVff
         Ryxloto7WF1/JIMnOgkpRUs97LAS+lVGyneZUw7ANUQ+gHio6wqLykVH76ZpBeONVjHc
         aevPJH8MvNk5Z2DOCgoi0flCw5pyUSeOCVPtrFBo99p2jKiqn7t35I2usqHtauAiRRKx
         sfv8u+P8Hig/EyUeWftgX7aDyzr9wmOqktvMvebw3xv2h08Iq4oDvp2TD03naiDzca2P
         yjUFCV/Bf9forVLDS6Qb+O4sdyQrzbV4yFrn1qOLKoqheKgXtBO1xve2anzUfyyCvc+Y
         symA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208047; x=1761812847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o5NAC18QJKswT+g7496Z32PVkkCkiTwCQISpflqfju0=;
        b=dM5z5Kulj1dRq5wdUNNw+0CzZ+YDsRjU9R+fvn8VEOLTzxUAJMhaglan82nZINBj6F
         //xrFAWB7CSvJkmLJHb5warC8pNBuYIbvtYFWZodsKSq4ju0loiiGuuF6y7d8KcoCER9
         Lvm5EZMM9bChDcF01JJkphR40UgXJKdCyrIs73WzEAZRu8li9fNAUkLgTz1jK52vdKkK
         epqx/Gl9OnjfIvtOVyqUPXYjmq3+hfpyROaNBXvdK/+InhLEoEeRTUI3+JZVmXp0rwCp
         QLw5OafDlut2QYgj4JEI7JcctIw/cOejafRfjBc9Nd3tBot3U3f8lH8J49g0CZFHhy+U
         GxQA==
X-Forwarded-Encrypted: i=1; AJvYcCWQSY7vivuRR86ORfPkpVNXOsTWiWrDwhfos/qiwQqOJURo3IHTgsplwjbIADTcADKxD058ywdhn9jaAx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWwPpq7J3HR86Qongw7qqUN19ByvgIF2ZafmiPhceXKQTcDIX
	BMisU4Auq8lREtmMyg/mg8/GhtGMkhaDHK7RnwrEDqMKSsJNI33iFmJA2NJgOqZEyhI=
X-Gm-Gg: ASbGnctJ3DGI3eyZz+XhjSGO1gETQ9mnwpuWb4zQKqRy5kB2PAZopCuScGm3A0glwRp
	2RzFqaN0NPJwV2MJe8Y/+w73DFsA5eTKFuB9VfQCFNqHzEJoj5MfChqxuRbRkTSRYHYl3eDc9PK
	OmWxHWU9Mhx3nt4InAfPqFF55wdeAcxSw7EWEs+pTXWXHdQM6HpWsWD9bxPPO3G4fdGe08WTohD
	PVFhsCTkKcp2pKwThsgKY3J/Iy6++Q6hepE4ce5BKHaMoOLfUBAcyL7EBvdXGgqsyDLMGFHiofu
	hlHEBOdcaWN+9C1J8bWgr0JiP5vLUNBt5W/hrlTvbv2kdBdgD+KR940/ohghnWhpC7isN/aPonA
	zy3dowWuDIwU4ef3uDaMAkOj2nDEy1f3KPjVEJnuy3MnLAfQJgWWyp6I4VRSB+9oWKNEbsTM6eg
	59oQ266Qis8Uqkci4E93d78mc7I09jLgbmzPh/jz0z74jgBwGy7Di6
X-Google-Smtp-Source: AGHT+IEKr8axP45C8SAm3blZ9SD+S+XPhWTl1Qvfzhwa2h5mIngdJ9Be+l1Fru99wJnFHQOsUb8UpQ==
X-Received: by 2002:a05:600c:34d0:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-471179067e6mr179978285e9.19.1761208047113;
        Thu, 23 Oct 2025 01:27:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4c73:a2de:56f0:4bfe? ([2a01:e0a:3d9:2080:4c73:a2de:56f0:4bfe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428ece8sm85423635e9.7.2025.10.23.01.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:27:26 -0700 (PDT)
Message-ID: <25e829f8-60b2-4b69-8d57-ded846b5206a@linaro.org>
Date: Thu, 23 Oct 2025 10:27:26 +0200
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
In-Reply-To: <5d6e7303-cc57-4a50-a9ad-b45d3c89d045@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/25 19:09, Konrad Dybcio wrote:
> On 10/22/25 2:44 PM, Neil Armstrong wrote:
>> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
>> the GCC and GPUCC sync_state would stay pending, leaving the resources in
>> full performance:
>> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
> 
> Does this *actually* cause any harm, by the way?

?

> 
> For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
> to a pair of GCC clocks and GCC refers to VDD_CX
> 
> and I see these prints, yet:
> 
> /sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
> /sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0
> 
> /sys/kernel/debug/pm_genpd/cx/current_state:on
> /sys/kernel/debug/pm_genpd/cx/perf_state:256 # because of USB3 votes
> 
> I'm not super sure where that sync_state comes from either (maybe
> dev_set_drv_sync_state in pmdomain/core?)

The way we handle the GMU so far is wrong, it abuses the driver model.

And this is a symptom, whatever the impact it has, it needs to be fixed
in a proper way.

The sync_state is retained because the gmu device is never probed but
has some clocks and power domains attached to it, which is clearly wrong.

Neil

> 
> Konrad


