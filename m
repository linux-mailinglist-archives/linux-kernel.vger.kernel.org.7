Return-Path: <linux-kernel+bounces-800131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519AB433C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867193A6952
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1229B8EF;
	Thu,  4 Sep 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lziSIs4P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7829B20D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970621; cv=none; b=bkq8MSu/QfzLQWYaecFqOubJcvBYJmL624wrznOxmAZqHFDh1tDUNRDxOedoGwAcgZqZ0OzQr2VCUvopcZHqXrb8+bCXq9Wc1DbF27UdFALZyswtYIMfisCrMiGka2dk7afruuLn6d2yG4stvDAAo8yoHgC8ybN5oownI6kQsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970621; c=relaxed/simple;
	bh=K+k2g+907ASsyyCxtBq+xooXy3sboopG0rLk+Iq1IaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RA7RlHRd/mPdm8gqurbMFTVhWRgjy1iD6pUeoW7xDd5VdvCJegBO3bFAI+ffSfia/yaUC0KLA266Qb2v/NEwbMEjY2tE/Urj1kSIO/yZZ1l+pTW7QRdMqW+g4knS44kl2GvQH2BEgObOfGjlPo/9Hl4Dw3Vr1NED67ce0rwr7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lziSIs4P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58411eJU007597
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 07:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcLHrJrBsSDOxB6AEHbsxRowhoXfiqU9zcHadIgLOJ4=; b=lziSIs4PiBBJLjgN
	EaIw38AEPHeQmG02ymcFQqODgPlFw7ZmpbMFNbtFThH9ZvnV9rhf/VXdJ31EaDUd
	lAOZ9Q38ne9ob1GFlolyb8ViYqzESaZm0IxrJy4XSkM7zncg3eEASQsq2ywTPzMw
	BA8yeNcujTptekk2sriCAWk3kH0tF6QF78PikcIo0Y1S4LfhJX7cgZK52et9wa+Z
	ToGe+DUeGmvMfue2JTAPSGM4zt5V6oWteZKgRjGcQJd9oJ+QB3SOCmV0jjzT6W5R
	5ez9PH773nfxwgAqjXFXtAFC1CSZQx2EXgeKwlw4BuNJ+n6TIv3pw8GcdymaKcN1
	74RJ+Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv6r1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:23:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32119e6c6so14475701cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970618; x=1757575418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcLHrJrBsSDOxB6AEHbsxRowhoXfiqU9zcHadIgLOJ4=;
        b=dIrsHQ+wgJtJNR22HDr+hH+BlnyNPu3tKCmTJqSel01xeVWTnZSjICfj0W4FDAZD8u
         4ebfZNDBNCly6AxZU129IPYzmzUQ2PdVDr2E3r4+bditeDM/ExPOe4Ety9dL8aqFxTOi
         +XrXXXQTx71sobvdSoM0bBJAYzL+u5FXVuja+Qu8lrf4vXucQqr9Z5/uTiOuG+ecQmt2
         /1hCW7yKVFrBk6OnRsOp425TE7Ci72PpBeIqjXtlO1LeSxqn/qiZoKKMjdY4XlE7RPUJ
         rPgDleoCd2Ay5/GJuUHvU+UFHdzJIrq4w2HUOb0NG8QneFAoBGnfZsajghAfnAMDTJvC
         FM6g==
X-Forwarded-Encrypted: i=1; AJvYcCXKrbuckRPHeDwiJJ7713pF5d0+C8zU0/dJmHBQHym+cLmvBlh3Z9FD/iAKsuWw/AWm6cZcmxuXzAg2/FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygCSi4mjibkefo/IDh0upaSdaEJi8U86x6tdnNwDzwNVdZtWcq
	1u5yPHTa/9hMcFcYyYFPUPkcuOM6OhHiXoWaqQ4ADTm9MyG+c2UBssu1lfHXXg/wtH0TSbNjvEf
	4KLTblMAlCpJx0TrL0WFDwQphKuKyxwd0UvenzlYt0tfMBQ/uKyT1ZPb4pr5KEt0SANY=
X-Gm-Gg: ASbGncsY51F9juc2AM17d64gxYEq25S3OGYyvbwVAf9L2BY33uRqUt3hgKIzKjiSf8S
	Lgukik8vzXtNa3kMt+yd+wgKzUnwVpdeofyOa8803gUr2hGViy7I6b5ukxKeBH4HgksfnyNjjKF
	Kzw3ognxZVAntO4QtK4ut2bGY8WHyAn2tpVTy294LrpD11zIkFSpbdd/hKgeibAti5xY4OTk7++
	QH/15iprX63wnKO54s/rAQUGsyzrLUm426bD8BvuoluHZnv3h7vmciwQ+GewilDmtCJaRTJD552
	354At+1E3U3IWB+rsUYoQJPg953fkkJZ0o/YC5JCaWiO45oadwCq8A+jFpM8nkYgnmI=
X-Received: by 2002:ac8:5a47:0:b0:4b3:1c38:b22a with SMTP id d75a77b69052e-4b31d80cc3dmr216763771cf.14.1756970618147;
        Thu, 04 Sep 2025 00:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4sjl5ao0M+XBc1s/tKuYtLWf33nRLYhQWE01z9AIvDf1k++soeDSMD6W8+8yKBeeVxEgr4A==
X-Received: by 2002:ac8:5a47:0:b0:4b3:1c38:b22a with SMTP id d75a77b69052e-4b31d80cc3dmr216763491cf.14.1756970617611;
        Thu, 04 Sep 2025 00:23:37 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm108511605e9.21.2025.09.04.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:23:37 -0700 (PDT)
Message-ID: <93c7a172-6c56-4feb-86b2-b645a4416a18@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 08:23:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: Fix playback quality
 distortion
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>
References: <20250901074403.137263-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250901074403.137263-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX/URYI+NV9CTt
 3kTDekJUDyRxT33CK3bVTEKz4+Z830mdzAwSYy2295OdGreiMag6z11IxNxkQ8EmTsxZki9Fy6Z
 kDmvtjVZJ2/B6P1ja/JzWxziMwsJoMDFCkJ30gq2IxRVQcCeFMra4nD2/+VOxbLn3Nus6R54/+G
 EdegGMAXUvLzHO8A0vRhwrUAQBfaFnvsN7goTBoq7uDzcDTv8S+rLhAiYJVQ+BD0hqk3XRi3+mx
 FiN+b2PjljV8IS3LY7eXYUTe6ROgAHy/oPGKNjcBdnnszEjIY+yKzI1QtSv/QLq2ILS2IM0GYrb
 C+WWuDrqt1c3kvE+budt6cI2K5TOMw7mvnxQJv5h+nX6bpGGmaQmmYdFSqeLZ9ntZNYi7+BrJ/p
 DlnJIgso
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b93e7b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=GEb1iMsm_hWG1FcFbWEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 45-Atav02pFTcMIIlJrBfkR8k9BkVQ1G
X-Proofpoint-GUID: 45-Atav02pFTcMIIlJrBfkR8k9BkVQ1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 9/1/25 8:44 AM, Krzysztof Kozlowski wrote:
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


