Return-Path: <linux-kernel+bounces-875010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A9C18000
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104485041B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FB2E5D32;
	Wed, 29 Oct 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gi7/LrHo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FXX6QzTN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69E2E6CD7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703530; cv=none; b=jlHt/zbN0XMWdRnTJ9h5hgk0EAkB1ZSdNojjJuWpG0TD7/pwIVnUtfDDZIOJ9EZEcmV9e30mDYidU/OTp/8Gsldb+U7dIH7zxC4NuQ0nCZAQ1ukq30hZD01QvyuXLsfA5GXbp7f0VEJU4gRO1CqAYixegLyswpAt6vPvwN6fdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703530; c=relaxed/simple;
	bh=6q2qqDVYKO5ZY58yg/N5whpHCFf46CzxMfbKry30Kag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEVnJLcRAuLmbjGyYfBo0Nb648e+0EEJ/snR+9HT9tMpnHUy+JoCfi8szVEx4C+MjGDQAO+7FHTk580GOyxnLNkFKpa78uBe63WUa288U6Iljz9D2V6HyTD4Em2ZhPxkt1TKZNcB4EYA99cxlB9CAHX/4zlT9ltWy7ARg3NZ6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gi7/LrHo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FXX6QzTN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJleuB2616644
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oNYnTyhROEtSOeCA2ONPfk1z
	k2xXS0IqmDQAJE9y2I8=; b=gi7/LrHoeAiQsPm9Ov/wB6nY1FRSi/Il3LJHMdth
	McGeaav8atOxCK0TyTyVlqp/9x4KwHim/nqRAZzRj1HEv+oT8OW5pmm+P+sVcwrI
	VCGnfCW3XhaE0kQalC6q/eVgw2Rq9oC33yL8pdwI+BHj0y4fGEmlqkaF5Pw2cOxF
	gA+IkmL4zajq/2HU+SutIuFDEey8MeUy623VCPLohF+0DvyvFYwQVdvC3XbuK1dY
	U56uLcoOqhNCAZQXB7G4q57Van1eWJxVmn84MX/3bkLtHhUjrI3skKJvSCe6GxJG
	J6QtRqyk2+zNKfiiFtbxde2/VogKVKxNl8uWJJq6fAPvEA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0gtn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:05:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-797ab35807eso228856726d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761703527; x=1762308327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNYnTyhROEtSOeCA2ONPfk1zk2xXS0IqmDQAJE9y2I8=;
        b=FXX6QzTNI+W2QdYCBNlgIDiIB5kGMdNq+gnxRRndjNqQ8LT8k9ZryefXkCLKsWTsjn
         9Krrz7oTLLPqtUqgIQWQDURRUPv/8/jCM1t6pwVgKlleGFD7pNlZ4Zg5NJmy0JgfUt7o
         dYwT45rNiW3auTRmqWg3pW7cGR1TUP/1ez1YdgvpopG722QAgVM+ofcsG4uXqB3aNGsr
         JSwVEvW0aVFJEJ/TPWe5odjAOMjGOEgml2yfP9BSQoB+dTaPE0DLfGEx2Ah1DVxDqvXN
         Ji7x+oU64vmMCrzTdQVNPDWtim0LeoYZ+TYpPSFIPsGvEyWMiWQ7EbKEzltoXS1zeamy
         xrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703527; x=1762308327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNYnTyhROEtSOeCA2ONPfk1zk2xXS0IqmDQAJE9y2I8=;
        b=ikeHXawRBev2d6GKMIaLNODNReM31/JFh1kDkSHCseuw0AiVHT5ZhaGa/3tIASl7YE
         wdbk//nFZfQH8IQg7F1xDohoJ4Ov88FakkfCCGWJRsXRlbJFvnza0TIvh07fU7aW/DGV
         mb0p0JEMv8rrCxpxCxht0RHBMHCYYOAIlGmpyTAsd58HWfkS+efvVUk+bNJSlznozBhP
         MJB5puzAtIBs7h4VmksttycuJEJtlBCJzk7yH/UOF5c6FRRjjZAEeghUsJdGxQm1VI98
         V0bXdrY0QSfZitxb9NQklw8RvbSemCHXh7TTL176NO0lyT+gzc8QU0QCTUX5puUp4oA3
         PG1w==
X-Forwarded-Encrypted: i=1; AJvYcCWtGVKKCilL7gob2yx8tXk9wLjXcMRlgH4cqg3GMgv2Pgr18jcN96qj8T17ahMM6nGQrquMPT9bTuVraU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtK3hB6teZFMUjp0f9pUdv7RH7ZmlDcxNfQ/uWfGMm4V20KtR
	Ij0HcK7Zq4FbadAXo2HrQ4p6Vn3coznN7DqLlRzj82r1gmP5Mmr4wzF9QnRfyV9m9lZdA+ERgMR
	2pCKBmQMck2v+Ktbl9dcoV1jQvWZGGUhWs5vK1Nq7AiiztGAcRqluEiwagVUf8YVfKjI=
X-Gm-Gg: ASbGncvjuwxzb40PTvqVzm1Ss2HX25UHKj2KkiHRUM5BR29Rxo1+z6K3xg1AXIuyEIq
	kEeAwaHwoEe4xkx7TWjTOeycEkb9x0J5jBM5QMksupve7LLypcPdNWFXovpZz/t1Q1seWeV6NJu
	nUR97w51Uo80s3n6de8czy8TGbRLCdOj+b5U8JcZw2xz9U8Y45g6QxSFF8/mMUDEBaUsVJvbLDz
	xNpjNxjymYXtmC1jgYXfgxLsUA6gV8x4rStw+v0UmyZ2LDJGqy+RycPxz4Z1aI3x0W4nNYCUeRv
	nO5lndYhJBDuU8ueCSisdT46G/7Xf8L+AfgAxTm0GYVppYkmZxAWS0DgMUO8+TCaYNPYWfMCvvB
	m0wA506wVZka5rhvKim3GTn+djV+HmFsNRh0LwljtoJqPN0Cfu6KIh43Tn+nZuVMn
X-Received: by 2002:a05:6214:1c47:b0:87d:c94a:17e1 with SMTP id 6a1803df08f44-88009c08041mr17921536d6.48.1761703527380;
        Tue, 28 Oct 2025 19:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGumAqyzy6p7G2g0/1nCG8Lfj49elpmE29lrS0JJixqIdFWH3Cdjr565IB/rUF7KuDDpYUNRA==
X-Received: by 2002:a05:6214:1c47:b0:87d:c94a:17e1 with SMTP id 6a1803df08f44-88009c08041mr17921186d6.48.1761703526864;
        Tue, 28 Oct 2025 19:05:26 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a7467sm88752116d6.5.2025.10.28.19.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:05:26 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:05:15 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Jessica Zhang <jesszhan0024@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <aQF2WwriXy2yFzkv@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <a4a7f1c9-1817-4092-9ab1-07209bb44125@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a7f1c9-1817-4092-9ab1-07209bb44125@gmail.com>
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=69017668 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wkyyw-Wu4EUB7OuTH_AA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: vNvrTYxApgvGKUIeHrqRJ3I916emASGX
X-Proofpoint-ORIG-GUID: vNvrTYxApgvGKUIeHrqRJ3I916emASGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAxNCBTYWx0ZWRfX5oJXtYDDSbP4
 OYWbW6XgLnnQGzBcGZSJj3he+Zr/jM+qpElpT6Mu/qWwoaM9d84XXS48uewGEr/N/v16h++E4m/
 fLN0/PNlSFoBvsjK112vGpjCN0BDqFRBFIAC+5z3rkPjrsI0VVogqyd75eTymRS3rEkiSU36ibJ
 y+/Lyww/tS29l4TUpcLo1SrEKlViSc2M4NikgHO+VLwkFofAhRG2uZvijnGiOP6kuOMTcVTQumz
 JATBZZus6VcRdgZ/NCtehbHZ8dZhrPWZ6Ef4xup+xlZKXf7wap15U3ZlJVQSQQEdiAJR0AKPRQT
 aB6NTJDSvAsrAeOCA+BTjg/U+TtMr8zN0nZ749tiCXM4iSm01zwOWoVXZA9JfYQ4j7MUrIt/t/Z
 T24rPcL2DkWmdGSbPEGcgA/tlrnbvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290014

On Mon, Oct 27, 2025 at 11:07:20PM -0700, Jessica Zhang wrote:
> On 10/23/2025 12:53 AM, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Hi Yuanjie,
> 
> Can you reword the commit message title to be more clear on what this patch
> *does*? "Compatible with Kaanapali interrupt register" is vague.
> 
> Something like "Add interrupt registers for DPU 13.x" is a complete sentence
> and makes it clear that you're adding interrupt registers.
>
Sure, will use "Add interrupt registers for DPU 13.x" for commit message.

Thanks,
Yuanjie
 
> Thanks,
> 
> Jessica Zhang
> 
> > 
> > DPU version 13 introduces changes to the interrupt register
> > layout. Update the driver to support these modifications for
> > proper interrupt handling.
> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >   .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 89 ++++++++++++++++++-
> >   1 file changed, 88 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > index 49bd77a755aa..8d265581f6ec 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > @@ -40,6 +40,15 @@
> >   #define MDP_INTF_REV_7xxx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x004)
> >   #define MDP_INTF_REV_7xxx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x008)
> > +#define MDP_INTF_REV_13xx_OFF(intf)			(0x18D000 + 0x1000 * (intf))
> > +#define MDP_INTF_REV_13xx_INTR_EN(intf)			(MDP_INTF_REV_13xx_OFF(intf) + 0x1c0)
> > +#define MDP_INTF_REV_13xx_INTR_STATUS(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c4)
> > +#define MDP_INTF_REV_13xx_INTR_CLEAR(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c8)
> > +#define MDP_INTF_REV_13xx_TEAR_OFF(intf)		(0x18D800 + 0x1000 * (intf))
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_EN(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x000)
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x004)
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x008)
> > +
> >   /**
> >    * struct dpu_intr_reg - array of DPU register sets
> >    * @clr_off:	offset to CLEAR reg
> > @@ -199,6 +208,82 @@ static const struct dpu_intr_reg dpu_intr_set_7xxx[] = {
> >   	},
> >   };
> > +/*
> > + * dpu_intr_set_13xx -  List of DPU interrupt registers for DPU >= 13.0
> > + */
> > +static const struct dpu_intr_reg dpu_intr_set_13xx[] = {
> > +	[MDP_SSPP_TOP0_INTR] = {
> > +		INTR_CLEAR,
> > +		INTR_EN,
> > +		INTR_STATUS
> > +	},
> > +	[MDP_SSPP_TOP0_INTR2] = {
> > +		INTR2_CLEAR,
> > +		INTR2_EN,
> > +		INTR2_STATUS
> > +	},
> > +	[MDP_SSPP_TOP0_HIST_INTR] = {
> > +		HIST_INTR_CLEAR,
> > +		HIST_INTR_EN,
> > +		HIST_INTR_STATUS
> > +	},
> > +	[MDP_INTF0_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(0),
> > +		MDP_INTF_REV_13xx_INTR_EN(0),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(0)
> > +	},
> > +	[MDP_INTF1_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(1),
> > +		MDP_INTF_REV_13xx_INTR_EN(1),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(1)
> > +	},
> > +	[MDP_INTF1_TEAR_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_TEAR_CLEAR(1),
> > +		MDP_INTF_REV_13xx_INTR_TEAR_EN(1),
> > +		MDP_INTF_REV_13xx_INTR_TEAR_STATUS(1)
> > +	},
> > +	[MDP_INTF2_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(2),
> > +		MDP_INTF_REV_13xx_INTR_EN(2),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(2)
> > +	},
> > +	[MDP_INTF2_TEAR_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_TEAR_CLEAR(2),
> > +		MDP_INTF_REV_13xx_INTR_TEAR_EN(2),
> > +		MDP_INTF_REV_13xx_INTR_TEAR_STATUS(2)
> > +	},
> > +	[MDP_INTF3_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(3),
> > +		MDP_INTF_REV_13xx_INTR_EN(3),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(3)
> > +	},
> > +	[MDP_INTF4_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(4),
> > +		MDP_INTF_REV_13xx_INTR_EN(4),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(4)
> > +	},
> > +	[MDP_INTF5_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(5),
> > +		MDP_INTF_REV_13xx_INTR_EN(5),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(5)
> > +	},
> > +	[MDP_INTF6_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(6),
> > +		MDP_INTF_REV_13xx_INTR_EN(6),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(6)
> > +	},
> > +	[MDP_INTF7_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(7),
> > +		MDP_INTF_REV_13xx_INTR_EN(7),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(7)
> > +	},
> > +	[MDP_INTF8_INTR] = {
> > +		MDP_INTF_REV_13xx_INTR_CLEAR(8),
> > +		MDP_INTF_REV_13xx_INTR_EN(8),
> > +		MDP_INTF_REV_13xx_INTR_STATUS(8)
> > +	},
> > +};
> > +
> >   #define DPU_IRQ_MASK(irq_idx)	(BIT(DPU_IRQ_BIT(irq_idx)))
> >   static inline bool dpu_core_irq_is_valid(unsigned int irq_idx)
> > @@ -507,7 +592,9 @@ struct dpu_hw_intr *dpu_hw_intr_init(struct drm_device *dev,
> >   	if (!intr)
> >   		return ERR_PTR(-ENOMEM);
> > -	if (m->mdss_ver->core_major_ver >= 7)
> > +	if (m->mdss_ver->core_major_ver >= 13)
> > +		intr->intr_set = dpu_intr_set_13xx;
> > +	else if (m->mdss_ver->core_major_ver >= 7)
> >   		intr->intr_set = dpu_intr_set_7xxx;
> >   	else
> >   		intr->intr_set = dpu_intr_set_legacy;

