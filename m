Return-Path: <linux-kernel+bounces-838629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F661BAFC70
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A04172A25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5362DE715;
	Wed,  1 Oct 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsGcKY/n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE112D949E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309481; cv=none; b=V21hTV0gpJJC9N19hKlkkGVMvo99nY1aKCiAT/UEXjXOa5xn8wSoAwVwRDVy/5vK9ZCgA+V4YBiukhIm5AChcjrnZZ0D6PIysv+bdjFTKUSxl0anO4yep++K02Fn14oO1rfuI2JfpeXF+4fXvHsVQnHnP2bDoNoO69AadrMXeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309481; c=relaxed/simple;
	bh=4S0VnWznaWtdgnfy+s9AoFLLT+aZCxWxxJMZ5f4FHhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRE7rYqvQllQQlj4ykBxYUMRy9E9RDrWk1wdFc/G3+PuAaLubFRk8Yl6xtsFqj9eyBeHwck0nCUYGmJBHEFOa45YkILopQt5xSxJlqxlp6uy7MIqg4wJvgokkBO7g1Qjyc5T5ViwFpapu5LZ2z/UCLCbqKrFa9r80e1kZXEV+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsGcKY/n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918Wj4G009452
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CfNVsHbqOEK6Djc44jlTWFITLsi2qwa8KQYpesfCqo4=; b=fsGcKY/n9ChfDxYE
	sW1NGuwvVgOdEZFxAmIuOIZKXUTjsG3Z2u7lQ/U1fPiotbaUtfEtJl9UmvDCWW+A
	tIk2pcXpnZSgjNTvZP6xl2ozx0H97IVeOug6GXxQCppNhK/StYAxLAj+hQpgiMy+
	44dnQ9koBf+QL4xHVJGKLEadmqQlg8PsZwH6LiUPEjk+nrrze/lusU5rKh98dB+E
	YYD6deXp6JNygXQiucgUfNL2Om9gvADO+yr1P9lV0O10GFz/JDKFJLxKm5XHQDwJ
	0GDxhf+0i9k4MJUWgQCI+xIhuqxdcGIdyCPRawXtMrx04pVUOfrJRWiFyCSMCR4D
	BMY9xg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977urr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:04:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85bb4e88394so4179785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309478; x=1759914278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfNVsHbqOEK6Djc44jlTWFITLsi2qwa8KQYpesfCqo4=;
        b=aTRtkWKtRT8c/h7qQEbEMZU2okKrLvCHgERCdxZPQkoYp/abAq9FuPCQeXXcNn3I18
         at5jaBX9biNmuk2Z462wLbzXvjyKUUmSLgccBYv/KBHq2vyEIDZYChfJpcH+VsiZrzFU
         O9Zdx8nyDlhusKk6TxHRZQlD3Jx5I3zOhrB6fKgiYaLk8lgpg5XeAX5LvJoYp4VGcyQS
         IGkJHMvsT9VDRmGyxk8YQwcFIUW15WwCjuxPTQJF7fRVT48OdBi4yjvR4/ltHnIcGNQx
         asv/aMSf1/vXNYKLveIET264SnmIh+dz+1kSYt7ll3QaInQ3uNczO59QDoEHT+/k35LI
         8YlA==
X-Forwarded-Encrypted: i=1; AJvYcCXa6bm8qPtOQ7gtGdVgZw/2qw/hlfVz1Zl/+7j7NlZAtGppDg7tdnN0mVO2sLEODFL7rS5Qlwx7jQF9g3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeEwjhfn7W7+XIdxtiz0I2+ELlqQSZ/WAM+WzhpDkCUxWafQ7
	TU5eA02AD9Po+991Fw5S+ywn1Vw9LHX9k6e6hq841OtpS86Qib56ZNOpQNxbMTAoJ/V/3EqnjJx
	nD5AWXULEKg+MDkNHOAW7elR6Khe/W1okAeUL7bOkcFHbH0wg7NEWU5tdokc9QVk3+0g=
X-Gm-Gg: ASbGncsM6DAPelB9EQvbN0Oh+97WPRdezaSxpoVQV+oA/88gyCcVWpNE+uQ/HO2601g
	xJ0MxCYG8R5/x92dl9dh1V5jfBaVFQQBe9k8MKFMiMeQODdRLUS8mJmvkyJXTocjbe8LQNSmNsL
	P4riBXRIvYRh8xbPjAbRKXQAV1vzbCqHCeFX2HoyLrzUH5mq3Atym/kjN6RZxSqM+3h54W/Ar6C
	BDMK2JkalCubBRnTB3vc0Z/lq6g+3Ja6UsWgovbHNWSiaMEjg2oWMOSNt20hbHh52EG9dwjgpkj
	vrud7Acqym9QvXaekRG2jS03eryBvdHJnsSOghuHKXqcol2/l6ro1aOS4hzWwz6tMeUmtxxRIKQ
	xdTZl7yAU7Afdg6bwXhp59aPYh+E=
X-Received: by 2002:a05:620a:1a9e:b0:864:1d18:499b with SMTP id af79cd13be357-8737116c812mr242353485a.5.1759309477683;
        Wed, 01 Oct 2025 02:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvUheZabbjOtgcpxEsJAvrgUPd6M+/fvvGGBhC3LzERbkqgTcCF2xkTYlVk3r+qDVu6l8ZEw==
X-Received: by 2002:a05:620a:1a9e:b0:864:1d18:499b with SMTP id af79cd13be357-8737116c812mr242350785a.5.1759309477158;
        Wed, 01 Oct 2025 02:04:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm666298366b.29.2025.10.01.02.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:04:36 -0700 (PDT)
Message-ID: <42463474-7fba-4df3-9dbb-24140581690f@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:04:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] arm64: dts: qcom: sdm845-lg-common: Add camera
 flash
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
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-9-b14cf9e9a928@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928-judyln-dts-v3-9-b14cf9e9a928@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0j09sJS22vChgd0dNtoXE-mAzUXOgz2n
X-Proofpoint-ORIG-GUID: 0j09sJS22vChgd0dNtoXE-mAzUXOgz2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX98xemJUfg6l1
 EerlFq/GdWmwc49a0oBHyoW0fBrZZcll/d8mCE9fUwvTUeBIQqy2j6QS79X4tKYxgKWKw+YzB6I
 KzXYja/5U0LOtz0fHrzONCP27h9NITbZZ7MIQygHsvsyyvGM+mfaG+f8PCUKVqNfL5uxmj96bAn
 bqINGXfQWaLtkDqqlJXQMrtP+rPKwkt4H6Achget8bGPTpzlixZzE85rZ8ZS95Q42quLQV3pFYU
 wrlTQ5+KQY8DYspArYmv6uFWzygg+wdnAn0IHUjgLhHstdxnfLAUkzpv2KJKGS1jF4lqRLbYklG
 ZlOxr7dqocEm6Z624YpSJKYApdm9BGGFahOyk/KErxPtL9DeejwysZ6t3978lQSE9iVhfD36Ia4
 kXPLJLuhhZGxhaEdtDv1/q8ulAWvAQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dceea7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=INp5xvtxXxILuIktMPQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On 9/29/25 7:05 AM, Paul Sajna wrote:
> So it can be used as a flashlight
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index a8c8706f2057d36d5ef4130f11d9ad417f93d575..f309e6ebc075a691c7a522238b4a93ba9e63f3c0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -509,6 +509,19 @@ &pm8998_resin {
>  	status = "okay";
>  };
>  
> +&pmi8998_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <1>;
> +		led-max-microamp = <850000>;
> +		flash-max-microamp = <850000>;

Allowing the same current for flash (brief on/off for night photos)
and LED (flashlight which you normally toggle through quick settings)
sounds no less than suspicious

Konrad

> +		flash-max-timeout-us = <500000>;
> +	};
> +};
> +
>  &pmi8998_lpg {
>  	status = "okay";
>  
> 

