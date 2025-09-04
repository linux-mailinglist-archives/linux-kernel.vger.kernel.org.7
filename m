Return-Path: <linux-kernel+bounces-800574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5CB43979
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D481C8114B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE02FB626;
	Thu,  4 Sep 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHEqwVnP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084282D060C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983852; cv=none; b=E/C/2/pF67/1Nj2FabRp1GHXhzvp3TNzhZ51IkanQUjWKhQ8dH+98xwpNjOL4eEiYfloSsC9VP2cdGTg+TT+EfKYcZ3w6eS6SmWdd92PR+p1YQMM1GC/kYoJH9FIoIMcfncGzAoJMsW+txGtPOVuqHPRyZpA1FhbWPwDlj7segQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983852; c=relaxed/simple;
	bh=QjsIzOjiLkqmeUN7HOVaPIL7oU9r3h2GtT5k5IIb8wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EVgKq5IgtJrMh9HOl9PwicDHGVqaLpts9BS8Bzhgi6kcjoEB4x2e/w73trgU24cNksXSjIUke28ToR9094JmoFMOctbjeL0MWIOOYOLQm0rQekkJZ5Nj5xchjdjXsjGGRz6vIHs1ArBMd7Ar0SSl+ovUozqNV9IKg3zN4Cel2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RHEqwVnP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849Y4Q1005051
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNdNABuSYEsbe4+HKubTrqHVQ5x7i1zjHvXMg0jlse4=; b=RHEqwVnPTq92NNuc
	UohUVxTdUd7+/+YWA76yryypSQPvnY3bxKiz+hxZyRpl/01apSuQTcmgn8cQfhzX
	fjDaav8j7ldgug77xzeP0AYoO4DWIY0/D4KyY0Y9knCa4IPkAP/Fnmf6fKpo6Ghr
	HjeeFUfxl+u/bQS6tsD00SJteu44w3k7Pq8JgwC4h0gy9vMylh+sBo4PBKhvapV8
	wcKsIHk21Md0RuTToShftuPfjyrdo5hCL4vFMpbkvbUwU4GRVvnz4FiAGUSUCZie
	eHLRvxwPP2/9M0Ca9O7ZrK8ILuaKTuSBVRKElNBa8NFlgRZR4XwQDsrCmWBcZMz+
	ojbZoA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s7a21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:04:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b30d6ed3a4so17850111cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983849; x=1757588649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNdNABuSYEsbe4+HKubTrqHVQ5x7i1zjHvXMg0jlse4=;
        b=w7Y3SVTTyw+5T8bEct9fb+FHg9FtCYos2QFMtVg7R8XrlFvHdgEUPDMINQfBkbVw1I
         /RYkJ2cNIbrQwJX/6ffQrzWuDtf1LKIvvWroPuTnrFgm2BEIeiXneOwuskaEPUL8ru5Z
         t8TByUKur1Un74alHH2q9S7Q2uv17CHQBHP7VTbuF3rElT2rdtxKJ+vbZLQk4tCj6zem
         yYKgg/d+AT7W8XslsWHAAi/1/19vhE4oLw/aJm+SdLxpXpJqDcrBNSO5bnLNX3ZEoeF3
         dsYAlbM+cus61XixmD2u62a6pbTqPg5B4SwA/Sd/eLhnJ+2dJlQTL2eHCX/5LGH8njWY
         ixPA==
X-Forwarded-Encrypted: i=1; AJvYcCVtB+EqjYq/O08D6ISCJLsLA22e3CR2k2eisr/Qmy1x7/sXINEoWDDafLzewglXJZQmrMbpK2vTSTcQvro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTJgupDw6V0/aqi5BRKmobje/G02ZV4UqalaPXQGGAKhdWjyd
	o8715x8PXEUSuKOlZvRcypDpNK/jTmLHPXkGzPILxWKJXb4zjyiJnqKGj3FOSAP0RuGvfFUb7u/
	jLnI9VZ0zfkJpsOCvdlZQvINjizIWOctX+rpbLuZU4m6hkKxo6YDRRzVAPvTF+YvMYLs=
X-Gm-Gg: ASbGncutb+wLyBO8Njd+PjCymBuE1eafeaIxPy9e/VLRSCFb66r+B/HtNAmc/GWRwVK
	0DLWn9VHYna2wTplEvhzA0wRXRDru0lE2iXrsb0Tb1O20HxqPGOUM5izFM2007hQqjCmvW2rlvL
	vzJGXoItZruPLUTdgoYJ6jzxd9N3eTTy8aKFx64AM/6W5Zh1gYAmjfogV4i/z1fFBfHr7zQWw4D
	CFa5jIv0Abqisy5E/qChwyhzi9OCro47DONduGClGShJkxdHUaq1nPGekWzOBueIyyHVHUtYF3O
	0kVDZL8wklbhi5HjYPrSG7dvcl44BDlC5igivjAnk9m1PfrU5xyTkETcQF4Irlv/9yI=
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr9547331cf.78.1756983848777;
        Thu, 04 Sep 2025 04:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAIkjJX64TcWdyq3xxLdTjtxkU4I8xfAaee5dwnGcTaqYCdV2E4yyxcq0eFxGzzPynPGYG5g==
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr9546681cf.78.1756983848081;
        Thu, 04 Sep 2025 04:04:08 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm17959025e9.7.2025.09.04.04.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:04:07 -0700 (PDT)
Message-ID: <79274958-52a0-4041-b4f3-365ee84fb088@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 12:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: qcom: audioreach: Add support for VI Sense
 module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
 <20250904102558.143745-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250904102558.143745-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX9Rm2G3Q0jZXw
 032K+efUcG1QVV+Bmph98EYTS5cicfWU1Ea19+yjN655pyC6T020nt7JcKBcHg0CdwEK/d+I6KG
 ls+Cx4XGBX9iNJnaUxS1YRgcDLjsMkfeJ+rQfEqShi5S3n9wkXqVMDuKYq8ipeCUbW64o9YFaTW
 XI6ANxO1fzNHtqD5OYj40vfLf2uUvHf1Qo1CLa+HGnWFcwb1kZoEqXWzI5oIa9xaBPXLFnjwFdq
 ToGeG1NTls+GLTf+1S5vS6P42LJkDDYEze/491MAhJSLwWYHm27PH4NWWlYFKzNHrDL4trEn1Uk
 3Jg52tsM6xnNJ9djXYApsJ1s6DEupCfHZye4YbBYjg/UPlgVxLEKFBSDcCyW2tQ4GJHEwkRNvem
 rElDixSk
X-Proofpoint-GUID: hHIDXEncD0t2qSVYIiYYBrAsFargz1Dv
X-Proofpoint-ORIG-GUID: hHIDXEncD0t2qSVYIiYYBrAsFargz1Dv
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b9722a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=zgq_qGFzbcYR-VCCdk8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019



On 9/4/25 11:26 AM, Krzysztof Kozlowski wrote:
> VI Sense module in ADSP is responsible for feedback loop for measuring
> current and voltage of amplifiers, necessary for proper calibration of
> Speaker Protection algorightms.  Implement parsing
> MODULE_ID_SPEAKER_PROTECTION_VI from Audioreach topology and sending it
> as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Use PARAM_ID_SP_VI_OP_MODE_NORMAL
> 2. Make num_channels u32
> 3. I did not change uint32_t type in the header for consistency
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 112 ++++++++++++++++++++++++++++++
>  sound/soc/qcom/qdsp6/audioreach.h |  27 +++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 3b7dffd696e7..f344ce80676f 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -202,6 +202,31 @@ struct apm_display_port_module_intf_cfg {
>  } __packed;
>  #define APM_DP_INTF_CFG_PSIZE ALIGN(sizeof(struct apm_display_port_module_intf_cfg), 8)
>  
> +struct apm_module_sp_vi_op_mode_cfg {
> +	struct apm_module_param_data param_data;
> +	struct param_id_sp_vi_op_mode_cfg cfg;
> +} __packed;
> +
> +#define APM_SP_VI_OP_MODE_CFG_PSIZE(ch) ALIGN( \
> +				sizeof(struct apm_module_sp_vi_op_mode_cfg) + \
> +				(ch) * sizeof(uint32_t), 8)
> +
> +struct apm_module_sp_vi_ex_mode_cfg {
> +	struct apm_module_param_data param_data;
> +	struct param_id_sp_vi_ex_mode_cfg cfg;
> +} __packed;
> +
> +#define APM_SP_VI_EX_MODE_CFG_PSIZE ALIGN(sizeof(struct apm_module_sp_vi_ex_mode_cfg), 8)
> +
> +struct apm_module_sp_vi_channel_map_cfg {
> +	struct apm_module_param_data param_data;
> +	struct param_id_sp_vi_channel_map_cfg cfg;
> +} __packed;
> +
> +#define APM_SP_VI_CH_MAP_CFG_PSIZE(ch) ALIGN( \
> +				sizeof(struct apm_module_sp_vi_channel_map_cfg) + \
> +				(ch) * sizeof(uint32_t), 8)
> +
>  static void *__audioreach_alloc_pkt(int payload_size, uint32_t opcode, uint32_t token,
>  				    uint32_t src_port, uint32_t dest_port, bool has_cmd_hdr)
>  {
> @@ -1258,6 +1283,89 @@ static int audioreach_speaker_protection(struct q6apm_graph *graph,
>  					 operation_mode);
>  }
>  
> +static int audioreach_speaker_protection_vi(struct q6apm_graph *graph,
> +					    struct audioreach_module *module,
> +					    struct audioreach_module_config *mcfg)
> +{
> +	u32 num_channels = mcfg->num_channels;
> +	struct apm_module_sp_vi_op_mode_cfg *op_cfg;
> +	struct apm_module_sp_vi_channel_map_cfg *cm_cfg;
> +	struct apm_module_sp_vi_ex_mode_cfg *ex_cfg;
> +	int op_sz, cm_sz, ex_sz;
> +	struct apm_module_param_data *param_data;
> +	int rc, i, payload_size;
> +	struct gpr_pkt *pkt;
> +	void *p;
> +
> +	if (num_channels > 2) {
> +		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
> +		return -EINVAL;
> +	}
> +
> +	op_sz = APM_SP_VI_OP_MODE_CFG_PSIZE(num_channels);
> +	/* Channel mapping for Isense and Vsense, thus twice number of speakers. */
> +	cm_sz = APM_SP_VI_CH_MAP_CFG_PSIZE(num_channels * 2);
> +	ex_sz = APM_SP_VI_EX_MODE_CFG_PSIZE;
> +
> +	payload_size = op_sz + cm_sz + ex_sz;
> +
> +	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
> +	if (IS_ERR(pkt))
> +		return PTR_ERR(pkt);
> +
> +	p = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	op_cfg = p;
> +	param_data = &op_cfg->param_data;
> +	param_data->module_instance_id = module->instance_id;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_SP_VI_OP_MODE_CFG;
> +	param_data->param_size = op_sz - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	op_cfg->cfg.num_channels = num_channels;
> +	op_cfg->cfg.operation_mode = PARAM_ID_SP_VI_OP_MODE_NORMAL;
> +	op_cfg->cfg.quick_calibration = 1;

This field is only valid in calibration mode, we can remove it.

Other than that, it LGTM

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini


