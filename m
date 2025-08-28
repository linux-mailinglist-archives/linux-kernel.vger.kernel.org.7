Return-Path: <linux-kernel+bounces-789987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF97B39DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A4982E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDD2E093F;
	Thu, 28 Aug 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLOYBOfx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B69260575
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385788; cv=none; b=XZk9sV0WbO1ut57OHZ/qf0mSnrn+WwEVT6WZXegX67lEthmKNvFhQoWsBT7sIOoVZHs4EmHxLfGIC5Q01Y3GqSeMn1zhVcuk4JXmpViljM0bt54uow8dH1gvMHqgO4xBvRbCknu1JZeMNUTglL4HYFkRN0cJKvj0N9GqSRQ2v2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385788; c=relaxed/simple;
	bh=MjXAYHORqLTV4UTX7O2Nfa7nXdwBrj10df/XFRj/0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhZ3bEzlzA6bMPkjqx4sGZvoordABMTLTNdJFs8Vo9VqTqqDQnMsw5ao8pzcyrmoUQulNSQtWGxDiVm2/D8xTCQU2wi867JJg6vAvKpQHCcfW8iYrstdUYF4CtohAsV79v9/eLNDhiuY2eIczjESJrhO0QHz10/CPKySkqWelkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MLOYBOfx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6EcnJ029271
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OdpmDsm62brobuQjUJYWRZMW
	8nEvkBWHHBR4Kl+p9ck=; b=MLOYBOfxkPhySalZJmsNJxpH0XwqD7DR0CWEmIoE
	JcPIo7+2i1H5T7AE7EZJvX2EoZ1HvOEe4bujMxMHnLO9cqpP/aZmCZHE/lpJ+Wad
	nMiRoSOAR26w87HyvVJfyK/ejhQvXNM0emS38P/Rf1sYjSeHE0YCCSpwHi9Lxcp4
	MkebjToxa5ES3MNmif0KwSWIsbMkp89IlMlhiIesEXfMn1PDKu1F7BkO/qZklzH2
	vV4iyTrApTG6NX7w2N+PJE3ecxd8zDeKaPqoFcgDle2jgmFUCBnTNDwYgZTLo9qj
	IaKTyP53y+09zoON9kvUXf311lp91+oLlw6RN1jywHAlUw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umgd9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:56:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de6f22487so19791726d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385785; x=1756990585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdpmDsm62brobuQjUJYWRZMW8nEvkBWHHBR4Kl+p9ck=;
        b=s5e2Zzojm99CabSzYwkjmStXlksbjb07uYq/Hysx4PgVpG0RML+0xUeB1GHTH9b1kI
         x/at2gId8navpNxfk7yDPRMOICUw8cLUxWGX0pA1LC2a0Pb48OUpwkts24Mya+w6t2K/
         kGX0gkSqpM3QCbLiz1Hjuge17wKRuELrCVmbfoE4n4+v/Xws2BfHVOT3sndusqWIs9QP
         P0AOtcW2FhNu7W06w6SuyBW68brNuG9oSR6kyn6I1n65Uw436IcdxtOCooKBEcZRLB7N
         ACbPncKRuW2Cpuju24HNiUxATVFmj39seYWDRdNAOmSklTHziuO/ITXQ0+eD344uZ1XP
         xWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUrOMYPTAzP4zl2foG0dpIs630nwyukrMIewpf6a2Vw2bqiXkJFdZlUKzC+U3YsF7Qvaskjnt5HUMvTQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywabkGbyz+vct+KW1mk7VxYU7D1WrK8zLMyB1VIUJjwjiTjdPW
	Aa25AtPWM6m38ISm6AeYjYSNw4MmzgRiwsaL6gXd051jRmVDPJlMZZ54QqncmoR8pGlsho8bzjN
	L1jJzyasyv2M8rWz78mwi0GI8h3H7+UfOxDpyI4Ck+m+BieaS5gOV7+iKs2vOU4jlqL8=
X-Gm-Gg: ASbGnctHkfo9KLStRU5JwOyGPinPDdh9Q324IlZv8puqpqUPmx03hVNJ2qTF3MitKIm
	hhxmdiOMIsvvRv/lvVd2ffzasBxVXQk/WbUEmgDSFpMx4oiqT+t9j4etnovDFCfEfzs7FTudnE/
	kUsh7SFa5iy8sOcVkiAS5lFnSntz5c/Qo+k+Z1g94o3d7UDlA0aSt2Q3RoEOeGaemBMHyLMVcZw
	01K0g6tTe8RYIKUd7JUQWHNEfzpBlIQkUUT5fhdSoeTkzGWIz6z4nVR/pU70WQec3JOdDUrx31e
	6dNmfa4ZMFIBcrFHJvlL4a6nYLeQUw9Lfuup5lSURIOe/l+J+Vi9SYIazhe2tbDMXbgWTR4Kbaa
	z6V7vDQ3F2dognr8r7JjSmKs4O4FBJ2ClgDoI8FSpTbhHdJ8j9dXV
X-Received: by 2002:a05:6214:27c2:b0:70d:843f:6b8c with SMTP id 6a1803df08f44-70d971e4c73mr254210426d6.37.1756385785174;
        Thu, 28 Aug 2025 05:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERQ3f0eiZP6GMEYC5Py0gqB9whnbXB6IFHUtmBsYwWEJ7LR2k+sbTMwXECFTAuvR2F5ILzjw==
X-Received: by 2002:a05:6214:27c2:b0:70d:843f:6b8c with SMTP id 6a1803df08f44-70d971e4c73mr254209926d6.37.1756385784519;
        Thu, 28 Aug 2025 05:56:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8bc94sm3337416e87.84.2025.08.28.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:56:23 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:56:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andy Yan <andyshrk@163.com>,
        heiko@sntech.de, hjc@rock-chips.com, naoki@radxa.com,
        stephen@radxa.com, cristian.ciocaltea@collabora.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh@kernel.org,
        sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Message-ID: <n3scvjsx2aec2ijnr5wwevkmhtegkts5nb43yti7dkjujqaezq@shbcy7ftibzo>
References: <20250822063959.692098-1-andyshrk@163.com>
 <bochli5u37mhc6eup7h2oz3yeignofbbj4k5nrvm2k7zf6f4ov@t2sje4gmveqa>
 <d040da3e-501f-45d8-bcbb-95fa77e94a59@suse.de>
 <20250828-tangible-wakeful-coati-ec27d1@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-tangible-wakeful-coati-ec27d1@houat>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68b051fa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=s8YR1HE3AAAA:8 a=tUpP_D99XMz3yPDlsHkA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX7ASdZ4PuSOc/
 l3YsL1rkliY9JhGhO3KqH83BgvOo7wT8X5Lse3W6FmXWkA7tmhStcpiHzpR/NBTUnx3nu3F65x6
 Izmzm4nhECG1HTKyS+Wkuh3Sjwajys0mud7PB4evhL1OQhGLiio7VBDstSfkMj3HmAgsaoJuxNR
 qiXfKU28xsSa4L9cCCibpHlA0zwni2EwLfVkuIAoP6++NXKiGzdq+puqa0Odvj4UfSXti9F+lXG
 VCnFAk91z8+QUFEuc3Vk9UCK3+oIZ+dqgWd+yxOhwHzQRuDZ3PfhqwazUGjGmc1CCsd6vDVRaJq
 SrSZOXkYGOhmzcOHvztVR09O8EnxhizM75LlueIoV8w4wBlj0GxesjvlkQS++wQZk+VjZRLdbDp
 YPc4EpFZ
X-Proofpoint-GUID: NdpNM614HvLBZph3945XEr2xLtuKedgc
X-Proofpoint-ORIG-GUID: NdpNM614HvLBZph3945XEr2xLtuKedgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Thu, Aug 28, 2025 at 10:05:28AM +0200, Maxime Ripard wrote:
> On Thu, Aug 28, 2025 at 09:50:34AM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 28.08.25 um 00:24 schrieb Dmitry Baryshkov:
> > > On Fri, Aug 22, 2025 at 02:39:44PM +0800, Andy Yan wrote:
> > > > From: Andy Yan <andy.yan@rock-chips.com>
> > > > 
> > > > 
> > > > There are two DW DPTX based DisplayPort Controller on rk3588 which
> > > > are compliant with the DisplayPort Specification Version 1.4 with
> > > > the following features:
> > > > 
> > > > * DisplayPort 1.4a
> > > > * Main Link: 1/2/4 lanes
> > > > * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> > > > * AUX channel 1Mbps
> > > > * Single Stream Transport(SST)
> > > > * Multistream Transport (MST)
> > > > * Type-C support (alternate mode)
> > > > * HDCP 2.2, HDCP 1.3
> > > > * Supports up to 8/10 bits per color component
> > > > * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> > > > * Pixel clock up to 594MHz
> > > > * I2S, SPDIF audio interface
> > > > 
> > > > The current version of this patch series only supports basic display outputs.
> > > > I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C
> > > > mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen and Piotr.
> > > > HDCP and audio features remain unimplemented.
> > > > For RK3588, it's only support SST, while in the upcoming RK3576, it can support
> > > > MST output.
> > > > 
> > > [skipped changelog]
> > > 
> > > > Andy Yan (10):
> > > >    dt-bindings: display: rockchip: Add schema for RK3588 DPTX Controller
> > > >    drm/bridge: synopsys: Add DW DPTX Controller support library
> > > >    drm/rockchip: Add RK3588 DPTX output support
> > > >    MAINTAINERS: Add entry for DW DPTX Controller bridge
> > > I tried pushing patches 1-4, but got the following error:
> > > 
> > > dim: ERROR: 5a68dcf5837a ("MAINTAINERS: Add entry for DW DPTX Controller bridge"): Mandatory Maintainer Acked-by missing., aborting
> > > 
> > > I'm not sure how to handle MAINTAINERS changes (or whether it's fine for
> > > me or not), so I will probably push patches 1-3 in a few days, if nobody
> > > beats me (or unless somebody points out a correct process for
> > > MAINTAINERS changes).
> > 
> > That warning has been added recently to make sure that patches do not get in
> > without sufficient review. It's overly pedantic, though.
> 
> It's not "overly pedantic", it follows the contribution rules. I'd argue
> that, if anything, we've been overly tolerant with that kind of
> practices.
> 
> We do have a bug with handling MAINTAINERS changes at the moment. But
> everything else shouldn't be ignored: either patch MAINTAINERS to
> reflect the actual contribution path, or get the maintainers Ack.

For me that points out that MAINTAINERS changes should be integrated
into the corresponding driver patch rather than being a separate patch.

> 
> > If you're confident that you have R-bs from enough relevant people,
> > push the patches with 'dim -f' to ignore the warning.
> 
> And let's not just advise that either.

-- 
With best wishes
Dmitry

