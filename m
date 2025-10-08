Return-Path: <linux-kernel+bounces-845150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C4BC3B44
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E4519E343C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8062F1FE1;
	Wed,  8 Oct 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV2xWan2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757742F49F9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908933; cv=none; b=poaOmvvhkHlqqXT5SkVAkpW50+lbnBKP/yWroqyHVAsF7PKfXK7O/J7LUEgvdCT61bujhywxrQEOFGFFraiFirvMO1nDrh6KLq4awp9ToysrSPiaXJBpfCA/GWlCK/t4shQe7rm1NOgqYZAbDo2sZ8TK4tkPPZthWY683ePNXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908933; c=relaxed/simple;
	bh=F4Jf3/Jx2Wrf9ObJ98QM9rPrenllrUtXKxkbFh2XhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL7HVq6dgz5NeePwnCRuQe9sW5TmhjbiexTY8R/b9YvRyxucUR/tXxSrRQXOuofa75er7s3VQ8Qx2MUe/ElByeWiHQVUDcXV9mg0kaVBaLpgYfNUiMie+Y4O+IWKVFfULWGsf5I4wH1ao2dXuovcWZjf15OqQBa5juLcubkcyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cV2xWan2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803pcS024073
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 07:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iiYKnuUQureOztNmxjz+R23v+NHrM5vRIegiMWn4T4g=; b=cV2xWan2lpcGhei+
	S2278UgtDFr6SN4gmmI/rpGUbpYCIIrxysHH0c/NZ6nfB0iXlaTkXkWbz4AlamlN
	IrBi4dRtWQze9TZUcnZ8jSrsQocbbRQdQxh7V4PE2mRXvc8tyAtQFSVwCCqVMcvw
	cV4uj206WqbYSK8/U/8XGPrLdZg1mK4/ws3BmONyB+8jORgwbtDLeCWG3yITPeis
	c43d/Hr3pmCAi3ytoso3tZi6gMp1g4i5ZCDaseUOVpakaOD4B9a+UyW/bFvRM+lE
	ZsLenuunxelrpQMYFIC8NMw8jSefUGckMzYDgw1gkz8VMbhsHplYxgmJ5iWHGpxW
	ItYwXw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk71q7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:35:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f914b5a4so6644523b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908929; x=1760513729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiYKnuUQureOztNmxjz+R23v+NHrM5vRIegiMWn4T4g=;
        b=rT5++GOG3a/Utcu9JO7d8sHryckiNllQESlXSEa3QUwuoGG9E+pBLnl8WK6Kgfrx7M
         xdPAZLeYC+h9oi/JAQHRH8yolzCcEzqoFShJY+z9h0NVySdPSg8QpG/Po1u8n/EGa4ea
         l2WldfpIMbqe/0wW8LFxc3f2k1+mC/nM7x1ChEnyfPrxKQSm9WO8x9o3ZaBIvnxAKGqx
         R7AXB7TELY5UbIWcLNpki9Qsm9DKJ/YkIbS5n60jb1Nad9An+D/WZWg359TFHVdvXLgE
         Sr69MN8HFADuMs3tZOmdVGTyL9DSD1THD5SaL6885tabsQ7UWpo6rjeL4NhKyk4EBg4u
         l34g==
X-Forwarded-Encrypted: i=1; AJvYcCXYOzk2TP6Bm2mrQ4PIrTWdWouWf5WQhrtDi9mokCzkBZGRuFq2EC8alsVqIyIDR9wTe/ziWSofZ/OWev8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqLcvaWSIuPSktt4nHfkhzxNn5yIQInT3LxxPuCvyx/QRixI8
	4sNr3qSTirxK7EIJa4XpGKtqKQLVfkNQlaYEBPNruDBgBkjGhzZG2bFnYNO52PMrG1qGg5p/5mo
	zJWH4iTHobcRVzsY+EBIJA1q84GNNP4oaGy0Ew+f7ueHQ21/8dyJg4pmiCZyr3cYYYmY=
X-Gm-Gg: ASbGncum43EoZNW2/YB+lMQitKsWSSbkapCQfxYXEzcECOAQIboeBXZG6o3f4uERbVn
	pMcqdsJwokBNt1ubDFi26JPVj5z5vArDyWVVstbep/mHmUq7OFV4cVy3zfQee3mFgSatzkRn2Zh
	VCew8FkFxKR6d1uSBjZMyr5loJ6pxwiJMd975CE0ooYee/xpkTPT3NYJd51P4fFVeWOW2ShoBh3
	JBCaU7A5KsFTqO2lnzM1XyvuiW1RrRl7PgiLXN+99fNucJ9LtJjUOZ7ZEeGIaVzjkCsl0JPt2qG
	/8jJTq4qybCZ1/+KgQfWKuh0urNlcVhgZXuFXNucov51PL9FhB3yPPhAkIWU0eMiAuBAP9Du
X-Received: by 2002:a05:6a00:9298:b0:781:9a6:1175 with SMTP id d2e1a72fcca58-79387c17855mr2747277b3a.25.1759908928354;
        Wed, 08 Oct 2025 00:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZSMKoKEdQQfj+KuO8JF5SEBLYOmlTZtL7VL9jTiwIRBF7GJdJ3rVJjNWFYe4E2jpO7zRbQ==
X-Received: by 2002:a05:6a00:9298:b0:781:9a6:1175 with SMTP id d2e1a72fcca58-79387c17855mr2747235b3a.25.1759908927674;
        Wed, 08 Oct 2025 00:35:27 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ced7sm17817725b3a.15.2025.10.08.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:35:27 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:05:21 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/12] firmware: qcom_scm: Add a prep version of
 auth_and_reset function
Message-ID: <20251008073521.ky5cxxrxntundezl@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-6-de841623af3c@oss.qualcomm.com>
 <juirzpdb7ltx32fdiu37q3fd543fctvtssnro5qv4satninz2z@3bxup227lvvy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <juirzpdb7ltx32fdiu37q3fd543fctvtssnro5qv4satninz2z@3bxup227lvvy>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX7BAzbQuEcXFD
 o6l4z8qZsLQOu7Bw5H+Aapva0hQ4+rgFfgrJttmiv77Xa3GCF76UipP+M6vL9B4RRkJvQsmdkdN
 VT20gmB9dRJXlZBMEjEszFCZmq1yKQ0mDeq84cUqjwRS8RY//7AYt2RKatW6PJ3ZNDV9G9cIKCT
 bMo6m485yNzz8rDVPn+E2fTSQ5fGEloWQVkzldqSPZk4HrZC2YMc8wkzYtPf4jC7VhRuCN84km2
 LqVqZWPnUhW+ii6zfrZ1+D5IJAuh+cp7Yn8doMT6iko3PFUTszgMfgnqvhYe53UpCVK0FF4t5yG
 RHqvngbCfq8+lE0UclXaeqMH2TYRn9oYLx4e3NEnvbWasP8veYvFsAOmsz2Ni/6sU+Ix5vGovlU
 daR+17JS7/neUBQl0/ondnCYS5VL5w==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e61442 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=H8e-7uY52fie2kMTd9UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: eJfYRtw4PLDk1ilpScsu9Kzh_0xG2EK2
X-Proofpoint-ORIG-GUID: eJfYRtw4PLDk1ilpScsu9Kzh_0xG2EK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Tue, Oct 07, 2025 at 02:37:40PM -0700, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 10:18:51PM +0530, Mukesh Ojha wrote:
> > For memory passed to TrustZone (TZ), it must either be part of a pool
> > registered with TZ or explicitly registered via SHMbridge SMC calls.
> > When Gunyah hypervisor is present, PAS SMC calls from Linux running at
> > EL1 are trapped by Gunyah running @ EL2, which handles SHMbridge
> > creation for both metadata and remoteproc carveout memory before
> > invoking the calls to TZ.
> > 
> > On SoCs running with a non-Gunyah-based hypervisor, Linux must take
> > responsibility for creating the SHM bridge before invoking PAS SMC
> > calls. For the auth_and_reset() call, the remoteproc carveout memory
> > must first be registered with TZ via a SHMbridge SMC call and once
> > authentication and reset are complete, the SHMbridge memory can be
> > deregistered.
> > 
> > Introduce qcom_scm_pas_prepare_and_auth_reset(), which sets up the SHM
> > bridge over the remoteproc carveout memory when Linux operates at EL2.
> > This behavior is indicated by a new field added to the PAS context data
> > structure. The function then invokes the auth_and_reset SMC call.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c       | 48 ++++++++++++++++++++++++++++++++++
> >  include/linux/firmware/qcom/qcom_scm.h |  2 ++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 7b4ff3cb26ed..ab2543d44097 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -791,6 +791,54 @@ int qcom_scm_pas_auth_and_reset(u32 pas_id)
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
> >  
> > +/**
> > + * qcom_scm_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> > + *					   remote processor
> > + *
> > + * @ctx:	Context saved during call to qcom_scm_pas_context_init()
> > + *
> > + * This function performs the necessary steps to prepare a PAS subsystem,
> > + * authenticate it using the provided metadata, and initiate a reset sequence.
> > + *
> > + * It should be used when Linux is in control setting up the IOMMU hardware
> > + * for remote subsystem during secure firmware loading processes. The preparation
> > + * step sets up a shmbridge over the firmware memory before TrustZone accesses the
> > + * firmware memory region for authentication. The authentication step verifies
> > + * the integrity and authenticity of the firmware or configuration using secure
> > + * metadata. Finally, the reset step ensures the subsystem starts in a clean and
> > + * sane state.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int qcom_scm_pas_prepare_and_auth_reset(struct qcom_scm_pas_context *ctx)
> > +{
> > +	u64 handle;
> > +	int ret;
> > +
> > +	if (!ctx->has_iommu)
> > +		return qcom_scm_pas_auth_and_reset(ctx->pas_id);
> > +
> > +	/*
> > +	 * When Linux running @ EL1, Gunyah hypervisor running @ EL2 traps the
> > +	 * auth_and_reset call and create an shmbridge on the remote subsystem
> > +	 * memory region and then invokes a call to TrustZone to authenticate.
> > +	 * When Linux runs @ EL2 Linux must create the shmbridge itself and then
> > +	 * subsequently call TrustZone for authenticate and reset.
> > +	 */
> > +	ret = qcom_tzmem_shm_bridge_create(ctx->mem_phys, ctx->mem_size, &handle);
> > +	if (ret) {
> > +		dev_err(__scm->dev, "Failed to create shmbridge ret=%d %u\n",
> 
> 	"Failed to create shmbridge for PAS ID (%u): %d\n"

Will apply, Thanks.

> 
> > +			ret, ctx->pas_id);
> > +		return ret;
> > +	}
> > +
> > +	ret = qcom_scm_pas_auth_and_reset(ctx->pas_id);
> > +	qcom_tzmem_shm_bridge_delete(handle);
> > +
> > +	return ret;
> 
> 	return 0;
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
-Mukesh Ojha

