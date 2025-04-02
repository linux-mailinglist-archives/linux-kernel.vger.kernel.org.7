Return-Path: <linux-kernel+bounces-584747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73360A78AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4517A4DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE6236A61;
	Wed,  2 Apr 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvdkSfen"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6832235BE4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585769; cv=none; b=IUrZ7uLmhI/79Oj+7gK1bnGjjmHv7BgwngsDE/wC1DJtyEzkLnM4St7mQuOxN38OJf6IggFcaXVilN0BAU8dnYt1/kDSPKyf/fgsBtYsnPKjm4MtuF3hVn5DnnIV//bpKPDvQFFpe6vc5NHn1J5p5bIlyu871kIZJMwlJK1xWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585769; c=relaxed/simple;
	bh=CNmW4BT5V9QsZTBwZbT7ALEG3vCqhJVHbM37DgoF2J4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mgw9BEJC4uLtx36UjCl2sFJum4/q45X9Fv708lVp2tukAw5FsDy5HdEisGnSgz3opL8Eongvxk3ELb5kv3MsfS99Zo8nu0LfIClzeNCwLgCLilCF8QHtaueFblEZzLrviWfD4Bou1iFuHtdxPNalZeAq3V9UifBQt5KYGEaz+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvdkSfen; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d129c1aso478986f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743585765; x=1744190565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZQrdGR+xmrmuCDrTSgiiPo+g13NAGpahm31NYw4FtY=;
        b=NvdkSfenSHoLXWUeYi6BjcEaBY+zayhoHGF+7dNTBTjvFIpZSPmSHAdV1kFS8a6RMw
         G4wL7rBhLdYN24qR1rOqBgt5Ya79vEpoDPWoozXUSb39McPB4mFTFY289XZmZy8NcjtO
         meWryy7hJFEUfBvhglTfN2IoFGf2ytIMkrI2gTFlREvl5nuYlzJHA1I2lQ//vqPlQYOz
         0lKyucYJz/kO0Jcm+TK683UeluJZOK8Mc3tA+19U++KvChemBxAg/kgSG5EjxDADCJJJ
         rCxjIZPCeVr4C3WHyBuRv9hMht8ukgdTNiHt0SO+nEquzOtpoQGx1ERoWStZlq0A3azl
         Q1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743585765; x=1744190565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pZQrdGR+xmrmuCDrTSgiiPo+g13NAGpahm31NYw4FtY=;
        b=rumJyfKYJiH2RhyeRWT+R2bHy6SlE82l8uj9VY0w/87sh4FHN/qkSIKCOF3/6lmwT1
         Gv9FUIuA1STHPIW5k8D/i4AuOS47fszHPxdwbUeTRa1QWa27myc6nzr7hU0Y6bSYx+71
         Rc6jwfosUEf42dkwMpycLyIaSm1ohYa0gbg7csiejb9laPNj4HNl55M8rOZNw9Jluf2t
         ASd13tBo1Z3YKfsZerXFwFSINcOnltLzFEG3cMqlGxb18FBRHdMvbRJ6FxiI57loCEmW
         aNWOe8UgU7AIdUnilsvnoJLCohiWKUpajP7eLi48GP41Kuo6p2kTqIqumaL7nYXmZhA4
         i59A==
X-Forwarded-Encrypted: i=1; AJvYcCXFXOPvaBrGzpZDq4yoc+SgioAGHqHmVfTcw4ZR+XFBs/6WkSg91/df9yXxYTuvNRdTeGEnnISh54xOdh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSoZYjfdzklG+LXJK/0NbTJD14qzDkcU3JZN/pWIcz3+2Ybgy
	JLM6n8redXwN5wvqutgxDXmtQI+zPPYFqy7Tm3tX1WFvCUj9FTs3CLuSWlJtpNc=
X-Gm-Gg: ASbGncvhQhf3KNl8ySpofzvJSZk4Px5mRtEKuXOdJ4gCaKHKFnMoe3OxjY8qr5JONOl
	RczgXJLUoZtLBDlWNEYP9TLE5jK80RjbEyL5yCxCLe4aTHUvAOAyNZeNBW5Xj9FhSwQAB4bZJEl
	aXLWhkyao9Q5ClTxGYQAWRMdkPv55Jw2kvSfxtLItIYpzDMxSsnoSxgVV0WVZn7jHL7Ap945Joa
	J6+GVytqAqpoghYksrduopIBXqegOlYHFdlYjCXMRL5tlTLLuWWECx/lyE8JYGWgf1UPRZP9ShK
	KbJK8QIZnaVHMBwMxrNAPiJZUss99EwxJVzW52PfPcs8iwdiK76KUZQRkGWfZwiqZb79ojustbT
	cJZSxB4cW2B++CmPQ0VWZQQ==
X-Google-Smtp-Source: AGHT+IFL4TgZbnJRCkpEk7VNctRay9zuto9OvdQQZuc5ZPiTz4kCQOL2utBV6/RBKCvEDMHBgFdmwQ==
X-Received: by 2002:a05:6000:22c4:b0:391:9b2:f496 with SMTP id ffacd0b85a97d-39c2a35c589mr1172758f8f.16.1743585764935;
        Wed, 02 Apr 2025 02:22:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ca59:43e0:210c:afcf? ([2a01:e0a:3d9:2080:ca59:43e0:210c:afcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0ddeecc9sm15149440f8f.83.2025.04.02.02.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 02:22:44 -0700 (PDT)
Message-ID: <fe647204-0827-4bf5-8355-80d7e1b6685f@linaro.org>
Date: Wed, 2 Apr 2025 11:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] soc: amlogic: clk-measure: Optimize the memory size of
 clk-measure
To: Chuan Liu <chuan.liu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250205-optimize_memory_size_of_clk_measure-v2-1-4f546053495d@amlogic.com>
 <774d1a84-cc35-418d-9a84-867888b843da@linaro.org>
 <57355917-8191-451e-b297-d5a9c50749d9@amlogic.com>
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
In-Reply-To: <57355917-8191-451e-b297-d5a9c50749d9@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
On 02/04/2025 10:50, Chuan Liu wrote:
> hi Neil:
> 
> Friendly ping: This patch has been approved in review but hasn't been applied yet. Has it been overlooked?😉

Sorry forgot to queue it, doing it right now,

Neil

> 
> 
> On 2/10/2025 5:50 PM, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 05/02/2025 08:58, Chuan Liu via B4 Relay wrote:
>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>
>>> Drop "CLK_MSR_MAX" and replace it with adding a member "msr_count" in
>>> the structure to specify the count of msr_id.
>>>
>>> Mark the table of msr_id as const.
>>>
>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>> ---
>>> The number of msr_ids for each chip is inconsistent. Defining a
>>> fixed-size array for each chip to store msr_ids would waste memory.
>>> ---
>>> Changes in v2:
>>> - Discard the global variable and restore the "priv" member in the
>>> "struct meson_msr_id".
>>> - Mark msr_id_table as const.
>>> - Link to v1: https://lore.kernel.org/r/20250123-optimize_memory_size_of_clk_measure-v1-1-06aa6a01ff37@amlogic.com
>>> ---
>>>   drivers/soc/amlogic/meson-clk-measure.c | 86 ++++++++++++++++++++++++---------
>>>   1 file changed, 62 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
>>> index a6453ffeb753..39638d6a593c 100644
>>> --- a/drivers/soc/amlogic/meson-clk-measure.c
>>> +++ b/drivers/soc/amlogic/meson-clk-measure.c
>>> @@ -33,23 +33,26 @@ static DEFINE_MUTEX(measure_lock);
>>>   #define DIV_STEP            32
>>>   #define DIV_MAX                     640
>>>
>>> -#define CLK_MSR_MAX          128
>>> -
>>>   struct meson_msr_id {
>>>       struct meson_msr *priv;
>>>       unsigned int id;
>>>       const char *name;
>>>   };
>>>
>>> +struct meson_msr_data {
>>> +     struct meson_msr_id *msr_table;
>>> +     unsigned int msr_count;
>>> +};
>>> +
>>>   struct meson_msr {
>>>       struct regmap *regmap;
>>> -     struct meson_msr_id msr_table[CLK_MSR_MAX];
>>> +     struct meson_msr_data data;
>>>   };
>>>
>>>   #define CLK_MSR_ID(__id, __name) \
>>>       [__id] = {.id = __id, .name = __name,}
>>>
>>> -static struct meson_msr_id clk_msr_m8[CLK_MSR_MAX] = {
>>> +static const struct meson_msr_id clk_msr_m8[] = {
>>>       CLK_MSR_ID(0, "ring_osc_out_ee0"),
>>>       CLK_MSR_ID(1, "ring_osc_out_ee1"),
>>>       CLK_MSR_ID(2, "ring_osc_out_ee2"),
>>> @@ -98,7 +101,7 @@ static struct meson_msr_id clk_msr_m8[CLK_MSR_MAX] = {
>>>       CLK_MSR_ID(63, "mipi_csi_cfg"),
>>>   };
>>>
>>> -static struct meson_msr_id clk_msr_gx[CLK_MSR_MAX] = {
>>> +static const struct meson_msr_id clk_msr_gx[] = {
>>>       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
>>>       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
>>>       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
>>> @@ -168,7 +171,7 @@ static struct meson_msr_id clk_msr_gx[CLK_MSR_MAX] = {
>>>       CLK_MSR_ID(82, "ge2d"),
>>>   };
>>>
>>> -static struct meson_msr_id clk_msr_axg[CLK_MSR_MAX] = {
>>> +static const struct meson_msr_id clk_msr_axg[] = {
>>>       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
>>>       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
>>>       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
>>> @@ -242,7 +245,7 @@ static struct meson_msr_id clk_msr_axg[CLK_MSR_MAX] = {
>>>       CLK_MSR_ID(109, "audio_locker_in"),
>>>   };
>>>
>>> -static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
>>> +static const struct meson_msr_id clk_msr_g12a[] = {
>>>       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
>>>       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
>>>       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
>>> @@ -358,7 +361,7 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
>>>       CLK_MSR_ID(122, "audio_pdm_dclk"),
>>>   };
>>>
>>> -static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
>>> +static const struct meson_msr_id clk_msr_sm1[] = {
>>>       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
>>>       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
>>>       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
>>> @@ -489,7 +492,7 @@ static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
>>>   };
>>>
>>>   static int meson_measure_id(struct meson_msr_id *clk_msr_id,
>>> -                            unsigned int duration)
>>> +                         unsigned int duration)
>>>   {
>>>       struct meson_msr *priv = clk_msr_id->priv;
>>>       unsigned int val;
>>> @@ -573,13 +576,14 @@ DEFINE_SHOW_ATTRIBUTE(clk_msr);
>>>   static int clk_msr_summary_show(struct seq_file *s, void *data)
>>>   {
>>>       struct meson_msr_id *msr_table = s->private;
>>> +     unsigned int msr_count = msr_table->priv->data.msr_count;
>>>       unsigned int precision = 0;
>>>       int val, i;
>>>
>>>       seq_puts(s, "  clock                     rate precision\n");
>>>       seq_puts(s, "---------------------------------------------\n");
>>>
>>> -     for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
>>> +     for (i = 0 ; i < msr_count ; ++i) {
>>>               if (!msr_table[i].name)
>>>                       continue;
>>>
>>> @@ -604,7 +608,7 @@ static const struct regmap_config meson_clk_msr_regmap_config = {
>>>
>>>   static int meson_msr_probe(struct platform_device *pdev)
>>>   {
>>> -     const struct meson_msr_id *match_data;
>>> +     const struct meson_msr_data *match_data;
>>>       struct meson_msr *priv;
>>>       struct dentry *root, *clks;
>>>       void __iomem *base;
>>> @@ -621,7 +625,16 @@ static int meson_msr_probe(struct platform_device *pdev)
>>>               return -ENODEV;
>>>       }
>>>
>>> -     memcpy(priv->msr_table, match_data, sizeof(priv->msr_table));
>>> +     priv->data.msr_table = devm_kcalloc(&pdev->dev,
>>> + match_data->msr_count,
>>> +                                         sizeof(struct meson_msr_id),
>>> +                                         GFP_KERNEL);
>>> +     if (!priv->data.msr_table)
>>> +             return -ENOMEM;
>>> +
>>> +     memcpy(priv->data.msr_table, match_data->msr_table,
>>> +            match_data->msr_count * sizeof(struct meson_msr_id));
>>> +     priv->data.msr_count = match_data->msr_count;
>>>
>>>       base = devm_platform_ioremap_resource(pdev, 0);
>>>       if (IS_ERR(base))
>>> @@ -636,45 +649,70 @@ static int meson_msr_probe(struct platform_device *pdev)
>>>       clks = debugfs_create_dir("clks", root);
>>>
>>>       debugfs_create_file("measure_summary", 0444, root,
>>> -                         priv->msr_table, &clk_msr_summary_fops);
>>> +                         priv->data.msr_table, &clk_msr_summary_fops);
>>>
>>> -     for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
>>> -             if (!priv->msr_table[i].name)
>>> +     for (i = 0 ; i < priv->data.msr_count ; ++i) {
>>> +             if (!priv->data.msr_table[i].name)
>>>                       continue;
>>>
>>> -             priv->msr_table[i].priv = priv;
>>> +             priv->data.msr_table[i].priv = priv;
>>>
>>> -             debugfs_create_file(priv->msr_table[i].name, 0444, clks,
>>> -                                 &priv->msr_table[i], &clk_msr_fops);
>>> + debugfs_create_file(priv->data.msr_table[i].name, 0444, clks,
>>> + &priv->data.msr_table[i], &clk_msr_fops);
>>>       }
>>>
>>>       return 0;
>>>   }
>>>
>>> +static const struct meson_msr_data clk_msr_gx_data = {
>>> +     .msr_table = (void *)clk_msr_gx,
>>> +     .msr_count = ARRAY_SIZE(clk_msr_gx),
>>> +};
>>> +
>>> +static const struct meson_msr_data clk_msr_m8_data = {
>>> +     .msr_table = (void *)clk_msr_m8,
>>> +     .msr_count = ARRAY_SIZE(clk_msr_m8),
>>> +};
>>> +
>>> +static const struct meson_msr_data clk_msr_axg_data = {
>>> +     .msr_table = (void *)clk_msr_axg,
>>> +     .msr_count = ARRAY_SIZE(clk_msr_axg),
>>> +};
>>> +
>>> +static const struct meson_msr_data clk_msr_g12a_data = {
>>> +     .msr_table = (void *)clk_msr_g12a,
>>> +     .msr_count = ARRAY_SIZE(clk_msr_g12a),
>>> +};
>>> +
>>> +static const struct meson_msr_data clk_msr_sm1_data = {
>>> +     .msr_table = (void *)clk_msr_sm1,
>>> +     .msr_count = ARRAY_SIZE(clk_msr_sm1),
>>> +};
>>> +
>>>   static const struct of_device_id meson_msr_match_table[] = {
>>>       {
>>>               .compatible = "amlogic,meson-gx-clk-measure",
>>> -             .data = (void *)clk_msr_gx,
>>> +             .data = &clk_msr_gx_data,
>>>       },
>>>       {
>>>               .compatible = "amlogic,meson8-clk-measure",
>>> -             .data = (void *)clk_msr_m8,
>>> +             .data = &clk_msr_m8_data,
>>>       },
>>>       {
>>>               .compatible = "amlogic,meson8b-clk-measure",
>>> -             .data = (void *)clk_msr_m8,
>>> +             .data = &clk_msr_m8_data,
>>>       },
>>>       {
>>>               .compatible = "amlogic,meson-axg-clk-measure",
>>> -             .data = (void *)clk_msr_axg,
>>> +             .data = &clk_msr_axg_data,
>>>       },
>>>       {
>>>               .compatible = "amlogic,meson-g12a-clk-measure",
>>> -             .data = (void *)clk_msr_g12a,
>>> +             .data = &clk_msr_g12a_data,
>>>       },
>>>       {
>>>               .compatible = "amlogic,meson-sm1-clk-measure",
>>> -             .data = (void *)clk_msr_sm1,
>>> +             .data = &clk_msr_sm1_data,
>>>       },
>>>       { /* sentinel */ }
>>>   };
>>>
>>> ---
>>> base-commit: 1e1fd26ed4ca05cc1f0e5857918da4dd54967f7d
>>> change-id: 20250123-optimize_memory_size_of_clk_measure-f9c40e815794
>>>
>>> Best regards,
>>
>> Looks fine, thanks !!!
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


