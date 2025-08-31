Return-Path: <linux-kernel+bounces-793270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4EB3D16C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22ABD188BD17
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43EB245033;
	Sun, 31 Aug 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XlRGZkZz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CCFC0A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629550; cv=none; b=cUSdkzrs9yAnbxuwMIvurWpeFOdOGsSYIK4On345QwYhCBsDio7oyOXMFZf0XK7LNsZHG+jDsLaFdesgEmBz76oUx5UR/1BCUnF4r2SFCjSavUu3IQrN7s6POYx/+yXlX/IVd1zAICKCvzJf0CZ489bOvBQQprbGX+Y62ah3it8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629550; c=relaxed/simple;
	bh=/A+9TjPsnGaaJzFSwqhfMsQkNU5gbU9e8IGwIjA9oLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2DhzWBXdd6hMZEaLIiL0BLyc/0I4sp+rHoy1vnkS1HxB3RWGdvXw4/9c5bvOPx22RmiD5K5Y85OGjixrJfTa0RrO8plX1HkxHDWDQaf9vvv8X/eUe789kqCDg+7BqdUpep45l/0QMjcbIkWkvxm53ik5USDOVsIibTksWFjcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XlRGZkZz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V7UmOj022502
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BRXQM5Xhx9VNwUQ6ACMX0+vtiPfY733mOi6VzYAWoQQ=; b=XlRGZkZz5u+pAihs
	0xyj05uxTBenxYmSvN41H5BBt/3c66Elz8TU5Ix0JBAgGtRruh6ZKIpdQvcOV/fP
	Uhp38GCz5NRS+5NHevT/JK7TEAH0n2TH9bnFWo44sX7S5vo9kTj031fZhlol21mb
	3CtNTl6e4qxSI0svFD4y7DGl+uil0R0aFwqChqWlmum8aDipm55VnbW0VtfpdJ0+
	1+do4QZDE9dyXKqzH3YXtd48E/IgQkG2pgG7mvholxaIbjeEg1jNjL4lvYoVOnz7
	AZWW33HxH6D/sKPC9SIItUy2E+pHyx5DmzkbkiiK+qGEd65PD7AiTpcBxh8GU8tZ
	pVuWlQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8hv01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:39:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70deedd1deaso61917266d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756629547; x=1757234347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRXQM5Xhx9VNwUQ6ACMX0+vtiPfY733mOi6VzYAWoQQ=;
        b=NHuwRvB1KCPnuLBaHHXzctI1Uz4Y6W+yt/SZodd8r9BIQ5fSMucU9fhG5fCElF2Efn
         cISCBKzVbdBRTDtNGaThSpp43zdu4VmzsV47Y4uOrdM8ZBAtbpWNcVCOzWnvJOry8VNs
         zSzV0rrKB3iFXazx7nX0fcuXKZqnaD3itgfWgeQ8Ka+QM4gov202R9FbAMzI06TsJ8ND
         UfAAqeIovAQ6hzmQqR9D3ZkXuywJxcfMI9ptOp63EvKByrVoxHaBT3uLk13EqGl50WeU
         ERagPzVYBOdC0KcfR8UXPuD3SReSi9k/4DcceC5eVYXiWiM1zFt6kLiUrxBVp4oogrR6
         MBNw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z9YDEiV1axmkuaUMRENV28bCugcC9eznyt3ZZNhaMNliVwvF2yqPzWR8NLSo3yT8x7SVaMmDmFZHKo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycwRUaLKwzaO2kBqD6+k24zUG2LVdFIatcY95uEp+9VuEqlIEj
	VHZMjYFunEXPculGTOIOYIXhn1WzJjlxqW7nt0GUuXcZEV17sLXVuc71seDVa2g+aepNUIgIlqx
	AaQ1Ikj9TXum5cVLlOYIVQDTAW1m3iNLre3XNwV6KPfitAbesFk44hWKAGHA/TRInCZw=
X-Gm-Gg: ASbGncsObHHs9PmgUXsQynHXYLeCTx3TbVXJfjkviA/2x/EDofcOXYX19Rp6c/4bGrd
	i/eXHxQn7zHZNK2irmS9cGjXVE9mAg22Mj2QFQsa7kTuwuVq61fw5o1rkgMcRVRTdjzas4QUatv
	KbJqG5FnXIbdMh/So15Nj/fSbx6H/YrCGPN5vspfGlOp++OiMuFlXGIInLNb5F/Uqx0ZQGrzfVN
	yWEFcXdxWpX7m6QPBAQBoPTMCaKME1tFwfPiIJJ2CsR7uOQng+/1bKhOJoAoraWVu6ruNnFxBmJ
	fOXzbefBp/29yldHBixBjhaJG1rPYWgn/kMRQwV34RV71n+g0OO+aqLtoe8W8PVXpYE=
X-Received: by 2002:a05:6214:5193:b0:70d:e501:1f9b with SMTP id 6a1803df08f44-70fac74ade3mr33464456d6.23.1756629546640;
        Sun, 31 Aug 2025 01:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzQ3HC5YME0UyGE1nyvjX0lufS8HE9JEN+POL+K35U2LzfmYAtT8yaQCjtNiPDfZCBh4nHw==
X-Received: by 2002:a05:6214:5193:b0:70d:e501:1f9b with SMTP id 6a1803df08f44-70fac74ade3mr33464266d6.23.1756629546197;
        Sun, 31 Aug 2025 01:39:06 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b6ee66bddsm189016035e9.0.2025.08.31.01.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 01:39:05 -0700 (PDT)
Message-ID: <f5cc1395-a3b7-4d5b-b8b0-d97de718e691@oss.qualcomm.com>
Date: Sun, 31 Aug 2025 09:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: qcom: audioreach: Fix lpaif_type
 configuration for the I2S interface
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250822171440.2040324-2-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250822171440.2040324-2-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Rjp5aquZI6JFqSvKzWhGOLovyWtW6HR0
X-Proofpoint-GUID: Rjp5aquZI6JFqSvKzWhGOLovyWtW6HR0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX37508KqwxUJf
 w0S+IfubaEPO4qBgW0yCJPfBnEVqj0x2eO5qU1vcJEGNSwN6j4Q36qqeuYFizsKgTQFpgw7673v
 aLFcLNSF5h5tSVQYXBU/s+RyoQmd0Gj99zDQJKxsMd9KVoyrwjBSevcrAA9X1itMnIT8RoVPeYV
 E69+iSW15M7cc9BFTTgaceBKxJEv9h7AetabIBKiAeI10GBCLjrhsHbrdj1wDCrmYm/Vq32RyEx
 VnCUdOACNTEgUNUTStI4J02JKHEICwtXFpJ1GAp5UaXlGd5RiVOmsN7fLy4cur+qOuS6miKMBxU
 kX0JpeP5KNVF6BTsFCCK7uEh1T0hpbWUFImwby+ddJ0Q7MUFjoVEkoW7AJ0sOpgMcIKju1CKW4Y
 yoi4CWVN
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b40a2b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KWf2NDoUiaxIZHtpWeoA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-31_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020



On 8/22/25 6:14 PM, Mohammad Rafi Shaik wrote:
> Fix missing lpaif_type configuration for the I2S interface.
> The proper lpaif interface type required to allow DSP to vote
> appropriate clock setting for I2S interface.
> 
> Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Missing CC Stable.

> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>


@Neil, this might help on the I2S Playback issue that you have been
hitting on SM8650.

--srini
>  sound/soc/qcom/qdsp6/audioreach.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index f4c53e84b4dc..6d7b1a4b0b2a 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
>  	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
>  	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
>  
> +	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
>  	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
>  	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
>  


