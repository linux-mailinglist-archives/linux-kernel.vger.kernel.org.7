Return-Path: <linux-kernel+bounces-745491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D794AB11AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF31E7A867A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1702C325B;
	Fri, 25 Jul 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5VQftU6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740341519BC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435064; cv=none; b=PkE3Sczzu4RZ+eatB/IJVwDiunDrieKHe+j+UupE6JCk5Qp6/bHGujlUVc+KCYcm3QlJgAdV5k3KIWq4MDc5T6OPi+BOrjfqoexDdvDpgouR3T6crJ4y5XM3dvZBXnHGRBMwEc2SsWcDy6kdL2ktBwo/gpwmbseQbuiR2aPBNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435064; c=relaxed/simple;
	bh=bOBAINPbtYNFViCYV6WDeBjBQ5bXvQbgtV/iznpIBlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA6GPOS2RBV9pTjYYrc0TefoyV/irFkQWtfKt2XPrVbcemnq82OEYgNZ7JnNxPO16a1wNdV22F2hfl90UEAYHP9q9f0VrNFS24XIBQQcs3M0+PaCyw2cxptKQ3o0MQCp9c6CBMp3Ibl3Kl5oadewfAHi2mO+FA61rmDdsMFfMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5VQftU6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9DaYC015901
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2KMk/UMFV9pj90RnZdgAu+v7lUkWr8SQyyGYLajB+lk=; b=X5VQftU6nL/LgeEB
	oA3ZHJiilg2Cr0XlOhY7uQgCURzZfpw276dpG1LCUQbL7dpSn4v1T063GO7U9M+p
	UfUd4ZI2bsEPrdRn/DdPHScvSoF+5UFzuVr/pyXh6DmO5ww4qvgV+u3KlUQYE7BO
	bQxYlUoa2vizqLIxHqV4dbsS+RnXmiimGOsi74QCy2LKbZ9baAkfGz9sjXy7EN0J
	ICpY1EVYyRx046ZbwH+q6eLxFv5fonAZxqRauIX/nfjGhP/d5lZIsdcgbLZ3IXmq
	4M4Wa/MQ+Y12mOzSx+h088zG9yB6sRdADoZHWkLO7N2GvlzH4NbGRKMWEIZ0X0XM
	HfFswg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501h0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:17:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab716c33cdso7378721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435046; x=1754039846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KMk/UMFV9pj90RnZdgAu+v7lUkWr8SQyyGYLajB+lk=;
        b=kRcoTplb0LP+wX48Mk/Yvlbj/FFFpW1EbVMXfZiDqD48swBqwlfAN6Pm1NtWGanYgF
         Gq0NHykMWIaOVxICI+dpZFvKqM48ewuupYgoe6/L4S5wuGOQzPqsysEceT0BS1q/QEoa
         gmjea8Gq1reQNdzSo+R0clrtBNeKJnEjqrQTGoJbGtjiFyRMRgzdIfB6a1x8+V9fLCXj
         Db27gOOppmFvL7rIdla/42F2v3mbi57590epnyA4UhmuzmzuquYrnydQMjM2S0w1YqXt
         ToCkrp45mfoDK6CyjxhVBByHcYtUS7N+kR8I4BrUECJFbLFuBPCtLoNx8lUSfQmuAaRf
         9dYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXON7e7qXP5U6ze4I2zPfs7HSLtgw7gBXAeFKACzmOFP2pEzRGnqoEKKdK0bZ9JFlHLBqqqBg8Ps5BZq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkCtjYYQhZDJyOOdiRdSlZ/XVj+h1uadgKWoWQAs5g+rivcU8
	Gm6Q/6VPnswhbTSD0H1avX9DVAvbEEh5s5JHsTJonLTDtV26V/rQMmxJopcjM+kgFCfOt2KLlMi
	qNq27Ufwn3hvLXtFHPGl2KPDpbl7SR8aYIWh4bQtnWcnY0O/215ZxupJgDqX+zNi2X2I=
X-Gm-Gg: ASbGnctBnZnrDrAvHglqa1KlJQYv3b3R05P3ERv9eaj62hen3jIswtCxm5k5uIDecpo
	+zaFxdudb0EKZj4z2WeNJ+O8NZpzSskZ78PzyvgUlkeql5EosifBEOtmpWPBhK0TZ6NJ60ge56F
	gsUZgfzvqSfhXT8JW6c3+7aChLyaeVxgI1T+pijQLoMsROtIYnGZMLhvjF8Eiq+JEr+LDZJmraq
	HQBpGor0uUsXsq/Ef30Q5b85q2hILIF1PthkuXo2xr3en/z2cixbNrPczd1hzZpzLkZUW+bUxwg
	I+nCoSszHfz0AYXjyTcMRbF8e5EaS4vz50Pg30cwJoRrsyPRPYWS23yVWnjvVA6Fuv85q9ZwBw+
	QceRLAbV0xUekfjIi/Q==
X-Received: by 2002:ac8:5e0a:0:b0:4ab:7daa:d84d with SMTP id d75a77b69052e-4ae8f05f1d6mr5130391cf.14.1753435046012;
        Fri, 25 Jul 2025 02:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv5/tQIemrC+cdKCLUc8nfT6WzE6Q7lvlNrkKLdqn3e6ZiyHMyr+3x/nQjJZgEZbx5Og6OjQ==
X-Received: by 2002:ac8:5e0a:0:b0:4ab:7daa:d84d with SMTP id d75a77b69052e-4ae8f05f1d6mr5130201cf.14.1753435045492;
        Fri, 25 Jul 2025 02:17:25 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42c2fsm234902166b.131.2025.07.25.02.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:17:24 -0700 (PDT)
Message-ID: <452c6a6a-3d65-4712-a105-386d8540f2ff@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs9075-evk: Add sound card
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250724155632.236675-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724155632.236675-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ptiOk87J4sG8yua7Mvp_RnpxtzKwy_-N
X-Proofpoint-ORIG-GUID: ptiOk87J4sG8yua7Mvp_RnpxtzKwy_-N
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=68834bb6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RUmmF2Cuiqa3jFE6LK0A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3OCBTYWx0ZWRfXwOkgKJqcoOjN
 Hf3zXerADmmnt6pRsBXvg3sPxp46XiLtJ4H16j7+oXkX6dzMQAb7/fpd0dOLZPhLW/AswkRYC9s
 gtJS0DSu2oOXuhKxNfSed+rNt0be1XW8cn6GkjL+MGg2yLDIeAsy88c+xHlU1q7bwkKhLQ/HQQf
 iBuYdJgp/A+Tqa0Lk0taeIDTeITHOaTHzugDdu2paksJlO3iJ7OMXkuHHoKlgDWCnap8P5o3q8J
 /mtTyPu9J9uIrtA4KQnv7cLuDLpjNEkwc1ZGnCJEieOjv3KcpAVICMBzbnGKI0clzz2SmUeovMo
 0wgEiwYvScGK/gNNdrxGHEm8jBlUGn0e5wKkz9rY8+HMwnjwA1HwzoybMQ3barcb1/7PR3HUCF3
 f7hUz8xY49NmXtb+K8l6hEGDz30R28CXr0x9/lJYGXyNtIcngUUGvLxxkAxe9Pnmpmz3hSy/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250078

On 7/24/25 5:56 PM, Mohammad Rafi Shaik wrote:
> Add the sound card node with tested playback over max98357a
> I2S speakers amplifier and I2S mic.
> 
> Introduce HS (High-Speed) MI2S pin control support.
> The I2S max98357a speaker amplifier is connected via HS0 and I2S
> microphones utilize the HS2 interface.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  .../boot/dts/qcom/qcs9075-iq-9075-evk.dts     | 52 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 14 +++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> index ba8a359d8fee..a2d9aaa641a1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> @@ -5,6 +5,7 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "qcs9075-som.dtsi"
> @@ -20,6 +21,57 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	dmic: audio-codec-1 {
> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +		num-channels = <1>;
> +	};
> +
> +	max98357a: audio-codec-0 {

It would make more sense if audio-codec-0 came before audio-codec-1

Konrad

