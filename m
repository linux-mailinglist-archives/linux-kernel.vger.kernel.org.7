Return-Path: <linux-kernel+bounces-787642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C28B3790A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B661F3AF55D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202627F178;
	Wed, 27 Aug 2025 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWp6PEmf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109A2773C1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756268457; cv=none; b=NvGOsgSexRFZLA6vP2VoZTntqAZv9IpytVeZGRY9Ecdm/qKqE+FQS3hmngVDYrmGOWLbUwCOoIY0EvetYsdRHDPVTDZGsbQnup9rpBuQM67/AK54z42cH/Ol4LsDFdtaI851Mz2WTGyLPHXIdKklbgwXvS9xk5LiSvxPOmO/EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756268457; c=relaxed/simple;
	bh=xN5aoKqkzdNrpFq90kBel8vDcXnD6KFAzDt9yvkGQSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWC/79JksUEG48jvgjfRG4ggkZVSpQ6V8TOaX1xSHUghEl4uYklBzwWUuY3NmOI4vtomwLi2Fxi5VAhnqVTA47opMpk90HFwNf/nwf0BJ77+HxMam0sZ1/RiT2VbdZqkJbjhHZFgdO/qjX74X4WFceowJ0I0vIb/ND2kj2ivLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWp6PEmf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJjDPP010324
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cgG9jC0fRhi
	ZdyvHtCvfrzjfO+AU/dNPrDX32M3A0k4=; b=OWp6PEmfY8HzuLFpF7XPI6Hutvn
	383bVACz2Qb5cExMcKHEYsA4bCqcXvZo/rpaZ6kmFl15rQ+qRcYfgFSU5zeseDIN
	qr2AwTQJj5TwgXDwyxRU4i/HRWBp31nWBAJl0rBWWhBhric1WHFEPaGA0893oUa6
	C2uPPs4Rb1eDdR3dTMGYPZ4I1gg97LBbv41ZUV4aqed8AiK6izXE4Z7SF1sy0rpw
	hYaevd+vWiz8kxE4e0PNZwyjdwN4/jKkmDjOdGS9pTqfhhJ+CMaRto7Qi1UfKMkO
	DuV9RuHGKN53m/SXh3LcLnpTYMal8JN+tZNup67bpPt3CFuOD4D5lwH9SlQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2uh1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:20:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771d7aa1470so2542299b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756268455; x=1756873255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgG9jC0fRhiZdyvHtCvfrzjfO+AU/dNPrDX32M3A0k4=;
        b=bNuFvXHPKlpG3/oaMXaQJZjOpOtakGcuubFzEIZ7yFnKpdQ5KruBpnJUKdvDGzqSGP
         X/JtCis7aQ5+6SpW//Rmq2iFwrx2oSyFFwp9yKj31uqT3b2+QGjTrewQW5YQjGjo3k8y
         C+pxwjle0rDOKbECSWdkYogzLxSBP6IVxEQF2SzCiFUOl2T0JlIX9oqE1ZzXizioi64W
         BpT68r6Ysjifjabv4lzwJoYCxkoynqJtuVf7Lr/6RpAazUWU2HgIXIoeSs7dAQfZwmcn
         AqvemNqicsZFh5MVAElBiPj4wQwN/UEj2FUNWDr9D+dNCBPjhmCVLpmHpl6/zvYB76Gn
         xbGw==
X-Forwarded-Encrypted: i=1; AJvYcCU8D3dZm0mhWhMWJdJNXhWJQATfx+x2QmSbBpcSMjztVSl6VStBtjlqkAB3HR6qOoov20loGJQNOhtXoZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xIs5FJQr8jMVQGA85C4t/JrwnOos+rcppQyHiAJVAEChHcnZ
	jUUm1cZcXMLLh/AZs69mbx55KvTz12ynXMc/dNx+T9JX974xFLCkUT5rAGf0SjhYt98AhYqWwUH
	WkTXq3GPR+AwTyn0Gj6s7LsdDGFvpCKkzf1411sHh9oztLH2iWrzDz2Dnthn2MUDl2Rk=
X-Gm-Gg: ASbGncvU28fsarBUMsD57pWiphb0dkHKxv2sK+c9LBu2oTMM+wkj/1K0qMyEHs3q8Q7
	9Y9tdeKKUUA1AByYlcURSbFOu1ytoxXbHRmZmgHKfiyjjROSfPOdenEF9Lc615jz65wxm8MzikL
	wVOvnk95SFOXs3Fd0CAoN7iNoOZYUJB0R7M9zsrRC8DzncCXMg23ZK5mR8hradYBeE9W+19Bd+s
	6tSXhXjt+xFUde8AQZHT3pxllfInq2z2yEC42gk2Rh2x9fVnnfol7DBWjJASCVi3TG0oK3e1o8u
	ZuZWUyJOp2gM0PgkX8xWgjwBkQ7r4nMUUu7DbCQkCiKEkgG9I9vj7DTQWJ9zNz/0rtsrLXZj1YJ
	nXlPKvJk3p+P2yOtyhHpb
X-Received: by 2002:a05:6a00:b4f:b0:771:e10d:813d with SMTP id d2e1a72fcca58-771e10d83f6mr11712090b3a.21.1756268454717;
        Tue, 26 Aug 2025 21:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbYYxd6uRKJhXpbWdWQeevt5PKMUN9Cf+ngWv6eWh3hbHw3ZL94CizAJIrwirDo4XyosfX/g==
X-Received: by 2002:a05:6a00:b4f:b0:771:e10d:813d with SMTP id d2e1a72fcca58-771e10d83f6mr11712066b3a.21.1756268454230;
        Tue, 26 Aug 2025 21:20:54 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f4072ac4sm4323076b3a.34.2025.08.26.21.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:20:53 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/3] coresight: tpda: add logic to configure TPDA_SYNCR register
Date: Wed, 27 Aug 2025 12:20:41 +0800
Message-Id: <20250827042042.6786-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ae87a7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6Dbyrv6SX_ztr3m6kfUA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9pUUJGFTeeCp
 qvOlR3/bo/KWyRlSSv0xLUxDu9kRDoLzew/AQwPwNnFazKvD0/SOY0DlPOQWDL3QGg3S5ojCU7R
 1peYCkoM5XdSUGy4IMmtG9J/F299aHZRmwPwS9mxOmYuGHwpNf8TmQlAVxo8+Y8n78+YN8OTKIF
 2EVJGiD2jGTi3OoNBX0OUuMd5w15Wm2uNWgq6Jepq5t40cEH/SnDC+lt/Rd0aw/MQwTzqTU6bVY
 LNOWKOlaSD61FyTmfyGAkxPY2l3eUQPs7H1pcXkxEyh+apiT8tPQdVQQ0obq0MNhC5mlrbxTCNl
 rQDYpaPw0KY/4fW1A1yLAnFqIWPohlYt7kjcNi9ox8c/r8TkMOYaIOtRfTfjpxTfU8boDR8IrtM
 tROESlik
X-Proofpoint-GUID: 5KSxhqbyjMq_CsQBGKmNP2g7ssSB11o1
X-Proofpoint-ORIG-GUID: 5KSxhqbyjMq_CsQBGKmNP2g7ssSB11o1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

The TPDA_SYNCR register defines the frequency at which TPDA generates
ASYNC packets, enabling userspace tools to accurately parse each valid
packet.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 7 +++++++
 drivers/hwtracing/coresight/coresight-tpda.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 647ab49a98d7..430f76c559f2 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -187,6 +187,13 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 	 */
 	if (drvdata->trig_flag_ts)
 		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
+
+	/* Program the counter value for TPDA_SYNCR */
+	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
+	/* Clear the mode */
+	val &= ~TPDA_SYNCR_MODE_CTRL;
+	val |= FIELD_PREP(TPDA_SYNCR_COUNTER_MASK, TPDA_SYNCR_MAX_COUNTER_VAL);
+	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
 }
 
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0be625fb52fd..8e1b66115ad1 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -9,6 +9,7 @@
 #define TPDA_CR			(0x000)
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
+#define TPDA_SYNCR		(0x08C)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
@@ -27,6 +28,11 @@
 #define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
+/* TPDA_SYNCR mode control bit */
+#define TPDA_SYNCR_MODE_CTRL		BIT(12)
+/* TPDA_SYNCR counter mask */
+#define TPDA_SYNCR_COUNTER_MASK		GENMASK(11, 0)
+#define TPDA_SYNCR_MAX_COUNTER_VAL	(0xFFF)
 
 #define TPDA_MAX_INPORTS	32
 
-- 
2.34.1


