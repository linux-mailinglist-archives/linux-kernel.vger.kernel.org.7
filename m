Return-Path: <linux-kernel+bounces-754198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF495B18FA3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA984E02A5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B9241691;
	Sat,  2 Aug 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCdjk5kB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AA1607AB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159251; cv=none; b=hXsSX8qq9gqs92ThYkZL28DgYyVl98NZ7xUFTG5MjoyWApQGWpBFVzHhwsDSXA/tLQsvjStWEIRb4TCrLrAP8lgUv0NP1apx+VupqQw3BeEyVnRWxax71hx/8Q8+MQofj8XVQTrEFBB3CJ8yg/RcwBDnPkAJfX8Aag5BHXKlIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159251; c=relaxed/simple;
	bh=mS85AEUZR7diq8LB3L7GwJfBwiq8F4Kg6myNQmyU+Pk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JC+/+EuDog2Dg+dWFfBNSpBvqnaf7yL90/MD/XAHyTq4s5nAzdGDmBkc+Yg5Xjgrq6+hGnwpqplqfsNHmmaloFhjH5w5qqoXpg6SaeqCKV230kZiwgz9ifuvA1Aytagqj0DNXiM1CR4mcG1vbDSVRDWTdH0W4sN0f185NvIDW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCdjk5kB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 572I1apU014197
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 18:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wHjJfO2eVz1RXrskPBrgz9SqYwFlP2w6be1JZyceH5A=; b=TCdjk5kBVzKXLWQd
	2XyhncFC7KbWEH47xV/M8yKgJi/qbU6IghYNFzIXyPEtXG/qHIZB7naeeXAgo/+I
	VMJ/YAfV79fXjob0o7yQ/34Yiky43X6KHM2itWcfbi2DAaOXgaL4Y/zZmIP9elgK
	llCS1kqn585tgfZSVlkbRBBBy5FohpgIqTfMP2h3iysFvivWjBbNRMSEoi3U8VKi
	MFb863cbX1ElrHjSWXwoxk3coIiN2pljp8mvybv7XFMPa+7q0u/o1hmwFstVK4xO
	x/D0nslno8BLEJT7YpEljIeMhJyutFwcJjTPes0DXu9WVVNRgOkjjl1XPaOvf5VK
	sgZWKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjhcs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 18:27:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af22e50c00so6649111cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 11:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754159247; x=1754764047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHjJfO2eVz1RXrskPBrgz9SqYwFlP2w6be1JZyceH5A=;
        b=dN9RJVMbwhEuzRuY2weYbs0PhgEqyBuPefYw9MiNZOkzKi+0tffXM3A8B/FyzE/9br
         ZjxAoelug44H507lWUmD2Uif+9YrLtlO1AHse5JFrT1810enUHwdKbCPT1gFWuPwkgy7
         wPUbIvNq/ugBOz84jXdMXmNkfthdmm3YO6tPygymsxeohkZNARjPSnndGkH8Z7ccv42i
         ZNFOsHWB/ZmQ7OSL9+Crf8YA4r8S1pa0kCkKqUrUKJ1gvPrEQkc9FszMLHyBokqOyx4i
         evF+jfM9APhD2mDhmZKI1V2BKmqo//s7C9A/GVHP02txWXuDrpwxfboqV3u9F0cCoWU4
         kKUg==
X-Forwarded-Encrypted: i=1; AJvYcCXtlWorALDDsUHtNp+G37TOzLwlN9ydrLWuT6J3pWW865QfQk3/c06dIZRaipZiapUbu6J0K6GHVAItMbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8K+XRkhl7IZOFcLbAfejKp18zIeGSDUOGJL2Ux27glVi+1m/
	K9NETOyNpLUYOz3gMcOwKOwQMt3/aojk2yFwMK1JTwYopJ/3zB0znn17YiDukPRJTqWqeuhDxRC
	yDN8vT8q++xRzsaPvOpHVmDeoC8zKSqzb4Z25YVtAUQuw7p1KhO5J3uZOQK0+y7fTu3Q=
X-Gm-Gg: ASbGnctEcXqzKiiLxQckBWPgoyEcad5fqmG2HJhdMxmQEhXeagVeKu41aUmrJ1b8rb0
	89EnA+5rA9cx3Yjy5QL31lyeRbvKnHLxezByaA+rTNoCFLGw3CsxYomrIuh4asvPHfbJ34rXDJo
	xA8m4puqo+8/7OCZJA/vS/URybQgrWjVvJvioCoTDKjVv3HwvaAhFs/2kPooRidUGxt/OYYq5yH
	S7AEWLfUss0mhM9VH/trY88/xTrVsqDig999uoCqIwGMV+VNAuoXqK6853Gvah/R3+Y/AMHZ03E
	fJJZQFaq7NsYydyDfs9+o2Mqy2kAwy7tSSn4jK5y5j4qanDNH3fMOucWfxTb4u4NH0Fcdm9AgnP
	zaXgriE+X14HfMD2NnrP20WfJbvt+s4h5qni9x2o97Ab3GhQXBC5S
X-Received: by 2002:a05:622a:1988:b0:4a4:41a1:b944 with SMTP id d75a77b69052e-4af1096838amr47219161cf.1.1754159247563;
        Sat, 02 Aug 2025 11:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdwUz9W6djQbx6Jk8PlmiYRWeWMq+sa/EoP9yp8VFX0101q5L3EsmEA3Pw+flip/kig9JF8w==
X-Received: by 2002:a05:622a:1988:b0:4a4:41a1:b944 with SMTP id d75a77b69052e-4af1096838amr47218801cf.1.1754159247079;
        Sat, 02 Aug 2025 11:27:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bd58sm1081590e87.8.2025.08.02.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 11:27:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708085124.15445-1-johan@kernel.org>
References: <20250708085124.15445-1-johan@kernel.org>
Subject: Re: (subset) [PATCH 0/2] drm/bridge: fix OF node leaks
Message-Id: <175415924590.3214054.15582803445369224429.b4-ty@oss.qualcomm.com>
Date: Sat, 02 Aug 2025 21:27:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=688e5890 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=nbYGOYP4SzQJCf5zM18A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Cvpkg4NTN8kXmIcAQdKMXmw3VMNyg1dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDE1MSBTYWx0ZWRfXxme83YQIY1Yw
 RBcp+vhKUef7/pwGO5m1iE6qeFsXPp2OoXei/C56L0W5Nk+s+nDnO4vdv5iVGrgDvnP0UBAdLbu
 Lh4I7mFDVw8Zi90JYLIcE/JEYwfWar261KWMKXqocSN4bceH6BvnDGziD3z42xNZILGmFVEAc6y
 knXq5DMdghds7NiKZ/M8tF4hvKoR3z4l5m1RkB5YPshK33pYowKM9VMr+IyBtM4CAEDcQDoEjPN
 Cd53XUwecWNnXSEJPz2KYbOm4VZODbbFLG/QrP3mytTRAt3cyw2dGySClQ0CkzO2Q4hwPTn/U2r
 44ei+xU6Wq0Qu9VOGrTOyIqEGDH58uVDJVkgINKewhtIJmpz9VEZT1rZdEG0sDgKjundMZQOYhB
 F/Xoj/4ZToNRgVKXpb4uqVBl0TcpNjZsZ7lKgQBCSEsyZzlFP4uAfgweX66iu3fFB0JvA3NH
X-Proofpoint-GUID: Cvpkg4NTN8kXmIcAQdKMXmw3VMNyg1dQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020151

On Tue, 08 Jul 2025 10:51:22 +0200, Johan Hovold wrote:
> Make sure to drop the OF node references taken when creating bridge
> device when the devices are later released.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   drm/bridge: fix OF node leak
>   drm/bridge: ti-sn65dsi86: fix OF node leak
> 
> [...]

Applied to drm-misc-next-fixes, thanks!

[1/2] drm/bridge: fix OF node leak
      commit: be71ce9796c36517c677ab1d3c6691423dd0bdec

Best regards,
-- 
With best wishes
Dmitry



