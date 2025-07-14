Return-Path: <linux-kernel+bounces-730074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C052B03FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E9616B829
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72042517A5;
	Mon, 14 Jul 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KraOIjuM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38B251793
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499706; cv=none; b=rDUbaVVC8ntePF7uqGIN/Cw4ue3Phpu0e/j9AA6aphkTnCe+q0o9lheSHoczb+QjYqtqGQ+/+LQAp/LuzHAACpkXdKmFpwaBFVtUj4LdhVC1aLDaWPp1esM7RFsfu8jo5Hx6cUYChfwIbDRzg1zvz9xwmlRcGR48HBSiGKgSoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499706; c=relaxed/simple;
	bh=oHEQKwBatWKUIOpL/sm9kI7CU4MvbWDSdi+bybgSb3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUOuH+gvVcLPLFdA4kwc3KvpyUet633qBikU+55KVBc+uhvV2o0CQtpBrI1+W1RN4l7NrMwLnG3LA1wRaWv2R17vH4iIwDr5aLOJWDGB2TmGPNYsOOPxIKByJeyqKUtxuyaydaprP2ZM/X/x9I7+DChayZH55NeAY24KyGwP8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KraOIjuM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E7Qbvd007879
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ob9U6sQ6B7CRRePb9koAuef4V+KwLq5wrBJm+EnY7mw=; b=KraOIjuMYxXVQhaX
	kIZthTVA1UDkARf529A33L3Ay1OXUTbakbPknENdM/vzBHHWr5cqBo/IfPw1Sjha
	acRjGHbUtpZ7Y8ks9h8O0OtODmuuAtzk3beBDqBQBMTJbo//x2ylTASYwks2rvmr
	dYsQlszRZsS2qdfZ88J0cMxzxvGQ96fEiDVWGaf8Q8O1qFY/SdtYaVkCMXWkCSqx
	VRP1ZUSShkQxeKLuKjnzA+K+3oeGZch/Y0WVSHbZqqOBnoztqLmFfh1DPt4VzZ4t
	SW6Eh8+f1yQdfjkfzXvQTnWeSeoUPu6WcZ/EJ+SSayPySP17m9jo9dBMkl+l53MY
	oTI3Ng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vwghh46t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:28:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab7a01c38cso783541cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499702; x=1753104502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob9U6sQ6B7CRRePb9koAuef4V+KwLq5wrBJm+EnY7mw=;
        b=HG9X5Ci2abNJa/t1DDmB9wOimx9jS0Ta9+O69AQmdC4n3YMpwZKvdZktd4iDKOwYJy
         trrscv/9dpZMZhuojYhEAJwiTEDxGVfJa2O2St7qCD9QA4Lr0a6CcT9dZa178CsKiVi0
         lbwoMRpMtbGdXy/ZmNyo2uzz8THqVEH7fW9EYgii4PN2+CvcAfniVsZbvOVz3smso2Nh
         jh0U7vkcmLVxzRBB+MDSdj2NYcQAs1A6u+st4v2VFFHMWNdfL/8ojtBAFtLQs1IzCpDl
         dAEcD4bzHG/1PeDGqzfN/kTDQMLSscaEJK+EdTFayKtR1z8I1ptg2FMfH0kaP+98JAEa
         UIEg==
X-Forwarded-Encrypted: i=1; AJvYcCW4jlThaFWN0CayyUzeRJWzlEDYHlgx6Q61J6t9+Ihrh3LC4/AbHD9Nrm/twoAuW6H9UCgOhXeVnksOy9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRn75hspu/Y9l7G0dCSRj9I4cZGCFPY9nmGSqxCgw29zhHrHS
	ISpYSsnFoKTEmp/EEz1qLstznbqjqgQ2zPXspkzEo7jl2ILvqLXWyDfD9OvjA+ib73JUQFZXrwq
	oGppjV7RXJ05A0MnDlUj89tnkFED1tqqpjaAgItLd+OvbNiwbl6i70j31lXDIluIhnd8=
X-Gm-Gg: ASbGncs/R10HSOBeeGVo8ANls/u0hkf0OQuncESoxa70uhUbID8kK/S4Q6BMrrtURgh
	/Mu6sUs94V9EaIrzDfZmsSHHD5bJ2RBLcPHu+TdkRstilPzySUL+stjE2BCaZPvjmzFtFJY/XWj
	oxXZtAgIij8aVVFoOUJF6+BX5gqE+6pJIgOIPNGu0UTKgyYh7a21rkTYDXJ2VQtKRra5MN3HNNU
	/sTEWBe9oQaS6Hnpwx4UBxG5GhGg5cONJUzOYTcx9DuPreVdb5gM16akS3UfIQJSSh+E4i3eJ6T
	u+HqS6NLHgA1Vhbnh3pI+ecXx5SFYhIhdTbtiEKN2IsMR3EQ1iAfwf4Yk29MhHor8v7hLFtXNP9
	lcU0Zpusdj8VPuhUb3lIJ
X-Received: by 2002:a05:620a:394b:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7ddeb8a4a8cmr654570385a.10.1752499702322;
        Mon, 14 Jul 2025 06:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Im8XF0a7klJdUS69ADOk3tOusKi5hYyzJtkL4/kjokc0qUJhiJ6sJr4jnvb6Fh5hB1siVQ==
X-Received: by 2002:a05:620a:394b:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7ddeb8a4a8cmr654567185a.10.1752499701899;
        Mon, 14 Jul 2025 06:28:21 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a0bsm819346166b.7.2025.07.14.06.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:28:21 -0700 (PDT)
Message-ID: <fc21ee61-188e-42a3-b9f6-4b81a72d388f@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 15:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] arm64: dts: qcom: x1e80100-crd: Add ov08x40 RGB
 sensor on CSIPHY4
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-11-0bc5da82f526@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-11-0bc5da82f526@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbLIQOmC c=1 sm=1 tr=0 ts=687505f7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=qEq-IjhxTDjyFSs2OvYA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: d5u8JBj2rkMRfW0znanDXZhc2u_mB9Uu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3OSBTYWx0ZWRfX2vSxPV89H8rj
 ON1zJPYhlbN9KGTkgCapmOrHawatCKjLTzp9wcjhJTxCq+ot/s6HeJsSkv+JEzwSy67FGxhRYc0
 ApDiLkgCwcxI40FAl5LoqE6bDHhyYwldB0Pd45TwSZ9q8USLNW2g9KI/qTSXpm+tHWlYCsYhKW4
 XIlQHQ/8EZsg5jYW6hXAjoJSPGcctSLYUEGaCNboYB2Y862XaM5A243SiSvPedbvPnzHWvlBWfr
 rA7LdvOOWBcb0STBiN5jCbgv5Z3EDmNkBs5KtddcHZOSIScpJi9kB3mlNV5JMhcLy9wvJ9QKKtp
 TTSaHeP6sv9eFZjy0OryjC0pEfMAtBJIomr71sRksQmLYVEncE2W7//3S4wsSleQ+qi7ZYytC/I
 p+01UxB1U/fzxJ4fr7BMk2JWmN94GMdrR2xheMs6h6AEi51Y6/r94kuBD2hX8i2furLrTp1d
X-Proofpoint-ORIG-GUID: d5u8JBj2rkMRfW0znanDXZhc2u_mB9Uu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140079

On 7/11/25 2:58 PM, Bryan O'Donoghue wrote:
> Define ov08x40 on cci1_i2c1. The RGB sensor appears on the AON CCI pins
> connected to CSIPHY4 in four lane mode.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index 08268f60c305cd69baf937fced6d37f2ea788b62..ace4ab2b9fc0faac8233a40220aafba200ff05d9 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> @@ -996,6 +997,67 @@ &gpu {
>  	status = "okay";
>  };
>  
> +&camss {
> +	status = "okay";
> +
> +	ports {
> +		/*
> +		 * port0 => csiphy0
> +		 * port1 => csiphy1
> +		 * port2 => csiphy2
> +		 * port3 => csiphy4

As I've mentioned in the past, this seems SoC-specific (and perhaps
the csiphyN naming is confusing, as it refers to a lane within the
phy, rather than the index of the instance of a phy..)

Konrad

