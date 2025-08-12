Return-Path: <linux-kernel+bounces-764519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5244B2240C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6862A3BE472
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E52EA49D;
	Tue, 12 Aug 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICbAEpAu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AB2EAB6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993211; cv=none; b=qwQvllC3/bk8hCYvy02UXw9Rf9/KjrS5fk0hMTA/NVrAr+w4UrvsDHFfgK8Mlog+8Pmjn07tLemfIRbIfieaMJZPljpr7CA8vNqyVqwUrGT79ISCpiaVILclSWdOlW95IxdSWOEqfvGMwnfvMkTSf8j0mTTRcfKgLctnW1yZfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993211; c=relaxed/simple;
	bh=p86wGcuXouV66IvwXNLN1S5SQ13PEZX8gi4dx6Jnpzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge8EhzQUoCUdE0kBGy+6DAgXEuHYeIaGUBe0/nu2UNHpkerEBAgzHIEIZWVmPY7SCRbY33L1lTNqWjLXU2NnuZAxVBGFqSEyY83svKz59KgI20se1gzGAsYcYyyLdRUnnbzqsOk5riFjA8NjL67a/rH/wLN4Q+v8cEX/y4NgCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICbAEpAu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7VjQr007595
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A8T8ZatYaGf8wMEcyEX+SVkI
	kdVBoSOYx1hxOAACmEE=; b=ICbAEpAuy0MSvABsrlO/4K/W8IleGPdGZWCoTe7x
	AYKCE2rZpFDnGwb7w7DsRmJuF59YhjkCtvT8AeGwhD2EZJiHUCOpCSvQ1NFTeY97
	NWX4MCIMsSx4uaGbnFSP8PCGVHNSN1kghrClnjR0NwxYRfaLBXDU23/edu3anooI
	dNCHDQLQmO2iOWlQdQO+gvcQWMwURez70bn2FuDqnZJxk9WldZj/jLLAh99bletX
	h+q3vXQ2fgJ59T5QQmfP7tBVqcCDvdh6FQ+rFwWqq09cveP2Xgl8r+SNyrBvdDdu
	f4xA0WEa68Hv0Wp+YDgmp4wP8J/Yp/qHD8tOL/QpKrI0yg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6khgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:06:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-478f78ff9beso192425001cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993203; x=1755598003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8T8ZatYaGf8wMEcyEX+SVkIkdVBoSOYx1hxOAACmEE=;
        b=w7TS9abH2/frIOxyMEojojfZ5bz3wVqvqCUWbJo6qr+BlTmO2Bh0JDmzGDt/F6j1b8
         OXvMyCNJeM4Z2Zm/TbLqTAA+OB+ACgrd1nXlBfyYoaTCD45GTvSqLZHTEMAR4DntHD+c
         6UISI1jU3sIbHrswHPOasKpq2+yvhpbqaq0dktRoLvMG2Moq74vAxVwj6VunTVl+RvOU
         rjxMQcFGIInmxaNEUklVhWA2IWVomD2M2/XgD7kVQEsgCj5wrSJpMRZ9/s/tSBYDSUfT
         PlsUv+8mV4/BkdhpbybrjEtstSxliv3sZIbZ+GcMTRmEtmSqahDnUw5SVMPklHWQWtHL
         4yBA==
X-Forwarded-Encrypted: i=1; AJvYcCXhgTKzLs4e5YUfF4sQynodqwLAsRnSJY0kGfYTJnHv/9a1UKCLz2dor1OWQ+LqWVoIfcNBZDIiHMOLr+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwGMs0SqHS9Sp7Dw0bOCw44tBSEmsfE1WFGSZMtDU0GDgiSew
	1tczeTe1H1r1iWhrY9Qfs/zXa8pwBcQXYO0vT1KhktkEK7jWtQgp703lAbPkZouBbElCYNM4FI9
	NsdhLt2Poh0FJ44uSeiQbJlPZrIyHIsGFO7IYVkZMHE2DEErWiMesNRoRYBaFOoDbOfEheviIPP
	Q=
X-Gm-Gg: ASbGnctpzv4rPqIHKIMeet2MUqurz01kGApJe1dbDhzrfIC4O1k+zkAokOiYjK8cPKs
	4mR5CbKzThNA6DXQ97bHiR9wnhDq/4Y+FwFxHrFzJTS0XRKxpLFXb1czcwbG7YcuAOAC8O4bqhC
	Nre5SQFLLfw0OlaJd0ZGMvdS/M2dUcka9KhXstJ3fKayzb5kvjQAO5MFzXOFuzH4fnyO5gI4ap6
	5yLeo1/2Fk8KRBLcm2L75N3TIzCsi3grITJPtlzAfM9go7//crafaHhlrPv0OOrggszION47snd
	62rioE1NFiBUcGBJoLkTpDckEOWWEmaDrvYYXeR6m+Vcsvfr9xSLgBIx8koesOPWrd4SL67Hvt4
	d2urJ91WM/csa7UOYGN/es+0B781/RNwZRT1ybOwzf16n6o+tb64O
X-Received: by 2002:a05:622a:993:b0:4b0:7b80:4759 with SMTP id d75a77b69052e-4b0ecbdfb41mr34852011cf.20.1754993202575;
        Tue, 12 Aug 2025 03:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlxzUMM54lZpUCjMGfkRuTDxqeDDulNqKujbwTvnh1hN5pHNNiRG8zIikUZyWOyfTNB5HMQ==
X-Received: by 2002:a05:622a:993:b0:4b0:7b80:4759 with SMTP id d75a77b69052e-4b0ecbdfb41mr34851841cf.20.1754993202166;
        Tue, 12 Aug 2025 03:06:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bb4asm4657815e87.16.2025.08.12.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:06:41 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:06:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenmeng Liu <quic_wenmliu@quicinc.com>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: qcom: camss: Add support for regulator
 init_load_uA in CSIPHY
Message-ID: <hosfuvk34iolc4ylzqu2pyoozomw4nzirlfdj54x3777eyuok6@renjfbqznl4r>
References: <20250729-camss_csiphy_current-v2-1-da3c72a2055c@quicinc.com>
 <d32cbtfzhwpzsvxpb7esvndpqxooergkzhlx2jp4ikuc3bsaop@gyxnlusuptg3>
 <e08cb2a3-e96b-4b06-b56e-0b630cff38fa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08cb2a3-e96b-4b06-b56e-0b630cff38fa@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXyWIOOHAobn3Y
 WwieoFx7BSY3KWpU/WrGc9HnN81Nb+Iu+y3rHdGYJjwr5VPPt55PmbyTYvQmfVxZo1FYCtteASB
 /ha0YmU8DUX3S4HfBykN+KWXLc2XU3wZ3ykFYmLgXndjK6XeKIdOroi0w9PDnFUyYv29bUp8kFk
 Z1mCfF04KB7Ipaquzhw8ai+TYbHLNpqXt0xupNZe08xxz5/AFSYpqAPENFPLyZi5c+f51N3pvln
 z3uhodh5rUjQt6TJHtcoHvpWD3I0qjBQ06BXFay9h5XN9gbdY0flG8GY0qvALecGu73OeAY/10I
 u0TSTbPMo718yonD0GAcMCIRw5CKyV2JIiINO1FF+6jORDNUJkFTURsj/5hIURA5Rsod3DnayeN
 Cdi5iOI7
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b1234 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=SCioppmI-r5X7Irv_ikA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: s3W9uX70KIkQ9Xnz9116kWHmNFdH72AG
X-Proofpoint-ORIG-GUID: s3W9uX70KIkQ9Xnz9116kWHmNFdH72AG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On Tue, Aug 12, 2025 at 02:05:55PM +0800, Wenmeng Liu wrote:
> 
> 
> On 2025/8/11 18:39, Dmitry Baryshkov wrote:
> > On Tue, Jul 29, 2025 at 03:24:55PM +0800, Wenmeng Liu wrote:
> > > Some Qualcomm regulators are configured with initial mode as
> > > HPM (High Power Mode), which may lead to higher power consumption.
> > > To reduce power usage, it's preferable to set the initial mode
> > > to LPM (Low Power Mode).
> > > 
> > > To ensure the regulator can switch from LPM to HPM when needed,
> > > this patch adds current load configuration for CAMSS CSIPHY.
> > > This allows the regulator framework to scale the mode dynamically
> > > based on the load requirement.
> > > 
> > > The current default value for current is uninitialized or random.
> > > To address this, initial current values are added for the
> > > following platforms:
> > > SDM670, SM8250, SC7280, SM8550, and X1E80100.
> > > 
> > > For SDM670, the value is set to -1, indicating that no default
> > > current value is configured, the other values are derived
> > > from the power grid.
> > > 
> > > ---
> > > Changes in v2:
> > > - Change the source of the current value from DTS to CAMSS resource
> > > - Link to v1: https://lore.kernel.org/all/20250620040736.3032667-1-quic_wenmliu@quicinc.com/
> > > ---
> > > 
> > > Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> > > ---
> > >   drivers/media/platform/qcom/camss/camss-csiphy.c |  4 +++-
> > >   drivers/media/platform/qcom/camss/camss.c        | 26 ++++++++++++++++++++++++
> > >   drivers/media/platform/qcom/camss/camss.h        |  1 +
> > >   3 files changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> > > index 2de97f58f9ae4f91e8bba39dcadf92bea8cf6f73..7a2d80a03dbd0884b614451b55cd27dce94af637 100644
> > > --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> > > +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> > > @@ -707,8 +707,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
> > >   			return -ENOMEM;
> > >   	}
> > > -	for (i = 0; i < csiphy->num_supplies; i++)
> > > +	for (i = 0; i < csiphy->num_supplies; i++) {
> > >   		csiphy->supplies[i].supply = res->regulators[i];
> > > +		csiphy->supplies[i].init_load_uA = res->regulators_current[i];
> > 
> > Could you possibly refactor to use devm_regulator_bulk_get_const()? It
> > would save you from this data moving.
> Initially, we were aiming for a minimal-change implementation.
> Consider refactor for save data moving, will be refactored in the next
> version.
> > 
> > > +	}
> > >   	ret = devm_regulator_bulk_get(camss->dev, csiphy->num_supplies,
> > >   				      csiphy->supplies);
> > > diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> > > index e08e70b93824baa5714b3a736bc1d05405253aaa..daf21c944c2b4818b1656efc255e817551788658 100644
> > > --- a/drivers/media/platform/qcom/camss/camss.c
> > > +++ b/drivers/media/platform/qcom/camss/camss.c
> > > @@ -750,6 +750,7 @@ static const struct camss_subdev_resources csiphy_res_670[] = {
> > >   	/* CSIPHY0 */
> > >   	{
> > >   		.regulators = { "vdda-phy", "vdda-pll" },
> > > +		.regulators_current = { -1, -1 },
> > 
> > If it's unset, it should be 0, not -1.
> I considered existing implementations as a reference:
> https://lore.kernel.org/all/20220804073608.v4.5.I55a9e65cb1c22221316629e98768ff473f47a067@changeid
> 
> but based on the implementation of regulator_bulk_get, setting it to 0 seems
> to be a better approach:

Ack. Also please try to provide a sensible value for all platforms, not
just the most recent ones.

> 
> drivers/regulator/core.c
> consumers[i].init_load_uA > 0
> 
> Thanks,
> Wenmeng
> 

-- 
With best wishes
Dmitry

