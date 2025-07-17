Return-Path: <linux-kernel+bounces-735315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FACB08DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA674A70CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586626E6E8;
	Thu, 17 Jul 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q91iohkk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B51E98E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757164; cv=none; b=tgtgFFmDlpAi4OPpZjdwwVXNfdbj8fK3GWuKZURZCFLOqs/QTj2bPuVBdOrgI/rRIQuWsGTnF1oM82ZqcC4gTd711z9/kVg59d5bn3TVNpq7/juNQ4CVeCdYLcBRT6v2Ws0Uky5d06SCKfWACPocMDZma/WvWAcyfzIe56Wptl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757164; c=relaxed/simple;
	bh=NazyAH6+gsaoyyq+9VO0xIsOYw4Q0V5xmekt5T3PZiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhVWjP98kO4DDjA0JrBHx2IRzR1hKwxjrzJc7sFj1iNAKYJrUXSpTx2MYmLONjlYfP46d9pf/3+O2dR4SUHRkXgVmOif0wCNx+YCK9FZQBDqxq+S8X2VGD2QdSashTpsTWZgazzxVhWysVgk8YfxGOVJTjBWROBwbBWlb5+DtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q91iohkk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a522224582so449260f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752757161; x=1753361961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeXlH9kxjwQMEYf9Z3/E3bIdL61oLglThcLuAKSoRCU=;
        b=q91iohkkLeAj2j1hIAsCr9v6xWahtgrzaSuiqYC75q1vtqk7GwehxerV5Ko5/kbF/W
         7O1PdWoieMynJ2CJvlrpD2YB4cCwb/HSrFOBt35R/s/TLJFb3qkFRJiLJqfQIVZgGcB+
         8Y4enUC5hM33lUhlu7yulcpPcuJaDwVw2G2PvQevw7L71IfIscWI8HQmKj2ompyCYgpZ
         8GmzaYrA2grjdM4e7sTrZAn5SlmInVp5MmRw7qRMjPFIlqxWv9WY79ogMXoUT+8sy5cZ
         wLkSH5lYSGRWk1rOKCknJ4EY4oRlhMR2kVnN6tRgXST1+by5wHApeOhBuqQfolFAxhnx
         lS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757161; x=1753361961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeXlH9kxjwQMEYf9Z3/E3bIdL61oLglThcLuAKSoRCU=;
        b=aFhjU3vqPqMLY9WKaXiRAnkx7RAdDlZ91xEgtvVoJRvyKd3jSeEDB/tJLf11R6OY/t
         5UNLEvhLUIL79GBiwT429J8FUVy3b+gjytE94qkx3z8bkFYncGLuLjdRrFdXbDisiOSg
         fxUxodLz43qP5FKwck8AOru0y023JquwmviHhjvTVlTuC9I8hR+Hkoexgt6zyGcNkPLG
         UrXEAjaQfYqerMcLXWT4Y+YSbBTaqryVkY9UozMz42PEv59iwmyfW51blIAWhpSUQ/yz
         EzM/sIdyzZGjhonWMhXzwboHXpdH5q7+Gkx35CT2QZLEHp4z+Cy0sSHU2xFSH1z8wBdk
         uwGA==
X-Gm-Message-State: AOJu0Yyw48WoWcJFrxeXpyhIUH/qHHs1C+3NOvcaKgizMwb89GRzyeV0
	Z+FBVoknoAdva81oTp9cY5xj6T1v0LU1+1nQKJbqWVbbcN44KUARmBGOUTD/CK61NkA=
X-Gm-Gg: ASbGncuGj3Sk+F3edUGytPE030AfBkPeNwbWcvE51aMfZDOx3e6EdwsBSra/dk0heG8
	cQv3UXGEnuEvt/KTP9H/7PEZSt2pNj4ZnHsZMGG8IntbLApW15sShD+B1YJXYvMycQOQCEp6hwT
	8LMXZAETthQOk4IrBRf82pLQ+MhqV0wof9AKJKsIehj2zUHE20yGfvJ2E390qts3RsXN9V9VZDL
	GpDJkeg3v5+xIR+xVQ/defNub1L/8EBR/qLL4hiLJ5DG1hHwQuBqIB1ynDMSxIFkiTBFacf4EPg
	socps70dMTmpk8uiiuGNLOvz8SZyQJz4zMA1xmUpsijRpvvVaf9K8U8Znktk+X1y6/GBYqwoK8u
	ev37g9OISteuK5DmZpk37PeCIqg7g9jOYaWWrh/9wACQ5URdQKs9YcRV+eBy+6qvk
X-Google-Smtp-Source: AGHT+IHo3vHr64NV7F+0RXnNGZqyQwEggq77AYSR1w4iYu4MR8Hvcl0X6/LKB7Yn0uoOvs2MpQCVPw==
X-Received: by 2002:a5d:5d11:0:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b60ddc6571mr5596225f8f.55.1752757161148;
        Thu, 17 Jul 2025 05:59:21 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9298sm20689436f8f.44.2025.07.17.05.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:59:20 -0700 (PDT)
Message-ID: <7cb32560-b7af-4395-bb58-04dc4bbfa420@linaro.org>
Date: Thu, 17 Jul 2025 13:59:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: qcom: camss: tpg: Add TPG support for
 SA8775P
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Wenmeng Liu <quic_wenmliu@quicinc.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com>
 <20250717-lemans_tpg-v2-3-a2538659349c@quicinc.com>
 <e1335aff-00b4-4505-bcf5-0eb8f2974a75@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e1335aff-00b4-4505-bcf5-0eb8f2974a75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2025 13:54, Konrad Dybcio wrote:
> On 7/17/25 5:20 AM, Wenmeng Liu wrote:
>> Add support for TPG found on SA8775P.
>>
>> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
>> ---
> 
> [...]
> 
>> +static int tpg_stream_on(struct tpg_device *tpg)
>> +{
>> +	struct tpg_testgen_config *tg = &tpg->testgen;
>> +	struct v4l2_mbus_framefmt *input_format;
>> +	const struct tpg_format_info *format;
>> +	u8 lane_cnt = tpg->res->lane_cnt;
>> +	u8 i;
>> +	u8 dt_cnt = 0;
>> +	u32 val;
>> +
>> +	/* Loop through all enabled VCs and configure stream for each */
>> +	for (i = 0; i < tpg->res->vc_cnt; i++) {
>> +		input_format = &tpg->fmt[MSM_TPG_PAD_SRC + i];
>> +		format = tpg_get_fmt_entry(tpg->res->formats->formats,
>> +					   tpg->res->formats->nformats,
>> +					   input_format->code);
>> +
>> +		val = (input_format->height & 0xffff) << TPG_VC_m_DT_n_CFG_0_FRAME_HEIGHT;
>> +		val |= (input_format->width & 0xffff) << TPG_VC_m_DT_n_CFG_0_FRAME_WIDTH;
>> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_0(i, dt_cnt));
>> +
>> +		val = format->data_type << TPG_VC_m_DT_n_CFG_1_DATA_TYPE;
>> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_1(i, dt_cnt));
>> +
>> +		val = (tg->mode - 1) << TPG_VC_m_DT_n_CFG_2_PAYLOAD_MODE;
>> +		val |= 0xBE << TPG_VC_m_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
>> +		val |= format->encode_format << TPG_VC_m_DT_n_CFG_2_ENCODE_FORMAT;
>> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_2(i, dt_cnt));
>> +
>> +		writel_relaxed(0xA00, tpg->base + TPG_VC_n_COLOR_BARS_CFG(i));
>> +
>> +		writel_relaxed(0x4701, tpg->base + TPG_VC_n_HBI_CFG(i));
>> +		writel_relaxed(0x438, tpg->base + TPG_VC_n_VBI_CFG(i));
> 
> Please provide context for the magic numbers> +
>> +		writel_relaxed(0x12345678, tpg->base + TPG_VC_n_LSFR_SEED(i));
>> +
>> +		/* configure one DT, infinite frames */
>> +		val = i << TPG_VC_n_CFG0_VC_NUM;
>> +		val |= 0 << TPG_VC_n_CFG0_NUM_FRAMES;
>> +		writel_relaxed(val, tpg->base + TPG_VC_n_CFG0(i));
>> +	}
>> +
>> +	writel_relaxed(1, tpg->base + TPG_TOP_IRQ_MASK);
>> +
>> +	val = 1 << TPG_CTRL_TEST_EN;
>> +	val |= 0 << TPG_CTRL_PHY_SEL;
>> +	val |= (lane_cnt - 1) << TPG_CTRL_NUM_ACTIVE_LANES;
>> +	val |= 0 << TPG_CTRL_VC_DT_PATTERN_ID;
>> +	val |= (tpg->res->vc_cnt - 1) << TPG_CTRL_NUM_ACTIVE_VC;
>> +	writel_relaxed(val, tpg->base + TPG_CTRL);
> 
> You want the last writel here (and in _off()) to *not* be relaxed,
> so that all the prior accesses would have been sent off to the hw
> 
> [...]
> 
>> +static u32 tpg_hw_version(struct tpg_device *tpg)
>> +{
>> +	u32 hw_version;
>> +	u32 hw_gen;
>> +	u32 hw_rev;
>> +	u32 hw_step;
>> +
>> +	hw_version = readl_relaxed(tpg->base + TPG_HW_VERSION);
>> +	hw_gen = (hw_version >> HW_VERSION_GENERATION) & 0xF;
>> +	hw_rev = (hw_version >> HW_VERSION_REVISION) & 0xFFF;
>> +	hw_step = (hw_version >> HW_VERSION_STEPPING) & 0xFFFF;
> 
> FIELD_GET()
> 
>> +	dev_dbg(tpg->camss->dev, "tpg HW Version = %u.%u.%u\n",
>> +		hw_gen, hw_rev, hw_step);
> 
> dev_dbg_once()
> 
> [...]
> 
>> +static int tpg_reset(struct tpg_device *tpg)
>> +{
>> +	writel_relaxed(0, tpg->base + TPG_CTRL);
>> +	writel_relaxed(0, tpg->base + TPG_TOP_IRQ_MASK);
>> +	writel_relaxed(1, tpg->base + TPG_TOP_IRQ_CLEAR);
>> +	writel_relaxed(1, tpg->base + TPG_IRQ_CMD);
>> +	writel_relaxed(1, tpg->base + TPG_CLEAR);
> 
> similar comment as before
> 
> Konrad

+1

the _relaxed() writes make me distinctly unrelaxed() and the magic 
numbers should be spelled out as bitfields with clear names. within reason.

For example 0xA5 is an obvious output pattern of alternating 1s and 0s.

---
bod

