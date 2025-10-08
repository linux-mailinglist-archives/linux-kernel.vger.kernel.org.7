Return-Path: <linux-kernel+bounces-845429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FEBC4E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89CCF351DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369F2517AF;
	Wed,  8 Oct 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hBd04cJg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7043248F77
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927244; cv=none; b=LsZIw29qCoZX4RwVMHHxvoaDwjQv08z8QbLrP3Kt/9fWE93ny5jqPCkrV+FRdIozPljWfQl80NHs2RHrNs+QIMQQ1HR9k1jqQWehV5IEo7QQw6Ybs8plxWGUjIZcaNsIuIzqxWxirfAThmnL3WO9WiRLRHcbIP2UW7XxnkmVEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927244; c=relaxed/simple;
	bh=lUTrOhjHPJyQD1MhnOgcyFKqj4kxP0ZYD9sQND0DSt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qteryIQDCBkh1Fai0PofIWkIiUM3wEAQ225XpXmWjj6pqYhcNtATh/H43gUwxIz70rWbge9Dswe4CIWsKGIgQBWZU1TOkTfD9VM66pMGQhoB+QtzeHHV+cMB8Wk22pmMT2+d53wB8mjNbgzZQJ+0A4OgAWwkMo2fooagXR88zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hBd04cJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Sh2009627
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4OPP5rGtbcoGt2hmvhc+u4aKUyzxDw05x/alaaMMrU=; b=hBd04cJgCs6FMEwT
	SLJv6hQIebpXckG7rSWR5WFqC0HAU3YzOqpBfUqFEbgMvU3Xc06MuQzjHrLsqdwt
	h8Ne8CmeNfpDQcCFgxPdgr9088KLmQcUJ6WknNvlJeMX/WPbctqMXCS4uJPYAI55
	2sta4654l/LibwERamb75M6AUI26ZJgtDStfAFLJF52818MNZxQIpzcnGlK0ye7T
	4UDigkvXMMEymCQfW8bOWuyTcJ0nExA3Vj3Q2l1d74UpiSK5uBihcP/VVfRrfmRD
	gq4Ky1onVbv6UtGwEYtK9uFvTQzRF24dfgGA+07skz++WYq/NeKviK0zVWpgy3Es
	QNDw5A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junuah1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:40:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7abea94d621so17294336d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927241; x=1760532041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4OPP5rGtbcoGt2hmvhc+u4aKUyzxDw05x/alaaMMrU=;
        b=lWLMpCF1diJI3WEiWsDJMROILAxoR/+NiFqfAir4XzSjS+kN0qvhi3ySw8YJ9CR0wi
         w59Y4FvpUE9UFpRu5bY/KF6vkbcoV69mQCyFtSOiVDWU3C+GKCMW6v2v5Q2gpP1/KxQJ
         swdkft18OvceGSV9ZBWYgcFeMby9BXYciKLpnm6daR0cc3PZ9vaIMNsYmxecwOKwTwQ0
         QzwtAk1IcXlNzJPkJQn/lSOQnEScWY4BZ5v8e1ZbCIT5Tv5U+SzHgohgDilIw6TjWCh0
         HNxO7bINiAnnN8RD3YTyBITSH6f+2iELkVPAVdRnqXjl7x2OyjuYXgFMgXxHtn7UksRr
         lWBA==
X-Forwarded-Encrypted: i=1; AJvYcCXRY1e0ww7qoVobpj5nAS7JmRFKIwmSHPLUasVJbJllesnn+JahG+lmc0g4ba1XCvtnOCxJMhHu0qRJAxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuYXUxBryIjA8f9bXe0BxOgXtPHBodxzVy1HRv3kSvpQq+iSj
	HuhMI2Lqen68LkI5rQ5MZOhHjnndFdqlDQXyPfsRFHSHuW93Rw9bMPVJvlAS2tpHJdXJA4Y6wfe
	0mLEnNKNXvJxyq/gvDLWyCp7/uPkSaaTfdGqy1mpqkQMuiohGcQq+JxIemuCwR4vY3EM=
X-Gm-Gg: ASbGncu/d0PptjQs/I6GDFrG7lOmIfACV9YO6YdTaiPjbRLYdO/Me/m/Zn4goFXSSTE
	x1BjrD1L/D+QSuTY4nndAalIML3o40Mk3FfUi4NQ3OBoNez9dn595EXndEe/JdxEj6P1I6UGrOz
	XvAibl5YA7Mh/C97h+Lzq3e3ulHPLsjNhIFdZfgsYfUsAkAA/YwE5YwLrP6Wa9Gy8roMchdSSLX
	akU7QOBIF1/we+sEBIEGjwv2zwQgnqwQiq9GUODLkHhGyQujDZOuKpXjJ+I1mGh7lPQRfBY41A9
	5lPirokVRNJiGbG3KfEk02Z2kqJbPo82UBQKK2pwHaBwB8/QwH4fCSSO4x3y7o/tFDo4DU2oZXI
	mW42jc12vq9mtjcLtOzbvT/7F0ww=
X-Received: by 2002:ad4:596a:0:b0:784:4f84:22f9 with SMTP id 6a1803df08f44-87b2ef94002mr25131156d6.7.1759927240884;
        Wed, 08 Oct 2025 05:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3QYIdes0zzXDXLbtN1GZArLUcJtOk9G7EMYv269Ezp7bFtd3e0tnh7OnfT4Sdj7S94CaghQ==
X-Received: by 2002:ad4:596a:0:b0:784:4f84:22f9 with SMTP id 6a1803df08f44-87b2ef94002mr25130856d6.7.1759927240350;
        Wed, 08 Oct 2025 05:40:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378810112bsm14570055a12.26.2025.10.08.05.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:40:39 -0700 (PDT)
Message-ID: <e3400ab5-c4ea-455a-b8ea-d4fba2ece85d@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:40:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: lemans: add mdss1 displayPort
 device nodes
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
        swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
        sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
        alex.vinarskis@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yJ6tEOkE5n4OxkeJ6bOwMZee4xJLSmye
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX2l2vIP+w6DTg
 5khap3zQWkR37AVCWOs/vt3iGAMUHG5xEmw75xoMFWH55RBt60dewt/KYT7R1ltl6rzFWO1YHYj
 CQtuCM8xRKDVkll1OFdO0qx69buSWgPM4rzt7L+eVm+GVoFG6PINh4BwX6/l29JdSabxHuTpQ56
 T/HSIjE2Iu/2dD+2KArR2TfzUD6j/MCw3HXCSfKfIJRHsZ//xzIydwAduMemi9w8WdJuvgHDTxf
 WmRrdiJdMDMzKgkoOJMXtaOsNjxlhReCiadZ8kTb4coYH/ir3fj94Z35UqdZ0A9N7XI4w8YydLh
 egd5Z38ikS9y01d8EUlDaJypKgpgAMVxQw7zNJVjwLdRC+nPM1av7xlstBgjoFXMrKfMuAFPM6z
 +599VDtoucSEbBnMK2ga8lFd2ripaQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e65bc9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=5YqVK4ek60l4VI_saP8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yJ6tEOkE5n4OxkeJ6bOwMZee4xJLSmye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
> Add device tree nodes for the mdss1 DPTX0 and DPTX1 controllers
> with their corresponding PHYs.
> 
> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> ---

[...]

> +			mdss1_dp0: displayport-controller@22154000 {
> +				compatible = "qcom,sa8775p-dp";
> +
> +				reg = <0x0 0x22154000 0x0 0x104>,

sz = 0x200

> +				      <0x0 0x22154200 0x0 0x0c0>,

sz = 0x200

> +				      <0x0 0x22155000 0x0 0x770>,

sz = 0xc00> +				      <0x0 0x22156000 0x0 0x09c>,
> +				      <0x0 0x22157000 0x0 0x09c>,
> +				      <0x0 0x22158000 0x0 0x09c>,
> +				      <0x0 0x22159000 0x0 0x09c>,

sz = 0x400 for all 0x9c

> +				      <0x0 0x2215a000 0x0 0x23c>,
> +				      <0x0 0x2215b000 0x0 0x23c>;

0x23c -> 0x600

[...]


> +			mdss1_dp1: displayport-controller@2215c000 {
> +				compatible = "qcom,sa8775p-dp";
> +
> +				reg = <0x0 0x2215c000 0x0 0x104>,
> +				      <0x0 0x2215c200 0x0 0x0c0>,
> +				      <0x0 0x2215d000 0x0 0x770>,
> +				      <0x0 0x2215e000 0x0 0x09c>,
> +				      <0x0 0x2215f000 0x0 0x09c>,
> +				      <0x0 0x22160000 0x0 0x09c>,
> +				      <0x0 0x22161000 0x0 0x09c>,
> +				      <0x0 0x22162000 0x0 0x23c>,
> +				      <0x0 0x22163000 0x0 0x23c>;

0x2216_2000 and _3000 don't exist, there's no MST2/3

sizes should be changed similarly 

[...]

>  		dispcc1: clock-controller@22100000 {
> @@ -6872,6 +7115,8 @@ dispcc1: clock-controller@22100000 {
>  				 <&rpmhcc RPMH_CXO_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK_A>,
>  				 <&sleep_clk>,
> +				 <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>,
> +				 <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>,
>  				 <0>, <0>, <0>, <0>,

You need to remove the same amount of zeroes that you added

Konrad

>  				 <0>, <0>, <0>, <0>;
>  			power-domains = <&rpmhpd SA8775P_MMCX>;

