Return-Path: <linux-kernel+bounces-833324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DABA1AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3911643E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84E19C546;
	Thu, 25 Sep 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7j9+LAO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24370DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836888; cv=none; b=mVwHV5/AkhSD5jYDqwrYl2pg96gC/at6Bo3/yoQQ8Va2WwT76IJB3Q7Wd7lr9A/MvXBOODruer+zT2IZcDNFWxmg1kkqduSOanwkkmEsYOdT1qRPXcY4RJ44f5bI/5oCnEreFUbfxHUQ6ktTaWBhCkMhIQm3rK7IChElVTVOYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836888; c=relaxed/simple;
	bh=c4pxs3NYo28ei3d77uspVU5mL2Ak3RMeFnGgYp86uCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqw0R2WmrQuATRsmFUlk1a+R7ciI1P37VBHyJQUKm45IDwT2iaiDg9srgQ53mAOCYAwTc29VlSrEE2FSaBA4SLdaT9ZZvJyu5DTIlgW+3U2Uw8wShIEsr7W0qpRXOj1aCM6QTilT942fJvZytnaW73zQvdmhmYauTL3wbrETTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7j9+LAO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPbK6011346
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1J7NyDGcAjM0l0VsjLAzDq+jwGxhWn4dU8Lohd7guWU=; b=j7j9+LAOKoPHC691
	/fhNAoqOTVhvN+4wSF8mp6HhqTWjn5M32+QCEotoPCqWrBG2FsV2nPhAV+PZoab1
	B2BrV1H4r7KEAn5ESsbY6+Dj0v90Ks8v52mRCot5RQHnu61HLG3Zs72V47V61j4y
	EzqxyZxnwBFptDTwEE5PfmU5zBjoK42KgfzZ8b9gw7Hi72glQH3/49oVmHZWdHnM
	q2SvORYu/qaOyO1X9xazd0oO+rL3q/oPPzG6qDD5WkTRCvdOmk8XU9/5VMsXOyJ+
	nngVltcx1yeINnDS72loDOqQHkFNb2va9GwqSnGoqqkRjdbOSM71Hp1C7YL2VnR9
	YoFKhw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0fxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:48:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d3632cf912so33231821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836884; x=1759441684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J7NyDGcAjM0l0VsjLAzDq+jwGxhWn4dU8Lohd7guWU=;
        b=S8EUCr+RCBBrIIdC+2j2jpf8ZEH3j6DPs9/tpPn2UL4zq4B8KpzVoyxY1h7n2ORx/g
         VZ+gXNFt+DJK8SEhaAf69JfWMJfbAGFCwNpePqYwJqr3QK0tuyPCt+c1OfB2FIEBjmXH
         mGflwmSJ65fS7kxM+eOR+4ew+9OZlEcuYguX2iJwuAfuGfHowziwRf/StE6vt+34fHMU
         1IFqPMbgN4vZtwifElwaRBvC2VuxUsfVFfwQxQifsIPsL5onyAwS93oKT2rK+Cigwqi9
         HmEOcHKmVavIEmxTma3BEnXOGBlupdMjbUR/yMQOszd42Zj3G5tGJCzths+q4ntDK/+J
         V25g==
X-Forwarded-Encrypted: i=1; AJvYcCVsOMvN1K9rc4oZwYQcEEVAEAdkYAaIzJndPJ5ZWoSqiwD3fgcmi789n1Ji3gmPVMjpwP1B66EkX6/9osI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaeDvakkRE43Ni1+Mk41m44f6a0zGxCUqnse+zDqzDXaXG4Ia
	9JS9g+hzBx52gQZY/PN1hoJdOlPRbQ0RxtU4kn8OAn+jC3fAQAKQrCbDJQq+hUmXncL0m7am0Rs
	/giLw2FzDyXTn0xbZ2A93+30X0aN28qg07ZkOtnQyN/DLGPjnXasCTEBR6u4in0rssgEVP+F25a
	s=
X-Gm-Gg: ASbGnctJNzPZ7hgco6LtzYs4Ne8zowLGjLKfMGLnXkrjAuVX3bXDTByu1pCtt1Xc74M
	p7JcwyqJfF8mrRJ+/L8DZ48J4BN970Gs0jzlkXzv74QbwjrJZc2ryDqN0qYQqtGQkhDQQbuw4nK
	1DTPVQgn25hhCUMT8xzPBN24A49y70fc1uUeItlKH9eFHLWJ0/taOlTuY1rKyNxli56sJ6O0Hx0
	q++FYuBccTcDHpcUfytUjzE2pmQOXO3AfQ4QQ1Obo9yIASbib7AtmmbiS8RDYFxTKi5EumZ3wKr
	kUkppE6NrPBqUVCUhYM8Kck8o2QGa+LHAh3EiCaDxr1MyEZmN+FEOhRqKq9LDXIKQ7c1GXrun2M
	5ESpj8QcVv+v3eDm2awifvXoqJpIalyvFzXIRDaQD+hOcju6x2FpM
X-Received: by 2002:ac8:7d8e:0:b0:4b5:e7e4:ba74 with SMTP id d75a77b69052e-4da4c39d3a7mr81769721cf.56.1758836884391;
        Thu, 25 Sep 2025 14:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Z40dedXoEWvgR9gkshTrihOWhuvgfiSSS+xVcgz3Ka7O0hjWhnzpsUYogC0k7NypbIYSSw==
X-Received: by 2002:ac8:7d8e:0:b0:4b5:e7e4:ba74 with SMTP id d75a77b69052e-4da4c39d3a7mr81769291cf.56.1758836883750;
        Thu, 25 Sep 2025 14:48:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd679csm1147631e87.56.2025.09.25.14.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:48:01 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:47:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v3 1/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <wttg6aizzolsm7qqntspmmwje7kqfaayoqvwp76tvudlkx5phl@7twddmdajfwp>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-1-6927284f1098@linaro.org>
 <5b75dckankcx55gbm734a23rvqxdbprlus3nkvqfry7lz5ksjf@jjmfsbiwqny6>
 <CABymUCNZmxzRaVVLU=U9QPupK0KpW_C1eqa8t_ijL6B5EdgnAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCNZmxzRaVVLU=U9QPupK0KpW_C1eqa8t_ijL6B5EdgnAw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 1MwAul_deDok45J8NkXz02rb8Y1wQONy
X-Proofpoint-GUID: 1MwAul_deDok45J8NkXz02rb8Y1wQONy
X-Authority-Analysis: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=68d5b896 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RAbU-raeAAAA:8 a=KKAkSRfTAAAA:8
 a=F1wq8hpAVWgPklvmxcQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=JiizpSU_mAIq9zsZDqn2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6qw2mlmRw/GO
 tvm1fnHY6SHMzQziydEOEWtCEckSXuwnU85HzLkkYco0Gds/jY3kHMerTOs6dLHEjckyCaGWark
 o8ukZlDlndw4Z/kgLsS7+6jRbNSqJ7fHK4U9IDlqalLBkJOuADhNOtce8MUjb6aW21SVhGT9UN9
 vnWg8rccXQgHFnhznapTEcIkT788phxQcTz1hVfzYTdDNEihakv3o6UYz2HLRddAZPVZJ4wUJGD
 AHNVC/3znshlnLhs4Dmi+cuzcuUq6oGXoX/DmRUHFA3ByObZsyBlB7bPHIlSvEruxwZQx89Oj33
 qgtm+A+lRluBG3ZT31DP34JOBqiVwOT4Q7mB/svfO95vbLOuy9bPEcnjLfNGiQAjNbqgyhPPTBQ
 nPb2adwq0slpE70Hkgo9uWfsNamWhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 03:07:28PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年9月25日周四 03:10写道：
> >
> > On Wed, Sep 24, 2025 at 11:08:10PM +0800, Jun Nie wrote:
> > > Some panels support multiple slice to be sent in a single DSC packet. And
> >
> > s/support/require/
> >
> > If the panel supports something, then we can omit that and send 1 slice
> > as we currently do. If the panel requires multiple slices, it's
> > mandatory.
> >
> > > this feature is a must for specific panels, such as JDI LPM026M648C. Add a
> >
> > A panel driver which executes this API is appreciated. Otherwise in a
> > few months / years somebody will submit a patch 'field foo is not used
> > by the kernel drivers, drop it'.
> 
> OK, will add a panel driver in next version.
> >
> > > dsc_slice_per_pkt member into struct mipi_dsi_device and support the
> > > feature in msm mdss driver.
> > >
> > > Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
> > >  include/drm/drm_mipi_dsi.h         |  2 ++
> > >  2 files changed, 12 insertions(+), 15 deletions(-)
> > >
> > > @@ -196,6 +197,7 @@ struct mipi_dsi_device {
> > >       unsigned long hs_rate;
> > >       unsigned long lp_rate;
> > >       struct drm_dsc_config *dsc;
> > > +     unsigned int dsc_slice_per_pkt;
> >
> > Why is it a part of the DSI device config? What if a device specifies
> > dsc_slice_per_pkt, but not DSC config? What are the legit boundaries for
> > this field?
> 
> You are right. drm_dsc_config is better place to add the info. Thus only
> panels that support DSC can convey the info to host.

You will have to explain that it is not a part of the standard and what
kind of effect should it cause for DP and HDMI.

> >
> > >  };
> > >
> > >  /**
> > >
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

