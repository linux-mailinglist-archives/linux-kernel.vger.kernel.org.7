Return-Path: <linux-kernel+bounces-874706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97459C16E76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94173B609D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7C34F48A;
	Tue, 28 Oct 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxi08bX2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gU9N0lKW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ABD2DC78B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686135; cv=none; b=MYFYcMRzBgtNw0PQj+M3AZBqmL6Ix+Gft9cKkNiVUnqfBuLQoU5zBdM6C/+RJ5DAeydAPcSv2x0FHi837L2X3N4gjIqaONYnNUP+Eam/dDp9v5z6KhKJDWYztvP9r+nAbyzkqkz79+RwkQwWpYvp5zylk+qDHdAm8VFdfiKK/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686135; c=relaxed/simple;
	bh=1SLvAEoZNQRLDp+XCv/j4QKTk2SclYwX86Ac4+yNShk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDiWmMXAGiRUvrH2UannBMheel+/eeJEPJEibLDskEtXOi2S2sv69w24yBtqEn3aXmXVEoWvd60ERrvPjVtJYD2ygVl6Vig0IW+C+wdED5Dkiv0Sund86kw8tIMCEZKJRRiKor/lkWHnWCfD11TMmu+uvmqGRx2lqWCkf7XBAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxi08bX2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gU9N0lKW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJldjA2539768
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QkpH6v9dp0MRYRL2ohSXE3M+
	TFxAVIa572J76dWKJgA=; b=nxi08bX2IU4RaynuB2unIXksIEnyXSImy8QR3tf4
	wW4scOJqraycDpqGHrXSAQb0NWJTRBQ3879pjBeo6WtfRbd5GNaflYIu4ONOfthM
	0UclQFVLgXg7lWUupC6gZkcAwggCVMWB8QqDOFcAGLn99cZLb5yS1sm6FFkvGU6l
	4IdFYvhYxIZk+SmMIuPeeGUKXD1jJYedd7L/hA8gmNuV5sjbiGEb1OOPpJ0LmL3F
	Ws1MPTnVhMr2BNzihnGtWx91/Q/E2iNnE38hE0t6gnMqGYk+Bjvr1an36a5j6Ekr
	FiOSazzsg6o33kFGxRQx2KSIpB0CVyCmhp6prQtkeqnNYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1g6g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:15:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf5d3b758so83921321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686132; x=1762290932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkpH6v9dp0MRYRL2ohSXE3M+TFxAVIa572J76dWKJgA=;
        b=gU9N0lKW3kaRi/r/cBHTt13xNFZ8+946QSwKzgTpnctldN0kzAnu0+j5Cl/lVdq+W+
         3isw2A9WwJb8wlPDRB6o6Nzrm/FNhUcxPqv65jKn+WzRHFdTFt5C+B8zHYxSAcu+SBKy
         HDsa05G4MvP7Dj09/RL8dkDKzlHF0VFMEAytmrxFf7Y527ilRlx6NjIrkdecLpnuXiys
         b2e/xxBu43HIlho43caRDDubvqQeKC7rs0QQ1ci4e7yaHIBHcpUbvNp1nZBNc6kocaYe
         wPsCOnK+Zfbl7YaBQPHZh4sJ71zJeM0zSiruKwv+ePRbv88ZIv4Q0Iuou/jn+1WXSVrC
         QDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686132; x=1762290932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkpH6v9dp0MRYRL2ohSXE3M+TFxAVIa572J76dWKJgA=;
        b=sixKRBfehpRKQXK6Kdfld4O41cNkeJ5Qknir5pWf2MbF/zKDuQePhMC7FCTd2N8czq
         tQhIy2bZzKTutTFs26lnZZ/Tl/srrOOeAudGPkdhlu3TSqliNnYS7WxaUgemYbMeEwbK
         n+YmCAlbeOzXGMXExGJZIUebaBjIubP1w3r7WKXr75cplHCBSPmsLbrSn3Ve9ADx2xZD
         xltGAgik8EDwxoDtUfINaO6yaqShAVhVHOubEqrbmQovZm3+e1gkKzqUpjJ0qRP9tuZa
         F9p/lXMqvx28oPCnkAV+s5LJvPY8LcQMyIZYmRddb+6gUApnVMPmaA53OWBds+g1Va2P
         VOXw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZQhawFqX50KG4m53eorVOUQxApyKxh1RO1WQW3YQqhGDVMN47o8vnO/fMvhfr2EzN/uwjoQNxvKmsRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEYRlxuv8RdcnsMe8YXHuSCzHD7HQPT7Ulvu2lKWWambclDSu
	7OxYND2kZFLLCQ2eKSuMUuEZSo5et3tG9nMUQ9LwxeMALzZnILIjOFLMdSsyYMFfReAy2YEypgy
	Jq8Cm5PAClSkl3F8gzL08oQZW7Qb/OSLzZMAbKuu7W5w8OyrTvGkyzXE2yVrdYGbEqhY=
X-Gm-Gg: ASbGncuNV7fjUwqiNN6TENDoTc/U46ysv41pxFqnkJtf6OLmiTFfzqadw+9sQ45LjOc
	pzbJMH8+ixB5SiXpyZBBEmNFzJTwAD9o2sajp0c3vR2Y0YhYbtgMGYD2XAPBajWeRG2tR1Iwp5G
	tTXWfSS5DAbvIPctiTaT1pkjv57xnN7A3Ek+yaOq5OiC2UFWIy8cDf6q3HSJ63ckFuBisLpwQf3
	o2FdVxwZaPmm8z1o6kQdiSzEeu08J3LmvVXRAAEF6ncZWJTvbxV8Dm5oGX6jYt6/4K28l1Bs/XD
	uZW32R2YZTHdg5cEYs67b7EcDP7FCEcH7peBFP7lCHLqt5t8eqSA0+1q38tgCMOD21hZY9IUzkK
	nB+H7DJte9ChaF7rpzWA+gDJixuD1mbuBMyHHPIWj92Z0uBtHU3qJ+EliPFTbD//mbfUDF2kok6
	wq1uyU4U6TX1+6
X-Received: by 2002:ac8:5f4c:0:b0:4e8:a389:dde with SMTP id d75a77b69052e-4ed15c41cedmr9753711cf.69.1761686131526;
        Tue, 28 Oct 2025 14:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKCbOyz6J1IE9zwWL3LnWol43Zm3I7im5kTE/fmtuzRYUCbnmOO0TzpIxB75SnE6oGv5I3rA==
X-Received: by 2002:ac8:5f4c:0:b0:4e8:a389:dde with SMTP id d75a77b69052e-4ed15c41cedmr9753391cf.69.1761686131083;
        Tue, 28 Oct 2025 14:15:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5093asm3285266e87.37.2025.10.28.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:15:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:15:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
Message-ID: <r5zjb7v2ngsbx2y63tmdhnm4gbpla5fki4uzpjhvn7sqmzsqi2@7637rbudt3z6>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=69013274 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SMp4HK0SL3UJoFr3leoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Q9-Tr-4sc-jZFv848in6BNWbQIhjEKL7
X-Proofpoint-ORIG-GUID: Q9-Tr-4sc-jZFv848in6BNWbQIhjEKL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3OSBTYWx0ZWRfX1G2wiv+jzI8W
 m0fceP7oKymx7cz0GX84UMHxJIQpJu/WtDtRjy+oCrgp3gMQBp5jCym87iVTX6vT6eIwF68KpiD
 ssHRD9ly8v/3oF2I7IaNfCttnPpXJ1YakTUwCWEfyOYXvvXVJHx290XKQiFvGdvOgKMOMkOuqyM
 9hKkAnOGDIOY6IvhW/kIc2JWwx+nFWNdU30cjPgFxCbSOK3jW87JRdZZNz74yS+7XOOSw+/4Djj
 olhE+6BxKpYQk9MRBMlO9S08SSQ4S7Ra2WUbdwL68DWRYkvIpvpnvDe6Yzn73470pXslDNe+doe
 nVsERSeqHZe1O+LTfleqEnWVQS0q842GzZfr4iVj86G1dU9TeWW78bmN/soZT6rjOCB/lmxNte/
 tPeisa7ZMU6X76dJ3EFttv7ED0Ayjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280179

On Fri, Oct 24, 2025 at 08:45:20PM +0530, Krishna Kurapati wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> Enable USB support on SM8750 MTP variants.  The current definition will
> start the USB controller in peripheral mode by default until
> dependencies are added, such as USB role detection.

Which dependencies?

> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> [Konrad: Provided diff to flatten USB node on MTP]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

-- 
With best wishes
Dmitry

