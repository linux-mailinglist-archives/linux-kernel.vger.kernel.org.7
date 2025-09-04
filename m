Return-Path: <linux-kernel+bounces-800581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F1B4398A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F0317B6D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CBE2FC024;
	Thu,  4 Sep 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYfoP760"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888472FC02E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983993; cv=none; b=eov+B3XMBIqZDWc5EaonLmGnC7jhGAXCXA/qq5hi7Y93B6ViaDh7X+9qEf3xw2hp1CRp7T/ofKRrqKOnJK7H+GP8ydt/DjOWI12Q4aF+15Ey8tv9moobsPVIwl7K2MePeNjWlKieeXizNHy1rAcRbU+cgY6Wixg/hSCgMV4HWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983993; c=relaxed/simple;
	bh=5vZcmgBM+9Nv9iip0wHP9dGmRG2D1+tPZM/R2QISb3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=akreWMZEAnh5ix4O6SuSdDcUqeEUtxRllkPRdXsjylIs6bdocgUcdoA6cpzGt8fDHUKpjagfOiT1tGIwq7X068CYgLoueh4o65vbJyywfBrLjPCo0Au3Nsjy+7nXeAVPZu+9x3SYsoBTJqSx8un5U8n4250n85zYMcNQynyumYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYfoP760; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7Ja022145
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhYbFIRKKiIOKT8Pi5ddhFvBtwfY5TujA8EjKQzqmHA=; b=NYfoP760/aavXEgn
	NAeSWua4vdb1T2zsy+jZJLjjOyAITEG4X7hv224yW+jBIISzyHdN5NGnhT6NoDSN
	T8qiYfeJsPYpMQV26puRU+9MYHu8/iSQP2cTu3a8X1mY/OBAkNOjI4dc/fl0fCFA
	aAJsKc9MQ6j60ZSvLGeE/5D1swcb746fMbRh8apqsvkyVaPYh64XACZ+NmN2sJM9
	hKo+fva3SaBLMKegUwmaH+hnGjo1LpXEaEgOopn6kafVEVU7K4TqO+5tqMil2oRp
	S8OJCZi/qDoram6vU5TTGnN+EBcjauUfiJp1bFenA/N/y4TwPFywXAhF0o62RYxZ
	q8CzAg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk973ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:06:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-724ee8d2a33so12093806d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983988; x=1757588788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhYbFIRKKiIOKT8Pi5ddhFvBtwfY5TujA8EjKQzqmHA=;
        b=bxSW/Fl0sN/kVmhyNPpr2Lcm32h+tSmUkdhNKyLtABqeZq9hj8nF3jY3i/3GXT7FfB
         fcutT8Zshimfn7G5hdabjRFWO0JpPbuiFke64u9vFlVBR5fxJ93ZDVSiHq2eMel4EAYf
         kc3LmKsOI2Sd7+xhx3dFWYKccvQFRzKC6fMCmx6nzXMj8ihGZ/8KsMdlkKuJr+RrjlLF
         d7Wgs3BQy+XcdloXG1MA0j/CbJqTVhI1SPPxVj5m8s8A+2RRMnxCPWHNUL2OnDenCSnp
         TnXgxyzb/0zetvgT+j9G5YOQ7viyEu8GPApfcZhXVs4en6jxpM3SwPWNij2L7A7B/w4B
         ksqA==
X-Forwarded-Encrypted: i=1; AJvYcCXBzX9VUE/ndS/k+NU9Yioq3nAQX7YqkKF7WwH3358ShCVV/XIt68HhTwVvr0CZcm3jPy0Uv2kdbX2g9pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvMmNXRCxtLLcBDPif0IaFiv3IK/vkXPl/LsxdCPFmu/k/iza
	XOwMFYUy8BeuZr0SXCbx6B54Q8t0EWzxamtBy0rRjDOILWPr9NU9/6nF12go6cqDn075nmujfLF
	GppkK4IAt3uu/Mu/JJwiN0VXmWbrtwj9tg7PBExjVtazvJ5THL/smIWVph21yYMaj9O4=
X-Gm-Gg: ASbGncvIdzGlaavCfWdEepaRV4v202baDc2K1YLaUBbsHeDNjO84mroAJcPdGXsHKno
	KvwVDuj5SulZlSEm3+nLGo7aI9LPmpW2X2TAqEBtnJe5o638xEkF/YHIo5hQJv6NfRT22xXheW6
	cuGtl5evn4jHnLaoh86nZ8StasccbvmMBlxgkifzfLBgE00kcERvyKhQkG5rwghIInM0x+/CuDk
	TLwnNxfNmBWZ3zZfJ5ZCaYCTYhq1UoCUF7oG1FfnRqdc4lzHG4N10TMG8EjqOB8+bcw/c7x3Faa
	OekiJCC01OH+X5myXXY6hTy5NJE15Tf7Qbxy3ot7W36wtLJRU3NJhfEhYTag6tbSFVQ=
X-Received: by 2002:a05:6214:3015:b0:70d:ba48:f8b1 with SMTP id 6a1803df08f44-70fac86ebe1mr208966466d6.31.1756983988357;
        Thu, 04 Sep 2025 04:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiU50o2//fs1eSkv5hsgG79HTu0XUnuA2rf/GSrZwv3jzhD7GlK0nFH1+s4mvAUoYiQMkTNg==
X-Received: by 2002:a05:6214:3015:b0:70d:ba48:f8b1 with SMTP id 6a1803df08f44-70fac86ebe1mr208965996d6.31.1756983987822;
        Thu, 04 Sep 2025 04:06:27 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm94775045e9.16.2025.09.04.04.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:06:27 -0700 (PDT)
Message-ID: <b396807c-309c-445c-85f4-b9c7ec5f1b88@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 12:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: qcom: audioreach: Add support for Speaker
 Protection module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 16QspcVm_r5LTGk9vjrI6HXw08gOdP-U
X-Proofpoint-ORIG-GUID: 16QspcVm_r5LTGk9vjrI6HXw08gOdP-U
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b972b5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jR5H-ETkXLhSoB5CPuAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX9gy+g8Hs7OoU
 0IpDWa74vHa7unYR12Ax0Z2hQqEwJX+qg+eo5IE8HBzPZKXOIsZr8Stui5pTwDnkvLyHOzXT34J
 GSt7mHWaq6f2ztHbqZEcAQHgW1o9n5VrgW9dv4kqilrW8nVgWUdebZAGS9xNRBIArkEyZapwGXG
 38EhgqF4fZlM9uF47R0+6BsHZ0kQpS+JOBmE6LyqJ7jutEAwjv5HyiR4jdalPsk+EXcJ4WgRlxG
 uKnAWBDuzfbh982z7++5kR9fsWZU4VYuVzOzJ7HpmPhEdKtVC6IHzwF3c5A1ORl0sGrB/ZdXQ0T
 FroIWTWf+MKAgRmk6XRsSUgZqvCaKbdC4rC2cLQ/dkayHJbp0Xo6lVjmS9KtJZGY24nhPi2plKn
 BqWQx6gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 9/4/25 11:25 AM, Krzysztof Kozlowski wrote:
> Speaker Protection is capability of ADSP to adjust the gain during
> playback to different speakers and their temperature.  This allows good
> playback without blowing the speakers up.
> 
> Implement parsing MODULE_ID_SPEAKER_PROTECTION from Audioreach topology
> and sending it as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini
> ---
> 
> Changes in v2:
> 1. Add and use PARAM_ID_SP_OP_MODE_NORMAL
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 13 +++++++++++++
>  sound/soc/qcom/qdsp6/audioreach.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index f4c53e84b4dc..3b7dffd696e7 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -1250,6 +1250,15 @@ static int audioreach_gain_set(struct q6apm_graph *graph, struct audioreach_modu
>  	return rc;
>  }
>  
> +static int audioreach_speaker_protection(struct q6apm_graph *graph,
> +					 struct audioreach_module *module,
> +					 uint32_t operation_mode)
> +{
> +	return audioreach_send_u32_param(graph, module, PARAM_ID_SP_OP_MODE,
> +					 operation_mode);
> +}
> +
> +
>  int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_module *module,
>  				struct audioreach_module_config *cfg)
>  {
> @@ -1299,6 +1308,10 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
>  	case MODULE_ID_GAPLESS:
>  		rc = audioreach_gapless_set_media_format(graph, module, cfg);
>  		break;
> +	case MODULE_ID_SPEAKER_PROTECTION:
> +		rc = audioreach_speaker_protection(graph, module,
> +						   PARAM_ID_SP_OP_MODE_NORMAL);
> +		break;
>  	default:
>  		rc = 0;
>  	}
> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
> index 790fba96e34d..9f6ddcf081ee 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.h
> +++ b/sound/soc/qcom/qdsp6/audioreach.h
> @@ -31,6 +31,7 @@ struct q6apm_graph;
>  #define MODULE_ID_MP3_DECODE		0x0700103B
>  #define MODULE_ID_GAPLESS		0x0700104D
>  #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
> +#define MODULE_ID_SPEAKER_PROTECTION	0x070010E2
>  
>  #define APM_CMD_GET_SPF_STATE		0x01001021
>  #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
> @@ -542,6 +543,17 @@ struct data_logging_config {
>  	uint32_t mode;
>  } __packed;
>  
> +/* Speaker Protection */
> +#define PARAM_ID_SP_OP_MODE			0x080011e9
> +#define PARAM_ID_SP_OP_MODE_NORMAL		0
> +#define PARAM_ID_SP_OP_MODE_CALIBRATION		1
> +#define PARAM_ID_SP_OP_MODE_FACTORY_TEST	2
> +#define PARAM_ID_SP_OP_MODE_VALIDATION		3
> +
> +struct param_id_sp_op_mode {
> +	uint32_t operation_mode;
> +} __packed;
> +
>  #define PARAM_ID_SAL_OUTPUT_CFG			0x08001016
>  struct param_id_sal_output_config {
>  	uint32_t bits_per_sample;


