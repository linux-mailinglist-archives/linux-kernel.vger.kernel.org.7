Return-Path: <linux-kernel+bounces-842828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12914BBDB78
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFD824EAED2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1511FDE19;
	Mon,  6 Oct 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5EX7/DR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFC188000
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747168; cv=none; b=C499n+sBNzR3c3oN5iJ9obptNiYDWKFi3yXH1dcOnj1dayGdGsckCyt0au5/Ma5htSAMZ/Oka5JWBOEqarw3t8gBIpA/4kO75hQtGpmnlGy1qwD6ACL5E3fwXPsMwW00gDJDSoO1Cg2EEFIYbH06ohAITinigv9QuMpuUhFlw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747168; c=relaxed/simple;
	bh=Y7YOFRG123DLfsR74hu7s46tHnv9F0MOoKCvsGPaRyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7I9qCL4cJ4b/uSqf1XVEhR7tGk84XLnMyn5helE6HPbvYMrKR56KDqJSZB0UnhoexSaifICitexpSMj2MDoUU9iIOGuYdUu4hyfP2XmZvcM4nvEThzhL2alBYvJZIahSFp7WxuNvRfnZzCEHqPQ0lfdJQ9pJRqaApqdjbhUEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5EX7/DR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59611jpv031750
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tL32lBVtdQG6FBp70cR/0+e7
	GT0m4lIzY/Mtg+rXvr0=; b=D5EX7/DRqdw74gyFVv30BXiPneQ15mlAaTP2HjDm
	feAYYiqjOPAYmPpAFYI5+3TWaOlTeMPhwYA0dj6EdoZV9f2GSyaxbzWK4EmYA3g2
	iOhN77zsnxwkAFw4T7zhfurMFEjQxipDWD3kDm84j430i8cqscibhxKsjwYdF53a
	BSvTXYSzYCJpKyXqjgTJLA+XLoQdqNMqLFXndcNI+PPNmBKiCU6J96pljJXCn4G+
	HmL09PXq9CEso3ZCoEmguWSMBFrljKWQ9nx/5CdtGN4EUpDTXD8xVdaxkwJx6LDe
	cQUdNEsES8NdcM7pwhF6YXJNAmEGlWNFh76gTPLND9kLlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7ke5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:39:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8589058c59bso1432425985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759747165; x=1760351965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL32lBVtdQG6FBp70cR/0+e7GT0m4lIzY/Mtg+rXvr0=;
        b=Y4jVvcJllPSTLr0gBj89um/bo9yvi2sAr5PXA7oxPSSgLT5Y9uZH4PZX1XYcoC+pCb
         l7eOHrEqDF93Z3lTCgE3/l0cqESg27OTSTOq3de1bcuDYfuOjvnBs2zYeQ7t4yA6z3rC
         JfXJzH6mPhzzD21dE/maNMXyV6F/EqoBWAuv33ShhdwO+YWGr0/icOsidBcBB8aZAZ05
         RN6cdhVp9MXy/EPJkbSIJjo5tikGjJqXld+jUsBpYKGcVijEsSipezyMqP20ni8PlAIk
         NismqrvGGeBJxtwxPI9iv4pp8kjVWRnNLXpHu4KJy8Woxb/XCdIf27345EApDT3PLtLw
         kiQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9DxHlLVWM5i9Z+2UgZsUEdizBa/GGr03QywO+3ai296Z5KwH426/T5XlMhWTAPSm5RGTqLC/w17O/XYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJfXRDF+TBIl2Ufq2G9IKbw4LhjvEUZQt7SZSluO+UjAkhOk8
	O9eDnseMfwEbkW4vjWmjftHiL2quJp63WQa7+v6vsDmGpO3mb2WDJo7hsP1kWPSZumz423NzqBR
	IEF6K4ufhmNoSyE/r8tpkNO1uGUOYMoKyBMKa3K81YC0cC3s/il/nZlC+Pao8SrrCC10=
X-Gm-Gg: ASbGncvMbYnGFJY70rLWzIA3WHUSTN5JRvoLHkX9WYxDBvdV5mO2PwPdPoxwaHpbqJp
	v5dwPDn4zJzwh1VAAcz49PDswIiJfwRKH1mSqTrIYE1pxTV4MGmqKhrhNmC+7/fstUOnRUX3GSz
	js2tWuwTuAan/W8ESEFheK3oH8UJjJGfLW13XbaMQp1cxWESdEnkU3CH5S2bF9LLOEMGpaJjZZU
	HjcWbQS38VARh69HnuhoVuEA6zdiDdVRU/QhPdNb+ONHE5bvAqulgR55+ox2itI1GK9+yFFy292
	cbpAi0DCkbjtWXFoWtM1nbqch03RhGnGB3fnDEWr0IOIDfcpFWYl1oonMDkVJ790V3reI1Nh88B
	yrA5p/d0mVtvNu6pkSfdaVrtIt22rZyRQKqMQanYZ+Adsxpfv70taZcHppg==
X-Received: by 2002:a05:620a:f05:b0:847:cb75:95e4 with SMTP id af79cd13be357-87a38a3a9a9mr1257910385a.78.1759747164962;
        Mon, 06 Oct 2025 03:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzjLLv0vLtf2KwPjN7Isng+2S6+xF8KquObPMQpThzVTOWmfSKiJh31vn8lJ3hYibY9HOs5w==
X-Received: by 2002:a05:620a:f05:b0:847:cb75:95e4 with SMTP id af79cd13be357-87a38a3a9a9mr1257906985a.78.1759747164471;
        Mon, 06 Oct 2025 03:39:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444ae4sm43603661fa.36.2025.10.06.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:39:23 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:39:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Junjie Cao <caojunjie650@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panel: Add Novatek NT36532 panel driver
Message-ID: <2do3dk7gqvbloocsv46t3zrc4ghvhrpiqre6djk6heese3wz75@dlqwkdsnrkbr>
References: <20251001135914.13754-1-caojunjie650@gmail.com>
 <20251001135914.13754-4-caojunjie650@gmail.com>
 <lfdhib6a7ct36nmj3of2setjft7ydrf6sfgtx7qued7qd56nhc@2xol3grm5re7>
 <e36572bf-4fb4-425e-8d10-c5efa5af97f3@oss.qualcomm.com>
 <rxm67cbwkp2qyxdlgqb3fz7fhiskmnhidhjvl4mhqn67iq2x4n@wfueruiiq7kp>
 <53aafa84-6d6a-4963-827e-c1600270662f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53aafa84-6d6a-4963-827e-c1600270662f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX5x3+OeJrPheR
 23DlnEzAeT592mIslcgz5+KfYz9v5cVNl6yTFudpUW7/vZFnjUmSMfZtsjasKbPW3mwhYT3Nt6q
 jPpoXARi3WTKoUVDcS7rjxPPAwK86ra1U95NXGT9y3i0/5GLaIOlDRFrKMRKJbfxaq7j0HOIMkw
 7IuRvQXCvTBJbeaxWac6Lt3vwrD1kyKDB7KaB99nSEiCq9HEzLCjTUGI3IIXYMgsaTPGg4YoR6x
 66PcfWXhuSo7f4jRo2jVI2RVMy/HSQFAHAj/DXD6C/d96WyzDjluhCefUu2zXI2L2xtv82PAtfY
 ganIVaXHd5I23y455lEPC5ROUVf2/G0Uvtx4TzPnUyCRay9CUaRrkwMhx0PqceKuV6wRvUyR8CW
 Zk0x3UjybmY+i5EzGxGzHU6/RMxBNw==
X-Proofpoint-ORIG-GUID: EgVLqf-XbwcWdqA7m_bMJA0vmoCoMzjZ
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e39c5e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EU-ENxuI5XK3D0y7c1kA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: EgVLqf-XbwcWdqA7m_bMJA0vmoCoMzjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On Mon, Oct 06, 2025 at 12:10:05PM +0200, Konrad Dybcio wrote:
> On 10/6/25 12:02 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 06, 2025 at 11:24:35AM +0200, Konrad Dybcio wrote:
> >> On 10/2/25 4:04 AM, Dmitry Baryshkov wrote:
> >>> On Wed, Oct 01, 2025 at 09:59:14PM +0800, Junjie Cao wrote:
> >>>> Add a driver for panels using the Novatek NT36532 Display Driver IC,
> >>>> including support for the CSOT PPC100HB1-1, found in the OnePlus Pad 2
> >>>> tablets.
> >>>>
> >>>> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
> >>>> ---
> >>>>  MAINTAINERS                                   |   7 +
> >>>>  drivers/gpu/drm/panel/Kconfig                 |  10 +
> >>>>  drivers/gpu/drm/panel/Makefile                |   1 +
> >>>>  drivers/gpu/drm/panel/panel-novatek-nt36532.c | 437 ++++++++++++++++++
> >>>>  4 files changed, 455 insertions(+)
> >>>>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
> >>>>
> >>>> +
> >>>> +static const struct panel_info csot_panel_info = {
> >>>> +	.width_mm = 250,
> >>>> +	.height_mm = 177,
> >>>> +	.lanes = 4,
> >>>> +	.format = MIPI_DSI_FMT_RGB888,
> >>>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS |
> >>>> +		      MIPI_DSI_MODE_LPM,
> >>>> +	.display_mode = csot_display_mode,
> >>>> +	.dsc_slice_per_pkt = 2,
> >>>
> >>> As this is not a part of the standard, what if the DSI host doesn't
> >>> support this feature?
> >>
> >> Shouldn't the core gracefully throw something like an -EINVAL?
> > 
> > There is no 'core' here. Each DSI DRM host manages DSC on their own.
> 
> drm_dsc_helper?

No, that's just for calculating PPS and some other values. It's one of
the problems of the DSI model, which I tried to solve a year ago, but
failed up to now to do it completely and clearly. The DSI device can't
check host's capabilities. It declares what it needs inside struct
mipi_dsi_device and hopes for the best.

-- 
With best wishes
Dmitry

