Return-Path: <linux-kernel+bounces-754551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F2AB196CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8761894E7E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B72046A9;
	Sun,  3 Aug 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OaRD/oh/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E791F4CAC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754261527; cv=none; b=Ut+0JXGG8srrs0WsmzqAXcqX+U399nMhvSW5UVr53rcYgkHg0q2j2OEpsc6qAw03I8GLpMBjewq0JQYbqQ11XskoBwfBqEYU3VE+VYmh+nBC0asz7rqm6GW5Sfs/6vT1adIBzpIj/eeW3JKWNjVu1kD8N61kfXa+OBGPHxQPLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754261527; c=relaxed/simple;
	bh=Pf/SzzgZyYr+FETReXK/PkNUpHPDJ7WnmAIh14cbOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrMIUWcsRPc41b4aEvQ5UauaTT6m2KxFxPu27oXEJBUDrcaBpGNZVyE92wMhwCdAdBUGAdG+tMKzPihjVq/n0gvnAfWDD5Dsrs4bnBlImRyY9JvCW8KbDOF7W+0oBTmAN1gEbTOk9b5+mvWkTxRAKeay74sLm+0GytfjCCuQm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OaRD/oh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573JrND6019944
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 22:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JD1bWaVWQaMuZIOSsbiapY7v
	x/fSAhiBJj0221w9hng=; b=OaRD/oh/HldFQT+r76ra5glaculHIRvoqG9PEr6+
	s4Fxh4DHfShNFZZ8biLt4GLnpcCp/rrJmWrDUSqKOdPUl7WnIVwOWWiMv/7UUDvF
	Az44Jar1g335SdvaMV9U4mmlwWT63Gtr35pTugXpE+k/hUcYqgltuzZe5LwG0XlN
	5O+C+vuP7QHDF2Nw9tXjXKBYw1niJr/DdKyCnp7y5uPMcPmkRgk9miIJw7X6LSLU
	17C21VshUDkrhQlgpTG1b+8pDf7DICT74JFD+ihleBHInUnKh355FWG6YwfKWfhG
	YKwhOYNwyuDvm+KNddxKjZWw2nHr08KxmM4VHL4VmEWqJA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqjtcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 22:52:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso102516631cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754261524; x=1754866324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD1bWaVWQaMuZIOSsbiapY7vx/fSAhiBJj0221w9hng=;
        b=wcS6d5cG9d1AcR9rKDMN44jEoauGHak3oRiB4c6+FaioIEuweWx7vEDbBabw1z1q6t
         S0+Cp3kOyDiDv3S/tFAHsekPDGmlbDENcQTdFEVPsXLzkfLT+KHwvF+4oq2ntGSuAiNb
         B2GBjHW+M4thXxd2Cu+RRYJoAjQ6KyNYWSySt61WJvr0/y0Fb9G1l3jmy8vPAZWRaDLO
         Sd10ZGkNoFIrmPsi4N8ImJGpYGFioTBcQ1ETBRHZumTTthsb+SlcFISQTYN6PCXw/5Se
         0pVyFGV2psZf766aEn6+iPkApXnH1Zq9oCuAWRkxAd2tY/nx8BQa42M1PlQwzz2Ifrgb
         zTCw==
X-Forwarded-Encrypted: i=1; AJvYcCVTUEpJ2rJHaV2lzG3Vl34bGQIehl/yU17DxPgDdYwUIXBFPyB3fMrj9IPlBk3e0gaxxZrfV0ea7UJeteg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnpKGXIwAMFfHBQEsEQ0oEe33AJvAiCTlZDjLw+Lk+MyS3Crn
	c25ks3CJ1I6883hSTZNhB7B7hCiuV3enqS35NbA5UDX5kxHvvObfkmyopqKuS5adINrT0WqzOvE
	gcHErr9iWaM0ufZ9xXXqnZP4cLc8UBgNTjhZ0N6QWlyWozazh5lPZQMWUQZQI6feNwWM=
X-Gm-Gg: ASbGncthDEOB6aSToB/ac1KTxOjOdpyNostfVdeMzACTU2AsxyTpp8CiXx/fdfI0Iu0
	fbhhg2exK2jGbkTvlT6YWtx86LYinDG1dbk7WxxxQ5oqWx2quuyoY14f5+XWuDqNFuoIm0q5Vgt
	MBAwMSNuZeY6CBBXrt9TQ6Fi9fMXE0KTRwn7JAFtsYWpwEx2M13hQGSttrf2tr+7KPJu4VI7edB
	GSqGR3cXrzMbU9tfM0iAMFvuiekM40S/DvzsHb0Os6xR5zBSFJuObBH/QF7e/8DP+56PEQcfYDt
	BPVxgvu75I5tZxtmIrL9x0G98Fk3lDrMdMUdeQKjPZjN2NFuqKJNduhzzOWMONmhzmNpwNLpw/x
	BKuuxRonlcRAMQ1i9vOV4y3PhDIRTMOhK6YOMLCef+RJ2vDtG2Mic
X-Received: by 2002:a05:622a:c9:b0:4ab:63b9:9bf4 with SMTP id d75a77b69052e-4af1097b2d6mr121492691cf.1.1754261523775;
        Sun, 03 Aug 2025 15:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvmz8aawgD/oGBs9k7aFMPr9BApt+fDHkdh79/grIR1SnsbvPVJ9lZL1LZ6ktrMtx82kna6Q==
X-Received: by 2002:a05:622a:c9:b0:4ab:63b9:9bf4 with SMTP id d75a77b69052e-4af1097b2d6mr121492451cf.1.1754261523353;
        Sun, 03 Aug 2025 15:52:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3fb1sm1420184e87.136.2025.08.03.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 15:52:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 01:51:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm: Fix potential null pointer dereference
 issues in drm_managed.c
Message-ID: <mw57szw4mnmpwxj55mvqu4pvjknuh2gmqfy6gko6wicsv2emah@4is7dv2bzx6p>
References: <20250703092819.2535786-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703092819.2535786-1-haoxiang_li2024@163.com>
X-Proofpoint-GUID: P0V351bEJRfS2XxL1pn8irZIF8aq8ZvW
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=688fe815 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=-n9UYpkImSeQm4xEVYIA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDE1NSBTYWx0ZWRfX/EIthiM0MbB2
 CXr5BY7HYUJNRGRMPA90CLQQ/jnTWZ7fqZhVXJe4MyrPwsl255aRtooVgt7+ntUHQau7ZLOsBiC
 q1+pc6p7IPNMrapmLaXFT4KczCa52DQOhlwS599F7kujmqdWkSmInDO0eUBVtHDCchgEucHilGu
 EVbRNj6KbFuuV9VlR+wrXdcAgqUO9eoHRTrS/bR0MWUAMRMIxz20kEqbW6pkTQaFj4G2gSR1AmM
 nYwjsIrdlGQ3fnjLkHz8jqyJv/QPREGvzEYm3JIhMTDPnSDYIU8iSSE8xjRDXutrK1SS5LvoGD3
 4Pdcbg6E/cEclmmXB9qvNN7S0LzalnE53rf55VGi0CUlzxfm3dmCTlZYCoMjbqHuBoUQVhZGEXp
 gspT5WGrKZMUJ2llv3b0ptYyA4b30GIpoUsQocrvgLOpnajX/syxmFCZnvzgZvgg1AULYT5t
X-Proofpoint-ORIG-GUID: P0V351bEJRfS2XxL1pn8irZIF8aq8ZvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=881 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508030155

On Thu, Jul 03, 2025 at 05:28:19PM +0800, Haoxiang Li wrote:
> Add check for the return value of kstrdup_const() in drm_managed.c
> to prevent potential null pointer dereference.
> 
> Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/drm_managed.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
> index cc4c463daae7..368763d4c24e 100644
> --- a/drivers/gpu/drm/drm_managed.c
> +++ b/drivers/gpu/drm/drm_managed.c
> @@ -151,6 +151,11 @@ int __drmm_add_action(struct drm_device *dev,
>  	}
>  
>  	dr->node.name = kstrdup_const(name, GFP_KERNEL);
> +	if (!dr->node.name) {
> +		kfree(dr);
> +		return -ENOMEM;
> +	}
> +
>  	if (data) {
>  		void_ptr = (void **)&dr->data;
>  		*void_ptr = data;
> @@ -236,6 +241,10 @@ void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp)
>  		return NULL;
>  	}
>  	dr->node.name = kstrdup_const("kmalloc", gfp);
> +	if (dr->node.name) {

This should be `if (!dr->node.name)`.
I think with this fixed the patch is legit and  should be picked up.

> +		kfree(dr);
> +		return NULL;
> +	}
>  
>  	add_dr(dev, dr);
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

