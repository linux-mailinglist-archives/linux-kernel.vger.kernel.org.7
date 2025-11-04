Return-Path: <linux-kernel+bounces-884760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED3C31095
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628CD420F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DBD2EC542;
	Tue,  4 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSjfM3Rp"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35681257AC6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260234; cv=none; b=oACHFBPdW66LYJzODHvkjiysZEeFn68HMzcDwwE/WF0vl3Zokg/TQ4/7tW6ynkoE+yqHRq1E4s38S92o8G9hBOAkSlNGPkdpRmJ6V49V/OJVlr3Y/Aw/RXmhoHZoFSpVAMNzPwRhOkFG8PkgF0ithzo3nHUhGqm6TOPfGflK3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260234; c=relaxed/simple;
	bh=LC1nNo8cZK2+Ung0b972dLKU2apwvo677rBTuGrzUnA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WSuMRkhgbPzeMcCqF4wk5joxO2VYyP4+rE2jjIbmTKNLqm6WhjN+G2Kz4gEu22GPoA4cWl7AZiJxHUK/jcGurFVSwiMDUJSWWPaMrcARTSLBhzbuvfRr/Nq0lIYsANM/e/DdxhHa9nFJ4uyWLr2DqKQZxBh0JmbNV/7mKIq5xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSjfM3Rp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429cf861327so309600f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762260230; x=1762865030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lx9/ZRtBYuBkF+gPYtIKjkasAjUUPJxma7p0SkGX9yg=;
        b=eSjfM3RphtwpN6RuB7QpJ8tf6852f3lcJ5JOrFpxuDPDfkaWb5hEp+b427XufsW5IU
         9DvvZFsoUcriTQ9wbb0WW3QF2IsrFobCZZcdim54T9mPpSo/i/o21NTHm9e0izQuctk5
         GsRAjZpQA1+Bewv/hmOa1EX45dEPQMMGpIGhpM/aq7UDLirF3YCpPcwlMDTtem+b7yga
         9CYiOSTY6pJ/v/I9WFgY6Mj7ZLU5cdI2wBw7r1z/GW55st5qnP39Mj/rsFg9r27pcOvc
         cNo8NQblN/GgN0qBEyf7cKIq0iBxQw3pz4LdQ7RXgxEZ6kSAV0bn54HjmgqHtfe74LiX
         hq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260230; x=1762865030;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lx9/ZRtBYuBkF+gPYtIKjkasAjUUPJxma7p0SkGX9yg=;
        b=nUoq+cBx3UGGWD8VpoBh6gz3oD5e+1xglP2QdMjfK2uFbyVAeamRSTlz3lFkfYc02V
         XaOr/rX9XzW53LTSD/Y3QRz7j8g1SvVAS/R/ecW5S0D5snEOsnzp6Wm93YL6AjPuDJMq
         ZTQWlit57Iu5cm/IrHLQXPBQzW8SpMXjRzjDMgBUf4ih6RrxqAhCciDVjERDqPSERcYC
         1nV3HVmIXHvcD+Xg3NU9Kze00I349EbJbUbTq7OsuW6VDaf3jjufpB8P8iEvqS6UWw3I
         CllePy+HVpbYNQIZIwcDcOLZ8yM36HMvyn+9MApA33+9tRRhLXBY01T9Z4gzekRtHohE
         KaTw==
X-Forwarded-Encrypted: i=1; AJvYcCWt6Kij/Dgs4kziCoXS/zSAUOFQCRhKNLLqopw+uNag7mrCcWcA1aGjuJEDTqayPP+9UNHYf2oEGQG0+l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6ZIGf+nF1QmCdfLnosqUFveEybWMRnW1tJo1hzoRRgxERivU
	Ut1gsvzdrkKKMp8tKu/8UKRB6/tURvZvFLFc30dMBg48S652uM+vrEFDw98JedOiKis=
X-Gm-Gg: ASbGncvmgOToHdWzdBDMKZs98zjGiejZcEffkxpEQnxKMh8rqSpPEvnKqp+FI7wjeoB
	5BdvV8ciDLf6A6Qr4AZTvvzk9iA4VSv95Y0uwwhyX6z89NsQYg64Xroe3p7mWGdbePZzM6jT6hF
	tI0/9UKHYzYcYmUs5XFiBxOJCd74d+CZD/6g9DSkEcIfj9hFpuHrPSvjp22OrRpI7aIdT8Ab4qw
	w4kMeI09WXSaajEL5/DT9lvkpik/rAkXeI9zBe5hNRw8LXMHXfpm7f8JcKzmu1gGWE69iArxszO
	f9zlp0AZH5W7yIQd+ii6xj84HNcoi0HZIkk9NspVqh+F2m8H7wdohuIsO5YPrKuqCUEr9oVTP5z
	2DoBpZ+eRwbQXLKSFkmQsAXVnh5CgyJJ39H2noslJ7XnBPGcDE2Oq+EE7+TelS11/RamjZCobPU
	8kHDDPmym2utVWclxVfPc7PmENRl0kLb5PbQ==
X-Google-Smtp-Source: AGHT+IEn+IPeP7UmbTbyN63za3XNZH29ht14vh3RcuTm0OyZm3PpaImB86o2gV2dUHwnhJO5ffQksw==
X-Received: by 2002:a5d:5f43:0:b0:429:d3e9:65b with SMTP id ffacd0b85a97d-429d3e90f22mr5616888f8f.59.1762260230228;
        Tue, 04 Nov 2025 04:43:50 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm4352163f8f.23.2025.11.04.04.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:43:49 -0800 (PST)
Message-ID: <5ff947f0-d743-422d-a897-b241ff1e02a4@linaro.org>
Date: Tue, 4 Nov 2025 13:43:48 +0100
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
To: Jens Reidel <adrian@mainlining.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
 <02356e35-0a3a-4a50-ad38-3032f9f166c9@mainlining.org>
 <e9e117ed-823c-47e3-8ed6-14dbecc844bc@linaro.org>
 <bb4a8978-790a-46c5-94bd-9f97ffa15b64@mainlining.org>
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
In-Reply-To: <bb4a8978-790a-46c5-94bd-9f97ffa15b64@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 02:30, Jens Reidel wrote:
> Hi Neil,
> 
> On 10/29/25 11:25 AM, Neil Armstrong wrote:
>> Hi,
>>
>> On 10/26/25 02:31, Jens Reidel wrote:
>>> On 10/22/25 14:44, Neil Armstrong wrote:
>>>> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
>>>> the GCC and GPUCC sync_state would stay pending, leaving the resources in
>>>> full performance:
>>>> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>>
>>>> In order to fix this state and allow the GMU to be properly
>>>> probed, let's add a proper driver for the GMU and add it to
>>>> the MSM driver components.
>>>>
>>>> Only the proper GMU has been tested since I don't have
>>>> access to hardware with a GMU wrapper.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 354 +++++++++++++ +---------------
>>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |   6 -
>>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   3 -
>>>>   drivers/gpu/drm/msm/adreno/adreno_device.c |   4 +
>>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   4 +
>>>>   drivers/gpu/drm/msm/msm_drv.c              |  16 +-
>>>>   6 files changed, 192 insertions(+), 195 deletions(-)
>>>>
>>
>> <snip>
>>
>>>>
>>>> ---
>>>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
>>>> change-id: 20251022-topic-adreno-attach-gmu-to-driver-e47025fd7ebb
>>>>
>>>> Best regards,
>>>
>>> Hi Neil,
>>>
>>> thanks for the patch. With it applied, my GPU fails to initialize.
>>> Here's the related dmesg section:
>>>
>>> [    1.733062] [drm:dpu_kms_hw_init:1173] dpu hardware revision:0x50020000
>>> [    1.735229] [drm] Initialized msm 1.13.0 for ae01000.display- controller on minor 0
>>> [    1.735403] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a630_sqe.fw from new location
>>> [    1.735513] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a630_gmu.bin from new location
>>> [    1.746710] a6xx_gmu 506a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeout waiting for GMU OOB set BOOT_SLUMBER: 0x800000
>>> [    1.746766] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* Couldn't power up the GPU: -110
>>>
>>> This could be because I have an Adreno 630-family GPU, which is marked as legacy in a6xx_gmu_init / a6xx_gmu_bind. Previously, the rest of the init code would just always run, while now, some parts are conditionally disabled for legacy GPUs - that may be unintentional? However, unconditionally enabling those parts seems to fail to initialize the GPU followed by a reset shortly after, so there's probably more to this.
>>>
>>> Please let me know if there's anything I can do to help debug this.
>>
>> Thanks for the report, it's an sdm845 based right ?
> 
> Almost, it's SM7150 with Adreno 618.
> 
>>
>> I may have mismatched the role of the legacy parameter...
>>
>> Could you try this on top:
> 
> <snip>
> 
>> ===========================><=====================================
> 
> This is about what I had already tried earlier. I wasn't able to grab a log from
> UART to see what exactly was still wrong back then, but I finally got around to it today.
> 
> Short excerpt from decoded stacktrace:
> 
> [    4.838573] Unable to handle kernel paging request at virtual address 0000000000023010
> [    4.846726] Mem abort info:
> [    4.857916]   ESR = 0x0000000096000044
> [    4.870865]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    4.883897]   SET = 0, FnV = 0
> [    4.895344]   EA = 0, S1PTW = 0
> [    4.898584]   FSC = 0x04: level 0 translation fault
> [    4.898586] Data abort info:
> [    4.898587]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> [    4.898589]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [    4.898591]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    4.898593] [0000000000023010] user address but active_mm is swapper
> [    4.898597] Internal error: Oops: 0000000096000044 [#1]  SMP
> [    4.898600] Modules linked in:
> [    4.898612] Tainted: [W]=WARN
> [    4.898613] Hardware name: xiaomi Xiaomi POCO X3 NFC (Huaxing)/Xiaomi POCO X3 NFC (Huaxing), BIOS 2025.10-gcb980be18336 10/01/2025
> [    4.898616] Workqueue: events_unbound deferred_probe_work_func
> [    4.911316]
> [    4.911318] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.911321] pc : a6xx_gmu_rpmh_init (arch/arm64/include/asm/io.h:43 include/asm-generic/io.h:293 drivers/gpu/drm/msm/adreno/a6xx_gmu.h:183 drivers/gpu/drm/msm/adreno/a6xx_gmu.c:621)
> [    4.911327] lr : a6xx_gmu_rpmh_init (drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1811)
> [    4.911331] sp : ffff8000809f3560
> [    4.911332] x29: ffff8000809f3560 x28: 0000000000000001
> [    4.919938]  x27: ffff800081e50000
> [    4.919940] x26: 0000000000000300 x25: 0068000000000413 x24: ffffc51d5cca9000
> [    4.919944] x23: 0000000000030090 x22: ffff000080aec3b0 x21: ffff00008162c010
> [    4.919947] x20: ffff000080aec578 x19: ffff800081f90000 x18: 000000000aa663d1
> [    4.919950] x17: ffffc51d5cefc000 x16: ffffc51d5cca9d80 x15: 0078000000000f13
> [    4.930595]
> [    4.930596] x14: 0000000000000000 x13: ffff800081f9ffff x12: ffff800081f9ffff
> [    4.930600] x11: 0000000001000000 x10: 0000000000023010 x9 : 0000000000000000
> [    4.930603] x8 : 0000000000000000 x7 : ffff00008155a960 x6 : 0000000000000000
> [    4.930606] x5 : 0000000000000cc0 x4 : 0000000000001000 x3 : 007800000b49ff13
> [    4.930610] x2 : 000000000b4a0000
> [    4.942943]  x1 : ffff800081fa0000 x0 : ffff800081e50000
> [    4.942947] Call trace:
> [    4.942948]  a6xx_gmu_rpmh_init (arch/arm64/include/asm/io.h:43 include/asm-generic/io.h:293 drivers/gpu/drm/msm/adreno/a6xx_gmu.h:183 drivers/gpu/drm/msm/adreno/a6xx_gmu.c:621) (P)
> [    4.942954]  a6xx_gmu_bind (drivers/gpu/drm/msm/adreno/a6xx_gmu.c:2102)
> [    4.942957]  component_bind_all (drivers/base/component.c:660)
> [    4.956709]  msm_drm_init (drivers/gpu/drm/msm/msm_drv.c:159)
> [    4.956714]  msm_drm_bind (drivers/gpu/drm/msm/msm_drv.c:1032)
> 
> Turns out that previously, gmu->mmio was assigned before setting
> gmu->rscc = gmu->mmio + 0x23000;
> With your changes, the order is now wrong.

Oh crap

> Moving the assignment up again (and applying the diff you shared
> for proper handling of legacy parameter) fixes it:
> 
> ==========================================
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2027,6 +2027,13 @@ static int a6xx_gmu_bind(struct device *dev, struct device *master, void *data)
>                  if (ret)
>                          goto err_memory;
> 
> +               /* Map the GMU registers */
> +               gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
> +               if (IS_ERR(gmu->mmio)) {
> +                       ret = PTR_ERR(gmu->mmio);
> +                       goto err_memory;
> +               }
> +
>                  if (adreno_is_a650_family(adreno_gpu) ||
>                      adreno_is_a7xx(adreno_gpu)) {
>                          gmu->rscc = a6xx_gmu_get_mmio(pdev, "rscc");
> @@ -2048,13 +2055,6 @@ static int a6xx_gmu_bind(struct device *dev, struct device *master, void *data)
>                  }
>          }
> 
> -       /* Map the GMU registers */
> -       gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
> -       if (IS_ERR(gmu->mmio)) {
> -               ret = PTR_ERR(gmu->mmio);
> -               goto err_memory;
> -       }
> -
>          gmu->cxpd = dev_pm_domain_attach_by_name(gmu->dev, "cx");
>          if (IS_ERR(gmu->cxpd)) {
>                  ret = PTR_ERR(gmu->cxpd);
> ==========================================
> 
> This almost certainly isn't correct either because the wrapper needs
> its registers mapped too, perhaps this is better suited for moving it
> above the if block, I think that makes more sense.

Yes, merging both functions was a bad move...

> 
> With the legacy parameter changes and GMU register mapping prior to RSCC
> offset calculation:Tested-by: Jens Reidel <adrian@mainlining.org> # SM7150

Thanks for testing !

Following Akhil's review, I'll probably keep the wrapper and normal
gmu bind/unbind separated for the first step.

Neil

> 
> Best regards,Jens
>>
>> Thanks,
>> Neil
>>
>>>
>>> Best regards,
>>> Jens
>>


