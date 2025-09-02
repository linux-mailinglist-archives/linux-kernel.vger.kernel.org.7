Return-Path: <linux-kernel+bounces-795469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1EB3F279
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D22178D28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98252DECA0;
	Tue,  2 Sep 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtTKd5iC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9752848AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780832; cv=none; b=qaJRyIWksZwQ9Z6PSlRUW3cfBtNHqEacNOf2WkGarsciwHC9hZI6bYpy0elgRiy3yl6dMsWNxXINTBxr+K/1bs+/gEdJ0mgSxKoTXBroXakTzogH9/mw3cUth3X3OrC7GimQxuhmXLnfTU2GZIxGwc+Sazw1JOWHcWuAMvn9+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780832; c=relaxed/simple;
	bh=WLXcTlPq7XlGarUlGnu8kzNHyb4Dw9UWIoOifERPsUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwcZVZymckQVCM+8CMh0UDf+jzR/RrHm4FsHy9ya6rdgLRhTHLtOQIIi73Ftxn1i4qtnmQUJlfoD/T+IsTOVIR8l5aAcN5DKF16v1YeLB8ByOMkS4WmhLogo8xV2R0o71TOPLHECme+Nm3dS3L3Ry5T/uFiTac5YfYeKl+BMWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OtTKd5iC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RnfT029672
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 02:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tg29j8riSusDWBByFXNjxB5I
	GPrEWfwJcCpyKpOLzXk=; b=OtTKd5iCU45OGFkvXuLK4CPKgLOZol8uh6Kp8ZIJ
	yQrqRBC74EWKovt2vA61Ok2cnZkE52y3qD5+6uylgY25EDk46AuuqZc5ZyrA1QCh
	25yEaMtExWqQboMPqes06fKVedwnlEs1WEGYawpl8sWjbOpXLWUC12ZMKOkw1I0U
	4Gdik0BbX5Jy+rN6kz3GUkOQDG/PpiwbUJB34I7VTY0IFWjygt4E0MQFh9NRFBft
	pckuV0LpU7lv/2QhDcqMw8AEDXQLfWT4gLUPRncgWFhICmHvJtlbOxFugGeeCBBh
	IBSTUg7FgoedPgeyZ8E5duQQpH09FWu6BPDsWGGxqZ/nJA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy226r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:40:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b302991816so82351911cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 19:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780828; x=1757385628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg29j8riSusDWBByFXNjxB5IGPrEWfwJcCpyKpOLzXk=;
        b=jw9FpskDoYMcrNUGVOQsjugsD+fH6Z/tj72gwNql4kS7tvZ9A8SfRKhcAGbz7Cs+eg
         B0yYSwWn8jLcXyqqwSitvmc3p5ih7aKDgNYDu0lOjOZ/23w12SNg0RHTPM0bIW0f3iAc
         a3uiRW7zykzOSl3awMQajQiBmm8Kn4ZEQ1c4WUypB71Ij1/7mOa3qxfOMfM0vU7qES2J
         vaLEmKqR7EAqRoLewQzBbW+nsAxErJcj3bpf+q6dAVMeq044x9RVUWFxrRZeMJcz/7km
         TArXZwLdSAFIPZcI1vtEt8M0UQcABocDPSgR3cyQ3R5Huck6YSHqc4jP3NPpinvA+SZw
         Ly0w==
X-Forwarded-Encrypted: i=1; AJvYcCUdgaB0wDeb/HxIQEaLfxT05SBbbrlSunqvu3L9JT2GAxt5By2S4zxgIAXMW6qb1abpUCW6Et3VgynrFlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCibCBshOhMx8yrOjCxyBW2xegltZTHgx6inlcziLSUhRGvzi
	FcorCjnPigzhP8tQBco4TyvY5HyPp4U+DBTCVbhJlrtF4SAJ4M59e8Iy6DJ8/ymuQrVDWtMMiVC
	M+ncRBUEOgAck9Q/7U4fiPjOkpEHA9AqRJKpP2PyKr5RvHXB0O+yyue055HRJ/u+hJn8=
X-Gm-Gg: ASbGncsoYmb9CZMk5fuVwfElqtWVDr+1p5Q4z3HtTemygQ0Sci4axRQ6FrrWjwZ+/kL
	pBpJfYzLRw2Bt1i8vQ9x34vzZvnRNJFLzmU2hZc596JYkYnxIkFVUZTco2PTLqDq1YkJZyv57st
	DmvxHqPbUepVMRtJNruxxY92n3ok9cPDo0ikz8ZvsPDt5EZLuNE/4+egrT3SrBOgPVn2OAKu38f
	+m/AaiVht85oqh1BKRiBzcy1trajIjwsuVDSZDWNueSY1aCAq+JQ99Qu85dV3xfKv8J23ZqClhs
	rR/63kBt9p8IWZQCdeFCfbDOjSXiIILwAT4vbD2Ad9FNs3zGs8cAOtdecksIZ5kAH6w2Q4YC9DB
	zr7edzmo7HF9vdvHm6GLNI1/DsyprDJwBshVGLjTv2v2deTS5JMB+
X-Received: by 2002:ac8:5e4d:0:b0:4b3:219:b74a with SMTP id d75a77b69052e-4b31dcccadbmr129749461cf.72.1756780828449;
        Mon, 01 Sep 2025 19:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlBlrS2RPVINW+G+ioh0iSLqOFe4udQG4ZAFt1sPE47KjQfC33Y2lZ3TOUXTQE4CuvMRlvpQ==
X-Received: by 2002:ac8:5e4d:0:b0:4b3:219:b74a with SMTP id d75a77b69052e-4b31dcccadbmr129749131cf.72.1756780827810;
        Mon, 01 Sep 2025 19:40:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826dba58sm298158e87.51.2025.09.01.19.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:40:26 -0700 (PDT)
Date: Tue, 2 Sep 2025 05:40:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: Fix playback quality
 distortion
Message-ID: <bect6bxzxmxguqsrxkchbkhhxgz5lmnzzkwwjyvaca7qtlfz4r@lxmmfto2qkm4>
References: <20250901074403.137263-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901074403.137263-2-krzysztof.kozlowski@linaro.org>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6591d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=GEb1iMsm_hWG1FcFbWEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aStOa5PcIrXxAgtguyzljrtbXTPLm6l4
X-Proofpoint-ORIG-GUID: aStOa5PcIrXxAgtguyzljrtbXTPLm6l4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxNKZnJMTkjOn
 //FnHsT+F5qllhoP3ZWieg0ZwgMczyDfGECPC7IVymN+lgb5nlQl9TUJyynbyn1pTgvou1b2qDx
 kTKdCiB+h19YwodIoRZxdUHjmwKBjqTDxDXwdDrp06G6R1Aus1p2M99a4HaX4eusdpE1Dpt3l0g
 aM0EYigOezhXGkpYnC+LyjJkJB39OG60zSHM6Dr9eM2oAyh2tzZ+pri468ApRXebQrihC7y6WIO
 4/Mfi0maO/+hhINAJQUmOmXISicuPHLhLq0+9UjLd6f11AC/GmEFK2/LeHEn4m0RI+gYj45lRPc
 l9+tGK7FU98+l+jYcIHTaTkM26uxRouiY/Y0jwRANLPiRiNkT2ez79UvtmYOsRfHDadi4sd9nTx
 0Ys97kUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Mon, Sep 01, 2025 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
> Commit bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused
> AIF_INVALID first DAI identifier") removed first entry in enum with DAI
> identifiers, because it looked unused.  Turns out that there is a
> relation between DAI ID and "RX_MACRO RX0 MUX"-like kcontrols which use
> "rx_macro_mux_text" array.  That "rx_macro_mux_text" array used first
> three entries of DAI IDs enum, with value '0' being invalid.
> 
> The value passed tp "RX_MACRO RX0 MUX"-like kcontrols was used as DAI ID
> and set to configure active channel count and mask, which are arrays
> indexed by DAI ID.
> 
> After removal of first AIF_INVALID DAI identifier, this kcontrol was
> updating wrong entries in active channel count and mask arrays which was
> visible in reduced quality (distortions) during headset playback on the
> Qualcomm SM8750 MTP8750 board.  It seems it also fixes recording silence
> (instead of actual sound) via headset, even though that's different
> macro codec.

Wouldn't it be easier to assign 1 to RX_MACRO_AIF1_PB,
TX_MACRO_AIF1_CAP, etc.?

> 
> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> Fixes: bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused AIF_INVALID first DAI identifier")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Reported via IRC.
> Fix for current v6.17-RC cycle.
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 238dbdb46c18..a8fc842cc94e 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -618,6 +618,7 @@ static struct interp_sample_rate sr_val_tbl[] = {
>  	{176400, 0xB}, {352800, 0xC},
>  };
>  
> +/* Matches also rx_macro_mux_text */
>  enum {
>  	RX_MACRO_AIF1_PB,
>  	RX_MACRO_AIF2_PB,
> @@ -722,6 +723,7 @@ static const char * const rx_int2_2_interp_mux_text[] = {
>  	"ZERO", "RX INT2_2 MUX",
>  };
>  
> +/* Order must match RX_MACRO_MAX_DAIS enum (offset by 1) */
>  static const char *const rx_macro_mux_text[] = {
>  	"ZERO", "AIF1_PB", "AIF2_PB", "AIF3_PB", "AIF4_PB"
>  };
> @@ -2474,6 +2476,7 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
>  	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
>  	struct snd_soc_dapm_update *update = NULL;
>  	u32 rx_port_value = ucontrol->value.enumerated.item[0];
> +	unsigned int dai_id;
>  	u32 aif_rst;
>  	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
>  
> @@ -2490,19 +2493,24 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
>  
>  	switch (rx_port_value) {
>  	case 0:
> -		if (rx->active_ch_cnt[aif_rst]) {
> -			clear_bit(widget->shift,
> -				&rx->active_ch_mask[aif_rst]);
> -			rx->active_ch_cnt[aif_rst]--;
> +		/*
> +		 * active_ch_cnt and active_ch_mask use DAI IDs (RX_MACRO_MAX_DAIS).
> +		 * active_ch_cnt == 0 was tested in if() above.
> +		 */
> +		dai_id = aif_rst - 1;
> +		if (rx->active_ch_cnt[dai_id]) {
> +			clear_bit(widget->shift, &rx->active_ch_mask[dai_id]);
> +			rx->active_ch_cnt[dai_id]--;
>  		}
>  		break;
>  	case 1:
>  	case 2:
>  	case 3:
>  	case 4:
> -		set_bit(widget->shift,
> -			&rx->active_ch_mask[rx_port_value]);
> -		rx->active_ch_cnt[rx_port_value]++;
> +		/* active_ch_cnt and active_ch_mask use DAI IDs (WSA_MACRO_MAX_DAIS). */
> +		dai_id = rx_port_value - 1;
> +		set_bit(widget->shift, &rx->active_ch_mask[dai_id]);
> +		rx->active_ch_cnt[dai_id]++;
>  		break;
>  	default:
>  		dev_err(component->dev,
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

