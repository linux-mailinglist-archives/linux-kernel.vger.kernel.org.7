Return-Path: <linux-kernel+bounces-803402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2DBB45F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EB217518B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968B309EE3;
	Fri,  5 Sep 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mb7+sxRH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFC218ACA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091087; cv=none; b=a+WYV9ZViE5rYXAKgeC4cYGS40PqgiOYX5U7phIb6SxLeyiSoz5LGFDFyjOjDaN01oZxCHVZIsfH10RTiyEo614qiv3nWzecPVaTVSBOacp5ZDnT72UqGixJH5fzvT5HqB27/yHDa5Hs+Zi+DH8mYTdxqtALAzhhrZzJgQHHoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091087; c=relaxed/simple;
	bh=IZ3lb4U/LoqXWSGcvX+7jXfGU/h7GlhNS7B0l768+Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHOOoTUicGy/4wzQ3YtNY+TU8FjxB7eO/rMQ1hPi24LkLQ7yK4KGqrLRsuy1DfW5SN4dAZTJ6ugOU7BjCd/6VK/JQQgB+mbT2Uq0/ucldsH04SlgchUTuYubrTJvSkrZ6b0kJVg/EANOja+0+JgpNvXMsjocN6KvhTk2sFZuwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mb7+sxRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585G9aXx031836
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4xa3n6NDrhRLnjmOPl5k/ZnS
	t/9I4YsaolOfWnhteaA=; b=mb7+sxRHRVew2env8Xw4AqGvdnL5/GQLdGPSqiyW
	MBaqxEzr8eNxsKOmePzhiRkj3R/RwFAy4a4xJ5yjsrfwhR/cbZrRKbOIZ+JgczRW
	QLc61xaTN8I7Tiu4MtH8n/tS4mzMUWeT3dhyeQp9MDCoSfnrHzSpfCN6Rdg2NYz9
	io7YIYfJ+EfNsnArKMcehxFC5UH9u3mhryI6Q+A71f+6wFSKswxUorwE37MixNp7
	1MPpkAdR0YgJ15Todig6xXjGdTp0GBUxeFMhkJ0+9vfnhhfzpnrxBVfWS9umeHLL
	UmHY8AiVMS2/T5Ie76Hn6lDfmmqbdVMXX4t4pKwqZd5wHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0bxkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:51:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b339e7d107so60840821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091084; x=1757695884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xa3n6NDrhRLnjmOPl5k/ZnSt/9I4YsaolOfWnhteaA=;
        b=LIxl9D3qGBB9J5Np4FWvGt/LnMEJcFTOwfAfC8eM5mG/SkTjGCBeyfTdENtIcB5Wtq
         ii5HDEtNQqPADwkMJtW1O1wCJ/9kkWTUwRSJ1C1itKwk8K5PpwWid9drao1d694XMzOV
         xjBL2HFjk8+ttxlMGDfCx+w/iUyA4pztBNnj1rM2f0ljcMdgOJCvJ6938ttnmcxSeEU4
         BdmApPwxFH4gRLCcL5kQSaCZTIlO+h9nyMxWb2pqsqGkvkFg0EiMD4CHoDy+tjmLA1+k
         w7idub2B99NYNCg44XoV39RHTOPrZ9Ca6coWpmVp9hD91MC2EbBDvf6heLLiAMfdZYfm
         nt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5geqOj6Y/qpnh11hO2hAQUqtF4tzpRanzYyJh8RdEM6/Z/z2ogDcqFCOmpzoiKtgXSmiC2xQWACUN9Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoZHOxbhngieZgTvLh+FBLbMytIOhkeGeYyO2CNa206LG4Hai
	YXXjkcGk7nOIvdABAdCaimpUWfXvEhgCVL8gx7bfOB6F/O0dF+ln4DEfJCL5D3KSvE4bPwab0ev
	cPTUCsIsdZ/0SXOdxkIUKrbRUPADIvFuD9Hl1+IUq/ynEjzmY2QFKRsgFLAxh8JbzJzk=
X-Gm-Gg: ASbGnctw82RFwTYlLPLPLt+HcwCpN41rHXB5blic2qyPGC2vOzg4Wj41phJsWhDxYTz
	PhfELIMeyaz7npj7TjIDwgJGAFhS9eW3lhrxdQDVoZMrty9kOT9XZqBGnhYFIGJpCMlSH4gllkh
	nlXef6sVT7f3PAaCoaEB4r3g40vqSc7u+Qr+8KEQz7NI8lk+Zc8knzkqu36xrr9CUgniOJE6IUj
	raYdfAOgbb2Yb8mVDKarsYuaxDSimN2duQKGfKv+Nlzb1SJCVrTlzw7QT1YS8jGGBSuQ5AYyNM0
	KIQbro20I3PzXG+7SHuNuIH1SFPyvpzuzCgVJShUC+BrIF4CEe9wkAdbrfbmJDZ8pMTB7GgJcPe
	mX8gySoDrwqifdTV+9OQPqQDwSFZpURk1IY2xX0U7BzuRpuG8hUu/
X-Received: by 2002:a05:622a:11c3:b0:4b5:e647:fa06 with SMTP id d75a77b69052e-4b5e6480197mr64077461cf.31.1757091083919;
        Fri, 05 Sep 2025 09:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9NXJNecwnP4ZBhUrbIp/AeRbWzoPY4rSQxPE1jmL8jey4gjRk14sba2Sc9yFWCYAmMMTGg==
X-Received: by 2002:a05:622a:11c3:b0:4b5:e647:fa06 with SMTP id d75a77b69052e-4b5e6480197mr64077041cf.31.1757091083297;
        Fri, 05 Sep 2025 09:51:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c4ed3csm19832831fa.4.2025.09.05.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:51:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:51:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
Message-ID: <bmbu6dfhr4i37fxlqo7ltalkzz6bocb5whuv34x437k3crie5j@ndtqjrv64n5j>
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
 <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr>
X-Proofpoint-GUID: o0ljQnp7WOQF0RWMehJFCeXdFvz4q48G
X-Proofpoint-ORIG-GUID: o0ljQnp7WOQF0RWMehJFCeXdFvz4q48G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX3hLfFf/uINOU
 a9FcLlg1PV8FVgEP2pY7a3t6r1nFd2c+eC2jYQ869/cAvoie/cG+ocrhykCfoHvD0tFg3FWkfwy
 ufKWAGFh5M82mRYERRtvWism+20fuTfx8M6gHQJYexx+oapMdqIjL97XXqhssvpk/KN2T5VYUvC
 XSkCXy+PwqHuLXAM0pnNIclUBj3mrjTGN2RkAeFqHkn305hUoWw7b2+TPcO/6Wh1tC5UZE9XhKs
 oX0jd3mTRjW8ZD8mTGNGx5sQD1OdGBmjUPx8NfS7KgZp+pR19ApKHCAQE3XoKKV6BSaIdHoCg/4
 +lLeZikRYaPstTwNTjPts9Alibq82E2K7RNrYK6rrS7Nb5ZSrSqI+WqJ0cKdUFLgEc2X9S5IH85
 znjslq+g
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bb150d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=j_c-LHFTLc-8uPKrwYUA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Fri, Aug 15, 2025 at 06:11:57PM +0300, Dmitry Baryshkov wrote:
> On Sat, Jul 05, 2025 at 01:05:13PM +0300, Dmitry Baryshkov wrote:
> > Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> > registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> > now.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > This is a part of the HDMI CEC rework, posting separately to let it be
> > tested by the maintainers.
> > ---
> > Changes in v7:
> > - Dropped all applied patches, keeping just VC4
> > - Link to v6: https://lore.kernel.org/r/20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com
> > 
> 
> Can I please get Tested-by for this patch? It has been R-B'ed, but I
> totally don't think it should be applied without testing on the actual
> hardware...

And another ping to get it tested by...

-- 
With best wishes
Dmitry

