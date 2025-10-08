Return-Path: <linux-kernel+bounces-845147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28762BC3B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1A464F915D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CB2F39C9;
	Wed,  8 Oct 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M50ZSHpC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715321CC55
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908848; cv=none; b=GI0TA4M/pngp2LGC5fck5xNLjKDV9VuoUHdqTh6v7Peq/mcLYEx1xsC8Cptqxnh0HL5Vgi5FGfCJmKTm1GmJrfsv3fBqJKHtmYw1pZBA7JcxALCxSiG+j2mfaqHA1OxRmYqFNp1cuObPxVA1mCSu7t3uDfePvBvKTteHFHkYwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908848; c=relaxed/simple;
	bh=7bptb2G06hdAdq2PKR7nNXkha4mvqjQyF5eSFMelo0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/YH5gsZ1Yj+zkVQI47FqgSzvW0F2cMuJO/FG0xn5BrqkYsKbC2Ndb/FZmmuhsGMkMoLOFGzYQKAPjv2AvHZuqZrWkdIao37PeQOjg82hg82E5cffeUz8YoZqLFzYDILDtCrS+gWCpbLojYg5kmsEhRp0+flLz3cw96HA+tJU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M50ZSHpC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803jYj018027
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 07:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hlhli3jcVHPyvAqlPzswYc3dq0CKsbFj/LuCjRLAF2o=; b=M50ZSHpCm4W/U4ER
	Fx7ZUXvhLcdp5KzduxqkqZO6h6RTz15aoQ/f1S0+izqeR5bmNf9rfzhmAH6RskVw
	U0mIhgDrWPaDyzkmS3rlDcB3OFjQb4r6SNxwKyjG+asItsozpnyku8nlaD0caSAL
	1pfC1Ka3LPWuj9I4LkQgYJcZZSXQ3KwWQRAggrQUcTgjaXSLLA+Oz7/WCiyWUiF6
	1riERq/KpielhVlte0+/8h4dOZhMF0oPsZECT/4bjgkrrKKzeC49NfbNEpM9ZZdy
	tSQ6dItWxYUI1Sbzr4NunFfjZ/HoQzFbvEr+AtydOnEQhLRsw8NMjVHtnmc6mYNu
	F12Kiw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpvgtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:34:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28e538b5f23so79668945ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908845; x=1760513645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlhli3jcVHPyvAqlPzswYc3dq0CKsbFj/LuCjRLAF2o=;
        b=FLpFT1aEXQl7CQZ+gphSVk0VImae1EBQ0uknG/S9ArEtUTaHbEdeARh5qkdSo+3khv
         VILOWWjV7PduhJ2RFbAlOQW6SDRip8Uuxe5sGedS1oerYW0YL2V+WM2eFm7WuXvtD4cK
         8nAAPca7Q4F/HunCCQ+H3v8Q02zSzNMcub63wGsL/diOxFGkFEl+fgEntGhJWFEFNKhy
         99I1zkkIGHOXZzmU+H/yS7JbswkjGOOXDbMrOnJ8DGXSQ2urMsgk4Z1HF1giRDXlQXgT
         ubjOUaZoHkbhIlgcf8iQ1xLqhZGFfx9nx6jHCaEZZ+F1bjPC/4aypPtvd7mllIE7ujOH
         L3mA==
X-Forwarded-Encrypted: i=1; AJvYcCW9fbEQdFU1NHo++Wf3MswyUcU6yHW6d95gdo1sWMPSzWuLjTYjnuTlVWq8bKgcJH8ul8W0rxeXSPmT9vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+AEHUy/hrWfoJvkJnrTb7xFkM4qYtjbXHfxCS7ZG4ce/igOQ
	mEEP0n/7THxUzkZ9LT8f+kBLVPcnQgogUMW36tsSvHCmiEZTlfLpuZ9th2bBPc1JmDhXKa72IYi
	01auYY3QFCe8ud9MW0obxnTsX8EOj2ZJc+19Vcbsd9TALyTJ4d1oYTGeqZazbYWtHt/I=
X-Gm-Gg: ASbGncvbdPaRV3a9nAHRnikjpBl4VqqoFVvdC3ecEPE0Ff8wf6rEayOol1Dl8RuI7ap
	Upp6wtbM87Y0O1owj5aHPaVrcfWCBQuRJcf8HMb7dYfiBvWWPbfziQb4n9bdG+avocGWdvRbta6
	eAovMODocyKkhvL4jUG+mgGLl/yRs/4PDe4MHMkICDCUkTaDjhjMYFM53pN7FkXLRvxJRl+0wWh
	OXE/Lr+MDdUg7L3xCn9kTRmM+969IrkTH6q7MInynAPZcqhToFzfJEP6GWl0tRldt9etbse58xf
	FMo5tPkjPOy3yg4EQTV6lc1tofYOqZp2pCWZofxVuni7N/85drBGQZ5JsCNvLJBMalDxTl3I
X-Received: by 2002:a17:903:1b64:b0:240:9dd8:219b with SMTP id d9443c01a7336-290272e6eacmr33271225ad.49.1759908844510;
        Wed, 08 Oct 2025 00:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4+KlUdtRRvYkXMICVc9fL+WCUzUirgQjCnrKXBz5Lo7RGote9A2zVrM+JHyCOFQn/qLfxNg==
X-Received: by 2002:a17:903:1b64:b0:240:9dd8:219b with SMTP id d9443c01a7336-290272e6eacmr33270805ad.49.1759908843871;
        Wed, 08 Oct 2025 00:34:03 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d135d71sm189292385ad.58.2025.10.08.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:34:03 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:03:57 +0530
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
Subject: Re: [PATCH v4 10/12] remoteproc: pas: Extend parse_fw callback to
 fetch resources via SMC call
Message-ID: <20251008073357.vjvmeatrzrphewnn@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-10-de841623af3c@oss.qualcomm.com>
 <hwjfb7rudsdsxxoluxyu4n7wumzyyn73xnzi2ww4fkkfkpg3a3@esvajcrmhcus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hwjfb7rudsdsxxoluxyu4n7wumzyyn73xnzi2ww4fkkfkpg3a3@esvajcrmhcus>
X-Proofpoint-GUID: BM_CvhRJmDTfr6KWdE7Fglx1IiPD_Dxw
X-Proofpoint-ORIG-GUID: BM_CvhRJmDTfr6KWdE7Fglx1IiPD_Dxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX1shi6sItnhOi
 83NVWRbZ9tMxANoCsKrfJJuI5dLEiFn4kRAkWS5daHni0U6adrllvCCGJ+CJi+FHa/liwDhfUcU
 u0/Ypk9eDxfXVf7xnNC5Yn2CFRSsH05HWiXQngwhyMV9XKawcd3vA1ZMw6kBzrBZYQ644ZMZHrW
 MKdeT5TJb3wLi4jOMAau3m1nWqq0NQ8ESTQT8YVSscvOq08CI5GYQ/7kS9D22Rv9SbSv7ChGarj
 CmoVKjYGevZG1bxWQ1OVpJHw7K0pVEQIrOw+sGq/yiRZhFFHN2EaxOpcP0PP8O2MZPSKPtqHwix
 WebJRYsVLuNFIGYENL/TDquw7zBcJpAfiOr2Th12JiXu+h/SJKLMGcihz7gNINGBY9Kd2JFG731
 WV70D+HioqV161dC8fQ+01Q6CraGKQ==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e613ed cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=1wm0BNpoZKb8wzEvCIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On Tue, Oct 07, 2025 at 02:48:26PM -0700, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 10:18:55PM +0530, Mukesh Ojha wrote:
> > Qualcomm remote processor may rely on static and dynamic resources for
> > it to be functional. For most of the Qualcomm SoCs, when run with Gunyah
> > or older QHEE hypervisor, all the resources whether it is static or
> > dynamic, is managed by the hypervisor. Dynamic resources if it is
> > present for a remote processor will always be coming from secure world
> > via SMC call while static resources may be present in remote processor
> > firmware binary or it may be coming from SMC call along with dynamic
> > resources.
> > 
> > Remoteproc already has method like rproc_elf_load_rsc_table() to check
> > firmware binary has resources or not and if it is not having then we
> > pass NULL and zero as input resource table and its size argument
> > respectively to qcom_scm_pas_get_rsc_table() and while it has resource
> > present then it should pass the present resources to Trustzone(TZ) so that
> > it could authenticate the present resources and append dynamic resource
> > to return in output_rt argument along with authenticated resources.
> > 
> > Extend parse_fw callback to include SMC call to get resources from
> > Trustzone and to leverage resource table parsing and mapping and
> > unmapping code from the remoteproc framework.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 60 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index 46a23fdefd48..ed7bd931dfd5 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -34,6 +34,7 @@
> >  #define QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS	100
> >  
> >  #define MAX_ASSIGN_COUNT 3
> > +#define MAX_RSCTABLE_SIZE	SZ_16K
> >  
> >  struct qcom_pas_data {
> >  	int crash_reason_smem;
> > @@ -412,6 +413,61 @@ static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is
> >  	return pas->mem_region + offset;
> >  }
> >  
> > +static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *fw)
> > +{
> > +	size_t output_rt_size = MAX_RSCTABLE_SIZE;
> > +	struct qcom_pas *pas = rproc->priv;
> > +	struct resource_table *table = NULL;
> > +	void *output_rt;
> > +	size_t table_sz;
> > +	int ret;
> > +
> > +	ret = qcom_register_dump_segments(rproc, fw);
> > +	if (ret) {
> > +		dev_err(pas->dev, "Error in registering dump segments\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!rproc->has_iommu)
> > +		return ret;
> > +
> > +	ret = rproc_elf_load_rsc_table(rproc, fw);
> > +	if (ret)
> > +		dev_info(&rproc->dev, "Error in loading resource table from firmware\n");
> > +
> > +	table = rproc->table_ptr;
> > +	table_sz = rproc->table_sz;
> 
> Are 'rproc->table_ptr' and 'rproc->table_sz' guaranteed to be 0 in the case of
> above error?

As far as remote processor firmware does not have resource table, it
will be 0.

> 
> > +
> > +	/*
> > +	 * Qualcomm remote processor may rely on static and dynamic resources for
> > +	 * it to be functional. For most of the Qualcomm SoCs, when run with Gunyah
> > +	 * or older QHEE hypervisor, all the resources whether it is static or dynamic,
> > +	 * is managed by present hypervisor. Dynamic resources if it is present for
> > +	 * a remote processor will always be coming from secure world via SMC call
> > +	 * while static resources may be present in remote processor firmware binary
> > +	 * or it may be coming from SMC call along with dynamic resources.
> > +	 *
> > +	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
> > +	 * or not and if it is not having then we pass NULL and zero as input resource
> > +	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> > +	 * and this is even true for Qualcomm remote processor who does follow remoteproc
> > +	 * framework.
> > +	 */
> > +	ret = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt,
> > +					 &output_rt_size);
> > +	if (ret) {
> > +		dev_err(pas->dev, "error %d getting resource_table\n", ret);
> 
> 	"Error in getting resource table: %d\n"
> 
> > +		return ret;
> > +	}
> > +
> > +	kfree(rproc->cached_table);
> > +	rproc->cached_table = output_rt;
> > +	rproc->table_ptr = rproc->cached_table;
> > +	rproc->table_sz = output_rt_size;
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

