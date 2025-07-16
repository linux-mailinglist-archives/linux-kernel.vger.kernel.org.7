Return-Path: <linux-kernel+bounces-733866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FFB07A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A8D1885A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F42C15B8;
	Wed, 16 Jul 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8txTZfE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676B24293F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680131; cv=none; b=diAjzdKt8ssvVGDpEZQ9jB096lo556WNdnYcoDrsFRjr9fJ/17TitvVU773oxV1pkp7CQRzuCA3/592PhKW4jUMJp5Kwknx+UPU95WxISAOGlegK0fAtfLIQUoLp9xC/l63qm6cez/GjPspVhBfRzokjZ2/m3Yo9VEpL94NLZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680131; c=relaxed/simple;
	bh=KO4I/UV9uxxYkgVhOGqX3ScFKYEZgickfkxEANrGH48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQeBves5JgsZ25benL1UZFaBBEfd8TPSNuOqi8ipDKjv6uyDfVYvJQ4foLXBnckJOiDEhToHvItNDoMDF5TViQbnxMAnM2ntmnpy0pM69Yz1yvok8lG5qZhDWdnW04wmjJQ37TDF8lvmQOctFUUKgOZ0utugxvtMTQBer573Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8txTZfE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCtBPx025684
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nKwLAVLBb1T9b+QNe2jR6UF2
	RMh1GWs/n01YMv7EqI4=; b=W8txTZfE3ZGmOAhv4FSqQUXbzDs3DLqmaBso6Esi
	FH3ii1sKg8Io28NEOS6LJhxlfW1FWhKqbehFCMZlDl5cj4N3lVoUtbur31ebyiWl
	2Kk3eR9ug3X42QAq7iupJkTYGBidyGhBvtU/TidrncB4gwkJsTkn7dZjVGNS3seV
	JA19HkMHmi5JkVasToHmgn60azhJi995nhLifMFpmV4kUPn6tsPtplnF+HsstEmz
	TecWGEFHRU9E6GEunBboslb6mnvNOL9X6jVprZI6PA5cbioEUDVmmT0Kw4nw0G2b
	znY4tiEjdLzGl06UfIHJKq0sKc+xqyOlvFId9H5BWBjOEg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy4cgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:35:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e207330a45so585642085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680126; x=1753284926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKwLAVLBb1T9b+QNe2jR6UF2RMh1GWs/n01YMv7EqI4=;
        b=LRe1TNQiRWlE3+aM6C9GDIpZPRZXmLg+pqGtMdz4jjfLaOiNS+Eqd2PQDqnOhQwzfz
         XuphtO48WFczanKk2FaBk2vU7/SX9M6kItTwAhYb+HcQiphl4HE3Jr9e9RiMR20XUnYj
         DPH4gXJKk8QvIdbhcssWcBeLCalFN42iKeFQsWrJXPB1PW/oStHjc0dWlnjPVwB5HAF7
         d+mJPMp2lIe3hzoB/sBaaoGPAEov9iZ+ZfLG3N9iyyC+aYCYz2HfJhK4snBx2s3D2H53
         HEVh/jLc4dJhyHxmA3lMk4UQgbdJt9cxtfv5Oi40uzluCJsiXUQOXudWHE2FELVgdlOh
         zSbg==
X-Forwarded-Encrypted: i=1; AJvYcCUpY4MwAjmobLkaU41HZCQvdGkSU0jlwW/Y79sUsWRDd8WszyvxS2Mv4FVzhyf/ctVTWi/LvODrpVH4Lq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmZhTbm2v8nkk5YlzkFJhFCTLIZ8orxR3yI94MggZs1qa5vYN
	z2IQOQeVs8OOrzGd74Zg0baKb0nV6phdcxK1ZvbVauHMImh5gGllysUw6oag0J5bGGr0xLh8JIw
	uNT+SoFx4HhAGj7CUVYDNM8ci62EL+ANIXm3PHg0Qgk1wcrkRylydZNCfcxRRkpMBxeE=
X-Gm-Gg: ASbGncth5bbnITb/OGJC0gpHiII+iv93IidDVStrlI6C65r/CQaN0fJsOOuB2sZboar
	FuIg3qOBN/sU3n/Ivo0uECx3j9sRg3pTt1pdyPNR/p359alIIRAjMiswaMBHcBKNC6wZB4t4nkt
	e/4T6/uuhp73kQITYaNROoy12tTMAzRRHyeHjB0ogeFII7aSMBSDDeaLkBKJuxdcSKy1B8ox/gB
	55+rgnQoWqQKv1Oq/DPzYm/zJABv25nXLBqncOwh8hw/2UG/CW82krhg/QC0GgHG2SU0Og3ZNN/
	xMt0Q0b4eS8MKyKgn3e4zdMAvV0yFr3BYPJiHOgkCZyvu/y/qeI4qfP/Is8EwgbkspKan9b1bjn
	ntaBid8H+rC+CeGHfl48HHH+Bxiq15tDdXXAjVX6yGHT6Rvn9g+bN
X-Received: by 2002:a05:620a:27c5:b0:7e3:31f5:c8e6 with SMTP id af79cd13be357-7e343636bfbmr462007085a.54.1752680125815;
        Wed, 16 Jul 2025 08:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhZK6K7A2ZsfzoQ0Uc59Gc0NZS3lOeMxcF1d+K5mxadbzZ4Ra8ZrydLaOEEGJw/CLKuCxFYg==
X-Received: by 2002:a05:620a:27c5:b0:7e3:31f5:c8e6 with SMTP id af79cd13be357-7e343636bfbmr462001285a.54.1752680125217;
        Wed, 16 Jul 2025 08:35:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d32b6sm2684915e87.122.2025.07.16.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:35:24 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:35:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] clk: qcom: Add TCSR clock driver for Glymur
Message-ID: <vawtojqbjrtoso4pjoza7vpaiog37hu6gbt7g6mmwbnmwladtx@ebh4amrwxwkk>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-4-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152017.4070029-4-pankaj.patil@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfX2DCmKhxmPka/
 H3Rfj+ljVIZCx3/QjMIpMjr7Oje3rJelu9b9aMTM3/odOHJpmWVep5MhS0SztcYt0a3QWi/fTf0
 07/eeBJRcfDRYxx7hAERsdW5+uc79OIqCtupww9rXryzLUudSQyF8cmqhm29dKQ7GVc3X18SIHY
 /8C2QDN3Z+sk/w1Vez6vDxtu0hxrGdroIs4FwzDpTGNXMPBLJMpg0NUyBv7wFMm5rh22tIcvunG
 Mxbmi3rFGzcpDY+DCKydXf5ZNFYAvlN10ItMDgwhBuXThHgc5sNuu9L2zWGmdtO2dJcQzsOxnFn
 4WWoGj85BFg3NXGSbx3C1wkF19VLvk5tC5V4cwEyB1InLhKqL1zgpyTmVuFIaIFhQBXJGxPHq3u
 gFNEzEyg+b7FholEPAQ9pje6uU7j1PEcFAEMlu38SbpL7rVwXjEF0uC7CCQ4a4168vZeKRh9
X-Proofpoint-GUID: GEwOEVpmYn69YUTAB8nG4De2Sax1SrvQ
X-Proofpoint-ORIG-GUID: GEwOEVpmYn69YUTAB8nG4De2Sax1SrvQ
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6877c6bf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZwOLpZNRS_i71KYojFIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=994 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

On Wed, Jul 16, 2025 at 08:50:13PM +0530, Pankaj Patil wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add a clock driver for the TCSR clock controller found on Glymur, which
> provides refclks for PCIE, USB, and UFS.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |   8 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/tcsrcc-glymur.c | 263 +++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/clk/qcom/tcsrcc-glymur.c
> 
> +
> +static int tcsr_cc_glymur_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &tcsr_cc_glymur_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return qcom_cc_really_probe(&pdev->dev, &tcsr_cc_glymur_desc, regmap);

This is just qcom_cc_probe();

> +}
> +
> +static struct platform_driver tcsr_cc_glymur_driver = {
> +	.probe = tcsr_cc_glymur_probe,
> +	.driver = {
> +		.name = "tcsrcc-glymur",
> +		.of_match_table = tcsr_cc_glymur_match_table,
> +	},
> +};
> +
> +static int __init tcsr_cc_glymur_init(void)
> +{
> +	return platform_driver_register(&tcsr_cc_glymur_driver);
> +}
> +subsys_initcall(tcsr_cc_glymur_init);
> +
> +static void __exit tcsr_cc_glymur_exit(void)
> +{
> +	platform_driver_unregister(&tcsr_cc_glymur_driver);
> +}
> +module_exit(tcsr_cc_glymur_exit);
> +
> +MODULE_DESCRIPTION("QTI TCSRCC GLYMUR Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

