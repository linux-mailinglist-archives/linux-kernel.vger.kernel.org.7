Return-Path: <linux-kernel+bounces-874742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A301DC17000
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66DD1A202E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C235505C;
	Tue, 28 Oct 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nyzmT0E2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="St60gymg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CBB351FB0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686647; cv=none; b=NY93ZaPAHbcbw4C4ijm3pD50Ofjy2ua+ehnNasDgMBGvdrVkuQTyHqoaqfDXMYx7O483Zcq7/9Z7boIOyvgnDFNVxXeRp/OimnERcceaOjWvH2D5aGAaGKKxjxXf2TG9w7Pfyv2tEGK6/b2wksz53mE46xqe5qLZf3YmIQ9E13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686647; c=relaxed/simple;
	bh=4n3A9q1y6Wg4cwx6UGPOep2eOOOce3iW1xgLNMubNV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPfmkvaT1+enarAImOfUqRhIPP7WzoIWGv1mDBFbDd7B5RbRxKBFc58hyOLh8H3vTYeTTXAq3lU8IXRa843HL+TK87+DO5TaJPKll0erzvA3s30GDJQzmRNY00fDdgA1xRD9xWTBYkclBmXYQVIKgUqcBpXcg3FKTP+3TESOGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nyzmT0E2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=St60gymg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJr0Pv2511405
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ABfUVFah1hyptug17CT9PCLT
	6YKSwLKR44p2mhENPxY=; b=nyzmT0E2zUZcOTuJNcY9dPI/G0QV6X+vN1PlNWiS
	hEVln05paPS+i65KuvyPhRfjRYAXkmg5L+mRskypLVCLxmlfnKa2dchwJ1r48hA7
	hY+9nSiKsVIZASoObXecgJwnPFB5SUAItW5KKwAxH4MfAHcoI5NVo/3yVZWwX+VS
	XmgE9Bp+nONz+qTjmBmDwzsILtzFTckjj6G00vgWY1/edOhuV4+Tj2ZaNvX2Ixdm
	H6GDFfMCkfBhy/6OiB1fBT6IB68cqMKVfQpRSB9pGaolPpWgaTJ6GhLvM7k94XEj
	WjXXYFqWKkMs4GqYZEITm5Iis2f6GTVfVC7C82Vzxd6JhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34cd86pb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e899262975so202261161cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686644; x=1762291444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABfUVFah1hyptug17CT9PCLT6YKSwLKR44p2mhENPxY=;
        b=St60gymgZGulAeqnPHReeP96ElbrVHz7SumhurCMPlcyy8nd1A9Z3AdxZcn8I2yTCh
         SkP7a2ByYef0+lOnVxzPmGIJbRfsNnmu6HSLDoFU4P4Hk06cF1kV94t/hVdrAtYZTgD9
         5xVtS8SpiXG3FELhIhudCO7KYATzN09e8iV5ZgbmgWUX9noeg0H49rUlL80Fs+ITkuXZ
         9ow5i4MVOGngQsszKHouyTFZK0a8/m6Xrg2NLceTY7vRqRagAr8QSkVyGWnnKutuAf5C
         LgGILdDHUwNu279QADuojtLxADMIojIjGnDzT8yaJpyVjxzX0r4EnRJ2rxG/Jona6R+0
         swNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686644; x=1762291444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABfUVFah1hyptug17CT9PCLT6YKSwLKR44p2mhENPxY=;
        b=eS/PZqsXj7+nLBcsruheY9Nfj86+vnzPxErkJ1SbpKnrZzhl4nKNK7PnBugr+efAWT
         C1OaDV4G++eQ32tmeKBdrlwYx2zqtEGiUug9m9LbSW86YuhSIwuyGQ5luqri6I5X5RpY
         GvkA5NNckzoKxFHYb5x+AtVQ008/fFp1aT1nz1/mpp0jv6lh4s+3D4pW9iU6wcbv8le2
         OOOhk8pjnZHMbeib0meki1bBU4RVkPGafba544bCCveIVu0ntcsG4/511BCjALcuwf3D
         qbJ49fG8btF/s0V5w5Xba62t2F/9fUt87Q2d4H5oD2S2z3Qm9bg0USeXa8LYRm1mxtPz
         Mt5w==
X-Forwarded-Encrypted: i=1; AJvYcCVdrj8udVr5igF/i7Hp8HSG0+RhNWQrkxNjwQ+EFux5N6qq7XXWctIYTH8zsgdwVE93qtwk1ew4GAILmG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BK33ewHIanRqgoijtEDV7cpqj8XE0EeIYvU2RxC18O5twc6s
	sC9Fg1o5fdnpL8rQG5Q58yt21BQ1ljUFvG+HHcxF+EnBVuZr5llFcFNu6MEH1dSbgdHuFjpa8Sb
	Tvba7XgMET+5u9CLt2AHfRg0CkznuEcqfBfBfnUbWcEYKjsV7h7W8wEJIBw7YVeU4RYU=
X-Gm-Gg: ASbGncuyZ2SXrJzXnbacmiQbIUrU553nV9btVkfxzDZ5TdgFKlK3EQmMwZWxDFrcW7u
	lAz7DHV/jqD1L+8vR4tMN7X/cDAJKWaPI/eagoI2PmYxez/I8IBBMht65PYzvWEnETnZ9XgO0zJ
	du9nvxCnepXwmU7ptaVzQsA50cd+4GQeGvPY+YVVZ0SW08NVR+Ge0njSwAojsPY/G7OzVYDR+u5
	tdWU1jvPKFwnuooK89CHxBG6QAHUqanRglOH5vjjzooi0xUCT/4FlbuSiE6YPhtQIeQWKxwukai
	r4LT8NpsgEIej2oCzCn7+Fsd6AfUh8ak9mPz3HDBfA/UPI0I+nhEehIN4uRyIGMRmdMAp9ugUHB
	S177uyDiV4qvm4FRcw7yqN1zGgjeYWaJo+WI7Jp+HwdDXkz9bQtGUy9wyomiyEjqEb0qsrq/MVm
	hukPgtEdJb3BSq
X-Received: by 2002:a05:622a:1c11:b0:4ec:fb62:fcc5 with SMTP id d75a77b69052e-4ed15c04a96mr10327031cf.49.1761686644170;
        Tue, 28 Oct 2025 14:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBhHm7sDSm0SNn4923M5bA+i3GKL7HcAL70JWJZ8fxnsCfd+ylfQkS7TGD0NAfopfgQklzAA==
X-Received: by 2002:a05:622a:1c11:b0:4ec:fb62:fcc5 with SMTP id d75a77b69052e-4ed15c04a96mr10326691cf.49.1761686643711;
        Tue, 28 Oct 2025 14:24:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59303ec8b95sm2955835e87.98.2025.10.28.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:24:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:24:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/msm/dpu: Fix allocation of RGB SSPPs without
 scaling
Message-ID: <5ijdhvmmqgt3xdfajgumv46ifsgnt7h4amtrbfoklcl5do4xjz@ks4ufzfzpyij>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251017-b4-dpu-fixes-v1-1-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-dpu-fixes-v1-1-40ce5993eeb6@gmail.com>
X-Proofpoint-ORIG-GUID: l7Z5du6Hbw93NavzHS0jGv-ysIaUg8S8
X-Proofpoint-GUID: l7Z5du6Hbw93NavzHS0jGv-ysIaUg8S8
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=69013474 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=sCrT992wuxv5weLG16oA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX8UXe3EonavHm
 6T334S9jXLqmJo9omFwTuc/Ypz98wNM5jUMoeXffIWmg6slnExQOQsQAQUNqRk30IjKjoDmq15o
 u8yObQ8vFB+1cQB2SnPx3HOQZ0v82Y6vgpke/OLQKJovCmfn5wKVxcICQ2jzgIHuqbmgXxfCKJB
 XfPdKhUtggNkQSox/Hfyg/8g4xilEo0uFTkUAaV9h+DhhiDedBhOxr8riMFuxN27Ojz7/pwxyzF
 X2uabupRRAV/timZ51rRR4NSuGMOIzn2AnQpgYAAy8pN/3i0l389Rix+GkfKEoETS1mdPMu4mEP
 hycklFfo4va8smAYSDr99Q5maI15we2nhtq7cu0FvdIL8PN4ilG2y3ea6ouGvJusHOY/YtBBNOq
 MwVs6kGSTH6EYIMm120v8+fnM/caNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280180

On Fri, Oct 17, 2025 at 07:58:35PM +0000, Vladimir Lypak wrote:
> Due to condition in dpu_rm_reserve_sspp, RGB SSPPs are only tried when
> scaling is requested, which prevents those SSPPs from being reserved if
> we don't need scaling at all. Instead we should check if YUV support is
> requested, since scaling on RGB SSPPs is optional and is not implemented
> in driver yet.
> 
> Fixes: 774bcfb73176 ("drm/msm/dpu: add support for virtual planes")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

