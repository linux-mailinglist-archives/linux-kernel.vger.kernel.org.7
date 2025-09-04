Return-Path: <linux-kernel+bounces-800138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B47AAB433DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABED91C25EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA942BD02A;
	Thu,  4 Sep 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WS0G3pg3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB52BD024
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970657; cv=none; b=ZajF1XPfB46Q7bH4OasStJcrIo0A+wmH4MLKhrajdUkc+M6muy4eUvQOj1eM87rq4Z2HLPSKMmRrbaEYCbiF9+8TlqFEEwxMd0jI7CdeLOuxRf/IdEXYsrDO/P4AVud8TTKbyZytGI3554wQOK0LsQbx55rPfzqyiDewfKk1Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970657; c=relaxed/simple;
	bh=DoJW9RcGqDECsrTexk01tZGY2qzWHhWKZJkm+4qcdqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UONaLkicJumC87ai93i27+5IVH1zQN0VdC18EXnFo47JNNzLM7VRbBMdn/RUsQ3M8aDnINlKMBdtandAAy0WUFGHMKF4t0cCgJ2er0OHKgstBrbtfg7XRO5tlm5xqTkQ6DPtBN0t8H6FlFuXy7JCA99RcEEqCMMdba8uTAR9Zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WS0G3pg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840BbhY029143
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 07:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	neETbrUFGTfGqy8dnw8ZO/Ru3fbeUxPbB5fjZXKFH34=; b=WS0G3pg3h/9aa+Of
	al8Whdp4JQ9sFkrD9gaUYw2dXAO+p46x60pJBq/8nmwFD/jxKNv55drFPzuQskm6
	ATUUgqeVEBFU9LqjkDacf50Mf+UqKRA4qUuZNi/f/UjRa9jNY6YTqZVJFI0VNsvk
	6DBMOWXimF1oLJY9HdIuO/QhBR7DIv13KPEV3Zr3vwxPtBM3onxlgtl8Ioj2MGo2
	667CK1w5l2N3+2kHuWK2pLrLotfY3NQ05qoGfMm0zNJJbWxrsGiVtE0wKdK00mMy
	4MLzOPSdSes74518UjMhSgpMV9B/C+YY2Im4zV6SqpNkcJN3CqmX1R39kS0h6d3L
	oNCLXw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw06mvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:24:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b49666c8b8so15372561cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970653; x=1757575453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neETbrUFGTfGqy8dnw8ZO/Ru3fbeUxPbB5fjZXKFH34=;
        b=ipPE7AIWS93dLLwZihpPCEifAocgoDAd8l2H+nB49foI3utg+u8V1wuudRsew6C028
         tcr8OFG6CnnteJ1Yv76qnOzJ5L4wehGl3i3LbKxuJa0FMPJxoz111XdW9tiAUXUmEj0L
         xRD5OhUCpXV+QHGfqGh2s7Ur9BZKYZx53Nvr/i0WuVXlZOh3e5rYtlhr4gVT162lJxxi
         zlDV58YurQh7E280CEIO2gPJd+DQNeuClbvBDOXxk8RoXfOuv183zu0ajrAeh9+di7PU
         i+0IER4kixH2NIkiJeHqVPQa02FU6V192ozUFYI4eQVeWU5TnyXckQpWjPsd+x0O6jyU
         cvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAZJPuBZ0xLEZomNSms3BGULISp9Peg0YVo4QFeG9MSmktQXn0TztKrvr/sjgocHawBCwfCEvZw4gVohw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtgcm7/Kh0UmBxKkgdi4+HJ5PMh/OX29HO1QUTfos1MIo8dwB
	xcp1J3IOzQYKx9xbE58qB0gfKtzN9vx3kEQJyL7vyJMPktk9ea7EiZibVHCzMen/7y9a1+mO+tA
	k83pkfzeubfNs5Hru49Vps3gTm5hyMgqVbpZAEe3N7q7nnCYU/QPYa4D4T3hVIPm+0O9+Ll6xtr
	s=
X-Gm-Gg: ASbGncv2lHbX3jGHmUIWUeCfAvFKb86ifwVtc+EkWG6vB5xAceDZaPMppgqeQR8QaZG
	6pQaSLSydNEQ+AVrg30yGzDT4+Zj+8yR8U6CH/WBeHFDmzhO9F6vc5C91Z/oxmhkvLaIfQSxyjv
	cMUTxWx83XewHYzH4rqFr0rqzQ/ZOxxYxWGa/v12DpnNypk4AlJzZJMaYp/PC4RnauhrGjH66Iw
	0wbhEDpva8VBy4lR6ER6WpIF3Ja5UIjIu1e22QcN5rqKWU+rGI82dszkZEPWuLkZZ+m2EtyLbWO
	LLhIDt1quAfLwEMAUmsRxuGjswa/71PcQ+5u/kvGiQYIBQO4bhnrHec8AYcvsSUldHc=
X-Received: by 2002:a05:622a:1dc7:b0:4b4:9429:cde with SMTP id d75a77b69052e-4b494291702mr45223851cf.29.1756970653223;
        Thu, 04 Sep 2025 00:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmccJXRkeUqwZ0CBqmOBNM7TXito+6UZAQrgNjxmbeeqLIOsTYNBKn3U44hbsudYxcCCadTA==
X-Received: by 2002:a05:622a:1dc7:b0:4b4:9429:cde with SMTP id d75a77b69052e-4b494291702mr45223731cf.29.1756970652762;
        Thu, 04 Sep 2025 00:24:12 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf34491a7fsm25837656f8f.57.2025.09.04.00.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:24:12 -0700 (PDT)
Message-ID: <0beec691-a21c-4425-b06b-728d55e7e254@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 08:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: Fix speaker quality
 distortion
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>
References: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HHl3WFMIsee3A75xGHEk1LqkPLn65kM6
X-Proofpoint-ORIG-GUID: HHl3WFMIsee3A75xGHEk1LqkPLn65kM6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX8n2LMCr+IIgX
 jOHTMB6KzR4tyAYZoPkV0eQwTzRp/PSTf/n4qkzXGgviYpc0CUcFJIoO6VwiFiP0pXqSE4EVewP
 S7UystnQSVyYvBE6gpMJL1QUImwIyZhHGA7qJSCE6IMs/ekmBsCqUElgcJ7FcZNaHn/axJTeH1B
 WImF5iNR4H49bgTDcww1hSauXnKhhXv+8XsOXBuN2uLbz6sGiCYkXKnlMZWSLOctkQ/qxlq3SH1
 6sjKrA22ron5afcD3LVlW8TychNwES34w6PqcORL9aij86sSxga9UFATlU9AXlePGOVVNdMRy6f
 YLFlBuuMo2qTVY3Og3i2l4JrJN161aVSUH6jiazvMnII38lB2RNKGdISVfnd7xqlYmqK3Dw3WEs
 Z0lkma5T
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b93e9e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=VfCHAZMPGebhGeETFh0A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027



On 8/31/25 4:14 PM, Krzysztof Kozlowski wrote:
> Commit bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused
> AIF_INVALID first DAI identifier") removed first entry in enum with DAI
> identifiers, because it looked unused.  Turns out that there is a
> relation between DAI ID and "WSA RX0 Mux"-like kcontrols (which use
> "rx_mux_text" array).  That "rx_mux_text" array used first three entries
> of DAI IDs enum, with value '0' being invalid.
> 
> The value passed tp "WSA RX0 Mux"-like kcontrols was used as DAI ID and
> set to configure active channel count and mask, which are arrays indexed
> by DAI ID.
> 
> After removal of first AIF_INVALID DAI identifier, this kcontrol was
> updating wrong entries in active channel count and mask arrays which was
> visible in reduced quality (distortions) during speaker playback on
> several boards like Lenovo T14s laptop and Qualcomm SM8550-based boards.
> 
> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> Fixes: bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused AIF_INVALID first DAI identifier")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Thanks for fixing this,

tested this on T14s, WSA speakers, VA DMICs, RX and TX on headphones..
everything seems to work fine.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>


--srini



> ---
> 
> Reported via IRC.
> Fix for current v6.17-RC cycle.
> 
> I will be investigating rest of lpass macro codecs a bit later.
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index da6adb3de21d..d7eec9fdaf9c 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -368,6 +368,7 @@ static struct interp_sample_rate int_mix_sample_rate_val[] = {
>  	{192000, 0x6},	/* 192K */
>  };
>  
> +/* Matches also rx_mux_text */
>  enum {
>  	WSA_MACRO_AIF1_PB,
>  	WSA_MACRO_AIF_MIX1_PB,
> @@ -465,6 +466,7 @@ static const char *const rx_mix_ec_text[] = {
>  	"ZERO", "RX_MIX_TX0", "RX_MIX_TX1"
>  };
>  
> +/* Order must match WSA_MACRO_MAX_DAIS enum (offset by 1) */
>  static const char *const rx_mux_text[] = {
>  	"ZERO", "AIF1_PB", "AIF_MIX1_PB"
>  };
> @@ -2207,6 +2209,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
>  	u32 rx_port_value = ucontrol->value.integer.value[0];
>  	u32 bit_input;
>  	u32 aif_rst;
> +	unsigned int dai_id;
>  	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>  
>  	aif_rst = wsa->rx_port_value[widget->shift];
> @@ -2224,17 +2227,22 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
>  
>  	switch (rx_port_value) {
>  	case 0:
> -		if (wsa->active_ch_cnt[aif_rst]) {
> -			clear_bit(bit_input,
> -				  &wsa->active_ch_mask[aif_rst]);
> -			wsa->active_ch_cnt[aif_rst]--;
> +		/*
> +		 * active_ch_cnt and active_ch_mask use DAI IDs (WSA_MACRO_MAX_DAIS).
> +		 * active_ch_cnt == 0 was tested in if() above.
> +		 */
> +		dai_id = aif_rst - 1;
> +		if (wsa->active_ch_cnt[dai_id]) {
> +			clear_bit(bit_input, &wsa->active_ch_mask[dai_id]);
> +			wsa->active_ch_cnt[dai_id]--;
>  		}
>  		break;
>  	case 1:
>  	case 2:
> -		set_bit(bit_input,
> -			&wsa->active_ch_mask[rx_port_value]);
> -		wsa->active_ch_cnt[rx_port_value]++;
> +		/* active_ch_cnt and active_ch_mask use DAI IDs (WSA_MACRO_MAX_DAIS). */
> +		dai_id = rx_port_value - 1;
> +		set_bit(bit_input, &wsa->active_ch_mask[dai_id]);
> +		wsa->active_ch_cnt[dai_id]++;
>  		break;
>  	default:
>  		dev_err(component->dev,


