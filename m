Return-Path: <linux-kernel+bounces-890502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D59C40343
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB2C4F0DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2401D31B9;
	Fri,  7 Nov 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZkupkSb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R9fmVyeP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66E30E82D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523587; cv=none; b=lOUyssx8l/SPdw0QLyje/HNZaHe80lb07/yG8GXId5ejAxUbWIWTVLEtTQifrw1ciGLepGhzDCTon7kLt2dYWXellQ9xrbBHxUAY6mo0B5JF4FWILmmVw1FeCvJfhWQK8849vSAUWGqSp1j8hxI65d0q9ivua6oJUdCufpLWqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523587; c=relaxed/simple;
	bh=cAbflNaU1jJlHuDwNHN5CyfiHqVWUEWBVibq6fQD71c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWt6cUvYyQypsLrMZCtUImUk5MJukHJEX8ZmEeqXWFwr2NyCtmAtR2cR7u02iozGOwAbZ0toUzrIhxgXHQWnZqzF63u7elpaxSYoS2kXAX7AgTJC16EbVfdfA7WFBG6Vt3YDzfuRkrKq1pzxv8NKDuk1cSmHLfv+AJlKbvfMGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZkupkSb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R9fmVyeP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7DPQ893129784
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 13:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/VVmRg18NY3wj2ZYE0m3Jiqj
	XMFW7uHzd+kVJOSzKrY=; b=aZkupkSbWyTHdHRM8bQYeP9AqR0UZ0zH4tq3AtYE
	4Sdz0i9IJmA96W8xvTYSnFnbfMZksavsZWtm3bBtdBck0lO0+UhokJj5WDoL0SE6
	Ifb6YuqmuDEhlP2KcBMTm+7dTi84Q1rffRPYrc7uh6IHTXIAoVVx2MNk5BwuIMrz
	Lqu1VWiaIKCChJyQnj+E+W2qOwZYJepNfOuXOinKGF29s4BWRZSG725ISQ0q58C8
	Dg7QFWeY3or/EoTDoxByrSi0Ev079uXY3pZqbpQw4o+yS0CESAVVm//101Yv1jvI
	qohadK+9fXx1cFXWPGrt75E5p+Kid2UK1qVJzzP7vk1Vfw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9hn081yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:53:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a43210187cso792785b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762523584; x=1763128384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VVmRg18NY3wj2ZYE0m3JiqjXMFW7uHzd+kVJOSzKrY=;
        b=R9fmVyePD89sbAK31zmIkKp755zP+rQ91ITVD+KFu5lUINBQUh4x5Xv97UZVJpgCZ0
         5ghO9zEx1aA2lapsD+CSIVSb2qjhIi2sRIjM+Bqmn5OMJ5I4z/dWuGRW3rBmM7D3vlXW
         x5I3H/lS1CmrOvS7kghGy4qBWB4FC4MtE1ixKonzmU3OtwpCAD75xa89C7j/xf4a4NhY
         1OPQPzavT6dxN04hZyx7CT0BE0C0gcueA2kbUsdFvN71lwTQ6tFtOkkqK52AOa9qOYv8
         l9OATfgjCVcYT2Nhp32AiUiPY5bcL1PtP0gznzEm0Qx2OPxeFokc/xNYQCPb4si1z58o
         E6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523584; x=1763128384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VVmRg18NY3wj2ZYE0m3JiqjXMFW7uHzd+kVJOSzKrY=;
        b=BxOPOzlhoE5iKjAm37uFgXJ9X9E60XT3s9xtnVzNIbUT0t4dQQj1Rrt4sWGO8iyFCv
         yyjSUKJAdjh5v6kMUhB/QwQPZ1oKmpEmnZfp3GeAv+ynhQxpTcFjuq6yxkKWAcElXaPK
         b1hAxCYTvSCLJEPBs792XGp/kdBXmPCrrf8R9+w5e3GgGUO0bUsMTTORogUVptfnoWxJ
         7K140PfX7lAytwi5b382gcPOARhHY9V8ciM2Zkc4i3nKDpgNOZdKP1Y5qFFVOWZqfRp9
         JawJeH2YaNy0707bmqAA5XZ72CB8gz3/uOknnhaPQgsqj7bzTIQbWZQiOJxwo5pgLii9
         F9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVzajNkgomp8gQXFsxtf+pNNK1I8hJ4UdDfpw9l1rOVl2cRmFjdgHe5jfrxhODgj8/kSQ6FAZ+Wwt3quXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmgp51jwBUQo6aqT9e+PgBnX6qimw1kvsU86v0Scgjf4rkdk3h
	MgaRnlN4nnHY/3Pq/JxJ7etWJKBnfhPvOyC4kjdZndYE5uywS5jani4pTx2pEF1BzUdEjw+QQtD
	+7m4e8Q/L+nbOGLXswC7VVMyIj4eZ67mTLE3jidXiOvIvZvo3Twjciy0izizNzmrXQQ==
X-Gm-Gg: ASbGncusmS2CSCIcM9Ki6+Ur4bUsZ3o/mT0hZG3dj8WzGX5qPXYHwgyFwi+aUAxiSMo
	1qTTzAesod//Km4jBZMQvBIeBxASv2yAK9ZQOH33WI+fUXiHWwBByvZ0MC08DgSjoOqgE+QIAx0
	2/y1QsymCKWIPNdo5fv/DrNWpjwXo1ThOiMY1TToNZ4yII12QSgH8iFiMNJLSTjR8kG7Jlwb3WZ
	YAKlvIVc8o5L3oNkQg5+XclcifsDtDJcLUwZcFF1cd2Hs+YhDlQB3FF+5JwyOfedtF7giDrIUD8
	dbjY4mx3mmnNUVX8yhZB+5PwfvuKKUA2mJt4T8bkE1Who6oVkiPYUJSCS+Ix1s3JZLQQ1wk0f4g
	49g/3ona9WzHQC99bLVr+4WlT
X-Received: by 2002:a05:6a00:3cd1:b0:7ab:6fdb:1d1f with SMTP id d2e1a72fcca58-7b0bdf66564mr4419015b3a.29.1762523583559;
        Fri, 07 Nov 2025 05:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KL3sD5hZ70NkXwEbmWRrK4jE3iJ9mGDdh1VUXj2/vuQfkmiiPTTaWojwx6gzMqeCFkjGnw==
X-Received: by 2002:a05:6a00:3cd1:b0:7ab:6fdb:1d1f with SMTP id d2e1a72fcca58-7b0bdf66564mr4418992b3a.29.1762523583018;
        Fri, 07 Nov 2025 05:53:03 -0800 (PST)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e2a4sm3160357b3a.6.2025.11.07.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:53:02 -0800 (PST)
Date: Fri, 7 Nov 2025 19:22:54 +0530
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>,
        Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <aQ35tvwp90qm57Cl@hu-nlaad-hyd.qualcomm.com>
References: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
 <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>
 <30b5f19b-1ce9-4239-bf0a-d83d647608ce@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b5f19b-1ce9-4239-bf0a-d83d647608ce@mailbox.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExNCBTYWx0ZWRfX/myJ2kVm2C/T
 S3QaircwrAx9LwlwiQI4rJIRkolGTokyb55A91tURtjNxAGpYiaXjANnw3rF9wOobYKtk+LaXqu
 OWeXVDGMR/4YgQibTteFL9HJ6fXBMCw9SdorsvwUiutf3errrxpWNST4b1WYjpNbar2HA+Awkhf
 KEhk7nOGxN2+P+TBcr+8ApgFAEZZYjA2NlJ+q+XNCUsflpRonvZp2BUm/IVC4Dlms5GyNPmz+o2
 e0Vo2616OBy+WV1dXHqYfIMOxrE7b4INkhdAlKlhpRzqkhFrhijhnySdRsK5BqBMlCHH9ssVhYW
 dITCbcqogj5sa7sYk7DLcG/uhWu9bkVmcdbQ//WUtT8/B4R6fadsNqlPnINjsty4Bbn4/hevT1s
 V8UKUAGZ105RITQn1rAmKrLEytHUWg==
X-Proofpoint-GUID: NbmazkQmxg6ftaRJw7NohHou325klEN9
X-Authority-Analysis: v=2.4 cv=MsJfKmae c=1 sm=1 tr=0 ts=690df9c0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zAaMOjnD8X0J8WzHdTwA:9
 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: NbmazkQmxg6ftaRJw7NohHou325klEN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070114

On Fri, Nov 07, 2025 at 02:20:58PM +0100, Marek Vasut wrote:
> On 11/7/25 2:02 PM, Nilesh Laad wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > 
> > LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > Add support for DSI to LVDS bridge configuration.
> How does this differ from existing drivers/gpu/drm/bridge/lontium-lt9211.c ?
> Can existing lt9211 driver be extended instead ? If not, why ? Details
> please ...
LT9211 and LT9211C differ completely in register programming sequences.
Even lontium mentioned that register configuration are different for lt9211 and lt9211c.
Nearly every function would require duplicated logic with if (chip_type) branching,
as register sequence are completely different.
Having both sequences in single file is not looking good, hence want to merge as separate driver.

