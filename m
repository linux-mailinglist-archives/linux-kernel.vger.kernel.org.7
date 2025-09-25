Return-Path: <linux-kernel+bounces-831615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C6B9D213
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5959B4262D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2920298D;
	Thu, 25 Sep 2025 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPBG/+dF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38533D27E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766934; cv=none; b=Typ5Q3cLYEPKVLdOAzb8E0YrtUUFuIRPVuE1Xk9RVKWVc5OIa/PMV4hFtSX8B0kOM2xTj7p9UuQS4BviwfwoCmGqS1mL9Lso/1IBTcOuo39Qhz/GpT1dRgVD/5/xgJ5Iw9h+5hL8sOPBUaK2Qw+jYRf+myZ5AN5grkbzwicIqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766934; c=relaxed/simple;
	bh=SAIzaDdMUAJ2rdHG/AL+FmlpaSt9Uj9wjE7RUoqyGf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxW7IIOd3nW5V0T1t6JFALFz3i2RI+Uq/doRPpvqvMQv0HizRX6Bhm0+3pSNXa948+ViK2Bkq+8f4Q6+7phoukAkYSvAVyoIDRKH31ZDOzg2GyEjltTk/EINtHkaq1HZE3TwsEcyvBWQGMRcPQBq+IPvR05Tbg0s4Z4Z7paFhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NPBG/+dF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1J95K029706
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dQYPg3HhOquErMj0zn5jCR2P
	8Pl8Yt8r6+LWmbHs99w=; b=NPBG/+dFYB119H9dlqihCt0+3kwEGd98EYVnJVKs
	uLyeXaGmFyDgi1l0qSRS06KZ9R3tWlxqEERD+vZdblMx9t2kB8D+iFvotGX29Eto
	Ow1Xh+vvPi8+PfSzlQ3es/HfxoDsRKNEQlW1zLm+pPTRhpwgS0qJ77TRuCpnmEim
	htn1k8BbeAaKZC9PLzO/hIxAzN921VYnAqh5e5EViF/mE+9Y/oRac2GHZ035ryrf
	I6YlUjJkPMdRCD0BnE81wFU4r5xOqhCk1QRLAqMlWTmw0oNJ5lxiEXsxC78xaXtC
	13TxMy79hCmKcXjdOaoLxUNehk0VswTM2oazY0zEu5DAig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpa7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:22:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d38dbc0e29so16368651cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766931; x=1759371731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQYPg3HhOquErMj0zn5jCR2P8Pl8Yt8r6+LWmbHs99w=;
        b=Zq+4l8hVV/byOIlgWxWI/uMZ+iII90tukMi75/8BeWJ0/WwRhKbpbMXGyoGrpBTM0u
         gbqfG+kFAQXkgimTro75qFm+DYJXOk+opZqOYgSD+jPspDT1d5NrsQ5ipb/ASJS004L3
         jQIeokRHC6sCl2+UadtIm2jZ/kfd1Q5Qi/BCVE0Cy2JB321mph1WD6k2MRDe36SLICW0
         a2yQttxjHrPkMhl6gfgxx5Pmspl/DcOmeq+meMWwH3bh8KjVmvp3sIuLGEZbTuC2MAMY
         bF8U3zrOJn3DIfjzaA+aZIP5AAO7oC83pkQSXXFP5tIJ3mp2sGf0C0/ylfJK+JWgjIcL
         TP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5hNPfNJHj8MKemTjtDPfKRXkI6/DakpCtXzrxqJpjm1EhbXwVnJiyapEZYf1kdbeaPtzzU7cKTfOMWbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkq0/Hj6YzuFhOIrHbyQ2korWdYe8MHT3hrCFPhHP2Bn1/Yl9g
	Z4I77YsEGOe/k20CiOoDQmUSKoBtah3ngEPHbo3jOO5+etE0TaKje1z2qgW2nVZyVczU17GLPJT
	HfF4sHmphYs5hWhvxvoMX9vIOufkqxROHLlL28bknTXCq2n7v3lHndd6QPs+pr72xHKg=
X-Gm-Gg: ASbGncvY7i3QC3uXvrwx9YEGF2VWg0cUAsE9c0ULPr9wgm+lKshibREF36J+mnjuNs4
	UWT7raj8aVQjQeOlpy/M1C8aDg3kohn237S7dCYiYFENbEI5Tnq11mR+Y4NfiJR03OdrJT0LywY
	K5pOgu2SyBARCfM4Z/EAxgF4uvkgYtocxc+K8WQWMRFqwIcSNT9MSgGTBCTp9EDDsvoew+f6RtQ
	r74Oo7qM8mOX3WggR/8kJaY8gxfaF0+Ffj++Idf6xj+bATK/Df+nBIr9aNo+hJ6GTAMn+nkLL4h
	uEtbYO4hTCjN9IuTqKVEN1GdrH01+A2t4lVFIAnNoaKzZj6AMkcX0ngGB3ajxOuxwdCmTTcYAYa
	xs4mYZXmXCNt7CqGbzi3fjec4PC9NSNiGu3DcSbMXuJAClSBM+bZ4
X-Received: by 2002:ac8:590c:0:b0:4da:207:f0ee with SMTP id d75a77b69052e-4da48b8f2c0mr24381421cf.32.1758766931047;
        Wed, 24 Sep 2025 19:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoOC/fEzI4rceoqPp5oihtG2BcGKgFCO8hZQHirGiAevUv0zoMqSlWcGxq7wq4yqj1AzFK0g==
X-Received: by 2002:ac8:590c:0:b0:4da:207:f0ee with SMTP id d75a77b69052e-4da48b8f2c0mr24381281cf.32.1758766930642;
        Wed, 24 Sep 2025 19:22:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656989sm241066e87.90.2025.09.24.19.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:22:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:22:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Subject: Re: [PATCH] soc: qcom: pd-mapper: Add Kaanapali compatible
Message-ID: <vyto6pxsld2h4vhzzmxvnyu34vil7fgefnzauz4adjipkpjbde@ejszs2z4hlsy>
References: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: -u5xO96mIdp3UhRWl7GKzxPu9emMJtM0
X-Proofpoint-GUID: -u5xO96mIdp3UhRWl7GKzxPu9emMJtM0
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4a754 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=97l5mCijwCuAxZHkA_EA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX2qHwcCdsARNX
 EjLgK5oNQdr+0V7FirH9L4cSpfmv5GpaVcAiB/iwMEq3Va3fF7LYyy8L97r4Ea25ZZVPjLD4z00
 +27jzTNB1jv9vkieqyKPsSk+gXV10IjprEtyht9SMISr2IJhAyv0IW+WDWBMU1b5fKw1GYcIBgd
 DWIVhLwYe+Foc6n1e2jhOol9EfgJQ3CKvWJS7axRa7/6wIL89FLwYDGdnNhsb4T3j31H43SkG9b
 8bkr0MjDB3YNMAQbWrFl4odXzzAFG/r8HwCJ9mVN1FiLoRM3ozSJZT6J4EkFN/6+UBH52ImX0S6
 ARgTLv0emVhKYdypvC7iigyuUeItrVCEuvtKMi+TSUcJM6ectZAjNP/t5YEAiQoKOxNYwjpel0p
 gvh9b6vZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 04:58:09PM -0700, Jingyi Wang wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Add support for the Qualcomm Kaanapali SoC to the protection
> domain mapper. Kaanapali shares the same protection domain
> configuration as SM8550, so reuse the existing SM8550 domain data.
> 
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

