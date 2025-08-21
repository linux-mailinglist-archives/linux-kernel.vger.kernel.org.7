Return-Path: <linux-kernel+bounces-780298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D15B30021
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD41684C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A52DEA72;
	Thu, 21 Aug 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqDZeuO/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05D2D8362
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793789; cv=none; b=qVAzVabizZN5EADcWKLurb6wxY/TQHm9MGCdsLb5b8T/6Dsc8ExLUKRnFPDBhglo4v6/1iqF6BKNZw1be4z1kouBLtcoZ02GARelCYuhOThusP9b+ARrXDJbmuI0P95ot0+MWL9JsbBjtNjip/m5z5Cz5KEQ806KtVtVSs8g7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793789; c=relaxed/simple;
	bh=/tbXBa6r0uSu+NPSmXQFYhFY4TeDHvKdeP7yIapjbxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVUtR4lrJnKtcdBpFk5oLvpihJyWLXq9/yPKaU0i8xtVCNvXr+Tji98io/O7RF8ljoWrsgKE0rr7AuH945uoocfVgzL21f5dd+JGtoHDCODtKDeYHajjfnrb1INrD/elV0xdkxRy+iH6sQtm4S4lpwkNziWctzCgcmiHZWH/xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqDZeuO/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCvo006389
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zIhKFueIyr4p/yFGjoDpxYA4
	IzoEZUqKsKS0QB3Gip8=; b=gqDZeuO/ilYuppctcwwO5szg9iQ/C7BbwZfK15xn
	m0e6SqLB4lHcjMOIGXfvwxLAqO7lvJOftrIxqwRvG+NizFhk2p1639VdEoXeOJ6Z
	Vl+8QnMjfKyqM3lMiE3LmsYMQuomxMcutivszXLLB76ZveRioNXJy21eKp3rPizx
	VrUZ3rtxp4bC5QMsHZXiN/JuJXaKplsSQgqcjx3JCrDDHOhqteFSwRUD/h3TnhKB
	0H3+FlLLaPkbMoM2PUHuPARZtDdDiBe5Tncjhb7JlWOrbNNA3bovvbbRV6PLyqoN
	1tpq11IPpyEl7Q3ruLhzFAUIvVxyeEuU6VQImJdKYSJZwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52964ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:29:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2449b4f316fso10014475ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793787; x=1756398587;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIhKFueIyr4p/yFGjoDpxYA4IzoEZUqKsKS0QB3Gip8=;
        b=Q+916KrmqIQawhRIHAOZP4QZ1EZhr5GhgKaMUSMweU/SzhlK9sxmNqoOh/BCOwixMS
         iN301XZ6D9BDQE9QjmyHwHnhnoIZIT+M6zYwbMzQ8fvwmGMF8JhjCpkZTaNt+NzbRvbH
         STJMsypGKJHAmuLv0sGk+pipfM5nz/vMRUeoPl5LhKTE1FzhqNKsv5h0kUd7r01HGFxg
         pZX27J6sLTw70J1sqsjKAAQ5qLOUz/i8+n5QxHDQ/Uug+i585mHglnSKb8Q9N4QneNpu
         VNAlWi9Rd4LhU1ntPsIGOKH/saYdKP+HtRd0SRXANtGEXjwcoh3oTF8y1yFLDD+hDhFX
         PT0A==
X-Forwarded-Encrypted: i=1; AJvYcCV2RDKt7kV6EHJlav6noRX10Sh7cuiXNEJs36SoeUyP7AhLz34wz7JoRDOU4A1sU0v7YNLWM/Qjp+im9LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzW3y7yKuxUVxJgszMGzEET9UbkgkCQMxKtCBYWD+U0lrgKRv
	SFL/qxleOYex9q3sxxJWu7xVbm3Wp78njA7sytg5rFlVr6zF2vjJuBNo6lc+cbwf97g6ci3BDNV
	KbcLxDUXNtial+KZkqCbpDGnSarealPVlbYUAEUjeLt63kfDpZNjmRvRJAnwPdU34YuM=
X-Gm-Gg: ASbGncsE3JY/vqIVbRJ1+MHa2rrMIXHd6e2CA8TM/tJBMnWVenvWFanpRE5OyRLZ9dn
	ez6qZKfzaKWJCNqM3b6I1s2w5eqM6QV9jujJH1EnOn9wQIFYK8+uXt2SA82Fq752Hn45vuU/9AX
	CrWEmugAYiwx569JXXSHVzVRKPeuIFm9Lj6p5KbKIwoALx/A2LhFC+QTW0BL1stcckNAnNguywv
	cQD84CuB3Ix12YE32OYGZlm8axT+j0uLJofsegb7AayF6Mtdim5SpVit0y2p5qmGFBpSekaZNPr
	AIjPY116Tzw1d1Flzz+6PHkaw4/8S+lBrmnBDdfEmcRJ9Fz9Fi/lSZm6G6mHJryDovw=
X-Received: by 2002:a17:902:ebc7:b0:240:3ef:e17d with SMTP id d9443c01a7336-245fedd4260mr47644425ad.40.1755793786758;
        Thu, 21 Aug 2025 09:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFztsB+0vyvGfd9GpFN/m6bhvsalSkka7TFzQDwuhyvsOAKhMpUjb0k8uC05DSbFLMBUCGz9Q==
X-Received: by 2002:a17:902:ebc7:b0:240:3ef:e17d with SMTP id d9443c01a7336-245fedd4260mr47643755ad.40.1755793786041;
        Thu, 21 Aug 2025 09:29:46 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4e9bc2sm59691575ad.113.2025.08.21.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:29:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:59:39 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 04/11] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
Message-ID: <20250821162939.6s5hjsc36bmelmvl@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-5-mukesh.ojha@oss.qualcomm.com>
 <10d91d9d-b6d6-4a83-a697-909f97abc503@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d91d9d-b6d6-4a83-a697-909f97abc503@linaro.org>
X-Proofpoint-GUID: XinRoKOC-Vw8Lo02RlWGg2uSCXVr4LXS
X-Proofpoint-ORIG-GUID: XinRoKOC-Vw8Lo02RlWGg2uSCXVr4LXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+tu5yrMP0uqQ
 a8rASefGjPRiG0LamqOdQdDd4OMQ1v6oS9zCNQum1jVnYdvFuq7cCeB8X7Pmkei8NMoRH2bpNg3
 cLeUWEehvJJrhc4PL44JXtPEI0kVW7N5uGs2oVVfrCawKJjMXE2DqkdSxGsT8WzrFmmBF2GdbEA
 A6zRztme1zd1mVV2Fl/Q31jD2x49DtBKvO1lE32hcrdeW9UKtskNZypphhpFqmK1M0tGcN7H7Od
 l9Gj81OaxRPJCluV1r4Dudqd8W6ylfTl/cl3IIoaf02QTUUysHiTjlCBZ/kUgKHyCddG6AKZqdB
 qwN4wnlQotP15Ku+eKBvVneK119iGGYv4JW1yGsxql6y92XgrdG6Rw3oLLe5Px6ttvn0ZGkj15U
 obXE0YU5tIHgqVyjJgr8eOfyx+uMGA==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a7497b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=oHMyjcGywICXLiFiIg0A:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 03:36:26PM +0100, Bryan O'Donoghue wrote:
> On 19/08/2025 17:54, Mukesh Ojha wrote:
> > Simplify qcom_scm_pas_init_image() by making the memory
> > allocation, copy and free work in a separate function
> > then the actual SMC call.
> 
> then is temporal
> than is disjunctive
> 
> you mean than here, not then.

Thanks, its a typo.

> 
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >   drivers/firmware/qcom/qcom_scm.c | 59 ++++++++++++++++++--------------
> >   1 file changed, 34 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 9a5b34f5bacb..7827699e277c 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -584,6 +584,38 @@ void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
> > +static int __qcom_scm_pas_init_image(u32 peripheral, dma_addr_t mdata_phys,
> > +				     void *metadata, size_t size,
> > +				     struct qcom_scm_res *res)
> > +{
> > +	int ret;
> > +	struct qcom_scm_desc desc = {
> > +		.svc = QCOM_SCM_SVC_PIL,
> > +		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
> > +		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
> > +		.args[0] = peripheral,
> > +		.owner = ARM_SMCCC_OWNER_SIP,
> > +	};
> 
> A minor detail but please reverse christmas tree your defintions and try to
> make int ret come last.

Sure.

> 
> > +
> > +	ret = qcom_scm_clk_enable();
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = qcom_scm_bw_enable();
> > +	if (ret)
> > +		goto disable_clk;
> > +
> > +	desc.args[1] = mdata_phys;
> > +
> > +	ret = qcom_scm_call(__scm->dev, &desc, res);
> > +	qcom_scm_bw_disable();
> > +
> > +disable_clk:
> > +	qcom_scm_clk_disable();
> > +
> > +	return ret;
> > +}
> > +
> >   /**
> >    * qcom_scm_pas_init_image() - Initialize peripheral authentication service
> >    *			       state machine for a given peripheral, using the
> > @@ -604,17 +636,10 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
> >   int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> >   			    struct qcom_scm_pas_metadata *ctx)
> >   {
> > +	struct qcom_scm_res res;
> >   	dma_addr_t mdata_phys;
> >   	void *mdata_buf;
> >   	int ret;
> > -	struct qcom_scm_desc desc = {
> > -		.svc = QCOM_SCM_SVC_PIL,
> > -		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
> > -		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
> > -		.args[0] = peripheral,
> > -		.owner = ARM_SMCCC_OWNER_SIP,
> > -	};
> > -	struct qcom_scm_res res;
> >   	/*
> >   	 * During the scm call memory protection will be enabled for the meta
> > @@ -635,23 +660,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> >   	memcpy(mdata_buf, metadata, size);
> > -	ret = qcom_scm_clk_enable();
> > -	if (ret)
> > -		goto out;
> > -
> > -	ret = qcom_scm_bw_enable();
> > -	if (ret)
> > -		goto disable_clk;
> > -
> > -	desc.args[1] = mdata_phys;
> > -
> > -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> > -	qcom_scm_bw_disable();
> > -
> > -disable_clk:
> > -	qcom_scm_clk_disable();
> > -
> > -out:
> > +	ret = __qcom_scm_pas_init_image(peripheral, mdata_phys, mdata_buf, size, &res);
> >   	if (ret < 0 || !ctx) {
> >   		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
> >   	} else if (ctx) {
> 
> With those changes.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

-- 
-Mukesh Ojha

