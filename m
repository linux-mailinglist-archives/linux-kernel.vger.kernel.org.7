Return-Path: <linux-kernel+bounces-804437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B075FB476E5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751F71B206FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E527E05A;
	Sat,  6 Sep 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U+erZqKT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6571F2BAB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186790; cv=none; b=RunS8XkXOQugqadblULZ6Fu4GzK1+JZc5OYhn8+gKCLDCD2UXRbFWu18ut3qhYymLZjotpgHstEGUhGaI/bqAs+sg/A/i+t8TxMPl2bvNJu1zzDdsaJv04jTv5eZ0k9kmIICDiM9S0P3RSXmCxUO8CM20Jmwoq1nzyS8fUvnfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186790; c=relaxed/simple;
	bh=IHMOXEjqSixhpDLaICEPJqievMBFyBTpM+jra29ECiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGo77IC3pP8IKHXhraaIKvIMCaiVKHbHXVV6b5cyIow7A7kbhGcHB2y0KFfXYlX4uDr/0O+UEFZDEpPjOaATO9DLRPTDZsAw8O/SPtEiWonUSJIa3BK6wkWygzsIpGNRscDjMrYo8xnyIxGJC8RL3UX+dU4RUma+U6Vh5wEPz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U+erZqKT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586EDJIU025677
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 19:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ILS4/z5vnuC+p1hrEpuyvRN3
	HDybTR9q3aBLGYadh7k=; b=U+erZqKT2rqzlj0pOKK3+a53V6cAIfry+GjyRVnx
	N4HcCVe/OVyAyA06kmOl41E/cFcOcP3tdl7mVcZxkP9C/LdZZ2G+/Knk5cMJ8cz/
	yGq3iANEHMNACQTtm2UnpxwzAA1SjC1odMJdCmmZlrYsD79g3rltndLCcrEr/k6w
	Fv5BH5yHvR/XOkNMSodD9b1A7XUy4p+jnZih+sLwCcrB2nl/gtPh3uIr7Wp3+IPb
	do6yGniJOfGVOxbLKRvWo3DJt0EaHgz+VzkERyyYpNg0iOQ35ypcTlG2BDZSqNkF
	kI3wPFz86GKFZ8QMpgcxilWKfkaN9KZ9qkvcucXrViaXvA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4ks0aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:26:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7222232866aso80859556d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 12:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757186787; x=1757791587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILS4/z5vnuC+p1hrEpuyvRN3HDybTR9q3aBLGYadh7k=;
        b=oO905YMr2yFFZUjsp8jtM3MgGesaphGFPJCHNAmvw+LfPYcx/gH03+bkE0CltmcUCB
         Ric5VlLvyPuYyHP7GrPBBw+h8Y4TvHwzsYcup18kiCzsD5u61md+lV6vfQuru7TS3Mrb
         rq8a7DZ8x/DSxj7BS+6tP8f8MHiNpOU3em3PbSrTsUWcb5ZiebTIiI6c3kqsxooJ9Qps
         ERSWD0n7x7XkCg/wF0E/zBpZ4Bum0VftV6lp4YokSU2cJp0SU2S0k1teXjok59a2YARZ
         PHXzba5gRNNY/63VkiN6ujMI9WOoKO041FhOuumHF+ni5DAfYskL7Yo5eqBbFELvB7ue
         zjNg==
X-Forwarded-Encrypted: i=1; AJvYcCVPwTrSE1XAFJMUR5SeJHAxFvyMq3zej8BpPzR2xwRxsui7Hsw7/8xNFYk5CLWRLbWrLLN4TsmFIibR4Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4II+4x5jnGFqQNc/qxq7nmJMAX09W4Kf2X1dXtbn2zKIUaSb
	XN6ZjjLi7p8LX/FbmupJbU1XRZvRYRWOj2diUZQmFc098BJi2cg3jZnm1aQybS/4084e2kptgpc
	EpWihsNyIIvJTjuUikRwPiYWMzV+GPdsurqs55XS75Owon8x8IVAb5S6fIk5Zw7ooYJs=
X-Gm-Gg: ASbGncsEPsmP/SZOGfY6z4UCGnnF66bs3UQP3awAtmiGxBFUMLK+781KpyqZxgeaeRS
	ZKRMQJBvWqLmsXLImTOfiy7tLcxF9+P41q1Cpuwf6VzpFjUSns8xVjbMU69w1aGMgOm2gQeRwpk
	+5P0N17s7z8UKjc5wnRYP5Q9oL9l5V53tpHnFYu42IhdkSlktWgBYXviZvsSpMYYLUxMZKIW32E
	JW88eDJguXuhe/+jV6Xz+D1R86cVrKQT+uw0x/TYrNIz68UwCh1LU2m3QYJakmzCQr8YvaCI4gt
	HmeUFKgf8hK8K41Cd5U9rRTzZnTOuyVb+US2mcsQyKtDNDEll6V/wCKLGwxX9aMod7mumL11KBc
	tcuqbtKfyQYX+MuDZPLkXKyS17ilXS1B/tW0bjpO04bEKQl+SkTre
X-Received: by 2002:a05:6214:1c0a:b0:729:8394:706f with SMTP id 6a1803df08f44-72bbdceb1ccmr88352326d6.2.1757186787106;
        Sat, 06 Sep 2025 12:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+DslGJnZJAU4p/sCwayK1mvD5P5ektTJ03hT8qtHIEvDCqtPanmGJlv7QtR75Xy66NIJyyA==
X-Received: by 2002:a05:6214:1c0a:b0:729:8394:706f with SMTP id 6a1803df08f44-72bbdceb1ccmr88352106d6.2.1757186786684;
        Sat, 06 Sep 2025 12:26:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad11f25sm2435654e87.115.2025.09.06.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 12:26:25 -0700 (PDT)
Date: Sat, 6 Sep 2025 22:26:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: monaco-evk: Add sound card
Message-ID: <7bzlof2wyqqorhh4xck46wd43zlehm4vhej2oaxajo4dxn5p7p@oc3vikzxcwke>
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <20250905192350.1223812-5-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905192350.1223812-5-umang.chheda@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX0xImPGQgB7Rn
 TCGdB2WwYHjKxWbjmuXgD0aIYEMer7W8IVMF2OGucwXkMx4qT0f2jfPuz4Ca1lbOgX9y6QH9vry
 /b2kWkq1LCqD/sc5KNU/sTg5I2NNTtlc4AK2YmpSl7q1rIgipJfH+/PPuHE+gF1vW8tv2FXn6fs
 YTDVMempEsBS3WHUlfMUdcFSeVzmm5TG2GeF/7TMJSYpjcI9piK2n8zXQbnzzUiH2+01m5KPGlO
 R397q5oDpn3D/e+x2aP5klp8PEjnIu30gwGKKIJWz+t+fHRubei84h9s0Cmpl/tHN2DEoYaxtbi
 3ELt1JEy8GK31sr21bxJ+65FCJRSGYzONTF7L0bP2BRH7Cd6AUIgerTwCgXJBHRwg+ctxMjdWYx
 nRR8hhzt
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bc8ae4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3jghqQMflu6n8rLTHt0A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: jJBp0QD3pw45oZvO36XQvewRTgFA_9So
X-Proofpoint-ORIG-GUID: jJBp0QD3pw45oZvO36XQvewRTgFA_9So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Sat, Sep 06, 2025 at 12:53:50AM +0530, Umang Chheda wrote:
> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> 
> Add the sound card for monaco-evk board and verified playback
> functionality using the max98357a I2S speaker amplifier and I2S
> microphones. The max98357a speaker amplifier is connected via
> High-Speed MI2S HS0 interface, while the microphones utilize the
> Secondary MI2S interface and also enable required pin controller
> gpios for audio.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 52 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi   | 37 ++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> index 93e9e5322a39..f3c5d363921e 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
> 
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> 
>  #include "qcs8300.dtsi"
> @@ -24,6 +25,57 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	dmic: audio-codec-0 {
> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +		num-channels = <1>;
> +	};
> +
> +	max98357a: audio-codec-1 {
> +		compatible = "maxim,max98357a";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	sound {
> +		compatible = "qcom,qcs8275-sndcard";

qcs8300

> +		model = "MONACO-EVK";
> +

-- 
With best wishes
Dmitry

