Return-Path: <linux-kernel+bounces-842050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A93BB8D96
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE2619C08DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AA273D73;
	Sat,  4 Oct 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0MNObXa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BE2741DA
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583429; cv=none; b=DMSyBcJUGZeSicBh+jq9Vdq3AQZzQPpuWIHYtV8r5JcSUSg66yo5idfclKEtJpYgCJX40724DYiYWhehdE/5AJe8jU63OxBTFEnpuMFf8X1tjvR201jmyPOqHiQwsP1So6EYCJXix1hZ0TjaRRsM+Uq/LuYmYgN7u4X1sWheDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583429; c=relaxed/simple;
	bh=13l3iqgM2i0JSA8FqqJWbwOIhNmRTj/GWalU3yK6I/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBGrRyokPTQSM6M6KgOTzSz/gHkv3f2W9pgu52vtGuu71JqUPu+8sBkFbleOdgGPSxuJ7GczGXpT1Z7KJI//IIDEGlH4nYmwkVFaD+x+p0VcfYbYreRP5EVs7siuIQ6hFDvz8B3C4CR/x8xE1CeJ7SbQp/4xiMENIFm8zJZZvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0MNObXa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 594CRmJC020896
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 13:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dr11+UpN4Bzrb6m/cuz9Q9mnl/2nnjWOhav/TKq7d8=; b=Z0MNObXa8bqDftRK
	vjF1/dxayY+gSE/aaK1gjX8aZ/x1nXi8+WLxlJBvyy3WtD0ubDZXKyrNnZ2TyDIW
	/BesyxbJ2//C0Z1miNGStrU2RvoZ3ekUvy8pm7PKbndXJtIgWcMrtQ8GqSTawD41
	yCR0zAIbnuNP5mbwHpky8A1wima7jmKlkqfu6P3lfaZHYqSIjca60i+fQgGG7ptT
	tMolvxMO8xm4XNp71HOeyoug+lk5kmQbQIv+onWUCgdB//OfAk4WNIihMfQVXAPV
	YQRI2W/hnai6ydlIwFsAF8rjZgtoRwRDajx5gKAZv05bc5ZAQMYsXlFegjhte62H
	1rwdfw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9drvdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:10:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e484dccaafso81082451cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759583425; x=1760188225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dr11+UpN4Bzrb6m/cuz9Q9mnl/2nnjWOhav/TKq7d8=;
        b=biOLRnDtHXTMEoGf9nZrWwH9e+i5GCm3BIISLjhOVmxxnay6j1iftjG3D1XPL9t8z9
         +aDoe0TFV4qvZV2aDSyiMQw1ZCMMb5AV72vKiYcwaUgUz4VwW/DDG+YXajSOzjntK34I
         KTX2yTIL0668nVXKs5RDwdFCN7RPYyBzEGzhb+kdGVEgBioG1qag+h3X9HiRyDmHpWnV
         tL6g4dmkuLnze3g2N3BKGigA8Gvebtfju443p3VuuOPOkvIDgjV5XGhVBBzJhtuE56i2
         eWntm2omrCT3vGG/10PTAVbOJWgcc1SRTHaGZ4llAzWdQOBF1OM0zBZWjBl7y/6n4d1q
         09aA==
X-Forwarded-Encrypted: i=1; AJvYcCUVp1XAynCZjNbImCVrmQYnv5JRjlEyFJTr2ANS1pCVHWD8WRjKioJetnD0KtlKV8fOFP+RnRSuSscELTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXeInf7xS3O43JaTCiNuZP7rEiwX2ehf+AMFxW9ceZv0xbMJN
	aQu30iIo0X8MsmWFlsjD5Cugpl8ltuGU/1gmUH3cKc+gTawAnjYyGCZuxIycYOEgi7gBcwufUkv
	ljM6Tv3fuBfPKTUfp6YVdxuU0a2W5Sq0QhmhsZiekZUsrJUhU5/vmhVvMSLg8lHf9YevAe7UCAE
	8jbA==
X-Gm-Gg: ASbGncuD7OIuTidbDttsX/J902MPbyGDxB16f68sNjDF0/K3h6+jyuUritklC1ij/vl
	64HfUgE8Nn/SFdRJai/5aSjeXF0wK9Bz3rVijoMDR/lgNrUzyUWKJEd1tH8K6OKzB+OxprhwS/e
	cjJvhr9UhYQQ+USHswd7htEDzJ/dHcDUBExifvtQa4JgT6f5+rMgLuajh+yWNBthGd+XHurd3Z+
	gmrX1EYOspaCf97y2b15uSFoy423lfQonpJJhxDexBY7G1zOaQOs39qqjoPpyVc/MKpiwFDHlyl
	rNJXsWoinlvt3yYmcstI0zdaf15TMqIaYFoL88hDyLcCLdXH70rxUmNslEUiGLXRTL5x+azvuxx
	ZN1VDBLuJ4mk+v9XGdTFEhw==
X-Received: by 2002:a05:622a:138c:b0:4de:658d:fab7 with SMTP id d75a77b69052e-4e563b68677mr143820231cf.37.1759583424844;
        Sat, 04 Oct 2025 06:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsG18T8Ps/jyJuwVAiF97qeEmDzCEhgJ18K2Eq/KgxXw/Cry0tjAb6l2MOXppRQfikUQzj3g==
X-Received: by 2002:a05:622a:138c:b0:4de:658d:fab7 with SMTP id d75a77b69052e-4e563b68677mr143819541cf.37.1759583424061;
        Sat, 04 Oct 2025 06:10:24 -0700 (PDT)
Received: from [172.19.207.82] ([82.206.163.72])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4255d8a6daasm12479961f8f.7.2025.10.04.06.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 06:10:23 -0700 (PDT)
Message-ID: <3b1c094f-5025-4e2c-83fc-e021293a49cc@oss.qualcomm.com>
Date: Sat, 4 Oct 2025 14:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel map
 mixer control
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
References: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e11cc2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Q7GZYsAjZ0JK4+WYEPx1wg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=p-4IODJjHoANa0DJiQYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Vym3Ab3DVrJOqqag5uAtihFQgtFprm71
X-Proofpoint-ORIG-GUID: Vym3Ab3DVrJOqqag5uAtihFQgtFprm71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX6brSFNM6wzYy
 Fcl9D515WmMJH047WGaVNY+EI64fXGtVdmj/DZheTcwvMhEe/nmVlTqtyiYkbpBSlce7eD9g+VT
 v5GxR6IqQpDIR5ozDC3H2EsXy9iaDV5aI9Vh6qsiqSuBlTOsWzU7qS177rWQ9+m2AZYraKmVt2v
 W+1G0t2ZHORPT+rAh3YbEv4VVmsDAcIobGfXBPOMQnn+eutyWU+y0qDgEBb8j4YZ4wiGQsfXkmE
 XV99vJutoCy5WPsj4x7XG8OcIorn9CzIlBaxx3wuPPntyTAn+LooF2iCKss/tHd0Kj+1vPGBJve
 pCnHA5I1YyTO3d1urThL3PWlBi556N1EUqadwIwBbQEY+jtJU3R/fHiVosH850XXrJJw+Q6prvn
 4IcspxKfXKQ+15W5zNvQn8pLUmkvYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 9/2/25 7:23 AM, Mohammad Rafi Shaik wrote:
> Introduce the channel map mixer control support for LPASS macro
> codec Digital Audio Interfaces (DAIs). The channel map mixer controls
> are required by APPS to configure usecase-specific audio routing and
> channel mapping.

Can you please ellobrate more on these usecases? and how is this
supposed to be used may be an example usecase and how it fits in the UCM..

--srini

> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
> Changes in v2:
> - Updated patch with improved commit description..
> - Link to v1: https://lore.kernel.org/linux-sound/20240930053111.3986838-1-quic_mohs@quicinc.com/
> ---
>  sound/soc/codecs/lpass-macro-common.c | 55 +++++++++++++++++++++++++++
>  sound/soc/codecs/lpass-macro-common.h |  2 +
>  sound/soc/codecs/lpass-rx-macro.c     | 12 ++++++
>  sound/soc/codecs/lpass-tx-macro.c     |  9 +++++
>  sound/soc/codecs/lpass-va-macro.c     |  9 +++++
>  sound/soc/codecs/lpass-wsa-macro.c    | 12 ++++++
>  6 files changed, 99 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
> index 6e3b8d0897dd..777af4885245 100644
> --- a/sound/soc/codecs/lpass-macro-common.c
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -8,12 +8,67 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
>  
>  #include "lpass-macro-common.h"
>  
>  static DEFINE_MUTEX(lpass_codec_mutex);
>  static enum lpass_codec_version lpass_codec_version;
>  
> +static int lpass_macro_chmap_ctl_get(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_dai *dai = info->private_data;
> +	u32 *chmap_data = NULL;
> +	u32 rx_ch_cnt = 0;
> +	u32 tx_ch_cnt = 0;
> +	u32 rx_ch, tx_ch;
> +
> +	chmap_data = kzalloc(sizeof(u32) * 2, GFP_KERNEL);
> +	if (!chmap_data)
> +		return -ENOMEM;
> +
> +	snd_soc_dai_get_channel_map(dai, &tx_ch_cnt, &tx_ch, &rx_ch_cnt, &rx_ch);
> +	if (rx_ch_cnt) {
> +		chmap_data[0] = rx_ch_cnt;
> +		chmap_data[1] = rx_ch;
> +	} else if (tx_ch_cnt) {
> +		chmap_data[0] = tx_ch_cnt;
> +		chmap_data[1] = tx_ch;
> +	}
> +	memcpy(ucontrol->value.bytes.data, chmap_data, sizeof(u32) * 2);
> +
> +	kfree(chmap_data);
> +	return 0;
> +}
> +
> +int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
> +			       struct snd_soc_dai *dai, int dir)
> +{
> +	struct snd_pcm_chmap *info;
> +	int ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, dir, NULL,
> +				      2 * sizeof(u32), 0, &info);
> +	if (ret < 0) {
> +		kfree(info);
> +		return ret;
> +	}
> +
> +	/* override handlers */
> +	info->private_data = dai;
> +	info->kctl->get = lpass_macro_chmap_ctl_get;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lpass_macro_add_chmap_ctls);
> +
>  struct lpass_macro *lpass_macro_pds_init(struct device *dev)
>  {
>  	struct lpass_macro *l_pds;
> diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
> index fb4b96cb2b23..23ed6836addf 100644
> --- a/sound/soc/codecs/lpass-macro-common.h
> +++ b/sound/soc/codecs/lpass-macro-common.h
> @@ -40,6 +40,8 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev);
>  void lpass_macro_pds_exit(struct lpass_macro *pds);
>  void lpass_macro_set_codec_version(enum lpass_codec_version version);
>  enum lpass_codec_version lpass_macro_get_codec_version(void);
> +int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
> +			       struct snd_soc_dai *dai, int dir);
>  
>  static inline void lpass_macro_pds_exit_action(void *pds)
>  {
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 238dbdb46c18..db08be2600ea 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -1953,10 +1953,22 @@ static int rx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
>  	return 0;
>  }
>  
> +static int rx_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_soc_dai *dai)
> +{
> +	int dir = SNDRV_PCM_STREAM_PLAYBACK;
> +
> +	if (dai->id == RX_MACRO_AIF_ECHO)
> +		dir = SNDRV_PCM_STREAM_CAPTURE;
> +
> +	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
> +}
> +
>  static const struct snd_soc_dai_ops rx_macro_dai_ops = {
>  	.hw_params = rx_macro_hw_params,
>  	.get_channel_map = rx_macro_get_channel_map,
>  	.mute_stream = rx_macro_digital_mute,
> +	.pcm_new = rx_macro_pcm_new,
>  };
>  
>  static struct snd_soc_dai_driver rx_macro_dai[] = {
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 1da34cb3505f..934b814b7a01 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -1210,10 +1210,19 @@ static int tx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
>  	return 0;
>  }
>  
> +static int tx_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_soc_dai *dai)
> +{
> +	int dir = SNDRV_PCM_STREAM_CAPTURE;
> +
> +	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
> +}
> +
>  static const struct snd_soc_dai_ops tx_macro_dai_ops = {
>  	.hw_params = tx_macro_hw_params,
>  	.get_channel_map = tx_macro_get_channel_map,
>  	.mute_stream = tx_macro_digital_mute,
> +	.pcm_new = tx_macro_pcm_new,
>  };
>  
>  static struct snd_soc_dai_driver tx_macro_dai[] = {
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index a49551f3fb29..69224c7805bf 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -938,10 +938,19 @@ static int va_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
>  	return 0;
>  }
>  
> +static int va_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_soc_dai *dai)
> +{
> +	int dir = SNDRV_PCM_STREAM_CAPTURE;
> +
> +	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
> +}
> +
>  static const struct snd_soc_dai_ops va_macro_dai_ops = {
>  	.hw_params = va_macro_hw_params,
>  	.get_channel_map = va_macro_get_channel_map,
>  	.mute_stream = va_macro_digital_mute,
> +	.pcm_new = va_macro_pcm_new,
>  };
>  
>  static struct snd_soc_dai_driver va_macro_dais[] = {
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index da6adb3de21d..62ed1173fd1c 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1354,9 +1354,21 @@ static int wsa_macro_get_channel_map(const struct snd_soc_dai *dai,
>  	return 0;
>  }
>  
> +static int wsa_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +			     struct snd_soc_dai *dai)
> +{
> +	int dir = SNDRV_PCM_STREAM_PLAYBACK;
> +
> +	if (dai->id == WSA_MACRO_AIF_VI || dai->id == WSA_MACRO_AIF_ECHO)
> +		dir = SNDRV_PCM_STREAM_CAPTURE;
> +
> +	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
> +}
> +
>  static const struct snd_soc_dai_ops wsa_macro_dai_ops = {
>  	.hw_params = wsa_macro_hw_params,
>  	.get_channel_map = wsa_macro_get_channel_map,
> +	.pcm_new = wsa_macro_pcm_new,
>  };
>  
>  static struct snd_soc_dai_driver wsa_macro_dai[] = {


