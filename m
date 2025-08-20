Return-Path: <linux-kernel+bounces-777635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A118B2DC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C11A052B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06CB2EE610;
	Wed, 20 Aug 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6L2P4UK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5272E62DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691455; cv=none; b=kvS0yfdwGhJzhsbmT5cp8Yk+ClZJ+iw7ht/jUBvLFoXIPEd3W+NlABwrtmcRZQbeCZ+7dTaLl4KRbYO33av7Bnm4eEyXkHNIS9B6fiu5d+kT9pIFYTkumfwXN4VUSjQZRIMQr5bdKlday14KP0mEXakAk20jNUBotQrRIMxfuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691455; c=relaxed/simple;
	bh=JQc5NwLCcqUcgmyVSsmSEXhdpF0NJy1xSY9nuzP+3xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBoxJDvxQK94usS2vnKGA3fz/BVm31091k+Ig6txkad7YKPqsEAEnoSuDHzTsTLV6uK2/tlZZjqzQ8O5+9UlS/ES6h6tJJ5q2UOfN2ILXrnnY0KGmNg0VE2dKCKPDJasWDOqPGS/0aDSxwGZD3B8q3MdEIFaypucOOqSC3u0jHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6L2P4UK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAMw5A020780
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sWIyS1ANCk71ZKYKAl+j3w7E
	oc9ui0qaPQRCGlJ0g+w=; b=O6L2P4UKujJRQJbI7F4KprrTl6CQ+7+yg5/4nhJM
	GIQbwOqEXsvo6DhBNyDhEemyNyffGBn1xR778K11b8ukmXhpCivBk/RyNm1vWSen
	iqwOGBDG8Hgo9LZOW/x9HnDMWlO4FSwcJdVw46bH0B3Lu1VNUmp4h1y/AnUVUrVR
	Bp7ncF21bhPxqxthXnMjDRVY+8JsVxI2ALChTEyo33zhZ5Cy1dTS0EkoUIYQSqNS
	tquhbwYUCQW2r1NqV0hizH4Pd1b/eBn8uvcP41MhlIPyKlL5iUdTW6rKQ4TJqiAq
	MZKesF/BksXkflK3wYeWy0MNVaA64MWoSxStdxVKa8H2+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291m34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:04:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso10772475ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755691452; x=1756296252;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWIyS1ANCk71ZKYKAl+j3w7Eoc9ui0qaPQRCGlJ0g+w=;
        b=gI0gkAt98T0yh/eMql++i4HpDcUWSLqwGpGFdk7pLMixxJJcDxXj/AC5X/E+lUQ6kZ
         bKnp95+HHYKy+xoS0ONZMdPEJZ8qzKDoQ3/pp7kUlbX65/GuSh7gVDz9yF9ELGvPcsLA
         CF/4RmCYF6GdfYDTPihgOMxPqAlWArjPb5ffqYtQjZSSUB0C4SBzt/7qY2KeHanyamB7
         /yiEm8Y/N+wuz2A1qraGJn3lvPohCmgnRy/Q+Ji0EFFjpc46TnfG8T3hlDPbYGEvDSv4
         n23UP4kbMDTlPM/lm8utbBXUhkmJbpq4Sjf6PfFOagNZIQgshtr3bFoRkGHVCjyKvWAW
         1MBw==
X-Forwarded-Encrypted: i=1; AJvYcCW4bcSpp9h++CjjB/p6r2jyF2m9oyjoJeuIg3RXAcEy5DA78RIbxcP2heB9bh0e9e5H9SOY1j13UD3Zx5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxj/APeBuQdPywDvMHyKMVbH5Lj15A3OClFTNxwqMMS417JFfK
	f1HRghhrsxXaHha+6/B2ebvnYEQf6hxRkV+5BcJWji+8AUNGC5aZiTzbjSy6FAl1+B4h8lYUfaC
	IXAV9PzP87zKGgXymNu0PzSB1XAfHdzsa+K0h8FVD39RzLrNyqUDMCfAVP+73iTBkeu0=
X-Gm-Gg: ASbGncufye/x/9yQaInB3O2yxUQWwBEvXKkALGokZ/FPsFy45Z/MwVSOpXHzU3kJSyS
	H3VIdDRxgaLReU3lQLTQna81Sec5wJEgervzFsHLetyHXiqj+dc6ElQgIXwqSEol6nZlP9pk1oO
	nsHRphgGcXkRAmkvf6iIiZck0V4cIXzJimcuyrE/TNYxH++53glQfF01t/qa1Nf8Mx3tv6Z+qUl
	RvGS+eTuc/rg3t0N5bR0gRRgbWpOwgg0AXwbG3z0GrRxzhyq3OwthvrEMuFxgV64fogkFPd2qx/
	sF1rEvzJX/qO+CT3yyWJ9XKBIS15Z6K+rCx9iLZy1dzQTFMCVxAULyxNfQ53xwvoiB8=
X-Received: by 2002:a17:902:cf12:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245ee1170b0mr41644065ad.15.1755691451922;
        Wed, 20 Aug 2025 05:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMUvumKvyToyANrJplMcGPNukZwx4CtjZElts6CZa1sETjyRTsPkuQ5WbmGN4OVH7LD7S4Ow==
X-Received: by 2002:a17:902:cf12:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245ee1170b0mr41638225ad.15.1755691446450;
        Wed, 20 Aug 2025 05:04:06 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed379e92sm25257835ad.65.2025.08.20.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:04:06 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:33:59 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 10/11] remoteproc: qcom: pas: Enable Secure PAS
 support with IOMMU managed by Linux
Message-ID: <20250820120359.dsdbm5txyrsdbedy@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-11-mukesh.ojha@oss.qualcomm.com>
 <aKWJ-c6B5Pvjw_jx@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKWJ-c6B5Pvjw_jx@linaro.org>
X-Proofpoint-GUID: 89gg8BFImjN7RN7XEso5x8znRyDQ0xnc
X-Proofpoint-ORIG-GUID: 89gg8BFImjN7RN7XEso5x8znRyDQ0xnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzrhACdV2UoTI
 9s0vecZRhg7heGhIapR2Bb2KQA7NyHzrtVyo0B3mueqdsMQgwlWL6G5+hcFuh9uCFJpCnos5/LA
 OmLQdhVAmuBFGc4K79QrPOdapYhGI5cTHc0oPaKQ2+beL8hiZ8L8h39f2aCYjkniEFWJnqQLdIh
 XhbMntKGXAeH+HMSy3gQBiYz2wBNoQHIzM+57XBDdRC6mfFmWLC6pYMlmaPF7M1vzEzTh3Z4MWN
 z/mYG5t1HBr4Ztcme4qrKm7NvKUdVK0Vosp/BZEq7WVMS1Tx22kUs7hg+1AcrojEPgDCJ38paIO
 tpRk/y35RTPGbMl7bIOx/LtmQOQO4qCYMGFwvbGlcj6OOz8kNzdXtPaCb1w8ZXdRTI9hfgED7Z0
 rPZyVn/0RXV9oj6BsiqIqHtwPSeU8A==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a5b9bc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6vJVrOM7mFHQH3jvjVQA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 10:40:25AM +0200, Stephan Gerhold wrote:
> On Tue, Aug 19, 2025 at 10:24:45PM +0530, Mukesh Ojha wrote:
> > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > or QHEE), which typically handles IOMMU configuration. This includes
> > mapping memory regions and device memory resources for remote processors
> > by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> > later removed during teardown. Additionally, SHM bridge setup is
> > required to enable memory protection for both remoteproc metadata and
> > its memory regions.
> > 
> > When the aforementioned hypervisor is absent, the operating system must
> > perform these configurations instead.
> > 
> > When Linux runs as the hypervisor (at EL2) on a SoC, it will have its
> > own device tree overlay file that specifies the firmware stream ID now
> > managed by Linux for a particular remote processor. If the iommus
> > property is specified in the remoteproc device tree node, it indicates
> > that IOMMU configuration must be handled by Linux. In this case, the
> > has_iommu flag is set for the remote processor, which ensures that the
> > resource table, carveouts, and SHM bridge are properly configured before
> > memory is passed to TrustZone for authentication. Otherwise, the
> > has_iommu flag remains unset, which is the default behavior.
> > 
> > Enables Secure PAS support for remote processors when IOMMU configuration
> > is managed by Linux.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 63 +++++++++++++++++++++++++++---
> >  1 file changed, 57 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index 1e0f09bf1ef2..180528bcd57c 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > [...]
> > @@ -424,7 +459,8 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
> >  	if (!rproc->has_iommu)
> >  		return ret;
> >  
> > -	ret = qcom_scm_pas_get_rsc_table(pas->pas_id, NULL, 0, &output_rt, &output_rt_size);
> > +	ret = qcom_scm_pas_get_rsc_table(pas->pas_ctx, NULL, 0,
> > +					 &output_rt, &output_rt_size);
> 
> Unrelated formatting change, should be in previous commit.

Ack, will fix.

> 
> >  	if (ret) {
> >  		dev_err(pas->dev, "error %d getting resource_table\n", ret);
> >  		return ret;
> > @@ -726,6 +762,20 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	if (of_property_present(pdev->dev.of_node, "iommus")) {
> 
> I think you need a dt-bindings change for this? You had one in v1, but
> dropped it entirely for some reason.

I missed to mentioned it in changelog.

As I said in another patch, I intended to send it separately however,
will send it along with this series in the next version.

> 
> > +		struct of_phandle_args args;
> > +
> > +		ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus",
> > +						 "#iommu-cells", 0, &args);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		rproc->has_iommu = true;
> > +		of_node_put(args.np);
> > +	} else {
> > +		rproc->has_iommu = false;
> > +	}
> > +
> >  	rproc->auto_boot = desc->auto_boot;
> >  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> >  
> > @@ -800,6 +850,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  	if (!pas->dtb_pas_ctx)
> >  		goto remove_ssr_sysmon;
> >  
> > +	pas->pas_ctx->has_iommu = pas->dtb_pas_ctx->has_iommu = rproc->has_iommu;
> 
> Nitpick: I think this would look cleaner if you separate it into two
> lines (only one assignment on each line).
> 

Sure.

Thanks for the review.

> Thanks,
> Stephan

-- 
-Mukesh Ojha

