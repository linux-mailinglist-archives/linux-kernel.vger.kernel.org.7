Return-Path: <linux-kernel+bounces-830344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8BB99712
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB430188DE84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAC2DFA25;
	Wed, 24 Sep 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crCZxAex"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFB2D94A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710206; cv=none; b=nh1H+MdqRjtu4uRHo3EUa4JN3ML9g0andXEQVukvmDw57cFBk/ANBpAsknKM72hFs+Zi9zoIajnBH53qxVb7Aqa+uAlGJAN9BzfUyciEwDvW/NO0otf3sov8f4Ck1s/jmnPi49q2BZ0yJZVvTHO/MP0phcVKKZlr3u/HjDg6f4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710206; c=relaxed/simple;
	bh=TcJuuFO6n0Y9yMEhd3p5BYTjpQ9PLg7J6rBPzBmb53Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukui/RTnDzOplyEaUbQHn8qnEQgzW6m4mD89grWS62BGzljvNI0YP9Na8cDJpvP6LY+DMh62AW5kYqE0E7vsOKJeJ5LkLH0szCoCLPKcuFVqzWuXhJGC1IY5wki8WeawEZELWz0IIA5PWPIfE9fag9WnCjvv7MsKT5AG8BdB/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crCZxAex; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iAcD021486
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/Yl5Cf4yj9MAlJOJXqnptSyyyT3YpEhhEgjwU6fmXk=; b=crCZxAex6fQshZlM
	ju719S9Mgg9yEm1Wmh3Oc4+Czb6/XeUhVpAv7SR66PoQERKkhl4+uGW7Z+oCYfp3
	BW0CnfhXL74teLEy1b9yLozGO1XeNLre0HNo96fhnLro//2Spx2e152WdPkO6D0t
	/mPOdRkbqVwPJoMUsoGuiHc2VLOE8GwlXyzL8GuipP1pWlQU4GGynNS9XMAuuvVL
	s9plhEzvJz/Bktz9N/xhtldwdjENV17YDioseUchtUKrX0bk2ZBWEfcj95ADViE4
	Qe3EdSlN3AU5kAyDQqjrTss2gJeJCcLQASPAM13tBfyOUzm9nmvXQUmsqO7P2Vzu
	KZ8koA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budabj5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:36:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ca8c6ec82eso68555591cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710198; x=1759314998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/Yl5Cf4yj9MAlJOJXqnptSyyyT3YpEhhEgjwU6fmXk=;
        b=cjjhlrOrd4WnZsrLvW/fNr4s6wiXT64yLewZ8hq4GGGfH/hw5iHyvGiYULUeTG9K9L
         UpZ/7w/sJEiFBBdua0qOem+uaLsP9q4Bm/ToOCMH8+oIvnenplG1M10YR0sL+5ONgCz+
         wNLdDcdsFjt5EIq7j6uzhYgYl0NNLxPq6OE8yV8tXa604MbyVB+kbR7PjskLrg0IA21D
         i/zC+AJRvKnKoPSryPHq2Qk48j0fgOuWqMw02vU/is86UrRju72aAyAqV5TX4xrAZ2HE
         vwYlybXMy2LTjK3zOQvLC2w9aAgJsfUZYYgjxTL+HfgHJRBrKXgNd36Xa3PQJTMGTWHa
         3Rjg==
X-Forwarded-Encrypted: i=1; AJvYcCWH4KZ7ksYsj1jzsOHxFIEMT2fPAGdKj8ocbrvJtzGboYEyXHh2hnoVET1RQJBoUcbmAg54QnZFuvhrSTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVN7vp/IOQkqG1s/wlfNLk+gJ5V2GKUGs4PynRg81ZcmtC2UI
	ky7/+zHFEPw64UrWETGCn+eAr5muMjPKh+jfzpPZ295NsqqslOmbMtpYEJCL/AGeHcYdmztHa/s
	t7VGRWBh3mKS8MF9XYOgJQHWYUxPVRmDq4usqoA+7DQsZsbunDPhEYL7CH5Y4TKJ7koo=
X-Gm-Gg: ASbGncuIQ/WI8TP7G11NLjl73nKgNIpciKupCvmPeX/PILO0hDoZb4nF3EfNVEeL+es
	FqTTlTdR2hb9NFFY+Hnt+/1EJ++ESjk+/PQBeen0sBbP5kb3ZAZKn5cjcFNsvsPuiFD6uQQ+YZd
	Ld9VQiC6rErjWQ9XYTUttI+inAmV01dh1/ZmTPR5VQzRjVS7/A6JgSiUzs3Yo/f2Xl6NPIGgWwi
	K7ZsaaNOu7Rs3kb8GY6ElIEi9T+8Gdz/FB80Up7zTZ9ks3mdGYU5JftwXgl6DScdEb0XwM0spGe
	J06u9ULGUrgAZBXAk6eNvr9NGY4Jsgn1qP3hGFx5M8BSZC38bwtXeIa/0TIRkkdhBbs=
X-Received: by 2002:a05:622a:2996:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4d36879b57bmr67953241cf.8.1758710198402;
        Wed, 24 Sep 2025 03:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvc+HULoluES1jwdfkJ75V5AO5mrYzrq/vmxtknjaJtpWE6iUTAMZQ0tm+dXZwSY8DOzWdVQ==
X-Received: by 2002:a05:622a:2996:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4d36879b57bmr67952911cf.8.1758710197936;
        Wed, 24 Sep 2025 03:36:37 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm22815116f8f.56.2025.09.24.03.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:36:37 -0700 (PDT)
Message-ID: <59aa38cf-2a57-49f2-85bf-157b1e7e977e@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 11:36:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] ASoC: codecs: wcd-common: fix signedness bug in
 wcd_dt_parse_micbias_info()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aNKEZ3VqJ8js208v@stanley.mountain>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <aNKEZ3VqJ8js208v@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RTqDq_I-PaxV1r4ezAdv6oelVEFCPL3f
X-Proofpoint-ORIG-GUID: RTqDq_I-PaxV1r4ezAdv6oelVEFCPL3f
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d3c9b7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=-C2JdNfRTmumDSgDQiEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXySSwg6k2qnff
 vWIWqQsqcljBJap6c49HscIPopiNVIYihG7sz7cfU4KEsFI1coHSqW/S98ohCZuvZVaWSsmPTnG
 7olQeqxTRfAHETcmavhBrZJomD7CoOPXu8ob4UzMzZf89ThrsVrSwHco4P2WwmT6QROIy/L+L5T
 91C58am71qXGDkvg/cmoc/91D8IJ2lfMwr9uov0aSdvH9S6t5VihjzirPc3JAlUxatrKfP5i0KT
 4qYM2f0BdzfCDx1kVupxmANuRgp2c5z1oJXZXaJ8MqRMvSvMdOkXIlAUCliuwsk1r+CnNvymLxU
 Ye29DL8XCaCNTRHm3LiC8EhMePP0M2wBbCWicxV/6e87h5jpHzIjUYm2o/OJ2QGOkr7wgc6H7py
 Yuy2XJtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On 9/23/25 12:28 PM, Dan Carpenter wrote:
> The error handling does not work because common->micb_vout[] is an array
> of u32.  We need a signed variable to store negative error codes.
> 
> Fixes: 4f16b6351bbf ("ASoC: codecs: wcd: add common helper for wcd codecs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Thanks Dan for fixing this,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini
>  sound/soc/codecs/wcd-common.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
> index 9bbfda828377..9016e974582f 100644
> --- a/sound/soc/codecs/wcd-common.c
> +++ b/sound/soc/codecs/wcd-common.c
> @@ -62,12 +62,13 @@ static int wcd_get_micbias_val(struct device *dev, int micb_num, u32 *micb_mv)
>  
>  int wcd_dt_parse_micbias_info(struct wcd_common *common)
>  {
> -	int i;
> +	int ret, i;
>  
>  	for (i = 0; i < common->max_bias; i++) {
> -		common->micb_vout[i] = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
> -		if (common->micb_vout[i] < 0)
> -			return -EINVAL;
> +		ret = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
> +		if (ret < 0)
> +			return ret;
> +		common->micb_vout[i] = ret;
>  	}
>  
>  	return 0;


