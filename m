Return-Path: <linux-kernel+bounces-747174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D8B130AF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EF7178252
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16C21C9F6;
	Sun, 27 Jul 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qn/TluVM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAE2045B7
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634263; cv=none; b=tCkuirPy7MffLoYq9VEHm7IbmCuWcrcXvwUDHET5+Ghpmi61Tw8xGQwGNCY0sFZszVKx4j2FSVuRzSTyoA2vdRLL7oCI70yxT6+JviDUZT22sp2goRCd2Limq1zz98hfn/CRQlfHLkflQwAcaMpxIy7WBk8IfqdTll2AoH2mM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634263; c=relaxed/simple;
	bh=/hyRTPmAmkAHxy8tJftSKanHmXxH651xE3r4m+wusw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBRshRYP5Sp+ET0SLq4PIdTKdjrst3Bdnll89DuEmyF7cJ4WhqmT1AmImyNmTfBDkQvekEPloFdu8l+q0Iyp/Hzn6PEB6j6Fn/vN58v0VdNW0Up2FXTPCyvdghm3kX/RB/AZAaALvHsFppbaBa5OAl/HXW7ViWLQbs0rsudyur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qn/TluVM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RFrapV030143
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wK/7AANYzXjuDWi34c4pgwf9
	uDLv5k83zXcgqhJz5MM=; b=Qn/TluVMApsDuwbUJbomJ8HoK9g5RC/YolwxcDiJ
	4XjDV8hiixmpZtRAu4metDviUyVQmb6gpW3ZRRE9/nK+bft3S6H2+t6I5lVHmWta
	p89PHGsmKd4l1dGIbiLFcQp8N8FSkdmjGL9acM2a+e5BidkLnCx8KoaDm8MyQkAU
	phNRaM4uEjNzh6zD2LnHQ4tzHycwAjaIQXEhjMh5W8KiLql48ocZLGMdhI2fpGAh
	MuUjXM9F8lns4O7uIE+t+FSC2vt/0cf+VF9NScJ3A5bkfG+2aNbJZRIsNg0Ef4FO
	AQ/ZAIVUgSwDHOaPVIHv3JS52Lllu1Rj0828Eiutp6Yc5w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr2k6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:37:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70743a15d33so9998346d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634259; x=1754239059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK/7AANYzXjuDWi34c4pgwf9uDLv5k83zXcgqhJz5MM=;
        b=Zc7enkkvFm9ioGezZJQHdDZ8/KMnL5C0SqELuVSceI6t4M9EqUksIL2fKyKY1ajF/Y
         WwvCVJyTc74v4WfwYHtoul4otPtUcWB4zuA4+PHvPPiTSIQsmll9XYIJO+ms4zThfs/E
         YFCGHZQ7IefwXdXWHn1oyi0zRGdiaSwZUMHB/yRRI3+kRXxMcWCKyhXne4cBScuz32zd
         U9NfFLvOawJpyZQ0+OSnpbqiBM/BBBFEejl82UFotRJjP1F5oW9TfRxysirZgXmZVY8X
         jYUTahyv0y0TSeVcQxkrZ+p2IbuKvBjNR9wqzkr5m5SENxHzgEm4wPX5vQiRT/1ZXKCW
         L9zg==
X-Forwarded-Encrypted: i=1; AJvYcCV9eZJMyV2fs+aWfO0EkpEfgWZx+u8aMlpAPIWsdZ6vO2ZCC5cquYuUNaMQaCAsrXHlYj6Sxc2BUVLXfmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UJWxIc5BGq50Z1eoxvUxoJgXNUBo1Ali9k18F8demf1utBxb
	+DeT++yGsszumoowez6NZ4iMsH9yRegsuRUFkXLDr4n7xrDpl519w5bxITrXE5+UP9xoIsZXk1r
	ANXz5h4qnhb/bK8PQ0ggofmYUjrRKwz6j/imwQgjUBuDxLLDHW7psZrHQ4I7N5yR4D0M=
X-Gm-Gg: ASbGnctkvnau5ky7u0VK7Nvmx2NEMqFjtlyGc9AflAkHFwzl6arRYmLgQBSm9ick1mm
	NSnaCQYU9rKaKn0sp0LKWfMVvqznnRbkdQEEHgnT+sEf+2upDai7hD8aVKVgywKvYiqJ5ajiCWM
	vJyMNIuhXteYTtDAv+B9oKtR5KqQSEBa6UM+AKnwozvt+4AytFs7zRWeFHFatpaQiD0Kk+gtz5D
	m8mqNNzq+6AuYuV/faLE0eG+PKOgBAE/hUmybgBjr5W+aw0ELZMAvzLJeYW23Aiv8XhA5O0ryj/
	UifrV5rtJ10Y1s6h/QmmVUlfNSd1KwX8SS9S9b2PRfFn5a0eDIc0RLW8RB/d6s56qkgRFhW8KaB
	NPfhI/s+CQIEifRfIn9bAw4rTekfqp8bVXuIPM7RcpIJJ8a79Sunb
X-Received: by 2002:ad4:5d48:0:b0:6fd:37c0:2c74 with SMTP id 6a1803df08f44-7072052e0b4mr146241616d6.11.1753634259608;
        Sun, 27 Jul 2025 09:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCEzR9cxfhoQf+JRJGJJ+OBE525ZBdzHU5iOMQLP/D8dHXrDVAEtnxnZAfMekTleUclCVblw==
X-Received: by 2002:ad4:5d48:0:b0:6fd:37c0:2c74 with SMTP id 6a1803df08f44-7072052e0b4mr146241226d6.11.1753634259033;
        Sun, 27 Jul 2025 09:37:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f426e396sm8705181fa.70.2025.07.27.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:37:38 -0700 (PDT)
Date: Sun, 27 Jul 2025 19:37:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/bridge: sii9234: fix some typos in comments
 and messages
Message-ID: <dqkflgvnthhej44ocyqkeifixtwjwpyeapq4qpof4ah7kt3ynf@e5svmfyeimga>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <20250724-exynos4-sii9234-driver-v2-1-faee244f1d40@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-exynos4-sii9234-driver-v2-1-faee244f1d40@grimler.se>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NyBTYWx0ZWRfXyiX7jKIj0Ijr
 ushu/y6nxr25wCESYg5s80r882ptdJezg1rHxB85VLsfK3fdSOTGP6xnBLks0+GwxeJZF9ADe3g
 Rgajtlvdd1XPgfaLpvePf9D9yUeyGl8XkqOBbCnqwSMJsAf8/Q2iul2qO4k/FHGQjhYxQ7o0YTx
 FjMcUnZ55bsI3tRB+2YBf+aHjX6A4L3c6NdnjHavJt4R5DNj1XBv1mqHK1Rq+o0+U7q2uOnWLIx
 OGDsoofgW6BqequRXyRJnNUg5fqOXmf7Iemn8cTI1cKjVXR3IQXk+OTmieZIKPEWFSsK4shvNP+
 SYJMlRWjaG2+8sjS/uZp1nrBvo/d+DneIJuqnjIgNJG59roIet+59kerm/wcEgg+dKJyKbBHV0H
 sQKepVvBp9+IVpeznUfMI/oI54EkpGuXKJJwfMzvJY/me3T1o55DdQoAHvQvfVmqWecjK0pR
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688655d4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7HXEQI8gbsEklOhadn0A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: wk5ygC_lDb-TzWtOEScQUy4uAEdXpLyr
X-Proofpoint-ORIG-GUID: wk5ygC_lDb-TzWtOEScQUy4uAEdXpLyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270147

On Thu, Jul 24, 2025 at 08:50:51PM +0200, Henrik Grimler wrote:
> Fix spelling and formatting so that the code is easier to follow, and
> so that it is more searchable.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> v2: no changes
> ---
>  drivers/gpu/drm/bridge/sii9234.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

