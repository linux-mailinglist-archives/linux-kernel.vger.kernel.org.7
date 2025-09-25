Return-Path: <linux-kernel+bounces-832994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B105BA0EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0685B621888
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335F309DBD;
	Thu, 25 Sep 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="naVBIjHC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E082AE8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822398; cv=none; b=egWr9ARsKkMANvmNdbnaVvTKT+XAnDLtnPoT7iZxa0KUdC42YsGfz/STsKpB1y4eZa3R08cR5t2JxWJAsG0i+9xlqX549JEV+f3qcppR5ZKvHpSVBlYS/Dpwaz+R7VNC/Jduqdiq7Q3HW5PY7w+AjQA4UFkiPA43AkFQASWNGWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822398; c=relaxed/simple;
	bh=rnCHfcjkCbQZeYmNGToYBTNYRRFpSbtir+WRvkjq+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nToLjygr16EClQdzW+dN+IB6ldbn6EgjMIVzZAa8G7u61kJAyIKPZ+s4QSSYWwDHelm2kT9ZXTiWgNeCcGkSbGwYLV7VCI0iVHZElL3aDLl5tNXBlD9N4uRzJ4EaQ/uPFGwhWyZ+xqPmqaJNRazItvFHJ9Q3OuOXEyqm8eYnxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=naVBIjHC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9jEA7025075
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9Q/N6hIYwHQ+P0nSlkF9uEXi
	09HCftUZJLY2C2kGHgU=; b=naVBIjHCSqkOmjc9QF4od+TNzU/hJB4WqFHAayoa
	kP8GFkYHnzZ+4sDLfzFZDsXqjQPolAk6BCIycbLFSw7vMKGwLcn8L+3V1gFKEEHE
	B+6ukTyxfJVbbVfWP3A9/6D+TqGl87WxW19YaXsRH/FA2X3sDjmNz1btK2J7pGRT
	PyqyxlZ3/ED43R0Z3sj+OMH6mQCCvgLqnFebTENoc8ksHfRGBEwHMm+fZ8cW2/Cn
	DPb5QtuuJJV0z5/YL5eLJnDEBi0rOCFiwkWbW2LmKFrr7gQa8C91U5LvWAdL3M7y
	AokX5M/D5DDLbkin1uYvgk2xOc/TfcJafkZuJVCSfzds5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf1dhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:46:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4bf85835856so33959701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822395; x=1759427195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q/N6hIYwHQ+P0nSlkF9uEXi09HCftUZJLY2C2kGHgU=;
        b=UfFiQUyrYk8iEsTj3md8FfTGtZ3h2yRf3pdw8BAyIrHUbm3ZzMQlNBecnff8FIAcj2
         xEHHQrITxG3J/CydbvW3VEhHbjuC7O08cYx3N/MYXuhzDUsdSBJtH3FLAELemE7PSMFk
         YTUus4wSipfdSOZRBKt6/hm3fb1x59wIHKaLfbT30MHo/V6EJa5NjVP+N3J/9XKgTE7E
         X7AalqmhNYq9gP4br04V9mCFutQz42MWPd5qd2JkZ8ssPlNKlgkjvOCQ9IKC9HpI+b1B
         ee676nZvJhg0525hbzl4jL7R6RTUqcgkHTGPSSNWe+l/LOUbT4a58RWqsvBF8nhcLpEV
         K7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWfWavpmbVe2iravq0z6uuDdrRGUupjpUPuJmdLKgbxrSV8dfZPsBrjN5DHyTwzKKG6tY2b85byyIamWh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNTvYZ5WvhVs5e9cQhFflc/0atZ7cux8Swgq6DdPmtmK6/bcG
	SrVEASpdHBeBxRlav0iKniIRqxbsUlN26squcmVO9IrshIH9DYH9YrFPqZLMFv4TirLnLV1Odq3
	SL9ZVNo2H3FudJixmRIBIFaW+h30oh+bjDBIWYfM0sbUd1GDodbb3s2kXOJ2Y85551F4=
X-Gm-Gg: ASbGnctCH+vEskLn7353wHk5v+NFx7Q6YuxEnDzeJiBSNWpUpIm6dd/w2FLlqEHPTtu
	tWlxzf6dLLPNpoHvvroM9Q7UqHabky7J1kSM1X1RjGINylapDjoU40RAtXkfyAYhO5Sg5bJXZSM
	PcoF7F4G98LQCU1RFs/D4o+4CpD8ZrJChBflVc4J31i5iMf4zRsiCcqBcxQel6FPxxujNlnWuui
	Mq29DPS5SEoF6AtxkYRFyK3SJRUUvuFSg4ny/X6H7HhrAGkYmSgh75Hynal745uK4osKmeAujHb
	pj9CzgRaNJKrIoEdp45NoPvoi2q7klLfCzNG07it7MK5/HJ4M7krFpQIqm723wMaNNwJRifJLyI
	FcMxf8jVZMmQbwbuBGaAgMiCpmYeEkLPf8zJBB5YBiPmxigC81/1R
X-Received: by 2002:ac8:5741:0:b0:4b5:de5c:deac with SMTP id d75a77b69052e-4daca2ec8f7mr43031591cf.18.1758822394932;
        Thu, 25 Sep 2025 10:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3egfUJxHuAsEbhmYEP0wHaUbXOz317Xca/Bso18ewcD3TgX2j/d5l1PbzMwB0nOFVRZyrLw==
X-Received: by 2002:ac8:5741:0:b0:4b5:de5c:deac with SMTP id d75a77b69052e-4daca2ec8f7mr43031201cf.18.1758822394345;
        Thu, 25 Sep 2025 10:46:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313905324sm947949e87.36.2025.09.25.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:46:33 -0700 (PDT)
Date: Thu, 25 Sep 2025 20:46:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
Message-ID: <h3omdnam5tdosczvwnqwlbjgyksvfpdbhd4hpmury2mcsozavt@um4pqzvjzz4v>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8828946b-3979-4e7b-a11c-740d8a6253ce@oss.qualcomm.com>
X-Proofpoint-GUID: Ycve4QAUtFDbFpkqTI1tyM5YAfz8Pqpk
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d57ffc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=njmFF80JpxCvrK74z7UA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX9BVDVvL0GDUB
 5+TrllaZ8SlE3NEes8HZTbeFuaNj/yXdeiNvN657or6GVHsyTKNdQVf65n9bCMC+tswEzKTSQIH
 tQbq/AV76EmMJJKihHmTczo1cuSEJ8J2OgJWtBcRSouhXrk74BeHBxGUze0m17DKeDvFW5DWJp5
 AQGs93FHglLBIZJiYMaCoGkKjIOaoU5RXzYEmM1KorGB+4z88Vy8HhgnvLI914G5/CEy3P+sTHx
 ixdyMDtVElM7f6Xl9UL2Qxxf6C7Zx9+GcEzcnPzSqt2QVpctq05bcjapJ+7Kw6Ks4ZxBcF6Cxb/
 rZ6JVMBuwBGySndhcmg5vOCJM9935gCObBpeWrTDVGookNEuygEDHkBWuxkOGqMd5tIypXTwoA9
 /N455rtP
X-Proofpoint-ORIG-GUID: Ycve4QAUtFDbFpkqTI1tyM5YAfz8Pqpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Thu, Sep 25, 2025 at 12:18:29PM +0200, Konrad Dybcio wrote:
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > 
> > Add device tree support for QUPv3 serial engine protocols on Glymur.
> > Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> > support of GPI DMA engines.
> > 
> > Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +		gpi_dma2: dma-controller@800000 {
> > +			compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
> > +			reg = <0 0x00800000 0 0x60000>;
> > +			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
> > +			dma-channels = <16>;
> > +			dma-channel-mask = <0x3f>;
> > +			#dma-cells = <3>;
> > +			iommus = <&apps_smmu 0xd76 0x0>;
> > +			status = "ok";
> 
> this is implied by default, drop
> 
> > +		};
> > +
> >  		qupv3_2: geniqup@8c0000 {
> >  			compatible = "qcom,geni-se-qup";
> >  			reg = <0x0 0x008c0000 0x0 0x3000>;
> > @@ -718,6 +744,339 @@ qupv3_2: geniqup@8c0000 {
> >  			#address-cells = <2>;
> >  			#size-cells = <2>;
> >  			ranges;
> > +			status = "ok";
> 
> ditto
> 
> (please resolve all occurences)
> 
> [...]
> 
> > +		cnoc_main: interconnect@1500000 {
> > +			compatible = "qcom,glymur-cnoc-main";
> > +			reg = <0x0 0x01500000 0x0 0x17080>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +			#interconnect-cells = <2>;
> > +		};
> > +
> > +		config_noc: interconnect@1600000 {
> > +			compatible = "qcom,glymur-cnoc-cfg";
> > +			reg = <0x0 0x01600000 0x0 0x6600>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +			#interconnect-cells = <2>;
> > +		};
> > +
> > +		system_noc: interconnect@1680000 {
> > +			compatible = "qcom,glymur-system-noc";
> > +			reg = <0x0 0x01680000 0x0 0x1c080>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +			#interconnect-cells = <2>;
> > +		};
> 
> This diff becomes unreadable really fast.. please play with git
> format-patch's --patience option

That comes as a price of split. I'd totally suggest a bigger chunks of
devices.

-- 
With best wishes
Dmitry

