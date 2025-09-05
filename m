Return-Path: <linux-kernel+bounces-802658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C1B4553F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0C6166CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BE3126B6;
	Fri,  5 Sep 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilQru3P+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D430CD8D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069211; cv=none; b=BoMBqmQ/F9urpKy5O81TpKFxJ6ahYm631DwoZkn91fFKZdQoWW+vPkZmU5p7kQ2R+QrYWRsupGqP1Z9CsPBO/oL0i1kxGVbmhYHBxrOhCflY88MclVpNur26dV7RcTipGCMhvTFXLCgJaMiz3pMJgL0/A47CuSmHGzMV0DKx+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069211; c=relaxed/simple;
	bh=c69T0jgOkThTayMwwmAnD70UzymF4qdce1OqRpAydq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNecmAUVP735XH2rA4EUSeV4dSNnFEMnb/az5nDkjvkSrGJhME36Xto5GdAjY0YaQE0A0SDGScv0Z3PWwfy0fTx5iZjNlZN56NMUcMfMByN0T1EzhKWVeR8Ar6U1xS4NHGx5nNR6s5ZvYwgXrD2Z0hBmWKmPNjF0T0UMw2lPs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilQru3P+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854p88C018575
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBBHXfngENXI8mT61mc0Kv/t7nDhmuKG6UQNq3EaiCM=; b=ilQru3P+OYSzvG62
	9iH6ynLngfOSL60vYuKJ/LGgeVZvIoJ7QVUwQ6RUQnNBsxOiFJBlgMpp/M0gie2P
	TKVd665l3KcU4B6PRc+/fvs6e4Jkgyfm3rg8dh7mz2QcGr3aoGp5ck7mtaI9P768
	Mut43Zkyr7tLDvxqjdSsGMFN+Lfm4BFwDKJYKESs+Cr9CT8Dq20UxSgiGaItZuOj
	p4UOmz0QTRy4f6UHqXofmyUXo9KMrD0xK3HJomAlX6eFaSGB1+L7f0T7H43agNhS
	28PNKUR9vUC2iVVWydQ2iN+Titn4VSJbta+32o8ixnR5MhkXskrIvXSU2k07Ybbo
	VXcGAQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutqrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:46:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f112dafeso4371651cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069207; x=1757674007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBBHXfngENXI8mT61mc0Kv/t7nDhmuKG6UQNq3EaiCM=;
        b=wvs2cigS+gpkq0U7vrorf1GBhwJ0Rvzd/S5ui10NGrJzHaWiO+SumcQ5nEs1yTKVs6
         S8A/mw8Jblp4SgbI05PnxraNUjd1ia43/ZnKsWuA+4Unnrh866JBE0oVLjRsG7ZoySuE
         3ICGxN6YP9Nx2MpCGtapwRgKPlFVlCsJSaiVkz8Uq0VK14OW1upnZsZlFdToVaG0fOVI
         smKpIP0WhA0rRwaSt/6NJb60E6nnNthaqfSNEODIUACLQKllREAclUGJ0hyant6/6foy
         ZVHl35cYKc0huZlcgQKrSKTBbHUEG6A/lfZvHy7/RlJI4hUF0Q384IcEeUr6Lo8W2Dx2
         I4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKuFg8DY6/2mkFJJGfS3Bn8dLUzHmifyUk7vrVfWsgu2y4riWiDyV9ab/4YbmSjvajHqhX/yRom8oZQz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaaw5xP+3n3S4H3OEghXRhUx4cRkcNIq+Ft25EOLMYiN0SNod
	yAeSNfdYa32jZ0M7WIat/8jrXHjSCCu2vFmC1R8KGwDRizFjR7/dRRCU9H1uqM6tSlcZ9sjYu3R
	lW57+Wn3wh2SZ4Pn+wZHVyb91rE8oDfTucQoMEgqQ5YzHyIvwawwumSsbbJLu4CEY1Tk=
X-Gm-Gg: ASbGnct7VGHPpJOd/Tl4pz/HYV1V5Kx8WgTP/oGRr/I3BdB72hUoN+i9NvtsCzfrsY0
	IifaDlC+fsWkGHbDBUauwI+6bvp5+7SzsNOYWVBdFufNlEsAJD4QFWHQ8r+retn/G4Uky2dlL1W
	cU3EFxDPuA8eDr96VKUwNJu+f8t6qXrPQwOQOBi/TUOxvxRkA/ptdpdikH8+1NhkGWeGA5UdsT/
	OHDYerSggmSUdmu7B7Rlo0zu7Kp0SXKI7akRqbt9Ep2PU3mVpgTbdKdgwOIqohAugvn/++bVZU+
	JUDgLTF5HYQqbNPxm83Ff45e8nPk0Ah+V6iL2kJsZhyl0Zf2RNJqpcVavxcl7SysnOI=
X-Received: by 2002:a05:622a:1984:b0:4b4:95f9:ada3 with SMTP id d75a77b69052e-4b49608f3a5mr86730791cf.60.1757069207440;
        Fri, 05 Sep 2025 03:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQqj6dB7alP5gAR2caFRsDZXzAkiYd+2/yrt4ytCgTJNhHVzYvVg/u/9CJtN/0NcPaN0ITOg==
X-Received: by 2002:a05:622a:1984:b0:4b4:95f9:ada3 with SMTP id d75a77b69052e-4b49608f3a5mr86730591cf.60.1757069206953;
        Fri, 05 Sep 2025 03:46:46 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm359312055e9.5.2025.09.05.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:46:46 -0700 (PDT)
Message-ID: <a9eae2e3-0e75-4ffb-9de1-3b8a9bce86a6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 11:46:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: qcom: audioreach: Fix lpaif_type
 configuration for the I2S interface
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905104020.2463473-2-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250905104020.2463473-2-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qPWpeb1d-96lCiho3Jb9IABj0F3e2ex3
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68babf98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mFzK8rC3iHN2mybPfuwA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX7CokbMEwmpYy
 JKtK+sbEMgZ6xL3KJxDH86xCPUy/ZFxrzePz8Ank1Ti3cNtVZO2w52iTrztMTB4N4C0N1hgqkoZ
 3xRfsX4uRD91UwCgsSsJx0eSsH4MveqFnbibJfP85//O1DW02ZlxIZQpACEFKXTPEitQPnyufOo
 XkVkcY54CeoxFwHh2uWp61LKUIFiExQYYINQ4sW+4Syi+pHVov2bkIMzoZD3Ep2ZKxwF0H//KIO
 veJWIqVlHpMlfTJtoRbwS7z8vJkCA/NZSlyJX8z4spmr6hISEapgbWTgf7Ec22S3tOmJH7u2QpR
 0SIUQfbNlQM2f+K4djs+E23vfA3bVxUUhYvAVChm1s+EUHgaQAbGByoa/NnAta0nM7118AV7Y6u
 PhGNadHt
X-Proofpoint-ORIG-GUID: qPWpeb1d-96lCiho3Jb9IABj0F3e2ex3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On 9/5/25 11:40 AM, Mohammad Rafi Shaik wrote:
> Fix missing lpaif_type configuration for the I2S interface.
> The proper lpaif interface type required to allow DSP to vote
> appropriate clock setting for I2S interface.
> 
> Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")

CC stable tag is missing.

--srini
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index bbfd51db8797..be21d5f6af8a 100644
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


