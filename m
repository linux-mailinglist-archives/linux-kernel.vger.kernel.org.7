Return-Path: <linux-kernel+bounces-820908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE617B7F9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBE527204
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2A3233F2;
	Wed, 17 Sep 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJo4ThQW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089D31BCBB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117114; cv=none; b=JP2C0TfwMCaZCXXw83q3AfBucJLhvtceWfl8UElCESvNQ7S+w3TVdOMyIkvUBUQIOpKGs+moyhf2FZpTRB0x4R+3qusZ4gJa9j3R1a5IwhAI4XFs4iLYg/rUVl2jtWio9Kkz2rpqSjBgSKHvRyavFdAiRDT9K4HKg8cPIVz56so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117114; c=relaxed/simple;
	bh=wR1KKrdrNFpxEZ4xLE2CusGSA0Y1uaWQR4YSujvUvJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdmS6Prd43Ykjz6oIYtHOsAsZJ2Pk6FTn68dFw3BwxcASHFMALhc6SbJjqEjHDjPvRYNEbg4FiWbxoqTaKvdtBIXYS91ftcy01g7wjZN36wrFSG8tUTBq8OPMmaP9KcC2l7Ni2HzUJlCmfw64rlzWZAIuXm3dWFSc/zovAFDK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJo4ThQW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XYl2018234
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9UiNZluozOEiEosmrVsvrTLkx+n+8c5m7jOfXnNrm9g=; b=nJo4ThQWWrPRlGNB
	AZONy7xqHJUy7oyVy3kQsfrPrHoOTND18WuR99jDhcc5hE5pYj8tP9wVDdZtO/Wi
	RJCue49eQApAsUcFNEhb7g38VcsSPicU592AMa7v+/feIm6/NdKm4P1g6X0BcwLo
	jcklEvP2IJ1MU0gIkwJhV14U+4Ua0aXnofrNOEH5Ptd8iTqwRixqHLh4qNqBodmE
	Mn+tZQbKC9rbwZQYSmXb0USrmaBRgqUYivcBLK96tvylebSlHH/w6t+ABwCCDYnf
	YmHAWifmHnVJgGyM4IwAzWWodHhjPE/x/Fp3ZR487eQqxLapSLoFFSy5tm55c7qN
	wJAbqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwaj42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:51:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5eb710c8eso8737451cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117111; x=1758721911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UiNZluozOEiEosmrVsvrTLkx+n+8c5m7jOfXnNrm9g=;
        b=OBuhOb7NTEKaD+atv0JI5bMJkPYE5BMjXpUOen7+ybgMQz+W6CuSoSlrM44UwwY6ho
         rBQu+qAb2r3ousie37Pj1jTShgE9RX2rZw8MnF2Tn8uNlQKjyT3P55M6AFj4Ix52WGcx
         VdA5NGQA3I3jgQXRlqVm8wJsMpt7QzuSDQf02AQM5CqAGdQyeLXTWAkYHj4qwpWZHOP7
         oiq2QMzdL17uTusuWJ9vUeYC+/SVr8RGzeveQYk+GLTb0Fs2+Q+WLysH9hFQwpIz5oXS
         iPNN9MHdYrR4Il+sA/psSayPy8ZyAtEpnJSjtxpjeSgHhM41QgRJj7kkC4UwPOnICY4p
         H8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUOYoD2YvMxDhsiHf4gP09aJAxz3fnj1oPn9lZhwbMaIkwrwNG/aZvETDE0rZm0EDz58lkAGHFVlB1R4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyquHhOq799lY/5u4Yrf1jtBNQzoBfjH7iW6guN/z2UlkSIrxpX
	PXCgCemZ7hpvASjGgzMSYn1c88CdHSQCTcjSz6UeLHj5yY0omKfgpj3W0tjatrieI+JuvOlEo2h
	lvLVydzHlpGPD0QY7/1/jd8JCNCaDMyymz8rhzvxY1mfrKcth8dauQwDknxnqYeg2skc=
X-Gm-Gg: ASbGncvFPWLl4omkwH3s5XEwhXwc7fNDkihB5y7MObA4fXZNLpUcVa/e67Z5X6YCajy
	aTMCBErHJNueHkuAS8dlVaIJkrVbHvTBFI3U78uS7dnA6wbUV+UQyQ6z+YprcIf8GEkzFMJW6Px
	Ov4CMIhs3qVynN6j+1wlfr0x4COiAPRZTJC2be5Fg4Q7b3vov9Scu/3hIFJDxE14ZmC75m8j9E+
	AFQR0/YgO4EH0mqIQ0fGWbO3czP/xk9LABQHh0Ckypn6OlncScWYjmL5G5SQhE3PIrb7n/tiT4n
	CE1vK+7o56WpJjC7rEUXhWK7NaISS/7fcF3KbI+r2WTQ/XMflDiQa87bTDiSnQTaMC00EI5tfwF
	+RUazwsQf5Jqp/Doh+cmMGg==
X-Received: by 2002:a05:622a:14ca:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4ba67d75f2dmr16425051cf.7.1758117110650;
        Wed, 17 Sep 2025 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2G5c62XRIZqyHsIUg5OGdC5gKqoJEvaDX2GNTMYr+lfCFleDAA/kpmUx+1QVXmO+VMX0cOw==
X-Received: by 2002:a05:622a:14ca:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4ba67d75f2dmr16424771cf.7.1758117110111;
        Wed, 17 Sep 2025 06:51:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2334sm1396605366b.78.2025.09.17.06.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:51:49 -0700 (PDT)
Message-ID: <003840ad-b5a7-40da-800f-1fd880b8f831@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: sdm845-lg-judyln: Add firmware
 nodes
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-6-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-6-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cabcf8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=03C2xpsRYuwQbuPiX2cA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6EU2vnfGE8L8
 VUF1GsDYt79fNPVLoJPLlbu7I/l4z3nIAIApTsYsiB+mmVNSPjTCq9cj4aEnuiFrwAPfl1qDil5
 1ZP+vMQPDUsWFWxxIkidieBlI05vR83CrDNvR01DxJNIHU+o+Uu4YZ4X7rAOJrhndrwI+uOjUBU
 sSWc9keyT3xW2OX1HefuDBqIvpTcNSNJVpejjhCq4o3n2CDh0PCLl/YiHUog4NGlRDUIOC4gC7q
 vrY0r4QFmsZ9y/Z7CD0wz3UzIJyBAOVTkr3/BlQHFKV4iGaG8Pqth3j7jTbLnG3j1ZJ+7cEuoeu
 Zy9dNgzcKJbf2zLjIMCGh4MRqODp4xMplOkW+CJiXPblzebPJDmmd1PMtQBtXRljUUkxv/sVgWh
 EVLPtUsB
X-Proofpoint-GUID: SY3PvTlBKI3eej2O0wfXTWrKz2WshiJX
X-Proofpoint-ORIG-GUID: SY3PvTlBKI3eej2O0wfXTWrKz2WshiJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> Add paths for Qualcomm firmware, including:
> ipa, modem, bluetooth, venus, gpu
> 
> Enable adsp and cdsp nodes since their firmware is present

This commit message is a little out of sync with the patch content

[...]

>  &adsp_pas {
> -	firmware-name = "qcom/sdm845/judyln/adsp.mbn";
> +	firmware-name = "qcom/sdm845/LG/judyln/adsp.mbn";
>  };
>  
>  &cdsp_pas {
> -	firmware-name = "qcom/sdm845/judyln/cdsp.mbn";
> +	firmware-name = "qcom/sdm845/LG/judyln/cdsp.mbn";
>  };
>  
>  &gpu {
>  	zap-shader {
> -		firmware-name = "qcom/sdm845/judyln/a630_zap.mbn";
> +		firmware-name = "qcom/sdm845/LG/judyln/a630_zap.mbn";
>  	};
>  };
>  
> +&ipa {
> +	firmware-name = "qcom/sdm845/LG/judyln/ipa_fws.mbn";
> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> @@ -101,7 +105,7 @@ &mdss_dsi0_out {
>  };
>  
>  &mss_pil {
> -	firmware-name = "qcom/sdm845/judyln/mba.mbn", "qcom/sdm845/judyln/modem.mbn";
> +	firmware-name = "qcom/sdm845/LG/judyln/mba.mbn", "qcom/sdm845/LG/judyln/modem.mbn";

You're changing all of these paths.. have the previous ones ever
been used, e.g. in pmOS, to the best of your knowledge?

Konrad

