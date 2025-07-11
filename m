Return-Path: <linux-kernel+bounces-727664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70279B01E08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F5B477C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5E2DCF67;
	Fri, 11 Jul 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYcAmEvw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2282D9790
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240763; cv=none; b=dqE44dtY8wkSHnXeYbnIJVuvsQuSoMb0vHWM0SkObMBQKneFGMtRQwgfP1pV0UDKBTbK1wqS0Lmd96tCRlOK2RvSxuyR3NFVOsQVDAF++A/++e0tfHbosly6sHJ2Hyq2pQNESrRbiwXunHAbJDVNOdrfL3qjFrqu9X6mratH0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240763; c=relaxed/simple;
	bh=cxDui2279G2iAL74DhrviEb73ULq4vNmJowaeDNo81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSZAivwx/1yYyqL4g3kukVT4GB9X1Vufo+9nOFI1ZYYdVpwGE9x/9EATiUd7Hm8hnVzE478sG13mc5MF6JOYAwaawKbv/twhzTRl+ra3kzNZ0Jc0SCxpqzbdlewvP3XypZ0smcX3mPLBnt/kaRk1/HgXarWhMIb4iEOpE6GEp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WYcAmEvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAi0gu012032
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	thUDUj4ntHriDBH6aejx31sCgkmryjUnapSdrJV27l8=; b=WYcAmEvwUJwE79dC
	HVZ0lfFYKopE7AVSdGXDFKlgxdwkhRa9f3DJhLW3Y6Z2kJoBzCEoCUk6TMk0uzuC
	vnxn05FggV77BChCoDVXqnATAKfgFoJ0unvjryrb3Ng6VZNsZ9cnWytRdxUgkblC
	7K0bsY7O5S7dC1/Et6cD9QO1puROUmRyw9FLDYeI+bLBxVI+002nsoiEK3VkjZJC
	mtci1YVd8nbs6p1Z4Ggq/HTzGhOAYl3+LQ07cKtumE0Lxju/UfuzkEt3iwp6yLCE
	qhdqbBWuQsyOHSCyzjROgZZ6nr0YDxPPCOOCOduMIg/0h8tNe+LhzBs3OgnKOssV
	Wk5CUw==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e0pen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:32:39 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3de3b5b7703so13359485ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240759; x=1752845559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thUDUj4ntHriDBH6aejx31sCgkmryjUnapSdrJV27l8=;
        b=Ec6rOwoErqcOmTMh4hx4BboSsNTuv0Cbj6heMTRP+bJD1ozzNrExuE5nVztmIn+a8T
         Vg+3jBCgdsbxD364AFkyr7s1ubcuw4GKIJRmRx8o2mIhw/QczOVDpVJyi95GbrpAayWO
         b4k2/yKBQWhFVycDAT2iRsYzDZE9mfMIcn7D6osHUZLm+rGhTH7xgKon1UM64Zodj6Ar
         iijPkcd9910XZIOZNrOTlw9USEHu2IinFiWqjiHccahuY+h+XNmUKxolbyI7zciZJkkz
         CGALC7xVf/VlmzKAaSRlH8pUWLncjEKw6giNSfVk6XV4plgD+sBABjEUYa6ZLLZy5Q2q
         whKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwPRd1/97C/QvLjre0Dvv3U1uXkegzggoFygBfknsYvFwth2bHwnO5FEWUhGyPpSRmTZRjBeuPIhz0xZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLda+Mgj87zTO1FKUqiX8gw24nxWnHPo8CnSke9YkrB002dcOr
	q8VnqV2yKTSGbqRdrMmWopfSqm2Pl7B6+IFktH0bCeSRwiAaxpVpUuxRk6hP1GdnnzG+Cg3gLNz
	EgLX7kbiW6rRZST5E+xSojRHSxT44LMqsJUJJnWFBRcIz/d2TGVJtMfCxjT8zqksObQY=
X-Gm-Gg: ASbGnctHolborvARSozGcfeu1HRlLnXgnseJL+gvWnmoe1dixdYD1eMzHv2KZWJ8Mmn
	WB4b24IBAGfxY2qsPk5CANKM//F7S7LV8iUFz6uZ3tZ5DapqY5RxLqekGb6/MGKOrAjm7vyJ08/
	36ZLkhjjNsC9W070ZhlvTseB+2+tzIwB+xGVtwh7vixEz8LtF8Tfki6WAVWJi6QK+/AKruMVtJu
	ZjqEtZeEFF6HhjcdjjvRimr391pbFnA6z3pVPlqixXnppbn6E2H+FZe6E2WaAk1PNicC0dlxnZa
	nmeP3pkZpYh/kHKZlQIfQ5Jw4FUWgiFI+S0J4xza3XmhZro7rYpTX57QBfdlqqfNksU=
X-Received: by 2002:a05:6e02:398e:b0:3df:3598:7688 with SMTP id e9e14a558f8ab-3e25434f9bemr37217885ab.21.1752240758562;
        Fri, 11 Jul 2025 06:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIF0igNgHju9Rl8GNa7JzdKd+TODV4gvdmsYawmICuzsGWGTS3QwLPPSzsDZlNmOF3ncQ7iQ==
X-Received: by 2002:a05:6e02:398e:b0:3df:3598:7688 with SMTP id e9e14a558f8ab-3e25434f9bemr37217215ab.21.1752240758111;
        Fri, 11 Jul 2025 06:32:38 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d511bd78sm87860525e9.35.2025.07.11.06.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:32:37 -0700 (PDT)
Message-ID: <87a56d1e-2bbd-4abf-91c8-5129835d8d87@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ASoC: codecs: add new pm4125 audio codec driver
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
 <20250711-pm4125_audio_codec_v1-v2-2-13e6f835677a@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250711-pm4125_audio_codec_v1-v2-2-13e6f835677a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G1SVn8TgzoXQqRkPwh8rtJONTXP2TsZL
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=68711277 cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=kjzoyE47cCA4-HZi2KEA:9 a=QEXdDO2ut3YA:10 a=mHQ74H5e8mo-RpSg_uaF:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: G1SVn8TgzoXQqRkPwh8rtJONTXP2TsZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5NiBTYWx0ZWRfXzBR8e8mRO6nP
 kaKG9xpTLioPOdQ6d5cgj44zkFQOWAeeKYl7snL0DuumjDnius3uGG5hYNcCHOopV6cIignLHb6
 ryQ1glZMuCqVlbLnXILbUSS5FyYsEMDEUgHFiGJRNdqvHstoAUszc+lf8Vkr4oR8v9IMPB78EKP
 FScOQRZnXaNP3yPzWCARcbeNS2opXlchmfQO0Fo/s5aJxaNqlr4ORjFIApf4BAydQzQoxVyeJOc
 6odyhdnjuNMtCPtqGXkHaM8lExaxqjnFBFYNPCpxZFWn1l6orQPuA1+3rmBaZeHnr6vHTL1+ZaB
 Fx4CAI35O2yJxZggrPlXnSFUBEuGyQPx7rhehDTNoaXsUQb7I+DHxzZRv9nryrBL9H6O0jNXKKG
 Awd3q+rXl5HK3H2KzjOVnwKi4A/fbS1sY6Q2iC3TeC3ATlptwe/3EjMcCpfuXYkNidVeL0Ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110096

On 7/11/25 4:00 AM, Alexey Klimov wrote:
> The audio codec is found in Qualcomm PM2250/PM4125 PMICs and is used on
> platforms like Qualcomm QCM2290. It has soundwire interface and
> corresponding RX and TX slave devices.
> 
> It has only two input channels: HPH left and right. The line output (LO)
> is linked to HPHL so the hardware has some limitations regarding concurrent
> playback via HPH and LO for instance.
> 
> The codec driver also uses WCD MBCH framework. The MBHC functionality is
> implemented in a minimalistic way to enable IRQs and avoid different
> issues with IRQs.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>

Thanks for doing this Alexey,

I have tested Headset playback, headset recording and Lineout.

While testing I have noticed one issue with the places where enable_irq
is being used, there is a possiblity of things going wrong in some cases.


> ---
>  sound/soc/codecs/Kconfig      |   18 +
>  sound/soc/codecs/Makefile     |    8 +
>  sound/soc/codecs/pm4125-sdw.c |  546 +++++++++++++
>  sound/soc/codecs/pm4125.c     | 1767 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/pm4125.h     |  314 ++++++++
>  5 files changed, 2653 insertions(+)
> 

...
> +static int pm4125_codec_enable_lo_pa(struct snd_soc_dapm_widget *w,
> +				     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct pm4125_priv *pm4125 = snd_soc_component_get_drvdata(component);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_component_update_bits(component, PM4125_ANA_COMBOPA_CTL_5, 0x04, 0x00);
> +		usleep_range(1000, 1010);
> +		snd_soc_component_update_bits(component, PM4125_ANA_COMBOPA_CTL_4, 0x0F, 0x0F);
> +		usleep_range(1000, 1010);
> +		snd_soc_component_write_field(component, PM4125_ANA_COMBOPA_CTL,
> +					      PM4125_ANA_COMBO_PA_SELECT_MASK,
> +					      PM4125_ANA_COMBO_PA_SELECT_LO);
> +		snd_soc_component_write_field(component, PM4125_DIG_SWR_PDM_WD_CTL0,
> +					      PM4125_WDT_ENABLE_MASK,
> +					      (PM4125_WDT_ENABLE_RX0_M | PM4125_WDT_ENABLE_RX0_L));
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		usleep_range(5000, 5010);
> +		snd_soc_component_update_bits(component, PM4125_ANA_COMBOPA_CTL_4, 0x0F, 0x04);
> +		enable_irq(pm4125->hphl_pdm_wd_int);

if headset playback dapm widgets are powered up or active and you try to
play on lineout you would get below splat:

[ 1181.352762] ------------[ cut here ]------------
[ 1181.357435] Unbalanced enable for IRQ 156
[ 1181.361489] WARNING: CPU: 1 PID: 877 at kernel/irq/manage.c:753
__enable_irq+0x4c/0x7c
...

[ 1181.483541] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[ 1181.490534] pc : __enable_irq+0x4c/0x7c
[ 1181.494405] lr : __enable_irq+0x4c/0x7c
[ 1181.498278] sp : ffff8000840ab8a0
[ 1181.501618] x29: ffff8000840ab8a0 x28: ffffd79b9725d588 x27:
ffff8000840ab948
[ 1181.508796] x26: 000000000000309b x25: 0000000000000080 x24:
0000000000000080
[ 1181.515980] x23: ffffd79b9698f250 x22: 0000000000000000 x21:
0000000000000000
[ 1181.523153] x20: 000000000000009c x19: ffff23c347fd9400 x18:
0000000000000006
[ 1181.530335] x17: 0000000000000001 x16: ffffd79b94dbcce8 x15:
ffff8000840ab46f
[ 1181.537508] x14: 0000000000000000 x13: 3635312051524920 x12:
ffffd79b96d96768
[ 1181.544691] x11: 0000000000000058 x10: 0000000000000018 x9 :
ffffd79b96d96768
[ 1181.551862] x8 : 000000000000024f x7 : ffffd79b96dee768 x6 :
ffffd79b96dee768
[ 1181.559044] x5 : ffff23c3bbbb8508 x4 : 0000000000000000 x3 :
0000000000000027
[ 1181.566217] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff23c35a0a4600
[ 1181.573392] Call trace:
[ 1181.575871]  __enable_irq+0x4c/0x7c (P)
[ 1181.579748]  enable_irq+0x60/0xd8
[ 1181.583098]  pm4125_codec_enable_lo_pa+0x6c/0x1a0 [snd_soc_pm4125]
[ 1181.589319]  dapm_seq_check_event+0x11c/0x144
[ 1181.593720]  dapm_seq_run_coalesced+0x130/0x1d0
[ 1181.598286]  dapm_seq_run+0x264/0x374
[ 1181.601991]  dapm_power_widgets+0x664/0x900
[ 1181.606212]  snd_soc_dapm_stream_event+0xf4/0x178
[ 1181.610957]  __soc_pcm_prepare+0x64/0x120
[ 1181.614998]  dpcm_be_dai_prepare+0x120/0x168
[ 1181.619299]  dpcm_fe_dai_prepare+0x94/0x178
[ 1181.623517]  snd_pcm_do_prepare+0x30/0x50
[ 1181.627567]  snd_pcm_action_single+0x48/0xa4
[ 1181.631872]  snd_pcm_action_nonatomic+0x94/0xb0
[ 1181.636435]  snd_pcm_prepare+0x7c/0xe0
[ 1181.640222]  snd_pcm_common_ioctl+0xca4/0x16e0
[ 1181.644705]  snd_pcm_ioctl+0x34/0x4c
[ 1181.648315]  __arm64_sys_ioctl+0xac/0x104
[ 1181.652355]  invoke_syscall+0x48/0x104
[ 1181.656147]  el0_svc_common.constprop.0+0x40/0xe0
[ 1181.660892]  do_el0_svc+0x1c/0x28
[ 1181.664242]  el0_svc+0x30/0xcc
[ 1181.667340]  el0t_64_sync_handler+0x10c/0x138
[ 1181.671737]  el0t_64_sync+0x198/0x19c
[ 1181.675430] ---[ end trace 0000000000000000 ]---
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		disable_irq_nosync(pm4125->hphl_pdm_wd_int);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		usleep_range(2000, 2010);
> +		snd_soc_component_write_field(component, PM4125_ANA_COMBOPA_CTL,
> +					      PM4125_ANA_COMBO_PA_SELECT_MASK,
> +					      PM4125_ANA_COMBO_PA_SELECT_EAR);
> +		usleep_range(5000, 5100);
> +		snd_soc_component_write_field(component, PM4125_DIG_SWR_PDM_WD_CTL0,
> +					      PM4125_WDT_ENABLE_MASK, 0x00);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +thanks,
Srini

