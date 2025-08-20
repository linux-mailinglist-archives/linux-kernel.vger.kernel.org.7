Return-Path: <linux-kernel+bounces-777541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224DB2DAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14F07A9B15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04832E3702;
	Wed, 20 Aug 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D77xryTK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D82E03FE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688499; cv=none; b=GT/7yoGsU6Bq7EQm8ADzH8UrMPEVnPQNMBjBNCrOwm5af5kURggLej5vC54iHdEogYj4cD3DsuBj5kYX/oeATKM+U7KB/6e3nlI/RLEkxSfD89y9RwKZYua92sTOwWWp2z7HbeTKAXtMAnCYKpSoPb7ow92f6DPoFvG1C2zP3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688499; c=relaxed/simple;
	bh=p8OghpNQhlTT+8A20KTVPN5jKRw3ph2Px/wtQTAAg6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJCueGRaxgGimkPMciemfYgS9OskfCvCXlYNTbRCzLY8LLrR97tHusX8i4l/tb3Eo92qxaQjdfFDQx4iG/doPB2yqev3WvJKLNKtMfqKixztFNrhyLNd98MO1+gU8GMFB3Uc2ZlOw4bhz6jaBkJPLJQH1vA3P84MbjiasqvojOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D77xryTK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA4iX9005901
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P/pf4Fr1yR1rp2biHIxblyq+
	CIVrL3OgqJfaB1OT7Yk=; b=D77xryTK2OeRsYB3BEvHxXIsq3fX4poR4fxGbPs8
	QrDT8uduZ0Sz7//nN0P2EceHhUtqKTgcK4s8t23QdxFofIA0s6bXWGxX2tlb9Du9
	GlZfQxPJGKzUV6BeExwL7p2b3C1U6XGVp507VhFyEU5hFB+6JEN+GZsbAdnLfzdL
	K222eHZklZcw3n9683SkZs6ElzBGXXqJguRmVGHG0v6++wkSHOQeeQ8w1jootORf
	nA242lAZxl/ELbsrQHPDQbdp60JIrAEO9fGcfe9n/Vpxd5sNVjEUmT2grp6wp6Pe
	Z/UmyjnU/Jv7f2jTT9KhNAuyFwUhN3OYZdk5VkWPFWVXcg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52chftn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:14:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458067fdeso79694215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688495; x=1756293295;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/pf4Fr1yR1rp2biHIxblyq+CIVrL3OgqJfaB1OT7Yk=;
        b=GRf/zbIMy6F3NOBECEb7KsEVZl8/mkVk75RWdYtuYNNBGDKG9eAEpiUFoQpdkAm4QK
         JGQFpsoJ8r2AAfBvfm6CAR0UkxZ7R45bigbmK1+iDlI5RIG2Wgf8KO/V6yPSbI7ZbGYu
         mrJJHik/irAOcubPQjqTls8ubDbkxyOFSPbJyd+L2ZMdeWiD3u1sPPiMrYvJ7AeW64ru
         PcCYrEyFLEdlq6Zz7RQwT65Vkas9w8cGZQKFA2QlZrk0rZxjFtjoAnqMwz4NG5Tg0tz0
         VdrfmDnGDrZ3mldB0LAHUIdNREW4tBVyON53uNNgcS9Ngn5CGk44AY2+JKnEYwDt7OT0
         eTdA==
X-Forwarded-Encrypted: i=1; AJvYcCWoD3VDBHSHD6x6CyGyW3qUnEZ3ctkdV26mUGJSuBuIhQyYYb/k4McMUg126EffO8Siik/dYCI6hYf7yb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyTyZHb9lQvJsCWcfLJ2kcJ3u0jpVjbluOiyzvm/+7S4Jde5C
	ZwRZ39Vp87lJI7YYAzH81xUym8fpngYJpVUm9qBjElqpr89u4mLNCoudAy42/670fR+85aDXNyf
	oS2n7kRBFOKoWhyAJo34cIEwrkwIGpL8rrqZgOLK6rCrx7hcg9bTOgpiUg9C1DSZFNO0=
X-Gm-Gg: ASbGncuM7ogGZ3V5qVHrDxjgYk4wVNxlgr9A/E1oGNLqyNkL/3T8Hto3fPfkHPmm66y
	7F3qvhYvy616UWWfuvkw1IdF4whuO5XH7TuzfXDhSp4+oYWo13dfJyUoW0EmCVbtL2SX0PTxOAL
	Z4SG142dq16o71lWorXwrQR2p28tSfq1TTwq2aEv8B9WIv8LbzSEb5Pr6uPDDMaNr8ttCRKTrKL
	2iU889KBWanR+4fVRg0NuBMNo1eyRpYWj3QLael0XuIIke/raiENMjh94bPSZh+vIwPMEkHJY3g
	IQhEg5+SlpE1bJvy529lfig15KhkzZjJjU/1KnE+muV0qYqBqpQSzzaIC/lInezI+8o=
X-Received: by 2002:a17:902:c405:b0:240:3915:99ba with SMTP id d9443c01a7336-245ef114adfmr32310125ad.5.1755688495497;
        Wed, 20 Aug 2025 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG6sR6+yRUv5dBYcA8W3SZstv8MECG4PDOw4JU6Rl2vlK/yFBFfFaba2q7jG3Vo9K3v9JkOw==
X-Received: by 2002:a17:902:c405:b0:240:3915:99ba with SMTP id d9443c01a7336-245ef114adfmr32309875ad.5.1755688494992;
        Wed, 20 Aug 2025 04:14:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73d1sm23632095ad.88.2025.08.20.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:14:54 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:44:48 +0530
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
Subject: Re: [PATCH v2 09/11] remoteproc: pas: Extend parse_fw callback to
 parse resource table
Message-ID: <20250820111448.tjaz2wld2nxg52aq@hu-mojha-hyd.qualcomm.com>
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
 <20250819165447.4149674-10-mukesh.ojha@oss.qualcomm.com>
 <aKWI-izL5BooL61p@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKWI-izL5BooL61p@linaro.org>
X-Proofpoint-GUID: oquzf9iygm4X6K9odUTUnD1FqmS8yax6
X-Proofpoint-ORIG-GUID: oquzf9iygm4X6K9odUTUnD1FqmS8yax6
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a5ae30 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ZUaeDnWVgNR0Owz7DOoA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX36fsb2/BdR2Y
 L/llOvrzYst2mAFXvwVgCIwjR4oAU6hLuEeH7KX90hFtXawyP9m4AEIP8rZ75HuHr7piAjqWrGH
 TcFLFp0Ol5B5EuIRfZfWWMW/sRve++YsyYZIf6zwyZFCKItwzEWNuOnRlFNSb4FbGTLFNG+3Dwx
 SCa3wYq70yWPLGzQoXyZqev3D5Ih7Jwx7QSzI2Cz/4u0mk0aEUSx5+z0nVFgxTGHs4UfWumSu34
 6fJQr7oaxgZOVZTdslpRIa91Mdp1Dp6UBof1bm0+SxACQVrxP1VXekGJC8lh+ce3ivSdyGFTv0k
 cnGuLy80Uzj1JUFnSH6Vjw00cwuVJqAofItAep5L91xvwJML0JkHLquw/LWA4Pi/JpYtVyUNoHB
 7mO4+gMp6Bf1twT+rMkAPOaf/yuxaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 10:36:10AM +0200, Stephan Gerhold wrote:
> On Tue, Aug 19, 2025 at 10:24:44PM +0530, Mukesh Ojha wrote:
> > Extend parse_fw callback to include SMC call to get resource
> > table from TrustZone to leverage resource table parse and
> > mapping and unmapping code reuse from the framework.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c  | 33 +++++++++++++++++++++++++++--
> >  drivers/soc/qcom/mdt_loader.c       |  1 -
> >  include/linux/soc/qcom/mdt_loader.h |  2 ++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index 09cada92dfd5..1e0f09bf1ef2 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -408,6 +408,35 @@ static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is
> >  	return pas->mem_region + offset;
> >  }
> >  
> > +static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *fw)
> > +{
> > +	struct qcom_pas *pas = rproc->priv;
> > +	size_t output_rt_size = MAX_RSCTABLE_SIZE;
> > +	void *output_rt;
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
> > +	ret = qcom_scm_pas_get_rsc_table(pas->pas_id, NULL, 0, &output_rt, &output_rt_size);
> 
> In PATCH 07/11 you have support for "static" resources that can be part
> of the firmware binary, but then you never make use of it. Like in the
> iris patch you just give in NULL, 0 for input_rt, even though,
> (presumably?) the remoteproc framework has support for parsing the
> resource table from the ELF firmware image.

Should have added a check here


ret = rproc_elf_load_rsc_table(rproc, fw);
if (ret)
	dev_info(&rproc->dev, "Error in loading resource table in firmware\n");

ret = qcom_scm_pas_get_rsc_table(pas->pas_id, rproc->table_ptr, rproc->table_sz, &output_rt, &output_rt_size);
...
..
	return ret;

	..

}



> I would suggest adding a comment here justifying this and perhaps
> something to the commit message. I do see value in having the
> qcom_scm_pas_get_rsc_table() properly defined with input RT support, but
> it's not obvious from the description of your patches that this is
> effectively dead code right now(?).

Sure, will add the comment where ever, I am going to pass NULL, 0, which
is for like IRIS. You rightly said, remoteproc can have its input_rt
by checking it in firmware binary have resource table while for others like
iris/venus etc. support is not there now but can be added in future. 

-Mukesh
> 
> > +	if (ret) {
> > +		dev_err(pas->dev, "error %d getting resource_table\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	rproc->cached_table = output_rt;
> > +	rproc->table_ptr = rproc->cached_table;
> > +	rproc->table_sz = output_rt_size;
> > +
> > +	return ret;
> > +}
> > +
> >  static unsigned long qcom_pas_panic(struct rproc *rproc)
> >  {
> >  	struct qcom_pas *pas = rproc->priv;
> > @@ -420,7 +449,7 @@ static const struct rproc_ops qcom_pas_ops = {
> >  	.start = qcom_pas_start,
> >  	.stop = qcom_pas_stop,
> >  	.da_to_va = qcom_pas_da_to_va,
> > -	.parse_fw = qcom_register_dump_segments,
> > +	.parse_fw = qcom_pas_parse_firmware,
> >  	.load = qcom_pas_load,
> >  	.panic = qcom_pas_panic,
> >  };
> > @@ -430,7 +459,7 @@ static const struct rproc_ops qcom_pas_minidump_ops = {
> >  	.start = qcom_pas_start,
> >  	.stop = qcom_pas_stop,
> >  	.da_to_va = qcom_pas_da_to_va,
> > -	.parse_fw = qcom_register_dump_segments,
> > +	.parse_fw = qcom_pas_parse_firmware,
> >  	.load = qcom_pas_load,
> >  	.panic = qcom_pas_panic,
> >  	.coredump = qcom_pas_minidump,
> > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > index ea7034c4b996..8456cca3f3e0 100644
> > --- a/drivers/soc/qcom/mdt_loader.c
> > +++ b/drivers/soc/qcom/mdt_loader.c
> > @@ -22,7 +22,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/soc/qcom/mdt_loader.h>
> >  
> > -#define MAX_RSCTABLE_SIZE	SZ_16K;
> 
> I'm confused why there is a semicolon here suddenly. Did you edit this
> patch by hand?
> 
> Applying: remoteproc: pas: Extend parse_fw callback to parse resource table
> Patch failed at 0009 remoteproc: pas: Extend parse_fw callback to parse resource table
> error: patch failed: drivers/soc/qcom/mdt_loader.c:22
> error: drivers/soc/qcom/mdt_loader.c: patch does not apply

Yes, I did this edit just before sending when checkpatch caught this.
Will avoid this in future.

> 
> >  #define RSC_TABLE_HASH_BITS	     5  // 32 buckets
> >  
> >  DEFINE_HASHTABLE(qcom_pas_rsc_table_map, RSC_TABLE_HASH_BITS);
> > diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> > index 62f239f64dfb..92ad862e733e 100644
> > --- a/include/linux/soc/qcom/mdt_loader.h
> > +++ b/include/linux/soc/qcom/mdt_loader.h
> > @@ -8,6 +8,8 @@
> >  #define QCOM_MDT_TYPE_HASH	(2 << 24)
> >  #define QCOM_MDT_RELOCATABLE	BIT(27)
> >  
> > +#define MAX_RSCTABLE_SIZE	SZ_16K
> > +
> >  struct device;
> >  struct firmware;
> >  struct qcom_scm_pas_ctx;
> 
> You added this define yourself in PATCH 08/11, so just add it in the
> right place directly. Make sure you scroll through your patch set before
> sending to make sure all changes are in the right commit. :-)

I did this intentionally, because there is outside user of this macro 
with this patch.

> 
> Thanks,
> Stephan

-- 
-Mukesh Ojha

