Return-Path: <linux-kernel+bounces-754801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C2B19CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE113A8E21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799D239E7F;
	Mon,  4 Aug 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nCYLKTvw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165B45009
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293773; cv=none; b=iT6thexujsQXAFRNT5Aevu30PKaXFeeKhbmrbfZKZepTTw7tfM+L1+Nux/JX+zo5e3XNDlQv78yeVyMkDoj2gVSWTV8aB+c3dIgjSNDyuABRBsi+rlwNMUBTVM/JsVdhKRbMdMqiMAjTVxPjrE46jWgYxLpehoAlrQ/T8DC+qC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293773; c=relaxed/simple;
	bh=pbf9kbxQEO8tVD0UwqrQb1DBFsqQAC8swTZLMbkbQaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Om83bG7JP2dnWlsgrOirlEWkd2W35OLIus713MjamsFQDfhD8Bz2J2/8lDdeUkBUZdaLNGQtB+qYQCBZMteGeTOppzcGZKaQ2d8YfYIlp2iQUTgNKaeffNmI9uEbwhq8czIl8cL3qtuvA3M0IVDUt4ZsARiqobe7guKA624Mw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nCYLKTvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573Nmhbu032122
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 07:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	STOBvxiI8njI7r5I7q2kaDJJR3rz10/Df51mAVUAL2M=; b=nCYLKTvwlBRCd5Y5
	Huoer+5K+4jcqskDQy9VGJXXSx5AXdIp7RkOC71MHy11ztWmUZsYNKlQskz/k6wW
	W1uuVX3UBnC3srBzrEcchKDgNAXWEcBB5dGm7M7pxwvDMvE0wF3alAOz7BnjD/lJ
	HD+wjas3BDcMIYUt21AIOEOm39EqD/c9YQMCUCINBlw6YDP0y/oeTSrchQZwAK9f
	+TGcA4Y300UYQCCqjvpp6grEyJimOlf1SIPFF5wTZPUzRVYwquXJo5+Ysdc+pID8
	gYdHQOuI+Wc3BhJ1i4NLZinTPRf3DX4QQaR4pld2FyrRkhvU3lL8LgIyPKrG1cQI
	HW5A/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwkx5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:49:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e623a209e0so665395085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293770; x=1754898570;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STOBvxiI8njI7r5I7q2kaDJJR3rz10/Df51mAVUAL2M=;
        b=TNECBPlJwlD0q88w1R4kyvdNSJ1ZX3yRfBAKaqHFwYQMbQ0kv0739ZWOyccvbtY30S
         Qss/hjAVuQdBhrOOyI1sDWBrHTBLkaXNpK82BcmSr96G9/M+UIz0tQ6NTouehmMwnMhI
         bc1cZ9JtvC/ijg6DGVxRP/7RowJqJNIhHskZqDRN4qzFQL3RDxrFsw1EHY2ubxbZils3
         8nu7j65sHWo29iQYwbvxZDNzXYYjkfpJHbFlg3DvpSMHs53yU7dkZfuBru7oEg1KmPRR
         5WgWIPd0lJus+AN/uLSV1UGXBvtoEP8B9Pz/9pCYe3NitSLPKQ4DVdxkoK7gGHcgNdU+
         zcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpGOUp6HMegc/eslhsFt0qEz7sYq/MIXA5JXbq0w9MRaFKQ6G31iYLsGCavyX7Aof0npBNk0G/trV2KWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpsOiXKkmYIOwMiUlpcl5l8m0IftAx5iPs03pVKT2lwtl+GyN
	VSXdLN0c+rUHbBZ5l1WuBfpGwffwzeWQd6j3jNinD2jGCmfNRsUVbabCkAh26YLZiS9dGw781Tr
	3WNgiEAZMpSrqkg304wE20de5ItYNGe9FrBrOeCSThtwxAuW89v4mKYVI81iwvlOMocU=
X-Gm-Gg: ASbGnctDHhns8D3DZJ61vwuNNInVChZnxRR5si52VzOd7bZowln8hhps2YQ1IbBcbfn
	zX40+GQsYc7ZPoKX7UJnpn4c8fMfE0OG03Yw6tiL/+3kpFv7M0BTcPorGG8Jo0X3M+/B6HKZppX
	/aIsOb7tXiLeyVq3VQ2SfNaMbLEUDNW6GN2vLWutWnvAw8XMQ3GkZW+g+jQvKC7G6jXAAal4TWn
	f+6nsPwLvRZ6RqA6IoKyBg5NLD8oSgtG7XxwSKoCx6M1Uv49oP8KwFV57pi55ZzDTNUkHj4WMPY
	NB/G/DsB6NqMZiLkFR3YYQDDYkXXwxanr9fkFLJuihDSihrI6lGacDXRMumHsA2N88WF/9z/ung
	ZbfMk4xJKhsbdAFOmiTEf2fKz8e+tEsUV+4nyg0BwihPYD6E7csn1
X-Received: by 2002:a05:620a:8c2:b0:7e6:8751:96ae with SMTP id af79cd13be357-7e696354949mr971852185a.31.1754293769768;
        Mon, 04 Aug 2025 00:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsguIUFIUKHYWXeH9zorTXCF1lcfU5CMnhov8eyA4nrE5HjM5lQxXvbmcppBsUJW0Xd8BB2g==
X-Received: by 2002:a05:620a:8c2:b0:7e6:8751:96ae with SMTP id af79cd13be357-7e696354949mr971849085a.31.1754293769324;
        Mon, 04 Aug 2025 00:49:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c35sm1583782e87.97.2025.08.04.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:49:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: simona@ffwll.ch, sfr@canb.auug.org.au, airlied@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250716125602.3166573-1-andyshrk@163.com>
References: <20250716125602.3166573-1-andyshrk@163.com>
Subject: Re: [PATCH] drm/bridge: Describe the newly introduced
 drm_connector parameter for drm_bridge_detect
Message-Id: <175429376814.3371239.2255431284571654871.b4-ty@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 10:49:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzOSBTYWx0ZWRfX+lDIDJ27r+4Q
 qEKyL65yydXTc+bWy4Q2S2mtWme/53pL3KYfBRoUwGBWtPV+IZTVL3lrIlh40dLWf+08FncjMha
 Q3y/cg75rM9siFc7tgRdPhZZ2pVr9UOjCxkUYIMSD9zeZSxzef9prk5us490uQMPF1382JiUC7f
 WYewSkEMpTeputh1Ea61mHCa3b/uxDs8gXF1IBVVjqlHb520nWLybr3kIk3I5bfxlABBxwActOL
 CbvEDVq+0lnUUSyRby64Yu+WvLhDo6aU9ccAuIthpL5b4gKCL1ebL34fSroz4Bd0sbsWISX8sTh
 +Quqyvr0lUyi6FWihUMLtSNTNbyZuPZqf/nmzaCnB6haRZ6noK2MH0E0iyb3TeTt76u0C1jzE96
 YXC3/jGqDcFmuP1BLFVnB55nTxJKMkkxJbNDlUZ5QfBWkzfr9jAv/IzayGb7+LEtnbyBzPDu
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=6890660a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Xx17V1t0QfcI18h7U9IA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: CtVpw7sGY0qmcfGppmsdHDsOSD4r4nW2
X-Proofpoint-ORIG-GUID: CtVpw7sGY0qmcfGppmsdHDsOSD4r4nW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040039

On Wed, 16 Jul 2025 20:55:55 +0800, Andy Yan wrote:
> This fix the make htmldocs warnings:
> drivers/gpu/drm/drm_bridge.c:1242: warning: Function parameter or struct
> member 'connector' not described in 'drm_bridge_detect'
> 
> 

Applied to drm-misc-next-fixes, thanks!

[1/1] drm/bridge: Describe the newly introduced drm_connector parameter for drm_bridge_detect
      commit: 584460393efbcccb6388b1cd5d37284b5326709c

Best regards,
-- 
With best wishes
Dmitry



