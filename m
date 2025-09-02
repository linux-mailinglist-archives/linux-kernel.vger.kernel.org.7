Return-Path: <linux-kernel+bounces-796440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B3B400BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517551A83DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF423C8D5;
	Tue,  2 Sep 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AOUDiaID"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0342236430
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816507; cv=none; b=rk8XLPFuDxV13gVAu8UnfOpubDvJsuNANzN/KQH0GrhMo6PgUpyLVBHMpCDoIqdU5ovCnHgDkp/f6H4ZLl9L9tQVKNXdUU3KWgwRiBlNkfZxS/ZwdaEd/YHctByi4pmUun/Bi5eQDUGO0luFX8xrmIWtpegbXqMwy+B0Fl2fb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816507; c=relaxed/simple;
	bh=LsELzEw8Q8N1hec1/lB7lSUYwB0wSGJsbCJHldjKkD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsgrVo9/lemB/JPTdClQzMIxFYDszSDmxJi6nv2g+V7Wt4v+d43xZrxpsx+xhf0jQaDBWIfGr3fejoDeLOsULJyM4por499DbmGu3WXP/92XlM7WXbGxZIRYwldKHVv+vYfXtH2N7J8gpqB7orJKlIbj8qtPpt1HGhCHnwJZ9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AOUDiaID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B6DMi022015
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B4rVQpxPPO+FQPgP3B3UuvMg
	XoWmixIq4Cskx+zX+jI=; b=AOUDiaIDOm5Fthrt+eQBaDoLAMOABN3sm7UL2qPI
	aZWN6UlGTDdR/90xc5qKg3qwW1RNpaDUwKQg8b+5iXIbOLHkLElDTkD4pOZJNVm+
	I91o5Zoa6Od63CX4a0F+4hwKGx9IXX5l3BauAwj+G4KRcKkaa9TPYYIcnZ9osNeU
	4TfcMruhuwyghHnfw1F957otT+rOHSr7RqETecK1kds0tLWiwMl2EF0bLZjoV1v6
	Ffu1QKlH7D2axvr0YSaUIkGADq5HgsgYljt0ZG2wrHmgtZdeYjnld7wjA7WAWalt
	YhiinRjnYyxmreETv1UTnpD/qdja/yJt4BmoIEH7SrCeOQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp7x55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:35:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b327a79a30so65091911cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816503; x=1757421303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4rVQpxPPO+FQPgP3B3UuvMgXoWmixIq4Cskx+zX+jI=;
        b=BzsUWlOdCn7aZmgXQbA+5tYl93xFAqThO75+NHOC9rddUKJ+vk1HYiexemPiFgON0R
         AmFloXpgu9wN5fsP9HffajTHV7FCwGVY3F2m/8iek6brBknKdnPZwgICQJmwUhfLa367
         zhpvkuoGItTh0zBH7yir4a7Dv4jQjIuXaffkr3EmI+qld4uGNwfIw4Esh1rJDB78iFNs
         0ueYMU4+/nYrBR/lnVKxhR1wcsViywgbORVZzG1Na5REddeRcgFXurp/yGvmYYc6WEao
         yOD/G1BORceoPwWQbfcFt5oFyIfSH5UR4Q6JzOLEdLxms+ExWQX5pEmYTJTXv6szYB4L
         hWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpWWXQobOrB39EmH5UI3beBVtptZoUEzPkobX/8tbAskNV5W2usJgvmJfGbmn6XyUGhf1WfQbM6WL23Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MNjO1xlrFi1HCaEcbRgL8tcX6kOYSvIUzK75sWVYISnga4r6
	vT0Zb2n68WQTV6B0YqOzV+qMygPB7JAcnWg8q0HfDzBbthBqKRuMEtw7avce8PDo6JfRArXti0R
	fYfrsCGjU6m196mMzuB1IQ5QV+sMSDnI8Fd++cDJ7BbnOPe3kkWcOYxbU4livG2WT9RU=
X-Gm-Gg: ASbGncvF59ovnw3vfcYqDNs/BfTVzjIDRw/umliOwz+6q30WyN2/LxaSBUQ/29/N/qA
	83FjoUuZslAYnJlW3AyDTg/W+JMb+zUkf2ZW5fzN5xmTt4aZmZCe3K8Zmfie/T7hVMGQ+j6A6M8
	tbKnsPIR9drn5qCsDJ+sPY94aVEtVv7oVtdL5epZRCrqL4UdrFnWVmKehiAgt5hfOc4QRy1HLwC
	4UnhvMz/Xm3iBVZOw8V7HXdwyp1g/QDFIlWAqLoYeLMFS6QBMlXaZPNBg0d1OjAbrIYgvzksf8f
	fbbaObllx9SC+K2yHkDLtAXGp25zClR0B4+IGn2uhQqGK2K6uH0Sfx3FEHncAIryLiJNsZIaVwc
	mYAVCA4JglzLEvjqNcNlYY5NOCwHvbw4HiVJRxvu1VtTi/wpUPXMB
X-Received: by 2002:ac8:5d49:0:b0:4b2:8ac4:ef72 with SMTP id d75a77b69052e-4b31dcd0d89mr141080101cf.65.1756816502568;
        Tue, 02 Sep 2025 05:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU/aLTJMFsLAMJ+zNuNGOEzmGzhvygt22y0Or38v41tO37Dhmnsn2U9YWvwA5+Rbfi+EGYqg==
X-Received: by 2002:ac8:5d49:0:b0:4b2:8ac4:ef72 with SMTP id d75a77b69052e-4b31dcd0d89mr141079651cf.65.1756816501921;
        Tue, 02 Sep 2025 05:35:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827a71bfsm672243e87.129.2025.09.02.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:35:01 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:34:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/38] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <z3erghqmjodsqbkkzzxtdt7ca3xw2esj3jqsshouipqu2mqvx2@kwxqs6d2ntuu>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
 <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
 <5b142910-81e7-462d-8933-70705334ef0a@oss.qualcomm.com>
 <yarnaujunszlfrbduakodv7n63wjgh6og3t4qowhu3n6tz6fmn@4kb4crd5rqq7>
 <d7141b57-fa3c-49ce-9830-8310a58b9581@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7141b57-fa3c-49ce-9830-8310a58b9581@oss.qualcomm.com>
X-Proofpoint-GUID: MVaE0Jhcyk4f5jD3BPpnsyz3khHTGOQi
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b6e477 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pUvFZNViTmPBewPdAa8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: MVaE0Jhcyk4f5jD3BPpnsyz3khHTGOQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX3tIOhhO6wssK
 GdGRUayooS35CXZEEuIvvP66tf3hlpZ7VROBX5H1JaAuLQ645EaL8c5naIgE18cWBtcA/YpgKhc
 G/zwrqvEKYw70UeK+/er5m4/+xqPiXsXtoagNlfJi2EY+Pb15FOCNVy7HCrf+LL1ZNMK/6tFu66
 XUSWKikwlsm7cSGJu3BuokUoMGHVI6Miz6OAhR/OTg9f9SUwejG7Gkx9M5ewRpfXS31QDQ4Il/p
 ZMwIpVlmc4S6tL0/a3qQqwbWbJMTs331bwfq7yqzihtrMGqmexJJl5JtUGNb85ID0nmbeH30LUd
 Bc8SKQ41mqmb1CP/JQMgWiTNRC8XQNo1MugoHKLiYI82dgKKBnPliK1Duv30B6xy9AHcRE/bzNH
 dQsc4DdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Tue, Sep 02, 2025 at 06:19:11PM +0800, Yongxing Mou wrote:
> 
> 
> On 9/2/2025 5:36 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 02, 2025 at 04:42:18PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 8/26/2025 12:41 AM, Dmitry Baryshkov wrote:
> > > > On Mon, Aug 25, 2025 at 10:15:47PM +0800, Yongxing Mou wrote:
> > > > > The cached drm_edid in msm_dp_panel was redundant and led to unnecessary
> > > > > state management complexity. This change removes the drm_edid member from
> > > > 
> > > > Please see Documentation/process/submitting-patches.rst on how to write
> > > > commit messages. Please use imperative language instead of describing
> > > > the changes.
> > > > 
> > > > THe patch LGTM.
> > > > 
> > > Thanks, will update it in next version. Since the HPD refactor series are
> > > unlikely to be merged soon. Can I separate out some patches from the MST
> > > series that don't have dependencies and send them individually to make it
> > > get applied? This would help reduce the number of the MST series.
> > 
> > Yes, of course. Please keep version number monothonic for those patches
> > (e.g. by telling b4 that it should start from v4).
> > 
> Sure. Thanks,  I want to confirm whether the patches should be sent
> individually or grouped into a series? They seem to be logically unrelated.
> I was originally planning to send each one separately.>>

You can send them separately.

> > > > > the panel structure and refactors related functions to use locally read
> > > > > EDID data instead.
> > > > > 
> > > > > - Replaces msm_dp_panel_read_sink_caps() with msm_dp_panel_read_link_caps()
> > > > > - Updates msm_dp_panel_handle_sink_request() to accept drm_edid as input
> > > > > - Removes msm_dp_panel_get_modes() and drm_edid caching logic
> > > > > - Cleans up unused drm_edid_free() calls
> > > > > 
> > > > > This simplifies EDID handling and avoids stale data issues.
> > > > > 
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++-------
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.c   | 47 ++++---------------------------------
> > > > >    drivers/gpu/drm/msm/dp/dp_panel.h   |  9 +++----
> > > > >    3 files changed, 26 insertions(+), 58 deletions(-)
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 

-- 
With best wishes
Dmitry

