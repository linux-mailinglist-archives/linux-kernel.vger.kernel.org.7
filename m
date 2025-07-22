Return-Path: <linux-kernel+bounces-740783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB07B0D919
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A4956251C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96092E8E12;
	Tue, 22 Jul 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k6AtnTB7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF12E3B0F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186374; cv=none; b=pTLGh6miEwiIO7FxIX8f3WBzdQsKxcSSht36/4nfEcnJcBmbVd20cdG+ObGlrNOXRIB+H6CP3FdOdhR2Zb2zJ+qp9P2D4hCX/LeDNjxaUTlplFCTzNhy/VBorvlQ8RCSc6/Ute3N8kVpw5DExIRE3XdfdGKE1DbMMy7wusIiDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186374; c=relaxed/simple;
	bh=B4m9Mr8J4dZJVVQHMVzz3OmaAMEJntzY7NDkzmQmosI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXaMAYVNMJV5lAcVTZIa0v+RYe6kUOF4KkKGTuJ/+o/g9gDIP0A+15WMHd6lRxJpVYvM9CkjBNdAxaNvnzAZ9uHYZ6RjNCxhm16G77jGmKy/3HVpBbOHnIvnJa4skoziwN/XmDB69gNMVNe2HXLmL4ReFLYGJDT1tubGoh/4PkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k6AtnTB7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7Lbvb008802
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6+tf+sdWldSOxWYqZA0c0epF
	R91HvWPAn6xpjPzhVvg=; b=k6AtnTB7FPEFcfn2Jia4GoFrAoMHN/V+fIZLWxj7
	yUz8sEiJlf615Sswg5M275/6zDbkKJ3xhSxeXMl0bmVxwimCEGJG9rd691/0tTgh
	1s3M1DbwA1dRPzk6Djx/kAcmEfI4mZwZHtm0p2BcNpKMDj5lzJESDSB7k9HmwhSv
	C8ss8Fz6mzb8lyQXmFacTSCLM80agtIguKwJNYrSB8V+mD4hrY3mFIiX6BjEcQvo
	7UE7wvIra+vG6obKA52woaTNr4ohfiBKqTmx6pPC7R7FBu5UsWX3ZwSdh83Ti8Mj
	EnLWc3Nt/OE9xfFAmL0IWv5XVVHYtewv1nrQcqd7Ud7g5Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vypjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e36e20d700so340168385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186345; x=1753791145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+tf+sdWldSOxWYqZA0c0epFR91HvWPAn6xpjPzhVvg=;
        b=BruQByWC/KNY1hUsuDabjpnW7QJ/+16+JyUqkt7C2AKTh/me81FZmR2wVeBBuemzWy
         sisSs5IM/N+KmCh+/oVkj3Dwgd9mwI349MNOLcqh/Qm3Ab41AXyDmJJba+hv8ktEameS
         1KHUa7GaFCPiz3skaoW90X0Xe2UWNiRWEqlyyhiNbe3vg4J+rD1GENyiN7w3AHRU2IKx
         7//jPA0aPOYgbnIp2xrhj1mK0IfL9WjmF/UL4HyNuraYozMOqvMshjqMaUsvR5h/GfI4
         ohpl5VoWnJzTuISDo3wedWEbRpTLMihmeAxmU3detAraXg3+GYT/uNEisXB3m1kzFeGU
         PI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8yd5uC7J5rG2Jrww9uW7PenhhNgeecgopLTa7DOHe5Ru2A5pyR6GBJkhn4ninKgsVs7ogEbD1w4jcreA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbA10xaqh3Q5kuC3RSl+7RrzAj0uOKek2P7aVlzNvB+VkGCAM
	77st0JFQMqwnvl23HW8sWl/UXu1o2PmNt0wCdx7WX+dHKiVLGN0AKnGsdOsNwtMnGIrbQRGirbH
	LVWul/NGnIQ1rOLEDPhjyqMpTKJQEQ1svw1MZVrRJmSy8/fin2VHcsrY0hvNWyewqbCc=
X-Gm-Gg: ASbGncsL20mVEl1MuXGaOUqWU7OX8ZXYW7jcQg/UxxEM5r8ZXNUJES/DVp5XAX6tflR
	Pqg7V/WI9hMu/iciTwLW0DN08XTWfmHWR3WaRnkvrf7eZBrY6RIrm88KF3CMr7stROCtvSALiFP
	2LzlzY9VtdJOtVxHcCZQQZGf2Uab4sLMScSKfEvGsMrEMbQO+yciBAEC/hlMqYHS7Dx5WNo5PIp
	phReDMNHyv3WMacAwH2ALaPch4SWy6enfsbLWC4JBEGPWzkaUGlE+sr/FFlxoOrDkeJNuW2AxxW
	3sR5oBJXfJp2oi6zVwKdjsCfrO+HKxbMMe0zHSz2B4VBWZ94VqXMz+VRqNdE4vKQGvD55vCZSCD
	m2A1ax9xE/pxntWFzgNH21+KqeH60Zed2WW9MDqtgUPWE4zHUpslV
X-Received: by 2002:a05:620a:aa19:b0:7e6:233a:fe35 with SMTP id af79cd13be357-7e6233b03bemr194466985a.20.1753186345652;
        Tue, 22 Jul 2025 05:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFg+8xKK+4rYS+5ET7ggPMSWDiREKrW1QGrmrNmf1IbigBBhD1bQdpTYbR0xEOTU3AyAhC7g==
X-Received: by 2002:a05:620a:aa19:b0:7e6:233a:fe35 with SMTP id af79cd13be357-7e6233b03bemr194463285a.20.1753186345110;
        Tue, 22 Jul 2025 05:12:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4c1d1a6bsm140209e87.102.2025.07.22.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:12:24 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:12:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: ipq5018: Add crypto nodes
Message-ID: <ssxqdorq6f2rmgxmnu3g6h7ceyzfg5golymfiqks4pxvhdeips@o26ha4ydkwrv>
References: <20250721-ipq5018-crypto-v3-1-b9cd9b0ef147@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-ipq5018-crypto-v3-1-b9cd9b0ef147@outlook.com>
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687f8043 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8
 a=UBJjrWuA7Xe-G2Q3MxoA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ex-CuQ8XBGzLktfqrm7B-pbkLAwRDXLH
X-Proofpoint-ORIG-GUID: ex-CuQ8XBGzLktfqrm7B-pbkLAwRDXLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwMCBTYWx0ZWRfX5njmMdWS79uc
 dkhXNYjq5KvJAo5eyyPz+nu3Ug7mzD1q8i0/aSCUhwin5pJa3IZW+zShTFVNxj1gdnV0+al5xvi
 gbfmSwi/py2Mj3MCISwGSbloov2Rib3P5BPMWkRSEUhPHUf2cn9erjBY4qQEdHSMZZ3zTUzwqBE
 BLDIvT38Xm0Bat8/B9cbU7VTHbeBGqNbp+WB6uuu/YadxEhuBC9a5RRR26uAXW2VX+GfSg1QzcY
 QtaPrT+ijmVqLIPeo5f3c3vPyl/L7EJ0UXCNkYuWp0H8id18MnOAHqT5lR8uO3tS+0V6pF9Mn+r
 BpKe+ZBSpwwjpJn1mRJsRcBrV1fE8g58+oRYToXY/UlwqaVeA/HKpzXGQFLQkFeb1exCZkLdVnu
 3JkuELabVzq06RD28ma/z65BCjnt5cX8Lc58aZAHW96crMUXs3YlmZ8Tj9YCwAK8vs/3tTml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=924 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220100

On Mon, Jul 21, 2025 at 10:23:15AM +0400, George Moussalem wrote:
> IPQ5018 uses Qualcomm QCE crypto engine v5.1 which is already supported.
> So let's add the dts nodes for its DMA v1.7.4 and QCE itself.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Changes in v3:
> - Rebased on tip of master for patch to cleanly apply, no other changes.
> - Link to v2: https://lore.kernel.org/r/20250524-ipq5018-crypto-v2-1-faa26aedc4cf@outlook.com
> 
> Changes in v2:
> - As per Konrad's comment, the BAM DMA controller is v1.7.4, so updated
>   the dma controller node accordingly.
> - Link to v1: https://lore.kernel.org/r/20250523-ipq5018-crypto-v1-1-0818047d8a18@outlook.com
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

