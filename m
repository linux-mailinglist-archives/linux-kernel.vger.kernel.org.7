Return-Path: <linux-kernel+bounces-838098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5250BAE6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC6C3C4F97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0228643B;
	Tue, 30 Sep 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvqfauCo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05ED285CA7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260053; cv=none; b=Tsq/oGP0t+YzWQUEZ1kV9U78dQW9D3zTvlJkvCJpCwbLy9jOKTdp7kWlFs+bNrlTn1eL1lPhAvUWrf/7btcRhA3FAd4cx0kAA6VPjw8i+4glQkhibSztYigqsIarQlQfiet+kj2n11v7NdbHofm73zyjCO6/sd5+FkXwz3Z4xjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260053; c=relaxed/simple;
	bh=4tUw/b7NIJ5cITKTzV2ZIfg9qQkiXrTbCT2hGU5nEvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZoY5wpm7ITzBiX+JejmS+kB08zFCNkSKUACPvrFIjDLnMkAGLyUWlsPzbaUyXN2Md6wH8KH4ToHdFyNLmpsD8eSTh2dVnZkXyCK2w2qfkjJehh/xchF3C9TYC+I/DhYBZ3++AXydij22CXZD0HgaDojdey2X6ab/s9Y+QsdJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvqfauCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UC3AOM027827
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KVXK3wyj4xgxBO/QQE/5ijkihmvihUgMziMTP7OJVrk=; b=QvqfauCoLCsFHunX
	BW86ook4l0mDvdjjOiDOGqcsZnMBR0QjXPr5w0Fh1ir4MAaYUxNmE6N3CorKuHcS
	QKTAtV50kLvUayA/gTgxQnrycTPzg4KvRmimnmFUCiVKhAEQxjHx4tdZxfvES3RG
	oTFF1PIpdIK82Q9Z7I+5YFb272irfvWvirWb4OkSI+9/Ldi9J8ogcHCM3H6mbGyw
	K1vSOcf++D5HqneStj8qqQlRJKQLOQ18NF3asMJW1gRAIbj9R/P8vwxt2OBXCsX2
	UTiu3mKqXDwbiLQ+13xAqQqmcQTt/j7yeCJvE5wF2yAzDnBMZ6uXPiee71XLOU3w
	7VoiXQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf3sm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:20:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df22892603so89457821cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260049; x=1759864849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVXK3wyj4xgxBO/QQE/5ijkihmvihUgMziMTP7OJVrk=;
        b=L04tgoKC2A0GbJpSqKMqm1prjeRHeRXKnHDo0fJSqS7QvLghcz2qid8Ph5AAnxDGqS
         zoOh4pFcDO9O72cKhePfuXj72yDakfpL9LgdHU10Gb3pFIqTgnsh+34mXBLkObbrZy9a
         6GX49qoMiz2YyhlicpUgdiDB0aL9odP4JhoFxW3I0DlRGurpnVhlJb4dQXnCdZWs2ynP
         TZYFJ71Q4hZeoR1L1nPCCTgHeOjB9nfMGzmmo2Q/rKOLVIDKf15soIqBoEfydHefpptc
         sTNnFbIdOgHtgFLPF5D5gRW7b87MwPLwav+VAMzJDL9TZiE1rTPLd7AmSL1l3Z/pMfP4
         My6w==
X-Forwarded-Encrypted: i=1; AJvYcCXEJTDRPg4Yi5KZepSYHjJpfhjpSC9HZtLDexDuFTsB68CUpZtWVO6cfoQA1cH1v4VTJ/eGQRq0O+IfcUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpPShldUdPkz24vdn/NX490o0Q5lb+UIqklB8OnXketziDgfB
	JUiYfuKy5489Nm7moayWcx57gWIpSweGVPd/BdZxKIH+j2GHcqGlKiZxRBnRfrd0UojTrfXd2O3
	YhxnV6aC+gF6BW9N295hSOUggNt/Yzh3lBfxVKfGrJ7JG1xfRb4Cnr2iTp/2CKK+ciQA=
X-Gm-Gg: ASbGncvLPZVZXJJALUPUUs75CSD4iLNk9NiMDOnPT5ke/UyOHLjzzL4qM6yMVQgsXQg
	WsUXoD+c6q97HXMZnYArzo2g8hkq5XaRUqoVVI1KnN9Zp9MwMHv9VLWjnhrGs8LOkTp+3VsmoUR
	4AgqY2GBp8McVyZ/nqV3xmbjNoV0rxJOOT0yU3J3eNG3aniZTAUBkQLzrnb2f+Fodw2+pmwzpNG
	Nf82uBppuFplwtKQGawAdt7lyaGVzOM2GCEaccB5S0RUxp+96UiVwAU+nyTxMDShsM0/CT/n4M/
	28K5/9Z2O7daqsln5X3NY8KqpQHyIAWRrvNM/qJAzNzCjXeDapOx7389OZQOdtGo8wlqhaFHts0
	QZZCzGG00t5p3EDexL6IucFjrgK00YRPulnG/GM5VfSna0j+KFRtB9A3nyQ==
X-Received: by 2002:ac8:6906:0:b0:4d2:d413:1f3a with SMTP id d75a77b69052e-4e41e256b01mr10937121cf.64.1759260049469;
        Tue, 30 Sep 2025 12:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlv8GouDfLH9jxcZXz4sZ9qg6O7hSAY2xOrBu+sewtGI48yKBVhvRDPT2OTQMfLyqgcLMpDQ==
X-Received: by 2002:ac8:6906:0:b0:4d2:d413:1f3a with SMTP id d75a77b69052e-4e41e256b01mr10936801cf.64.1759260049035;
        Tue, 30 Sep 2025 12:20:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583134310bfsm5244156e87.26.2025.09.30.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:20:48 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:20:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
Subject: Re: [PATCH 03/17] drm/msm/adreno: Common-ize PIPE definitions
Message-ID: <ftbecn7dlcp6pqtpfl5v7kv2kevz5m4yqcy7fg3atkdjabkt67@zqwwostqqfou>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-3-73530b0700ed@oss.qualcomm.com>
 <xsgnpvswvkyuxiviv4uyb6pxbpi646fut6dy54kpyfisqrxycz@tyfox3zdi26e>
 <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV011=_szCPbdm6YA8aJjm76r_BZP9QFeOzcAGCvqUUTebg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: aqRJL8AoQ6SyxCfNyfjp0eBKRNtQQKWW
X-Proofpoint-GUID: aqRJL8AoQ6SyxCfNyfjp0eBKRNtQQKWW
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dc2d92 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IkzWstXsGuqL4x2q7pEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX+VZ5Fr83p7ph
 hOihpx0iUvLqKCRzS+SuPIm/4j0JhXS8SRKcZHYeIfi2sMcuKRMCgZ7Z4KfB4XG8MEK2vUu2BhL
 HL/V6xKSjxloFWo/shxrxEZ1CAgsr14Y9KOKH6Dv5/H/2FJFYDKmQLzDaRp4P17szIyBuYIEjgF
 c392H3JopU4T+F8pnshDumSvRv1EFcFv/cGfcempff38dUbJ9aN1h74s2eUAcnS7Ar74HvCOM72
 XxB+nxJShdwoJoVeL3DvaquSjAe2hxHN+jy4GRjPlljAdTMwzYjlIMBZVWOq+osteRYaRDzMjAt
 alAs6ssJIWeqX1GDaODRQ4IU+9k9nMYFiQy6ClYEiLYTHY1+vmygCeEFV0FkvfgxyjvCg5KhW3c
 NmACVuuKONwtQkZgzVSvqbNKXsh9mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Tue, Sep 30, 2025 at 12:25:55AM -0700, Rob Clark wrote:
> On Tue, Sep 30, 2025 at 12:05 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Sep 30, 2025 at 11:18:08AM +0530, Akhil P Oommen wrote:
> > > PIPE enum definitions are backward compatible. So move its definition
> > > to adreno_common.xml.
> >
> > What do you mean here by 'backward compatible'. Are they going to be
> > used on a6xx? a5xx? If not, then why do we need to move them?
> 
> Newer gen's introduce pipe enums which do not exist on older gens, but
> the numeric values do not conflict.  Ie. each gen is a superset of the
> previous.

I see.

With the updated commit message:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> BR,
> -R
> 
> > >
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  10 +-
> > >  .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  | 412 +++++++++---------
> > >  .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  | 324 +++++++--------
> > >  .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  | 462 ++++++++++-----------
> > >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   4 +-
> > >  .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |   7 -
> > >  .../gpu/drm/msm/registers/adreno/adreno_common.xml |  11 +
> > >  7 files changed, 617 insertions(+), 613 deletions(-)
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

