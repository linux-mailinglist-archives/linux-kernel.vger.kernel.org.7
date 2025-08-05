Return-Path: <linux-kernel+bounces-756284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D6DB1B249
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A37189CA08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565423DEB6;
	Tue,  5 Aug 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N73F0IH7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284192222D2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391094; cv=none; b=f2DWzk/uOujhcX+gOyS12y3Pjrw/BI/+HRfBj2j2ZiOYX5CPsRJ5ujgvfkq400jyeiC8LHZqVM3odlsFoMw5BueWsI4WV89b2H+FPavlVCzA2TKBFdLrecYOXmT9ZH276sTax3NNod0znrWhf2NggGynVujVqLSl4VlmevCQAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391094; c=relaxed/simple;
	bh=axaPrv8xUeRbbEKD4PK85MM7Qv2uw3Bo++ptLlxXegk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SgGkayhHbsXfZVEVPvHCC50p1jYvtHtpWrs5GQGjLKMVy228l3DZgwhvjD4fqX7nEZuLSAc5InW+MHcIP9OjdgUfVLYWGImevVMCqm8VBI4shqKA0QukvagTmcjfqA8VcSLKo6WgGwPvR09ZPjUzlDzVzUf0GYmFcz9kshF6ewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N73F0IH7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756vsvX010359
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7+1XHQJSTgHTnFQCSkGI1i+CMvEJfW/p/UsKbi6qO8c=; b=N73F0IH7QlOB5EGS
	eaUeZaY6WkFObaV8RxVFydPfxG3QBDFuGMOpzLHuZZB/aPg13DA4H+3Sn7nZnp9h
	nH+JQRSqQGLF2CAnrAE+dS3lsbBquguLImZ+DOU52bGo1zOGg74eDhQA1gEnTkIO
	v3ncigJYO3Z4jBEb1Yi6hrooo0/J6GJyOsN0zgbMQD7YUU72V7dd097gDBp05u3d
	e28Yd1zKkVrj4I06vIO2FJt7oFwfxmRiJvxY/UV6lNEGpN0WvDykJ++yRiuMW1Kx
	o6pOjj+ZZt3JZfy9RrRiuZSEGjKKrfyoNd3Uao/gFmkyx8LNoCOnu4/UL5wr1FqV
	yQ4DkA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek86jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:51:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7075d489ff0so89130726d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391091; x=1754995891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+1XHQJSTgHTnFQCSkGI1i+CMvEJfW/p/UsKbi6qO8c=;
        b=T0rV2rvpEzyD8tdO73VggAHi2x6khNn9EqAVcVLjMya+e6TEm2uxXTRd/XtGSqsTva
         pW27g/NeLMBaTgs//xbnwOECwgIRh2TYYQ/EMTsIzH9bzZtGgRppRGDF0llPIoWEVlr2
         boQgImwyL7RBMUhPkawTl4+/k1bVT9d9Bb66kiAtVgWsNKZ/904HpHxDf5+Uru+/utAg
         99Q/Os3Hn1SZe4/WbhiHXED/8gkR7acUyaDRawf09GdIQte9Wjciu2xS1sfMBIBIBx4p
         uB4ahCz9tA8qEkxuaoOyRf2JBJuGKOA6+n8xWjeSPYjl6crmz2vpiDYnxNAxkmX6+8nL
         IBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV8P1zE2pDa4pJAR/Dfp9igynEP84FIUHMWTcVqSdTh6tH+vOHqwxjWX/bWPecv9gQrxLZG9ppaIWtk2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJ5GsX955UOmkds50h9gjSwfHIXLPa2MBqG5ghEpoQaYnCPay
	XJrOv3fD0qD+iBrtnb0TpBcmP/pcr+H05P+U+rPCjYg1kAcg58H4Yj7Xqfh66RabYDuwqwrcu27
	cEuLTkSseFDdBTRSaPad7anXETMk6+w3MOi00L15wxP3kUEC5Uqxh0gPwpMxWc082N8c=
X-Gm-Gg: ASbGncsJRLRBxnQaSG85ApNeIuUxoVh6iwvv3OJeEteCJribXFyacGBvdtfUJtcpyJ2
	kdyl4P5K6R4wGFya6/cb3il5WXwY/dqWZLpKoFnTB46UjeCvC/fMEwTmv9Km5R6Qa5ND1zJKHEd
	pYyQYhK1+BDZJdggyNSpBFuSvveIfBLbteTxYD7CckSw6t98u20eC3vnC0ESAgRFW7vR3Wl7xcD
	fjcacglApHajrgShMdiT8JK/E3KNaW0wEN/WPC2iOEv6aVbAkjEhC0L6Ifm8h6aAGQfGbV/iV0A
	WYQlXyillP505DXBW+oTroCUGhkeS2h3LgH8j6PsSaPzJwADB+2RwGB8Pc4pC1e6EYs0joyo9Q7
	xHgaN2EE8dlIRVzLS5XDbUUTHUkZogLolhyRv6hZPSz6Q6o3Bs/R7
X-Received: by 2002:a05:6214:20cb:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-7093633e31amr166353626d6.44.1754391091001;
        Tue, 05 Aug 2025 03:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp46qB81Yj6DBW6PfmcGZLSvWO4X9UnsMWKv37gM+2eUxLFUWLz66W/1ruvmDLQpLgFriCew==
X-Received: by 2002:a05:6214:20cb:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-7093633e31amr166353266d6.44.1754391090599;
        Tue, 05 Aug 2025 03:51:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm1966116e87.77.2025.08.05.03.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:51:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com>
References: <20250801-drm-hdmi-cec-docs-v1-1-be63e6008d0e@oss.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: document HDMI CEC callbacks
Message-Id: <175439108947.3454735.4407593124485023962.b4-ty@oss.qualcomm.com>
Date: Tue, 05 Aug 2025 13:51:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=6891e234 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8pPcKAIJdAIFnR10lwcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3OCBTYWx0ZWRfX7cr8NdgD7KAN
 lMcIzH1gxdnf51wTxplCJ/2SNEzikwFBbRzK0MK8GAdgILIuegnYRIqzd+286ByJkO8Ab4HOt9Q
 GZ1X6CNpxqYNm+cDcOfHYh8Y9j+lZ+VzuIajhj2WD/AfsfDaNgeGeSl3kgY4yFA10dFzj5HmYaW
 ishMlF2lbsAuXizdM97dLJlnknkiAU2WpZhwd5vprA3PRlUYHpE+Yl89ZLV2kEr/NhM3AOY/6zU
 uzh57EuZkQSA7yGYSq2MkFunklOA6A/vLTvITQIYlWuXUIRu+kB7a67xVXkU86Tq8QUlKGbWeXY
 lQtPpZ+CMFwn2lh99AMQQ0gjssKkra18gzc+DgOrVoS/Kx5I+kwHwXh8LsMw+sOXFU44k0pmcpp
 KsGWCu9KMsbr2kiJq9uiJ9G8tdhTrkVpZpu3QXpf58B9AyGLePdEZL2lLjWU1oC0WtOJqPGs
X-Proofpoint-ORIG-GUID: aHdclAQm7T9GGP-jwiTkU-tR9urLMM8c
X-Proofpoint-GUID: aHdclAQm7T9GGP-jwiTkU-tR9urLMM8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=986 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050078

On Fri, 01 Aug 2025 13:46:41 +0300, Dmitry Baryshkov wrote:
> Provide documentation for the drm_bridge callbacks related to the
> DRM_BRIDGE_OP_HDMI_CEC_ADAPTER flag.
> 
> 

Applied to drm-misc-next-fixes, thanks!

[1/1] drm/bridge: document HDMI CEC callbacks
      commit: eec8e8c048caa826ecbde7bf40f0ac2d11eef99d

Best regards,
-- 
With best wishes
Dmitry



