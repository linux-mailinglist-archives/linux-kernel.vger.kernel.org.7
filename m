Return-Path: <linux-kernel+bounces-743458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406E9B0FEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6649D5468D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A95B1AC88A;
	Thu, 24 Jul 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AOlzwA1i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E6165F13
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324927; cv=none; b=ubWWPHLMXYqCB8kuervlJsHfQP/B7elmqOT8yfbEgbdrZPAzdjnqJvNBnqTjB7jkCW6YdC3WS45/237Sz1o329AJTAAxceo0n2/OqzGUgUQbbQulTSz6K11XU2+aJzKMzl1gFRSkteiYfLimK+vF8C/faGZRPgJb1gPXST8H7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324927; c=relaxed/simple;
	bh=h4frGDfrcoPFjquRdJloro3+LdnHf515DuJQKJtAjms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR7egwmr8uzstDdhM8Fd4ynASsUrCyq9FbUVZFxqrXcxIfzSW4jf9XOGTWEZr+z3lHF9d7VxZmxeQQoppLe5kyoq7p1OC6s0w/hLQr4aSWSXz58e8fWvDSwHff/5hmA2DaDOY6DE0lDNy3Gm6U8FPPROqkygjhECghbqWGFrCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AOlzwA1i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXH04028528
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eDOg8qXq6ts/jqvtj29vp91Z
	bBfT4Y7kQHLHI9O6E7w=; b=AOlzwA1ivWq4YUhMvIaBdqQjXDrX1E9X8eHdKSRF
	sR7xZXz2eQ0qlO0eNfpQgMJWTo+d/cXRs11Eo70/gk9m8TxoglesSSS/ojCUFgdS
	bSzL/DPfZDrZFbT6XI/znkWI/t3U+X7L6URwp1HFOfTQYwMd0KpHn1xZO1uB27Jh
	QJy38JeyHLxRjqhpNVfS/ettS+P41QO+AYcwi1XAlMkWJ4oxJ2Xi3PsufZ9fYRt6
	6PBgbCHCx3CHXZ2nFNONB2S5DAYIc47/ZXA4ISRZZ6KT0Z7Oo7d1uOMYXN9fh01K
	yTAcEE2Nv1TXMFjIqtkf365sbTGXztVqhZHATm3+WODqtw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1efuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:42:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e7550f7bso4209255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324923; x=1753929723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDOg8qXq6ts/jqvtj29vp91ZbBfT4Y7kQHLHI9O6E7w=;
        b=xK0zQRDymnayDepOv/OhDRkqL13+bCo0t+gwKjQaBUSCwMJXOGSo0joboxnYwd4eGT
         kuua1R3Iuyun/FDB3b6EhPFiefMSIQX64wQrj/Mh7JVkrMxoICSHT4y3VwkcBE2VPtxp
         ABX9WI/NuDZwBBbgeLBp2wCgSoKecU1g2H4onZYBpuawcSQ1rNsZOMtYh921WDjMCVGf
         zR/O+xWjCkgDdmJlO7aDZ/b43ltCxg/wtLoYTztrr8+ksayoN7FAFuF9swlb0oPz3kA+
         6bmEZbcjuAm/0xdF1w9ut8ifnoPH6aekMbLKzNk3Hv9iDzWuRPmU/EOhq+cGICyJgtbi
         inVg==
X-Forwarded-Encrypted: i=1; AJvYcCUvI4oLQCQp+GRO5nkJJe0U9woA1aFdedSfyN9IL8CwtonkK2ZVR7iLWN2c517Jat0cmzymjbY9FhGMo6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27zvgOqTAPV04XuA3PfKkvqOdZMkYML2liPE8PsjLSYtr1Uqw
	DW+TsdUEmXEWaTHvTxbyyQCChptrs+dtwCxCqHz7Y9z8b76/Tzju83U4PJXrtKNg6oFuQ4JgpUu
	KoRZzAZLcLhttu7fUblI5ioWLo1YdZheP7ZWZ3pxFfIkB9JoFWwD5Zfi89wNL2O5RpK4=
X-Gm-Gg: ASbGncud8izvtKT9vomxZ8zyKWSF1UaKaQUHpSS6tojnJtxCa9ySQgLfHml4nO42/v0
	iLWHZZ/B70UMzeqdTVRooyvwKPGr6XZ1qwsaNNYkJggNW/MIF1HqpgUoOhcpN1ldOcmFkcbD5pR
	F/XfXnfQ7g2WMOJoFndcs8+cdFsnuHrO9DtsabfP3Juc6lyGcs4uCGFTR+KjZKGldfmWdnSNINX
	JBK7DqLmG5TJHW1KLmQoHYIlLTbEWwEwPgYwfzpuruRkV2izleMlwERMGQYXIQS8LxxJqt1C6AZ
	xQiCKKFIeEwtsDXCO+41VROApZCircBQypVrmXjSD/s8nX8ZxswJ5zmJwdkgSu9OeNLRJcaWohr
	T2QSPr2Y4YCpsCXyv
X-Received: by 2002:a17:903:2ec5:b0:234:f15b:f158 with SMTP id d9443c01a7336-23f98171cddmr68323265ad.13.1753324923273;
        Wed, 23 Jul 2025 19:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZbf1jwRdOeHqFTB+q34Xd0NzngKZRUNeuMorAiN0u6i2hgQggAiHuKf+kKKaL3Y8JY2bnw==
X-Received: by 2002:a17:903:2ec5:b0:234:f15b:f158 with SMTP id d9443c01a7336-23f98171cddmr68322935ad.13.1753324922787;
        Wed, 23 Jul 2025 19:42:02 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48ebe2dsm3335105ad.155.2025.07.23.19.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:42:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 10:41:56 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Subject: Re: [PATCH v2] pinctrl: qcom: Fix logic error when TLMM reg-names
 property is missing
Message-ID: <aIGddOWlz6LTAxgV@yuanjiey.ap.qualcomm.com>
References: <20250723075024.4604-1-yuanjie.yang@oss.qualcomm.com>
 <nqujsfdojllp74ykhskftdgj6kcvje726av2bgu5xqymiwvzl3@mw2cqji4qzqc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nqujsfdojllp74ykhskftdgj6kcvje726av2bgu5xqymiwvzl3@mw2cqji4qzqc>
X-Proofpoint-GUID: FVF2FPbPiCzRdhsnGAorbpcJ3oZuvEgz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAxNCBTYWx0ZWRfX75oCnIP4Agsl
 bkdM5R8QX5xb+zT5vPabILXdGQ8RBKZrTjg16bbtLAcYZ2pR8qwP3qTzRGF9o/cRIyg6bKXQS9J
 lZQIHpMt2x1XZaK9a3/9k0u9KfhjCJC3vhCH06dYQ4bGy8DW7zDU7N8xgrCKFVv3X6uERTOV6OW
 PSzyuBlsE4j0Re5aVmZ4DXmG/hjkFEwpk+NJrhk+eafZ5cvXsileNWElMUZitMrwQRYEs5uY2VX
 wqndYpTrvB1RiRrOvmOTQgjHR8KLJxeH5IHdcHUtRsU3yWP6nPKnN7lNnXuwUluAaR1zyvgpH7U
 HoP/CAYG64OEDxhwrLdYGihhgBcgugGGEb36WxFbdi4h3ygxu3rk+I04mDJ8HwKG98tI/fsz6TN
 V1ECM5LtxOn995Gv+McBJ49vhZ9d6btHbYbAIUOCdzohuSI1X7gNqHpOO6WPTdu33PMHn9oi
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68819d7c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vfjdRiaXop_0gXblzogA:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FVF2FPbPiCzRdhsnGAorbpcJ3oZuvEgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240014

On Wed, Jul 23, 2025 at 02:27:46PM +0300, Dmitry Baryshkov wrote:
> On Wed, Jul 23, 2025 at 03:50:24PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Some Qualcomm platforms, such as sm8750.dtsi, define a single TLMM
> > region without the reg-names property. This is a valid and expected
> > configuration. However, the current code incorrectly treats the absence
> > of reg-names as an error, resulting in unintended behavior.
> > 
> > Refactor the logic to handle both cases correctly:
> > If only the gpio parameter is provided, default to TLMM region 0.
> > If both gpio and name are provided, compare the reg-names entries in the
> > TLMM node with the given name to select the appropriate region.
> > 
> > Fixes: 56ffb63749f4 ("pinctrl: qcom: add multi TLMM region option parameter")
> > 
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > ---
> > - optimize commit message
> > - optimize code structure and fix kfree issue
> > - rebase on tag: next-20250723
> > - Link to v1: https://lore.kernel.org/all/20250722054446.3432-1-yuanjie.yang@oss.qualcomm.com/
> > 
> > ---
> >  drivers/pinctrl/qcom/tlmm-test.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
> > index 7d7fff538755..e41fe7e76c80 100644
> > --- a/drivers/pinctrl/qcom/tlmm-test.c
> > +++ b/drivers/pinctrl/qcom/tlmm-test.c
> > @@ -581,10 +581,13 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
> >  	int ret;
> >  	int i;
> >  
> > +	if (!strcmp(tlmm_reg_name, "default_region"))
> > +		return of_address_to_resource(tlmm, 0, res);
> > +
> >  	count = of_property_count_strings(tlmm, "reg-names");
> >  	if (count <= 0) {
> >  		pr_err("failed to find tlmm reg name\n");
> > -		return count;
> > +		return -EINVAL;
> 
> Why? It's better to propagate the error instead of reinventing it.

of_property_count_strings often return value > 0 (count) or value < 0 (error code).
But theoretically the return value can equal 0 (value == 0), perhaps this situation
will not happen.

However, from the code logic perspective, this tool should early return when count<=0,
if return count == 0, code flow can not stop, this will lead to a mistake in the tool. 
  line:
    639:ret = tlmm_reg_base(tlmm, &res);
    640:if (ret < 0)
    641:	return ret;  

With this consideration, I have reinvented the error code.

> >  	}
> >  
> >  	reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> > @@ -597,19 +600,16 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (!strcmp(tlmm_reg_name, "default_region")) {
> > -		ret = of_address_to_resource(tlmm, 0, res);
> > -	} else {
> > -		for (i = 0; i < count; i++) {
> > -			if (!strcmp(reg_names[i], tlmm_reg_name)) {
> > -				ret = of_address_to_resource(tlmm, i, res);
> > -				break;
> > -			}
> > +	for (i = 0; i < count; i++) {
> > +		if (!strcmp(reg_names[i], tlmm_reg_name)) {
> > +			ret = of_address_to_resource(tlmm, i, res);
> > +			break;
> >  		}
> > -		if (i == count)
> > -			ret = -EINVAL;
> >  	}
> >  
> > +	if (i == count)
> > +		ret = -EINVAL;
> > +
> >  	kfree(reg_names);
> >  
> >  	return ret;
> > 
> > base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

Thanks,
Yuanjie

