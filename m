Return-Path: <linux-kernel+bounces-838148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4202BAE8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226AC1921076
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67D267F58;
	Tue, 30 Sep 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aYaUOS+V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA51266581
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264579; cv=none; b=R1tdgn/hdXQqw8y3PBIbvKQdDCIk+1Px0Zm12hURFJIeISv6oUGpfuiCeUBaVAx4jSmE5+iDSfYJUTqh3WzQYXHVfDosl97BmEEKCYsHtGS8xFBHPbNwFO2fg0afF+M+/2Li2/6GhVuQgTSUHu72AOMCVodMXIXHLdfuNOTY+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264579; c=relaxed/simple;
	bh=pYzmZMeM0haV1I7kxC+a5XtONgUKhG80+mi59Gbz8bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkgzor2/0T+hde8DifpJFhvQDt3ih7cJ4mRS2HovMACZ+2oWzhz60oPRq3xFWYFbCx5jrtHlr+ihdJXjZFjhi19Da4YB/Bplhq129qJSEas/YC8wPBl3XjB5/v6bLg3TCcqdKMfy0gnfDM8NeTZLHErhBnKmEOZ3dWMvS8mprXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aYaUOS+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UC72V2026871
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yRYR8mKHUZFaYtXuWtiKtjrk
	y868kXbSvHpGdSOUABY=; b=aYaUOS+VDv+kxGuS0EJOBn3jZsRvgFGBxtozbsMR
	Ac9vrucmrZxwlJT/bwVES0C71Pifkfd7jEhfBwDX8PcD1l+BQYW94SrM/q2VQYFW
	DSfhw+ZrjsVgjnjN/gMX7X9pHlZBAnLC3pmHy6IGvzJ7/kW1NQ3nkMSWJJZNaB5Y
	fqwcbk6Vrrulg2sTCgxyVF1pVKVHnRxqEWiY6/V6mgv48P3LGjUP3xBoVnS0bCFE
	J/FQSPRuSa+6FvqfGXqEGpQVYAki1/LYqW1e3mKgBLGbDe3SGHhm9zt334YhoCu6
	nz5g1QtR41tllKQaQNXpN4HQjHYEMTJQgrL4TMs19jbcUA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf3y65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:36:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e0e7caf22eso78932151cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759264576; x=1759869376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRYR8mKHUZFaYtXuWtiKtjrky868kXbSvHpGdSOUABY=;
        b=gAp+jrXnbHmve4RNKoFsw2ghkshdO42McEwRG1a3e6J/ot08d8/EQZFkS2dx5rUHvN
         zpeswX+3Dv2qaMXaTJKPOVrheU9ydV+QfYK8OTJX6WiJtJXyzFwGNFgMkiOP/894nWgT
         8qrvmvtuTMLWzUiI2ai2WQSJ5ELjWPnkZtWb2VhacsCU0OxFVzMxGTc6fqGo7ST1oplE
         3SrrbJzQlFJsKMlWhRy2dfsZTnSLztgKQnRCpWO7dxgdMp0hy4KM2Fl/wdFAmTqkohyg
         LIMozbfixrpVo8gSiYy2NVTNUPoF+EAQsu+EJWZ6PYcyqt2VW0ZY+/hl0s5xXzavjwKs
         Xhug==
X-Forwarded-Encrypted: i=1; AJvYcCWD6oNjJQ3joAcZ3HP617lUV+oY8XWiABqihbbDDOWl0jRhX1Cb6aMpnyuuSN6ls4EzfeYe4Qlk4VAejJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlRh4pxqUrFVerJ3/ihNCeTghTkr2P9pTWtVgWJMfJZQX17sO
	yNoxaUzYTgbwYKhPD88ytVARHgkFI+2OoH/jIZ3uOY8HJyUZCCIxkRVB4/hAANGyr5868/Uy3pr
	CNi/nBePFKPrcGOoQUBgXPKod25pQfr821X4JNDgnhQs9K+ZMWkIsi9Ges7VdFhJU6jM=
X-Gm-Gg: ASbGncvP1BJBvI7tFzS/soZRcoEOB12L1B3lplVYNyzfq+aSbYaZydELnVblR07uJRf
	klaNQNtkX3W2xMgXjvIWzspYm7SDw2TRLvPXlU1Bh7YvVFEMTG/A3fbPnvWZgqjMGoc1jChDnaD
	/5xLkKMKgRiuxSpYkXw2fPnTgT3q96nqrDyXMe1cp2jU7mdGPmENyC0pJahC8ZxLALqJfe3p3Zq
	3EmCn9p9MSeKmNfuheBWpRLK1Vct6HxSDXgIgod9FulApfm4lfFYKCEiUx2fiZKo4/O+rGw7PMZ
	S/dWz8HN7VF6DN/h+oSusu+1YR+AgMKy4stEILwD0oe1PrmqUFhiDhz8MkRKYcU+TUIZwRoXPf4
	WT671cB66f9UNMcBSdpxojd9vhC3+rm5/V1uVolanhiWNF3po5LdpeXZ/og==
X-Received: by 2002:a05:622a:1f09:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4e41e2553a4mr14266761cf.61.1759264575280;
        Tue, 30 Sep 2025 13:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFuPPlCXIV5zyuzMgVAJcVfckSn/45lViJoli6ItFTToo3aAOYLqDps3QFpjsl6dnCqLcS/g==
X-Received: by 2002:a05:622a:1f09:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4e41e2553a4mr14266301cf.61.1759264574813;
        Tue, 30 Sep 2025 13:36:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710474sm34821171fa.33.2025.09.30.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:36:13 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:36:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
        dianders@chromium.org, m.szyprowski@samsung.com,
        luca.ceresoli@bootlin.com, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 18/18] drm/bridge: analogix_dp: Apply panel_bridge
 helper
Message-ID: <aeby4ds46ehzkrvc32pjcrxz2aalpc7icuis4y4zxfm5kvgcg4@ie7m7s6rcnqu>
References: <20250930094251.131314-1-damon.ding@rock-chips.com>
 <20250930094251.131314-5-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930094251.131314-5-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: jBmW4STnwYmm0xrfeob-yP_LRQ04Gu_d
X-Proofpoint-GUID: jBmW4STnwYmm0xrfeob-yP_LRQ04Gu_d
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dc3f40 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=rSdC-L6FqKhTve90478A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX0ZqVgRRfTBZy
 dvrCOIweIxWiIP+uBxF+vUfQyn4yneM0hJ3RZitcZ/nOFULQAKdshaS7vdRpR0gM2EsF+c+BEsZ
 ViL4SdPlfPoiOENDVi2cA2M61VNx6z0bxj+BCmnOjzCs3AapqFHvXpc9qCE+os4OieursEq0IGp
 GAYQPCRtPlcgLX+tPQdce6vsAkwX4SPEOXo31tJqIoJ/tY2xI7iVBFttDB2GSfCW7fS8U0ghz/q
 14W2j0uyyarDt7fchTrN13allZigaNBmWexx6L8fIzQ2yMNRf3jRfKkKphw/p8A3WX3jI3c37IW
 O1FgkPm5hgrgeH0NaxSCNtj06XJ7przGMZurIhHJqhYSHTyEyDDzPqL1Am/ykyMqaVONSpCm+uf
 /pS+yxxBQliY/1IoHSUkSgfW+ecXSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Tue, Sep 30, 2025 at 05:42:51PM +0800, Damon Ding wrote:
> In order to unify the handling of the panel and bridge, apply
> panel_bridge helpers for Analogix DP driver. With this patch, the
> bridge support will also become available.
> 
> The following changes have ben made:
> - Apply plane_bridge helper to wrap the panel as the bridge.
> - Remove the explicit panel APIs calls, which can be replaced with
>   the automic bridge APIs calls wrapped by the panel.
> - Remove the unnecessary analogix_dp_bridge_get_modes().
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

