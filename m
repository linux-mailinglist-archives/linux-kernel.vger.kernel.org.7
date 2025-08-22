Return-Path: <linux-kernel+bounces-782565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B33B32229
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF983A76DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F7291C07;
	Fri, 22 Aug 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIkIhtgd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC02BE02C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886343; cv=none; b=Fa2LxKio4jQJZ0TJOXAi68mdIRFhfdl+qJ5zBrCHVoXF26ZgFZzkGYIr21mU3dFJaErb+K/xBSbHwTjNDtx4WQdNT2Qzcm2GVVjfV+hlffnc3D9cz54vTJeZm79XCcUINEQefSOTraPSmKJhQCNSfxP0AeWyDIsrF//st85GjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886343; c=relaxed/simple;
	bh=RAxWI0euiUT6SEQblqsBhwKkDxfsL904Z6hDWRCsopQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo0xBXxEpaErejIzgHGLNQr9a7ec0tXBZ2Ov43RzolZ43kErxSflhBjXFS05l/riDYhWjFiiuQ+40Dt3UhzAWug1U+g74eRkD+SQxllfPGUNjyQhHU4FS/+chruVOFtLpcq4q93dYMVHmpNLTQLs5zXUcYLOzz9idwgdapyIsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jIkIhtgd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHa7Bq026217
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9F4kF/0PG0gqpOGPryNaB+t1E6t5FiaNAX6DsaIWBY=; b=jIkIhtgdj5s0I7Db
	TnMfmrdMghAf+6PpmRtcXHMhhLOut7gGkaK1ibTUkBVDIeBKf8d6RUWjayhKnX5h
	bCKd2EWhQ0ZEw8TUbR3xmxsuoDuyYDlZHv+3nE5y1fb73/6lQYfqCBYc8/Y+kknX
	oOEgAi7NKytojhlzZLvyKo/vxb1xZ/dTu8mBROnHUP3szxGUWlO3pLadCOXnWCLP
	Y/H6d2K8O5zwsBE/P2m7osqazaEaulLzY2VpvXE9olmN7OkdcmPfKYdAXDysVH2h
	+P8T4ECoUMgGVKoNdNn3eBJ2WgZECC2OOg9fV57FAVh3yc2yJC9E87jDJIfTIeH0
	lCuJuw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw3cg3a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:12:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9f5bdf67so20768116d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886340; x=1756491140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9F4kF/0PG0gqpOGPryNaB+t1E6t5FiaNAX6DsaIWBY=;
        b=PbXRRh0NlwVZ4+Iz5B7f0VXL5bzef0Rz/mkFIi2g5YAZaa50j5P0FB2WveXRSg0lbw
         0Bz2d/wiCDyDe/K05y2GquUEZTc4p22kh9HWG7amOGMhGVPh6RJTx3cRIJJPz6saUprD
         qtnFbF7B0A3Q54bCo1sBSYqmbqQUClGpMO6Z8B7ZLSjgXROymbGSlhc1tLujFbVpAIsx
         3V4zpC5Krl57YXK261GarJtOthkn5PvYwjyIPeP/p3sFc5AIYlTiaAqkqpfBwJf1aveh
         o0tg3qcaQIxalDEJoLLNJpgG0bqRkaCU3K77dpOgPPSOgVFnJNZB7rCtYSTj1OG275+O
         7YnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFYbN39uUm0pgKyGE4Fmp76MK5hzgLVDcp9uxMf4+2x1ikzdM/xn2wqe3AtsvqUx7Dx/nhNMFVd/oFesI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN2HLygEYU8tD15UwGnV6Qw8lKeWo5NSD5tilFulacWIioiHR
	Al0kv6gm7+AVoPIei8anSoEbRyt3Zw3rw/SCWhYnjKp+NAIYapdo3HjgpUDHA/faNxzJn5Qvg1M
	ViR6azuaTPP1WMsvRx/ldCJD5nDzpYZWvdzI2GHelRkAOWa337Jn9jqUGQzxaq6HQg3I=
X-Gm-Gg: ASbGncup8t7jWm2cS5a1M2udQH5gBfD6fojolS7zORHhdwWpQMFVSHkdHJHEG6Tukc7
	UoyIxqtcNipaaBTaDLzNlQd3PeHnR7qd7gC88DSTWhqRpuyC2udk8uqIrvVdsHDhqMYT+HhVO6a
	h0YrmwBbTouadC4D9iX2hlAo72NZL6DO+A8H6TWgpuRCk6D/HITTBDgYt2+ARTn7JwXa0V6hekt
	iAp25Ihb0kuCOVCzR54zav97QIzdaPq6Ah7hjKa7S4fUGTTLpPbVdFnOHuLJUwcjlgR3RYzrrV/
	A6Xx65WqMHJBaQHszbKTSvhD9Imvt2sgkRbnon5X45zjs4oFvJbXdcBqg+0Cke10V0wkE2bbCvn
	P060baMrjjZtPg33IPZIndg74AsM2Yhma52lXQ7Nu4Xyp+a6xLa98
X-Received: by 2002:a05:6214:2244:b0:70d:a4bf:66ae with SMTP id 6a1803df08f44-70da4bf69c5mr19413906d6.12.1755886340103;
        Fri, 22 Aug 2025 11:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ9vrMkeP87y8XS1HYbM10ipCEtP2NQ/1/i89/UBtmnM3Uakd6ZPlSGQcOg+/ENSPZGgsjeA==
X-Received: by 2002:a05:6214:2244:b0:70d:a4bf:66ae with SMTP id 6a1803df08f44-70da4bf69c5mr19413446d6.12.1755886339585;
        Fri, 22 Aug 2025 11:12:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c01e5asm89897e87.26.2025.08.22.11.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:12:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: heiko@sntech.de, Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com, stephen@radxa.com,
        cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org,
        Laurent.pinchart@ideasonboard.com, yubing.zhang@rock-chips.com,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh@kernel.org, sebastian.reichel@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Date: Fri, 22 Aug 2025 21:12:16 +0300
Message-ID: <175588622226.771426.4504932000654632813.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MSBTYWx0ZWRfX0mow0goaAnKZ
 jYtD8627FCaPRHHd4K7VbgKRNzOa1FEZigjyF6buGaoomjBMPZaUqZQ+XCcz2wvCIlpvk5Tgw7Q
 cj0z83gaLPIxTIv1JUnWANsv5Enc6hpvAuHaJlihNbx1BOgqCgD78UuLYgZWw7tPTXEa7MPXTsf
 eWG/n9zstacNqXmip8E3IclXM6Z8EWCcQJB8FGvDbacYY5KI9u2l51ODvdTjl3ruva5RRXnmzJ1
 eC0I+jlTsIy6MYzUlOXQN1OSHgJf1kHQHfRPVq8CDMMXw45HHWc1v8T59cqUIwxJQD2300rVk0V
 phjBs7CHuBEZDCs/lIDUDhJqEgesvsV9M1n9NibX27JI5YYd1RP9nvOVgr+uclSMA4LFbMa79GF
 NrFxSI3S
X-Authority-Analysis: v=2.4 cv=EJ4G00ZC c=1 sm=1 tr=0 ts=68a8b305 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=s8YR1HE3AAAA:8 a=u1nK3qfxStItYws1ViEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: jzh7qmVV6gKPyDOK4Y6kz76y-GzlbAn4
X-Proofpoint-GUID: jzh7qmVV6gKPyDOK4Y6kz76y-GzlbAn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220161

On Fri, 22 Aug 2025 14:39:44 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> There are two DW DPTX based DisplayPort Controller on rk3588 which
> are compliant with the DisplayPort Specification Version 1.4 with
> the following features:
> 
> [...]

Applied to drm-misc-next, thanks! I will wait for a few more days to apply the
rest, maybe it gets some more R-b (especially the MAINTAINERS patch).

[05/10] dt-bindings: display: simple-bridge: Add ra620 compatible
        commit: 480a76c64f4f6a7f8d4aa2ac86cd2178687716b9
[06/10] drm/bridge: simple-bridge: Add support for radxa ra620
        commit: 73b81fcb12df1051bd169e488245f8bf4c37bc93

Best regards,
-- 
With best wishes
Dmitry


