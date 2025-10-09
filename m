Return-Path: <linux-kernel+bounces-846980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4316FBC9950
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C22C4FBD52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5E23F422;
	Thu,  9 Oct 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ep6+HlCS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413B2EB848
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020905; cv=none; b=MbagnayZuXEDBaAfCwvowvx8newkOnNgyIiOLU0n5cHjCgn7+8Ihvu0BY9ia6JTDN60nbqpahPcaMFQ41pNQrmjq8wXR1SzLFs6OAnvuiSJQq1oOeG29QO4WQqVach3NFPzsQUQKEqkIJ0MX5GJayi4HfYeqWWqVWADsHwyDLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020905; c=relaxed/simple;
	bh=HclYgnPF4LRbdDLD/Q8caHudhorVDWjtXDMuv4Ilhzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScdkmEoG5mZvp4ikP9TVUnHp+2xMFXCeqmIElaPxZhzSH21CI0MJSfatIFfL8iJxDJm8h/knSkDH/uTqh3rK4rJ7ghoTY+B6hCONMuoX7GRpRSwBmLPLw1h2JkwJEzpVFEywCZs8t7OFhaq8dLUoQm6J6SttWT7aYdNRrnTJNN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ep6+HlCS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EhE9029129
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qZxbfmQyGMX+bvx3enASN+Ih
	rNAG5CFfSD/AXrL+wew=; b=ep6+HlCSyQOJYq9gMKv7Lf5Yl4AvI8mXKlrQ9mtn
	3hF9uNIa6GCVtHHdvjY3B6y5oZQMwgNIgVgyu2nHqdCELr2MAJPaZe5o8zG0xmGw
	u8HSoS//g8O1z8Mcf6xxBwDGRbcunC1WVr7XI52fb9YR/GymuZpRltTVHt35XeaC
	VBmS1I/uKOi8WteNS+q6K/qEVAvbKQgJg+FV0aij+gkvAI+Sijy+LDSNcr05PVmK
	guTCqdFz4PwY3z12gCIxN5nJ+dDAEsBAExvH1Ao1SPtpvAWLRjP1dlFFF55/1YVL
	CHo7LaODkouibxY5AUaNgZZ+pFnkX/vsgFxNbr39bbDm5A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ku776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:41:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df60ea7a1bso35256931cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020901; x=1760625701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZxbfmQyGMX+bvx3enASN+IhrNAG5CFfSD/AXrL+wew=;
        b=JB0Iw602dRGm0faiadZ71DjXjDTLSE4gc9mm6+LLdOOY6Fg8i6Rf4+KmHXLlgAeAT8
         7jwDxGuaCrOEpCtT5LeiY59JaUqR8EGcPKInqlbicsyclwbGEc51o0ZiiKlhA+ghUPQV
         RDUaTn2RSkTi97tZlqza5258Wi32ZI/HChtj93OpCdDYCIzaTprQmtKn2i2lThSbbaJ+
         Se78kcQWCbr2QyiJKYslQWgHf/ef5VgOt+456xVybHLkfPjzzan8X49KfseqiPp6KZlW
         8QvktWE8OdH7qCrLT08HLSuyD4/celENqfcTwXBWE8nijo02+ng/mvmYzEYZzf5MjY1x
         QjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUtEm25iCG/7US51Nmhd2G2qivn1+Xa2ao5FTakhIFqxahGyIrEp/Wf7BcZKltdImqaSq2pVDdjKVRRHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBf8LJzwmUj5bf2OzoAvohQ/uLSB8hNT7LCrj6bD4s/RlpoHFI
	QDQDuoP21/C1arHvnw3OUQALd1nvUA0JEXIIsHntZ3w/rXLKYpStS0bWPA5Z2aR8bkGEKvCZIl4
	HHrv7DJgt2mKrpghKi0GHAzyzM0WCNeT1q945ZnIJYGmWZuO+ZbJg2FEpd09KXELJRCk=
X-Gm-Gg: ASbGncvX47Y27P1d0+8lOyQyDadOg9KJEVxzSl23cJAUiAhXVAU6eu0KOxZqHWH7jXs
	sFOA0TaoSXPvY37HGREYlYq0aLDTQK2U3H4g3inxUq7FGlsxnutxlY009LBvRDZLZBDHM2fZQbx
	gGloRIo/laPszDiTQqu3onA2J3lCPvux6XrmcLNEHQDOCwDYUI6wrLGYXa0BrsHqo+/cGaCgwys
	mVXyvVU8QAADdx6EZu4JJ8figHzuTT6m7R8P0omYDcXpz+eub3YcpuefsdPjK45wIPOdJ5VaQQG
	Z4/U8+387iqWEGbb1+jvEEyeIvgfbY4HlGkRsZR7Q0YKTsduSzKACEyT49NGsy/89fSpeGzDSk2
	EJWvOhsyhn3kibfHYkpDR+qnR1O6RnYAbOomLoJPLXgOmEUhqkGUl1XZaNQ==
X-Received: by 2002:a05:622a:507:b0:4e5:8180:d4fa with SMTP id d75a77b69052e-4e6ead4a78cmr98196821cf.39.1760020900957;
        Thu, 09 Oct 2025 07:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv0mdo3za5+5FAlM5CJ7wLkbh7iaSVKM8BbIGVMwJLYVlsYxxhzIKo+VojFEtceXLiOMhU7A==
X-Received: by 2002:a05:622a:507:b0:4e5:8180:d4fa with SMTP id d75a77b69052e-4e6ead4a78cmr98196221cf.39.1760020900338;
        Thu, 09 Oct 2025 07:41:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac1f095sm1108654e87.37.2025.10.09.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:41:39 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:41:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcm6490-shift-otter: Enable
 flash LED
Message-ID: <b24tiwwhie34narc4u3ez4le3cne3whjtxaccm4xtit3wldumb@ipgsccain72f>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-4-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-otter-further-bringup-v2-4-5bb2f4a02cea@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4c5zFabwL+O2
 rkG4bY8JOWogdmk/KJ/zQVHn7LnHmEnZAuhclwraZ3FgNbRYoeX8Kcme5VeK0rEMRW+1iXixBAV
 sEf4QOiJE92GZMRFpzaaPIJwDH/+BHa2GTGPQ7IxeP+jOhKLQ/yx5NYcEBY8hPOVco71HWgtgCU
 aSuGKyh+4Ypb0cJ14HPWkseifF/DWbFBOI3Kzne1pLWvnzTdtm+UGbvMVzeaizB259hV0x020B8
 iFtf13mDzzL7JIXYC+sQ6S1JiT3ws7G+d1L42+7fp5LhOuFcoYkQkVsNA/WAYjtkhwf+asaoKLb
 1rbGoiY50GytY53+YsEOHGT51oM4Sod0bX2jtC/0WUzHyTWdukz8U8wMJB2tTbPga2XVkVrgxy2
 XttkeTAeJcSPRZHgewPmGIXUXEushQ==
X-Proofpoint-GUID: GDltkBy6SdaMf1sKKIhzmUz9oQuJlepL
X-Proofpoint-ORIG-GUID: GDltkBy6SdaMf1sKKIhzmUz9oQuJlepL
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e7c9a6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=kDRJMEyxNqLK-ifJ8_YA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:06:34AM +0200, Luca Weiss wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Describe the flash LED on this phone.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

