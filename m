Return-Path: <linux-kernel+bounces-604611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C74A89688
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA946189D77A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E882949FC;
	Tue, 15 Apr 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8NKmdIE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9529290B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705470; cv=none; b=Am2s6ybIPX/aolja6UjjkrLSFODel3JpeJi9enErsXKzBEybejGHCjxC1mB2FJPWJfLiXso0SPw1DBl3JBC0JJPnwV/B7OVIsx0XyPL5v8eB21Vtfiryc7m034d+9MC2JhC01a5fLg7nWn1ZgqwuAzv7l04Upmf/rcBo0hFH9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705470; c=relaxed/simple;
	bh=Toe/MgEkUwQhqibB4avUzGEz/yS779oZa4EZXvqTX9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m4EGVbLtHIDsMp58CSzlDNcqI5n1eN4Lqw3KIy5HCupkx2JjtXHPipa6XFPNXqJFK16HOAcpxv8YZkCrU8uYFwA52+3rkiN1r9yObc2C/S7tdkvFPW5syd3u2RBfR+dpnnAS5nhBrhAbOYMgzAUSgM1d83EtCijrBxP0bM48wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8NKmdIE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4530262f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744705466; x=1745310266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSpzlKU1nIREVlNsrNu96tgGduluBR66UGak+c0tdBY=;
        b=R8NKmdIE22KFgUWl+2A2F/0WLrdOyJamliRPqqykGa9PMwMxv6ohg5/B1iXtNrSUVP
         Vt65GZUJ5bgQ3ZT2hJ0ks1jL7ocTwbnSs0pPgFi+YEFmL5fPrjnAz6Ne2Uhxz+iaGGkb
         g7Y2OxS1XRn6fAu0qtu+Ft5AOpJWlgnqrzFFaxrSlmk+Ls4wCiI3Ot+ihKmk3VbBuXaH
         PY28gp//3JGBQ9dGkKubvr8S8Wi3AtfRtm+4vCLlBW0kVKaRB8ENhJgQlICYMSueX3WN
         B4qNvpueEBIwHi1v5Md2e6K3echxbhG05prH4lCBnsZNyXNtf33+82BpKRftkN+49riu
         adLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705466; x=1745310266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSpzlKU1nIREVlNsrNu96tgGduluBR66UGak+c0tdBY=;
        b=prMfa/n67MUA5zOs/wQnzcfAMiPTq8n2W+TjVo8rb8DbNmrGKwaxwXTyOHoZ8Y11/z
         TboADSvKdniEg/+P7cJlRFrcGoqRps7I9dy2QFe81IqM/CA8IqiYupiQ4jSFLC+b4Oy/
         epCndzRammG2dVJkAEhKmL8SO7kT/SKQwSCYWDCy949FZaevKQ+GoJlCj1dh/cFwS4Jf
         YqZZQ1fNcn3oHx8ddg3VM99ZDSDp0oevzl5d8rfaEOEao1NIPBTl/WyUpN/dtQdDP/xT
         cpvyEDGIYvKHUX2qcs5bZm5HrmyVoODZv5SjgFGgpc1hGfBevdjSsMCm075+K3W9S9Bn
         u7+A==
X-Gm-Message-State: AOJu0YzW926JRENF1V5LV1SXQAD7vTHDMqXhoCTimzR+ygt2paPFMNFg
	U2CTULpXzrYBAGiSkc0qXnHRk52KyOCLzaIVLbIqpzbdRJyk0osu4V6LWBL/KdM=
X-Gm-Gg: ASbGnctONOfWmQplutobNmMkCCAJKtII5ktp89WBJjiBlAwuKfh25UfEG6Gu4npU6o3
	vRL6QyOOFpuwH9AAYea3se5ZQHZueyowa9KC94xz2VVLCJr1CJQrRLqe/hYyghXIkexKC2F5nJY
	jHwUbrxBvOwhMqHyKdE1S/yOIf53iW+DmRKcceQ1CeSPM7XLuvGtiYWOdWRSc8w0/hQkFL2YVE0
	BEgXR3TH9K4yBVRPkreuISs4fOZ5P326iL3uDc3XVwYwUAyTSMGESytqHKhuXjN8hT5hvjbqYyf
	dv3cpQn6kt+lxzbES6A9gtEU1PZ43p1JgboL+hC+I+ZeCMAFu6/JP7JgVvBoKnIkNvwNc5XDBy5
	i0elRldh6ZlqVjZbakA==
X-Google-Smtp-Source: AGHT+IFm+L30iLixeyBlQxYooSK2h2BfOdRzKzGjdzVFNUUVHWw3HgHSntRbFZguV94g5Y239kmccw==
X-Received: by 2002:a05:6000:2507:b0:39c:1257:cc25 with SMTP id ffacd0b85a97d-39eaaed2d1cmr13410344f8f.56.1744705465757;
        Tue, 15 Apr 2025 01:24:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ac71:de35:af4b:b8fb? ([2a01:e0a:3d9:2080:ac71:de35:af4b:b8fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c5f2sm13592403f8f.34.2025.04.15.01.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:24:25 -0700 (PDT)
Message-ID: <0c4fcd81-8e1f-4b4b-a345-c08caeb599c8@linaro.org>
Date: Tue, 15 Apr 2025 10:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v5 0/8] media: qcom: iris: re-organize catalog & add
 support for SM8650
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250410-topic-sm8x50-upstream-iris-catalog-v5-0-44a431574c25@linaro.org>
 <2740b178-34cc-4b95-a8da-7e6862cabc92@linaro.org>
 <96953447-cff5-98d4-053e-8cc31778849c@quicinc.com>
 <eb469388-d2f9-447a-aa80-41795991a4ad@linaro.org>
 <5b50ad93-0885-d908-fd13-3a597966115c@quicinc.com>
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
In-Reply-To: <5b50ad93-0885-d908-fd13-3a597966115c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 14/04/2025 21:48, Vikash Garodia wrote:
> 
> On 4/14/2025 5:39 PM, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 14/04/2025 12:54, Vikash Garodia wrote:
>>> Hi Neil,
>>>
>>> On 4/14/2025 1:05 PM, Neil Armstrong wrote:
>>>> Hi Vikash, Dikshita,
>>>>
>>>> On 10/04/2025 18:29, Neil Armstrong wrote:
>>>>> Re-organize the platform support core into a gen1 catalog C file
>>>>> declaring common platform structure and include platform headers
>>>>> containing platform specific entries and iris_platform_data
>>>>> structure.
>>>>>
>>>>> The goal is to share most of the structure while having
>>>>> clear and separate per-SoC catalog files.
>>>>>
>>>>> The organization is based on the curent drm/msm dpu1 catalog
>>>>> entries.
>>>>
>>>> Any feedback on this patchset ?
>>> Myself and Dikshita went through the approach you are bringing here, let me
>>> update some context here:
>>> - sm8550, sm8650, sm8775p, qcs8300 are all irisv3, while qcs8300 is the scaled
>>> down variant i.e have 2 PIPE vs others having 4. Similarly there are other
>>> irisv3 having 1 pipe as well.
>>> - With above variations, firmware and instance caps would change for the variant
>>> SOCs.
>>> - Above these, few(less) bindings/connections specific delta would be there,
>>> like there is reset delta in sm8550 and sm8650.
>>>
>>> Given above, xxx_gen1.c and xxx_gen2.c can have all binding specific tables and
>>> SOC platform data, i.e sm8650_data (for sm8650). On top of this, individual SOC
>>> specific .c file can have any delta, from xxx_gen1/2.c) like reset table or
>>> preset register table, etc and export these delta structs in xxx_gen1.c or
>>> xxx_gen2.c.
>>>
>>> Going with above approach, sm8650.c would have only one reset table for now.
>>> Later if any delta is identified, the same can be added in it. All other common
>>> structs, can reside in xxx_gen2.c for now.
>>
>> Thanks for reviewing, but...
>> Sorry I don't understand what you and Dmitry are asking me...
>>
>> If I try really hard, you would like to have:
>>
>> iris_catalog_sm8550.c
>> - iris_set_sm8550_preset_registers
>> - sm8550_icc_table
>> - sm8550_clk_reset_table
>> - sm8550_bw_table_dec
>> - sm8550_pmdomain_table
>> - sm8550_opp_pd_table
>> - sm8550_clk_table
> Move or rename existing 8550.c as xxx_gen2.c. This is with the existing
> assumption that everything under 8550.c is common for all gen2 to come in future.
>>
>> iris_catalog_sm8650.c
>> - sm8650_clk_reset_table
>> - sm8650_controller_reset_table
> yes, since reset is the only delta.
>>
>> iris_catalog_gen2.c
>> - iris_hfi_gen2_command_ops_init
>> - iris_hfi_gen2_response_ops_init
>> ...
>> - sm8550_dec_op_int_buf_tbl
>>
>> and:
>> - struct iris_platform_data sm8550_data
>> - struct iris_platform_data sm8650_data
> all this goes to xxx_gen2.c as well.

Yeah so this is exactly my current approach, except it use .h files
for each SoC for simplicity.

> 
>> using data from iris_catalog_sm8550.c & iris_catalog_sm8550.c
>>
>> So this is basically what I _already_ propose except
>> you move data in separate .c files for no reasons,
>> please explain why you absolutely want distinct .c
>> files per SoC. We are no more in the 1990's and we camn
>> defintely have big .c files.
> Its not about the size of file alone, it is easy to understand later what would
> be the delta in the SOCs and what would common. For ex, just navigating through
> sm8650.c, anyone can comment that reset is the delta.

What's the problem with the current approach with .h file for each SoC ?

>>
>> And we still have a big issue, how to get the:
>> - ARRAY_SIZE(sm8550_clk_reset_table)
>> - ARRAY_SIZE(sm8550_bw_table_dec)
>> - ARRAY_SIZE(sm8550_pmdomain_table)
>> ...
>>
>> since they are declared in a separate .c file and you
>> need a compile-time const value to fill all the _size
>> attribute in iris_platform_data.
> I have not tries this, but isn't extern-ing the soc structs (in your case reset
> tables) into xxx_gen2.c enough here ? Also i think the tables you are pointing
> here, lies in the xxx_gen2.c only, so i am sure above ones would not be an issue
> at all. The only delta struct is reset table, lets see if extern helps.

No it doesn't, because I wrote C for the last 25 years, and I tried it already,
I also tried to export a const int with the table size, and it also doesn't work.

The 3 only ways are:
1) add defines with sizes for each table
2) add a NULL entry at the end of each table, and update all code using those tables
3) declare in the same scope, which is my current proposal

Neil

> 
> Regards,
> Vikash
>>
>> So I recall my goal, I just want to add sm8650 support,
>> and I'm not the owner of this driver, and I'm really happy
>> to help, but giving me random ideas to solve your problem
>> doesn't help us at all going forward.
>>
>> Neil
>>
>>>
>>> Regards,
>>> Vikash
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>> Add support for the IRIS accelerator for the SM8650
>>>>> platform, which uses the iris33 hardware.
>>>>>
>>>>> The vpu33 requires a different reset & poweroff sequence
>>>>> in order to properly get out of runtime suspend.
>>>>>
>>>>> Follow-up of [1]:
>>>>> https://lore.kernel.org/all/20250409-topic-sm8x50-iris-v10-v4-0-40e411594285@linaro.org/
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Changes in v4:
>>>>> - Reorganized into catalog, rebased sm8650 support on top
>>>>> - Link to v4:
>>>>> https://lore.kernel.org/all/20250409-topic-sm8x50-iris-v10-v4-0-40e411594285@linaro.org
>>>>>
>>>>> Changes in v4:
>>>>> - collected tags
>>>>> - un-split power_off in vpu3x
>>>>> - removed useless function defines
>>>>> - added back vpu3x disappeared rename commit
>>>>> - Link to v3:
>>>>> https://lore.kernel.org/r/20250407-topic-sm8x50-iris-v10-v3-0-63569f6d04aa@linaro.org
>>>>>
>>>>> Changes in v3:
>>>>> - Collected review tags
>>>>> - Removed bulky reset_controller ops
>>>>> - Removed iris_vpu_power_off_controller split
>>>>> - Link to v2:
>>>>> https://lore.kernel.org/r/20250305-topic-sm8x50-iris-v10-v2-0-bd65a3fc099e@linaro.org
>>>>>
>>>>> Changes in v2:
>>>>> - Collected bindings review
>>>>> - Reworked rest handling by adding a secondary optional table to be used by
>>>>> controller poweroff
>>>>> - Reworked power_off_controller to be reused and extended by vpu33 support
>>>>> - Removed useless and unneeded vpu33 init
>>>>> - Moved vpu33 into vpu3x files to reuse code from vpu3
>>>>> - Moved sm8650 data table into sm8550
>>>>> - Link to v1:
>>>>> https://lore.kernel.org/r/20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org
>>>>>
>>>>> ---
>>>>> Neil Armstrong (8):
>>>>>          media: qcom: iris: move sm8250 to gen1 catalog
>>>>>          media: qcom: iris: move sm8550 to gen2 catalog
>>>>>          dt-bindings: media: qcom,sm8550-iris: document SM8650 IRIS accelerator
>>>>>          media: platform: qcom/iris: add power_off_controller to vpu_ops
>>>>>          media: platform: qcom/iris: introduce optional controller_rst_tbl
>>>>>          media: platform: qcom/iris: rename iris_vpu3 to iris_vpu3x
>>>>>          media: platform: qcom/iris: add support for vpu33
>>>>>          media: platform: qcom/iris: add sm8650 support
>>>>>
>>>>>     .../bindings/media/qcom,sm8550-iris.yaml           |  33 ++-
>>>>>     drivers/media/platform/qcom/iris/Makefile          |   6 +-
>>>>>     .../media/platform/qcom/iris/iris_catalog_gen1.c   |  83 +++++++
>>>>>     ...{iris_platform_sm8550.c => iris_catalog_gen2.c} |  85 +------
>>>>>     ...ris_platform_sm8250.c => iris_catalog_sm8250.h} |  80 +-----
>>>>>     .../media/platform/qcom/iris/iris_catalog_sm8550.h |  91 +++++++
>>>>>     .../media/platform/qcom/iris/iris_catalog_sm8650.h |  68 +++++
>>>>>     drivers/media/platform/qcom/iris/iris_core.h       |   1 +
>>>>>     .../platform/qcom/iris/iris_platform_common.h      |   3 +
>>>>>     drivers/media/platform/qcom/iris/iris_probe.c      |  43 +++-
>>>>>     drivers/media/platform/qcom/iris/iris_vpu2.c       |   1 +
>>>>>     drivers/media/platform/qcom/iris/iris_vpu3.c       | 122 ---------
>>>>>     drivers/media/platform/qcom/iris/iris_vpu3x.c      | 275
>>>>> +++++++++++++++++++++
>>>>>     drivers/media/platform/qcom/iris/iris_vpu_common.c |   4 +-
>>>>>     drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
>>>>>     15 files changed, 598 insertions(+), 300 deletions(-)
>>>>> ---
>>>>> base-commit: 2bdde620f7f2bff2ff1cb7dc166859eaa0c78a7c
>>>>> change-id: 20250410-topic-sm8x50-upstream-iris-catalog-3e2e4a033d6f
>>>>>
>>>>> Best regards,
>>>>
>>


