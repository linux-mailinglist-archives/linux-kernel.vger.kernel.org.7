Return-Path: <linux-kernel+bounces-832432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72FB9F4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED34B3AE10B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378881AC43A;
	Thu, 25 Sep 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkyxQbXL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2401A23B9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804053; cv=none; b=A8C/nmi/0PQjOApHnKidUw6SpNfKJpqG4zOs0LA1HLUDNk/3wQYOgT4V/1mGYnJ8qm3s+5KNXm1d02uM4x1uWssSGxJfmZ+A6vVZ6LZhEKkvZxpxnRUdddYwxgGUptwvEq0x+wb8Glpz8F/wM4YI8vHvrYY3H0/P0O9+h7IC8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804053; c=relaxed/simple;
	bh=AhGGCS6dDI+GEQk34E+bshyvtzLQAsH6srofQOixnko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaEzBbZyxT29V2mxAZH35QtemJQvWO8UEiu1Gwz/sCWov1SiElF1FCRFHEYgLsrOjPBjmdw/oD/5q4PLYw0VNfP9t0hJ+ICnSxTzIE6+lMHdGBsQszQhIR0JA9mbniwUL0eBVH1f2KBaBfl7ClE/2c2a3YD2wflEY4dUMN/4D7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkyxQbXL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9kBeu023756
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7DA5QlEXLvO5wlCLJTK0tIK5026blUS+NEp9jsrNDPI=; b=mkyxQbXLg+VJXAgZ
	bza7J42SJZPEgNsNAeBceG/gVepjIMmlfexF361ghuqmabdWDK7IJVs4bCY1iAfD
	dr4erPtvdC6GWRtZvNIEIM+pYvwE4qePtN9oLMdXw1/5rkzcwAHvL96feWaU73Yf
	4SMTgnlaccwedgwH2RabZ/6MtEOcAlVdNH485U31kd44eVVgLYO1F+eR364x93CA
	85MQbzFo3UXgkOnXCKOAolW9Ly+XnFoAGl43CzDxCiZyEtBZDkoebd0g2TjHuIMS
	qnIm6FqsvB2GZtqgUUKtH0qn1k+h3fOH6qJwGaMrH1t3w68MHd8rctvXYMkZUZed
	nTNTbA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0f47j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:40:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d91b91b6f8so15839631cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804050; x=1759408850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DA5QlEXLvO5wlCLJTK0tIK5026blUS+NEp9jsrNDPI=;
        b=D8U+B83J2Q6UWoDYd4M82P86054e6PUajwXgWZiM3//+P59HmhH9x4Oa/p6J5jtOkO
         ZHard3SAwGaZRw2nLdl+UB/EcbVfRIDsooy5TdU3/5Mbz3AEzEC2nqQSBKxZrdnLG1jb
         fRA0JMDSAyZMa/3hGn0OCGoAVwlscchis5h5QXvy8iVw3xcIRg8yUeIng/Zn+FvHiOuc
         1I4vqc8GB+WxgVaxa1eWC2cL80LCWB32zrRaIHL0eipsHL3K9ITwcW7mOWaECqHMiQpX
         1ADg3TgFTED/iBGBZrybJq2fkVDbv+l5IKxn1CvfrqQoq53JRTYVjKDYlmXkEEQvffFx
         Kdag==
X-Forwarded-Encrypted: i=1; AJvYcCWHM738uHsi/UgdyROWaYqQYjJJfiIQlukUFwolsnORV1SapB4rdkG2hCfDspJSFcXkXoLSnscgGg2TkpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7dtJHmIZlVXd/FhJcXJIkGyRxER3Jd3CVeAH/fnLQICJ4bPP
	LvRXTqVJg3Mt8QKVYy7qzre+FxbLKcjOw5xxr6RHUpUvJg4P+LwSuUq3X67xt9uS86P0NcMukCJ
	SmvKzae1nJd4hy9oIIXw3BiWJ92JXTdPh8EtlRTUUSLn/MAp+h88iVITaouNNyNOQtIE=
X-Gm-Gg: ASbGncuaPEGhPPXvDb7r3my8yiR//FuE4vdU8h5HSpqWhgvrsetYTLISpLPT7a5GCjG
	4a/T+HlrTU1W/eenIPBdvnYCYAnBMMqWqDF8mXDilnyzCm5A9+/Ys9OMTHaJIou6t/+pE2FdZma
	nev14GUwArE+p4OhhyZEWU9/1ltaVjb5G7b89wwyoJqWb7qFxtHfYvd/WHGSJyj5OcYxzhlQ+n/
	Fh6Mnho6xpoFTRl9LTWLL8XVCF82XhyOc9gn4zVGfNPoxTaKnihSCFsk31OTY0+7Jo+R7xfkpky
	0cLUgnWOamKFLsJykRfNch33z4lvHAnIGdRjZXM0xQcHsMc6qpkOTS/xrdzs/jZ/cfg=
X-Received: by 2002:a05:622a:1493:b0:4cc:1ef6:9c07 with SMTP id d75a77b69052e-4da4bbe5ef9mr35814391cf.60.1758804049797;
        Thu, 25 Sep 2025 05:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX85mpHDw23mdnZOpD/BzldlFTXbeXvu6iZKgjDkleBCCGikK22j+c/QmDKXYYH6nMkDB1xw==
X-Received: by 2002:a05:622a:1493:b0:4cc:1ef6:9c07 with SMTP id d75a77b69052e-4da4bbe5ef9mr35814031cf.60.1758804048934;
        Thu, 25 Sep 2025 05:40:48 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc5602dc2sm2881204f8f.32.2025.09.25.05.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:40:48 -0700 (PDT)
Message-ID: <fc956fe4-e4f9-4f34-b1c1-1bc23125494a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: qcom: sc8280xp: use sa8775p/ subdir for QCS9100
 / QCS9075
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250924-lemans-evk-topo-v2-1-7d44909a5758@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250924-lemans-evk-topo-v2-1-7d44909a5758@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d53852 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IA5jmXtsaGuytGhItUkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: bX86hc4C8dDfG4aMXXeGi17ZMS9X3_Yn
X-Proofpoint-ORIG-GUID: bX86hc4C8dDfG4aMXXeGi17ZMS9X3_Yn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXxQzroRJNDd4O
 uYjEs55crjvwOcjUiHY6bU8Y8VPujgyZJiByyjdwof5KbhHir78dQvektkHdbumQyVGI1yG8rL0
 u/rWkaAnJyFF8Z4y+7FNrgtn29lXWMR4XaHX+bT8ETdThZNrVC+VHDRMmIxIG0eNxNKnf2zTQ9Y
 o95UtoyXmG4ULqMTPD4B0Xed2xufzB5eyKqudaBWYw8b3MbIecfoeOeA5K+77sylBgpFFSCvhyx
 CMpleNDuadfuXYGyQOD31ObkIR3YA7TQV5ceGlS3aM9Xe1JLyq9rxiSmdVSWiEdLfpJf5V7SXCz
 r8Bvtiz0HaOT+9Olx5VCx5YNGPeUm1EoktzQ7Y3Q3y9dVYZDSFiQPaFRKi5kA8d8VftNVO6efcX
 R6lArwZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138



On 9/24/25 8:34 PM, Dmitry Baryshkov wrote:
> All firmware for the Lemans platform aka QCS9100 aka QCS9075 is for
> historical reasons located in the qcom/sa8775p/ subdir inside
> linux-firmware. The only exceptions to this rule are audio topology
> files. While it's not too late, change the subdir to point to the
> sa8775p/ subdir, so that all firmware for that platform is present at
> the same location.
> 
> Fixes: 5b5bf5922f4c ("ASoC: qcom: sc8280xp: Add sound card support for QCS9100 and QCS9075")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks Dmitry for cleaning this up,


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini
> ---
> Changes in v2:
> - Rebased on linux-next (Mark)
> - Fixed commit subject (Mark)
> - Link to v1: https://lore.kernel.org/r/20250918-lemans-evk-topo-v1-1-9680600e62d4@oss.qualcomm.com
> ---
>  sound/soc/qcom/sc8280xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 3cf71cb1766ed7e3d6caf6a74876f6102ddcbc41..78e327bc2f07767b1032f09af7f45b947e7eb67a 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -194,8 +194,8 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
>  	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
>  	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
>  	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
> -	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
> -	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
> +	{.compatible = "qcom,qcs9075-sndcard", "sa8775p"},
> +	{.compatible = "qcom,qcs9100-sndcard", "sa8775p"},
>  	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
>  	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
>  	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
> 
> ---
> base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
> change-id: 20250918-lemans-evk-topo-dddd73c29024
> 
> Best regards,


