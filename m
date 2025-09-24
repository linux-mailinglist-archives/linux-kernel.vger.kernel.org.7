Return-Path: <linux-kernel+bounces-829917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE75B98310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F22E60D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40386238C23;
	Wed, 24 Sep 2025 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/aN7J+s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02F222582
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687535; cv=none; b=HgLOucrQKange9DPgk10F+CYl0QNwR40Rp2WG10LjAl/hYSk9yAD4Y2qFeAs1aQa2Ry8DnTggO+Ky5nn6u0w/CdPzOjemNnjXa26GU4k4PxORxbi0pdESsD/2gYR4sC0DMbkWkbhTUZuVbWqzvr1kkD7LJi4+MGHVj4/yeMKhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687535; c=relaxed/simple;
	bh=y3kDiWminIlh4cAMLwWiVIQUVLbdzIjh8+MBDi4VRcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUNeFt8+lJpowN3dtrwBQpAc+BnrljAifxTFV+HOhTdfA7zv0VM8liP5PWTSuQu2Jz9ETzaia8LSbABzEzyOKRTo7mHB4PtwYv2DSuUzaHTTFPCOi/mh8RaKNrJb0cpBT+qzAthgaIE0VvJ3vgE9NrEc+r49rNr4uFJ56u72nEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/aN7J+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O2t2LG001952
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MzWxFE6SmNE6Sd0JJ62qs2K1+TijFUt9wCgiHhJ3do=; b=a/aN7J+s1FOfcBmp
	wS1htj8rZ/VJANYqKj7em0XEUvDVo+H/2JDakZOZiqDEreYdjjCIpBe/mxkVXN8H
	iw0AkR1Byn4xSp7UcEL4LLaqBHkt1Gh+o5lKNpy1puzjMsPn2iUxJYVwljOZrMy6
	V3uUpK9r88tTadzm2owewPU73Jb4RlJXfRpKJBfryd1S1DIguEwNodfC36webv8L
	B/wMXVGraBCTrM4yI8Q6aJwUHNdqbR0vep2ni43mAn6OtBIArUiJI777wML4x3SA
	pOphqqjywS/2mykTJY4O0Vb0ZzEd2e6OPeHQ+/oXAxmiqGRQR0aiDoRQdVw9iuvW
	5NFdNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fjvq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:18:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269af520712so70587015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758687532; x=1759292332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MzWxFE6SmNE6Sd0JJ62qs2K1+TijFUt9wCgiHhJ3do=;
        b=pLHnEyqpNRX0V8NQD1e3i40OkEia1FUO/SPPNdYDsq/MP2G3HcjWFyd5Dot+OC7jW3
         torsj9i5LjOWE/O/BcQvwbdZdVLRvUH+p9gXQKC/JoFtJ9fRDGfuhpL9itjaLZpcVJKh
         lKs/2OcQLBcI2HEcytCSst9PB42CRxCzZF+FjlfIFWnwZplVccAG5kp3N2Kaln4uZQ0x
         y7WCjcRcXaf0WH+YADOinXOhUD73w90t5bxruqqUDntAtWGVfZOEYlNGJbqYm6yiecmd
         mOqfgoWWa5FjTV7IAOBo7P0c1SvnmPP6ZXWrJ40NInBzsSLFaaUxzwanT0F7ayXBjLLP
         tEag==
X-Forwarded-Encrypted: i=1; AJvYcCXG0FfNwcRE2gLAb5iwWT8ZoK3JzSzpt5ud8iinThXRQ47MO6A21V6OcK9zKgdapQxw0oT4F/Bduu5AlcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwHvb6gOqcawmPo2m6hqvNcmATp7+yWb+YrxcKvBCb68PssjR
	sDQ8c+de5DJYuw/WmcnPtalXuvA6nMn/EVKqEDeF1Mf5ScHqSMVizSOa+2bokfFEd83nvDOqad9
	QCHKUM7K1dRy0f6o5yjRYPruyCu4uQO/3IZh9Juq54PGA5psPWtsuxd5AN/unOIRKS6LgtxsJt7
	k=
X-Gm-Gg: ASbGncv4FYB/sHum9lG9GG6+EyYETFlGFjzWfIyBPItPq1+5ymyLDLOsW1MY7Y675ZT
	9uAHIwYlQoCTtyKf+bb2F5LORuuneAsbrOon+zZqOZvxMr8sgGRYfvcKKKqwhSDUYtgM7DQ9d8v
	JSoxNEWoQB0jItVP6xcarLnBWFcQUt5YkyM337BOd5KjNMTCS96eVW7YlZxpISuINejSb0R08Zz
	vqrQWDZQ6kFpo91KmYdchZe9gBp80+/eVG4JOJuweJzbVBwcGOzAaX3F6cyfiyfzLjIf7qqEQuc
	rMBYn3MUFs27bIdcKKwqemzXhLAF9WZMV44r2h5oab/V99ZjiOfDhUqJ9iLFxZBrwC6Hrv2X8Tv
	fbi86nYDuUCN0eAs=
X-Received: by 2002:a17:903:2c0b:b0:269:8edf:67f1 with SMTP id d9443c01a7336-27cc13808bbmr60166455ad.6.1758687531874;
        Tue, 23 Sep 2025 21:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7r66V5B2kT2HM7RA4fkMlGVLXRBRzSC0bio+S3HcT4gSSi9reHGYc6Y5F2yK+Vb6ftbA61A==
X-Received: by 2002:a17:903:2c0b:b0:269:8edf:67f1 with SMTP id d9443c01a7336-27cc13808bbmr60166235ad.6.1758687531388;
        Tue, 23 Sep 2025 21:18:51 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699363989fsm170133885ad.92.2025.09.23.21.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 21:18:51 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 21:18:43 -0700
Subject: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
In-Reply-To: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758687528; l=3194;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=Iv1mr0CsUVNvjD6gvfRUYbwxcg/epGGs6ZABQD1hV/k=;
 b=EU8eBSCHicFs67DlRHihnPl91dsbq99bdcVFpgiWeT1t22XtBq4SuigAYW3TRa2TFRM8Joc6P
 QvWns9Zje6PAdutnp3VcwsS1dUbDqhRnXh/fBhA3sPsH7lJGQfUVy2m
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: ERXvCkXtb60A8DQXYecby8tLQ_diLbIa
X-Proofpoint-GUID: ERXvCkXtb60A8DQXYecby8tLQ_diLbIa
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d3712d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Xvny5BtixxlE2jsoVxoA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXxq9pUf3+23ON
 XDT1faj5gxlP+Y6L5/e4svZjMQ9QLbGUOWWkta6BzUMWdTWjbVXIxz8i6AXAnCoQVik1MDC+5zK
 ZHaNzi9IwBwYCzWNVGJQ75bXxxe8Yc7E9YaB38nt3Al02C05NQXQ1eb8+5jJHdJv/ABHHSFxMeL
 0L+Cgf+jkFGZX7Zew1AcsmTVj1Ryfn5ntjpKcweM3J9tifb8Mnxi5B0aXroZmgraH37PfKZ1afk
 v/5EecBgNQouHS9koKq+MYT3QnOhkWL1xRnJjhBgvgKb5GQPm7BYuX7mWG+xu9nPFQuCtYkDF/y
 G9vr5YhLu/QMcFFmVAzS+16sh9x9/K//sDEBj9dK3LTv9tfBuAPdiOjzOFsgSZzWNdDcGr2GK5V
 XCFtHgoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Chris Lew <chris.lew@oss.qualcomm.com>

Some remoteproc need smp2p v2 support, mirror the version written by the
remote if the remote supports v2. This is needed if the remote does not
have backwards compatibility with v1. And reset entry last value on SSR for
smp2p v2.

Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/soc/qcom/smp2p.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index e2cfd9ec8875..5ea64a83c678 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -48,10 +48,13 @@
 #define SMP2P_MAGIC 0x504d5324
 #define SMP2P_ALL_FEATURES	SMP2P_FEATURE_SSR_ACK
 
+#define SMP2P_VERSION_1 1
+#define SMP2P_VERSION_2 2
+
 /**
  * struct smp2p_smem_item - in memory communication structure
  * @magic:		magic number
- * @version:		version - must be 1
+ * @version:		version
  * @features:		features flag - currently unused
  * @local_pid:		processor id of sending end
  * @remote_pid:		processor id of receiving end
@@ -180,14 +183,23 @@ static void qcom_smp2p_kick(struct qcom_smp2p *smp2p)
 static bool qcom_smp2p_check_ssr(struct qcom_smp2p *smp2p)
 {
 	struct smp2p_smem_item *in = smp2p->in;
+	struct smp2p_entry *entry;
 	bool restart;
 
 	if (!smp2p->ssr_ack_enabled)
 		return false;
 
 	restart = in->flags & BIT(SMP2P_FLAGS_RESTART_DONE_BIT);
+	restart = restart != smp2p->ssr_ack;
+	if (restart && in->version > SMP2P_VERSION_1) {
+		list_for_each_entry(entry, &smp2p->inbound, node) {
+			if (!entry->value)
+				continue;
+			entry->last_value = 0;
+		}
+	}
 
-	return restart != smp2p->ssr_ack;
+	return restart;
 }
 
 static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
@@ -222,6 +234,20 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
 	}
 }
 
+static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
+{
+	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
+	unsigned int pid = smp2p->remote_pid;
+	struct smp2p_smem_item *in;
+	size_t size;
+
+	in = qcom_smem_get(pid, smem_id, &size);
+	if (IS_ERR(in))
+		return 0;
+
+	return in->version;
+}
+
 static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
 {
 	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
@@ -516,6 +542,7 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
 	struct smp2p_smem_item *out;
 	unsigned smem_id = smp2p->smem_items[SMP2P_OUTBOUND];
 	unsigned pid = smp2p->remote_pid;
+	u8 in_version;
 	int ret;
 
 	ret = qcom_smem_alloc(pid, smem_id, sizeof(*out));
@@ -537,12 +564,14 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
 	out->valid_entries = 0;
 	out->features = SMP2P_ALL_FEATURES;
 
+	in_version = qcom_smp2p_in_version(smp2p);
+
 	/*
 	 * Make sure the rest of the header is written before we validate the
 	 * item by writing a valid version number.
 	 */
 	wmb();
-	out->version = 1;
+	out->version = (in_version) ? in_version : 1;
 
 	qcom_smp2p_kick(smp2p);
 

-- 
2.25.1


