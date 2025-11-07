Return-Path: <linux-kernel+bounces-890422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE249C40061
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012803A9F60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056D281369;
	Fri,  7 Nov 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOEPCMAO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZVuY1Vg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA64280328
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520668; cv=none; b=KfTxmnn+8R8UrOB07hUTZamZwiqJagXrKElT8uciPMs8Y6rdSBF00LSiT1DNQdyxe1+k+gLvFFajbj8hrsNR/nacwo8Kv4OSYzkN384vhd4MyZFlDQCS87Ygo5L0qaetHMfmipvlOPzowveuL2TW04c+8g5LkirVAnfvBZYqNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520668; c=relaxed/simple;
	bh=Ted6AZIFVphD/F8lSCH5ehpbw5jTq6uqRnlR0itDLB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oak4U2kw3J11Libi3Ao/6gNeOBfFt/pOZ40/T9ZGJ8n0YWXY00eo2b4GmfCLP2QLoJrHv/OrWlmf/tEPydgtNLrPMy8gob/GYBdDhiOJzkCxn/RIzDtz8snkaOSvKLy7Y0Im8RFaCr47fpQCyn11gvV/casUxqr/UV53LOnp0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOEPCMAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZVuY1Vg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A77CGqt630895
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 13:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kS3XC1Ni5FhZbMpzDDtKCVF4
	F8GiZA0Y/05CysERk9o=; b=dOEPCMAOWcaga3C0izeYIoAFzPyuTV4xY26zcPJs
	Qb7yBGTQJtPvcTOvIGeHngbVgkDiarDyJo5lpZB521OpGqVSDzKmImHI89QeNTCJ
	7FzvZDuPbEgYrZrWNFPx/ytCJY4NzMD5o9yZ9k2S6UIKVdebMGGx08KFq9z/A0nU
	m4CUAR8GY5nYJRdymkSKMcCKdkPIKh3VodflxwMwrPt4+RvYxmu/YvXKxt+XkQ5I
	kopDLn2WqGjkh65qcsKTwju3ws8CcfNyRZKxkrbR97wB7KgCG8QeU0lrhLb19C1I
	mMBGZ51SektIaBaBAO84WO1HbDma5yTis8yqQ9laZuiFsw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a92232nrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:04:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2953deecdaeso17895715ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762520664; x=1763125464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kS3XC1Ni5FhZbMpzDDtKCVF4F8GiZA0Y/05CysERk9o=;
        b=RZVuY1Vg+Sra5fDKGuXWEyDuMQAc4zbkdxIBxCYWJRxupi+KlGZ74Li82mxeRGQpit
         9fOib18OB0mkSfpoJs3aTQkXgDDqmlhPGd0rPl2UWrE4pPxoYN+aij359Um+DAAQ/wSq
         KPqdmfKn8ap+NwE6SPKCvqrtJxhI5Ih94gwS2s9vs6b6naZOLYTgUxLli9JyzCBgWf94
         72SSb0HTTcpBw7GZJv7dwYWDC8mwrxyfboe2tRi/BtpEE0d0uuYIDZf5GowEaFsij7M5
         DBUa5df0pk78AmT6uup12VWsGpL5CcHV7oFm2m1w9P7KgKHHOhOAHB0oB8FN6NyAAO1B
         j7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520664; x=1763125464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS3XC1Ni5FhZbMpzDDtKCVF4F8GiZA0Y/05CysERk9o=;
        b=TkYalAoBRk3P3fjg+iK/9rQ7HjuKtdoPqBoEegCCQyddjFfe1dWXehSUsQxamQvB4M
         eJ7w6OTpb8GrEBvo0dyvjvJY3IWxkjsRA56bZ1EU/I6GEKTfpOMwNSVUieX6rOQI5004
         wSWwhvmOqKn5eQIM1e3OQ92zM+xrEvBL4spIv5iN4SmNRQSC9gpi9ymM/IuzvvP4kuDd
         gxrcVK6NkFQqGkwrR0HHngCmEXjQ+z5ZQfJ/oM4GIQbSSW8OiyXos86Kfbe1xjhnrSIo
         0j8vv2FmX80OtxAE2ANtxFBU121RTdgKXMkbzrKAtEB1iavoeR14wSv/znLYYktpSUhO
         J6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVyRpp/5JwvBYkuwrJKbxv5Vaoah3Zi1+GT4tHRjcSfRfrhADqzEtBpgMWQqc8u9LOQB4FngF0GKoqmb+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5c4FZDk6DnZ7B0uD280nKKOgFXrQtZKxPcxDVuRP+7lUpB/O
	pThrdxYahduWk9nkbtri1FYbyekyCX3K65jWEepFKIt9nFUfAWEy8RjEcFMx1hP7VyEsNRdNgaK
	qDBFeyeN1BtDC9pD4lCDNmzwpTR76fbIXSra6o5whCjZX5e7gdkpJ4TKLDSvDcj/Aecw=
X-Gm-Gg: ASbGncv+d0/TWFzVfjSFdNM01POKux3RkPMwWiZTcqeuPozgViHy6XaBOW96LM3br0N
	2wWq/GsAF2IZJAwPX248xmqInwjDP9zFdbOl4l1+UK+qvUMCi0LUvZdy+UtSM3FeNgIydfsidb5
	RFpivY4n+7Vy6yYPWSSwtADRMfMCgCKHbozCFYxgV7nuuJC6W5+QUdSvRWM7eBcODdk8vaeoalJ
	A7Z0XglEAwZr8RJhg3WB+gaYoBXllchtdJDFVK5c4Kr1xqRHVsAbhjdzZVB4tKsvKmkkzVpTfJL
	ufUGPHQGTSQiBvAkBiBaA1D4iGtAMUaed0XVTW52ObdLxy2EFgfa4j1tnJOQ/0SWlXFjIJVs1zD
	zDl0t9Luqvlo7deyPEHzR16lvGQ==
X-Received: by 2002:a17:902:d488:b0:296:5b82:abb8 with SMTP id d9443c01a7336-297c03e87edmr41728185ad.25.1762520663673;
        Fri, 07 Nov 2025 05:04:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDi3VCG+jeQPZKjaDhNHY0E8KIkUAIShvjAZuhx0bHnqGMm1WhD/k5gY8hxa9TPWGiaTBl1A==
X-Received: by 2002:a17:902:d488:b0:296:5b82:abb8 with SMTP id d9443c01a7336-297c03e87edmr41727605ad.25.1762520663029;
        Fri, 07 Nov 2025 05:04:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e791sm3028775b3a.7.2025.11.07.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:04:22 -0800 (PST)
Date: Fri, 7 Nov 2025 18:34:16 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/14] firmware: qcom_scm: Add SHM bridge handling for
 PAS when running without QHEE
Message-ID: <20251107130416.owdceicrivofyfxi@hu-mojha-hyd.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-10-7017b0adc24e@oss.qualcomm.com>
 <7a5d188d-989f-4843-a10d-0fbad94a9ef0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5d188d-989f-4843-a10d-0fbad94a9ef0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEwNiBTYWx0ZWRfX0zmr9FwJOMzz
 DWUkovqRPfro/jyPgtlfJqiXWKQ+w8bugdfDDOO2Uqh7SiUGMOYfOoyrHL2V2P5qGPnvpFet6AM
 ibgj661VUpQ1bTpe2kzBnZUPRMWhLU8n5VdYe6l94dc+ILYmbVODyOR817teO8DuhKsDbdXlWls
 gDqGdbNmv0CpRQdFxuzOsrRupIa7B6q9adI4cLoc1Q76tDUdC4lo5CKLOb+k+USzHX6NaOBGNxF
 I8I/UkCOtaGtrmZml2v713GwwktBi/fUakpU8zymza6zb0N1RY8Se5znTGK5E4msNMVRK7/oRzp
 I4PAj0BqHqiQdMgViM5x0R/s9WfsFEY0CoG2gu8lghE2bhQ6BYMr0kLoYt3sjcbysuLPzM/Te/Z
 aQmnFRoUP1R0PJmRGfv62a0BE4yqBQ==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690dee59 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=HuBIHT5r4gaFfCbWWWsA:9
 a=CjuIK1q_8ugA:10 a=s5zKW874KtQA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=Soy3cZ2v3rD3IzUh-QDm:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: vCgXelV5ZbQmoUcvY8h_JW-2XEMwaVrN
X-Proofpoint-ORIG-GUID: vCgXelV5ZbQmoUcvY8h_JW-2XEMwaVrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070106

On Fri, Nov 07, 2025 at 11:17:23AM +0100, Konrad Dybcio wrote:
> On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> > On SoCs running with a non-Gunyah-based hypervisor, Linux must take
> > responsibility for creating the SHM bridge both for metadata (before
> > calling qcom_scm_pas_init_image()) and for remoteproc memory (before
> > calling qcom_scm_pas_auth_and_reset()). We have taken care the things
> > required for qcom_scm_pas_auth_and_reset().
> > 
> > Lets put these awareness of above conditions into
> > qcom_scm_pas_init_image() and qcom_scm_pas_metadata_release().
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index aabdef295492..9d3e45ec73ac 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -625,6 +625,33 @@ static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *me
> >  	return ret;
> >  }
> >  
> > +static int qcom_scm_pas_prep_and_init_image(struct qcom_scm_pas_context *ctx,
> > +					    const void *metadata, size_t size)
> > +{
> > +	struct qcom_scm_pas_metadata *mdt_ctx;
> > +	struct qcom_scm_res res;
> > +	phys_addr_t mdata_phys;
> > +	void *mdata_buf;
> > +	int ret;
> > +
> > +	mdata_buf = qcom_tzmem_alloc(__scm->mempool, size, GFP_KERNEL);
> > +	if (!mdata_buf)
> > +		return -ENOMEM;
> 
> I'm still a little sour about this function having to be separate just
> because we use a different allocator..
> 
> Did we conclude that using set_dma_ops(some_tzmem_ops) was not going to
> work?

I think, you asked here [1], and we discussed on this. It is not
something plain that we can hook every DMA api to tzmem. This SMC function
or any such buffer which is passed to TZ when QHEE is present, is a
special case as QHEE makes shmbridge and Linux need to do when it is absent. 

are you saying set_dma_ops() every case or just when ctx->has_iommu = true ?
If it is for every case, we will observe crash during call of this
function when we will run with QHEE.

And doing it only for non-gunyah does not make sense..

or let me know if I did not understand your question ?


[1]
http://shc-kerarch-hyd:8080/kernel_archive/ed0b8ec3-035f-4ea4-83ba-8f2aba9ea623@oss.qualcomm.com/


> 
> Konrad

-- 
-Mukesh Ojha

