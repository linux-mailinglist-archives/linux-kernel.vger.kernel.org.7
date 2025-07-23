Return-Path: <linux-kernel+bounces-742590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867DFB0F41C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553945668D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9F2E8DED;
	Wed, 23 Jul 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQUR6D7s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9F2E8884
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277645; cv=none; b=o1pCxHaF6l6ZgSuWBWPU2A0v+H/xOlBhM3/Y/3nM72QOS8OhlhOqD405c1Ygf/2fsOrP7kqxfITQm7Fk/6fqJHA5Cm8IC3KN5N4Y/agVjpkTnYB157OJ6ppDBtCvQkJ/IeiUvdpDdRuimMhC36MaN+XFddj5bqu+WxfLvF3aaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277645; c=relaxed/simple;
	bh=I/HwupANQZNrDN72YfoYISTR/jnhtFvcCce7OTyzEPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nSwsXrs7rJlxRmjT4H60pbVhJoifHVnI2xrENem/s9Z1s1Q9UZKrzaNOZrXqemQOCEtleRoDkqlNNMYuBg66cb+QWfYoKN2tzCrna5wMIsGEEf0Dg/8vev3Jy1JgRSh6qwSkTdM5kRsIJEErIYnvonYrn91LuVBUdn6xN/CWk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQUR6D7s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9AMg5001970
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cErycuEc1BPG/yLEfc2IRSm6016iTOA8t+hzUspH65U=; b=QQUR6D7sbLdLbO7d
	yk0ql2PNHiYYPDXcKRtlvJXdUeyMAX3dfjIr6QyFopjtEXCHWPxIDnXR5/PG3mPi
	5Se8D9MZ4f6/CRj8oe2kwsJCm2aqBIzXcdwcc2Xxyyc78f+1DHRFfmKJvE+uBHAG
	4gSa6iBRSdidOG3jn8QLG6w6DtK9dRGg7Ey92LLo1V5kwUnOgdSXDVRzGU3UL/cJ
	PpaVEhWllGgwv7d5V0tJLBkuv6UIDh2k3QBC0bM+1i5ZK2LYp35khqrADTVs24w4
	ules2YRfLEqpH4phg8zWziSpbgKWdnXSCnqmlD9x2HWepMHdeAkbMiFDOQX7T/Me
	kJNbjQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w6e3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:34:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4abc1e8bd11so16003281cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277641; x=1753882441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cErycuEc1BPG/yLEfc2IRSm6016iTOA8t+hzUspH65U=;
        b=iiDKoKo2LYMmoScYJDYOF5jiEwmK5iYlt3FFdHSRdeMQgoYQLx4B9P7xMDu6on9o8u
         iMaBsro3NcrwaJDC/I5iigyrqbw1pn2t/QPzgOCUILUf91+fAI3UZmTfTBp7tdHhiczG
         LwLvMl3w0ODDZALGwqy6SPDJAyupzSyOB4xDsEkKxUXMjDLQPYoA96JX2Z7Ntwqj7WHC
         aAFqCmtBsDxOmpfp52XoBqun/ehdv9gukc8GkECmKfaCC/Y3jTI17pY4BYxNVaNoM9+J
         uJcWD++z+YsMHfmiqvFBYaEaP7N0sd7Cf75rFKG80k3aJXV+EOOsc7vAaJLAeju/UQgd
         ccUw==
X-Forwarded-Encrypted: i=1; AJvYcCVsB3GW+nIIX5qbdllF3YIUjbs6exIoaGsWW5TmJA7tACV1iq6xqUNSCJ/UEFsZ3L1QTluJOTy7qlVB38w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVtnSy0+yQqRbuFjXjHpU3DW092XngWT16dtzua8Eb8dNjIpn
	moAHFc1A+QnOQpCjMWkKh/aZ8u/A+Ro9SjcEHU8FucmvRInn2QiJY4C1xgx0iVccAfA8Jz6aSgU
	961JsS9lBkpl7vrInf+O0o/Q5Zuh281ccskwK2y248LxnfwPzXldiBRUYwx2MjvK+ceI=
X-Gm-Gg: ASbGncs6ozy3KXHTNYicHdLnywirtJ3zyAXkDZZN4A29NWFbafOnoVNzOHHUw6mxe8m
	QuvfaXgElIJDcgjh/987QY3NmFsrlmi8T1ns5OKXp7cHH+rPQN+2m+TzcasfV9WWKkBokWMSbSz
	VD7eEQt/mgaJ/WTkavIYwMODQo4HyyHLqdP7HBPAZCvlVYogoXO15fRVogR9VvrzmEKrzYYC4pM
	0avXIQRK9uH20pE3kzIJE/LA+gMSoT8gjbc681JZuDvC+nMz5SliZ2wm6gstFBidcuvtEve3N3R
	TFfT+9l/8A+qvONbX4Coavk0XIinZF1aeXADHGKeAMBMu0ydhrpZK3r5xzPGUrGF4i8WDiVf0mo
	Jc6a0rrUT8+Cp8h0v2A==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124749385a.13.1753277641273;
        Wed, 23 Jul 2025 06:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYMNLS1GUA8u7+fQK+6rKxw7iDDU93TXDtPnP5+2dDFuZKetwr7kiUpYLhhOQk9KpRqg1Eg==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124746785a.13.1753277640829;
        Wed, 23 Jul 2025 06:34:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af244a659a4sm236451266b.22.2025.07.23.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:34:00 -0700 (PDT)
Message-ID: <277971b8-09d5-444d-b0eb-1e658b68029f@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
 <20250723110815.2865403-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723110815.2865403-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6880e4ca cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=R0CBZZInQid6lz33ABQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX+OJ/W6urb3Tj
 mlJbpbX2sGilurEuGZ0s36dYu9RMCnzCoejP3mdlBPtKQiaPzXjd5cKewCZlIx90I8nc26IgYv9
 a2nlbDhwa8ESGvcw02rv00Y8RwCXJxyjXib66YiZ2VWGaREGxtUjfTZMNLDHJgF8X+C8LB7hD4J
 LLBg5la6RFo+0TnkKUTDNzOhVl7asT8Tpy+UnWJ170k3lh/zAaeEv3QPsnzy28Xgn3TLpX/tLWv
 WfORJ3F9NugPtmlVtty/Pr11VIAbTjst7jNX9n30lwnVxx6KfO2Gpa1rTmXc2UVaE9Ycu+wg2p6
 Tr+lPcuHqskCYQ2BvOumJAHRbgVQPT0FauKcXroqhjDcsByIqY2oLEk5nKyt8OZ/EnEwkGibV46
 XuUEB4yOqG1O/pZ2BTC6Wa/3kZPkAnz2+caMciSnBF18IdY7stpOC8DsIH/kLC5M5PhwXPlb
X-Proofpoint-ORIG-GUID: gSufl8EhO5LDKMGAFaFDMMtLa5HxE8dU
X-Proofpoint-GUID: gSufl8EhO5LDKMGAFaFDMMtLa5HxE8dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230116

On 7/23/25 1:08 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related entries, fix dt-bindings errors ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add 'interconnects' to cpu nodes
>     Add 'opp-peak-kBps' to opp table
>     Add '#interconnect-cells' to apss_clk
>     Remove unnecessary comment
>     Fix dt-binding-errors in qfprom node
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 65 +++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 2eea8a078595..39d394f49789 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>  #include <dt-bindings/clock/qcom,ipq5424-cmn-pll.h>
>  #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
> @@ -52,6 +53,12 @@ cpu0: cpu@0 {
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2_0>;
> +			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
> +				 <&apss_clk L3_CORE_CLK>;

You exposed the latter clock through the interconnect framework. Now,
every set_rate/set_bw call will be fighting for whoever completes first.

Konrad

