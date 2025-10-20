Return-Path: <linux-kernel+bounces-861094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C5BF1C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F09C34EE15B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F632C8B;
	Mon, 20 Oct 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLj5Upwk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E21E1DE9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969781; cv=none; b=DNiVPvb2PDeFArRKZkhWqa+Xo6s9LDW+86x29+h16+at8PFgzZRzD9seoI3PdNqo6TGg2hEV+mjrIodA8Alq3Wm/Iv9zoqgzRBNzt/B8Hrs+wNrJzutUPYbknXnTqyVlPYgCpLOVfvVUvHz8Z/TnHJu2TNqG6mmCPqlanR4zNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969781; c=relaxed/simple;
	bh=5A3htDO+1VjzHSoUi8BLFJDsT21igQEQ6V/KLqB6Auw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JpAhZKCpwaXyeWIgQCbt9wZ/WRLyQNHFLa5FRpoHbxcPtMzI4PV66v+kjkpNZmQ6P3UvGTfyKrcJIdFjshZ/pMWiGuqnacRzx+txiBf9uFFMDOw+nskcggL78HULToafN/K/lj4QdQJFMrTkmDN+DqcozOzzHuPt0gevMZyzUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nLj5Upwk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so19157965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969778; x=1761574578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fh25uPGmMGtjwugJOpAW21MuxERzASNAZ/okxFq7s0w=;
        b=nLj5UpwkxQhqahuB037kYjdm9iNBu1XUD5XypD9SGARqYE5fFjJupYv6N1BEEpF+SO
         48koB0OtAWKqrCfXzOZD58OqnAZzAy7Lyny6K62nxmf8+ofiAxiESqZ8U1wQE/JI2ghy
         JaCuku9xvw5EOwitCjDldUIzj6+ztNAhSd0zEWr3fNhqPO/8cmQYUER9JYaDtgN0mNvQ
         2RFk8f46lRm3COboS5PhsYWn4O1EoLR6xqWDWzE4vA/hT5O3JadCI9HDTz058osSU6Fu
         vFuYAO+lMPi6ja/bsalHulP+MZtLt+D8M0gTgZjJFYGBylOOF/Zu3laPiVWN529tzi8k
         Z7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969778; x=1761574578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fh25uPGmMGtjwugJOpAW21MuxERzASNAZ/okxFq7s0w=;
        b=dJZbr/9llggitR1HAadyn0BBQj1wXGWgxr7MAWQgfzp+1+aofL8awJsIKaC+mYqJuG
         75hW+VaZWqV5qyzGE4uUEe8DTnTZ6IJyj3l54WTZnnY1EL07U7jo6EJeIuUZ9a1cRn/I
         A02fPJDFI3GJMFriJnJLHIVy1eSr0qPaWzfaJ36SiNzLddiR1sHe7Q+epeOMYOV5LQtC
         tenBNKefiOjyUh03MFHAYPTVTDCOhbFNWOHF4nL0/OB7S386lTaWknbxpC/SrvN/5KHd
         hoG7rJoqfPApBrLzjvVwmsJCjGxETs2+4CEsCBrBHBakohttek5A98oMrSPrzfKGL6eZ
         0SBg==
X-Forwarded-Encrypted: i=1; AJvYcCU3LXAM6JEroI+gSg8Jws3RncqMonXdFcXPFpur6bMHDxKkLiu88HNCELQY9jAHUzDYsi8oVRHCXKnmcgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7UlenHrtS94VO8q+2em7GADQ9IOSpR3yH5sdECF+NuzuMceq
	ayrIe+tXiCioufY8Dsm416KimdosEfW64paMFSSyHlr7RZdysJTpls+fDtVaXyE10vI=
X-Gm-Gg: ASbGncs7nO7kGH+y1yEyAOj54voVD8ujT0Eb3slk86GEKhL2V33BnaqsJ4MB0uMv+Yx
	TqKtDoSxvQtykhashODAjJMdlcS4X0P/qYfqDLItETWlYvDtbQOpwNFTnIMuJ9lObOLoV4Se1NZ
	f9aoJUeXepmDP8x6Jph90U10a1CydRCQGaelXICb9QPwvs5DNcVXqJCQajorCZtka9UypdSsROT
	NyFEol6wrJIkPgYFB+uqPnEdT3IjVI/j1NB5VPTr81aUHp/FdGuBtnGj+aDKXRC6Z7L45p2nyYa
	hc+KyC2Esbgrg5zHpvGtDOoE4Y8D+gY864R+5bd4ljB9NbQV/Gef1LS0A2HzPP2X/E3T6JbwdcE
	BLPaeayE6XV2+jW7IM7T+B/Z6G9IUgj0leVuYAN25ZJMERAw2zr4nUIXjAwi8LwsEzzFhxILA6C
	G1iTKdn43L6/ILN4zPB1IJtPa7kLY0deEgDIRIdX2ILnWdM3FLAYBTbKfwYl39
X-Google-Smtp-Source: AGHT+IH4rwpSS/RaY2Oa3ZwU3XyWBckH6u90hy8FRnIVp3cW7pD6Y7xTDa7CDM9oadtybkKsYlMFwg==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4711791c3b0mr110392435e9.28.1760969777956;
        Mon, 20 Oct 2025 07:16:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4f9c:f978:568:7b9c? ([2a01:e0a:3d9:2080:4f9c:f978:568:7b9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d3ddsm228773055e9.5.2025.10.20.07.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:16:17 -0700 (PDT)
Message-ID: <e87a6ea4-dc88-485c-bee3-1d2e99081b6f@linaro.org>
Date: Mon, 20 Oct 2025 16:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <1b783a60-39c7-49b5-8932-e77230f6cddd@linaro.org>
 <88f04334-8d73-4ced-9c46-e69c3e6cbc72@oss.qualcomm.com>
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
In-Reply-To: <88f04334-8d73-4ced-9c46-e69c3e6cbc72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/20/25 16:15, Konrad Dybcio wrote:
> On 10/20/25 4:05 PM, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 5/7/25 03:38, Jessica Zhang wrote:
>>> Filter out modes that have a clock rate greater than the max core clock
>>> rate when adjusted for the perf clock factor
>>>
>>> This is especially important for chipsets such as QCS615 that have lower
>>> limits for the MDP max core clock.
>>>
>>> Since the core CRTC clock is at least the mode clock (adjusted for the
>>> perf clock factor) [1], the modes supported by the driver should be less
>>> than the max core clock rate.
>>>
>>> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>
>> This change breaks the T14s OLED display, no modes are reported on the eDP connector.
>> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] Assigning EDID-1.4 digital sink color depth as 10 bpc.
>> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD monitor
>> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD size 20, SAD count 0
>> [drm:drm_mode_object_put.part.0 [drm]] OBJ ID: 113 (1)
>> msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 120 652260 2880 2912 2920 2980 1800 1808 1816 1824 0x48 0x9 (CLOCK_HIGH)
>> msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 60 652260 2880 2888 2920 2980 1800 1808 1816 3648 0x40 0x9 (CLOCK_HIGH)
>>
>> With this reverted on v6.18-rc, display works again.
> 
> https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/

Thanks,
Neil

> 
> Konrad


