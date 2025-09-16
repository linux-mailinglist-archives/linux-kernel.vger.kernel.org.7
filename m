Return-Path: <linux-kernel+bounces-818555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7922DB59350
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E72D1BC5A72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154624338F;
	Tue, 16 Sep 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnSbv5g/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E927A92E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018039; cv=none; b=EQiHv9IxkGN6Y5+uYgkH9pUG0Yvv2TCBYWarhH3AYdp7B2eKuEtzq2kepn3dCnQJ6Bmjdr7U8BsSZQy4R3oehBR8D1luiAG/AQANNxGSMd6LRsfJEr80tjA9HQNK53/+kmahq0Lsl6j067QNJi972a6YhQyWWcH+sFYMKFD+lL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018039; c=relaxed/simple;
	bh=Z79MuAHqLmnfhIXPhPe1WTgGzRY3sqQwPS+B2AZHKGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7RRIdJkE6nzdEb7Y+8uB8E0LGbtg2C3iwyu9iQwyLpOXXJ89Q7wMCsxZ4EbOEu/cS5i3ZtBm3mIWkrhyvbULa/IrghggPyFYE5z5bTZ6keN48OKgtB6DnMIUxATTitu7Zsh9J+x/EU/ouu9WSi1v+F8+eJ2AMZ7YGkeq+B4VTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnSbv5g/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3qiME014551
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fX0Y/gtR++vND/LuB2Nc1fsO
	EUd47UfUpCZUEjof6Zk=; b=GnSbv5g/5O3hW81nWJ7ffFKFtbH9IDf6UXsaINIf
	SVCUblUcW/qjJdYivWkOQe5zw7uZxPqnBiTqoB4SqZRsoWGJFH+sHFgSxs/vNlAG
	Lu4e+AiGiqK6CzA/QGQFteHdh00+C906yXsYkVuvsAxbQspaRpyHsyFloSqbgVv0
	Z9vYFcglIbaoYgUb2qvYygdfDMKTJQILB0YktwMLKwmTL8wPbC09UV8UVcATpDiU
	oOdBCD9KRgDv8RUWuX56xPHtpbe5/2r7yS88nGLpC1Jcwcq2XHbjP43+2T1rQaeX
	sIYf42LSBb33dU2ByJU1S+iVzTy+fZSYIpytDI+qXjhuQQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072rg3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:20:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b793b04fe0so60202311cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018036; x=1758622836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX0Y/gtR++vND/LuB2Nc1fsOEUd47UfUpCZUEjof6Zk=;
        b=B8cqNWdc6HvZ50ugtm17diJyjtku/JvgqPsdA1fR0z60hx84BmOq2yRkVkMupNYAuL
         k+ITWiejIZn41ARG3FJR1LJrZMf2Qk8a/Jqz4voQ6E7IIG6C9ldFHHjdPHxYOMOXlGqt
         GbcDclvt08Ga9Kpvz9RYsZvW4ipVM9RgMV/Kzb2wo7XhbcjqLEXIH/TRQu92XwydbDs1
         PG2IhxE0O7bKR8d1c4H7CQH61Mbp89HaqqCyQX4cVoloozsmQi61CuEEjmaTzJmMH9vd
         hOj9/doondgXfUUAmuU/NqZ7aIC1aMYS+lyitoUzQr1AbgMvDludm2d4fEm9RH5vG8qR
         sJwg==
X-Forwarded-Encrypted: i=1; AJvYcCUaAeIh8oCBMNMXe11BKYkMS71hxKg59i5c0u4QFEt6DpNIx97eIOzeLTqDdkUh3Xv9IBIAXvGrKECyZjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAQh1b/uQ0LqhJeKjB8mbXMQeHiryd+Xr8IIS25iFdltpa8Wf
	O+iPLrDpKiX6JNbjd/oiolyvftSwb2FakbCDjiEceA8rdaGU+SK1qx6GS4lvaHVzPvmJVpiSsWJ
	PlBiQB+ucNKVjEb3sYRwQJN+1NYN+BnmatiaC8IggygEFEoatUmRkZYJKQfwPeLdpNyA=
X-Gm-Gg: ASbGncsyYcxXQg/bv9rCBBHMgm0anrnzE3vvZ7WhVitt1CLGKYvDlc1iWNgWOIj3gjm
	PgtsBr55On9/0MYFh/oRfcPPJmnBgOciD6qg0AttprKHZ8Ezll2eYb8Z8G0BzxN3/QgbGcClGDD
	ZrrnHWwigMercy/xpV0rJZ3aX0eejCh7Gj0tbFH9DBmg5OfWCp9p73oRC0LlPl5l1fDLTW8ajPT
	nCaP4iErdYSwIryDKGd5wLDrYdE3rL1to7f+SE2DtEyo0ovggKYEoV/QtRltVRcHIKqeD1WNnag
	2dpWlBs2Hjtby9FRNVlMkTw/mUk5DlpZV7xgf5PONcPCd9CG9zrpa6Ie1eMXZBGj2Q8pDxgP/te
	PEititPQ7GTkjmA+ImD59dTErLAzCIXLW4okI4yognXAmMKBe+DYd
X-Received: by 2002:a05:622a:4d45:b0:4b5:e644:67e with SMTP id d75a77b69052e-4b77cf982a8mr262930401cf.16.1758018035902;
        Tue, 16 Sep 2025 03:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQ1pTniGU4JXGr/sMdK5biZOWU0CLhI+tTtSwMj7eFmqrGcBZ1WkDskr95Pi8m+6q+eazYQ==
X-Received: by 2002:a05:622a:4d45:b0:4b5:e644:67e with SMTP id d75a77b69052e-4b77cf982a8mr262929951cf.16.1758018035258;
        Tue, 16 Sep 2025 03:20:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211d6sm34724701fa.43.2025.09.16.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:20:34 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:20:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] regulator: rpmh-regulator: Add RPMH regulator
 support for Glymur
Message-ID: <gsnmpdxnuihagle276sagfcxpblxvwtjztb34r53f3nub7be5m@twj5lizpevpd>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
 <20250916-glymur-rpmh-regulator-driver-v1-4-bb9b00e93a61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-4-bb9b00e93a61@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX7bRSb1b4k3de
 6gNG/n77sJ59hBfBo6e3zFB5Sb8b3kjC/VPO/jFEKhgbg7mUaYW3duQKS40c4NeTTcQHP0sgJ1v
 H6Fnudvn/+1PHWLlD37xuGyUtaSx9NT72MMIaUkb9/SdmFd3gjxNhf5oj76mnfUy4D61pvuRBwM
 aYsELB2NYa898tpdOnfML+bF+AV98rnU9eU9mDU786zHgRg81FaSiodWyFe0hRP6pbMsBcAcOo+
 MTImM24BrummR+YpStzsfSRgImA0znnBl59XqRqPv1kbkHSabsTYIZ/d4g1HF8HJBPs5y50+UNb
 GEZV2S9aAT4Iy6lTsObS46C9/+QwCKTqCjWgc73WNMIc7jHM63HpT8tAQCpDRu1j605dkmsyQXP
 liNKX2dl
X-Proofpoint-GUID: gIq5tg8iiuj8GkN1WKguITJ7EzkhD8x5
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c939f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=A_yzNFqrIlXfnZhuJ7gA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: gIq5tg8iiuj8GkN1WKguITJ7EzkhD8x5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Tue, Sep 16, 2025 at 01:28:18PM +0530, Kamal Wadhwa wrote:
> Add support for PMH0101/PMCX0102/PMH0110/PMH0104 PMIC voltage
> regulators which are present on Glymur boards.
> 
> Introduce new LDOs & SMPSs under them (PMIC5 subtype 530 for
> both).
> 
> For these new LDOs support a new optimum power mode(OPM). In
> this mode LDO will automatically switch between high power mode
> (HPM) and low power mode (LPM) based on the real-time LDO load
> current. Its operation is analogous to SMPS AUTO mode.
> 
> Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 188 +++++++++++++++++++++++++++++++-
>  1 file changed, 187 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

