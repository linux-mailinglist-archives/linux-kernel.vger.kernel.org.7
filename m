Return-Path: <linux-kernel+bounces-796850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC72B40847
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305DB5E6CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52E3126D1;
	Tue,  2 Sep 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eu3j3OhN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4A27B330
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825037; cv=none; b=gO6DAvNRDN3OlJ4mPHc7hriJmDoP6o7FeAbWHkLa4X2JNH6xlRHvHUiOMux3VTMRmQcPYojJ31DQvZoSJ7ZVUtWN+oVrS//UcvukoG716NOzk6bv5PiizOSk+jVLcarhzXxuUUEHmZ2WtxaQpIJfLhA3oxJ+0nfijMkGxckVj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825037; c=relaxed/simple;
	bh=NtBGlMRAqA+UkZeDcrg4wYdlDrWg/u//wUHsrC5a6JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCv4QyywoLGPEuWfrRF/YkjZMcCAJIRUNEFXyo1HvskwjZdW8Cgob4NIpjiS29MuXN3sXxQWoScSDjKHHzKegZQ3fZBdggrq6aPx6Sa8i0NWf1OS2poXL1ZkHKDh/mZIGywtbC0zquCFtha6NHaC84YSUtow7L6SmpESRamiank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eu3j3OhN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCku025298
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TsmfkgMBnp9SJQN3L5y7Bh9L
	sMiuyaGhK5Ns/kSaNZc=; b=eu3j3OhN8NE52GVbTnYhN5bolGpchquaY6Oo8k/l
	ZIq1js7kPg4ehpJhc5KyjfsJFAH4PuF77ImvKVVyLchpgfZVrYhzELTaL3Z9voCb
	omQZTL90PlEPBphxQuuykkCUPnLUzlNvsjDl5vSrGvOVrnwZMkmMk/5QU6a2iggr
	O/SzQYmNFf7PoYqZaaVSCk6DFHVh2V0r+iG6vvAfQ1Tq3KW/sCIrEe3hU5UTWcuL
	obseSgjLOqRVhF5dHpbiQuqVGnqB/No/IgASByuaos+JmEB5Ygs56lGJtSKKqoKB
	4uCxCvZP7OT+Ir/3FozajGUA06obmmqQ2nmw3djLIVI/5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv085e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:57:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32d323297so47140591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825033; x=1757429833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsmfkgMBnp9SJQN3L5y7Bh9LsMiuyaGhK5Ns/kSaNZc=;
        b=tBR/vOch05Z9qLfeZ5KhdTwgw2T4KV+1WC6fHVg6Zd+KVHcYtc8h97WubWvj0y/6Q2
         yfTUhDgjxk+LHuOyA80sxrbzoV+xqjrQh1QbvncPH2jVt5YRYuts6nH6H0nI2dyimW2E
         UOW1bEEVbYQ14QbwUK5fpxElNhdQCX1oeHeHVB6OPjRwtQRZiCssT5FCpbkj5i9wd4ZW
         N3aF1sk2Uxw2lxlDhXuWCUdFGvfKttCfeETk31K00QBZ5wAM2FmlHHDDS27ue4tIeEp+
         ShsN1tJ1nKn23ktBbbjfCpe5rSOBw0FbTtIJb1M5QDBWjzKYAIL6M1vRycfT0WvoOc7I
         vmWw==
X-Forwarded-Encrypted: i=1; AJvYcCVb9B/snp9vFe40v7Wez5O9cYVhJWJKtydnmPexFvvgy1l6UigfBW4gj8+rIpHYG5FMcR7tSZSBDT4vCqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+pFZHdj3k4FH7KUYmT6X2thFzNz2VQ9PcrBzz2wqSyumzDTM
	yLePsUlloCb1eWEmroHyN6yqDIiJ7rN6h+lmHHS3M34oi6vU0CQtJWdweooc96+SfKs0sHDGm80
	pAporpL0DIrzL5UDfKPikZShNFkaDa4T82CRT34g1lphao3+nBBppu67kCQoiYefcA8c=
X-Gm-Gg: ASbGnct10cLahqenVgquIXjVkbprXvK74Xe4j7wZrpv0ue1vBie8vnSWaLxU0dTdhXI
	+upNsDQ8WW7iyaeaVV7tfNHXARzpaKJzZVnZi9Y5xEp4REA2KTIcJejqfs4z9JYAtG7+ncmYooh
	0+XUW6cVwSdIn2q5cyrAXO+RU31ktzirVAlLJSeP6w1I7Dx8JFGhiF3NrIagCrZy/uKB6sGMthI
	PCAkLXkQq+TAoFFnHO3znoN6J0JEtubgf9MKFgTP3xvqyCklnkLbYDbYxKyR5Z3jid6nTNh4KSB
	AMvgHudL3MSWtn/Z63uTGKcBjbIAB6aJ/WQ1zt4ninObrCRBLSIH4/KRQ0TL3eiOrUni9oJgDDy
	YJnBYkFgHH3FOrab2U23OFVFow/vk8VHz6TpPdSXkowQUIGtC5i0y
X-Received: by 2002:a05:622a:1103:b0:4b3:9f3:8f86 with SMTP id d75a77b69052e-4b31da25423mr131231391cf.43.1756825033240;
        Tue, 02 Sep 2025 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZq3/yRV8lo2PEycPVb24whKPiXTRJq33EprBVrpg4tMMnhbq/xhljHZVKKCnnnAke8vRMXw==
X-Received: by 2002:a05:622a:1103:b0:4b3:9f3:8f86 with SMTP id d75a77b69052e-4b31da25423mr131230811cf.43.1756825032575;
        Tue, 02 Sep 2025 07:57:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827b3ac5sm751954e87.147.2025.09.02.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:57:11 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:57:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 00/13] drm/msm/dpu: Support quad pipe with
 dual-interface
Message-ID: <53z5v73r4ixmecpo6z3a6rnsmkgjjftbrwke24bf7mkr5ffh64@2viglv4lnows>
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX92UroDCtslQ7
 dcmMTvPXSiYTZb++9HgNxTb5byFxE7t3LZrmzYiW8kXecDf+zQp7aJMKarcULTIvxGIWif4Mjga
 9dI0qdWjizI8NOqr2sfNKhjuBEmx8hSjvNTkwWRi0KX1Tn3rZ6mXIx+8ei8Y+7z3Pnajr0jOLfK
 h5lIr3n/gl/rgXhKth784euc0x0u8XefMqikhu5LVGbkVDIXEm995JbIHSuvyI7KfQXqS981T1v
 f1ZZ52RLr5i1vodv3jQz+JmOMdU16QzQm3whl9dFyzh8hiC+TZj2kcnBWGK1xrcYkZibAHr5ndK
 YiTBXZ2gohoFVA+qZKQM2W6zaIlMDTcakB9Q4qzzQ1CLWlTK02x42Ro5TxbYBuDHT0XLmxl0gCI
 4ywoiFWl
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b705ca cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8
 a=NuLzGU6fH5aT33uQb0QA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: 3363SnJLukoNdBaIysCWl80WNyjJ1vuN
X-Proofpoint-GUID: 3363SnJLukoNdBaIysCWl80WNyjJ1vuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On Tue, Aug 19, 2025 at 09:30:54AM +0800, Jun Nie wrote:
> 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> And 4 DSC are preferred for power optimal in this case due to width
> limitation of SSPP and MDP clock rate constrain. This patch set
> extends number of pipes to 4 and revise related mixer blending logic
> to support quad pipe. All these changes depends on the virtual plane
> feature to split a super wide drm plane horizontally into 2 or more sub
> clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> whole drm plane.
> 
> The first pipe pair co-work with the first mixer pair to cover the left
> half of screen and 2nd pair of pipes and mixers are for the right half
> of screen. If a plane is only for the right half of screen, only one
> or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
> assinged for invalid pipe.
> 
> For those panel that does not require quad-pipe, only 1 or 2 pipes in
> the 1st pipe pair will be used. There is no concept of right half of
> screen.
> 
> For legacy non virtual plane mode, the first 1 or 2 pipes are used for
> the single SSPP and its multi-rect mode.
> 
> Changes in v15:
> - Polish logic in sspp check and assignment.
> - Link to v14: https://lore.kernel.org/r/20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org

I tried picking up these patches into the msm-next-lumag, however they
seem to trigger a lot of IGT test failures. See [1]. Could you please
take a look at those failures? Note, virtual planes are still disabled
by default.

[1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1502582


-- 
With best wishes
Dmitry

