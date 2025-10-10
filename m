Return-Path: <linux-kernel+bounces-847837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7FBCBD99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62138352031
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2D25A642;
	Fri, 10 Oct 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPrEUSRg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9E22CBC0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079731; cv=none; b=aMrb8xAol92BH4Yww9678JpClZSDfzDX0prnzG32fJvlVfmSgCO1/M0n7EV8WFOwx1DQqvNS58HQwItRF8Lk+MsiEUi6G/yF/6MFMkYBIuT3b77l1wTP3JVmPgLOw2+IfxHGbkhaEMEiw2Pm6PK6urphkHwLvWvutjVvc4SI030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079731; c=relaxed/simple;
	bh=4vvvEMb2vuNn8UVT9VIvvwNLOeHP8FoAvPrXeBK9elU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3mUNmquRt5KDUwjbByD+LkRekJTJxQHXLaU1vEEQ58aFWlWnc1n1x/LIo+v5KQzKzpTITh8xgalR2t1/epA/66kyADaLV6bwagU4b/IKSle3yEMxx7uc/DJSdVqJ38SyWSTaT+7B7kQrB7ckHIetrol+Eg3qtWCluBzo4fgY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bPrEUSRg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6WnDt032427
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dQwvd11Ba4OZZPtdkUFVNZBI
	SyWrAhGDJUfi6nuz7rM=; b=bPrEUSRgzrYc+3qyDhpzEtMX0lGgR34YK/st6XmK
	/hXfeFDPAEpLbIz7Oj6mffsVD4tTsH4UDMQ68xFLSY6V9DGtH+G7BJzCoLaA9Zo+
	bdG8gSiA2AfcdnWS6NCURwD1cJXt2wJuLyHpV3Duui5ZQMDKXtSS4lKgXxHEZ22O
	XdvKxE29Kg1b8zUzYvj4v60/CtcAvXG1iNtiFLCrlMckt93lfNBKsgXS+MKGb6Ky
	vgg5X2EaFZx2eAFj2kAN4dze2eXDXXt2oKi2ODZCORdlC9ZgONUGjuq33eDniGde
	WNHiSjlAQDoqxjDVq8PmD8wHQ6CKX1K0RiOxHvdpoAzPGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kwehv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:02:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28e538b5f23so35819125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760079728; x=1760684528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQwvd11Ba4OZZPtdkUFVNZBISyWrAhGDJUfi6nuz7rM=;
        b=v8MRBeE7YWypJRUe8c8hs30knC9m8j3HV7zZUxim7smB1KZXn2fGPGZQ1+tZSHfmFi
         1+h2HuAL+dK2D75EIJyJNOEoz1dIc+NqoNiilWTFKUgCYp3ExtllhfYpErVKWrwrcqrq
         xtnvfKpEOoGz5t4AvkXAtBn4b8s+QQPX3aD4iMlTHpJ/uNoO4MffVMBIjVftCGULUHkn
         Nk0/9dZpGLsmB9SEOQ2vSI3W67z3xv7N7zhomosXiaau61QdaZdiLPqA12P5sNzP2858
         ehSf34h/GQida1GwoAJJbi5Qc+5YcypaAmJKCkW180/MqxMcPQ0qojudE2Y6TS3Xskz8
         OLPg==
X-Forwarded-Encrypted: i=1; AJvYcCUWZhn+DFA3Z+8OY0cHxdL7IocVGUK9gFZKs/VOBtEWD/sw3AH3iHdqSRFbaAF/ivIZohGdChdWgBuzRUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskLqfrkkiD9CPGfKCxboqftaBPr/SFM7ULDRtbhpiY7hiI6WD
	1ufxg1N+KF9gxT++VMe3eIY3EiWZuS4Jd/EYGIlKgFIXKJrlv4d99PDjbsTH7wNgyWKLP2iN45h
	YPG4SUUCpIQXrkq42FGfpWNmE/vGrPoY77KI9Lnoku0a/jXrfhX0F5ikHcz8YdtTRvd4=
X-Gm-Gg: ASbGncu4u61ROZxoXzdJX6fXTeBnaD1lNXlM4a1G1Dwm/NTBjl/qgyLjfud+Msuc2LF
	5/bG7CEQKEQdRcpnikpquF0Hbup7zOOnZthuczAZprgX1lnDR4nOciV1Te2Z0DgzLC1siUA4r8n
	hbtXV1lPTL7U4KiwquPIc4GL0TNaQqWBG6KNuzIqDy2dqrBC4J7001/XcyCD+NwZFXutIRH9OEq
	/N+bFBsTIdL4xqt4xxLj1vPcYBL+kwTBlJ2Hsi4DsGGJiyU1LGYJ7MPUpBA/8N3z59rro6adIj8
	s7wocPp70OXYSrPvqzUXuReR7B2EEqowD9WCDngd9/A3CW/EmBokfWYFZHInM6ribmCS4WLwhe/
	s1HumOim5ygA=
X-Received: by 2002:a17:903:1b4b:b0:26d:353c:75cd with SMTP id d9443c01a7336-290272409c7mr142515045ad.21.1760079728475;
        Fri, 10 Oct 2025 00:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXYefKjkw/AY2CktNp8R5G+EiBMLqaA04w5BsZCP6mW9dFQLgjjEQp8WdnscP3rBXH2Ry6Aw==
X-Received: by 2002:a17:903:1b4b:b0:26d:353c:75cd with SMTP id d9443c01a7336-290272409c7mr142514515ad.21.1760079727974;
        Fri, 10 Oct 2025 00:02:07 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070ecsm48098155ad.60.2025.10.10.00.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:02:07 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:02:05 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <aOivbf/U0FluPsZj@hu-qianyu-lv.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
 <75d8cdc7-60c1-44a8-bf6c-0fb1ef38dd70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d8cdc7-60c1-44a8-bf6c-0fb1ef38dd70@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5X3Zi80DLGaB
 Sj+AZfT1AVwU7/x3EIgX+KmJuNwwgNpOUeuCPSzGHDVKIGMmMKa1oPyldOUSRAXNBdkmoCWMl9p
 M7I9p29nGnS5AgSzCo29JoCdvm2W3IKVtXR7UuNjmoWOXwrAdU8GCCNmDBcAkyIDsKZVh4ZFIi7
 oMy9XMVrHT1Xq/FIvEwDzCbcTdB2OKRZHszsX4EG9Zq8+hqSs8U7NI1Fnkr5pEFbWqcgzOO25h2
 wtCzwtNyrncsJC6lyw4Z2SbYCWpyuzKAld5iknH+tEkbNIDCe12aAgFMipIaQ6lCLXwP5jAJjXW
 eL10jg19YAttsTWjGYvzrAlYlW2NHroci2J9jBFqW5dt6nvZv9cBc/SvXm0SaKoqtlkOIil3iaO
 61IuswUsJG/FmOs6jcQ7c/QUOvLLwg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e8af71 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z4uItHPOzOwcMgdkeGIA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -9nq3IZVxjqOdiL0rMappiJBZmPYToLM
X-Proofpoint-ORIG-GUID: -9nq3IZVxjqOdiL0rMappiJBZmPYToLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Sep 25, 2025 at 01:32:04PM +0200, Konrad Dybcio wrote:
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > 
> > Describe PCIe5 controller and PHY. Also add required system resources like
> > regulators, clocks, interrupts and registers configuration for PCIe5.
> > 
> > Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +		pcie5: pci@1b40000 {
> > +			device_type = "pci";
> > +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> > +			reg = <0x0 0x01b40000 0x0 0x3000>,
> > +			      <0x7 0xa0000000 0x0 0xf20>,
> > +			      <0x7 0xa0000f40 0x0 0xa8>,
> > +			      <0x7 0xb0000000 0x0 0x4000>,
> > +			      <0x7 0xa0100000 0x0 0x100000>,
> > +			      <0x0 0x01b43000 0x0 0x1000>;
> > +			reg-names = "parf",
> > +				    "dbi",
> > +				    "elbi",
> > +				    "atu",
> > +				    "config",
> > +				    "mhi";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			ranges = <0x02000000 0 0x7a000000 0 0x7a000000 0 0x4000000>;
> 
> No I/O space? We can also add the (presumably prefetchable) 64-bit range 

Will add I/O space and prefetchable mem space since we don't know which
device user may insert.

> 
> 
> > +			pcie5port0: pcie@0 {
> 
> pcie5_port0:
> 
> > +				device_type = "pci";
> > +				reg = <0x0 0x0 0x0 0x0 0x0>;
> > +				bus-range = <0x01 0xff>;
> > +
> > +				#address-cells = <3>;
> > +				#size-cells = <2>;
> > +				ranges;
> > +				phys = <&pcie5_phy>;
> 
> same comment as on the other patch
>

Will change the order as you commented for kaanapali patch.

device_type = "pci";
reg = <0x0 0x0 0x0 0x0 0x0>;
bus-range = <0x01 0xff>;

phys = <&pcie0_phy>;

#address-cells = <3>;
#size-cells = <2>;
ranges;

- Qiang Yu
> Konrad

