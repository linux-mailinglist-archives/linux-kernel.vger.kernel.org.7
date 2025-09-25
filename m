Return-Path: <linux-kernel+bounces-831642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1799B9D372
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821C44A155A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2F21423C;
	Thu, 25 Sep 2025 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJsc3Gel"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834315624D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767928; cv=none; b=Uu0m2IqV0JzZBPgUjT65jgIYcAQgVjHZoYrrhRJaRHEWiAghAX5/HdYjlNgDgrHKvONdeApB7i2LYfWs7LqndPsFb2hbCz7SWr4ZAuGUALaYFBNaOfiJmFRws6xPPFbYm2xdA8G8lnVvcFbHsF2HFBgLZe3or3Vq1ncDvL5JqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767928; c=relaxed/simple;
	bh=XJUYhg0VFEFsFldPgT7FY7B/fRd3lwXDjvW6ijcWA2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB58aQqg1cbLIJvHd9u629+cJOkHNK5Jw6NH+M5ruOC7gJPNJSWSp1NHmMx3LN6SZ9+jIHiS0smNOH2GXFP+KVll5rMQQPYwLA/ItarfWz2dErA4jsJ9+sBjDQPZ4PgQybq0Kx6yXMc12LelYFMKlCcqQEnZMyH9/NSgrGxiNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJsc3Gel; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONx2bj018070
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5dBE8wCPmuYIKAvATllBrBFt
	XuoveB9RJyGGd22KLBI=; b=gJsc3GelbCCaxk56G1ZmWDeZOuARJATTmewX1iCN
	WySsOwM7j+mT46n7E2K7aGftaSd6Ry/38Rs0mpxmcY+JCQ47MB3g0/8FO9CIT01K
	4QSE0SvoknYR5ONMZ6JFVkxuTrQP7e1zH5Pd9vd2A9+Uknce+y+ODjhvNfQ0SqQC
	b+YkDZZBYQLiTsin5XWQxoZsU1bakv9hqwAziiBnZ6/JDuOw7liU+zWg31sbUmKX
	SVx7wLoSxK/LvIyQTimO/jtM4tvy0p4tM9wyVl7mzvcfdULxCEwzCrQdHN95LK2r
	IR2VtiHRrp8wXU/0xiv09jauuDdyCMiGEtNKRjpktpoDqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkaegu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:38:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d58d226cso12413421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767925; x=1759372725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dBE8wCPmuYIKAvATllBrBFtXuoveB9RJyGGd22KLBI=;
        b=PPiQXtZRoCE/6eNtRoDIjrpRdvxX28BxJdpRzai74ETrkUC970sfMwTFRFpBRyQkV3
         Wp2bZxIpWEuF0ah0Ziafkpn8Zn/Ux9suDbiwnMs0XsPfs1yste3YEu6VRxtTs6M1YDCI
         zzvDIeiSfXc5FBVFModZ6RqsZTs+ltS+JHpYG5PUuB8+wBmZkL9LmnwhbgxJNx7GrHdU
         sV31EHQ1oYENd/uGx4L/cUxOySTP/nGxc3uqojCRJY5FGRSVJl/+fsYigrUzh/39rlyk
         AY/33WQ5Edl9SBS4XnfQ5TEkitsPnYUaDh2zcLLbPEMj6ZSxIpvQSHGEbZhATE1UOoxm
         h1jw==
X-Forwarded-Encrypted: i=1; AJvYcCUWpl2nKnpDDk01v8OSA+DQ872O67NA1oh7boIl4yPJZgv/XEelnWRz+LZL9Iy3rwTx6wvbrKEnZjIoo0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+1KT5pZLx8XhSsCYa9fltCHAJVo9QtC2/V2yseMfvttVjOla
	YT7LjeiVvZg3g51BuEpr4l9uwFwqq4ZAJn7zXhA4DwHBtfE2FV8GhB/ZlnUX7ayEiS9nmvNSTUr
	EuIVOUtzRahVsFibOq4GR2+jOX0ILubyvOgwRw5hrjIaaCrC46829sReWbv97IPeE1cA=
X-Gm-Gg: ASbGncu8Dd9wTwT6MdEiadr2tMVbzshfzLIysX/6OjKxoF8viCux02zLv2AQ1YszoaP
	2RynBm9rLodVnAU1GA2x9BEs34SGtzqy8KwCL7VKimExCxekU8GcFjFejSrY57DjqCfba3oqPfi
	wx9Q/ehqBGhO5Qb8Lsgdd/FrX4iu/dFahX3wNQZuVpS2BR5WIVTUScxKEYeI0hvp2/lmnsxeDyK
	6bD9/FHb2YsB5bZDDkJ4jQ+dR/HebcP+DjG3nPVYgCdDplx9VvgbsqataCmKK5iWHdZciTse6WJ
	Wcfq1r+fWLs//9quYKDJyvJFJEshu+wNWUnkUgQub7rLKLE2o7+CRCipHH3jZ0qR7rX8uqdGkJr
	ZE6rZrYp2vkF3GU+b8gyJTNkopsTuMejClgL3z83tHPZVZjB/i806
X-Received: by 2002:a05:622a:13d3:b0:4d8:d502:7469 with SMTP id d75a77b69052e-4da4cd4c801mr27417451cf.75.1758767924750;
        Wed, 24 Sep 2025 19:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzAX+Bo3ArcJumD4HPQ/3vJQ49cheZkg9XDmwTcQRShTjOBjhcFEYQXZyYcD5dNdPNkm6f7w==
X-Received: by 2002:a05:622a:13d3:b0:4d8:d502:7469 with SMTP id d75a77b69052e-4da4cd4c801mr27417231cf.75.1758767924318;
        Wed, 24 Sep 2025 19:38:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4e38aeesm2096901fa.18.2025.09.24.19.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:38:42 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:38:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 0/2] Add Qualcomm SM8850 socinfo
Message-ID: <ebxbhaaefuoemadcef5h4lxfw2k2hwkfe72aubctqb3tk2zdmp@p7ck45rd2hy7>
References: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
X-Proofpoint-GUID: gC5yoOYQMqb9MbZpbRO4lMVjRAHoFS-5
X-Proofpoint-ORIG-GUID: gC5yoOYQMqb9MbZpbRO4lMVjRAHoFS-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX/9mO9J9hOp29
 Uet5gt8Oyq+B4rFgRflV1/04iD6Ympb+uFzsPo6uYSqJQclCEYvnkXNQCAWjWK9TggAStS9aLph
 YCjtmJT7ukOB1bko+1UIShBzRYsdUbyG/HFaAQtn8CJo+XeDhkM+NwsrWATzNbsaACTGQwN9uDZ
 aPsc5y6Itmco54+egHpeUKTHuCi9DZzCSVlV3ch/hxmGkeUQf6+j7rLaZwlqqzdUXK6fl0xCHn3
 I/2oPrFl9HPuJHJy3ELLc0kv5BofGzwHxrcX5Jts2VIPkYwWMgPsJ+uwozfJ6wSG8QEQBEML65x
 y3W526fyzQVN0QAvLz+sa1+sAHu9QS1gFyl7vC5S3cJxEuMEJSBoFVYIoWkhoJ6a+sJyJk/tKgG
 6QMJiR0f
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4ab35 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MSJ7r52RwriqJIIK1REA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Wed, Sep 24, 2025 at 04:17:45PM -0700, Jingyi Wang wrote:
> Add socinfo for Qualcomm SM8850 SoC.

What is SM8850?

> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Jingyi Wang (2):
>       dt-bindings: arm: qcom,ids: add SoC ID for SM8850
>       soc: qcom: socinfo: add SM8850 SoC ID
> 
>  drivers/soc/qcom/socinfo.c         | 1 +
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  2 files changed, 2 insertions(+)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-socid-f96f14a9640d
> 
> Best regards,
> -- 
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

