Return-Path: <linux-kernel+bounces-732135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15CB0628D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD23BDB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5020B800;
	Tue, 15 Jul 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElfxlvT0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C814386D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592341; cv=none; b=DHBgPMrrOQLZU3TG7hYR0P+UPb52qCEg/iu5lqgpuelhQKDJdlqWXp889o4G8B3RNk3k9Ds8OgCoEXzPdiGAR1DzsMfcCzI0fG1AtEshkvxuV9YOFFyRcWo8RDpiW5w3STVGVLhxzBL6/X+c7uwiunlNiCN/TPe/2hICOZF7n/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592341; c=relaxed/simple;
	bh=C7Bt6ty4O6b5hObsfJEEwxiNOyTN1VXF/4lKT7wSu18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8MUADERqEucyVS66wnE4IEWd+cfOYGP2Dv1G/ZD+Ptxy8YpwuNTNcmKWnH5dvYwJrr9HpiXDSRFGwfYV6J+ZfoLMFBZ0hXDSdgGx2qzvS+vT1GtkwTIWn4HHQQrpN365bI6QWit5D5kCWtniuNT4aqsgshCMBxL/b6E4LrBJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElfxlvT0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCY19O008069
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/8/GQmYozt0hkVdJKNP3dY4c
	27MmXYLwdf8DyqAf4/8=; b=ElfxlvT0VzYDBYqLPcqcx5u7gpdJm/0FYmMwnBnG
	y+B4eho5GQ38s7gyWa5V2do3XLCADnVdKyNIdYEaRxCT0C1n6voidTAPb/dJ8PNM
	cQjD55+s9FTC8E0DR8gaP1UR/8u1e6FZJsdhUG9oFq65KyWJvm1FKx/OIVGZhCDY
	GqP34VrlblGX7kQjhS4nxUIVXBXKFZ9NLggE072UbjrSEaUUDqK9bPvusCTM1sc8
	TYWch1G+ETibhGOgFvTa8N8/FWEZDaZpp8bAT7BoxZ0ifVXNJ6WcBNJaKwt99/uv
	EPvODnurcR0dUiYP2bhTrorQpVZq/UucSCwyWS482wIFPA==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug380uf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:12:18 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso94801465ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592337; x=1753197137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8/GQmYozt0hkVdJKNP3dY4c27MmXYLwdf8DyqAf4/8=;
        b=QW/+Dxni/uw3Ep8XOMGPjHcBTBupJzFqs7+RTffb+/EWovfHa92zCES+IYrc9JaT5Z
         RJKp6jsfNbXhtP3Biw6cQ1/X8G40L8fu8jMjH43curWHjyVstvUJFD/6Yy//Ja8m1jhb
         iCcFgchqBmbZj7ko8u6ogWa4kDq5pYvGxftDyJ2KaDlSXdV6iO1nn0+2nWP1WlrUIOIM
         ynv5gSrklJuGSMYVjeSb9/C2I+IH+/EaMT+wDJpUoM7TE7vagH7lKkNGtfMu/XTS5Lut
         FF0waCrefuRMsvMPWCE6zLgACaoPk2Xl8vjN7ztqD6oYg0Uxdh1A8O6ifhpXr6uaQ6zW
         vKFg==
X-Forwarded-Encrypted: i=1; AJvYcCXdx+SDS/BhzgmGPcI2JkY7Vu9caJl9CoeX/kGzWldLE9JXqaJdNFfegNa/kPChDh0mduuYH6U1tmMzh3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9HSJygf8pHfhCzTNNjs7qbjGxGyoXOIN0qfNCir7aZ+JbdMq
	/VmV4MHYRJzry1cv1zBwHWJehYffqd0PkeFO15f1JnuSsh1fkRzL91b0XtS/04fF4JRa50k6tOp
	CtbfzLraMS/pY/taxEMJ5ihPMHvlTVsX7qwIzJ15vixSCskRn6qEhWTbGCD4hbrDeCuPMTjnhaa
	Q=
X-Gm-Gg: ASbGncvLOtRxjuzi3D/lICbq2eH66/TcwsoSYrMtRjOLnMJJ2jPbAjpED7TaebzjmXj
	jBa24GURQVzRrNvIxpjBvqiK8nEcCUTfoufzY3ipiNseMPwk6+qGeBvtssNhanzVAXCdklS8q9d
	p8Sm1uF4rTqQyaODC5uheH2Dt4sEbf7yQ7HnH/2v1coFW4ij9bnNAPt6qcHJqGwTaPtoDBnCDhK
	bq3uxlXbOP+VwDdAynzJLdCGJF/cCiRrdlJuv3pH/vxF/lB36S9VvyVxMbnlYiaosckyvf5dU99
	ULRGuYH07dLzJLjHOi2o6vgJP6HDjJO4rMYEHwrGyQGgeqnZqEF7YWlv690/LITOHPuLwY0Jbo8
	GNhgsYmjElpgghcaQoDpe/5em9u+tFFns04cf4RfpRVfwNajf021Y
X-Received: by 2002:a05:6e02:b23:b0:3e0:5042:6a0e with SMTP id e9e14a558f8ab-3e253317f2fmr190550385ab.14.1752592336552;
        Tue, 15 Jul 2025 08:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuCcHGzu/NV0coaNVvZvnyxMM3fWdvavBShiCcBGZwVBVkpyKA9SgxNyTJ8HCuKA2VAmYM7Q==
X-Received: by 2002:a05:6e02:b23:b0:3e0:5042:6a0e with SMTP id e9e14a558f8ab-3e253317f2fmr190549775ab.14.1752592336031;
        Tue, 15 Jul 2025 08:12:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7f380dsm2345658e87.83.2025.07.15.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:12:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:12:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/9] drm/msm/disp/mdp4/mdp4_lvds_pll: convert from
 round_rate() to determine_rate()
Message-ID: <tkqu2zt5yulnngwvda462fhmkmtmtjnwieruel6lfjr475h7ld@47goit7jldgk>
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
 <20250710-drm-clk-round-rate-v1-3-601b9ea384c3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-drm-clk-round-rate-v1-3-601b9ea384c3@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzOSBTYWx0ZWRfX3MP4TX9i8s12
 qseGXkF9ukixy4bQZ5ftnud4ELzPaBAvafDcBt8hxR9bSPlWEiK4w9F8SLHD3jy8RKQIUCdXGYe
 R3UlQWdKuJOa4QW6/KBGobJ2pTz4n2/Kw38ZwY/W8fDK2Yhg0TqzEiAquiO1oDpTw4XLgBnsMt/
 JMn5kR1iwfXCscDM2k1MpEBWDAdn64KOn0FPCz2XyTFhG1Zu0eSdK+uCJydropgBKs6gCA+J/m6
 4UHOX8Z2y1l138fe/oqCVrKjOah50ZgL8TzUt9GbkPh8rxWl72AeolbyNBiNh5lx9S0/eW0gdFT
 Z4xNhz49RGFC3DQpEZCBG9GsKKMON5UGuA2GFQkujM8e2+RvgLohUfzecIeeCa21l0teUNDIdQR
 UEMYiN1/lw4ZNGCmhmOAEUosDKp9EDBUuBFJMEX4960cK4kPLZftcxcyzGeUmbIXNTguv1F1
X-Proofpoint-GUID: Z99ITvIluD4zupnAlnRBc7-m66mFuuAZ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68766fd2 cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=mHQ74H5e8mo-RpSg_uaF:22
X-Proofpoint-ORIG-GUID: Z99ITvIluD4zupnAlnRBc7-m66mFuuAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=960 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150139

On Thu, Jul 10, 2025 at 01:43:04PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Please take this via the drm-misc tree (I assume the rest is going to be
merged that way).

-- 
With best wishes
Dmitry

