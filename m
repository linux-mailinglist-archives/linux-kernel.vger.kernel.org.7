Return-Path: <linux-kernel+bounces-825108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FE8B8AFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9081C4E7F85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB72765ED;
	Fri, 19 Sep 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RodICOPT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C461268C42
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307839; cv=none; b=j5MSyyMt8NvcRpXvHRLCB3UEvGWJ4/BR/Vf/bWAsz3GM/wjSISHYSohhwLoyNgobzcy2O3IHfhdBO7rRIsc7vurO0Vt5gxWWqMvkV9Oee9FTLfWZ3kEofd9aPndSCXUTdSEnwfHGTjdgFsvCZKq5UdNbc0b6d8r7xJZim55tY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307839; c=relaxed/simple;
	bh=GH48vQlKxHp1FNXHWxP0jWvh3YRMVUXRARdfvGi/WRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTJpNPC+gmeKYngGb8tZCgvYhqpoCMc6Odq4xKQXFQWw15ePi32tFpsdgpgY6QJiVB/FcP66KghMSlaExT5PuSogk/qR9ohy2DZXfGdgAEISVRoMytP8UqY40JcdhP7vkohao9i4o4HvKGY3/KiEFcVmAnpQn076leBc2AFcYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RodICOPT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JEl9B7021413
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/zVetAH60xiLOOQQabWXMY2i
	CJqLvqOL6orH5OLF1Q8=; b=RodICOPTncKTFzokmFCdDNVaPBJJd6jTyD+ULkYC
	AgRUa2FVVGtGArGXg1DMC62vrdl8/5pxLVdSoHAsbZnuN+DeRZX83Jqb1GPzcTxr
	J1IHk38SJ4JlTHMBE7vJb9Nzz1w2IUfat+WPkiInnAvzev+8IGTWghg65ZKpcTfH
	+VpDg0MGjOnwUd1obLLgo2mPiGn/aShskL7qec3qnHXS2ttLvmbAF0UJws9swRnW
	OJsWBVvH/Jl4jfDjX3Kv6cJehSWn2hprDacPkGnw5GX0nxq1dHTIzj9zoGA+VYBY
	kb4PyzAGIArZkEH9FbNIhatiH5y/DbWkVO854H/++9QDFw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5kjne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:50:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so41933951cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307835; x=1758912635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zVetAH60xiLOOQQabWXMY2iCJqLvqOL6orH5OLF1Q8=;
        b=KwYykr6Q15zO0mTCUkSvgcNtdjvKW+0grkIos/20eDuuXtLh0BG8L8eOM5733iKJY5
         +CNU9VKOnhnv7s2oiN1n6h4zzEURg41lXM3qfACljJENUsUJa69VxaLgyE1pN5CjaMsf
         bJa5e4Gki/35kszFGXiBVLucKd8A76XHsAY8Obf2Yymf/yKPh6gRsnFAHQkywx8QcjMW
         TKxsfA+3Dgkrd9nC3T/LJ8NiYisqPRtghEE/3mr5pOUshUZ4dWHaFd9Ap+gn8uSD2oYg
         HXzRJvG6yDoqxVywbeacierFoAJs8y+Ph/DMQtbchwHYRwm4MPXg2wXa0Vn2dSxHvxix
         y1+g==
X-Forwarded-Encrypted: i=1; AJvYcCX5p0xA01RLM85hHS8S6Jfq7URqfVd83n11JeBzj80WR7EWDGWRTFHEdjXZYxZ+JX6yVLWWjVALGeXXnK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IPWj1LYpwKBWiLjJCX/tiZDP1H4NUpS85+11S/DjlzpeJA+5
	1fdqLsywoKS5zT3LNDVkmz3gM2hIs8YUApYnC5JGcVapGK/s6/GpZYxr3oYGz4dtku3csUuZ5NU
	NxZZ8p6v95Y8wn6ZzzEa2FqZLo2Z/TN+40zurmzpGIGK5HpEEIauyn+fwDJS3g92NbDE=
X-Gm-Gg: ASbGncsoiRrzk4r8fo8FQYytXFJkJtKQFYvqf/39TYzFNUgH9uOyIMQFV3A4F11YbYQ
	GYPoo7A87aptpPmFru9+6/ulVdxT/ADd830EWnoUZdfAm2eYx7dGJ6aP7K2RAwNyZGdY19Dpkpp
	okWPUmYSd3solHd6oSHz8bhhm4UojanqmAe2HhKR/HuAJn8zD9kO60k+eYEYFp0+vlWbYkgx1Xl
	Y3Q12pKijSQN4lsoIIrgEEakGh8fn4Y2DyjKuyO5ri6OQTE+ZBbRAEsqMGkmd4AeWtRXxL55i1b
	ugVOL6vjGiR1LrbtXbJWqWZNkG0f1BNQWuc09+6+ID89X2j+dTrfxsB2L18Ivw8BlE0GVl8KC8p
	NL+By0i2Cv0DP4/+gFt9Lq2bU+fuHCfE2atUIcFT088v/ydGvLxkp
X-Received: by 2002:ac8:6906:0:b0:4b7:a92a:fbe9 with SMTP id d75a77b69052e-4c074a12ea9mr50090011cf.60.1758307834910;
        Fri, 19 Sep 2025 11:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHvM68mI4vWxxDdRyLwlfnUEBZv557Y2SOJBuuYk4+sFrbV9HcLthdAsZ2WBw6KM4yV7CgEg==
X-Received: by 2002:ac8:6906:0:b0:4b7:a92a:fbe9 with SMTP id d75a77b69052e-4c074a12ea9mr50089361cf.60.1758307834048;
        Fri, 19 Sep 2025 11:50:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e07947sm14292821fa.12.2025.09.19.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:50:32 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:50:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v16 00/10] drm/msm/dpu: Support quad pipe with
 dual-interface
Message-ID: <ibmp5mztq6ykktbtbhhxwvejwtaznr3m32u2t7xz3ujo5akkc3@gvdzchiu47hd>
References: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
 <lkpcsed5wkyztbysmiks5xk3ojr3dw74ef65cpoycclxjmbnsp@5adctm46fc3z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lkpcsed5wkyztbysmiks5xk3ojr3dw74ef65cpoycclxjmbnsp@5adctm46fc3z>
X-Proofpoint-GUID: nUI9pfX5LK0uZxbISoDdKvOVykyoJpGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8VjzPqLGUTVI
 OBxYH/gICP9Y3Qxy0MX0DJ5zWvQ7gdoYPf/CR1PAQkKXR6fHz9KEC08HvdnFOABWGg5UT6a3fDV
 EDzTNVDH0XdS4ViK6866NxhzWY2J+dxTVzoaT4G0pU2avQOMsWCOlxlyToRwdP5OucXYTfVFdmH
 j+5JxFNxLn8BoeUF/0AHb0GDvRyjQoOuUk9/sYT4skF3wuwDPAgATfi0p8lDr6VlhYZFwP/Ky14
 rzCgc2oUkC3PpvXC1OPFNX5VELOKLUfKDsVMtKljOuFg/F0WWOJNR/8D+i2NJgysD76P1WJIDJg
 eEwmKavW9m3PFgKyXXt/gH+WQ3ELAlMJcBSj+7VR0lBW7z1XX4q1RjcnihSUBy4LoeFA0g5V2Ai
 G6At5sC/
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cda5fc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8
 a=TzENwY7SnjuQWjFngvoA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: nUI9pfX5LK0uZxbISoDdKvOVykyoJpGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On Fri, Sep 19, 2025 at 03:41:56AM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 18, 2025 at 09:28:52PM +0800, Jun Nie wrote:
> > 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> > And 4 DSC are preferred for power optimal in this case due to width
> > limitation of SSPP and MDP clock rate constrain. This patch set
> > extends number of pipes to 4 and revise related mixer blending logic
> > to support quad pipe. All these changes depends on the virtual plane
> > feature to split a super wide drm plane horizontally into 2 or more sub
> > clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> > whole drm plane.
> > 
> > The first pipe pair co-work with the first mixer pair to cover the left
> > half of screen and 2nd pair of pipes and mixers are for the right half
> > of screen. If a plane is only for the right half of screen, only one
> > or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
> > assinged for invalid pipe.
> > 
> > For those panel that does not require quad-pipe, only 1 or 2 pipes in
> > the 1st pipe pair will be used. There is no concept of right half of
> > screen.
> > 
> > For legacy non virtual plane mode, the first 1 or 2 pipes are used for
> > the single SSPP and its multi-rect mode.
> >     
> >     Changes in v16:
> >     - Rebase to latest branch msm-next-lumag.
> >     - Fix IGT test failures.
> >     - Drop patches that have been merged.
> >     - Link to v15: https://lore.kernel.org/r/20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org
> 
> Thanks. It's too invasive and too late for 6.18, but I've started the
> test run at https://gitlab.freedesktop.org/drm/msm/-/merge_requests/191

JFYI: this has passed the IGT testing, so it will be picked up soon
after 6.18-rc1.

-- 
With best wishes
Dmitry

