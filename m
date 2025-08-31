Return-Path: <linux-kernel+bounces-793269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30852B3D16A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82883B3512
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212A2192EE;
	Sun, 31 Aug 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRyITQd8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B61A9FBC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756629427; cv=none; b=uKIqxBPVMM6YjQPpuzqx+rSl5bcwZPlWgqH6G2iw9ZcOibx7UoXXU4SIJIUGrE+0WEnYBlZbr8CfBNckcyinPFqLWAx5IhQMKLW+ehZNN4+p6qVZ5j7/7Oekp7MUJ7H1rALX8iTeIvknbu8PMeNm5V8ytx1sqpsGKVdrNRWSGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756629427; c=relaxed/simple;
	bh=KTcx5AK/U1aLX2t7lvHDaX6OWhGHUj3CO9nJLkF7ahc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqq0Z3FNfPWuC/X5rjNZF8Qd1nw/iOF7tepJHPyB4hKhv/ZUcu2LoRqwoStZ/LBV3xVUZ8FfshZYt7h+6IAb6Og4fMTlxmPH/lFZhLGmPsTYebGq8D3XF0VV0/j82k9THX0SbS7aQQTfPWu8glHwdnVfkAZZJ84cVfOwBwWojIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRyITQd8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V7HX3a026682
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xvUaMplkMJogbDO2u3ua3bX/R2mAiQNL2SvnRzJqJK4=; b=pRyITQd8eZFFZXxP
	vJDX//nE2JfjK13IJy1+MyOvvVVtqbcja5mVIA2IgSyfDKpEw9mrajXMmUw69GRP
	SCahhquzp3wATwCi1jsGiAn58T9xn+P/7h7xPuyAXhDtnpkWEtF0H4aPwsrFQN42
	QlrIvkWy55hs18i0RFr9ZfR8B2QLb9CUhCjXnBoT+GsYrHcHKo2OcSvq/l1FIe8a
	lvoux2jA0NzVMl8bCZrEpF2NdecPyTpic+Abv484+/FtaJupXsgWB/YeLtMDx+zJ
	7mk/7613Fuhw0VoTXFbNR6QCnT2y6wimd7lWlGWQoJloIlTsX0RJ7ry2424skUu8
	Gn3n0A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp1yxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:37:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dfd87a763so32710876d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756629423; x=1757234223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvUaMplkMJogbDO2u3ua3bX/R2mAiQNL2SvnRzJqJK4=;
        b=uytiOfNaOOWngnY2sDJhnKE4QvUfoDwa35I1Tlgku+povKC9gGKRkoH5RyoqauXNHp
         Dwc16k93CSuwrbtoPwE9hhsrQmhHuvpOrpR+WsKxGZFuv1Fy/QitQdVCWXhoQlgKKkwk
         Zyk1jgr5HC9G+m0cUAwLuQjdhSEH2GfPwMUNzEYWKsN4cPkLwVeWjCrRrAxfD5L2Z0BD
         4YTGIrsnp7zkGs+38YJmo9DAk+FSierMjpNnaiNxXN20koFcocQEZ5q8D9LDgm8iQDN9
         zX3gTgYWdmowHMtVnRqPjvDdqinb3+4pmVHbd+eSsB4cWwG2tXKNifv+eGwsPzqjZ4md
         hgdg==
X-Forwarded-Encrypted: i=1; AJvYcCVhR2/bBP6hqG+sepDmA1DCHMSR+YjpzwEfh8y3PCLjDF8UgTJiDwkvBSKGxVxp9ygYjO5nEbHuZLIqvLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxcEgQdXvujHFxIfrdlKmNgUFk2ezgPAXT8qgcnV/jYX9YiYA
	lA6CspicQkt6zKDhyHfwF5eh169N6Mx2SC2fjorbeOMWRwdZjNv7SL4GHnsz5qaVYKZhaBiaLrQ
	CBw7K1YOo+rcQGLOXBMwmn3ch90Pze8uXaAmzEGTQOUwg84WA38VJ1irAXNNnv2xf7KM=
X-Gm-Gg: ASbGncsiF9lEsd29VnnDNYMA651dOJkvqPcSm0oIRK+PC6CBSSrKWANlTrk+hDwXE0T
	FUuoHuUsQbGm1H1ZE/7US6DJVCwJKpxFMAPuIznkNpFgVgMncz+ZD2PBENlt8mkkSqAu4vYiChu
	EmISugP7zFKeQaSp7yKx5iymNmYOEzM4Fccp/dkhzLK4ZOn+lP/jP+euJeopjvbj6ttSVQZLblZ
	95Zm39iwB936eIzIi9Uf8h/0ZcWmYxTmoCxTms272OramdK+OR8baKJK8EXW6a5Bac5koqBIZAh
	ekVG0pO37I+cYJuc7nzeMb6PiW+VQaeMJt8uxfSnKiMoa6iHtO7zRkzysRTXQfcJXmA=
X-Received: by 2002:ad4:5948:0:b0:70d:a379:b954 with SMTP id 6a1803df08f44-70fac6f8bd0mr40632696d6.9.1756629423378;
        Sun, 31 Aug 2025 01:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFysRsDtlezgcpowiIOwxzIZWWR53SUtf3htCaraOnRVnxUG9PshDQSDY8Wu2/z3X0OOzKOSg==
X-Received: by 2002:ad4:5948:0:b0:70d:a379:b954 with SMTP id 6a1803df08f44-70fac6f8bd0mr40632576d6.9.1756629422878;
        Sun, 31 Aug 2025 01:37:02 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm10162308f8f.25.2025.08.31.01.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 01:37:02 -0700 (PDT)
Message-ID: <6ca759f1-27ef-4cf4-833c-ee2f6a9b2d87@oss.qualcomm.com>
Date: Sun, 31 Aug 2025 09:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: qcom: audioreach: Fix default WS source
 assignment for I2S interface
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250822171440.2040324-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250822171440.2040324-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jxuELOpIpJhN-XsPHPIgAbyIsuS2MEQy
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b409b0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BoCV0UJ9-xh1oqjoEqQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: jxuELOpIpJhN-XsPHPIgAbyIsuS2MEQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX9VnyeuHOvxVg
 Rsi8KpBAmRsD076HDAJTGMkoAjOgQRS1ad7Um/VGK0YWFC3G4SamrdJTAT94Cxw99eGnSt/rehX
 kVVCs7T2JMeoItxO/1rwRm4wPGUh6yZHpR+3KLwheq8Mye8HK+MrLmInRSr8bftMVAFFXV/PAzy
 gnF4+xqBf9weh8mFA7VzqmeC+6TdGPq9m/KWPMm9lkbvMVROQ86UhYfaZYU64liUwF82fTKG+YA
 UEPmGlRTBKCL3L56uO8x6WphQBQA96Q+GraYpXwsERFoKJjr8r/sqrILOlcC70GbJxpDRI7CGMr
 vku1Nm87Y5KBc7Aw4DFG+KhaSmUBrCvYWdXOhvc2Cj9U/3ueulDLnMXVurX3qi4kkcC//EUX388
 JqOLCuE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-31_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001



On 8/22/25 6:14 PM, Mohammad Rafi Shaik wrote:
> Resolve an issue where the I2S Word Select (WS) source could remain unset,
> leading to misconfiguration of the I2S interface. A default WS source is
> assigned when not explicitly configured by the AudioReach module.
> 
> For HS MI2S interface, the DSP need proper WS settings to set
> appropriate endpoint configuration.
> 
Sorry this is not the right way to do this, machine driver should select
the correct configuration via snd_soc_dai_set_fmt.

who supplies the frame clock is decided by that configuration, we should
not be assuming any default as this is totally board depended.

--srini

> Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/qdsp6/audioreach.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 6d7b1a4b0b2a..d4397f75e310 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -999,6 +999,12 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
>  	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
>  	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
>  
> +	/* Set default WS source if not already configured */
> +	if (!module->ws_src)
> +		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;
> +	else
> +		intf_cfg->cfg.ws_src = module->ws_src;
> +
>  	switch (cfg->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>  	case SND_SOC_DAIFMT_BP_FP:
>  		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;


