Return-Path: <linux-kernel+bounces-800309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA7B43615
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3D5A19CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7732C21EC;
	Thu,  4 Sep 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRR9JaMu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC82C11D9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975244; cv=none; b=KrpC/kCl13zCOa56174chIJD7qsxWMXB3dqhme7VmlLsoasu1COoKjdhpqIkHnZvtN8RBuEJVkPKd7QOm+vJn2JU3XK4poRQfA9u0BEj4lCg2613I1vT0ZonuK7ROOZx58P5gD+TlxgVuLJWieoLdTMxL2a1rCUlWgoABOx+76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975244; c=relaxed/simple;
	bh=NkmDNo8VPDtMikBhpQmfI7PvvoyGiT1t1uBLOq/33TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgZ86FDCOluksEGlCHQTSh6RjIpdfP/7uocOkHKRj919gWkqati6pRrABnnzxP+3sJgA15wyisf9yvlWT1xIste8ytBy4nd8OtKjofZ6sHqetSWOe55zNUmjP+XkEfJ4A+pvTDtCGwL0SepUgPvGOqL5WafuGcZkyyodZ0JWDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRR9JaMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840iZ78007700
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I4P4Vpckc6QJ4OtjBhntsKaQJGflNRN1gBEgtyUv9mg=; b=mRR9JaMuBjiUkIC5
	iZv+AUF4xoQaK0bIgVVycAebuDTEGGDgdDyuqPmDKKLYYJ8B78r4q6ssMhNqnMPV
	2jYEFJPPg3LQ6ssw2So1aaI753Fwx+D/7ViUVzSTtCHOYbVbWn0BhcWDJAutNj+c
	ywOFwv/BkFGyoiTfMa/DtVhilXvtcF+gqkWgO+LpZH29LhsF2pOEc36CHwgozXcE
	tCQ9WDsm1O8u1+8ws28m6SQPQ6JB0qF0YfcmdsKVV+2V83au334aHNgepId9JerW
	af1krn3OwbAcdfftxQcTqpP/44LwfBJmUZW6BCi3oVLqPeMiLIhJiJGEzihdzVhW
	Fg4LUw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s6vdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:40:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b331150323so1860711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975240; x=1757580040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4P4Vpckc6QJ4OtjBhntsKaQJGflNRN1gBEgtyUv9mg=;
        b=GDnM+E60ZoMnVr1NUeKD6UTEdBr6mbiA2a80NYY0OK8tK6cQusLvTJqOKYEB61T7Fh
         0hS54a7fdglSpr7ZzAJ6R2+2/jWmpfDqj7coLNgNjeerRkAX+Gnn+BiDJ9h+84qdGFz/
         toZQKDrsU7Sxm4h+1sTkECG36sc3utiEQ6h7Qa0YdIiCv/3aXkiCyVtZt+MNRQ7P8g9g
         N4+zhC0UmKHpSF89aW5Heg+/aTxJWJrRTdz5LKv4oZ7DeQNU0eMMeWBLVP8YOhXNFL8t
         wh8oUu2wPQe71gIBeTJ3rwtPi12NuofqfQO15ZTET39FDR9l2AKcNFGrHfQ9ydCG1Qa0
         VBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV+sLacABh1QAlmVDS8oQ/Ertd5S4wykSgX/ILd/DLlqCekMm8OjFo469memzLEaHzsEq3WmJO5guk1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMsrbjocyVqTbXSDXdLygTEXf8LBHSbpLlnTNTWHcUz8xK0TH
	ODbYYNFEvE9sFNxss0VP9cV971dnFqQfdBjGiGkGcMXwXDhOnlDFLHkxuxKF5qsjUdKFJQr+Ikt
	I3N2UYBUWFVIHsY7IEMTS4MVV63HN9mypjGIRaFotAzTXlXswsCEyY4n/ZpzLVHNBIFI=
X-Gm-Gg: ASbGncsSAF8gUnqKldtwOoqVLkpD1ZKvKSPA4vRS9Cu7cXii9ANkI+qhejy/jEN61nZ
	b/j2+lVIHcbsFZv8yAlBRGGOXdG1UdtHoKE3PCCsOPThBr0VcDQ79GOxDpv+qWB0VfzgzjVHEgm
	59zKGyuxbSLmny0te7gtb02DIxp7/N+VLcHdHFAzm4PtM1HmdBV86aaP9bJZnmhshhLoCclMmS0
	N4eOn9kZgEoEATTOU7wERHzMcpqLDBccsell2g+7pgNvVtzD7/C35jVLwi6ECA1r1nJ5L5SysTi
	n84zytbJouGCzFckyiS87A1cklVIYbMKcZ4Dwwqu4EsopqLvwV6Wbai/OZeVbjZkQzc/69teswO
	tXXvrpozuHWLDKVpcTc87cw==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr176386691cf.11.1756975240390;
        Thu, 04 Sep 2025 01:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3LGMrSU/BytfgHKLmHyXhzao5cramuAbvzO2C5SkqEfzxhB2VBfo0CX0aTEn069I0+lokrA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr176386541cf.11.1756975239917;
        Thu, 04 Sep 2025 01:40:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0431832a98sm886966366b.80.2025.09.04.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:40:39 -0700 (PDT)
Message-ID: <34d9e8eb-e0f4-47e9-a731-fe50e932fea1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:40:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add missing TCSR refclk to the
 DP PHYs
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-3-d88c1b0cdc1b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-3-d88c1b0cdc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX6y0WLh7H4ofk
 m73INMg9103fnae/XZ8Mhgm8YuBzgsfCwjMY1QUdTz2aLRMkh/+tLcPXEuyZEFTMSu3j1hAR3lF
 71tn/7HaAmXoGbyRT5mfL3KwZw2ZHb8sSaYhlaST8XeMXLUdQXPR8FLhEqLC61Gx1b6qomu6gpB
 nhI/T/03bD8Z7l4ifa2kB9dRIiyHmjTbCEhwPW90CXqEhYWIBVS/sUJq++c6sZBCsMXK5HsF8Ya
 d1GjPGOM9UEg6s/UilQVu3Wy6wQgt9B6Y5S6bFvgPweqcbE+4jz5etKHk3shaDWdmsm16bjgQYM
 IaxFGoUXu9+HirIt7bOtGKzZE+fCc1XX8k2n/ohjZMvVRD3EStUNVvoo89ek0KAfGOD7xrpDoGF
 0yPQozh8
X-Proofpoint-GUID: CzWoh-FqclzvhyXnOZC49UeK7pONxst-
X-Proofpoint-ORIG-GUID: CzWoh-FqclzvhyXnOZC49UeK7pONxst-
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b95089 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=LkxnY9FmGKG3Lg6D2dsA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/3/25 2:37 PM, Abel Vesa wrote:
> The DP PHYs on X1E80100 need the refclk which is provided
> by the TCSR CC. So add it to the PHYs.
> 
> Cc: stable@vger.kernel.org # v6.9

You want to backport this to 6.9, but you also want to backport
the driver patch to 6.10, "meh"

I'm not sure it makes sense to backport functionally, as this would
only exhibit issues if:

a) the UEFI did no work to enable the refclk
or:
b) unused cleanup would happen

but the board would not survive booting with b) in v6.9, at least
it wouldn't have display  - see Commit b60521eff227 ("clk: qcom:
gcc-x1e80100: Unregister GCC_GPU_CFG_AHB_CLK/GCC_DISP_XO_CLK")

and a) is not something we'd hit on any of the upstream-supported
targets

Konrad

