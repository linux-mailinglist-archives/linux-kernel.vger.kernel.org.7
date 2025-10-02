Return-Path: <linux-kernel+bounces-840088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB4BB37FD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006CD3A44A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079D3002AD;
	Thu,  2 Oct 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIUaFGut"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE442F1FCA
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398033; cv=none; b=eRuVCOY2Wpre2hUj4+nRScs9U7xbGxFji9BI8wsl3XMQor0LsBfv48XldEHrs8cUSAexenpwOK3KPEATmNOQIZB+R+JW9La/bIfEY+Q97XAIQr8rFPY3c+OuDwnhr7xA2udEkJhQFgwzV1jIULxyMt964zvUQ7aOghfR78IES8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398033; c=relaxed/simple;
	bh=p4GlG0i2Y081h5gfnx5qiqD7ASzyquWjITj8IlfhFC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQkdAJWMVS8sSPY6WbCNd2VOXAPN69A3CAmyl9aXmBmRTpu9kcJSvK/ykIhW0/bhBbt3lR3D8mG4djp1vtiK1mE1TRf59QdomgATESYZcskFUIgeFbP/qFVAyYNu1E+YxarO11l7vjkIIy6k+GBgpJyUPszU/+aaP4t6iBF5C7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIUaFGut; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5925kIaE007823
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 09:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dcrL4l9U3YzpWDGoNd9/zApd17e8vxY/gbnZPfARZlA=; b=oIUaFGutMZn3s4S8
	1ja7n2cTs6iP3ki4RSoP5ilYYn3moafCWfV/AO3gs+co+MZKNTEvsmXmvj1kE/S7
	jJihhFJMMYQYIUgttITzGVMGXkr6jJWXSrGcpCE2n5hkpGUj4CTvQ63MJLnPe77h
	EUDXwJ2PKab5xU2r3lVpSG5sO2+NnAyBXwCnJ7kPusPHHOUOwnZ/CuNwhYhkYtdj
	hgOdqGIFmghRImLB2/bnqSPanqfi4HZhhuHm75DnQBV8AAcxVEOyuXkm3Dn1cG8F
	eOYuxpplMfAIWK0Lh6QFBShObluttJCVeuR7kTEKeTL6TEB2rhk8afceGluJitUT
	Jj1mDg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh0hx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:40:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-84fb3e80002so2108906d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759398030; x=1760002830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcrL4l9U3YzpWDGoNd9/zApd17e8vxY/gbnZPfARZlA=;
        b=soxgIFx0UxPK+Hl/u282k/SVOESOzVDv43wpqn4IP6bAE0Q9iTwEWfUkhO2LvF19ms
         Zn9/moyN6mIAohshWKDlHQO74W9DA+AWQugDWlu+8B1bzCqnDVtD3vNujpKAxAh3FeTj
         yaLQDj3SrFzgQ9G/3SRt/QssD700x29/YMAfputWphXIUP1h86bwHMemX6+CF99gYdmX
         JCyocGeZ+nc0mxTzY0BkKn86jE8q25kOix4c44n0tNvYzUr0OliuuLfPxC7vgGL+zv38
         kT7tdqvZurK0SdQhXwkMM3yldwgWppRVeqUjY4wcSKo603wNo5Rpzc47hKgeKKKAPIlk
         AnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ77Hu2Uq241+3l5JNehdMjEtxVGskpBqNLwa1lVc3pXpaXCCjcynWCLHE3MiIXwFIHalK5cgFl0puJAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbsnaxsZnUSsISznQQAtzCRyb6oU7/zVICCNsSV21kU+2GvR/
	tqSHOGjkwNGchLiT5tmyAuvZam/VX6PZQ+DhHSnrlYMznJjCGbPncMUIqNtdsAcIDy/7972S2rt
	Eqf5Llfgvfzru0EiMerEOt801hwvgctTeK7WsXDe7FspP8b5GF3aE8ZNo1+Klf2t7abo=
X-Gm-Gg: ASbGncsI9aXfw8WABRcA5TVRRA4pFRNAEdYQUHPf10ZHOyMlu/qMXPfpvDn/WMWnk4G
	21neLwtBL/NUP4rTxVOQvp2nlIoJiNdsAKlQ+91bIMU6ajq71GzBXzBiUEtScouMdekbzeHHQSq
	Ai+XyvTHhQ9B3ys8iIXKskAwHSMDKB9cEkEmOObSD4aHGjVXIouuUAFVcvjnHzMNAhYl1BTMePm
	6Ie7R7SQneRFpfhVqnT5LKJEP5heuakRayR0fgGmQe9ZcBFat2lRPahC3Zmyk/WE4axiuU+e4e8
	3aWsup1XmlKe7Yp27mWTNcyyuAqjUXRFbPp+6gXvJh3VJyoY/qjWu9eSD+sYibltTsqQTPIdYW0
	QtnIG7+32Ufu/TyPhC/cxiAkfchM=
X-Received: by 2002:ad4:5ec8:0:b0:7a0:a767:a178 with SMTP id 6a1803df08f44-8738f502fbdmr66516866d6.0.1759398029980;
        Thu, 02 Oct 2025 02:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVXxbuADxsDG4M6Oq6bh+r8gRFAtX4iygac+XXhWKQ9H3f8VHZAfJ8X66Hn5JI6RTnHcgGiA==
X-Received: by 2002:ad4:5ec8:0:b0:7a0:a767:a178 with SMTP id 6a1803df08f44-8738f502fbdmr66516706d6.0.1759398029297;
        Thu, 02 Oct 2025 02:40:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3aa9e4sm1513886a12.7.2025.10.02.02.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 02:40:28 -0700 (PDT)
Message-ID: <f212ddf6-9bb8-4222-b3ab-58d493f0aded@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: gcc-x1e80100: Add missing USB4
 clocks/resets
To: kernel test robot <lkp@intel.com>, Konrad Dybcio
 <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250926-topic-hamoa_gcc_usb4-v1-2-25cad1700829@oss.qualcomm.com>
 <202509272140.wYFpHZfD-lkp@intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <202509272140.wYFpHZfD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _0mUBVQkk6kUde9-SElMfndMo83fauQp
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68de488e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=lGh6S24CkXRaUtfctWAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX4YNz/qXk6aRX
 vCBhWf7/C+bkwUBoJxgYScbeCexJPmlVsfn57HsP063KawCuFhT2M3AB/si/UQT3JAl0CqYc9+E
 btFo+mHRqx5ROWVvbA8TkhtzsmYAMcB1/D02NppY9rx6e7gOz8oymxzRljB3egtzmDG9b/Fmt83
 AvlEWr/yd7SQg+3aZZjNjeyWwKNDENwz1nuCtACJRIekrv5+xnPEayx0WzNPg+lQUiDB9N8hcQs
 uUThDLvxiNNyVXWJL5qUlcgb8vcQmeri20OEREiLbZn6u3bFZjJm3p97tFijxJ7k1JcMEFsh45D
 Af6go2fHozBxICrN4TF6mmdIyv67HRq1fZaszHnpa0LBxxNChqnwW8msCvOCvgt9wkZNdxSxVyJ
 ncZw3upEx2FQ8hhujd+rP5sLfZLdww==
X-Proofpoint-ORIG-GUID: _0mUBVQkk6kUde9-SElMfndMo83fauQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

On 9/27/25 4:01 PM, kernel test robot wrote:
> Hi Konrad,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/dt-bindings-clock-qcom-x1e80100-gcc-Add-missing-USB4-clocks-resets/20250926-200520
> base:   8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> patch link:    https://lore.kernel.org/r/20250926-topic-hamoa_gcc_usb4-v1-2-25cad1700829%40oss.qualcomm.com
> patch subject: [PATCH 2/3] clk: qcom: gcc-x1e80100: Add missing USB4 clocks/resets
> config: riscv-randconfig-002-20250927 (https://download.01.org/0day-ci/archive/20250927/202509272140.wYFpHZfD-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509272140.wYFpHZfD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509272140.wYFpHZfD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/clk/qcom/gcc-x1e80100.c:580:32: warning: 'gcc_parent_map_33' defined but not used [-Wunused-const-variable=]
>      580 | static const struct parent_map gcc_parent_map_33[] = {

I initially used a different magic clock struct, but the current
clk_regmap_phy_mux doesn't need it. I'll resend with that fixed.

Konrad


