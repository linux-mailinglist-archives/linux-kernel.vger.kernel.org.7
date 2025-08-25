Return-Path: <linux-kernel+bounces-785296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF0B348B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F85D3B259E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10339303CA3;
	Mon, 25 Aug 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVZ9EhpK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C1301000
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143168; cv=none; b=tqvEh+Ux0v7MrkyhtkGgTTRacWR/CAPdy//KTllCKyley5hVH5CxbxUCjwCYjTS8dhexV2VUlXbQ0cB3aLUaeH9FdEkd/8mFPj71pqIEXJD9ZAsORsD8Zg9JGUETB8WA+oqQrl679qM+JcNaQY/RlA2UzACha3jtLtmenEfi0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143168; c=relaxed/simple;
	bh=FdQgA63171kQamrvoRpHVDUxsVOKlVjnZl2p+Aodt/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZe2O2KQTk7LOMgokS3PSp06gejvTbmjwPkBUHdSn3mQtaCrFZFjIQA5xpWMran7ci5JYxgcMCvHVjRl31WephYihp3eyW/JZT9c55DYwFI+vg3GQ1zLhZjo5OSCVOi1AZY4KCLck9Nd7/fe+KIq9Bffz2VFqyTCPmo5EeAgrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVZ9EhpK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGvKB6025424
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PtOiqEStQKZ77zF7pAKUnMDX
	Hl86zn3BR3KKMOrL/y8=; b=NVZ9EhpKamed2usnZ22OuD7deiCJJtYDOVcRZlh4
	C7h0LGQNQm4BhPWhv5UxLXdQSm6CPiDDWxMgkf8XfW4x/0ShSHHRDa988lxJHkdY
	NMkcr10gI4fWSRf3z3vL78XnME/a7n3ijNuUXGwpfJFzZVXbJ30z2xzJ0rlP3MuP
	CNOc6p3+/nvhLe+EUYefcW/fhy5KdLsVz+Wepweh0hDQMC41mRXMR51xnSJCOeJP
	3JaDIIjgRpaJNIKcglNm6TILMfgVSJ1BlG0wpkw255znSohOILxAJL9i+Vg4xdBs
	H8GcFpp5dOTcDqddrRJs4zhsj07NveIQud2D/+C0TDQXOA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rusk839k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:32:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109765d3fso99849731cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143165; x=1756747965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtOiqEStQKZ77zF7pAKUnMDXHl86zn3BR3KKMOrL/y8=;
        b=E+/S2QteOiINztEnMP01D0KSJnIE6nuDMVzrRvhmOZ+sCe+0dbwwhqnIYBt0wbUDF4
         iD9DKLeYCSYJwNL3x8//SM5OB2cdWAN5aqe24geHyydYf13zbtrmAwKg/oQ60rc98RF/
         cIMJzrAKzYY/p/vBaN8pHbzQ6lXgY+LjPn1t7YtIiX9zi4qK+b8DeUi+fRsKCOKGXkw9
         zSnh1vtduJaOEhbiSTnVg2U+4oF9FMFrupUx98KUaqg+2op7/Fj72CzHrI9CP7thv9QR
         +6NI6I5nWxRe/frEqDCwT7ed88zluLuB+ubVdvb17ZQAb+gzja2g+4IQzi8IoHbgAvdr
         zgSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTan+QUFYJ03TGIWBEHg9j1i2HSdTvvsJgCv8scWEFMO29eDQUUVhqRgi30Ivfq+Z9zCGfXyMgm2y9RiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBHbqKwc20RQFE+vtgtvtTBHOyATz9OI7KxYZsZzsipbcEISC
	Re7Igw3/Dz44xkP0wkiRhrwnB5wKCM343lNIa0Sqxee9kmnndLepos/leglCiHlxaUYtKQWJLiD
	WJk9mrPSS7mAXn0PLHw0RMxHbjpdPX3Lak9mJ5Gmr207W4FW0CvQ3oX791dxd3LVEJPA=
X-Gm-Gg: ASbGncvsOL9fMSBwe7uS0qbjNXhHg/TgGboy4kkX1TOW8U5d/K5jBdDqnUnpTPXD2OR
	M4l1VsFe7NSnqRxynnEdOfxoL+TKtSfS7QlGAaGPLbbwXPlnJb8/R0fQf59bBawQXR+z/6OcIip
	r465fWJVwApV22ZO+TX6DBpEk/3offGlax6CG2ne9jyyw8/BeBQw7DZxHNhwpDmBWfytLAdqecS
	iYsF1hV7wQCHnrwfMJofipY9l/esRjzH/jOcoUPqkKKCBx1ZNvb7KK6Hl1vu15jz0Plsgj3uJB4
	9WZJFudXPjNS8Z4J+zTq9RS7igQDeYKtpJk7SrHGu93I3fDPjPlJpGExoklOgQ3bk0NKbQSkEv9
	vpNfuIN5W0eYeSM03Tp4n/xs+329GRplsq121sWFicRq4IWmXlQFU
X-Received: by 2002:ac8:7c41:0:b0:4b2:8ac4:f098 with SMTP id d75a77b69052e-4b2e0a20a11mr6080851cf.34.1756143164548;
        Mon, 25 Aug 2025 10:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyWUI9/JcuNq34IRC/iYRA3AEnS2Qy6SSU8Z7TfujwVKyou4G/jnYD5HrIwMTWY66+zeUXJg==
X-Received: by 2002:ac8:7c41:0:b0:4b2:8ac4:f098 with SMTP id d75a77b69052e-4b2e0a20a11mr6080081cf.34.1756143163891;
        Mon, 25 Aug 2025 10:32:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3d4d1afasm1436815e87.58.2025.08.25.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:32:43 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:32:41 +0300
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
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 07/38] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <jlgm2fgkyflflphtb4cv5gqedvbrstc64rz5iihjvvwvncha2q@5mrwxuq3i7jx>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-7-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-7-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SY73duRu c=1 sm=1 tr=0 ts=68ac9e3e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6Lrzk36WTCfDkofcdswA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1xcZJ0Uvtjdr4hWxuPc0uS6T-kJJp6OT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE1MyBTYWx0ZWRfXwjEgpg2Dm06w
 ZNqS4AiyWN/yeUxDaommmrLFkqXZ5MG48jrt+pVMUBFch/QmWih5R1LMcSozxVNjl+iFvf1+fnW
 EwP84uxq8QozSCKekV4hdf3IzITrkilqtj6QAO1PJfpv58pOCYIXkh/q5y2ZgPJ6fXyjq4A/hnJ
 5/TdQIvGhX/NRxJwrebXKX/sUk1G4L92f3Wjkf1lelqLUNH0Zkex1WhKAY5HT8PSbvL8LYXK0Xb
 cSWKR3R106xJlKLPsrkQpOwQUxJFwSJQU5q465E76YCEtM4YR3mCu5XsX0aqBtRcYoPi5gYlKqw
 bVAdNPCAp+HojwCS6ao0USfyWj9ZDMt2YMQ3JJ2vp/kinQck8pyGvxhJhxIjKB/vNP1c6wOiKVR
 esadaAh9
X-Proofpoint-ORIG-GUID: 1xcZJ0Uvtjdr4hWxuPc0uS6T-kJJp6OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250153

On Mon, Aug 25, 2025 at 10:15:53PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Currently, the dp_ctrl stream APIs operate on their own dp_panel
> which is cached inside the dp_ctrl's private struct. However with MST,
> the cached panel represents the fixed link and not the sinks which
> are hotplugged. Allow the stream related APIs to work on the panel
> which is passed to them rather than the cached one. For SST cases,
> this shall continue to use the cached dp_panel.

cached -> stored

I think that for MST case we should not be using the msm_dp_panel for
the link handling at all. Does that make sense or would it require too
big refactoring?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 

The patch LGTM.

-- 
With best wishes
Dmitry

