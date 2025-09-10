Return-Path: <linux-kernel+bounces-810987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC37B522B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A568FA07AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2430F945;
	Wed, 10 Sep 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrU8KvlU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B430DEC5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537070; cv=none; b=KPIZHSizfBwHadf+L6NnmooTArA+PN5ZhUMvhTzy4EzwoizAPT4aVHPeR4J0KKrbAcXhSz3x+cmi/IUrNsL2yoYGNFS+5KduC4otjSW6iVtRFXRr3yfk42Rm1aPiL/mVRIsxvRMMp2p03o85PubW5PDQAqUufQAp49gABh5tqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537070; c=relaxed/simple;
	bh=J+p7EMrTz5Ci3v4cB32sGVNKuiRkVCCBePNgL++HPk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PEQqZhOi5raF1koUi1Te3MF+okN7zS5Vuwdgxe+8T2HhpUrvuGY4wpybUy90pVP3edzyiW7eQ5kP+T2M5knD8covX/PKwZxbBfyLlsD7Twe0+MEFrAcduXVqTLYabZhDXeilQ1v8dTtc/yiX/pYUTfxkRBvc5oq3qEWBBl2r6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XrU8KvlU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgWes022254
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nWIoku7RCCmxR6hiLsQeRJ
	gxh4TQgexEWCOmvJvrbBE=; b=XrU8KvlU3vGyH+KjktquJW/5Qdf2u74w5e7fCp
	aeasgqh6UBtPmRY0Pd4JlThpVgJMYBBQKAZP6sNseY2UG3nVeKaunThETKPEE2T/
	GsvAC9/aXv3SUKokTYn24jrK3ZWS9kYfHtAZSt1AxFFmDZrTP7Bq8PvEqg+mGjFE
	hFD8j+G2tj49MfeijhoLY7pXcjOg+kS/SCtJ3S3cRZNheMSz3yzTLsZs8sFJyXcQ
	xKS7wUrdqvxSGJ9Ggi36OuMQ5RIOX5j+rKR7Blfwuvf2JdON8qV6oZjx3nZsAE03
	wWVO/MYe6Dlhs55BNcMFrPwSRZVfAWUsqzlOtewCB6Ae32Vw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t381qjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737c5efso24220a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537067; x=1758141867;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWIoku7RCCmxR6hiLsQeRJgxh4TQgexEWCOmvJvrbBE=;
        b=u6p0L0YeeSoAZqFdm/+uBZ2oi0V5K9XHsyBaxkiWUShTn3WSr4Iwkd5oAJOJAsACzh
         +4AUst5Wf+JbZBuqT/B9GIf5nrhfHLw9e4fzBcRUU6+QDM9TFRzm5BXul7psjt9uKlYF
         +KgQpwmjbkLyoc9f1cqo/3YgO5X0WsCCidd3NpLeWHdJ3Db8rU8vF1xkMtO8MXi/iltz
         ZIUNcOmGoKW7SfWNvjbo7CLAsrRdO650hCU8jXfm4v+7sJEsUhbr3pZPXqONxCR4tIR7
         qvgPrYly7J+MB0PpityXlpwITogHUehamNvEtX0/KUXCgB8XjvHagWslTvcHOolmeXJM
         yYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDFrjixTEmIbGo2PREAowjsiQDA5YOsL13lNxEsgd4TT9GFen3krBsB2H1N3ZKemF9DhNF0LHfSEPeEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsm6Xo1cuimCuDv0+llZU5rRIDItiM2MRl4MCDTV40/0hFxHSF
	QxxYnyAG0D4Uy5lLLWjJx3e6yuJTZtRQvtUAHOa/gALwuKtVo05xiyuphByaLMdVqon+CH1I79Z
	IrTn7a9P56cUsiznAdOZzeGGmeQJ3NpbZM4wT0i+V6Nha1oIkYTByxgXau74PqgQKtn8=
X-Gm-Gg: ASbGncsNGc8gUCM0Lzjn3MKsLpu/EJj8l2oIlBpi9WIeKMoxeAYNIXcS5X24sffDHwe
	FNHa8b92UFDMFi6NCQqrJ4IlXESnvInUbLOEfRGarqb8lT8DonuEKrvUt72xVS+FDey98Row7aP
	UcqOPauXFzVxssK4qN0GGLhvW8SF5lABI/XS2Pkj/hAj0VDjlMHV86Gu+yTmH3m7oU7wUkvTzzI
	+PrXiV0r4v7DD1uqg5spd7Eoo1BlkH6VqbsXGrpty4LS10JWsfTTQrNhfGMWgSuYQrzapQXDYnU
	lcZghb18iFieF8eT4aIwxiQhMh1hg6nmbwHBjdg+qkdZBaV23+HCFk8Su+ppJpOT
X-Received: by 2002:a17:90b:3f8c:b0:32b:be68:bb30 with SMTP id 98e67ed59e1d1-32d440d2749mr22619349a91.37.1757537066913;
        Wed, 10 Sep 2025 13:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLzBx/C6rpXTx/AbKEdDRvKi+XAeJbA0oSLh+2R4Y6TD77ThmcYAVvMZfgGZ6ZPkjXKl0yyQ==
X-Received: by 2002:a17:90b:3f8c:b0:32b:be68:bb30 with SMTP id 98e67ed59e1d1-32d440d2749mr22619323a91.37.1757537066397;
        Wed, 10 Sep 2025 13:44:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm46771a91.5.2025.09.10.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:44:26 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/4] drm/msm: Assorted fixes and changes
Date: Thu, 11 Sep 2025 02:14:03 +0530
Message-Id: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPjwWgC/2WOwQ6CMAyGX4X0bAkbDpWT72E4DCiyRBisg2gI7
 +4Ab16afM3f7+8CTM4QQx4t4Gg2bGwfQJ4iqFrdPwlNHRhkIlVySwRqZus81cg0eBSolMoaoWS
 alVcIV4Ojxrx346M42NE4BbE/llBqJqxs1xmfR3MWiwu66gxbuDXsrfvs38xiT/+K5V/xLDDBJ
 qXqVmqqlUjvljkeJ/3a3HEYUKzr+gUK+ao84gAAAA==
X-Change-ID: 20250901-assorted-sept-1-5556f15236b8
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757537061; l=1041;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=J+p7EMrTz5Ci3v4cB32sGVNKuiRkVCCBePNgL++HPk0=;
 b=hvl43ly3LC2M/bCZ1O8Ib5iiOmQszyzcHxa1HmifszeN2jgiCGmATP61nlgRwPvXFFV6x013r
 ekqQUg/+U7kDXj8WEFR08JKHtAioiH86Vem1M3D/Cs/IK+d2AWRQ7I8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: i4oLRWHfvLOWC2G0-aow4MLGG6LnRJuf
X-Proofpoint-GUID: i4oLRWHfvLOWC2G0-aow4MLGG6LnRJuf
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c1e32b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vskJOa3sKGgw8GBTMRoA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX2+gpFEhpDAmF
 Ya9OQ6ru6di7rAGtAH/qvZT0b7HY18fklCLk0840UHUrP6UcvDWGUXX2NAD05RFUOcaQSuMxTGk
 I2j5Abikpr+hS3JBif+7q2Eh+q8NIgAirFNdbQWMQYqI9mjY58C83l1EMAane3IZD/C+Cyp35uJ
 pDACrIVZiFQqZgeTGGWiUIkDBF0W0wq8MyHf7XkRPSzvu0wuB7msfway0NpAjC2FGB3c2uZ/xl6
 i0ItW/yxA6fbUrIsPPHwP3q3KBh8xgM1LwqFoobdMK2RYUbwipJoSFd6Epv3BlCS3zwZq6kaViN
 DrBw5U4U7mhoyxr+kMgze9/a26zkz3dGd9tB/1zOOpeLdm9UE/hToa5wE8GpWmekVhsfSGrMtg0
 Ef/qOGKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

A few changes and fixes that were lying in my stack.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com

---
Akhil P Oommen (4):
      drm/msm: Fix bootup splat with separate_gpu_drm modparam
      drm/msm/a6xx: Fix GMU firmware parser
      drm/msm/adreno: Add a modparam to skip GPU
      drm/msm/a6xx: Add a comment to acd_probe()

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  9 ++++++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.c              |  1 +
 include/drm/drm_drv.h                      |  3 ++-
 4 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
change-id: 20250901-assorted-sept-1-5556f15236b8

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>


