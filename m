Return-Path: <linux-kernel+bounces-817599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51099B58451
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5582F188586A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE12BDC2B;
	Mon, 15 Sep 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlTSAvuP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B011A9F89
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960140; cv=none; b=a10FP8BRRxNtoGbx2AU9/QJz0ZaxHGWjrqn9Spl4dy+AIWC12GUfbSJryxs2kJtjVNyiDJMsZTv8gacSEwq3HxZlSLlbY5V79VncvKDKf2CowPPJAvjoTiF8PrmyKseI+OMmb+O2gKf8v5Wy6bkBzFK1eOPDa3MA6JlJ37LqwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960140; c=relaxed/simple;
	bh=b3tLW6Lh2bd/lWW1rlpdKcjwC3k7IeJWmkKC3UYrR/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzSf6lfTbNEbRwaeiXz5YjJ+G2cnci+TCAaqN4707CBiFl6JWq4HJSgrhCJrpyW49iNJQ16z+I03MRLOgiQ2dJWdSivcUZAUcb40Tc51pzMbqINpQ/5N5qPDCooFL2w54zZvABX3FtO+SgEOUHTC4+VOCZB3/6Q25lLIhh+3XWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlTSAvuP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEMYRS027269
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6f1ur2OAuyG3gVnkNaf1NXHoDMPmNFiXyxlSHSLCAk=; b=WlTSAvuPyp4e7Tkd
	RHWpwRQ+NGYn1GZlknsNRNDJgrayongGvBjQO4e5BBSYxcgfB87mXvohwQ/LYA+G
	7rER5gMgpoGlBgBg3EGNERiIJD9eS3Di8J064nEtwL2cRYD/XRCqrIqUq4JoyjR0
	6FT5MYRUDv1Xia0r/Ap6X/xvxSPwCkqsA+UlFEsRFziL8NtHJkHDp3rL/JunWitA
	AmseY09Ilq0RqWy2av445dxcNu8lGoD+OnDLRjCH+6Lnix603ic9EB8CPeoHi2HZ
	98cNlKt74EMBTC9tpK1QMs/9i6GVS0aNHQ8duPzSrRWEezVfjbhx2phWIzM8fzeI
	4OA7Lg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072p0k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:15:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b548745115so114590541cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960135; x=1758564935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6f1ur2OAuyG3gVnkNaf1NXHoDMPmNFiXyxlSHSLCAk=;
        b=xLcpMCVzqx1aVs8dWOSwf1kQodO+FtiU9fLMBV1UOS570KnRhFwn8UqX/9dyIug11h
         juont9rLQoagoe4NwbI3doK0YGCZ1qIWPWmh56SX/OQAQ7g0CEeeihZONcoNzELYqwTB
         hhxNjHUFvoe62NkciM4wYj7gCPJNYayyEKO1LlTb/F57QNwKuswsp6gM2afR80RUEgx3
         Sh+RVz3+wBgT9IUIV355P7CTC4KpYjiWQ3/zMfb6Qq3jaknhWXPdydak19KvTCklql4L
         YVXIhD26I2m39MztoslFfBqgO9FDWC46skmZySV6R1hBjdA0oFDMAjXnqC6lUGu7BWdT
         W1YA==
X-Forwarded-Encrypted: i=1; AJvYcCVWAuvhxBZRPREcXNOUxKLcR8YMhyxGUnST7TmoHsbIjYwwd1LWHO145z5+EVxzPjIYvZhNBdmTeIo5v+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBilf8QJ6sbCcnDY4k8oDtbtQRjWzF+mkaLwLQe/w3xsSlVPRw
	+KBuypuWGvrAUe3hj2Gcdq3NvX3bYvfuVAr6TgafdYJgoJOop7Kmo4cfopil4ZUR+dsPZmAZNUU
	DMpfsCCHUJHahZsX7vg52uO+t6WY9PXOzBCf1sDGj9CBH0ry1UYJ9tbea2p3ISakT6xg=
X-Gm-Gg: ASbGncv1Bw9QmqmfVNq6ZXSKctYPFIXw3d1kauoWlzbIs9CsZQ+G+y2bL11dkwOSVkh
	mOJKF+n2DWXgNIA6r8LLya1uX8Zvmn54oYw4jpQC9W67c6Zfhl1NfixHLeA83O7TzaN4Jmty7k1
	fQlXeC7c9uhrtvVuGMmS3i8BVdu477W8sI51IXT0EfLI12Tmx3D8L5/gABkfV26hY/3veM0g5Wa
	JkNX7LhlA2YolT6x5WpeGFSDqLI68lPw2LgkL50CQGEAf/PqxjJrMcCS7jHcg2MnodcHxKdPj86
	s66ht7iCiGAaHP72QZ/3knZ3RrTrND+AHLb51xTdO7uSy+N+ytCNyWJW/uzyd1RmEhbo78PmpUL
	1vwDwX11c1pOgcqA6AflcpYzgQQ/+lHGE9FI6Qcw+i+9pnj6KVLeH
X-Received: by 2002:a05:622a:8c14:b0:4b6:3d70:8810 with SMTP id d75a77b69052e-4b63d7088e2mr175507141cf.22.1757960135027;
        Mon, 15 Sep 2025 11:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUuro1SmpPEADogZffdM7l1FjPktoEHc4t8tIvDkL3K5P/oGNVhE55NqVHm7z5YEMGTHbndg==
X-Received: by 2002:a05:622a:8c14:b0:4b6:3d70:8810 with SMTP id d75a77b69052e-4b63d7088e2mr175506541cf.22.1757960134479;
        Mon, 15 Sep 2025 11:15:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5d20df19sm3772762e87.48.2025.09.15.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:15:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:15:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: display: simple: Add
 innolux,n133hse-ea1 and nlt,nl12880bc20-spwg-24
Message-ID: <l7ycmuoktaamk7kaurt757ihk5jifruoe6fq42aejpb7t6ljv2@26gtcl65s34v>
References: <20250915155123.3250823-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915155123.3250823-1-Frank.Li@nxp.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX9pAEwQ0a+bKA
 BSX2x+2S38mqGPG/zLQ7oETGIra8IBjj71gpm67R7Nu7TPjYHNPFj0zh3W2X+RUrSiu9UIDLI+A
 5EjgHSVNODmxEbtyZ/pXFAaHhFNRA7uUHzkocTSUlmuPgV/Mz4saGMb068lv1su3w+9Z+0X+Gzd
 gk0RYLvE6XebIw385CXqOnX6OVx8Xi8+zgC8GAUIGrSeT08v+1/5g2IZR9xRPLhTSSSCmxPybrS
 FmQ4itkn5hH5Y3qixFBHiGN+JdApHrO+z9dZuTTs37gbxs8OUObvOqjko2czRDd7Ogxl8WBAc7W
 jcYp5zd72TkrTtYWqc5FpOs4V7tMMn5VGMw9tiL8f4KuGNWPtA1V6nYUdP4N3sl286ebpnaCOyb
 Pq3/RlHk
X-Proofpoint-GUID: NBa-bqJsyn7DWrdpINx3KIcaSedIML05
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c857c8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=XQU3RipaE_N5LczM4VUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: NBa-bqJsyn7DWrdpINx3KIcaSedIML05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Mon, Sep 15, 2025 at 11:51:23AM -0400, Frank Li wrote:
> Add innolux,n133hse-ea1 13.3" TFT LCD panel and nlt,nl12880bc20-spwg-24
> 12.1" WXGA (1280 x 800) LVDS TFT LCD panel.
> 
> Fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx6q-novena.dtb: /panel: failed to match any schema with compatible: ['innolux,n133hse-ea1']
> arch/arm/boot/dts/nxp/imx/imx6dl-tx6u-811x.dtb: /lvds0-panel: failed to match any schema with compatible: ['nlt,nl12880bc20-spwg-24']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - update commit message to show fix CHECK_DTBS warnings.
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 48344ce74a6e7..77a5d20a8b0d9 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -180,6 +180,8 @@ properties:
>        - innolux,g121xce-l01
>          # InnoLux 15.6" FHD (1920x1080) TFT LCD panel
>        - innolux,g156hce-l01
> +        # InnoLux 13.3" FHD (1920x1080) TFT LCD panel
> +      - innolux,n133hse-ea1

For the reference: https://lore.kernel.org/dri-devel/20200509111834.26335-3-srk@48.io/

>          # InnoLux 15.6" WXGA TFT LCD panel
>        - innolux,n156bge-l21
>          # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
> @@ -230,6 +232,8 @@ properties:
>        - netron-dy,e231732
>          # Newhaven Display International 480 x 272 TFT LCD panel
>        - newhaven,nhd-4.3-480272ef-atxl
> +        # NLT Technologies, Ltd. 12.1" WXGA (1280 x 800) LVDS TFT LCD panel
> +      - nlt,nl12880bc20-spwg-24

For the reference: https://lore.kernel.org/dri-devel/1507721021-28174-8-git-send-email-LW@KARO-electronics.de/

>          # NLT Technologies, Ltd. 15.6" WXGA (1366×768) LVDS TFT LCD panel
>        - nlt,nl13676bc25-03f
>          # New Vision Display 7.0" 800 RGB x 480 TFT LCD panel
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

