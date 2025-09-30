Return-Path: <linux-kernel+bounces-837294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A2BABE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1316850E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72024168D;
	Tue, 30 Sep 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vw/XAKGE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B833F6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218366; cv=none; b=f+AVyzarrxQ/D0Fg1T9aSIXnoBRV/0yFY3Z/sjlEigZRNe+h7P6MdbjrjABPjxArwO/5S8h/mIihIkxasQV+9RuBApl/0DnrEHSUgMNnvKrVzCzDPXcKle6uYBJZk7J9lFWE/LdLeqjul8C0ZaiY517Xl/Ap3rr3FO4E6fiyXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218366; c=relaxed/simple;
	bh=BefZSX9fm1ONvnB9eur1YvCHDGRIRGcUqr+hf2kx83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnVly2vVn+rq5YYj5XFiPWxNhmZO069ywOLAbJ3voRRpDTL2eMYkM5Ne/gsbM1sJp2w3qufgc+6uYgQ+Oaj1MN+mi6V8VFffTc17szxLpVjEMBlzkLWfj/Dz334NqoD5J/hYEn7JhNeYSG6zD7yKbGxUtAsWuTGQg2e6hfmkw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vw/XAKGE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hax6017597
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Kji2nmZ2FEr3Raw9eE5h6cYw
	gKVR2CawlGpJNJ1zd3g=; b=Vw/XAKGE1YO/T9KY5F5Hr22nkn+F1e2vVFdW0Yk5
	HucrueTDHPW8bQKdDS7ZSJUH3pMjsUmxgjV5CwqWy22p0FkJGOSH8eDfhqa99wnu
	5vEcvfNhuri2ynbFqymBxNt7EZXstZtoGedJRH6A5Pyrm4eC0yqYDV27uLk/EqRt
	o/cXfEAV0/hfQyepZ4CuB64ceNJN5tA5Gx22Wf7at+joGv3XvywLEfUK/d6N5dI6
	tO/IDDnLwKdrQ6WtRWBlhPalt9dKwRC6wSlNQ5DSkDFSkfVTKugIaHAwexVG3Q4X
	HiJbykLLeuMB/0zcLomnZoSPDz6RSPpIlh7S9P4PFf8sqw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tr6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:45:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dd932741cfso102243931cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218359; x=1759823159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kji2nmZ2FEr3Raw9eE5h6cYwgKVR2CawlGpJNJ1zd3g=;
        b=VTVyiLARgjwZzl+Co9OdietKRGkH8vuPngaZH8AMqH7ktFmkjS28ZcPWzn34pP123y
         dzOJFFHGmz45SpicZP6eR0hdlD50cj78iFvKhZorv9Sjq2Gd+GLqoq/qS8s3Xuq7Q8KR
         z+g9ruSHdBcONmEfXvEid2oWJc92iHcPJIICJU2/GCGWrjcPDx4pFRk3Yr3SLo3JPtZC
         VwGknyKejHTwOxaUUQ7wTDFweXSg2S4tOlwD/37FTIhXFF7AjvZaAcb4kULqx6On/hh/
         jHb2CIQvaD9JEY/IEncby/ZKWU62YKB/mgHute0ok68cjlWKONZeODJh3bR393GVgI8A
         YSKw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJuyz5W/joUzLR2G4SbI1piVpvpT0H1zCoChuiLeZfbrQG6O7JT6zXntmQ/BT4mwpo6NAgGYCHqk8R0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJHAoXb93zTMx2L8hfqiVl7WS3Se4Fb1Z8kIAprss8rtFLc8o
	kQCxrEQnx4qh01eM2bO3nvdrYMtfFWMuMNtYuWZHxWgtcgYJ97lEG6OZm7UzTdFCVNQtzfzJAQ/
	EjJB1lUWsMvvqvJ+22HnucViNREEfwdoyXBgU6rD06BbujmY2ViD2gkegrYAFgnFjVHw=
X-Gm-Gg: ASbGncsQdBAWUvUzJpv0gghFyQn17/WUIUWCwwE3Leiomvw5YdiFqPpvBV4suih0JSm
	hk9pzgnzUvBDMqyalpnshNf2Rvi7I+dzBNQpZN5k0DY4AKYL95Es/2ss9jsVR0hk8pPtg6/ZFTE
	wUb5xRpGvcaJt3KIE84uYUftF+eLVWX1ZtZQzn094ImCzpkCir4IGASmR3hQFGFtsVYfLAW+r05
	WGdrj4TqarkPxpuGTwERIsBwx84LFGFFvlxT1pCC5G/H/kfkMfI/ykAN1AZfXGsjEcUJBfu888A
	HK4mt3vXCaPVvzr6u0ilTnBKg65CeVsT1/k68gp+m8z6S4TXiBcUjR7fzor2LIJVyEB+lDnptzl
	yvE4SyNHSZXj7Rg8fA+/5LTqcIGTawakem3rQF2WWXmOhR+fWHFwJxZVo7g==
X-Received: by 2002:a05:622a:408f:b0:4df:9e59:9d79 with SMTP id d75a77b69052e-4e2661da9f5mr51016131cf.35.1759218358972;
        Tue, 30 Sep 2025 00:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECErpsVHn/gl20DmHz+69GFvY5gifpdT4tSpKn1PuYqRHRES76ncOLU7Pd8idEKbvO7WTlFQ==
X-Received: by 2002:a05:622a:408f:b0:4df:9e59:9d79 with SMTP id d75a77b69052e-4e2661da9f5mr51015931cf.35.1759218358442;
        Tue, 30 Sep 2025 00:45:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37289559058sm17247361fa.2.2025.09.30.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:45:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:45:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/17] drm/msm/a8xx: Add support for Adreno 840 GPU
Message-ID: <r2spx7vu4sg4ydk2pvhe5gq6wxaiahmec3f5dpijvw5mseldmb@755zm7c2nv4z>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-14-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-14-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX5y4QIIuduPiu
 dclqM3bU/z7unmM0Om68QYCmqVbAEJ9rOcCvU4B/v/hP+EcCHL/TV7P2y/JTZMrt43LA/H57rMn
 JodV94oH2kc3FsRTxBE6kKVieU07akZiUiw1D9LFxaeepm50OfhkakB3BiU9zYmCBUagv9/XXkV
 Rf8r342wi6RQ2PkktkYELLJCHvfFbflGh/YdYLcbaFwGMGkxmJO5j2imAemaxUikkhk9NAfS9zO
 XATMWFWEZZjd5UJr+AGjHJACm23j0/Q2ot+pq1mD6UEc5pWFq6x6GN/9rQ8PIWNEC8P+ST2Ip1K
 bPgiAUVRCN79FdfxDiN+SZW4cHgJH25SyJbSQzQwNVTDpGDoWRBupbfnujcj1NnRnDhz9u/jpdP
 Pc32Aneof3I+0iYG29HWpXKJLMqCOw==
X-Proofpoint-GUID: IcCTTpUVvKJlivA6ASVgHyzWCn74z3Ex
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db8ab7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=90rIqVWp54D9reHQgRkA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: IcCTTpUVvKJlivA6ASVgHyzWCn74z3Ex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Tue, Sep 30, 2025 at 11:18:19AM +0530, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It comes in 2 variants with either 2 or 3 Slices. This is
> in addition to the SKUs supported based on the GPU FMAX.
> 
> Add the necessary register configurations to the catalog and enable
> support for it.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 211 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |   8 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   5 +
>  4 files changed, 225 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

