Return-Path: <linux-kernel+bounces-868033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80CC0432B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAB03B1A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBD72639;
	Fri, 24 Oct 2025 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUrSOHyj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF92E63C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274764; cv=none; b=J47maV8U/vgZs5hijgLsqDvo0oelYf47yCJYwuDda/rUPnLySeinfNb545NEo/McJGpkPZtptKgFZYnKdI70sqgxKRJrIyJ+ya5ab0Pgan593PCeLBEkz8eAng82uGTd0hj0stpErKyQwPItZk7jz+Y78K8dd4xfLVcgxDaCQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274764; c=relaxed/simple;
	bh=s/bxgWQ2osWXjwr2KotWn8dyknnYa2vRT9k+3Hb3BdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZSKvw34D4wN82ThMFqZG35k8OO0cioTlrLkkIHsFdWE4KarJLU5DvVXA38zVZ+iaQLWC2jYrsPGF72yjZ0ZsHhfJDfCA7nGPmwvzXFAYZFUHAC5PcR7SDfOaCHAgil3tZsbBkAT5WPWCiIcIt6/ptlIwlAAkGhGfenjLzrwP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUrSOHyj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O1q7uw016466
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=alHbWdl9Rj2RBorWf/yZSPFW
	VTNaKm9v1UuWbZYPNvQ=; b=eUrSOHyj7vWrS2OW5rC4UsVIJg5sxsso6QnHTwpF
	wsk6WgAezBockomuEiWMVZJ/Ihf9AqYUyJaiY1UUFMfD9BdifmOZySj2dh+//afH
	gl5O2dqNb5SskkfICscvFv8ZJ4PlEnmOe5U2oKoSoWO6h7lfNS2M/6gZ47aTpzHg
	ZcGUILrnS+M+WQNCkJVtrXNS/kcmeX3Hlj3dSpJgkxZUsu2V/QcgqeUNOT/EN4G3
	ViG3Lek8j9TvmY1EV8rgEtcwX2PwezOLkw373YD8UVQq1a6m1LwKGCz5FvbcQnTN
	LI/AVcYq93xWoPiwbNorIadVkXLW6L6/tfiXFh9Y/B9Prg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsg6hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:59:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87df30d45ecso44122556d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761274760; x=1761879560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alHbWdl9Rj2RBorWf/yZSPFWVTNaKm9v1UuWbZYPNvQ=;
        b=qkqA3dSFJtIVi8b0aLkMfZ3CM6dCMNqD4kSiNRsPy5PjMsZxgiUxvN/EYxRZvd/iwL
         krN8eweduRZOzOqHWnXOq7+oiVXD7OalFryC32uvijjOisujArRnh/NUDMSr6s6eQJaV
         3F80fRRoAW3r1afyL+BDSgZLo+nPW6Ul5NxGsFXMiLsK+zuesBH8zSkMrmYSfKWiOnBb
         pJfiGSM9NhukSk2kZOMJOQFd9g6cqvFaN8o/QlyXJKbZpV2Fb8gBC3c+W5ls7J6XGySx
         +52rVdqqtK8KQQy/j8JhJ2LHKmKm9N3cACv2bDkVFlo39zMgrwsyCmaCyAfsJaIjhn1h
         FDLA==
X-Forwarded-Encrypted: i=1; AJvYcCWI36DaMtP+PeQnoYa0GkuNCkusSsf6ZOWSU55ayWhbdlg0FU2lnUHpq5Q/Gr1Cld7fK+tt/vVf8gAf9Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNhpy+9KGkUJsbpz6u4qeO6Bd3j7OxHTPo1tUAtxmJwJsreOs
	NcosOZd0VzVdL9t2XalazaiK0TgF0kGy38rhFEGRenEe1xGtQjVyFLk4o1kJTHEA3RIxz6obmjg
	bA5+9+tQk0G3QV7A+SfJCbIC5d+uHSAF3P4BabcnNI0amrXgP+wpGWkAVqW2Eso5QmOc=
X-Gm-Gg: ASbGncvacFlhtH6v+XZto2pc8t06Se1EfwCstb/Cbz429yY+4Qj9yukhO/zSOBw7MH9
	FSoV13BrHswcKnRTDr2/SK7HiO4l+/NNvjQcet1u1SyWWbUMUiEtAY/rwJABV/DYeVj/r8WF+mK
	5WWJp20cZcn2vhDH5YB2yixi2+Tkv1twuYR4gUgMVZUnPfR62k022oXOQal/IEuYhMPAB23de+j
	ExscHjtU4akJIC5gmFyk6ouxb/k8gaZLBY67EqF5QiNV0rr8gFjckF3dt46MwRllr4bfvTLpLzc
	LCcDTFi/D3EC5fSJXUABIWkT0TVAp9aQS77pjGpKW25Of6NWLjU+50TzgbH3niacEvpbdLnC11U
	GNl8mz1dIWnK2rJbTbgOX86/Vacs74K5mZTgjCZfb+3BVTr7d+xa5vH9kNJRB
X-Received: by 2002:a05:620a:44d1:b0:89a:ad1c:5135 with SMTP id af79cd13be357-89aad1c5576mr1081386885a.0.1761274759957;
        Thu, 23 Oct 2025 19:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu/QPO9m9brJvJf/IlDol46ZUfnhMKMfRAWUSM0GHftzDhJSrp/isYST7dyuvvS0TjSLd0GA==
X-Received: by 2002:a05:620a:44d1:b0:89a:ad1c:5135 with SMTP id af79cd13be357-89aad1c5576mr1081384785a.0.1761274759524;
        Thu, 23 Oct 2025 19:59:19 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c1264383bsm291555585a.59.2025.10.23.19.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:59:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:59:07 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfXyQzmNZyCkLA1
 E0BrO5mRsasXR23uNJOd5+/3eCdFunIfndE9F+yI1N8NkuSB120xSBTX8GktjhqiBBLKYVt+ntg
 58Z/tppVt5L0JxYOc7iBa7GftKH0zzzfhofIjrajB4+mppKOTId+NkUWVrMhiJVMSyXHNjCGFx/
 /y46kkiygF0ovVpWelkV9c36cFAL1uq0wvEfnH5MxqQsgzBC/YS03SL1thKXxZcnDW9ZZQCErAQ
 H3qw7jGolUVcWX0DxZ1q2jHnWZWIDrGpAYOZvpQ2ijDq0CAmUaY2X0IJVjEk9cIRua7ebxS7eSS
 xS+Dx9vm9y3auWjBIKjIo+3YAr4/Ba1Dj2jeb1eQwIbLj/4GQp9+kBbLXxzykzP6O9qcwd0N7pX
 60uxcNP4kTnW3walM+WFsXLxNonRSA==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68faeb89 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EXeeq68Q20KqPfprLVgA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: CcPutNYrArT2vwd_crJd6hs3TcO2ive-
X-Proofpoint-ORIG-GUID: CcPutNYrArT2vwd_crJd6hs3TcO2ive-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On Thu, Oct 23, 2025 at 02:59:12PM +0300, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > DPU version 13 introduces changes to the interrupt register
> > layout. Update the driver to support these modifications for
> > proper interrupt handling.
> 
> So... Previous patch enabled support for the platform and it has been
> using wrong registers for interrupts? I think that's broken.

I want to express DPU 13 has different INTF register address, so need to add new
interrupt array to let DPU 13 interrupt work fine. Maybe I should optimize my commit msg.

> > 
> > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > ---
> >  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 89 ++++++++++++++++++-
> >  1 file changed, 88 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > index 49bd77a755aa..8d265581f6ec 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > @@ -40,6 +40,15 @@
> >  #define MDP_INTF_REV_7xxx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x004)
> >  #define MDP_INTF_REV_7xxx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_7xxx_TEAR_OFF(intf) + 0x008)
> >  
> > +#define MDP_INTF_REV_13xx_OFF(intf)			(0x18D000 + 0x1000 * (intf))
> 
> Lowercase hex
OK, will fix.

> > +#define MDP_INTF_REV_13xx_INTR_EN(intf)			(MDP_INTF_REV_13xx_OFF(intf) + 0x1c0)
> > +#define MDP_INTF_REV_13xx_INTR_STATUS(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c4)
> > +#define MDP_INTF_REV_13xx_INTR_CLEAR(intf)		(MDP_INTF_REV_13xx_OFF(intf) + 0x1c8)
> > +#define MDP_INTF_REV_13xx_TEAR_OFF(intf)		(0x18D800 + 0x1000 * (intf))
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_EN(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x000)
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_STATUS(intf)	(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x004)
> > +#define MDP_INTF_REV_13xx_INTR_TEAR_CLEAR(intf)		(MDP_INTF_REV_13xx_TEAR_OFF(intf) + 0x008)
> > +
> >  /**
> >   * struct dpu_intr_reg - array of DPU register sets
> >   * @clr_off:	offset to CLEAR reg
> 
> -- 
> With best wishes
> Dmitry

Thanks,
Yuanjie

