Return-Path: <linux-kernel+bounces-776654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8BB2CFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3593BBA59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA8265606;
	Tue, 19 Aug 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kr3KqPQ2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B52264B7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646154; cv=none; b=QpL863xsb1egdgp8qognGoObHgw1YmYQxzOcKlNDcz0WU+Jg1A89zf5QytYD7zI0xoHo4zjaFXvWKN7zISdbd3GXR4myk+KaiUWyELZjEJbgTjyg2IHPax9AlwYEgayeoBtRKAWOA3SadUdBv7ORqKNU5hmA5VVVoH4I+8K3HKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646154; c=relaxed/simple;
	bh=nlyN0emqFC5mah3+AEX+HhzrrRHCuhU8yafMr2P/Azk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcXkKAIcGTZtElaH330AJWmDN4eyFu2T5y+3idFdgUF9zSr4ioAYb0OXn3VEw9XeH9hHTkbig+W7wlViqDbDdpmTZkiLbttOPqY3vG3yTzzKGCIwjYJttIUyIkbyxCxUL2MjViIkFOQceP9L7Gu5P1Kae+yEJzuib7hOGv9o2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kr3KqPQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL0i7m029711
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uXtfjUzzByf11+oWG4pmF8mNkBkkbpFfD4T
	0474ANBY=; b=kr3KqPQ2BQHM8y9CIGwXmvqiMqQObMhTD79qY4GbG9+5kLjJsmf
	xpUor5AIH/xYM78EW+1aJjagj8CJ9GvfJSKYTbVsdkZtjppE8Lz1jpRdidJ4AG0y
	NKvJj8FnI+AFb8wND1dbasNCdM5r3QyEXE6DK7qifZ9tXmOc1ndriLLHaAyzAd3L
	DEng6MW4Dg+5AHMCom5acBZFX8tDZdzSRd49gOYZlsI90ztEGjUHSrCj+TInoZgU
	LAdSdkgQZkyv2A2R8jC2jNDyDyq67HsdYVau2D3TyFMcGwI1wnKEkuM2SdilTEW1
	+nkQdaekBLqhadKUGlgi8yGQ0FVu3HZsghA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0tdr8nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457fe8844so69286845ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646150; x=1756250950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXtfjUzzByf11+oWG4pmF8mNkBkkbpFfD4T0474ANBY=;
        b=MMe4tN5zdMfpwYjK2MLT5FlCXya1ckk9qQAnDkpThMx9/P5rqHDGciWmZ5qlVOUwBn
         w82VNPEbLfKA0VTkM9PVL9H3+JMJYhaX0uTEIlgLafq6k31E5vss4WYFn7HLzL9Mr89e
         Ht5IBKBAvqa0YEPB4KzBaNqn7DvSOpWNqbDZMrEvvK4xt5VSsx4rLavq2PcnW7d+/1h5
         n0UtiZOSXmMG+8o8Xro8DszWP6TCbxTV8EnxE7bYcgS2SztgNALUr8HJ6xoT72PtbTJP
         EyOjZ5S7dJwi4aNt26gzsCWu/INtytCBRLPXqhtf5YL+DXRlJ85jWFdaGTBbBgVkEchC
         7WHg==
X-Forwarded-Encrypted: i=1; AJvYcCUFZI0PWX5cwVEIt5nz7KW2x72ZjHH1GYEMai5P2UklJNk1H0dhVitaii6IX/QgPY095MKIdYyl6mwq9hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojgNiXJ0borNzLmjQUXAhcWs4c67dBiyXFsyq6zBhaGPIELZT
	+ZBimiGZIT9DfF6Li/sC3HtSwUtbMXz86cq39DSys46CY1Y/M0+JPHiIPLCP45mvHLyHS7F3O7T
	xvDLVi65KhcJOG22So4DEu6CR62QVXSaLwRI9pRleGDhetqW+HtG4o6M/j5Zl/jlwoiw=
X-Gm-Gg: ASbGncuVwQdCOykOKQ9D9iBbh+pCkyKXtdJr1OWiBdxF+Ji8D73ons2lmB28H+9JEIz
	o79f4Df+XTDNhVFEe7VrUGsvunIP9FSbxwN3wf7Z104oMc/HjBHvwEvZNgfvEdNpe0kTfWIJjuo
	hPa+v0PMQW+EB7ZcEGzwlyBsjlD6dNm9NntUn3zGAnYrCXa3eQn+SMEGuDjJqma319l5OpkM4mG
	ecVTxSKAeOens3caTqYqc97fGASN0Hy85xH8bCuZUBx+afX64Y+HAquXR9ZkvWJ59fVevDUVSW4
	1i+NGI50606PuVjf4RAVk/r/cDJDAPKXdwWw1yFOPDVVehrJNn0=
X-Received: by 2002:a17:903:181:b0:242:89fd:48cc with SMTP id d9443c01a7336-245ef25b64fmr7800895ad.50.1755646150141;
        Tue, 19 Aug 2025 16:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqUzvFcXROWico6d5Pqt2w0AvN4+pGykRNe2nE6KgbOBguGbbEYaRHz4y5taRq3of+8i1TGQ==
X-Received: by 2002:a17:903:181:b0:242:89fd:48cc with SMTP id d9443c01a7336-245ef25b64fmr7800625ad.50.1755646149739;
        Tue, 19 Aug 2025 16:29:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51a97csm8052695ad.132.2025.08.19.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:29:09 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/3] drm/msm: A few GEM/VM_BIND fixes
Date: Tue, 19 Aug 2025 16:29:00 -0700
Message-ID: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a4RpNUSF c=1 sm=1 tr=0 ts=68a508c7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=7-57VTQsmsoFMMg7Vz0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: eQc-ExLmxFx2Qf53DQlMXogfYnHu4Q_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX7ctE0eUXXzcj
 XuRJqBSR2GIGouBmJY67Fkgax6dga2w3MNvm4wNtcY2keCDDIm/wWzermbhJyXd0stMtZZnAQwr
 YOUHx+sov6nC5G+J0Q1Oyp59T7LrgGSFBe5zllIp7DdGynSL1ikyj2CrurxFX+dHSMdTdHvZc4r
 JVrzVg14Gw8dTBt+7OkDqqPypv7yEzkjBdsMcPp4Z/iRnnWQM/6qtPWSV7O/3xrEFcL6YO4bVSW
 EU+45N3Q1sZPGllEz2wCMlDSYGGDd1pCoyc3OYD+Of9bLRgxOi0o3kK5JFO/22HWbeFmJ8cZ3Sy
 BwVJKTzBpaeEjvzjsOeCVIgj9xWK0nXfi9iwHNlKd0IlOAX4lIXTr0k1oCDbWAEXUJ5OCRbOZy6
 5a7fii6cztQc/FRiNR0nO3NRjMz8XA==
X-Proofpoint-GUID: eQc-ExLmxFx2Qf53DQlMXogfYnHu4Q_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190196

Fixes for a few issues found in vkd3d-proton testing.

Rob Clark (3):
  drm/msm: Fix obj leak in VM_BIND error path
  drm/msm: Fix missing VM_BIND offset/range validation
  drm/msm: Fix 32b size truncation

 drivers/gpu/drm/msm/msm_gem.c     | 17 ++++++++---------
 drivers/gpu/drm/msm/msm_gem.h     |  6 +++---
 drivers/gpu/drm/msm/msm_gem_vma.c | 31 +++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.50.1


