Return-Path: <linux-kernel+bounces-749297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A21B14C83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B983B3C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94028A73F;
	Tue, 29 Jul 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQ3J8MGM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D828B3ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786176; cv=none; b=t/eUEvo+45ZiOlY4GGM8pbhA2LMBP4x9zs+TetTnuxU6UEzvP3QyzCp2X00ypJjLfi4r3ik62KbsZYgS0JZmsmFVc/lfUSrYZujeIrqWSSH57/QeHPNkqkvNa0fVf+sth2ZeGFa9tVebk6vR1Tj1JxyPYjv42EKotzjvq1OZj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786176; c=relaxed/simple;
	bh=vUdyfTdjbF+l3su631l5cooBtaC3WlleYouL0ydx3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOWHIg2+oiJZFkroRRajj0YQw2bq9ep7ig2T7UyzTZCgYic2HRr7YzojlOWFQXhdBw6MdvLL60oORY1r5ElPp7tSr/xyYeFKMIKiSu7a30hyCrYHz1GQnk8MdIlC2DX+bYdOiOkta8UptphiY9o5Sz84RSaXc1VtgLDacX1P1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQ3J8MGM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T91nIJ023447
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lo5hcIj++3t+Pk5CHCpA6OOx
	qnwkB/ZqQgNwTp/vi58=; b=KQ3J8MGMx2ou2NCU7VYBeXt19vAJfMqVfNj/9ypd
	0BSOxe0HgLgumZ30klRpZzBfzJseh00YNBfVMOWXaGMzug31SVQpplld+hMP5Uka
	uGYWwjbAo490xmiLjPP4jcWVFxrFvAtTXNsVF+ByODS4UdCK7jnVer3hETec86Ia
	SZM2tgeHDGPmp2MQMKXwuw/SJqk82PBWFqKO6JFewh4tExPUtqcAPYR0U/eHbE3x
	QOe5WyFTVd5wNGvJIGEJJKdRHCvwR0BnAhjQ8Gmh8bqZahaL1YYwnOu04LKO6/sq
	cRvW4xo0AAdT3SiUecGZwezPtUkICm9XzvHUuVshydv7TA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qqrfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab4211ca00so146827331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786173; x=1754390973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo5hcIj++3t+Pk5CHCpA6OOxqnwkB/ZqQgNwTp/vi58=;
        b=ppy0XumM4cLoW2KY2l9grKgMWYep94NjYfLG1WyWBli9g17hk7abqLFbEgox0w7Xev
         Wp+YXde8i6q7ZI37YFknKrTcXnewsAKvMT3WgfCVikTrPgPiJq2H+B9/EaYUCYUsTY5U
         L78trV6yioPFVSnKwnfDUIwML2yrG7wGz/cdr5XKlxN5+UZxhe1/RBb74Rlv12/8pG/F
         r54ALsrz/2Pe9oWEPiWXE/h+Uox4MUWGojB3lbNwbXtxvs5fBL0Tul/DG2FGpuZKEwww
         hCgqviOf+RI8rzsgUPgcrBZrCBkwjl2xffZXmY3eYAZVtcD/V7Cavp6Gq71xq1qLegGN
         cpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMMvVbYPUU1Hd7J0p+OXLPFm94EUkh8Cl7+RzJaHBtaxrGTcShO+hRaeMIJ2JJLR5SFqrOMDh7nbZZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugyCMvYID4Rniq2aM5A4TWXVMX425aCPfzvoxq+2zw1rWOXAA
	un/ayLBE9KTtdc3R5S4jYrpXYELXuqnNxaVaZOUVP0wNxyPBVJoyhLlAUsKy03DhUXPY3enS1SM
	7KeeeJC8dMuUNt1FUpZh0XIUpEBDvkfz2eSRLZyBnzzQPurv6bfHQb4yxulSxa6MCsqk=
X-Gm-Gg: ASbGncv26ia372fhyZ+UAp8EXpgEF9uCi34EDIb6LsdoZDLNR0Eljl+3KpJp9C59BV8
	98WSOdfHlI3IKwcaDy8EPUh+Vev9s5AjQMA42gk4PnF7rSbq1zIoX8iRGTB0tTK5w+7Dt4xV6zh
	E3wJM7M96B3OVmEKqfz/+T0VOPlVIx0vkmhcUX5obx/KgSWETtT0LF+spHRHbSYbHxSlid5dfnq
	ZIVlBVoPlBIqMaVJ4IfEHK9wyivSpQKRrS1AMSwHWG5BnJbe8mn3ckKI4bF7oOVNwVP0CF1J/+z
	xO+AncBKOpSwIZ/Yu4ZP2MeVeeT3ZZfnw48n/R2504FfXYK7Dt36a8+1/fsCBNw0X8o1spFtAxm
	wnSTxYq2mhRGGxb0yndHicU7+JaYzfEd7d7ihl5+FOStcTofKZBBv
X-Received: by 2002:a05:6214:300f:b0:6fa:fddf:734b with SMTP id 6a1803df08f44-707205aeaf3mr174250066d6.24.1753786173110;
        Tue, 29 Jul 2025 03:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJD7qzRsibNuXaKYj25dTlRQLHEQU+p+3CjeKzyh+6IunNWCn9ZNOdwvfaAwF05to0NXbu7g==
X-Received: by 2002:a05:6214:300f:b0:6fa:fddf:734b with SMTP id 6a1803df08f44-707205aeaf3mr174249386d6.24.1753786171940;
        Tue, 29 Jul 2025 03:49:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b631a1b6esm1645910e87.77.2025.07.29.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:49:31 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
Message-ID: <63iuccupcdhzlo6u4j66vr5latfabjpbvtvrq4gx4lmxqsqskp@4yamwbuv4ct4>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NCBTYWx0ZWRfX5EQK9uk4mp0b
 FheTrIedOARbblZSrEQ2UJBxOHPw7jPn4x7w4M11WUJHzsTg/P0mn6B07JwQ5Ut9MMwp8euDvMR
 9kAicbXxHY9haLya6ZYGH4/bHY1YIPuAGvXZ156IV1eIimxdg8FOtbCvferQ+HIrjdGBIso6zY2
 JA9fX3Eqok7vr3aAg9jAuvXTObVpbKRCFqVpbu1IB/mSGg0d+yR+JzoEMarkXDEwQvXWq4SWC2D
 h4fXJGyMYKDPI+iAJ4IxFNUldmj/eyjYh1MgxroJx/yffZk17chxeWNkeXc+N/9mXolnGJz0PBN
 /j88/HnqBhzkRip+JZns4A/H57H4lRv0FypNOAbx8xq4hpMgWMLixPloWvijbDno/NsCqAGMORJ
 xaw36E7qaby5QR2uF4ZcAsGadeZBTMUouJCk0h6S1bdABXo6VeLvVca0sG+BxNmelzHnZ44U
X-Proofpoint-ORIG-GUID: GLTCd87TGB2IqvZsq3VnV8vWXX9mWWZN
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6888a73e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CzopthhaEyFBFQvfYY0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GLTCd87TGB2IqvZsq3VnV8vWXX9mWWZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=756 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290084

On Tue, Jul 29, 2025 at 11:12:37AM +0530, Taniya Das wrote:
> Add a clock driver for the TCSR clock controller found on Glymur, which
> provides refclks for PCIE, USB, and UFS.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |   8 ++
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

