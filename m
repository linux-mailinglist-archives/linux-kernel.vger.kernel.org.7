Return-Path: <linux-kernel+bounces-855661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB2BE1E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397D64836BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE22E7F3E;
	Thu, 16 Oct 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcehCPxd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AD2DECD6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599438; cv=none; b=AUl12/LpwjzRTi0sJLWmvHxVX83X17PJaROIPZ8K9iM8LtTEOcpdPLxSPGNQbtWRW//DizzyORe3rxG607/qzQ6cUopdBtFZxgUpiXNSWGu2BqQWlpB60PMskb/OAcWum9ADSW8sPzN4WMVbjKBuKJgxWoxxkDqhc40lJbEQ620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599438; c=relaxed/simple;
	bh=u/pvDB6NNeRtZsdN9ugitJ4p2VYbjeZ0yG4iEuphbPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shETIOwMvz8jnxKYUXvwKCz04QcA6T9Zn8XoiBozl6hY1r5J94Y8jQZc1N/WaHtuWiof9F5+ck47ioyk1dBqjMH3MNMIUBXegdiqS+N2kFgdU4WfGnE2BWk8X0NsHE+18n+OIJh/rIv8GthA/VobjR26yDK2/F6z7KUqZ7Ve32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcehCPxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKhZOf016276
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HNGoDb+vaeJYhaVScXJVKuKu
	/Vv4DWy6iQO7I53RXv0=; b=lcehCPxdI3Y3P4qM+yY4UhPyGsxAao5Pp/qdcZiG
	OsMZzCfojghPy6kLmWAQuHukdmPKI5dtOZlrv9CZmxrYxZw3ADW99vJTtiqw7uce
	1W44E0QRpEFdP8Xt7Ni1hOZTPYs+S9bKymX1SOX8a53k2jHcTGXeFn1dCi9FprYG
	5PQ+D5Vpx+HOi4rGzhpdM8oY8w7+dIcLYDyv1McaTcRTL8QuOthKT0qUn2BD7onW
	r2z4no7LHMbWIvn6qzyAiEJjYnv6jEHkWsXoxwOoXwPdhlRP8AXRe5Dmy2mx6dKM
	FhCpW+uv2KioBWzyoLNYccyX7+jb30gQRDNOIx3WR+3p0A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkfc9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:23:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so336284a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760599435; x=1761204235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNGoDb+vaeJYhaVScXJVKuKu/Vv4DWy6iQO7I53RXv0=;
        b=SwC1qd/O/i837okCFXcD6F+AaCsdTHZs47gQZcDGsOB+xovapuZ6YjelVKy5BqlXiH
         CdIXvCYsfaDzANjuSUjdfpOae+gNKx5kI1cSq4JaUxSb0gzJ/7RdSSdOYSv1D/Yg1Ure
         RYwrmf1iCpSVVqu6imjlYXheOtLjq+DJj7L5DwJTjR3+xWjZjhiGzeo4x55IQEQOh+3O
         WJnQjRxnogdFhqMbLurGnJWj8V8Z1R3qM4qLRcmOw/hrCmxMQSpryigzgy7ObB2snjOD
         6ukBS5Wm3AFvKQ3p/KwuJxJCdEsNa2MXerv4l0/K1PNmT5l4HIzmdVY/86kjcqWtJyd8
         o8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnC/nYZoOOxVs9kBviD30ZDMJ1JjDhVm7yBq3FzGTzqml6uMGn3Jn5598nGeQAJ7Op/Wl6PmRuI3inzVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEzDLN9qE67V59MOSDLlN0r4PKCxa0wNS2bTn2fIabw4KRgEb
	6+viN1D7tlJ7KJ7rI+83J9GMzULNfgXv4THvfkBmd1hOw46p6W3mSTZIkqMSOcxm6MAKJe5oVXi
	z/rkkB4DA0osly+VgEMSZj2B9We23ASYpm32/YMMOYDDQfQPnwwtS1gtyJTZpCu057c0=
X-Gm-Gg: ASbGnctmS72avS8BJYCDzDQXf+ILMs5qNJBocUBTqSQLwfvuluPHWYl8gILiIQ+vIxe
	V2icBCruphFiFx3lMgU86eeNKhV6nPz84OvAD50dkOlSGDNrt74qEN1/KBQI7QQiu/GPvbBDM5T
	4rnrRSZe8udHKUuX026T2TLX8dn+TmzxomfLrmdkE8Vk/o2ZSofaHAXJpJf16JLMwuEia7Hv2XX
	ZKoD5VGgfzPdkUPhknQjrXbRgVDRPrvJ6takc+Baouyjz26chOXhlZBT3inSsykcnE8niAu2BQH
	df2p9xjHprRnBDYrr8NOhnrir+MOKvXk6pzOhEprKRESvJrtyXyLg/pmfOqhvd2Fxr2SDWsZbjO
	VgXDy+3A+KPSEmNhHFesX5tWMH+gsYPcHtoo+S7f0S80HEA==
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr6237499637.8.1760599434710;
        Thu, 16 Oct 2025 00:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrFPYz5L+0gDGKdDM3zwqmU9HSI97jDmKx2e+L9OE61zcHAbhnCy3ioFU+PCD6S5glLBXkw==
X-Received: by 2002:a05:6a20:9147:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-3348d0b695bmr6237464637.8.1760599434258;
        Thu, 16 Oct 2025 00:23:54 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb116basm21248313b3a.30.2025.10.16.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:23:53 -0700 (PDT)
Date: Thu, 16 Oct 2025 00:23:51 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <aPCdhz+kr/Hghol/@hu-qianyu-lv.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
 <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
 <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
 <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>
 <w4kphey3icpiln2sd5ucmxgo7yp72twwtnloi5z7a3r3a63fri@fbebffeibb7p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4kphey3icpiln2sd5ucmxgo7yp72twwtnloi5z7a3r3a63fri@fbebffeibb7p>
X-Proofpoint-ORIG-GUID: t6iwh33xosESVuzDvRKzYE23MiEXK30z
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f09d8b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=AS9496Lnv1pbona6PS0A:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: t6iwh33xosESVuzDvRKzYE23MiEXK30z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxAKCAairU2mB
 +LKS5D2q2nwvS/Wih2pkjLOelmZoGoLfQo1MxjMRJDSZDdZr/fCYuVLwhbYmf7GH10V4Fo15sKe
 DowOauFvbxVLK39tEJswnAa5hVBi9AKd6fT1PTrcWMh4e+pIMBSzdTnoSgl18OtKTnZLxTo+fFa
 vGYa1EqDfbZzxfcg8LQ61mml4TNsZOlOZMS70PJw4oADsggjLMXLMMTPxK5V9cdoWKtFNiMnFpS
 +fM3FKDoORlxWCOYdqmScVlJvUni4bO/oT6WIvfDAnW/n2uZ/hvk8usZzsaNas6pggb/TpXt7J5
 bi0Epmu/K2aw+YMiBdH4YohFP/AIp2Y8qHw+NR8YvOTdLTKmw3DEMVH6XP0QGK9yib5gbUHSu04
 7mxm1kIggHGErr0d8RiZ4ptnA8Yw1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 09:58:31AM +0300, Abel Vesa wrote:
> On 25-10-14 18:50:37, Qiang Yu wrote:
> > On Sun, Oct 12, 2025 at 05:01:45AM +0200, Krzysztof Kozlowski wrote:
> > > On 11/10/2025 14:15, Abel Vesa wrote:
> > > >>  
> > > >>  properties:
> > > >>    compatible:
> > > >> -    const: qcom,pcie-x1e80100
> > > >> +    oneOf:
> > > >> +      - const: qcom,pcie-x1e80100
> > > >> +      - items:
> > > >> +          - enum:
> > > >> +              - qcom,glymur-pcie
> > > >> +          - const: qcom,pcie-x1e80100
> > > >>  
> > > > 
> > > > The cnoc_sf_axi clock is not found on Glymur, at least according to this:
> > > > 
> > > > https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/
> > > > 
> > > > And dtbs_check reports the following:
> > > > 
> > > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
> > > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > > 
> > > > One more thing:
> > > > 
> > > > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
> > > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > > > 
> > > 
> > > So that's another Glymur patch which wasn't ever tested?
> > 
> > I tested all of these patch and also did dtb checks. That's how I found
> > cnoc_sf_axi clock is not required. There was a discussion about whether we
> > need to limit max speed to 16 GT and I limited it. I may forget to do dtb
> > checks again after changing it to 32 GT. Let me push another patch to fix
> > this.
> 
> Still, you need to add glymur specific clocks entry then, to fix the schema
> w.r.t cnoc_sf_axi not being needed.
>

I think the clock-names too short (cnoc_sf_axi not needed) issue has been
fixed by below change.
https://lore.kernel.org/all/20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com/

About the max-link-speed issue, we will remove max-link-speed = <5> in dts
as max-link-speed is used to limit speed but I'm not limiting it.

- Qiang Yu
> 
> Best regards,
> Abel

