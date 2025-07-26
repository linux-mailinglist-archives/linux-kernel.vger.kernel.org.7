Return-Path: <linux-kernel+bounces-746542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD7B127EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E5BAA836A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D431D554;
	Sat, 26 Jul 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShqQ6KY+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41ED290F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488946; cv=none; b=o1nRcYbRW3WnwWAIhOoGRTPPrLh9a/h56q6Ls4q+P2c6qP9Bv8avEonIdCXmqo3JKIqSVMkLUZRP0a3R22GTeHpR437Bgxc0qc8INCSlJRq7YKHQB0wyWCG9GBX5Cka2hAx/tA4J7o5WBXIKBhKIXJpMQ2hWtJE8EDomZ54fSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488946; c=relaxed/simple;
	bh=FRapydIMxZmNJrM9Pxa1A1VBqPqtUQ6OnN2R/zJBoOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt8DJvXbocKhaMbKcem1cwK1y054MH17e7npCv2pjgpKFvypFr+HlUwK+CrpAHIisReBEKwT/zEx4G97bNOtTzD9ytiUbXPQIgPwnu81DAzd3TWIHvfzTme6p9cAn6iQ1gepeTQfQ0ENWg5Movhi/02DnPDqeUtpT0iB2bCrVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShqQ6KY+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEIf7p016786
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wc7wbesunn622E6lhLM0ZKBY
	dN3sWZP6DO3RHiTM7ok=; b=ShqQ6KY+EvXQdv+pJtp207j/oBCI6PI91JG+xF4K
	ENbUXrQUsRqAImbFnEwjKPynhDig8hIXtaqX0Dsu9OWjF0Qg8waVyefba1Uje4Di
	VN55T/vSLEfn6JkUM3LcMG9BlQuIpotnjVBTiaKe86e5Q8JAJ2zxwZ5n1yuHfyvS
	pUSrAnAYTobW88AWgrAkeh9zycMsi7Nm6W25wPprgLQ15uHBXVGnKA3o47zFrcCf
	Bq+RKgMEz2qaN9SJZZaLxrbGM2H1xEoiGX+NrqlwMUD8WafEgrklNZiUR1fGknOh
	PpGRPXoSvX8BqZ6VO3oOc9xnZPO3oI4l8Wh8vlVFJFTmZQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484bjq1g8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:15:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb50d92061so41204976d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488922; x=1754093722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc7wbesunn622E6lhLM0ZKBYdN3sWZP6DO3RHiTM7ok=;
        b=ZhXTfP01TCRCjoQmHcUcbtlLl4izf9rRZ+D77HBOm9xzo2CdY1QUGwR2ldWj9RJK5k
         3K9uSwWuasDfFzUNMzY6XGAxbU48kfc1LNGWTYMDq1T7OvcUS+mHmxMYaDKLY+m05sfC
         106yFKF6NKzA5bJEy48JaWwU7LuQABulzAKt53Cp1vEJr2IaZRJKw0pzyGH2GE9OZ6fN
         INUHnv0c3ofS8bdtYjIZ9T3QMGsTEhFu7djG0189BOsrvcgilFUoHnIPPhKQlyP0D2pu
         37Pu1Dzf9xKXCl1Q09sT1AmzpBtMYIugjbdAyMOxL4ut3Xz4QKy1o0q9EJeKg5PVm/i3
         lDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1tbmvPxzK/9Xpv1NazGabY+MhqdZnnakNSKfBxZQMErqRYEq18GN7y8qCQKHLBIjztBVe2ixJ+a5GU7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdGF+j8Nv+nP+NlWY3wgFtExIjEXZhVYdUPQXLFq+AybeHL/T
	6YYtKbsjOopUthgglhvRSkHiv5TOeUJFWSnk42QM/cS1Ax7hXbNeo7clRLQzMQnH64PfXagxdfJ
	MORnM6kcT6ymy1A+GUrBi9gtB9lbM+oIX7cu84zPfD3ASCC0Vb03Trxlrvvrwoq1fse8=
X-Gm-Gg: ASbGncut20tc8KztMk4bl2taIR7lxiO64ii5wpI3j6/jBcXED+YDU37tsMIGAMrksXH
	EE9Sl7v0toYXMH4m1keskKXVtio5idhqrGQHsGiIjv5+5b+Y0N5SxZXC+wzqMV4DjMwwXzPoeTp
	KUJVPD9FcuqW/Gfcflqo0TwYclnO7sSp+UJDCaUQjRXmKvEDuxgN+iJ9Ny0Uyf+kf2C2cBfd9CK
	UkGk6x4tdaAwN0M+0LJGXdQ3cA6Ui+QoZFtxrrzcZoPHiohKOYk/hifzHnsfnk6grBloEOJBCvr
	nXbJSdKGfy+yyoOE2iRDX3XCUs97c8HGPGsj6YHt/8VwRps6Lmd1OGMh5gof82L8AcsTwQqZF8a
	seJjLkxqtiE8H6tYhr5IZyfIN3o+gU9/eJjh759DB3XuWCuaKWuDg
X-Received: by 2002:a05:6214:2a88:b0:6fa:cc39:68 with SMTP id 6a1803df08f44-7072053c3b5mr42704326d6.15.1753488922018;
        Fri, 25 Jul 2025 17:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxKX4spzgAgy045riATOyKNu99U7axrHMs7Vy4UMZ91CFAU7dGAREfsaxr4wy+fd4nCMcT2A==
X-Received: by 2002:a05:6214:2a88:b0:6fa:cc39:68 with SMTP id 6a1803df08f44-7072053c3b5mr42704086d6.15.1753488921541;
        Fri, 25 Jul 2025 17:15:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f427c501sm2101441fa.77.2025.07.25.17.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:15:19 -0700 (PDT)
Date: Sat, 26 Jul 2025 03:15:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 04/14] drm/bridge: analogix_dp: Add
 &analogix_dp_plat_data.bridge
Message-ID: <kmgosc2oboburyxrk6drvfghqg3eo3z7pbeywlui523aoqyuqv@uyog5cv2ijq3>
References: <20250724080304.3572457-1-damon.ding@rock-chips.com>
 <20250724080304.3572457-5-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724080304.3572457-5-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: YVeReLcRtW73YfUND9pblNrddXMbXBtc
X-Proofpoint-GUID: YVeReLcRtW73YfUND9pblNrddXMbXBtc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwOCBTYWx0ZWRfX+Z8PcCeQhCLg
 m5QjS1ohbSbfCchSgAZtvCz9j8SkUgX4KCw6y2KPbJBox0JSvvprAOZTdpFtwqHw9ZXCIw/MMyy
 6x6hmUhrhyy60htS08rhWq3qDaOYs96aMMTj0haqNfelyL9pmVgNIcEYnrUvazU2UAJgYEKxHTp
 mXOvVCEsWYgEIhTS3PMpZprJytqU+cyAC2cCZYJZYXHTtM1gU20EZTa/Q8lxOp64z/gPGvHEHpQ
 BXKRy00N3ZIi9WYYsCN8bWLtm/2tzRpDyCfwr1AS1Q5khWDQfejhgTvUC6fFyprKSZ16HDA+4FZ
 03YtEtaMzsWkhuGTdomz8s1ozx62ICc8WLZwrieR0gPvUdFG4CnU9DAJnQrG300xFfoNp/Ln6JC
 lqB3btq3HJbsf9zVGZut/AXd1pk/ZFanGpDewU/WBNdj7+U27JmqGMkhTIgKP0WWIhWeMfss
X-Authority-Analysis: v=2.4 cv=KLlaDEFo c=1 sm=1 tr=0 ts=68841e2e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=Ui6KuL_mdHivunMvz7MA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250208

On Thu, Jul 24, 2025 at 04:02:54PM +0800, Damon Ding wrote:
> In order to move the parnel/bridge parsing and attachmenet to the
> Analogix side, add component struct drm_bridge *bridge to platform
> data struct analogix_dp_plat_data.
> 
> The movemenet makes sense because the panel/bridge should logically
> be positioned behind the Analogix bridge in the display pipeline.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  include/drm/bridge/analogix_dp.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

