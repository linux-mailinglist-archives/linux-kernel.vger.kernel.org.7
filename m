Return-Path: <linux-kernel+bounces-863762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3704BF90C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84365403285
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FD926980F;
	Tue, 21 Oct 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCaZNXXL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE2295DA6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085746; cv=none; b=BXn69uoekL88FQiQ7uxHeCBUuGixN8an9q47oFn/QaUyzZIJQUjWhG77lKMTq50PEhyxO8ccicCKNj4iY2em5RHaCQUdHGeSpBzU77Xyaz+EEBT+F+B6Jdxmnj6WolfJj5mCpp6woPeNnYUWqA/1bXe6aws1Ry90NjSD+wVnshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085746; c=relaxed/simple;
	bh=SKo4ZdKvx5zABCBrIRoDuS4ran5erUFQ53rpKcKMTRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVwvzPxtdkzirDgKp1BVVutMOakP/zUWtah1XeKeJRdcITp+nynGaKfWkj7jWr1foGPwp8nEXCGyKJ5juHBuEiv6RK+7zrAW6kCDeJFC0YAUHRaeywQ0Pw2YiImlxUi3O+cbSMGwIEo5Pb7YGJPj8QzbBGTDUeYfx6Sa2MCVf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCaZNXXL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LETHI8024737
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kiFK5hCF6RWSHybLAv25QKHA
	JLzCGFsxWtvs9iMRuZY=; b=YCaZNXXLPQ/J1jalYu18AgcwpiD1Si0ikALO12xN
	ACwjbeXb7xDZmyWVMQPTaBdSmaJqwysdT5NgQh9cV6sXv9z1pg//0NQxQXssCVG2
	/7HOCqnT4EVBxaoVLPOnboP8PURHhHrw4Ci5UW+sXKehKnDtZqu4oAV/xbohutcW
	kJIFjoJpNl4NxVhc83sj7o/inKGChXPZ8/u3V+UMLB2S8ACdW9N5tKiUSW6xcXO+
	aqzvGCJEFoHpA8fzicuDoixW28l9mA1iSzrQrJfRyXLc7Y2utXFnSPZ8sLvrbxG9
	7Savq8dWJckWjFo2er2umUsimZXug7iKs6BP+EI6JEv4Kg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws4su7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:29:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e892f776d0so20567741cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085743; x=1761690543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiFK5hCF6RWSHybLAv25QKHAJLzCGFsxWtvs9iMRuZY=;
        b=pJS7PL2fA1XPxDuBMZHhtD1AHgMATUJE6Xap0D8fCF3Br+G+zP/OZBP8GAoZKK/vmY
         kpR8THMWUcl2Tn7XJDH7M0XC/XNPGPSGGrDX/lT0GwdlMQzbz8619HDN5w6OWuZAMP1t
         bTeKKlS7ifPm76SzRMwJ9ZSTUjMYwd3+5JPunez0UXFGKwC92zLNRlovAn3+SSmbJTka
         Eq/vNNmrBkZnBz2Ubh2uXNJGoX+9k8kQaG0bOYi+00WqnWPWYtO/u4L7RvsiTTo5WI0O
         2MMlBOZHqo1CgMUUbUejOsmC7W3UYgEog/lLUxMza/cSSafy2lOKuD/oYTiRkPxYcoLW
         gUqg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0aCXIhKbQh/GOIw93JF7dQ9meDUUH2r7OVu9ePF6gexvkReFw2kE91ytH36qV3XKoOqf/+X4oujMoG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4D/52OQFcf7TavNWZm1HwYKbs3n2rB4f5uEGjiTv0ymIQDVv
	XmnZVXtH2/Qa/tnh/SjVxqajLw+ZVnqoHf+7S7mvMUFFb+SZ6evaO06g69XK1gud5R3lclPpBDI
	WZgEtCNA0bZX2AYfsit0v0W2E0nNxvWwqPGjlJLGBEEaGCm9s0Ed7jvE4l+T9863/Y9k=
X-Gm-Gg: ASbGncskXCMlrR2B0unzdi6VbHcnIvVufR11zl2Gx7j3vRSHs2LESnVHIF3bsfXGX9K
	m4+891DKUmdIgO4hpKoK5skvIz48ELVDrRWRrqe9BdtqVZxtxvavFH9mQufTrg4jmZ9NGp7ikof
	ly/dtXRp6ZRGmeaqml9RIAeprHE6UJ0+jAa7LxWozk56b7ndUy9MBKh+V3QPeCEj5ULo7DECft5
	BHr6V+YzAY4Ud0E+Ky81YXwlszGgBhZq349JgIVPuBP6OJEHrUALNKOL1SnopPMd3SFAzdqpjdj
	1eQAYmLETCCo9HEi2j+MIuYkBbz+y48OG/OWVaLnR2hhJ0pq2dgDJxMbNQjGX9DLJ7ZNlWoXSI1
	0yF3UPHBjW55BbDKSRvQ9sefzcbS+0Dv1Yu90ezRKbP7HSY2tNq/SlcVigVvhFPVZa6FlqankA9
	NwGiG448NbmNI=
X-Received: by 2002:ac8:7fd3:0:b0:4b7:9abe:e1d6 with SMTP id d75a77b69052e-4e89d1dd370mr243689991cf.17.1761085742665;
        Tue, 21 Oct 2025 15:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECOr2B3oal+A+v1ws1NmT3k7ICJMaoEFYAdhMeoCN6IDsgsceY3c19tmovel8ObqfklAWkNg==
X-Received: by 2002:ac8:7fd3:0:b0:4b7:9abe:e1d6 with SMTP id d75a77b69052e-4e89d1dd370mr243689711cf.17.1761085742209;
        Tue, 21 Oct 2025 15:29:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591dee6b31esm4073918e87.0.2025.10.21.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:29:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:28:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back
 resource settings
Message-ID: <3kngkegljl73a3kmzcprwhkwpjml7rfgiy3hypv3hyvyxe7yg2@ccyzzva2bifj>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX/KLaOAYaVBgR
 9GtJqWfT5cKPzySTaDG7JoyWw0GaA3xaDtacHPXWKwgZEJsU9YLQ/VvdB+YT+2ISMYbdmvzUNWU
 P92fJpy2wESxuQPMLq83ZLRWJMhKlhFfBbEoFfZ4OTA4vqlTbR4mlfk6sHTmbRg3p8Fl5sIzEFO
 LL5V0rxszaf508aaGeMiP70pVS4n8xs2cNbA2Gr99RdOpcg5CnFr/MdRIdq2tLW1qALNLKuv8dr
 eD1Pe/yi7HcAHgjztA2j5ZEh0F/6i1MSVV5abfzT1It1vDRMEBT+hB7UE9rrMjFgLZ3cb/kO5gj
 a9CSwmZ5brg/IKg7uUv2Q8iG6wSNfLgj5+9aZOmav2u/dAxUKlzdVbeLqUVmymTdnPMKqaSxORj
 /HjDszBdjI/EiEYCM6IauR499wGEmg==
X-Proofpoint-GUID: K47-a5Z2xOAkbEtXZeumSFxnHKdFu8Rf
X-Proofpoint-ORIG-GUID: K47-a5Z2xOAkbEtXZeumSFxnHKdFu8Rf
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f8092f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9CSTVoF-9rFBF_6A-HIA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
> 
> All rpmh_*() APIs so far have supported placing votes for various
> resource settings but the H/W also have option to read resource
> settings.

Is it supported since SDM845?

> 
> This change adds a new rpmh_read() API to allow clients

See Documentation/process/submitting-patches.rst, "This patch ..."

> to read back resource setting from H/W. This will be useful for
> clients like regulators, which currently don't have a way to know
> the settings applied during bootloader stage.
> 
> Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com

This is useless, please drop.

> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++--
>  drivers/soc/qcom/rpmh.c     | 47 +++++++++++++++++++++++++++++++++++++++++----
>  include/soc/qcom/rpmh.h     |  5 +++++
>  include/soc/qcom/tcs.h      |  2 ++
>  4 files changed, 61 insertions(+), 6 deletions(-)
> 

-- 
With best wishes
Dmitry

