Return-Path: <linux-kernel+bounces-753254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFCB180A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F31C189262F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B722172E;
	Fri,  1 Aug 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Up3tLr1+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBD2BB1D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046270; cv=none; b=IoCoimpueJsoI+/YTxtsMmLx8o1CkIZ4wmLC8NzagVyC2LxkXgxYanRQKid9zwi5pUqFPSl2nycBIvFooXaK04I5q62wPcjRpTHakJRg26goxVVUlfz4rUdptvIM0vClEsYwUcRhjIsKIvOfz7dWphqoCOXJqPqBlSPrFICFHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046270; c=relaxed/simple;
	bh=zOehqtXHRDO6fWosdVjMRCsZ1EtHdLfJqca5uCbIWtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD/6i7ZgMw6i6uQQscRV7mon1jUFU4uYrPwuQFkLTUarML2Y0oikNZUzvO5Ane7rlc9AqCMZRmPIhiNKzcCTQKhT/b/uUeJBoeZLGcH/zkRjJUTR8LUhcXUUkWjE8xuMM5oyAKbUC3kwnvMFwGcb7yiKAgSZb9Q6pyrqfxj6rLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Up3tLr1+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719HGc3018997
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NgRcL7ZzvTtLCYCuWN7Ar9gM
	KYLMCAowZwuINSJ1rW4=; b=Up3tLr1+ZRyH/8JyXscwVyb++epGiqLhGPbiCd1n
	dg6EXUVBuHHB6ETD4o3lY8aRx21kaXbIHsxw/ONgW+zHrTKjSjhrBxVI/xrcCgJo
	L92+LphSidvf82akRopdNEx4/MCKeAuwvZ7aySqEPplr8SVqPagGgIf9Cls1DnhK
	/stb+p0QSyYmhEKPQ3e61K23zRh5SMkvMjHljJtG9dgi7dRXrxzoPFdbyO/GlTLF
	01ubzJhQWzq39DlqiLUAWLIJUQehyriJRPPRBlj9p8Ucg1DtddqLu8SbzsGarXOv
	nyJRy3GQtw8Iq+elK5hU2cXLl5lhhRsAy9uozCOPY97uvw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwgg4w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:04:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aef2f51b7eso26253461cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046266; x=1754651066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgRcL7ZzvTtLCYCuWN7Ar9gMKYLMCAowZwuINSJ1rW4=;
        b=gjJ/qMbye1Pa35XexqH+nI1EkptnigHS0RTmJ0DvkoQxvKiKJNnjRA8sbcBzS7txFa
         esESftZiliDQGJiGxUEpvKSjzA9rVMP8FXLAmLyPBgADoSBfzWcwifm5nyQxRbBzjhgy
         uFgf/ZFyFuwYALd5d7/tvl2Dzaj0lAF9PhvvpukI5Lep24Bz1r1hwCj7U5XLU3nJftg6
         Z9qr/FJJ/FMV/9vSnZDDuMIhUnEs8gxD/PI/8p+RutMekfOBSKyv+KZAPnbkv9nUVPaz
         6XpPZou5v28/IOdb1SqcSSpRf+4k1wBtNybEIjezxsdAWViwBexQjB9PVxg9PKCi9BJD
         QCkg==
X-Forwarded-Encrypted: i=1; AJvYcCW65eQ2ACoMufaD1eKeTilUizmTVOFzBmVcg8d5lpoNjZuUpNI0FUYZ9FQsZnTu7mbmaZUz0X07gBJK3aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqNxbVbBJ+Kbze75eNC8dPEQ3AO67LsTqmpM7tWSCtfBbd6sj
	2FX4PbE/vjO0COGRHTWYJiYw5uila5/DQjis9JwhagfZzVK+9+E1VzU55FegKg/R1zdlPoD+bU/
	oWpH582MtAET/UvQ1uk1D4eW9gF596gE8GJznZhaq00x+Foj6H0uRw2z4kTlrQeiKpT8=
X-Gm-Gg: ASbGncsmbrxLjy+njShGg/JA3rTTrhDL6+UvePbX8jwr0o1ltFp68rF0WNsfnsQ5UXy
	ZUOdlIwXo5RS2bbcRIf99bCNUnqo+0r7Y15MysOkMwPOadNTN0vfv6WtwdhvN5StBuGj80yLU1T
	W2y69QthTPKMAnsiOGVan7Bw1kxz3D511FvV2RTJjNkxdNZQWtJmq386k24Oq1951WxSeLwqHxN
	dvvheVEz8Z+SbL1SNcKT29gCqJQ//ohjH081v/zBWx9SWam92O6WN+gEpBXz+YPpPT7F3b41nA2
	m0GjZGl2ETSMtTobbS9tL4dijqR/x5yTQ9NoXuUoiGul4bRJ2F41H/2dUfUQB+4AJ8axZJ6yf6U
	UGxHGwHYx8Ps+JCw+DxpSqtCIC3zgniyKAVvMH3jnB24KGh2WRXkK
X-Received: by 2002:ac8:6312:0:b0:4ab:65ae:410e with SMTP id d75a77b69052e-4aedd3d7118mr112659741cf.29.1754046266186;
        Fri, 01 Aug 2025 04:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuigU5I/fNY+R/JXK4FaI194+ce8U1d910+DeVFR6Gtmc8iLAg+RFSFlfj1DqL2LEydQoptw==
X-Received: by 2002:ac8:6312:0:b0:4ab:65ae:410e with SMTP id d75a77b69052e-4aedd3d7118mr112659231cf.29.1754046265530;
        Fri, 01 Aug 2025 04:04:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272d3fsm5667011fa.5.2025.08.01.04.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:04:24 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:04:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <bnmpfzdhbr4wlpk4qfcewfotmstbf53ulni3jo7bklranpq7ls@qugmpsudkzzy>
References: <20250611140933.1429a1b8@canb.auug.org.au>
 <20250801143440.59e13a4b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801143440.59e13a4b@canb.auug.org.au>
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688c9f3b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rOUgymgbAAAA:8
 a=83lZ8fBB0w3I-Wmrrl8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-ORIG-GUID: KfpB4QGDxhOLMM708XKNFGAZGDYkVQiv
X-Proofpoint-GUID: KfpB4QGDxhOLMM708XKNFGAZGDYkVQiv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfX4DkNNerQvgwN
 R115yR2sWjlVuedjsiV6KkUu6DbrbjTqzWJ72ygxiA5QHZoafPJfIKsgKWcfQuRlWsHzsI/Mz4t
 h4L+46t2E/SzO/OxpTW6Kss1QSqhIBjlJYkUqoiVTEy+sJQLBaxLWlnu/AIf4xLEbltFTIrk9NG
 voHezGkS4D940wl9qkAzHluLcb7nIqA+8v39HbwAfwr23zMFiuo/eFn4ghITJV3La5n51BF85Ec
 j6E5SZrPjlAlTBPtMcinAsyNQ7pL6AR9lhanAl5MLCbxgCuFaazBKhgs7THxjma9JH86BHx0PM9
 wwpNM5NACFzxDla9XgXrHi7nflnaNhmQjvls8JIjFjnxKoSAjGb/p17yZ0JuplP0usxgTt/MbSe
 eHcsysUrb0Yp5cKORlaMtDjBLt61tCrx6HCXRSwUPGXrKOIFpLr8tv+zzqW/3QWF8yx5sxBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010079

On Fri, Aug 01, 2025 at 02:34:40PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 11 Jun 2025 14:09:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the drm-misc tree, today's linux-next build (htmldocs)
> > produced these warnings:
> > 
> > include/drm/drm_bridge.h:943: warning: Function parameter or struct member 'hdmi_cec_init' not described in 'drm_bridge_funcs'
> > include/drm/drm_bridge.h:943: warning: Function parameter or struct member 'hdmi_cec_enable' not described in 'drm_bridge_funcs'
> > include/drm/drm_bridge.h:943: warning: Function parameter or struct member 'hdmi_cec_log_addr' not described in 'drm_bridge_funcs'
> > include/drm/drm_bridge.h:943: warning: Function parameter or struct member 'hdmi_cec_transmit' not described in 'drm_bridge_funcs'
> > 
> > Introduced by commit
> > 
> >   a74288c8ded7 ("drm/display: bridge-connector: handle CEC adapters")
> 
> I am still seeing these warnings.  That commit is now in Linus' tree.

I've posted the fix at:
https://lore.kernel.org/dri-devel/20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com/

-- 
With best wishes
Dmitry

