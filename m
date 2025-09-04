Return-Path: <linux-kernel+bounces-800443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBCB437A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22210169E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312722F998A;
	Thu,  4 Sep 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lm/Cv9PC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E702F99A6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979547; cv=none; b=eae4VOfMv3isS6KHrIAf85j5XNL8du+uyhYNpbxp7MDu94VERf24foHguQuJWX/8IwhJIaPkj8dBlByz6H6CDfyYjKD/g413yRF1sH+Zx4IOFMH9LXiBQghTF09cB+xvBIPsFZGCXvfLMODpr1YlRkoJG2gX5201q5enrKHDF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979547; c=relaxed/simple;
	bh=0Bc3P0XvcGpoRu4+CwZqqb8LlVFA3+CaY9mfLAEHlx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxHO5DP8pplisYMXniN03QMiCGZOR0mKRXLBH73UUdWd05rYtVkNMHdqT/8RLPGubtTEEkcTRydfYgw/sXVN8Aj6NuCfi3eqvM+Nofj8SaT+veAdA1qyqLeYXOJK1bktWi/V8U/xVbU69AsYA9Qprb7IQ73xF4sKs5xRJloJbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lm/Cv9PC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7hZ003771
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=roP2Cb+KhhXpyTf8KVgqlWlP
	8WRvNVjEfW5IK/vjwLs=; b=lm/Cv9PC5Znn2uqmFInlkAGHljCJ3os1xJQB0/2Z
	o3tmIivcPXACqbWofVkdH5JCojub+yncCFUrfwfXxOl62gtUny5YvEUHZYTwJBzP
	iXPTb64VDHQj9LXA7RVCOkr2Zz3L8HoPlen15wHGiI7GQ8j+1S5PI6aWnZlrfkJU
	Iy7l37XP6Ufe+QbNBbb4HL2zYcyg5C+OPLtrc/f491a8bMjDuSvI+m0iSpofzN0P
	rc6Y+Cn9poZNlQvopPmBRyuNAS/BJrCRTqxeHQaqIFumY5yooF4Javc+frWcofxp
	rE7q6DOxkjfe2Iq/jnGBUTcC0eaP7uFtgkdCjlFbJBmeJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s73ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:52:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724bca103dso822421b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979542; x=1757584342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roP2Cb+KhhXpyTf8KVgqlWlP8WRvNVjEfW5IK/vjwLs=;
        b=sCmATyAokjHAA6Ilw2c63POJyqAbPZhLUJQ7dlV874PQFW6/K69i0TiNsxfNMCCNdc
         IubW7LTrdk9vsiYmhWN5naf7JCys8V0whxuMbVDRZnK1mnJqY/fXhIZmtbFAP4gehUDV
         MaTHlP1Bz5/TJymRRZhSRms3piF2lh37m1mwLtGMzgXLnMU8iMwX/724gxmpCaoMDuDK
         nF/qzZmAadecVw53HhWsJf0h57TEyq0Mr4v6g3V5AHZZSWcMf37Gn8JudRV6Y9mRRach
         ogcQhQWy1Hn5kgg8dInaLgskXlYyMo1wF8hy2A8abM+jd2drEkPu+vx48BnV+oG2jPpO
         AIfw==
X-Forwarded-Encrypted: i=1; AJvYcCXHJae/pmGXS7TaR4dIrK74BjcA8h3+UvzIMS7j/IGyjS2iWxmPJ5MNCpIpjZDPgWt1Yht+NQd0uOMbHM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3nAB7e1i3jca8jgzd3gJtDbmiE4AKjJMYktXpZv69/Two04H
	2xua5p1gE6qw30INY8SsZ/qqOHhKD1N87nqmFSpEESsSP3KxG11uBpNCZXQUlRIj9C8OpacD4aO
	Hp0oWsg1o0LYGUxGBXnaTjRncq7Aay0xy7mIruQ7qc5sHkAT6rq5LEdosVVEU9qH9wM4=
X-Gm-Gg: ASbGnctPCm55NsPknXOj8xiOX3kyiiC4+ZjTouajLnrg+tXU3q3zjGT4KbMf/q5Vxo8
	fGAP9BXex2mce2129EY82zmmeTPbnhr1Hi3dHcp7jqLdVVKEFwhiQ68z0O5m+4jSYBwvdGo2pSt
	uV1pJjO0si+/0nmxicCO5QUzX+Nr/2KfWwQgQ8Av/reLow9ole69zEVLG9ZeiW+0bARSIP14t9n
	Hikzb8BxV8k+9+87/uhET2Yawd5U5v+7H+cdjkyg7bnKiB1k2t8Rg7h2+UEzzjTeRT+A69NwdmV
	FLGelslFtgNKNDyAAjWqlfvdnu8PSZyd4+G9/JpZrIZ+/4FLe3mEFv6qCbfz9eBHtfk=
X-Received: by 2002:a05:6a00:4fcd:b0:76b:ec81:bcc9 with SMTP id d2e1a72fcca58-7723e342f6amr22020653b3a.21.1756979542312;
        Thu, 04 Sep 2025 02:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAjN+8ImBourO6S6qeIBIf9ESDV0Fq8gGseTXKI5xhDrlTdekjc+51IX/W1teg14iNdtVOIg==
X-Received: by 2002:a05:6a00:4fcd:b0:76b:ec81:bcc9 with SMTP id d2e1a72fcca58-7723e342f6amr22020630b3a.21.1756979541788;
        Thu, 04 Sep 2025 02:52:21 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772306a1870sm17912598b3a.75.2025.09.04.02.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:52:21 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:22:15 +0530
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
Subject: Re: [PATCH v2 02/11] soc: qcom: mdtloader: Add context aware
 qcom_mdt_pas_load() helper
Message-ID: <20250904095215.ekkhrt5ql65ap74k@hu-mojha-hyd.qualcomm.com>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-3-mukesh.ojha@oss.qualcomm.com>
 <0b4472cb-0c73-4eb8-a360-22b40aae44f5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b4472cb-0c73-4eb8-a360-22b40aae44f5@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXxWAuRTjACpPF
 PlNLc/Bgy5fDeutQgNXApWfUb9y0dWBRIyjP7uRrFohxGy/SrrkKojHLB58lTre6fsS2PFQdXb3
 +fkPQUCiynT6xbg6vFhcNIf5kLrhhkyjJdVCHiQ1RECUNo72Es7AfGjG23vRPCOYjhX7wXgGe7s
 J+8lbsVt9x8PxYixTxedV3WuzrdWJjeta5sLfcpIqrrDkQOAah3P870GL8ubzZUG+5u5pQrhJEj
 OZ8o/3JIbZa4m/ErAVPYwiTtmeXkaDvFqNIEU1/1XcrvKkUh3V3IAZMVVgu1taksYl0Qm1WRWbt
 WBfOi7KlY717R9PYTidGvjwFX6Gs8xnswcTkHMBOBqef+widZkIt0k8i4ZfR7vmDwDg7ZuhLu7z
 Ej0Q53NS
X-Proofpoint-GUID: OuEKbTb7yQ0g_2w190Um0Xo4i6Dx7lZ9
X-Proofpoint-ORIG-GUID: OuEKbTb7yQ0g_2w190Um0Xo4i6Dx7lZ9
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b96157 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IDm2FHnpOmf9DK9IQ3YA:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Wed, Sep 03, 2025 at 04:03:05PM +0100, Bryan O'Donoghue wrote:
> On 19/08/2025 17:54, Mukesh Ojha wrote:
> > Currently, remoteproc and non-remoteproc subsystems use different
> > variants of the MDT loader helper API, primarily due to the handling of
> > the metadata context. Remoteproc subsystems retain this context until
> > authentication and reset, while non-remoteproc subsystems (e.g., video,
> > graphics) do not require it.
> > 
> > Add context aware qcom_mdt_pas_load() function which uses context
> > returned from qcom_scm_pas_ctx_init() and use it till subsystems
> > is out of set. This will also help in unifying the API used by
> > remoteproc and non-remoteproc subsystems drivers.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> 
> I'm struggling with the logic here a little bit.
> 
> You take this function which calls qcom_mtd_load_no_init();
> 
> > -		ret = qcom_mdt_pas_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
> > -					pas->dtb_pas_id, pas->dtb_mem_phys,
> > -					&pas->dtb_pas_metadata);
> > -		if (ret)
> > -			goto release_dtb_firmware;
> > -
> > -		ret = qcom_mdt_load_no_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
> > -					    pas->dtb_mem_region, pas->dtb_mem_phys,
> > -					    pas->dtb_mem_size, &pas->dtb_mem_reloc);
> > +		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware, pas->dtb_firmware_name,
> > +					pas->dtb_mem_region, &pas->dtb_mem_reloc);
> 
> and then turn it into
> 
> > +int qcom_mdt_pas_load(struct qcom_scm_pas_ctx *ctx, const struct firmware *fw,
> > +		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
> > +{
> > +	int ret;
> > +
> > +	ret = __qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->peripheral,
> > +				  ctx->mem_phys, ctx->metadata);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx->mem_phys,
> > +			       ctx->mem_size, reloc_base);
> 
> Surely you want to qcom_mdt_load_no_init ?
> 
> On current kernel
> return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx,
> 		       mem_phys, ctx->mem_size,
> 		       reloc_base, true);
> 
> but that's a functional change
> 
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
> the no_init version of this looks like this:
> 
> int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
>                           const char *firmware, int pas_id,
>                           void *mem_region, phys_addr_t mem_phys,
>                           size_t mem_size, phys_addr_t *reloc_base)
> {
>         return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region,
> 			       mem_phys, mem_size, reloc_base, false);
> }
> EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
> 
> So is it really the intention of this patch to change the callsites where
> qcom_mdt_pas_load() away from the init version to the no_init version ?
> 
> Maybe its a symptom of patch collision but hmm, having a hard time
> cherry-picking this to test.

My intention is to unify all subsystems whether it's remoteproc, video,
or others using Secure PIL, so that they all use the same set of APIs
via context (cxt).

Like, we first initialize the context, and then use it for other PIL-related
SMC calls such as pas_init, mem_setup, auth_and_reset, or even for the
new rsc_table SMC call. This way, everything is connected, and it
becomes clear which functions need to be called and it will also be
extensible via a small handling for SHMbridge on gunyah absence. Similar
changes would also apply to the MDT loader APIs.

That's why I asked here after "---" in this patch if this approach is
preferred, I will apply it consistently and eliminate redundant APIs.

Let me know your thought.

> 
> ---
> bod
> 

-- 
-Mukesh Ojha

