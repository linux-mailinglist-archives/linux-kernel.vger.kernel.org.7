Return-Path: <linux-kernel+bounces-749439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC7B14E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BABB1894421
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8124438B;
	Tue, 29 Jul 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaCvraAQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1B3597E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795960; cv=none; b=GpLgD4aHYAOrjoHW/s4DHarrFmEtLhUoFwlW5KcNkCf2ECmoFV7MyAwCNwfHj5/ZjRJeB4LUgAWflBq2yl0e0Zsm/MLCFyXPPvrrQTu6CPCFSTd2IUJmNYxgp+4MeG3czRk8SNP21TnHPo9CpVMKcABEtKQrk8BLO3eW05b9CeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795960; c=relaxed/simple;
	bh=v+DsZl55yzDRDRu9Ri3laxrorOzZ5AU7QR5AaTILLx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxUDqS2F9lNRnwFpJPvGIeo6iiVbon01kRU3J8gU0Ud4dbwIs3p4iPx9sEVDvlHVhJL5pISgyhlNzH/Cx8Z/diuB2VJVXnKkIYafyvH6iuprHWSWczaNGZXh4VdTBQS2cBPUJjKUqOagwBSrzihZvmc17DfAUNWepds+OwGMQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaCvraAQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9aBEB006230
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jM+V99Ir0I4XA3k8O6hCYfIKJXhqtYGbn0EBhNXPZOU=; b=TaCvraAQDvDry/Q6
	kTfpgjYD/P7HKtjUt+4z87gF0bV9VVsUZ8FCMNFQTgWwPkIpsHjVnZLfZaZtivnu
	RXE8oTxJm5wioaO3pwUBUAUWFA0bvB1bmM3xmOO3/b5Ho+w+zsarLPUl2rew3WrG
	EfVc2YQD37k8uo8mPkwK7z4O3iwDcEgZ7GRT8/jinb5zMP46vRzmA8nrtLR9swbH
	ZjhhaL3nX+WBNenF8+6k+3X8dN3KBRu7gW5COqviUNBj8fcFxZY+s/twNc2mTels
	VmZ6TBmsW1D49CCIq//epE938ohQEXhDezDk10wAjRbe/yIokqnGC7/XgyI6YEbM
	79WJkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr8d9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7deca3ef277so112830185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795957; x=1754400757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM+V99Ir0I4XA3k8O6hCYfIKJXhqtYGbn0EBhNXPZOU=;
        b=YbPbtxd2/u1+1So/UFxJKxh6/6Fq8fGbGrfA8mNeQQiBFCIbsVF/MUiyK542myKlfq
         2aYVXq+aEKPAFNkj6rSF3j+SQCKBYmBY3lIWqFH/gMu6s1glI9ITEIGopJ3Nf1rCAbWP
         lbQTCrWAbrG9rcJQYRw6iR8R3vAbz8k6Xlay+j44hiytbbTArQC7AfDK3ekFqJMlqcm1
         KeTMBbQeMgjKiYA64A4XknKcy1QQSRMDRUMnicqtaxfcypktlNzwvbEoTOyivOE+fHHk
         mZFjWYe/fqT8ObfUVgP74Y2zIvQi1RJ1xfgLH/zH9YtrlmksbP+/yLNpznIUg7cgkHbB
         +pGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/QXngOsGB0LrFifGWBWhs5e9jqF3bQqvyXh7rxHzxIfGaFHSArHQc3y4/ufI+gx9uMU9OAPmVHAEG7lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOxWau1209h3LDXjZ77EIe5YyYz/t74iJRvtlNmESqjVS+owP
	abtxTaQCD76mFwWDtYaHxnIwSiaJ1CkSQmwVHtATQD3/zEy3fJNb7yeDmaoy4YfyBfYPAemWRC7
	P2d3cJZm0KZw/sabJln5KQ0Dob8k774qTKSm1EcoYxw8m7GvKLE7iTAJUzm29MlB1s2g=
X-Gm-Gg: ASbGncsW+CqdO89WL6mI4QPbFLDVSpr15Gmb6/E8EpJ6pykyXUfO4lW3b190BiURQrB
	6Y1YNXI8FLAgX77hFgFYebnl788qYPqI5aOh+V5FiDFp8grTW6eX82IXbFn1MyGpfbFD6FxnjYk
	+S1pNuv1b3I/DbFgumF1QdGqhn3tUB6jAeO6L1dQAG+QBd+WFXRwubd45CINtXJMow2fLNig/+Q
	JUBm3fEq16StoV2LAecytiSvHbwkTaI2zzv9SmX16tPXpceqz2Rx7UkuuDd4QbTOwbMnE086gUr
	J1ltf8ehp+HYMK+qRsPm3c1J/s5qzE0Ur8FZiTOzWJz5EdID62xcJNpLE/EC9PrBevwzJUEMpPO
	xquORqQz0EvSWG/lp3Q==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr1044385a.3.1753795957089;
        Tue, 29 Jul 2025 06:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGAOzJT3QZrBy02ECSykHzkvGf3IwWCyjkvsQ1hFqKmBvEZUJqnoAyRjkdmzAO0gfMk6N25A==
X-Received: by 2002:a05:620a:40cb:b0:7e6:3c4f:fff with SMTP id af79cd13be357-7e66d4b1af0mr1036885a.3.1753795956019;
        Tue, 29 Jul 2025 06:32:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635adb093sm590411066b.124.2025.07.29.06.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:32:35 -0700 (PDT)
Message-ID: <39be83ee-9aa3-4c87-b76b-b6dcaf50a239@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNCBTYWx0ZWRfX3uGR8injBv77
 UMu5Z/BH1j4pPCyCBdd8jbC/fc3pr2IzuRJCBmcoHRWo2cH9mv6pX74RNna6kZDtcZindzOEpse
 Zhorz/xA1/Cm3JdKfnghIqMHueBJhCH39Uc+U6tgAOzAEkwkUwsX5biikxAZ7iqLVYEsfcQYfx7
 xL6pObmgUL9N5z+JJXvnBNS2oQsjmZm2oHBGDgoIYZ8/rqstTtG9TG6fyt11YJOUPtFfIc7ub6u
 9qHHiGE13wPTyD1oNytuUAlEQ/hNuZ81a9/YyYG0MH3V3x2bh+q0bpTd1fmd1pDkuJehwLoP8Tc
 mogDohVbMc21uQ8+/xMJK7w/2Yw5OCccQDizLjqqLPDUBj8JhJxhid3R1UZwVMgAawUlTbsmynu
 k6ThBQqzZuSy6UPSNtPaDveYDvoXlNyLosLEaIsE1M+UEe7pxkDUMY3MUhkoPtOvDrHR3649
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6888cd76 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8Yr4R-HfXjpLVZqX0moA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 5O05eBIXy9tfpu3HlqA3f8cCcmQIofIp
X-Proofpoint-ORIG-GUID: 5O05eBIXy9tfpu3HlqA3f8cCcmQIofIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290104

On 7/25/25 12:22 PM, Ziyue Zhang wrote:
> The gcc_aux_clk is used by the PCIe Root Complex (RC) and is not required
> by the PHY. The correct clock for the PHY is gcc_phy_aux_clk, which this
> patch uses to replace the incorrect reference.
> 
> The distinction between AUX_CLK and PHY_AUX_CLK is important: AUX_CLK is
> typically used by the controller, while PHY_AUX_CLK is required by certain
> PHYs—particularly Gen4 QMP PHYs—for internal operations such as clock
> gating and power management. Some non-Gen4 Qualcomm PHYs also use
> PHY_AUX_CLK, but they do not require AUX_CLK.
> 
> This change ensures proper clock configuration and avoids unnecessary
> dependencies.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---

Fixes: 489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")

Konrad

