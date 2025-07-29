Return-Path: <linux-kernel+bounces-749438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A80DB14E69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC906545172
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CBA153BE8;
	Tue, 29 Jul 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpnWDldJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35184C79
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795931; cv=none; b=pfCA+kNMVqpIqLpYgoky/QdqdKuG5PkR9N49jdkMG/mXE4skyOU/BoLwfVHKeUytL1WRXmWDDcdyP087RVePyEvylsENDfS4hJGohfTtoU8Z7xOjwjvgKqjNlQrfjAv/z6VpdcoBfDXgv+S3C4GY7FZNb8mpDiW0WQpBwk8inXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795931; c=relaxed/simple;
	bh=8Ft2D/+C4yivVVIIj7XXHB6bdiwQxNYGInng8jnYwyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJCcup1VZisB9++xfKfB7Hsc96gEbb+a4l0G785ruZTqI7kpHhJZPeq+EH1xGPmmB1AdcjT1jJ3M1uk9CqIjKqLK1ounRJa/ETF7wW9XBDAzZyfVny1Ldg2qWvhsAwTsAi/LpyysWDX9xhHTFPf5RQ9w55c6T8pkmX1b2BxvNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpnWDldJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T95Ir9018853
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rxf3Nnt90oOV5L8CNTt+oQ9ToPCocW8enMiasd1MNto=; b=jpnWDldJ9rk8DHmw
	ADBKBxby2tR09BvFzV5peoYbLgDHaxu1NVUEEVdOAODl8IAqMUWC2G60HthJ6vYG
	/ShgPqyY0SRQrqoJR6iTJkSy5K6anl7cHdIY+ORJWlCLcbUMIdNs9lT3m3By5yus
	u47vk/XSzMKMbBaW40Kp67l5Ddt9no3/5HqKysSgsVFxTIVo6h5QhHjr35ZoURBR
	T/s9WgeCN6sArXuSaSlJkBWjlnp+VV9T45FvpHWJvuSYldnMb/JI5im96jwCtbro
	SAGkx6TbuYH+HHC2q/xV/ileXpfqBo2+FaMlVhJU5KeHaDniMB1dgpL3PyPz4Krb
	Q1vDMg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q860b9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:32:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400892d330so7659675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795928; x=1754400728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxf3Nnt90oOV5L8CNTt+oQ9ToPCocW8enMiasd1MNto=;
        b=Ph7hrcJt2DO2irEsLbqbEUa1sAcEnIhD658KuHN+6Qcem5iAi4TJSSdpxvcECm4nw4
         jro2hZFszFTDcTZNNsrW/PVKv2wY1gYjhDRP2JFfH6SNCVGyMQq5p6FIscursgXittKm
         rPpLK5yse4hjh32liYMEiE4MN6NcD52kGspC6mU9ROphLKbKnuA3wTao1uDNs0BakeBV
         U7frxWJX6ccs83C7x5dfcuE5gt2aHQi30Whgtuxt2v3xBdBF7KBqLFpBi47+U5e5Fvqq
         Ccuy/tLf07Ih5MEBzNu3nlUwL5FTRy22iWc40AXuVRkp04DUYtxe55Yb80W5FGKLRdt8
         wSgw==
X-Forwarded-Encrypted: i=1; AJvYcCVze/1Cjx7FcnzICT1jVQoVSOQWO4RjCKdJUt+2WKDDTrt2AeB5rkXQYzYg65XXfglbLrsVJBNMGz0Q9TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmnf32/vXxnALJohx2uQdvh2zpptzQzDoOveoWMS7Nc7a2SLx8
	rqEeC4qRkqAjc/tKe874NR/LAFFcA1/s5XA4g2r+nn9d1Yra1TPd63nESYtDfAPrfrdyPPfaN6b
	zbPSDPfbH85AuLInzQPhn+1PSPQR7F/jhx92cipdSpIyCkpcEdjtpP9XMkWmljNlXz00=
X-Gm-Gg: ASbGncvtTRLA9SXi4Gc2F4O7xmrsB442aUsfcTKxrS8GOqvOpOdvzJFoyUwZQ3+CoPY
	8xFeSyAGuuLw2pm2wCX526G3mPjje4DlAKd9KAn9RvMH4b2puoWtPeHUrcA+q+YaDcaTY66cDoW
	Ad4QRO9lkPGmgKzgtFqY/MXEDktsLmToMtjhQtOs3URpfP/GJBgkQYDndMiTYT85nds9RAWiOSW
	g7MQKAD1cstbGlism0PhU0PlVzewz8N8rdULZb3QS046DaqtXlVW4qFSyo65aiiNFY7Y34Zvr84
	uzbwClEJBb7Xbg34UeO6w9DPQQ27E0ALK6orLxRS8238Hv2clcWkwgRsKjgRuFE/TzXwc0sq2Wr
	3aDm/89pfM/5OVKvGLA==
X-Received: by 2002:a05:6a21:4603:b0:235:6606:6840 with SMTP id adf61e73a8af0-23d701797efmr10497080637.6.1753795927900;
        Tue, 29 Jul 2025 06:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGppZH4tBm0B0ZjZxNPeIr5Ha36dgu+n0hmG3OmQx2BO7yLnrEJlDf1YuOvKQHgy5pzupLEDg==
X-Received: by 2002:a05:6a21:4603:b0:235:6606:6840 with SMTP id adf61e73a8af0-23d701797efmr10497026637.6.1753795927390;
        Tue, 29 Jul 2025 06:32:07 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af8f62b27a1sm19823066b.54.2025.07.29.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:32:05 -0700 (PDT)
Message-ID: <8dca591d-0a4e-43ee-903a-7a6dccff9250@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:32:03 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNCBTYWx0ZWRfX+rMvkQISlfks
 LyzmPPqb3jTMnrTH3xQZ550wV6GF0RR4KTNA1g2nGKTZ/l8GaUdygK+2vzPNmy9RAv5MZ1yKlHO
 yay1tW0mkxky67qqdiAf//Uf20aAD3RVE/aWIRfS0wmKWNKUg8A+5Bdrqcb2/JJLKKZ2dcEGeBh
 Q7VnknhyHBit9xOpspLcSIue6ACYKblJARZFPU+M707ZxfYNe8axNCuoeIj7t5VOOgqPvbYuXWm
 Cd2YoJZeCMyixh1T/7W3BIQLgIWTvWENFwCCgEXsSplr5URDS8/VTB+xLIVe8zE0plt1m+wCFXr
 NjuSjeFq/QvZltCqRixoIVD7/ZmAWWOGVqupiqoZww1zQbUZmgnQq9HPyhRxmepf1KW/uythVJ2
 E1T8bpE5MTwwTNKnRJzASXm2ddo/cjtgbDUh44aLPpb80qgmKHD88tPeGn0seU0mnvlxel3o
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6888cd58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8Yr4R-HfXjpLVZqX0moA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: z5WEuqm_SUH_L2ISSHCSMO6BMOU1mko5
X-Proofpoint-GUID: z5WEuqm_SUH_L2ISSHCSMO6BMOU1mko5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=973 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290104

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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

