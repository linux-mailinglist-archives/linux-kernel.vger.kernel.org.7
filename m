Return-Path: <linux-kernel+bounces-640107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEBAB00B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9179E4DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309D284662;
	Thu,  8 May 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2UVzOGc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A885279916
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722929; cv=none; b=o+tsxVq3AlfqBrgiPDj8M/poWIi39tKKU9DdwNEfJQNvuCX91op+H5SSDVBP8WCd14vbqRKRXmjx7FnuFtyouhbLyhWYeYlMLJ5vXJ1/tYN5mOLksFXfdEUf7WtIlUq291frVZI5NJnVe0+VoU/4FoQUqW4JPfhX3moZbcVDD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722929; c=relaxed/simple;
	bh=KQmoh3AJHwEw2cboRfJvYLgzmcYfASo+BXAQJyUWAZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmKi1ZqXZmxAOaDXJcdkLfiVvqlxUyK4WicJAImBNFsmfU2vlddUwIdihaKKeSOeuFylY9N8LSmwokl6I7VMh23509YCXZXYM9v7rfkQfdkMim/8Rata/iT81Yhpn5FJuClmfL2mWyRdwJX8z2pmgQ2/hi0po2nITODUCp7c0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2UVzOGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D0Pvh010146
	for <linux-kernel@vger.kernel.org>; Thu, 8 May 2025 16:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IgbXxKI+z8z6kLlm8PuoMSAP
	erf7Js6dwsIubjE5Tr8=; b=I2UVzOGcMKJj8+crKrDn54ygUMjmwoSmbAI4OhOp
	WoknggJeGWVTb74KEEW4QnqoDRw3abRBuDYmxdte1cAN0c3hgPKOiZfliGeDBfP0
	n0LRgUP8dz/x3z8znR7FvBL2+HDUpuhxKn91IZIg+lgsNnptOfQWVem53Goc78Sw
	Ch6yfFPcYJGjzd9Pysbd0ldYlnmxVHDX6HYyKCi/dxUouei7e1S/Kiyib3XqXv/4
	BuNGGdERc+0IKtTky/ALjt0UodXxK5N8b/f7msKT9ymaIbd5I1NKt6kSggEmjztW
	u/FIDcSCHBNYANaETaIuuct8eeqMLk6/JGa5cMyu/wFNYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp7a1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 16:48:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7394772635dso981793b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 09:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722926; x=1747327726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgbXxKI+z8z6kLlm8PuoMSAPerf7Js6dwsIubjE5Tr8=;
        b=nlp6R6nmdt09ULFoarwG+z/PcxAKCpzZwUQCR1NMDTWcBw73s1sB0thc5KIrUID/Y6
         PQ6/ES+3A/o6Acu76E7AIHqPL57CdRjgZv0VCP/Yy/k8U2TT7pfS2+8vPjmfnXUFVLjo
         Q/+nrAxm4SV7brPpx1FIWndC6wanuk6noQwyn4kKT0lOiQA0LWC3RkBcEdwHWLIx/cpp
         m2bWTaysaf+6qbOLStfkYoGAWOvbNjcivB2ezVtOBAcInXSsmHvajzRSHdc53ZhyO3Pm
         Xpk7bPFb/L4Bg48fopnaeV8endrN+k3AqP39ZeGHTFNTB1xOMFvmPhqY0XpuRe2FOluq
         NE9A==
X-Forwarded-Encrypted: i=1; AJvYcCXh6P6PDDBMLgd0lOBs9Lh0IH4fKKiM4AF3YrPFjCbJc9tSqaRx9nH41aKpA9kqpdL1IGzY/M0PfgpoTdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/dhONZ0qv7bl6VDipP9OzBrmeqFBSr83xjXrHaf3LXWEObhW
	ky1vpvBe9Sx4XbChPql0twMeg6eoOnjPCOpL79KjSKEEt+S2MlPCkI3Y2Am25tpulNHsoFm93Eg
	oBC98AD7kKSe5ULsFMXxNQ2jiFzc9MNYHqb/YrQ5Y+tOl3Mf66vveOHBsKHalWex6+/0PRkA=
X-Gm-Gg: ASbGncugv2IT4RfcGaoheL5vn/BlYdzdOPqlw4aSeQ47FZ96MELtY0+blpQkKVx1gww
	ErQ7rnBXMe9/EjYfZi+ol1XKKzi+TwqF8UrhVKZZT4w4qBI9NzZ9gaxWPmO+uH3LnyQGvK2QYQD
	FdTrYgMWTyB1q1WL/49S/mBgTONQTDJdVqZKMSeTiVEjWDfJLACqLpV1XnDlz9w9ltTV/3deeRM
	uBO3BwFUOW+SaAwDmemz8byYY7mKuFW3+bfyoqu/WhN/7AhRY+NN9czJLA7IPtSeL4S3CgUzgDj
	5wX1jAyYQLjiNG727OkwFlwXKYdjpaMZc6FjQqI=
X-Received: by 2002:a05:6a00:2f44:b0:740:9d6b:db1a with SMTP id d2e1a72fcca58-7409d6bdceamr7328274b3a.15.1746722925758;
        Thu, 08 May 2025 09:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH913otIr7kbg3QzAP18a2sNNmlEbDpHVmbC972l+FTxz+htTGHT9oY2SgdTCxM1m6OPFf/HA==
X-Received: by 2002:a05:6a00:2f44:b0:740:9d6b:db1a with SMTP id d2e1a72fcca58-7409d6bdceamr7328252b3a.15.1746722925325;
        Thu, 08 May 2025 09:48:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704e07sm240194b3a.10.2025.05.08.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:48:44 -0700 (PDT)
Date: Thu, 8 May 2025 22:18:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: qcom: socinfo: Add support for new fields in
 revision 21
Message-ID: <aBzgaKSspA0Af0sZ@hu-mojha-hyd.qualcomm.com>
References: <20250425135946.1087065-1-mukesh.ojha@oss.qualcomm.com>
 <20250425135946.1087065-2-mukesh.ojha@oss.qualcomm.com>
 <mc6n7fbhjhe6cxyoqkxs23kjs7gsa5cihy6qwrcrnz4g3kwjms@vh3vfqzfprw2>
 <aBzPn2OXapJLsikk@hu-mojha-hyd.qualcomm.com>
 <s5fd3txerbwgzzgqnoovkffmijgub5dxfucqqskhdqyjqzkbyl@5cyycrfmubup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5fd3txerbwgzzgqnoovkffmijgub5dxfucqqskhdqyjqzkbyl@5cyycrfmubup>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0NyBTYWx0ZWRfXy5jNHZrWK4b0
 657rUATTE+1cKCQgFa8qboCHaPKCySaZoTugOoXp96Pmit+C+yOIkzYxl+vzV0jIvuRM1MVpuf5
 fY1IRAEy/IXBfWX8gv4D/IWXSdvCc6yK83SQBz1eHiAT365xDOa2NOJO1LkRSXETAEIA9zch+cc
 Gt2eVb/kR3WGItZ9mTON7hyQCoAh32NaPby+6BhERuc1hM7gSr36StIH2ivqkPEQ/ZaACraiKi7
 HxVGBoJxkUIYXBOCqsFmtnsiDbZo2rja6lfnaWAdf+jHChp4CfYtjvvsp6v7gd0OE04akERjrE3
 +RrFLR1gbDYQp7Dw5+J17NUFvgpMOhCq0NhBJmhr/yiK6e4dPDO/+eqhQ0oeUlqK3JGdLlEPv94
 2Ns7lVC6OUEVXylPKUzKYenyL/oQzjYsfPfajv1Db9u2TvgYGWCVmpJjqEyhtTjdFLmGzyD1
X-Proofpoint-GUID: g9qrjeTAirR4-Flrkuvh6jzGrs3HjXmZ
X-Authority-Analysis: v=2.4 cv=B/G50PtM c=1 sm=1 tr=0 ts=681ce06e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=S0qan5B5_AHtxJkbWd0A:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: g9qrjeTAirR4-Flrkuvh6jzGrs3HjXmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080147

On Thu, May 08, 2025 at 06:56:47PM +0300, Dmitry Baryshkov wrote:
> On Thu, May 08, 2025 at 09:07:03PM +0530, Mukesh Ojha wrote:
> > On Fri, Apr 25, 2025 at 08:28:51PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, Apr 25, 2025 at 07:29:45PM +0530, Mukesh Ojha wrote:
> > > > Add the subpartfeature offset field to the socinfo structure
> > > > which came for version 21 of socinfo structure.
> > > > 
> > > > Subpart_feat_offset is subpart like camera, display, etc.,
> > > > and its internal feature available on a bin.
> > > > 
> > > > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > > ---
> > > > Changes in v2:
> > > >  - Added debugfs entry and described more about the field in commit.
> > > > 
> > > >  drivers/soc/qcom/socinfo.c       | 6 ++++++
> > > >  include/linux/soc/qcom/socinfo.h | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > > > index 5800ebf9ceea..bac1485f1b27 100644
> > > > --- a/drivers/soc/qcom/socinfo.c
> > > > +++ b/drivers/soc/qcom/socinfo.c
> > > > @@ -154,6 +154,7 @@ struct socinfo_params {
> > > >  	u32 boot_cluster;
> > > >  	u32 boot_core;
> > > >  	u32 raw_package_type;
> > > > +	u32 nsubpart_feat_array_offset;
> > > >  };
> > > >  
> > > >  struct smem_image_version {
> > > > @@ -608,6 +609,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
> > > >  			   &qcom_socinfo->info.fmt);
> > > >  
> > > >  	switch (qcom_socinfo->info.fmt) {
> > > > +	case SOCINFO_VERSION(0, 21):
> > > > +		qcom_socinfo->info.nsubpart_feat_array_offset =
> > > > +				   __le32_to_cpu(info->nsubpart_feat_array_offset);
> > > > +		debugfs_create_u32("nsubpart_feat_array_offset", 0444, qcom_socinfo->dbg_root,
> > > > +				   &qcom_socinfo->info.nsubpart_feat_array_offset);
> > > 
> > > An offset into what? If this provides additional data, then the data
> > > should be visible in the debugfs. Not sure, what's the point in dumping
> > > the offset here.
> > 
> > offset into info(struct socinfo) object.
> > 
> > I agree to you and I said the same in first version this is just offset
> > and does not provide any debug info we would look from userspace.  For
> > parity with other fields I did it for all newly added fields.
> > I have dropped it in latest patch.
> 
> I'd rather see the decoded structure that is being pointed by this
> offset.

You mean info + info->nsubpart_feat_array_offset ? 

There is more to it which I don't want to mention as they are not
upstreamed yet and unrelated to this change.

data = info + (offset + (part * sizeof(u32)));

e.g., Here, part is a enum represents camera, display etc., and data
represents their feature presents. Since, part is not upstream yet I
don't feel we should expose this information to debugfs. We could always
add them in debugfs when such things are standardized and upstreamed.

-Mukesh
> 
> -- 
> With best wishes
> Dmitry

