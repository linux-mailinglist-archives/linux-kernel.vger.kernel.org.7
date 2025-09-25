Return-Path: <linux-kernel+bounces-832196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A2B9E9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3703AF405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19442EA49C;
	Thu, 25 Sep 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3sqOFnX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E62EA15D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795921; cv=none; b=DOwXeTCd5MSS41q8F814gPrR2Ru2gmiNLRRY/3DWIE0584G3r8vSRBYoZ2eDEFk5lwsBNm2ElkZcmp5Q4UutyLs45vbwAho7OCDO2Unyi3qiWLUqtONm86DcOZlR46hwwGuB1oVVOfKqxqWfYaC3HvkqpruwLZsxZMAGioStQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795921; c=relaxed/simple;
	bh=jJH46p3z2LOWDtL4CTl89NqL9Jpzrq56C/RNQoMYBPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw5yqiPfG0efTlaEVMUgiZUV/XT5doC0n+bIwqfzZ9Ep+KnM0n4BdXnod4lR7aWOYJO66gSCoat84eDze2yd3u2tTANN3WKMz84dCslK8/aYjRWo81O2citJW7EP2IEhrAVOgG1xC5zpfNijWYAhfgvgcZo7+ZfRnRPgTluO+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3sqOFnX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aJbu027521
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJ4HNspy8ugKaxak0rI5XESfap+Y3CVU5ROm4M6HYI8=; b=I3sqOFnXsA3IAxUg
	cPGCPtxVZBJD0lE30y6n6ix3nZgsnRIo4ofm96e/GfsylnPcZEhWeaGIkEFQDHs/
	Axi7VYqUcTNVEwmdAiUEtw6hEoZyEIt4Pn9snrJbUxLjWZCLuv9qVwR56o4tVTb0
	oPv78nf3ThCMLqhXzRQf5JAN7Qyy3d/u0GzKW+yd5cblGsOIHQ7OTjbklXsemFKC
	SVlo8LapVEKWP28zAk3EMYBby0QHMctJM8Nmh+xY8teoZN/g8uvXckrgjosQQkzL
	X0LA4n03acbTJjJeY5kUuNLFx7+8TX5ThKbNzUgLqNAQTZK677y0FsTLg8m4TQbm
	a0ApaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup0xvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:25:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85e95d986e2so1485085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795918; x=1759400718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ4HNspy8ugKaxak0rI5XESfap+Y3CVU5ROm4M6HYI8=;
        b=sxgfARgGzCkzEJjCXH8RrIcjiOkZIPywyW7EWZO+H7a7T0l80cSkq4bDNNqVVHAT1H
         Qvhla7y1EWSviXTOm4HtQ2YlO7mVgQ8hG9jusYXVzsOG61x6KZMzXKPerJAAg1YD81E5
         DDgf7jbzPIlv+tCgJ0WMDzNjwpe/Q1q+hCd5lCIeNLa+E2T2q02y4k2k9h/K55xqzHRH
         hSPKpWqWBq3iOZWjzJAA5+vcO4TvktNaat6HxfQt0XXryZLZcToqQy25vh3ZSfnIUX2R
         laq1YCfUYrrVFKM/BkDF8KmD9Fa/4GhMkr86EMPf4BrhdcWDwZOFZMt34B0BrsIO1KMw
         IBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfi/Fi3a55PQrkQM7p9ubJHZwtByfUWlfvfVYQEk9Ppj92Z0RTpUGH6/JBAWNUevZhriA2UB+VO/9daw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVu181bwfoc5q/iVQk6L8idm1JJxH0n8b3fB402SsKxaZu8w8t
	QS13AUZnS+e7rAfdJSfW9OaYJh4Mzi0wuVAj9gMr6Y3JLarB//uKnEb82/wJUY2zi4ToC59+4Lp
	pZ2D2Iiw2VhCeYLPMcoOPXnoBGA+4Qp6U/KX0xKuIjwpjZkEMN50laBL1s5bGPdEKphg=
X-Gm-Gg: ASbGncsp9uxaCitFwNkIGOB4+PV6Xr/14dVyK6Zcx8iqSVKCk52i2MAwRk9gnWhZU+5
	qPVYNZXof3Ff2yWk93RQDs57lGH0tpz03S2gn8ZGkODfHKnEgfDCRSACTsTGWe1MX1ZnWrGK4fZ
	zvmD6+X4pJn7t6GOZYS7lmXICI+KEaHmJJRsQORwAqB57jS/l8LD8zB8tYogoGinS5An1tGZOkD
	+V9Qrr9yx0Vg8SFylb+iI6Hwyb8MbYfEh2OIG4wsUQDKo5F0j9uI6HYet1KGe3q3Vt1xQEp3UNz
	fOiG7Del01nnhCd3zC/1UC2x/vLVjztOhnzuBcBr1LPxYwlcm08lkgv827xV+5nVzuhNh3MSU/l
	iUSP848KWN6Dm4O0R41zFww==
X-Received: by 2002:a05:620a:40cb:b0:855:b82a:eba5 with SMTP id af79cd13be357-85adf5d276cmr231390385a.2.1758795917365;
        Thu, 25 Sep 2025 03:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2Zz6UrEL9X1kyHtq0w9S+d/UM+2pLk4ePCwwUt6YIR1xjOW2GmKX818dowCttFUH2RlgjbQ==
X-Received: by 2002:a05:620a:40cb:b0:855:b82a:eba5 with SMTP id af79cd13be357-85adf5d276cmr231389085a.2.1758795916935;
        Thu, 25 Sep 2025 03:25:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f772528sm139148366b.37.2025.09.25.03.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:25:16 -0700 (PDT)
Message-ID: <2055e6a8-dace-4ee9-a74b-0e3bf2d58fb7@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] arm64: dts: qcom: glymur: Add cpu idle states
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-5-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-5-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d5188f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IJKnKGbGdoixpOcUAUoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX0gdG/2xaaiwX
 gkmlsT/hhSsUwGCKnNiHubUEhl8yMmjlBNk8HUrirIhipDz1qCGiK+qI8e6x5AeyCybgXeHzz2t
 TR4Nvq51CY5MjmH4azA9Yxx7YdArJUatA/p1dK+UolL0hC/SZlwjKaLp6kYLel6Qeyplgz7uVNd
 UonQq8YFwv4TA0AgTXYjr4DyN18/IYzDp7JayxZsCzRwL5LCLTrg+TArYU8ViQQq3pzWu/iYYWE
 crTYGyCfwFqa+thFx7ewH0S20Rqr/GqEKRZexyzVbvizP8wNMn4yj/LG4L6LRbr89n12+Cd7etM
 EtNFfD1T0lM4DtGXLMkhGEjBw/QcxMz22Ya7ov0AdwVIZ9tI+ZImVNfEF886ZBYwpT1yAwXCmcc
 O0xj5//H
X-Proofpoint-GUID: _nNyiDs9k1I3hwEEYe5QfHlyxQR4agrr
X-Proofpoint-ORIG-GUID: _nNyiDs9k1I3hwEEYe5QfHlyxQR4agrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
> 
> Add CPU power domains

The commit message could say something about what kind of states
are being added, what their impact on the running system is, etc..

[...]

> +		idle-states {
> +			entry-method = "psci";
> +
> +			CLUSTER0_C4: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <180>;
> +				exit-latency-us = <320>;
> +				min-residency-us = <1000>;
> +			};
> +
> +			CLUSTER1_C4: cpu-sleep-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <180>;
> +				exit-latency-us = <320>;
> +				min-residency-us = <1000>;
> +			};
> +
> +			CLUSTER2_C4: cpu-sleep-2 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <180>;
> +				exit-latency-us = <320>;
> +				min-residency-us = <1000>;
> +			};

All three are identical (should they be?), just call it CPU_C4 and de-
duplicate it (unless the framework would read that as "all CPUs in the
system must sleep at the same time" which I don't know if it would)

> +
> +			cluster0_cl5: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x01000054>;
> +				entry-latency-us = <2000>;
> +				exit-latency-us = <2000>;
> +				min-residency-us = <9000>;
> +			};
> +
> +			cluster1_cl5: cluster-sleep-1 {
> +				compatible = "domain-idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x01000054>;
> +				entry-latency-us = <2000>;
> +				exit-latency-us = <2000>;
> +				min-residency-us = <9000>;
> +			};
> +
> +			cluster2_cl5: cluster-sleep-2 {
> +				compatible = "domain-idle-state";
> +				idle-state-name = "ret";
> +				arm,psci-suspend-param = <0x01000054>;
> +				entry-latency-us = <2000>;
> +				exit-latency-us = <2000>;
> +				min-residency-us = <9000>;
> +			};

ditto

> +
> +			APSS_OFF: cluster-ss3 {

labels must be lowercase

> +				compatible = "domain-idle-state";
> +				idle-state-name = "apps-pc";
> +				entry-latency-us = <2800>;
> +				exit-latency-us = <4400>;
> +				min-residency-us = <10150>;
> +				arm,psci-suspend-param = <0x0200C354>;

lowercase hex, please

also, this node oddly puts arm,psci-suspend-param at a different place,
please align it with the prvious ones

[...]

> +		CLUSTER3_PD: power-domain-cpu-cluster3 {

"SYSTEM_PD"?
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&APSS_OFF>;

Does it make sense to include some shallower idle states?

Konrad

