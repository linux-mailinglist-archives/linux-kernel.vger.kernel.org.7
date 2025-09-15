Return-Path: <linux-kernel+bounces-817191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F14B57F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED24B172BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF831DDA0;
	Mon, 15 Sep 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhGMIiAK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F501C8631
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946785; cv=none; b=TmdQO597PZ7D0UJ1/Qkme4B9fM8kWAU2GzZIz3h5DHlwiiCJ3PVDKINgDQfvvxwElPDsXWuuYGmQooMm6HtQsQedrBpgCj5kTjJtdKkBfJyyKItGQpkdt72DgtGxya3V/sJwb+CLVsTX8Sf3AtM7vyR9hGpLaGWsS6KsAeU5Ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946785; c=relaxed/simple;
	bh=SZsUCX/w3pUxBbcbMlcwv7f0jJpQxiT09A73W9+X7FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7CEtvXTga8bP8mVY1u3D3JtrIHGRdx8bNS9LRu3LkyPHKz95v+YjzDX3XO2D2uYNSBxX/478bL2k//gccM6tpsmAKQP+k4EbBZC+XfdMk4RLNBpmfnYKDvwX8X3psImIo26WAFsZSsjDe/q8zPNy++Ptw+LmQOXTh4wXq242g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhGMIiAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAQPnh017534
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cCiPLFsgRo2egphdxmb1qzOQ
	5mme8yx2hExKNMNoSQE=; b=HhGMIiAKuz/F2/+8ITmQfIeolCgGFrHLten91PgH
	l4DBKNbJ0h6Ud7usSUwjs2iLHeWuPm+1OlcAtLQaUuAcTDr+TxU1A5Gg9nTVV7Ea
	S3aynEudRJFGuHFX6Ecded+KObji5Il6HG9I1ORtA5mEP6VFiGa4c4lwShLOVXgN
	jmImbcBG2bxsrFIWHOq4XgfScJ4D9xq9afhPeWgcwVRA1MSparaYEu6CPqOS41O1
	qSoPEFg/7QV4QshJ2G7DbqqUqTf/Eykdzf4w4EKa4VIF9T+c+XJU7Ry5f6szyfle
	Hayss9GLQh6BT5L9m7ru1lv2qf1dJW3I9HL+OnLH/kAUgw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sgr64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:33:02 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544b20274deso1569223e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946782; x=1758551582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCiPLFsgRo2egphdxmb1qzOQ5mme8yx2hExKNMNoSQE=;
        b=F7x7f426ER4wtu+qXraTKHiW4+xpWTZfBwv6PhEz/pp83yHg9hopqBj5GzO7AYEPxl
         dMqi5idiJTgF8V5GLgqFXIaEhZGfXHowY/4LdaAXiKHcvKYJUpkDnrSmYWfj0927fgWR
         +e4aMRGq3iIv1jtLEUB6sgHiuJH7GGo7yD2aixrzctdvzv2KDwFXwD/BiysPK57iRhbL
         5UI5qXygHZB1UjQscQEhAO6bE7XHEg34qvlya4EGhRqRqHHdAxNVTrrJgGzdIE5Vt5ZT
         jgug1B1uLpmp2RgcRtkzy4B9BNuq+jG/m62AAc5vlk1Eaw07VweGkrE9Wf0RdZtiPfhY
         18rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV82zefLbhgiQv71awbdNIvFMd/GRIJV97HJBVEDLTjx/0b1VnrywrqxXyPf20zXxbnfp06oLiYa2VdrAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXveYLsp8+YYhKhWaLlX7WbdhY9yChCaQQS5ih2WcBE0OsEHG
	Gg0eD6MbGJe+cKriWTA2a6AsE/uL74WAqi3YKNcwklNO/rZns8s1F4YRR20++YLcIgK2nI2PX9b
	xZbWwvZCTlWZQi6Y+ZAgEFmtz+caDAD45FCmHP6LhnQSGvCD0mpTARjdPH+dGRTqjmtQ=
X-Gm-Gg: ASbGncvG9kUVKKbu4IBCHEwrMGQ14nwzsgkQWfhvchbtBOhAfdET3uZlcC8cnimTMfv
	w7fD4zZO9fLkmw0WEjSRhlNcqrbGZVwB6rEHpM11cuA8FRfFY566qkKW5HJ1i3ThteteCBDb2+X
	/Ux1auKlceGwefCXZf60tHPnWpJo+5hTHVfvo4B9uZiFJ8o/xlz3kFatbkpTMOCMJKGTvvDpPko
	rSB60uzdMRs8kvDrXSaKZOB/8szYIHbm6I7daybzLLTaCH5SUWu9dkTVSCSwiaSveZMLlI+D1nZ
	cGfRfCRcGM456fFd4JwCXai8fWMlXREd95eB2vhY+eG8s1M9Lpo0ZbCAJ3p1+pbTT7WeltZyi2W
	Rkk9QO50sRXnXSF4pPTPtbdjRxlRRbkYcdsiXZebCWGlgu3jkAIiB
X-Received: by 2002:a05:6122:2019:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-54a16cc2ea8mr3544714e0c.11.1757946781603;
        Mon, 15 Sep 2025 07:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuIXd3AXZPQsg6yrUQ/6TEB2uZ3QxUx6thouxmHnQ+pG1W7Rw+xHTFcjX/dtsAxhwpzcsAcA==
X-Received: by 2002:a05:6122:2019:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-54a16cc2ea8mr3544660e0c.11.1757946780789;
        Mon, 15 Sep 2025 07:33:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b62b3sm3659056e87.5.2025.09.15.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:32:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:32:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: simple: Add innolux,
 n133hse-ea1 and nlt, nl12880bc20-spwg-24
Message-ID: <bd6y7ckgp6nmnotyfibedhgyzemne7mz7ghcfwf3h4k6xdqpbd@i3zl3uellpex>
References: <20250912185159.1118209-1-Frank.Li@nxp.com>
 <ufmwjrlnaq6tucfpqishzvdpgsxartxgohjrgyr4eccahb5jrc@5ausrm3osivb>
 <aMghlBUIu0z2HqPw@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMghlBUIu0z2HqPw@lizhi-Precision-Tower-5810>
X-Proofpoint-ORIG-GUID: ibDRd84-lioh2CRYbWEydbjxzXKzkqsp
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c8239e cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=8WGclHcmlfbBJmt5TOwA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: ibDRd84-lioh2CRYbWEydbjxzXKzkqsp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX4yfLtnFE8bTi
 1Zzn5yfr/ww9IkkfUgPcAC6VyCtF9WRjPAaKhHO1Ec/pdibREnY/eIrAO4mptLNcO9O2tRNNjm0
 tmtDPvEu6cV3pYPNJSIiobKaLZDxIrclL1kaJOsku4q3t7mLnjaaQMG4hR+Xp9dhHeDxkt3i8wI
 ORWnJ3gXR3UCYBrtSGs+nrj02ge/33VRROFTBBMNqPqlLw8eC78gOLka7jIZSUc4Ykr5DJKr9A3
 f71xktK3r2Q1/Hb+Cx5t5arA2ufavJVcm1WiUqGYkufDcH/MegugSiUJBWeLC9PMcfpb4vBhjY5
 56YESrFQz0DqqfOkbq0w6MtG2LKyoAZpww7zVcm9wCJsu0ZQM/kTsUr/I0JWu9DbR1pqpLpgHEt
 rHXwicaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On Mon, Sep 15, 2025 at 10:24:20AM -0400, Frank Li wrote:
> On Mon, Sep 15, 2025 at 04:00:22AM +0300, Dmitry Baryshkov wrote:
> > On Fri, Sep 12, 2025 at 02:51:59PM -0400, Frank Li wrote:
> > > Add innolux,n133hse-ea1 13.3" TFT LCD panel and nlt,nl12880bc20-spwg-24
> > > 12.1" WXGA (1280 x 800) LVDS TFT LCD panel.
> > >
> >
> > And no driver bits?
> 
> This patches just try to fix CHECK_DTBS Warnings for existed old platform.
> I have not these platforms to do test. It is not necessary to have one
> linux driver when add binding doc.

Please explain this in the commit message.


-- 
With best wishes
Dmitry

