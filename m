Return-Path: <linux-kernel+bounces-745423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0AB119BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798EC4E2904
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47B2BEC51;
	Fri, 25 Jul 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcKJRwA6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2829E0F8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431763; cv=none; b=WI6ul4xIyQVm6im2Y7zVsBcvJXdL3xE01w7Im5T56UnN5LRvfLKjNi3OTMxiQ74o5FMTeJ6jvWorV0Q3PES+ifoP0EtIFFVlB1KtoKmkq2G9rbvj8WvW0UCugPfI9XxZQ6r3dueV+iEu9mT6DP8hsJPzuMVWh4Qo6sTBCCjNo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431763; c=relaxed/simple;
	bh=tAq/SqO5yTKsbl8iexike5OsMdJZOe+rhnywnp60BIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0dYwRrf0Q3jHgSVH5W3ClFNeNREpsIXVTsK2zR47dGj3BrTHP/NUoQeyqXITNrowZVc7ADRUw3S0PW4yYBHyG4+3+YEPiKhbcvHom0wFg3b/iFx0xXxK4SXLXGmunF9NEY1YNWg3/wIPA8kyJWcqKNMVQeqwW4CWXPJr4rtH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcKJRwA6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLrWik004813
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UMDm2fXHNCh3LgW6f0uPopRqEtk82wFNcazajJLD31w=; b=gcKJRwA6ZsYKFwOW
	4HdqsjTqf9QkX6AWCa5BN5b8/J77zqjRTMo0JdtwwTlw3IFzJe0OkaWBDEiNuqhW
	WRmHcn6qk508749V/2g2L3WH3FkrDgURWp6/PlGvz3jEWYVWRcKiAZVlqZS7+RVT
	MA6xPyoAvrZ+DF9sKokE7fs4oleX8HcTR6rmoD6GwChPshBj1MPtNrAn9M2IbTpf
	G2Cx2zM8nHyOgck0xY8dWshWP5sV9zVHFNfVJ7KScgXxAQv/ggV3J0dm6PX9hdlD
	f+OpQ0QISTfMF9qm4nPtuUVyF5I932kdllYICwj40p4eCzctHmiDLB8V4txwW1nZ
	IFp+wQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w539btw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:22:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ae762426d8so1196811cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431760; x=1754036560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDm2fXHNCh3LgW6f0uPopRqEtk82wFNcazajJLD31w=;
        b=RyT6+HWLOxr7nRtqCfTF4WQuBiOYP688hJxC6l/zLMe4aIUEEG4w2GaRKU9RIvNNUs
         PKfRKE/jgcdP4nb2mt5VZZcPiPkimORwCPC7DUPWLq/mrdVnl1OkPSm+VWFvqypyWr0o
         Q5b4+4dE4psKNBq5GauT97n86sUH8GaBDciILUemupU8Xghsva3QtqK0kWYtrY3bZafx
         +1EGIF4X5SYovKRBPRbULDJUNFYH7nYa9w78iUvn9tyYQm0bLAnA98PWNpzUD7IyT1ZN
         fa78v8zkAzHtlw4OX5AMHGX3klOgng82muxKTgT8MNO4Ra+d9nJGo/cJ7HBPtMbuiBHV
         GmZA==
X-Forwarded-Encrypted: i=1; AJvYcCVK80MG3Ke386o2NHawL/+QYhusjqq7XUYhc8wlfjyrJgg2AcqTVHpwRe5lsUQUnK3WiWTOADUojsWgNOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlg+7q2YXxUCQA/N96yC8kdhHNS1f7T3ecP8Jec6ZX8RHY2Ui
	PF0BwojVjV3z/rkx/F66H/SyeOSNbiiQ5xVo7PLtc3I4/+P+WKNSnYZoZh5ObekPsRf41Yf4+6U
	h6HQjArHApWyGsNSlSCvgsij4McbrbOAri91VBjfLHhfSJzN2fWHzL5LIsoDc35n0LZeU3S4KL/
	M=
X-Gm-Gg: ASbGnctRlGUz4fBoK92aw83vsHK2Ckb7VnsQsfWX4m474sfqin0d2x1fK64Y5j9zHvb
	7lgqaJdPcV/tsLBgX5/xdW1VUR9UaHqaCemgP9TA+oTVdQ93D+XRvsm5nNoMN/+26vNICCA6wxI
	avmq+Mk+0WgJ30qvZuKWVfLHoUC7lLkLnr/C68KWs+mZ+/exo7042rGVl/98mizXtJpvMfIGnjU
	Zk30iScNniR7W/kMBKviaiBQapor5oD6rTCL7RWncFc15O2LXZ46GKtdCI3Jjzoj6CrO+aW3n4x
	qgjg6PCMMpOnrx5tfitpFRCzfylvOXHEg7WMXiDsKjE6Umr2rf9ZRTXRog0RVHODPPTFu00TMgu
	EOPUmV22sO+ZvWevvoA==
X-Received: by 2002:ac8:5dd3:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4ae8ef34affmr4792921cf.6.1753431760235;
        Fri, 25 Jul 2025 01:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuWomd2vdk9aPHDlgia6FxW++avBnZSibV7JMRZycFiIZcbVvohrAq8kSwrDLCAE+kEsk00w==
X-Received: by 2002:ac8:5dd3:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4ae8ef34affmr4792791cf.6.1753431759808;
        Fri, 25 Jul 2025 01:22:39 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6bdb6sm229547166b.39.2025.07.25.01.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:22:38 -0700 (PDT)
Message-ID: <36c8affa-336a-412d-8002-095fdf23a287@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 10:22:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: use DT label for DSI outputs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250725-msm-dsi-outs-v1-1-18401fb9fc53@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725-msm-dsi-outs-v1-1-18401fb9fc53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AfKxH2XG c=1 sm=1 tr=0 ts=68833ed1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Yi-8vXkECB-a3imGwT4A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MCBTYWx0ZWRfX0SGmw9Imgr+w
 cNFin+2GBvZ1l7KrpVo5FxPfw2AR/p2BBj/pHlUrWmAAEQtKVfFHtH6ObyoXOF0Nb9a1U8zBFXk
 vQr+VqKeMblvvcT8D0b1elrX49WpYmWh/4C9cosp9XIn89Hlewssw+9rraoRu7UiKSbrp6Ay/1d
 RbMkGpiFakOJWCiPCjD8X7QhtIdU15dTBmSOjB5sCK3ktPu593nUXMHjdv6I5otd+ruKUzu4pvF
 L+tFCvl6fxEj/eDoYDJUSEnjPLMdgpBApG2oxzh+gDPISETB/Nlberx68PHaajQgVGsHQr9CN8p
 un0TLNOnIuxBtoiIR8QUidgo9Q33en6Udx27jMlMJYwGMnb40KDq35d8dTzU8ESFZFy5rWKMGqn
 Q1yv2HtbrUUyOGNQLBEWgq28OTvzOPnUQBCXnNA/8IBHP5JYdXi7AbRe8hk9cK7qz7dpjFUu
X-Proofpoint-GUID: l0q-aUaV_deVdSsZNQTAb8RhqDgk8Fmy
X-Proofpoint-ORIG-GUID: l0q-aUaV_deVdSsZNQTAb8RhqDgk8Fmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=712 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250070

On 7/25/25 4:59 AM, Dmitry Baryshkov wrote:
> Instead of keeping a copy of the DT tree going down to the DSI output
> endpoint use the label to reference it directly, making DTs less
> error-prone.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 12 ++++------
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts            | 12 ++++------
>  .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     | 12 ++++------
>  .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 12 ++++------
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         | 12 ++++------
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts         | 24 +++++++-------------
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 26 ++++++++--------------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 12 ++++------
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 24 +++++++-------------
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 12 ++++------
>  .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 15 +++----------

This file becomes different after the patch, but upon manual inspection,
it comes down to a phandle index shifting around (i.e. no *real* change)

Nice cleanup

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

