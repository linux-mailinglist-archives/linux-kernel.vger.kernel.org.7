Return-Path: <linux-kernel+bounces-822558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BDB84216
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5D2545417
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C312F6598;
	Thu, 18 Sep 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYbhmY7j"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E862868AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191635; cv=none; b=L0JGxx5G2QKRrzF36xvN1NXfymzqnLsRijnpIDlbjGidO1SCYCgmHcO75rWfA7HXPYXlobjKd1gukW6pVfsdTP4hzOrgZBrLHWyMRU8JggmDW8V1yKX/zoJPpj//w64klAr7MdaLIcXr1fMkZ9QNGS8TdLmJ8cQMxWkQ/J6vs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191635; c=relaxed/simple;
	bh=ajqpC0k6vh4Nc161dnIzsEVVzeo/VL7NZREPJ6MVoTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5E86WzJgoSnzYKHhE1XSL3BV7vtjZMSLYb0yXuaQtuypqYOOzj+hCpreXq8dXIHOPnieExuxsUq3OfwEpPXWjBP0ulGi8DmkUsxrjHU4N0KSyMZLnYVCAUXhl4sBnzpqzc9MXM2BIuhbnfcWojjPPSGOTH501T4paoIYtGmWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vYbhmY7j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de56a042dso5042405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758191632; x=1758796432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eYG+lwsBg89zkDARtkqh0ytv6M3TN13nMByHYDuJzU=;
        b=vYbhmY7j8CzoPKX8t2IJJQCtbMhVGhagQpniCIYjy1M7d3skwf9eULLbsB90AL6TU0
         zQR/j8XvGF40cjgVLHvmK3tGFNdnGhvnPfTX46FUP47SFmpLFT9VRGVNkSUdxF3bFub7
         /nIYqCRVoLU49/oaSeR4etTRytkj6TJbOdzQjqv2hu9TxnizUxArqKnjmkCupAqHjIXk
         fxFZxV22W6iRALV+gisAJSK+vxl6DeAib2q+oMa2lLDplGV3rmpLIYtdRN++J4cMJYFP
         l0q/5HD483ml0JO8u1LDuu4MJnNUGugqSt3aNJtX3EY2b11gWMn9FGnuvw3MAA9WyUhb
         irog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191632; x=1758796432;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eYG+lwsBg89zkDARtkqh0ytv6M3TN13nMByHYDuJzU=;
        b=aL3V4P+uZVZCWSlH08476SMogoTbHZoV4i9/K0HazNcsotfZ40u3qZWN3YIo4aW+y0
         PPXwEdlcxRroRNJlliQoi/rSdPj9LmtodOwUjDHJ+Oa79LXVUIJqRgqduMGsdkzEZgEq
         5Hor169OXtltjKBJKBA+1xTd7FzkLLBdXCK1f8P3UplhDZxvzT1AEFEcalUI3GQjcYhw
         0s3A1zIGJBeYvRApETrrWWo2TMTI11W7BNcHzHD4wi3A1xzGlfMf5IW2jyt8vkyNFCXy
         Y1IVILVgu0MLK1HRFRtf4YxHtRlxOjvs6O6Y07SOn8nMjSTFNWf78QwLVvyaa/Trs7aW
         cXug==
X-Forwarded-Encrypted: i=1; AJvYcCVLuat0XzEt9N0eFz/eL1HAJv7gnPYnpV0w34DruTIEQZuQF1eD2Ln3BqvX6Y/ClKcrqMsrjtbMsZqfiow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWA2EsUEPnwE2cWW576KOcuoTYrRuUyUafj5JP8Pqg0HW3nhjP
	7LLdz20Z1bXwuzUM2eZKWhmR3XBak9N5FJHHBw32RTjSMkWP5RTIBj6uKQusx8SmJO0=
X-Gm-Gg: ASbGncvGGTiCFq/GszhJhu4LhiZtmZP/WanPRSZ9KQeommtki5XDe2zHZq6bh6J6x3q
	Jr062wa83WWD7/5s7NNZpQrpO9Xh8v3iaTgG9UHt5BT0/gmoOChA0NSVaEwCpAkAIZDoxBpJBkM
	KoBGTKe15EsiAbRVVz4/N200pVyH3kHAUSB6JuRdZvmzMfYPzOlCvt4jkaMytlL1Ww9v1FZYtfq
	1W7uymSvORJZ/btZsXD9OFaPl97NWDgstfokyJoeXuZ4lu/njDPD04+jVJIe2lkf4mdXLRnWRdn
	HrqW91NJ4/ydV97c0AVnbbMLoKS9F2i6KltHRFON7IGwZh3zCcFmbwUsiD0a5Q9ssMLf49JNhtz
	G2C7P7xTNUdDv23gB56Big4F0PMMcrmG+ha1+TrivUq0LnVGkp835W5+zd738d8NDSFwArJk+3L
	LG4f5hAePorWYZoEWABUTsje3ADBTvqQREyHmJfg==
X-Google-Smtp-Source: AGHT+IGtskj6EsALihGomkAsZJx+Vh8xJiOZhFyiAAK0fMVOrqoM0VQqMr08kuiyPwXSQoTPkf5j1w==
X-Received: by 2002:adf:ee49:0:b0:3ed:82c:29ae with SMTP id ffacd0b85a97d-3ed082c2d49mr3311185f8f.44.1758191632027;
        Thu, 18 Sep 2025 03:33:52 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm2803577f8f.53.2025.09.18.03.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:33:51 -0700 (PDT)
Message-ID: <a59ccd01-1482-4091-957f-740840ff5112@linaro.org>
Date: Thu, 18 Sep 2025 11:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: pm_helpers: add fallback for the
 opp-table
To: Renjiang Han <quic_renjiang@quicinc.com>, quic_qiweil@quicinc.com,
 quic_wangaow@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250724-fallback_of_opp_table-v2-1-2fc61f2407dc@quicinc.com>
 <6dc33f02-6691-4ad8-b04f-423e4e5caea8@linaro.org>
 <b19ff26f-7dc7-4022-aec7-49922ab521cf@quicinc.com>
 <b4e25dd2-caf3-48f0-8e1b-622f3db1b7ca@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <b4e25dd2-caf3-48f0-8e1b-622f3db1b7ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2025 11:21, Renjiang Han wrote:
> 
> On 9/4/2025 11:33 AM, Renjiang Han wrote:
>>
>> On 7/28/2025 11:20 PM, Bryan O'Donoghue wrote:
>>> On 24/07/2025 08:53, Renjiang Han wrote:
>>>> Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
>>>> do not include an opp-table and have not configured opp-pmdomain, they
>>>> still need to use the frequencies defined in the driver's freq_tbl.
>>>>
>>>> Both core_power_v1 and core_power_v4 functions require core_clks_enable
>>>> function during POWER_ON. Therefore, in the core_clks_enable function,
>>>> if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
>>>> it needs to fall back to the freq_tbl to retrieve the frequency.
>>>>
>>>> Fixes: b179234b5e59 ("media: venus: pm_helpers: use opp-table for 
>>>> the frequency")
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
>>>> ---
>>>> Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
>>>> contain an opp-table and have not configured opp-pmdomain, they still
>>>> need to use the frequencies defined in the driver's freq_tbl.
>>>>
>>>> Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
>>>> fails in the core_clks_enable, it needs to fall back to the freq_tbl to
>>>> retrieve the frequency.
>>>>
>>>> Validated this series on QCS615 and msm8916.
>>>> ---
>>>> Changes in v2:
>>>> - 1. Update the returned error value as per the feedback.
>>>> - Link to v1: https://lore.kernel.org/r/20250723- 
>>>> fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com
>>>> ---
>>>>   drivers/media/platform/qcom/venus/pm_helpers.c | 11 ++++++++++-
>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/ 
>>>> drivers/media/platform/qcom/venus/pm_helpers.c
>>>> index 
>>>> 8dd5a9b0d060cddfeafd4da477ade0c7aeb6c390..77c12273dbb9505244e260fc8fa635e4fe045236 100644
>>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>>> @@ -40,6 +40,8 @@ static int core_clks_get(struct venus_core *core)
>>>>     static int core_clks_enable(struct venus_core *core)
>>>>   {
>>>> +    const struct freq_tbl *freq_tbl = core->res->freq_tbl;
>>>> +    unsigned int freq_tbl_size = core->res->freq_tbl_size;
>>>>       const struct venus_resources *res = core->res;
>>>>       struct device *dev = core->dev;
>>>>       unsigned long freq = 0;
>>>> @@ -48,7 +50,14 @@ static int core_clks_enable(struct venus_core *core)
>>>>       int ret;
>>>>         opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>>>> -    dev_pm_opp_put(opp);
>>>> +    if (IS_ERR(opp)) {
>>>> +        if (!freq_tbl)
>>>> +            return -ENODEV;
>>>> +        freq = freq_tbl[freq_tbl_size - 1].freq;
>>>> +    } else {
>>>> +        dev_pm_opp_put(opp);
>>>> +    }
>>>> +
>>>>         for (i = 0; i < res->clks_num; i++) {
>>>>           if (IS_V6(core)) {
>>>>
>>>> ---
>>>> base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
>>>> change-id: 20250721-fallback_of_opp_table-4ea39376f617
>>>>
>>>> Best regards,
>>>
>>> Note to self add a
>>>
>>> Closes: 
>>> CA+G9fYu5=3n84VY+vTbCAcfFKOq7Us5vgBZgpypY4MveM=eVwg@mail.gmail.com
>> Thanks for helping review this patch. But I'm sorry, may I ask how to
>> understand this comment?
>>
>> This patch has not been picked yet.Is there anything else I need to do?
> I’d appreciate any thoughts you might have on this.
>>>
>>>
>>> ---
>>> bod
>>

Marked as "Not applicable" on media-ci patchwork - you should have 
received an email about that.

* 7881cd6886a89 - media: venus: Fix OPP table error handling (6 weeks ago)
* b179234b5e590 - media: venus: pm_helpers: use opp-table for the 
frequency (3 months ago)
* 14423fc3a4a21 - media: venus: pm_helpers: add compatibility for 
dev_pm_genpd_set_hwmode on V4 (5 months ago)

git checkout -b linux-next/master-25-09-18 linux-next/master
Updating files: 100% (10211/10211), done.
branch 'linux-next/master-25-09-18' set up to track 'linux-next/master'.

b4 shazam b4e25dd2-caf3-48f0-8e1b-622f3db1b7ca@quicinc.com
Grabbing thread from 
lore.kernel.org/all/b4e25dd2-caf3-48f0-8e1b-622f3db1b7ca@quicinc.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 5 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v2] media: venus: pm_helpers: add fallback for the opp-table
     + Closes: 
CA+G9fYu5=3n84VY+vTbCAcfFKOq7Us5vgBZgpypY4MveM=eVwg@mail.gmail.com (✗ 
DKIM/linaro.org)
     + Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com> (✓ 
DKIM/quicinc.com)
   ---
   ✗ No key: ed25519/quic_renjiang@quicinc.com
   ✓ Signed: DKIM/quicinc.com
---
Total patches: 1
---
  Base: using specified base-commit d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
Applying: media: venus: pm_helpers: add fallback for the opp-table
Patch failed at 0001 media: venus: pm_helpers: add fallback for the 
opp-table
error: patch failed: drivers/media/platform/qcom/venus/pm_helpers.c:48
error: drivers/media/platform/qcom/venus/pm_helpers.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am 
--abort".
hint: Disable this message with "git config set advice.mergeConflict false"

---
bod

