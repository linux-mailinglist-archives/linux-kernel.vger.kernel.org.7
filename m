Return-Path: <linux-kernel+bounces-722054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0ABAFD3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABB17B4DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBD2E5B3E;
	Tue,  8 Jul 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aAFhtQBD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCA2E1C74
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994092; cv=none; b=akydWNB0ZXWlspQTuHMIWGUwtxEBTGWibknkMNKzVwPjfGlSk2qrSgQLubIzcm8cQNWkJ46fQZqJ2qa229EkKjwiMlQUCRPTLPmqz/Y9+0Ax1sKE/4wt+ZrHnlDnFy5bvb53J6fTH1I7LSiC6vb7SpROHeLobQcYMxFyy38os5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994092; c=relaxed/simple;
	bh=BqGM5a+qikZv6YmiHyixJJYfugYzxCcrLmI9hiVzEV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKlIuFzvCBxWapyswd8aKqecre7nBH+qUO6IaOChBViHo+poccjjNRNM+u/Nd8n6EmSvn5Ld7KtO8gK2qeciGgQt4B8aavbV1byyt08lGGMYTMVO37N80/ZbBJn63w6Uo917CwlqESITc9kiN9RgxJA+WdgS0xg3ACVyUF4XhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aAFhtQBD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbdC017144
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 17:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9HVP8PLVIqdMkjmRam85PKtQy8lGLeiTlplREZoT/Ww=; b=aAFhtQBDKUUcfX2a
	/vYCH7QPM7P3AEvgGOIRifYHnqWzwbHbUCDCsYi9gOXkc6uLlokrV2nBx8jVPKRI
	6Ge6MRoJzG3KXr54OedZeD2uyenR9fa7aw9u7EJfH35v9Qk1riJEO+FK17+yiUCH
	ZilC79JMnbMcXixLaLY9z8/Rk0Ijz9QV81zFZQ3m4bu4qHQ75LuXwbV5az7KgZAg
	7hgfoAmMLq6uI1sV7x/IjKyMVwJXS1UmtklJElLLaAKsNSyDkxlMC6NluJWOJTrC
	gZVIUts0JWShuoDA5xYfYdZDtoQH+a83Hz+Ed0YWhSnAf2yxzFTkvgu8XG4IBTSk
	m/uiGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkqtse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:01:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09b74dc4bso47935285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994089; x=1752598889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HVP8PLVIqdMkjmRam85PKtQy8lGLeiTlplREZoT/Ww=;
        b=sIkVcjm5tRrEJ08JXjrcdtMoigrBU6B6XBGv8wDspdV6QnEIuyAOU1J5P1wAPPNTDD
         7yFHgN3QKkvkAbRrf6mUzxzXGMfZPXwLW5yfU4c6MC15t5KguSI77Gob94TwHZY/XsX2
         CGBMVx18qZx/q51u2oeEHg/TkvH5tY+xzX5iq+Ow2S7Ce+4qde3fWzhLER1S1FCJc9Ge
         fhbpEhAeKOsvUAa0u9vfMusgZWxsnzL9l5cMWJDX59iYtJuNH77T+lGPn8xia6ak7DfG
         rKSewSUjlD5JqwsfSHWw8NpoPO1Xiyp3LsLseJq59mdYRF40xcmZyzmUZPVOYFrrE/Ci
         M0gA==
X-Forwarded-Encrypted: i=1; AJvYcCWVF2vwlS8PUdJIEPCQYu8pq6m/ccMZO80L7kPrE+NdjTvKirXel65MBaDnsTRVFB1yeVbBVvcYCQgsOgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhg8i9ka+GVVrSbgitDv+G+QeA5p21Vq0ju2ORdJWcLsZjP1Yw
	+kp+VCoHQBvSmLTVDp0iEUfNDsE6gZhJJwoiuwe94Xn2oR8NCuteThpA1VaH2PtXnuUaMziHk0n
	JQOYjMt47ySGdgoTWLoTVQcFYZr63liUhXdf6NpeDPR5tayvozW5BaZuRbjGER032IM4=
X-Gm-Gg: ASbGnctcNCx80hGBZqfLbQ81viV1G9cWlS1DhaPS07VdgmYC+gEcMCj/UcJo9aQ0ZQw
	HeL1I0wI0BkgzzjVm6P7XAEQ2uuao4uoVTkxsmDqV/z2IHDXClmNqn48+/x1ipaWpe7uLWAzOUv
	7WX7vnrjAR36qK8W5QkLG8SwJUmdp8SDwM5vgheTCO+aghAZMzsmcYJUvJIzASNAEzEA2lDi7Hf
	HZTwZ/AS2+GGhKHNfu3PKmutzOLsxiCTkYfc7z67kpgYyZ0rgqEr/s/quesrHoLhAmROWqzOKx2
	W9sukF4z6s5pDBQJx6WSY2O/tv4zPeNJyXcCjvefQN1QQxdbXbsXYjglSwdEte7prcpN3WhhnaZ
	ycAw=
X-Received: by 2002:a05:620a:2606:b0:7d3:c69e:e3b with SMTP id af79cd13be357-7d5ddc9c00fmr724140085a.12.1751994088959;
        Tue, 08 Jul 2025 10:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8VaEIcGVpLYIC9btd5VdZrEByDUcJ1j1cqq4zNRG2aWqvXrcL2ih+rvzNvPZChhbhkCHjA==
X-Received: by 2002:a05:620a:2606:b0:7d3:c69e:e3b with SMTP id af79cd13be357-7d5ddc9c00fmr724137285a.12.1751994088291;
        Tue, 08 Jul 2025 10:01:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fa9b8sm7404785a12.54.2025.07.08.10.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 10:01:27 -0700 (PDT)
Message-ID: <548ce30c-941e-4ddd-9391-2bb5609e26a3@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 19:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: x1e80100: Add videocc
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-x1e-videocc-v1-0-785d393be502@linaro.org>
 <20250701-x1e-videocc-v1-6-785d393be502@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250701-x1e-videocc-v1-6-785d393be502@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NCBTYWx0ZWRfX/TJIneMOUiWW
 T5F7ep5sZSpRD61YuABxrgf85ZoERuODG06XVEWBaxqFuaFi3ecgC7vejTXDTQAM5JXtTUmIqIh
 2MRqdSG9U52tNDdoIWYcWSwWWr/yPkXOQYtDDDIIa/RdFdMhWa9U5nLq8FJFRJF31vpDbQ8V0Hb
 R5F6zHaMonq4otTC6BJQ4bab2EwOj1bt3OLB+Qg4UjmzvIo2FxvKdOy8iROCwgKrfpM6tpfYC2G
 7z43tOejhjzQAww99cgpWBspGsfX4eDWsK/JX3f5BOE6F2JKrMJhXZs0laeRGCceITu4zCrKn4C
 JixOV65TrmJ2DjQwx5Vr0GP4DaKWGgyY3cUImlGEDvTcG86MjSqJVJ6p3E9tMMGN4Q0JFHDtUuq
 k5uirkk8S0YP5AcMHpa1QzoaE0PImVUZFMNMtkLrRNk9JlzXzMmV+H9Wj72xPi9A1Xunnn14
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686d4eea cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=GeF6aowdgphGmeW15skA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZSLVshvNC3LIHSpTkFb3GHCoBUePxf1q
X-Proofpoint-GUID: ZSLVshvNC3LIHSpTkFb3GHCoBUePxf1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080144

On 7/1/25 7:28 PM, Stephan Gerhold wrote:
> Add the video clock controller for X1E80100, similar to sm8550.dtsi. It
> provides the needed clocks/power domains for the iris video codec.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a9a7bb676c6f8ac48a2e443d28efdc8c9b5e52c0..890eaaa40184a18bff54f2d750968112a2546d19 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
> +#include <dt-bindings/clock/qcom,sm8450-videocc.h>
>  #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
>  #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
>  #include <dt-bindings/clock/qcom,x1e80100-gpucc.h>
> @@ -5171,6 +5172,20 @@ usb_1_ss1_dwc3_ss: endpoint {
>  			};
>  		};
>  
> +		videocc: clock-controller@aaf0000 {
> +			compatible = "qcom,x1e80100-videocc";
> +			reg = <0 0x0aaf0000 0 0x10000>;
> +			clocks = <&bi_tcxo_div2>,
> +				 <&gcc GCC_QMIP_VIDEO_VCODEC_AHB_CLK>;

This should be GCC_VIDEO_AHB_CLK, you can refer to it even if
we don't expose it through the clk framework on Linux (it's
enabled through magic writes instead)

Konrad

