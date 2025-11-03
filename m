Return-Path: <linux-kernel+bounces-882279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA2C2A0D2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80BA14EA187
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF9223710;
	Mon,  3 Nov 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWqpkcDy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4Rb83Ug"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6628DB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147227; cv=none; b=e0oF3Qqm86sIYfytPqg6i4xNxDNlUFSPTXxMeoXKvHAy0kE1CCIEoqNp48hDubhrzPAGNLGUZ8wWQITvigXdDzdFxnzG6fRwtaEXKHuvOuHFTv6+XGyIkewRe7L//6S2FCloFX8+zFrYmrNvDPR8aXkuyHHrxPRamhJx7Gj27iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147227; c=relaxed/simple;
	bh=JSX9p/wIgvHai+qHF4nQy/+4OQNMz0VoQCPVnyjPdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv5QzxtR3LQP8CfYIjEueMM2U54+qBD/AsfBxQ4L5gF0YOVMhj9gz5yBwcNQjozOOR9BMP6oBAZvrFCbLUUdKQ2zUi9P80Rk8buNHXUQHiw4j1t0LTvwX7Lm3mUWu/woEkWimRoyTnyjzPmz5MjVF00ShJ9jqlQpDl00TnIHeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWqpkcDy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4Rb83Ug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2LCJ8G1281298
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 05:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7GGfOekLc0CHGGD6nfIjuSVS
	vP2PeOzTU8l9vvvf41g=; b=cWqpkcDy5W5BxSkQBNgW/S3VUlm16SZ7FShTh7qS
	gcmzBRAggLjDO6GqPMVuljyLcXT1Kh4SbSP8YltOWB7FFRftBxSGn555j6KTRlNJ
	/bsRe59GNBHzLF5uTVKOFI0v+8qbUA9BErYvkPDnlc/wqSOQ6Nimm8oFqCAYIj0J
	EBlNFsxGWjl4ZuqT9y8hc/yPZFqEHxF7mRgouhSTIdcoWok7fwnbG2+JZn66g0pR
	85CF+wQ3018k7UUM4kRUxz8fi5+y/nZG8X4e0pALJrkR1r0+qubMYlpQ1TIV6Ggo
	/ybFcu1qsoX5YXzOpNQyKU+HZbIWgGsMw/bFlTEZ0mWMZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn3jqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:20:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb7853480dso122929851cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762147223; x=1762752023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GGfOekLc0CHGGD6nfIjuSVSvP2PeOzTU8l9vvvf41g=;
        b=f4Rb83Ug5bZzkOeFtT+HQySLW1eA0FsYXKcoQii8tmnfVKSf+OVtZSwrHT5wuI/IfR
         bm3dqCu2CH4XaBp5qim8SrLIQTlTddA0gzPGg/nbefQVLCNiaHJbgS4mIYLQ7V6P/Uun
         aeZzJkfuRd1BaCvY03gxXK0ktDq557GJzpSPpZBQ+cPVGNDcMU07fyCzSpF4w0+i4Fv5
         FV3qPqs8Iq+xT7F8Cb9fuQfVv2iQDxvKbrWfXZ3B8mvHWNeELLJoMzW+RLlCj4V7VIl7
         lDGGtNhKL9kio7aib6/pqXbwnZmHsfJf3ebl/OvUMVYZw0LnfWZB8GKEe9cb3fyZHxDU
         mh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147223; x=1762752023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GGfOekLc0CHGGD6nfIjuSVSvP2PeOzTU8l9vvvf41g=;
        b=f/6KeVh4nJPkYBH47RHtLLiy1+r/Nzp6L7gSf4AVqRoOhfRZezPEIrVsHReMiTOO28
         wF2xvbs/OLOurQqxGzrFXTBXBc+tJepEpNW+sS8MDG8JwfgMRyRcOU+NkY1bZtTdX6dT
         4v00SJDTiV4Jex6wcK0+zkugft3O1s6A9l8J8l/CWDAJzoR3/TJ7Y6/vJ2reayfX9Kt+
         l0EjFluDo7TzXcqxhUAd5WZhMZjo2ZtVoJy4ubbZZjxj4rDuN9v/VHQJr2y9DiVAZRwS
         fAE5e2i7H1OmOoI0C157YLiGRJoHTfNa5TZ1LAW9BAAG5hrls8p+5cPaQ5kf+mtF4nE1
         BxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMLnHYZpkeMasH0XFap0cpFQ2tmIy3+mUPkBqUqwJJGSXHOmoLdxzy/wkU4hqeYMWiXSAN425iS3vIsu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThjiUTdi9s3pltIDwUldJyYB09tgnIBoX8m73iVGZ4d9Fx7w9
	IHotd8ymB0+IziznlYbk+PeMM/C3ExBwOaq4gkouO6CTaiKydSN9A/Lf1KUztAfOE3F4bB+XJfC
	p0+q/Im3qBizLR2eVAUb0FvG9rfhqKJRxL7zMpWYRJk6iQIQwdkxdzjTFOMudw1PgF48=
X-Gm-Gg: ASbGncsZj7PcYhqQZNbSmFNoAwY0VJtw7T2613adixuzmShKPtZIGzG87mmKRZFBxh5
	Q4n4UB52KpSSIjUNvE0yDLn/Vkgknujc97WwJPCTy3bA+AVFI54epmLeQxk0gfkiN+8KeRSlbq+
	Au6LRF+d33oJDXdihIARb7SvbaGtRztMgo8YAdiRlrZUkKclCBN/HhIVFvqKSZZyM49CVvlP4ZR
	/0OyCzLEf70Pi0SPyJjEKdfezSrBWF8xkyt3UaMbref4PPirR3j1HYor/5/IVcZUKh3rFbRoXEL
	8MK1tCg1lilyiwLniHaupaKmbFjy43C1DKqhwesXDr8atSI5d4VzXnr4WPMyPOaxlAEBlJMWOTM
	IpJ7HBs4at++F+ctVwNb8GEhNeidmDVgmWhiyihxs8QJlqQzQPofxyjew/kk3cgNLNjp202BIns
	ky2WXXT7hHv0LK
X-Received: by 2002:ac8:6f17:0:b0:4ec:eef1:52f9 with SMTP id d75a77b69052e-4ed31073eebmr185256571cf.67.1762147223420;
        Sun, 02 Nov 2025 21:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlxVVTClCdm2b14QJHu5NecoS0dWkyd0akYNoXO8ZN/iF/gNbPqXOw3mB1GIGfjm+us1bdjg==
X-Received: by 2002:ac8:6f17:0:b0:4ec:eef1:52f9 with SMTP id d75a77b69052e-4ed31073eebmr185256241cf.67.1762147222851;
        Sun, 02 Nov 2025 21:20:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5942e2bac22sm457536e87.62.2025.11.02.21.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:20:20 -0800 (PST)
Date: Mon, 3 Nov 2025 07:20:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Hui Pu <Hui.Pu@gehealthcare.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/display: bridge_connector: get/put the stored
 bridges: fix NULL pointer regression
Message-ID: <whkqe5j4ydzjh6f7qiiz5q3dpqwry7anadpzl3dfvjftz36tua@zq4vkvriadci>
References: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=69083b98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=hD80L64hAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AWrDNu5aXUrvGcUHwcEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: LpKQkb2zJp2lNAVvEBOE0buNeLAaWblm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA0NyBTYWx0ZWRfXznnimbVFLDil
 tjrytLXNJDf4wBmo7BIGy5FeRfKbOJGrys8vnFPw+YIoXqiVJ9tWYLmYzAJJ0NqdcrPdepcgwvp
 P5SHKnO2jtxqbAgWWJ6c/naWI8L4t/bLKGfk4Y3m4+Q/4FH6NLA6PoV1g3R8sXPxRoBkTc1dsdX
 5gQBwi5aiwZBXWU9FWYYFZkVa2iz0PuTBnwPs4QJERaLfk6ynqUVHWdUtm7o1j083yWyIs1Y0lS
 lNKM2ckkRQJoOFsUnnEdDVUWdZf92IwRMGCkQDV7gSBmzKk/A8IK2xxj95Jui+O3kKv98kN5/c1
 4jI01oW0EiBSuhCai3/kBWWNDx4PKtD0tC47oV7THcFJyxQaviNsH+Xx/GxrfGTuqe4IhFzwZgP
 E4dPMyZT7zsfRJgS4T4qkYD4aXPHEQ==
X-Proofpoint-ORIG-GUID: LpKQkb2zJp2lNAVvEBOE0buNeLAaWblm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030047

On Fri, Oct 17, 2025 at 06:15:03PM +0200, Luca Ceresoli wrote:
> A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
> deref regression (reported here [2] and here [3]). Being in lack of a quick
> fix, I sent a revert proposal [4].
> 
> The revert proposal has no answers currenty, and in the meanwhile I have a
> patch that implements the original idea but without the same bug. So here's
> a v2 series with:
> 
>  - the same revert patch
>  - the original patch but rewritten without the same bug (and even simpler)
> 
> Also the re-written patch is now split in two for clarity because it was
> doing two somewhat different things.
> 
> [1] https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/
> [2] https://lore.kernel.org/lkml/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
> [3] https://lore.kernel.org/lkml/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com/
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v2:
> - No changes to the revert patch
> - Added the (corrected) patch introducing the same feature as the original
>   buggy patch, and also split it in two fir clarity
> - Link to v1: https://lore.kernel.org/r/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # db410c



-- 
With best wishes
Dmitry

