Return-Path: <linux-kernel+bounces-781695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42185B31598
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86D31C205E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355122F6181;
	Fri, 22 Aug 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KThJm8W6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E092F616F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859148; cv=none; b=JKYb6kwJQ52uHicDNadYeSF12XYdfMkRzeRYkxHuAGX+BeHEKu4r0ATodJKRIpsTkJ1CyZxNNbJwWjXCda+xisMlpbZZuATBhkLH+OGLaSrFh6DJY2tZO/A3Wk9kQfka8JhsNEY9VnNHaXBp/6tON9ES8L/IB4nqFHOSoP+9B6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859148; c=relaxed/simple;
	bh=jUX/r9RsZcGNRJ/PKy1ft9RmpI77wTYlMOSZQGBL1e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CTI1DWAHDAjZavtDPxcQ90QiXRA//qrz4uayu1K6ZqkL2LKKVmPDws9fQ1JHOSrvFlJiki8/qCUg5qPJ1hPBsq6fQxIkxJFQG08h4/Kv2ubEeTLZbXfmkgZX5vUMTPT1PTFyajulfWfsyeLpF2cE+hefJT3K3xMS22+Mz+makIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KThJm8W6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UM0D011160
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tEYj78kDDZNqCektDc9Qzj8ZYGHcgUPi5WGwOTOcZMY=; b=KThJm8W6guybmZky
	4Gpe717HgSm+HdEq8UaU8LDF70MF4SVmZismIDipdr06drGLvJ1V1n+BfuWxIUTh
	BASEwGA16njo+Cz2rWgY1M++WLlj0g8SWd7C//SWE39lMr6/GSp2qHjeKTLYc3gg
	qGzBu8wxfCEDiPBGYiI2xH7dFDGbNu8binKDgukMTflrMX8Vwlxy5TUGCeRYJPSy
	J+hVniMCvitFgeFgwdkt89Ur8wjpf7GuR6XNUPFF2w1Xw+xQuCiPg9DiqmTTWMu+
	IcZeXAtZvZF55XZuuHFuUVFSUwtjPwKMzMWszA3HAUkpi7fBGJFt42cr+fdiCVGd
	l2geOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8eqfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:39:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e86499748cso803963485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859144; x=1756463944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEYj78kDDZNqCektDc9Qzj8ZYGHcgUPi5WGwOTOcZMY=;
        b=jOQF8iJfH5fDVn/2HKDoO5oTHDP0MOec7qbwp8fiJOs57wVBXn1aLDDCaVUiiAI/9z
         boTebPoD9yp4Rlw/iHb91zKc8GzZQG15uJHKJkHIXSi5YaS1R9vdGY/tcuVPGny8JWyK
         lZiEVnnYeWyECJwqZHLtIsFKbSLZzzIjQ53thmaVA+2ivfZCt2kbNKONEfqceFVwJzQo
         0Bn2CYZHUCTjhmVcGYYrf9vavwOL2hllv6VzGP4sBLcqsOiyKREKS4rHMjy5yuf+7/OC
         yO+b7u2+vhdd0ddXIthLp0WcDXenf5MLptISK7fGvFh2NpIjrlAYiaGoaCtlcUQi5IwJ
         z6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAU9K+EI546Bw0a67msu1wWstxb3lIiXhFXcNTodaEUOW70UMxPu1Pw+1fBCHfDav2tf6XO5aE8TBPDek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIcTItcUVBwSxuUiebIFFFiq6cJxYmrfcOgDlyi5HpZ6HHDJF
	QArYUwOf/Vzz5xDS1CS8yLhdQ60n0J2YUmUdw2a1Bjx+TXdewvyo4h93lHA+tnnhWvhIsM+sVuh
	ApQROw/uomhpHeIkF4Tu1NiDJbnNDduxa7en4xxxsxQy2njPO2gxlRJWKPqgXvIwjo4A=
X-Gm-Gg: ASbGncuWYRXlXJH1hMBeWMfR0iPolTWOf3KgKalT9Ysqo071ZYE9TnSoedvhxt9ZjwM
	H54yt4W0YUO9SQtboAlD5MSljqLJkEc2TPXZ3zn0X15rfELdPFn9Vkb/5DsySKmM6t6Kumxk9NI
	fgbLp1VpOImrxizSNv5pkD06pPm5qyVhFlKzzdd6DlyNy9cft8USVkG7czKajyiqobd/IUiDJnv
	e49ACHGO6WEJEwMfP7CRQdC+xZSspQ+Mkbt7WEQ00OnvB9I9z4MBDt5Tt6YVxoyOWsNOD9nsyGR
	FCvELt/Q8UC3b0/WBcgntLBTQFixo44CPfxrOMqlZiDKpWw/5zrFB6k/PF8Pdso0TVE=
X-Received: by 2002:a05:622a:389:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b29ff9063fmr57492491cf.17.1755859143791;
        Fri, 22 Aug 2025 03:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDI6VWxl67USh3oUaMFJLIrKflkLf1xshpbfrxke76ywOQuvAn1j74aJhLi/r7gO3jGaiwLQ==
X-Received: by 2002:a05:622a:389:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b29ff9063fmr57492281cf.17.1755859143324;
        Fri, 22 Aug 2025 03:39:03 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3527432f8f.14.2025.08.22.03.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:39:02 -0700 (PDT)
Message-ID: <2566eea5-a153-42e6-9a43-1c0af5a4c11c@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 11:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: audioreach: Add support for Speaker
 Protection module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfXyCFHfUTu4deb
 rmvLKO9HBemM03bwvmi9lQ+wQgeU+UfBjcnyl9fzUCzusEx9A89aaB6En2ptm4A9jQyNzdpOM3G
 qOgAlxoimMqkI1vcfiT+nZLV7/69qe8/HQc/2CPcgk5p/ibjUWVmLfDuesgxi+CSzUHEYT/NUIF
 a/W0Ax/UO8s5EGO9vedx157DmK2o0NGRz1X5P5aASBmsJvuv/lz5zeoSVISJAPGyxPW6Z+TQjKp
 AAM+GDhI/g4+TOZD6ltj1JKsP+OJVNV+I1Cr1CCAEO11VWcVuLKoXgw5yIJXYZfFIXT9o4P0tVQ
 DIaxpYdX3o1E96sicj+YvE1s7FjiHlFUa+8o/f8xsz8wgGjrkoZWBN1yLw/Wsx4VQ4BhfhjceTN
 OrIqStEJhN/YcoVCjUXdiJkW3H/qhQ==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a848c8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=jR5H-ETkXLhSoB5CPuAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EEjie_mjjXKrhhR9Idf56J4UfnkTAg37
X-Proofpoint-ORIG-GUID: EEjie_mjjXKrhhR9Idf56J4UfnkTAg37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

Thanks Krzysztof for doing this.

On 8/21/25 3:16 PM, Krzysztof Kozlowski wrote:
> Speaker Protection is capability of ADSP to adjust the gain during
> playback to different speakers and their temperature.  This allows good
> playback without blowing the speakers up.
> 
> Implement parsing MODULE_ID_SPEAKER_PROTECTION from Audioreach topology
> and sending it as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 13 +++++++++++++
>  sound/soc/qcom/qdsp6/audioreach.h | 11 +++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index f4c53e84b4dc..b7f1fc835dc2 100644
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
> +						   PARAM_ID_SP_OP_MODE_CALIBRATION);

Are we leaving this in calibration mode forever? When does the mode change?

> +		break;
>  	default:
>  		rc = 0;
>  	}
> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
> index 790fba96e34d..0ad566e45e09 100644
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
> @@ -542,6 +543,16 @@ struct data_logging_config {
>  	uint32_t mode;
>  } __packed;
>  
> +/* Speaker Protection */
> +#define PARAM_ID_SP_OP_MODE			0x080011e9


Are we missing

#define PARAM_ID_SP_OP_MODE_NORMAL		0
?

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


