Return-Path: <linux-kernel+bounces-871805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A7C0E59A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD344349C36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FAB307AF4;
	Mon, 27 Oct 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRhNkD9W"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477641E32D6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574688; cv=none; b=VwNlmZTYpf2KWYNYlZUi2qGJho6eY5aH7gVBBLiSc+9p+VGeNABdLPUtI4cVqE47dqdtiWJ/ZWc+MJ4y44VcxqLkEmi0yFATSjNyE3LS280JrFBje6SXrzAlXeKELC0GzeMUEKW/yJAtH2vHSaMgHuoBd1r+C+iAijrU/VZOOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574688; c=relaxed/simple;
	bh=lTrEmJFTKDqZBzFU9cieH3uCiCIfTwM3Exjug7Lspw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfgwVZHMcPnA7amKPv2JcBboaj9iVfrZKh2AyO/nkGy/gea9gdkXcqXZ3Pnud7KzGqC5WjCg+DMS6hQ/8HO7Jz/RyI4+oAKBlkIaOBTB4tBhzR2t/A4VG1IzWbZUImTVo5UWFrln/enSKXu5HwDNDLLoJkZnpo7nyqkTHcqD4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRhNkD9W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so28439365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761574684; x=1762179484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+A41/+8xE3cDf5oGMMLtLcsckFYV27YrsuG5ddNvM5s=;
        b=vRhNkD9WFuoBm1XT9+JGePl4JjlrhokPvbKIBNa4aMeDA23QU0SA2zo3YvwmXVA8Ee
         CV7o6KWxJOHCOJXHHDPUaUtOfD6UCc/NLL5rPYGC3w6C52Cir/q/Bmss6nLQkkwxfjhu
         Nx6T6zWpNydexDGGuQPnAvwLHynTsv9dA6MYiEHwLjOYe1AYSAXnZS5wasN9BKDB0Arn
         fc53qQtClS0k4Qbh/CcciCn0C7WonytFOswypwdbyHmUa4YyiPDOQ3ccx5KIO+35pyao
         MINTEUpTp7+MCPBB+TncXEK96WUjQyuTWgwSAwssy5O2n1O2K7wCdCeKEfF+JwPW3FGW
         vmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574684; x=1762179484;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+A41/+8xE3cDf5oGMMLtLcsckFYV27YrsuG5ddNvM5s=;
        b=lNpo7oPq8w389ZVcOw7/+hSBfifDcdkY5V0FUgjqC1e9NVYlIi7uyVU9Jnt9/wTAAk
         qaPLJ52FIeyeWgFKcvwNp3VBDUGdsaFrCqTxV7AuV0pK9cxam1+jYRVegJmcHzGLdTRz
         6pPxpegW921JcHaRooxioZ3ymOi1xeOwUXgueKAA/5f3Vzk8qkCBzTyX7sxrcSlUcWgj
         ANpGGrlhuX3QEWaG0K/6wWkM0tR7vATdSw7ZzWRVnvY6GBPJu3HaGT9Y5KfLlFi4G2wL
         pztz+gKo+8mVpc4uneiRvvK24luU07bRr0t+OGPpcE26DQk7RBgVgYDm6CthQNaDDn88
         yc4g==
X-Forwarded-Encrypted: i=1; AJvYcCXO6c9WLiohbQf6CKuapaR76EU/0+3mfNO/jOLFfvppaCkRQ3Tg7p6WK3s5ytGPhiR4o0dL7NynfVdIjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg9V4vfUG+z3aPb1HBelj6z4jAd7oPxMy+DEBe66nc8iTaFsp
	ktRkdW92dTGeb5k/B80QPPeH7AW21sKTHHBwenWVSB0EtztGgFbFHAzZRYeRVQQY4cg=
X-Gm-Gg: ASbGnctFK3qRF+1pahlU79NepsYnfo2g9A2LrST+WFl1ManP4zvfL5TvjbeFCXuE8DX
	Fzvo03HfgFZqM51XcggitnKSVpjS4rIAgcYfydOSz8XKzRI57cvLJUtvgJDcbDO+3+6FKPpWvBK
	PX0OI0jDINJJIZTdI6me6MttVRqq6C/udYRh2LwT+GF1oVybK64sPLFd3f1EMzI624xoufwz1Vu
	YpoyzoSzok2R2tJrDhLtnA9cXSkCmJosPPj94Nvi7O32VJvt9jpv53IQ0uyink4r2UqZCKTRidW
	NHYAaSsgDH56kUNJmx9x306qxnevjrBUcTsFNIC5bs3+hT0OE7NTnHzSwH7JgDbX5wyeU7Fdhu3
	HLq6u4JsiN8H/v1Rx8PhgLP/SX1v4z+bNMBwAqvdimnyqg9hVyP32NziYXeriFIeXlSyTmZOtrc
	78jAgATI5tzaaog+GmFRkv8UjkDCY0ZhkcoZq6TlXuBLE=
X-Google-Smtp-Source: AGHT+IEG7Sd7f/L+xgkXJFr4wLLAmFVIB+pOb6+xXcxI0Tl8IHSO43ohQIIMyu1emb3Ury+MncpC0w==
X-Received: by 2002:a05:600d:834a:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-475dac36adamr48834105e9.27.1761574684460;
        Mon, 27 Oct 2025 07:18:04 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e4esm134958725e9.11.2025.10.27.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:18:03 -0700 (PDT)
Message-ID: <491fa11c-a0b2-4280-95ab-0de5d2d25f83@linaro.org>
Date: Mon, 27 Oct 2025 14:18:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: Use of_reserved_mem_region_to_resource() for
 "memory-region"
To: Rob Herring <robh@kernel.org>
Cc: Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Ming Qian <ming.qian@oss.nxp.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250813214949.897858-1-robh@kernel.org>
 <CAL_Jsq+vUNtMw6JS0ac6a8LTdJBB+UepadpDxP_S8vr6QwUiNA@mail.gmail.com>
 <0bb932e4-9fb5-4ee0-bd21-6e30d6c8044c@linaro.org>
 <CAL_JsqJHzPUyB6nDaTS87eHysoh5W8o=CefWt6hH8zbpM_aQJw@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAL_JsqJHzPUyB6nDaTS87eHysoh5W8o=CefWt6hH8zbpM_aQJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2025 14:11, Rob Herring wrote:
> On Thu, Sep 18, 2025 at 4:25 PM Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 18/09/2025 21:22, Rob Herring wrote:
>>> On Wed, Aug 13, 2025 at 4:50 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>
>>>> Use the newly added of_reserved_mem_region_to_resource() function to
>>>> handle "memory-region" properties.
>>>>
>>>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>> Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
>>>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>>>> ---
>>>> v2:
>>>>    - Rebase on v6.17-rc1
>>>> ---
>>>>    drivers/media/platform/amphion/vpu_core.c     | 40 +++++--------------
>>>>    .../media/platform/qcom/iris/iris_firmware.c  | 18 +++------
>>>>    drivers/media/platform/qcom/venus/firmware.c  | 19 +++------
>>>>    3 files changed, 21 insertions(+), 56 deletions(-)
>>>
>>> Ping!
>> I'll pick this one up.
> 
> I still don't see this showing up in next.
> 
> Rob

Pardon me, I didn't update patchwork.

Will do now.

---
bod

