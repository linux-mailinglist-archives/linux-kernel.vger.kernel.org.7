Return-Path: <linux-kernel+bounces-744863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD896B111DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868F61CC54C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF902EE267;
	Thu, 24 Jul 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9JillTe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE620012B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386099; cv=none; b=nBOjw0dA8gekMQ/ySHxPjAOlAUJyp/04e4Sip+QgtYxzRGAW3YxtIL6I/OLX43O331JK8L0qWj4ZkAu5CO+Xu5Azk0C5EiYFDu31CxWq/G+AQ2mHPs0jToxYUjmAFP2pOG/uUmE50pZ7H+rC1vLUoyzXWQe1uGh1g12Ppim/ZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386099; c=relaxed/simple;
	bh=pM1HUgksEDt2HUeKXQq+VqyG1755uI2VyU63d14RMxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktf0nseByGVQeDGKX9TKYIPpvxTHt9be7hTxqG7/lMjYwJy7Dpen0KagstL5+HHryS0AwdIHtyAa+K0VqDe16QOLO5PpCIvgj/5h2l4CVW3bxTbMQ825Fk7tP574YwQDt4Hj2fjZsepSVRZfByzXA64JTqE7DoDqjuI2CWMwZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9JillTe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEqiv0027567
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wwNM3mtjau7uqQilaPmYdY7ZPk417VPjIHda79n7D24=; b=f9JillTeN1WWZHH5
	ZY3pIKR7gBlgsbTV8nCfFkTwKQFvc5kAKHYZv2Tuj8F0FDRD9jScKpxAp/K2jnaB
	euatl+Z9Tsi99VFiPUFZdOBnCGc0I3d3Jx8BF33TP7IxPwSyl722y8Z3ZgTaIgfH
	Bvt/53/FSMaoTtatXZAU9N5bKFUAa9xDFVCbyz1RzCKGaz263feye4ADoqGNI6w9
	NaFOJuXW3mu1PVZ9howbmHPYzAbpkvSRfFgJrxlQt78K0uKPrjADeNIv3eokqoAv
	CeQRDXO50Jw6HStpgErl+H0NVJCIiz+OAQYbMO6T3mZ/7BBEkwIOGDQ0EO+F2g/b
	WhrZVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk29ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:41:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e33d32c501so335530685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386095; x=1753990895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwNM3mtjau7uqQilaPmYdY7ZPk417VPjIHda79n7D24=;
        b=r1BwG50wNJ9yzryNMyyNmjR2rrt3QhSvyN66JpAkqcaTDiZ8ks33MSMs9inWOSiLLR
         Sl6r+tN23L6rfgRYG/Ha5e7tP9XRn0ljJzjpznliHZt5KxvRtKdFn0uxqYuXZnGfb5Ry
         tfma5noE9vPnKTSLRNZdnXBrbHRyZHBZwmLD6Q6j2JDHhwps1W0V1OZxV9Q+5sVp3nIJ
         UEdHyUC15U9UCjgzt+mHaPtA9KUTfP4G//99zhTTvA9Nm67VUMteHoG96SehiONPJU7f
         bDaljmiqPJkdiM18Z+8Tb13KE4gPQoveM+DdsCT7xee586FP9hn+FKf2cVIFPXEwrsdR
         5Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCVYs3tzEckuLbLxG7+T+QWDeShjkDrQ9hCvMBawI3quZl+VUak3dhlL9I4/won73nlLDpW8aLouXJneFuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gPmYjSBN23ZkZk2DMh1dDXoHXH86STo9hGo1ORXgLsPzVFhz
	telK1JBt9lIQ4WS7mrVw/JbHaZR7DN1s8Sk500oqYwT12NV+xTkkCJOPBiAyJ4jAqxnAHgXMea+
	hjIjpk1J11SOI9uiogoN2euY6VQmEkIlQZ/LUWHbFvMitCEvT+LDPT7E49fz0S5ruGJ4=
X-Gm-Gg: ASbGncuP8ACpLATLWnzBraQglqD/9PDYZUtmx0qAnjPM6AeVd8eDEpmhnTchQojUHc+
	wxKKJixoOI9n43SCHtP+0NdyEo3dNhUiLzWqN24UOuaJ606MwdgHE4nrApHYlBOlZvUD58t8Q0L
	RFbzSUjdVcDuknLKO4XZz1cCTPh/O47oQAE+GrK96oF0752BL00jYy21NIaforl6M8+ztF+RMLy
	OAHQqWjykwHrPFKpTGYsXKR8vhfV7ZiAGoLJdSA6sotaw7rnQBAHcMmQmriBsN4ZXohfbG6Na32
	HeS36UzIGGpy3ekUNMLQnGwB0GzDQIlzNtXWBVf8zp2tp3hNdQ76tOF3GSDs2kO67Mh21/C5yvr
	JV9s8ywvaM9xaLt/EtDjq6C93lZdNwCLLBx1KW3/psIAICrrS+sBF
X-Received: by 2002:a05:6214:2508:b0:706:6967:71da with SMTP id 6a1803df08f44-7070069c664mr109753376d6.38.1753386095114;
        Thu, 24 Jul 2025 12:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQDqKstosSneJZpb85nOhQ+2TXw7qj/NhXKc7lo8KhtjTczwG5CeYfAMo04mula3VPY10+OA==
X-Received: by 2002:a05:6214:2508:b0:706:6967:71da with SMTP id 6a1803df08f44-7070069c664mr109752856d6.38.1753386094418;
        Thu, 24 Jul 2025 12:41:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c87a88sm501393e87.152.2025.07.24.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:41:33 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:41:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 01/14] soc: qcom: Add UBWC config provider
Message-ID: <jfslenwbfdoy7qz44on5ckzuljrxfjce2encitxiz5pws2iecl@2xnwdlpppmsk>
References: <20250626-topic-ubwc_central-v6-0-c94fa9d12040@oss.qualcomm.com>
 <20250626-topic-ubwc_central-v6-1-c94fa9d12040@oss.qualcomm.com>
 <CAL_JsqLviOtUjzyq6Yg5tksxV3ANuxorX7kXcn6ibFi+mPwTog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLviOtUjzyq6Yg5tksxV3ANuxorX7kXcn6ibFi+mPwTog@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE1MyBTYWx0ZWRfX/btOGVjQNjJz
 /wz2QKNsR8IRYsUn14wbzFtVUvv8basSqC5n5CRmrybFjsgyqU6pFbrYVjHOnTpdfcZ25PswyqU
 Cpx7es8IsMsy934M62z2fkcvacaWFI7aDFf5mmhtBEHP021P6nQoGRmbpYoliwL/U4i9d9WRz3H
 Yi0/E5Cu4qNqfBp3p88p8xlUKWyNRM4vNKddav5UWzQGHyVTfdjAhtUMVcQAiEz2vyQzQMEdlbQ
 UjpVBji38KCA7oRVPuX6i+4fk+S4sm+ZM6SW9jSWOZCE/Hi3WQROC4Mz8D5H1EbdCJ7yPHHTWkp
 aL77RFlYsniR9/lMq3Wbzb/kOpXtKk0OhkothzV1sxgPHoTuruBWHyBsoJELlPj/OSDFB0IpD9W
 JC6Dm0cjnpv+QPTp3zDgxppcNGBh+GK/4RcYyOP5bUfe7E+kn0n073f+hu+ac/0EJEyPO/yS
X-Proofpoint-GUID: Ukp34EkPqD6VT9xTD-khViJhxgExE67G
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=68828c70 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xQNkBhgbifyRU6rVYtUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Ukp34EkPqD6VT9xTD-khViJhxgExE67G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240153

On Thu, Jul 24, 2025 at 12:24:29PM -0500, Rob Herring wrote:
> On Thu, Jun 26, 2025 at 4:02 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
> >
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >
> > Add a file that will serve as a single source of truth for UBWC
> > configuration data for various multimedia blocks.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  drivers/soc/qcom/Kconfig       |   8 ++
> >  drivers/soc/qcom/Makefile      |   1 +
> >  drivers/soc/qcom/ubwc_config.c | 251 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/soc/qcom/ubwc.h  |  65 +++++++++++
> >  4 files changed, 325 insertions(+)
> 
> > +static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
> > +       { .compatible = "qcom,apq8096", .data = &msm8998_data },
> > +       { .compatible = "qcom,msm8917", .data = &msm8937_data },
> > +       { .compatible = "qcom,msm8937", .data = &msm8937_data },
> 
> This compatible is not documented.

Oh, fun. We have several qcom,msm8937-foo compatibles, we have support
for display on MSM8937, but not the main platform compatible.

-- 
With best wishes
Dmitry

