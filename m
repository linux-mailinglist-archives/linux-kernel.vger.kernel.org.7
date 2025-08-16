Return-Path: <linux-kernel+bounces-772101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394AB28EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536101C83099
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857B2F39BB;
	Sat, 16 Aug 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o49DVN3h"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A52E8888
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356828; cv=none; b=pV3UxttyqMxaZqkuvl5MaWC/HQOrTuoYRb4pkj/FZntSaS9Lvbnu5y0n9Tp2SPTPelVLPszPcNq93D6T32DdR2s361LnDOBsWi305Ap/4BJpsm73DnF8wrbRmvPAh0foP8JWwZ5xSC8X84TEqqUm3hXX3UTGoBy/fO8HqSODNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356828; c=relaxed/simple;
	bh=3Ky2iU5L6Io9C+pCEp2jHJ3xZ0K8dqhYtHBlF2ADnh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7/HpWJhNc4WvCb247+9dAPBkj0bvLcXyGQD3zKNkkP9gvdFlWG8IBYfKvZH1NxMFZtdLNYvNaX1OWBoQ2kG8/D4LE/CQmOC6WXYQc14TAacaJT+hEx22CRbYDbGpXMpsspRNcUJQoIcM4jFgPmP6X0jqrjLRRV0Aj2O+RV8aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o49DVN3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3ALVA015783
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HPARjqGQEXADRJTy3T66+FgY1XO3Wy0tKELjyBfIFxI=; b=o49DVN3h2y+E8+/N
	RF33OV/8hsHg35oiB2mjstGodiwKhSw4TRfBa4lmMm730v8rWtX7CoQ0RPe3rePc
	9L1u7ZYgIzjkIqf5VSVi5vGCwj6YduVSKFa9xeCJ9d3dUbxvdyLNm2exOc6WTS0w
	RCIJ21ez2tyHsl8yBKItvo/pUUDUfG0I14m0wW28CBkLF+38qUR+VPrjN4FJTx+3
	4AkJy/1ewV9KUwzAlJDdxSwyvyg5w/HW47fTmcj+gdEXowBIXAxOpBZVK8ETYFJ5
	UuDI9bbqxbZirKzScLVk3lsw8DUzfhUt0vieLJwPIf3TD0SMzs7YDLflDJKmpW7W
	4dYapw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagrv4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:07:05 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88de16c0so62779956d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755356824; x=1755961624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPARjqGQEXADRJTy3T66+FgY1XO3Wy0tKELjyBfIFxI=;
        b=Hr/sMEWwA+e8wNkSH/ERgR7yJCaBNnwodzPkHecFkD0xXi23yksd4nUHndCt3m4sZH
         fyzCWLyAd587r2JLQ/hbk3DIx4XlJmBAA/U1zkxQYut/w/vYxi8t+RsLNLNm5WE/SGZp
         eUw962nwo+cvvhY/syPi9ZbQLUGxk1DlLkHcCCmdKdAQSe9hrcTR+ZLN5i3lDfijU59L
         XDYKaV4rinOLRD+2vpcYEQhutWsywk23J82UEpaR0l9z2Xy20XumdXDVbARtryYKSkU/
         +OIqeNY5P/vdRzR3qfbqAkYkmBushQxm/tNf/9wcwOv2/PdR5AJX2EEuKqqsUrZvslUN
         /JbA==
X-Forwarded-Encrypted: i=1; AJvYcCWgVkAHW+4dZPK920xna7mKXx5Soa/G1M29q/T8glXtDqihbbiVJYcqaQhTaevrIKfGSmTkQJ+unRy3NlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyS//tvWjCC3V0FdGHNc1dBTMv81soFKrfSdfG+thIGG6tH6Qd
	/tfSSjKYsK1Pm/wFlx7dhVc0kZXvmrL9H51byG/kTKpTXUHGpiY30aS6oJ+wm3LfUNNJytN/L+J
	vTVIuGqDZARj0oKuckrkPTELB4f7KaHTjSSeTgMrVHPSMw6k3ez7zkc4lo0PNB2203Sw=
X-Gm-Gg: ASbGncv4H+4ViuOwDQgdHiQ0bH7Pr4LD0rajXHdkeua4mGL5zGn1iwHfhg0xEOZQs6P
	1uomRWazVpm1aoR5cckMccyH7HNOGQmwezeRuJp4cx8laFuZ4Z/hi46lyW7IzStgEN1Rri5qTjV
	GrKDerD0iemmnwkMZ4DHYVlPXvWc61JbXqMeXq7maKgGAnf+uTJUO4SCkvKnWj878J1ba68G03d
	3BBEftaAwi/acpxhIfYP3E3yZ/hvHSG/xApMBSw7O3YVuXJyTgWY1q1CKAPgtey0iP2xVnUsRHy
	s8hyytPMTO57XiMr8gFQxnVPJfJAUuyDrNqw18Cveucc2e5/GUNKefyjpTXZ8CMA5dxK7jzwUfu
	LWH9CgfY+yKUWhROGeMNgcow0LPZdCAGyxpNvyTpzG7QjrYUedpFr
X-Received: by 2002:a05:6214:5286:b0:709:b6a7:6226 with SMTP id 6a1803df08f44-70bb061f4acmr41921186d6.34.1755356824553;
        Sat, 16 Aug 2025 08:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGteGpeN0SYzXGMbCcsQLJ69y3P3FVG661/6VvE2NCO2IH44COnPW6Js0Ei0+mI85s4HgD/Ww==
X-Received: by 2002:a05:6214:5286:b0:709:b6a7:6226 with SMTP id 6a1803df08f44-70bb061f4acmr41920436d6.34.1755356824080;
        Sat, 16 Aug 2025 08:07:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a604194sm10403571fa.50.2025.08.16.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:07:03 -0700 (PDT)
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts
Date: Sat, 16 Aug 2025 18:07:01 +0300
Message-ID: <175535681533.1839975.1951145166123046642.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250802-dp-conn-no-detect-v1-1-2748c2b946da@oss.qualcomm.com>
References: <20250802-dp-conn-no-detect-v1-1-2748c2b946da@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a09e99 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=3LZpj7SCskOl_Lh2xeoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 0s1myCwGj-6PCkHrn6GP2hGO6EzqRlVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfXwMmoQN2PVdvc
 c4NWZG81HDSboWa9BrkIQ0mupm6Hi47YE+wXsKcut3cHVG0hoS/ksw5Z29QqVeUQaTE4wYr8hOr
 oFTYBUp/IvvIu97tX2iVeZi8pMC90St+vl4ijvQqZcoR49QNl1hxwuvWUmJDwpuPP5PPSS+vyMZ
 QAVaVYs4xD3oZogk9gQE+T31T0eUgibk16ybPntUaWsy/LCpbstN5S2/Hmm/psObYzSrAtcfpn/
 E8FuXnH2gpAa6mBQ0y2vulZARqc+xGk2vY6U0h+V59D8sgOEidwlghOKUhugW6yWpqD7T7tJ2xG
 EMez39r+fHq1IaM43tQ/RW9ztfMbkFmMgft6pH/+cc8/HLJaUsufhPjjmW45lkmEXf00o5Hi5t+
 IttuXgF/
X-Proofpoint-GUID: 0s1myCwGj-6PCkHrn6GP2hGO6EzqRlVM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

On Sat, 02 Aug 2025 13:40:35 +0300, Dmitry Baryshkov wrote:
> Detecting the monitor for DisplayPort targets is more complicated than
> just reading the HPD pin level: it requires reading the DPCD in order to
> check what kind of device is attached to the port and whether there is
> an actual display attached.
> 
> In order to let DRM framework handle such configurations, disable
> DRM_BRIDGE_OP_DETECT for dp-connector devices, letting the actual DP
> driver perform detection. This still keeps DRM_BRIDGE_OP_HPD enabled, so
> it is valid for the bridge to report HPD events.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts
      commit: cb640b2ca54617f4a9d4d6efd5ff2afd6be11f19

Best regards,
-- 
With best wishes
Dmitry


