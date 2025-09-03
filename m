Return-Path: <linux-kernel+bounces-798476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED9B41E88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D60543834
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF02E54D3;
	Wed,  3 Sep 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPpkCtGv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11051258CE7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901650; cv=none; b=qa7FehK9JL3RBI/Hh3syDfZYS1hNyvPKiABI5ckUHMuv8nNHsyGBbRHz7JPHHUbMXXI4oBHSVWw6JXwbUlVcpVzoijPQu3Wb8qBdG8GnMG5uFWpL1SKaLtLAtmPxiae90AnqIkveqDCjP8726yYRbJZTvFEeorh7bx43PdWz/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901650; c=relaxed/simple;
	bh=YtdeGZI55ezZBf39MWpOqIeT6GYRAKuljv26BqkGc7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpj6ab8CmLhfWtrYHOHLRE8pihAoMc21zXu7Jq/tSoemj+/OglRvXfFpQUCA39ysQxS7XiMbvu0XyzZkR83m5V5pJ6PWUrdjAHzWOXribWhJtqykY4opBsgd5uml0p4tng/ee/jGbHhiJq9y+oNBc58ngIYtFVYq2yAlQZvvBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GPpkCtGv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF3PM004538
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYhvAJ2yDxm3t5+1Vvt6nPPA+d/qBvKI0quyH0NlUv8=; b=GPpkCtGvFf4WhW26
	DOSF5KBPJ5mHMVBI/Pz//GRCVwmx61XgZaeJdw5eV37KinrrC9tLv0VYKMa/ipk3
	shmJKCXiY6ifnSGBHmqEqSLTsPlfSAp2kGWokxxdzsliCjpX+Hm0IHTwPDlRlAIT
	zXP8Mghrha7u4zOaR4AgutS+zvONlmrTvEQl//53juhGaojE5l9YEz2aKuHc3fYE
	dz9j+rTewSEHxAcFLWruPWYdzfFCb8jfp89f+3TYerQwkM+hhT2ymJMLGYybBYNY
	F13yHMYAbtnlWrd6C/CV0kJU26RedSAkaGjYVG4sXWQyp1+kf0paEe33kU2xV+Rp
	ALjhIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbrbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:14:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10991e9c3so11568651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901647; x=1757506447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYhvAJ2yDxm3t5+1Vvt6nPPA+d/qBvKI0quyH0NlUv8=;
        b=Ps2EtH5bYGmGIBe+eQFcyzQyDHeIW4HFeqt+RzXAmonM38wUWWKCnmhLmYHv13zcd/
         8/pVCl7cZeTx9xdH5PrULZAKHF+kqD6zYUrWxOuxmUF5DrxW+USCmdWZodWECVtE+8Do
         OEE+V/8wyqz2wZik47zYeoTwCRnVYrGjRwifPuXOYjbR6e2hM06A9gA+OetgRXCGDSU2
         hCjwc2sc6MXxA2tfdEwxhqJab3Q0UDiQWbJnKglWf0ZTMfx1CiKzCs8+mquLTkEgNohr
         hkfu/RCLd/+nlsDb79j9FuD4cs/nT0jrg2Qa8Kab7+o+H0uipV6tl3sFxIKBmnW2zQ5y
         QVKw==
X-Forwarded-Encrypted: i=1; AJvYcCUubLhaVf3d8lHOih5vwyFpp+JMqPdNu19Xpma6skm+hpbzSJqsNlV5njt5wNnY/N9+IM+BK1dyvpNq2fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+ZEtuJSfVyLSzNVDs3KG7VSQpJIbfVMviu6yrb3OFhlVggy0
	DVoWv2yk6y8R3GOnEkAo6Kg3Xnw38dyfvO3nRP6CO0Xo/EK9B+eSO+/IxIJ5WdtZe3RbKRzVCBA
	PEAL2o/myV8WCEtAbTmVIbj+xwoGAf0W7+9zy6Gff4cj8fROPuHgLFLajuQ6hEZlOdHg=
X-Gm-Gg: ASbGncvjQBm2jtKnWqnaaOZ5pUsj9toZo3mZspo2rvdmEOOHGpgwihkPQAl1tK3MwXA
	kR4ISdvkOL+mJhC70YsbdY/pfHvkSs1Yzhr/KBMEWjwH48/ggwVpt15RUcSp8axHGjc42+s+j7c
	q9fH2G0oMiIndu+fLx3cV8wjWT2UoiO+vy6xHNIuvyL0ZmWnCkyXvIuiB87Q17REVJ/ZjmZSgw5
	UjqFBBHNxi3VNAH+ijbcktS2puztp5g7pP7vte63lhAk3UmHkSakHRLYou8SUevIEhMJvP0MWy8
	QYn5YAAM1Y9qQqMFt9qdL5I0IGSlbVkC7foF3aSzkrzKoBF0BhzrlVGGqW/awG1dTfL9z+IFDF/
	jcwzeM6CvV6VHjrA5HLCF2w==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr146879571cf.2.1756901646984;
        Wed, 03 Sep 2025 05:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfxXAgSIGzsPwmW+MlQE0V1gR8/fJuy34NZIUCYx2HrmLlKlVIYnJUO6aP913FkYg4ai5C6Q==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr146879081cf.2.1756901646361;
        Wed, 03 Sep 2025 05:14:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0426516668sm777114966b.46.2025.09.03.05.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:14:05 -0700 (PDT)
Message-ID: <1df90473-551a-4c1b-9a51-af4a6fff1bb5@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: lemans-evk: Add sound card
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250822131902.1848802-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822131902.1848802-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CYVNy50W6LawqEsm5mOWA7bBB181pN5n
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b8310f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=M_mJTPNyHkIBEOdhXoAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: CYVNy50W6LawqEsm5mOWA7bBB181pN5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXwZShfaExRPfy
 TXCmYf8feC5o+zfq7wjTukxT30NMJL6XRpts04iKJYSvv0kMKXdoNno7q1T7FHCSMIeKmJpwoBm
 zblfTXGBD3PtuJF+lU3pEOW8XjEFc8DxolYt22vwDG36wU8ZsTBu8hfXXYAGniy2wyKp2Ak7Ux9
 OjyWUcLNje1WprwXdi3bg9kLIJWYd7BHlH2/ol9kdGmebTgPJFh4ahYPhCdNFcglCJT2O3wSC4b
 kVYd3kJ17Qz3viN5CbZ9rb7SB5iF6VFVfvksc8d3UyxgfY6vRKxxg/udvlWqFNwp7o22TqETMD0
 zzaBmIFm8GPNh9aJPnCNyrecrsMUgpA0PqgZ2Mo0WenHSPU8RQHbgMjJSqcFRM0AK3IkFz2f+id
 rftf7MC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 8/22/25 3:19 PM, Mohammad Rafi Shaik wrote:
> Add the sound card node with tested playback over max98357a
> I2S speakers amplifier and I2S mic.
> 
> Introduce HS (High-Speed) MI2S pin control support.
> The I2S max98357a speaker amplifier is connected via HS0 and I2S
> microphones utilize the HS2 interface.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 669ac52f4cf6..d67a9307cc75 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "lemans.dtsi"
> @@ -22,6 +23,57 @@ aliases {
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

In case anyone's interested, this the SD_MODE pin is connected to the
power supply (i.e. it's always on)

Konrad

