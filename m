Return-Path: <linux-kernel+bounces-805248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D8B485F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5789189FADA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2A2E9746;
	Mon,  8 Sep 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azhN1hsC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7002E8B7C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317390; cv=none; b=VNRy/9B2kcZXRfXBYRbBAjPDsWNdTs00B8hisYgrSjNLseiZNMl6wXGQRgGQYbtxRkuexUM2o+9CLOyDMmS1SfG4qYNjfwmUCecdj89DoWWQEkrqYt+FjJdIJ36BZ8/N4jhOcl4NF1dvMtTt2qlR5OWMKthzEsd/PdQr08/ijeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317390; c=relaxed/simple;
	bh=WYg45bgT0XRN0euq4QCobxp8IotvXOVZG3lh3FUmcVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syzJMjKWeWOpG0idZYETxPglbW4jZoLxJkwmG3FGQ4CcE3AnmPhBy/07l9xhuFncI/jCxxB38XBP1fOVQNavjwM3XWtq4TEf8LcQObzEOhOV8xw9Fqzg9Ul6XQCe16vgPC0T6nwRD/sqzrWGhfjpaMdQ5S1K+kVNEpuAr+jIb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azhN1hsC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Mt9ar027195
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 07:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1grmPgipKFGWJ92VbKgO7RBjzC/AoySVCE8pyMqTBpA=; b=azhN1hsCVGW3xN9R
	qqm2DukADn+E924Sqz/YT4jdrwM1TmQWOMC5Ve3I9HKQUqnt4uZznMwbqIp9GEWC
	A7ztNMDfXG2aR667ua+FQoVHEfwQ7TCwfalb85O3/KuGazvZXarDkIBXirZdMYw6
	EhBpVPTY0+cemuOTQxwBgPNYm8x9TXwK9dARAbaw2dGO/DHjPpbUv7w6vK1GGsvw
	ydQcZK8sgatnDoX1yCqNLOc0IjTMirkh2P8jjEp7ppwW2yS7L/ORf0GinaRrRFH7
	it0nG1ontF3vliJnH68uU8TFtmWbxiUwzCxok5kR6QrScto3geAbvjxHC7X46p5K
	GOXOTQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0kpxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:43:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7507804a7f7so4724876d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317387; x=1757922187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1grmPgipKFGWJ92VbKgO7RBjzC/AoySVCE8pyMqTBpA=;
        b=ZNFdih6Z9fnY22VurbjE384Auj/qd+TV/7wp0LLCchcCIPolHfYYUISGJJTVdo22/N
         o14m1hEwUsiIY2iq1qk8wE9LwgsOoJ59tDCp70GhwKVICdpTdustUjs5Ab3ZYv7Of7LX
         o9O/c0AYE/DRANzvods27f+mK9VvF8AiYCpq6FRofRmuTJ5MW52bcQcuhJ3jxl5/Ot7t
         j2QQg+HQoir2Qtsd/DFE0Y3/bj6Rtb8RULDqDnHlN+7rwde7/kQFb80Dy+XsjUzy4H5L
         WUaPgcFlWxebnPYcOGvEhyZ1yxnr/kOHZDUZK3YtmVb4eWitKaGERzmHuUfftFq56G6A
         yGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSOydOE/9EdcBZ0A7rSjRk5lwine1VB7amuEmSqCeeTuwryItP7FQJu/puDCdvEbm3Lyc+BpwyYqo4GTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3w5zkMBE6bApkhpSGxG8MrTYUIvevq4Pq4pLYiY+PwVldoeVf
	+14uTEkSf/ZxCXJwTn7zP3iVp08mcJ4JWWF7wu013YfrJOz9MV6cNgioY/ONLJlYYodA8FlVQy1
	wFBUGDiLad/b4QFoLVxTVo1zUcFIXwpIkL5zgkwF6TggQlsLIdo3zcsRyyrn+PurMjZA=
X-Gm-Gg: ASbGnct6Rnj1ChdbX/6W5PMZwdpxU3speXco4t1Qv0+/51bMG4QAS5mONOxfpBXnJH2
	/lCUFRbBEHUtl0AKYR49FPlcN2MYm96FZ51qbdW0JO4AV1xPofcGl0zy5IhNyOd4b38H5cIFuWo
	mBkAxZw1vU0fc8JUIG/BrZHUa8nbY+i1wUQq2g0FWNUNdFutOl1yT8ngVO2JI9HIqltSgxGU9t7
	aQDYysNdPnPD9k2LqoypDEmDXnr1EQjSayhsxJcI0ghLqyjYIj5DVdnMwZ+CoH/4+sD6XNk2UnQ
	CA0lIw9Ar9BMA+fU0iiLxjgPfxtORIVjejsTdNruYxT5VaJycb+zNE+LkyBwEwBeBZQ=
X-Received: by 2002:a05:6214:ca6:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-72bbdcead63mr126284846d6.1.1757317387165;
        Mon, 08 Sep 2025 00:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgAcdbDq5zNfyipOZBWdCcXswZ41a9jDEPvBfo2g42KlKJ6RgThA5OuAMoeYELmzFt39Z6Gg==
X-Received: by 2002:a05:6214:ca6:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-72bbdcead63mr126284616d6.1.1757317386708;
        Mon, 08 Sep 2025 00:43:06 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm225190345e9.13.2025.09.08.00.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:43:06 -0700 (PDT)
Message-ID: <9842b149-0c39-4114-88dd-2fbd4423d077@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 08:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: qcom: sc8280xp: Add support for QCS8300
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905142647.2566951-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250905142647.2566951-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Oh-znjYx-lnGVeAOIgITPq6zURpbf7uN
X-Proofpoint-GUID: Oh-znjYx-lnGVeAOIgITPq6zURpbf7uN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX/endR1skU7v7
 PWD8B0GgN/8Zu2i3cVKFeSlfEzDPz805MbL7k62ALADw8wCi5biykbBpccOYK2dlpyOorISVp5F
 5nYBOPS7y9PK6s2Y3gYT17mDwYeH/zzYl5O5g1FmqgYlG3ksXcKb6S6/lVIWqbPEyyR+h352w8y
 JtfHLyW9/jK9f4tnH1NBsbiBbAm1uaK3wGObPxUhX4PoOes3aO8MfOtC3SGzYfCylDSULcWDWRD
 4QciTnFaao91tMVqdL1hz0RgANhx5Gs3GyCJ9TsTXOKv9sUn1Y2ZciXhqn9ib29f5AMlvKVjIK5
 LbtYjbi7qd08XSVKuYst2PRDIEp/TxCHA3PjhyhZBxZDz8amxvr9m/DUqYoDRA+izPukIsJDb5e
 TZCa62Yp
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be890c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NPwD-xthdEbpHelLTGYA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024



On 9/5/25 3:26 PM, Mohammad Rafi Shaik wrote:
> Add compatible for sound card on Qualcomm QCS8300 boards.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

LGTM,
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>


--srini
>  sound/soc/qcom/sc8280xp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..c6aa62b1f66f 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -187,6 +187,7 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
>  	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
>  	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
>  	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
> +	{.compatible = "qcom,qcs8300-sndcard", "qcs8300"},
>  	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
>  	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
>  	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},


