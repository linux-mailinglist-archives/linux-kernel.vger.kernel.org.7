Return-Path: <linux-kernel+bounces-591345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E901CA7DE8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D3188AB78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427262505A7;
	Mon,  7 Apr 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6DAHguz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B620E6FB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031350; cv=none; b=cgtMDJkfD9oZcvOWfEhz74YVx4rYwzfkGmoc8msv/QC5AqiK2dNM8bWIpb5ce0ZW/6C9tjpdxyg9jBzA+FKCulNMaV9KhGqsHOv7KFxVUF7/7hw5LWQOU7Si1W9h6KyHuY62hljNMTYqasuJ1Vc1pbYoWQFeHzBetqw7zlLox98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031350; c=relaxed/simple;
	bh=xXCuFVww/NlUudV8SgwoqY3CZ2vPEw38inrW5lB3lLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DgB9vbyqTm9HYNAfU42Jp96JahbZU1EfrXHFtsAsxK+YTceVlMLdQ85ZRaJbMrO3APZklcZbYQZ5gIBMXvuryDz+L4kiLOpa83UdzUNU0yFl/oa9Ihld4QSISQLjpDWEl+BNZ+bpmLIn/4UbV8QttTJSXvH+seE5Fa0OKNVoYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6DAHguz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dk2P028069
	for <linux-kernel@vger.kernel.org>; Mon, 7 Apr 2025 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hAFJIGd25SE14xpwa+KhUSRa80h97UsYN+TeQKpPB9k=; b=g6DAHguz4Gq0/Frx
	Mz1CwKecDhKrpZn6+rg4Xq9oRH/S3CdY2l1ELTu0/ex2PkqC5IVXTsPYh6klLHKi
	YRv0W1ToJBAz5/8kpaS6Rm+ifSI3Wam8NA+Lmk3bxNoAfgKpXmu62++ZFJLXghTV
	K4Dp3tCgQrD5ImfBLRQ95hV2s9KuRbHu6K0VaJ2ZYv3nXRfrutNn99fZ+V4L0z+P
	B2BpE8Dq3X1a5OvaiDlllrN6/8zaXXJguUOEYkficfhZ7SzVfCYyMCGcLk59+ZPa
	i3jpvWBoQa8k/h2x+53IsY8jj9U0GK++z/pfqIRA1UVmnS8ZzzyJnn00Uv7UbW44
	GyOBDA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyvap2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 13:09:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5c9abdbd3so419832485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 06:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744031347; x=1744636147;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAFJIGd25SE14xpwa+KhUSRa80h97UsYN+TeQKpPB9k=;
        b=kXFTDA5a9BIPLnN0GLz+seU2GMBwZ6pp+hFBRVRw6uifC3HhFXbaPLLFjlirK3/kXH
         kPP5vMrf8Py45KDezlTRTB//acKoIjhfznUU+cIPhFBgFZd/dwL/oqa21xvU7KiB8jNi
         S3HOZsi4dfk41djMz95/w2d5W40LO6bxIVR41xS+K6fqpnoINf8EL7NjEPYTCjEBqgAk
         vSKRPhlfzVZsq8GqcU0+LHwQ0D/crh8Vr61m0K+Oi+A/gUGkIZsvezU9n8LWCLSF9JcE
         N+UW1Za7AZZPBblm22a9mZHspHbB1NHjY6Cb80428en9fss/nMg/xeGN4Y7GggVIX8XB
         21Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6kBgEQbtpTr4FBIayXD0imkpAMOmFuwarjnLJ/I82/VFRT6wl8BmKIxS3vNUP2lHYY0RwdIqXLcHeGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXTgQ+6Gaz7R8qqNm1beO7BRUJhq/Iq2bxFx3pRImuaCE3rqA
	8gReL18SlPiEnp03ppdOclYSDDE1XvEEYbEF7Mk9nb0ak/QYSAwoNpAhz+/QEDt7u0ZVLB8ynHH
	Yk0EMOpohl9x2tgBiIZU6f2tdBzzrHc7gE6mG+l2tSEiq4r3UbEwtElYaMALMUck=
X-Gm-Gg: ASbGnct6ODoOXIe8gFoROOftLTxBmfWctsF+zypeqxJ2XWmHvQiIvU5bnAMgJtHp83Z
	mL4VBYYSQvM85vBTluAeN2L8IdKKu0RGzSEH1trKkL9JafdhQoM9UjAeVJP/Y1YtrQdUelSJjql
	QW5Uq5MZZmlywln/BReZavcQiW8Zvh0uKY4W8vjyJEVAcPzSqZ5FMHrbz4+vGG9ZC2CYWi2j/ib
	PqscCB+whwkJifg+cRu3ISW5KF0GKRtnIaSvTrTDpg+qJa47rfXjU+jWRujrbmSF2LuFH7GLJ+i
	0yt+TMFL0zUXMnr5KGt42oJz2CfSjp7TVuaEoPwjoyCmHO+rg3TNUVWaoIQFPTy5306H/N1YXpz
	6jn0=
X-Received: by 2002:a05:620a:24ce:b0:7c5:e226:9da2 with SMTP id af79cd13be357-7c775ae9e54mr1621401985a.47.1744031346752;
        Mon, 07 Apr 2025 06:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe7KohhBIGgD1fDaoNscLqxmlrmjcjcccMAiZ1cn7+YLrzEZrX0CHRA3Rk601QkVQkjPsAvA==
X-Received: by 2002:a05:620a:24ce:b0:7c5:e226:9da2 with SMTP id af79cd13be357-7c775ae9e54mr1621397985a.47.1744031346391;
        Mon, 07 Apr 2025 06:09:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e67141csm1293819e87.224.2025.04.07.06.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:09:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Hermes Wu <Hermes.wu@ite.com.tw>, Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <lumag@kernel.org>
In-Reply-To: <20250314-dp-hdmi-audio-v6-0-dbd228fa73d7@oss.qualcomm.com>
References: <20250314-dp-hdmi-audio-v6-0-dbd228fa73d7@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/4] drm/bridge: reuse DRM HDMI Audio
 helpers for DisplayPort bridges
Message-Id: <174403134393.3385678.13559826981567818455.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 16:09:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: G3jpNM3LT4zm75NyJm60dSWv2Uj1abmJ
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f3ce73 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=5uxiH3rk7msUY6mfsOcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: G3jpNM3LT4zm75NyJm60dSWv2Uj1abmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070092

On Fri, 14 Mar 2025 11:36:47 +0200, Dmitry Baryshkov wrote:
> A lot of DisplayPort bridges use HDMI Codec in order to provide audio
> support. Present DRM HDMI Audio support has been written with the HDMI
> and in particular DRM HDMI Connector framework support, however those
> audio helpers can be easily reused for DisplayPort drivers too.
> 
> Patches by Hermes Wu that targeted implementing HDMI Audio support in
> the iTE IT6506 driver pointed out the necessity of allowing one to use
> generic audio helpers for DisplayPort drivers, as otherwise each driver
> has to manually (and correctly) implement the get_eld() and plugged_cb
> support.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/4] drm/bridge: split HDMI Audio from DRM_BRIDGE_OP_HDMI
      commit: 5d04b41889596adab613b0e2f27f76f6414cda66
[2/4] drm/bridge: add function interface for DisplayPort audio implementation
      commit: d87ecc232706ace682a900a45018d843f148da56
[3/4] drm/bridge-connector: hook DisplayPort audio support
      commit: 231adeda9f674ece664b09b75b68a4c023180fb4

Best regards,
-- 
With best wishes
Dmitry



