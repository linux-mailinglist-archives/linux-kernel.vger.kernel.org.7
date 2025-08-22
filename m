Return-Path: <linux-kernel+bounces-781726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178CB315F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE500AC7B22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7502F90CC;
	Fri, 22 Aug 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fv0G3qhu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FF258EC2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860123; cv=none; b=FNeyKHe3uzTDgQchEW7ROVYcMhpr4ZByFFLNxT0KrqLF+OY7kE2zl1QA+oY+w8v0GH6Ljim/LlqWe4JlaqxHhA/vBv+BjiDkUeDSgG6XuuVBKjqvZ4XNFrVQW6MZKUSKIjplaBLNC6dz0QxI5NOctfHFdUdh02VaDslfurVEFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860123; c=relaxed/simple;
	bh=XbuOpXqYiunKbSbSNp+OTWaA/M6GReq0/U3LNHNvyJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KjbPee0bNjLXA29eDhO1q9gOH0wjXA/uwm3SeNPOX96aaQ1TbfgF3ph1bwYtYKV2oIhS11sgqIg457wT4G++l9CbUBSqbtNJAnel3KvUT7l5lZLbuSGQXEi/j30mcRi08pyvSWdBG46V7Mz82RP+MqzNoB59Q2zP5GPF7B+LjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fv0G3qhu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UJJT005615
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DuF30ydN2ZQeTy/GA6e65bX7Ud15XFT+k/NW2dRJT08=; b=fv0G3qhuMi+JwZjZ
	fDd/WJHvc+3p7aAa1iuCx1JfoEqbnvusj/teXgfsAahoEdrT6TEX5f0Mw0KMFWZy
	uv4EEt5ZMrsdXCSi0A+SvOBtx9Fyevvt4aDKm2arJ+/r4pgzYSEEaKPWOxnP+6si
	DPuWrFcGSSf3pY5AXy44MfZiSruyPT2TKHfA8lEbGiTbXwGlYg2p45/QDMkmIvuJ
	PeeXhv3ywBWxdQY5HTkamYtgrowWRWE63xMe1AkAl8DseHkGj+qG2Du82pWxked7
	XajWyqvYQAUO8JGWc78y0oa4w1hn2Vir2FvMo0t13f/dLVnAvjoVWfZ7lqS10NU9
	xbTQtQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drumg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:55:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d903d04dbso30545246d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860117; x=1756464917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuF30ydN2ZQeTy/GA6e65bX7Ud15XFT+k/NW2dRJT08=;
        b=O7sgw9jT0XmQDA9xGBJezDQovlO1oEujz9pbbwAXcKwpTdj07vCVXkC+clg4gVpsxe
         UPeM0Xaa5tDk0iDsM3N/dlNQpyAo+vFUigSnyAIj+L3oJCVfkKI9Xhf6MtocJ+wwvFoL
         zeOu1oYCswZLiVMtwmmfN+AE/BqeYXA1koYqmQEg5aPygV878MNXg4//CZoXQvGAJ84R
         uISc7kUnrlE2iDM0JZJMnR3xIlzzmH9IBAlZe6v/OhG75rtf/0iia1hAqL6OnQECB1hF
         QFofT4ittsjaqQWjHqnohGZ0jh8iCjheDrA/YsTgj6Vlsz/Oxn4ZlNdm/xj8ox2OYICI
         Zllw==
X-Forwarded-Encrypted: i=1; AJvYcCU4i6HGan5vvqODB4+BfC10AfUfKCpXPq+uGsipx9eabbxjDeg0IJx1JhKfWg24qlZuJcSY3zCIv87TUU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfi1EqFRVM7trtis+vA8t763P3mBTbflieQ5+tr3a9sE3wya9u
	b72H1Ek4usv8OUkZvQ/vjYYVRsUrvNQ25/9tqhUraxbaAxIw/IDgGDyREyoHVTEN6FKYZmsUpcp
	K6d3uK0iqMMuwEVqTzPgi1qdMa1HYhtJ49LLnSYcuAIPNfywodtG9Vr3oDLSV7YC5XBo=
X-Gm-Gg: ASbGnctCGcI7QJKGNTyqLsbqQKfOz9uRFVdirAMi4DBGkWh+17MM8eA4dtiZ5a3C98L
	wpfgjHPij/6JAsRXLnmvb8W1QMj21YcgRA2585hf+Tkgn0xT7RHAmDMySWOKt4qnIt2/AW6L7KX
	9JEKnn21TfbabwNulMfwCf2Da++w+fM7aWS2bLxlcP6r2G5BlPqtvTNM5mXBAHD9BI9x+vh30HQ
	jfCnXWrYp3XCQDbONztIo/A1bhWYcwvpaICWjVBQPcmouc/VdZT3rfRcZB2HnuyFDVw9KbsSuhf
	z7Fp27zqq6LGdrKJ/6nP+TNJYNQAjx2N6UCaJwL5iFiT8MJ6iFVd1k0Uyy9WvrfWNJc=
X-Received: by 2002:a05:6214:1c86:b0:70d:6de2:50ba with SMTP id 6a1803df08f44-70d9733f326mr29342176d6.55.1755860116922;
        Fri, 22 Aug 2025 03:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5yaFihF5akudpDZ3q6UIvfl9qSPo9Ne7xAKkzui1FD6I2i7DxTmdLR4xBlr/nHdiY7Lf+kA==
X-Received: by 2002:a05:6214:1c86:b0:70d:6de2:50ba with SMTP id 6a1803df08f44-70d9733f326mr29341916d6.55.1755860116255;
        Fri, 22 Aug 2025 03:55:16 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b50e1852asm32076825e9.25.2025.08.22.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:55:15 -0700 (PDT)
Message-ID: <6a4a601b-937e-441f-80a7-3f733fc86445@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 11:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: qcom: audioreach: Add support for VI Sense
 module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
 <20250821141625.131990-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250821141625.131990-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7475oXR+3Pxd
 5lyGLgRl+4UJIsGWJ15wE+jA2WC5/xqg5M3gZKR8ki7Z4AgV96S6swRJMwJNsz850sGBzUof9i2
 a5KDxNCHkMu+cmPYpbHwIzshLtrn5BF13mqYSnMq21PuRKckbhp4+uzrJxRsVA7LSm8acntXAYm
 es9DJUvekbG/33nFTHuce/o2Su51HmG5lgRFXf0nwtWIMmTTFrQNycvaoSINrqr2WFqlPZh8BrW
 EelR5Bfuy//Iwi8RG5ibBa/mwGn7fLw3Siung5Bd67itinnFz9P5fLPnA9nEVz2gz+YFHZrsFFY
 d0GSNDgBi9VwNhmRM9MKpXFc90emHL0YycwoXC+28TevdHOZJMqACDRC63YBHKhMXvFQOVL2vw6
 lohLZ0v9K//nWSewU/cmt8e9O+clAw==
X-Proofpoint-ORIG-GUID: nqRlafMdO-QhG9aKq4LEiVRt3UPkfBid
X-Proofpoint-GUID: nqRlafMdO-QhG9aKq4LEiVRt3UPkfBid
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a84c98 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=zgq_qGFzbcYR-VCCdk8A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/21/25 3:16 PM, Krzysztof Kozlowski wrote:
> VI Sense module in ADSP is responsible for feedback loop for measuring
> current and voltage of amplifiers, necessary for proper calibration of
> Speaker Protection algorightms.  Implement parsing
> MODULE_ID_SPEAKER_PROTECTION_VI from Audioreach topology and sending it
> as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 112 ++++++++++++++++++++++++++++++
>  sound/soc/qcom/qdsp6/audioreach.h |  27 +++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index b7f1fc835dc2..f2b7f18e29ae 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -202,6 +202,31 @@ struct apm_display_port_module_intf_cfg {
>  } __packed;
>  }
>  
> +static int audioreach_speaker_protection_vi(struct q6apm_graph *graph,
> +					    struct audioreach_module *module,
> +					    struct audioreach_module_config *mcfg)
> +{
> +	uint32_t num_channels = mcfg->num_channels;
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
> +	op_cfg->cfg.operation_mode = PARAM_ID_SP_VI_OP_MODE_CALIBRATION;
> +	op_cfg->cfg.quick_calibration = 1;
> +	/*
> +	 * op_cfg->cfg.r0_t0_selection should be set only for normal mode, keep
> +	 * as 0 for calibration

How do we move from calibration to a normal mode?

--srini
> +	 */
> +	p += op_sz;
> +
> +	cm_cfg = p;
> +	param_data = &cm_cfg->param_data;
> +	param_data->module_instance_id = module->instance_id;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_SP_VI_CHANNEL_MAP_CFG;
> +	param_data->param_size = cm_sz - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	cm_cfg->cfg.num_channels = num_channels * 2;
> +	for (i = 0; i < num_channels; i++) {
> +		/*
> +		 * Map speakers into Vsense and then Isense of each channel.
> +		 * E.g. for PCM_CHANNEL_FL and PCM_CHANNEL_FR to:
> +		 * [ 1, 2, 3, 4]
> +		 */
> +		cm_cfg->cfg.channel_mapping[2 * i] = (mcfg->channel_map[i] - 1) * 2 + 1;
> +		cm_cfg->cfg.channel_mapping[2 * i + 1] = (mcfg->channel_map[i] - 1) * 2 + 2;
> +	}
> +
> +	p += cm_sz;
> +
> +	ex_cfg = p;
> +	param_data = &ex_cfg->param_data;
> +	param_data->module_instance_id = module->instance_id;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_SP_VI_EX_MODE_CFG;
> +	param_data->param_size = ex_sz - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	ex_cfg->cfg.factory_mode = 0;
> +
> +	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
> +
> +	kfree(pkt);
> +
> +	return rc;
> +}

