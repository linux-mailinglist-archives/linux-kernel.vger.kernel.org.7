Return-Path: <linux-kernel+bounces-894170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C35C49676
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB91188BC24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC6305979;
	Mon, 10 Nov 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmZY1rUD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RyHEiRPU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1C2FE577
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810173; cv=none; b=eFgU4H1Q4GMxYC8fD45My97yRvaFAb+n6Ptm7TmWa8/lMm6AajRwXh6B9V3b0aMWTNpNKSteUrvn5hBKVXoYgzLWor6OVQtASCngZO536PK5e8V/StIIyD6fwZLGwcAW93iQnGfCDf9fyDboOJpo303B6F3RKOqBs3LRf2C5ywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810173; c=relaxed/simple;
	bh=g+y6MSy72euGXPhtDEt4v9F2/OTUfa2+S7jFbeHaTz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oelhNFngzUVeXTBVuLDRz1ROtMho6jUW90RiZBHRiD3wihYoZD3xOG/+b+A96NL7bNhxVpxh75PyqEMi6AuEYJwL40T6XJOPVyYFzYP9265Nmql7jsPnRS1gTEN4oxFMg0gUAhB8pCikF2SuffFqGLladGkJSnH+JP0BhkeTEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmZY1rUD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RyHEiRPU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAKI4iT212391
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zjm8QOGOt6wRLYUzXj/zuV
	GSGpLuzn17DWxZW+DBPow=; b=GmZY1rUDXKZpodDpaa53tQVEKjvCp++ltB4StH
	KFPq4Yh8+6H/qMsDU+UMJzAep1WV13Fcs2+lbQbjZuSglypbxLGAYnx6WF4Lc8Xa
	clyRCE249k6cyq1dm7IIx6IU8KLGL24q7TYIS3ktDtZxgdG2qBfLfX4K1m2dDjf/
	PiYOkycWnhQtenTI3kLsMqP2Ltfk5XP4SehEzjqYY3nHUDk6ADBGJ7Ka7RQ7eZ94
	XpGcFxCECbeCnz9/t+ZdGs29TCQa8rN5D4iw3cg+78Au2QfPeW7MCKu9C9/yw2Mo
	imQMnZEcTHiYubEZACm8Fwn9AQ3Npdg1dwODKljeiAJWFliA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8g4tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:29:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f48e81b8so3477355ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762810169; x=1763414969; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjm8QOGOt6wRLYUzXj/zuVGSGpLuzn17DWxZW+DBPow=;
        b=RyHEiRPUA5jmjxjfW4NO51pJxA54xneGxbJDzZNyRXGMYm+1VuHpr/b13KHHdh9bXG
         OlnDFpJLrmIQHIFUOpGhgZcYmavQIW1AAVG7MksdwTw2nguMRslJMfAik2uAN3TwgUBO
         sjYgYd4taKz/GZHtByzj44PS89ldUYGUPulf9988EefqILAmbrdFfqFCdNdclBcqaLhv
         CXWbMyU8cHa28udnr0PJap+Pfs+wXLHF7cqjEvxojaZ9HAQkLvyXmPyXDW5Z3pTGBfLV
         89piYi4z6KgiWYFggyU+7PUHv50C0rl3qzpv+VdS+zH0pyYwmoVfOJ3d+RmhX3T+f8j2
         P8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810169; x=1763414969;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjm8QOGOt6wRLYUzXj/zuVGSGpLuzn17DWxZW+DBPow=;
        b=SE0qi6qsLamnWNsYAzawnoVun7BXYRkBL16upOdjGJXFzv5sVGIGFD2dEeO4skWoX3
         BJGVR9+8h9ergd1O0VGvNcJ7VQ1sMbG6wTxlH5ouMQ0ywt8DUaD+as8MJpZHnvy75O7p
         00ICJGj4HrrSCvso5RGcpLIR+ogP9lt/kBLTuzXemCy1aawdF5mV1qgVlyJKfVn5tDwl
         mzngokx4EiIaCAsF5ujar2iMU9r0gMphrMO5uHfxq9LrFf/VwNPR1uZ+bQfUqVuT9CxL
         b3p2SHvEU703uzwQdcwiEB2E223uoGASGKoq1iOAaueb9rx1aVSCBZswBMtIK5kuUQXG
         swKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgsvyiqrKSsn1hVhomyZonTGhPnK95MuGooPKnTJlYzJ+WG7xNjlqZDuUvqL8HE6fRIlr5MhZjOeJSQ94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ivPa4G039be1+ZIb6sLXUsWGxdeTVRg2j7coNFcZzC5i+3HR
	NEMW1oN5/tcvsCY9ctJFFXM90tLk+Jxn0gyeHo1Wsk9lx2GM/3aRuFXBzzaZelXgl36WJAnxriR
	WsCzplEb35B+L2Kro0VOv/C9kf9kMFu7IKdmpe8Ywei7+G3NVdO13UUWdUNOsKT8VYg==
X-Gm-Gg: ASbGncvwwba96bWoQRQRkQ5Bk2x8t5dhGktfhsflDnY+YJJ59todgPQgpJIrn2C35dG
	pMtHUMJBMWdp6cGUq5MFA0LLAIsq9zcxA7fRSSzGQds9LZvJwsBgw8Bwlu9zfO3KvtHKms7clGE
	KbiBB0HGP5RYhmb5mc330PQr8nxHWdGfqM7xhIPtZ1rpjVJekGCCNlzEfTP1HkpFuhDT0dEbd1m
	VpryMisVrzdLUYxZqmkXj2DByZnzkAB8oLY6mL5jS0A1bXIBiLDEruNxWTzk+4hCYCV7F8/W3xF
	8oArMTOJ/YcZDJ1rJ73tx+tcI1TfGM4qlr8jT7D1gxsPYj4gU94qP4xx1ggvcR2RDVDJR8xmPTe
	JRxBOsdsFa/CbZ6R/Bpv9xhfeM2LSJXRhm3S88pSIgsrxsUCnIZv73Ca4oA==
X-Received: by 2002:a17:903:2286:b0:266:57f7:25f5 with SMTP id d9443c01a7336-298407daaacmr10730485ad.7.1762810169246;
        Mon, 10 Nov 2025 13:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIuV+1SxMchLbxTlgtjAKcFCy/+6NTWvSU6efADcUbKDtqkuQ+bij8jy109pZykyKrrcsPkg==
X-Received: by 2002:a17:903:2286:b0:266:57f7:25f5 with SMTP id d9443c01a7336-298407daaacmr10730325ad.7.1762810168681;
        Mon, 10 Nov 2025 13:29:28 -0800 (PST)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cb47dbsm156444415ad.96.2025.11.10.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:29:28 -0800 (PST)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 13:28:32 -0800
Subject: [PATCH] tee: qcom: initialize result before use in release worker
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP9YEmkC/x2MQQqAIBAAvyJ7biGtSPpKdBDdag9paVQQ/j3pO
 AwzLySKTAkG8UKkixMHX0BWAuxq/ELIrjCoWnVSyhoPGzY8iXDmB28TPfsFG9dp17dGKaehpHu
 kov/tOOX8ATQgbvZmAAAA
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: gvTiUwDmNVYxECjMgvXOeJS1t8aDdeka
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69125939 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4MyBTYWx0ZWRfX1MkGlRgIxgQN
 sjDZfzgzCVj//MTFeN8EDozPbeOPu3hsU4A4vL80EiKVCKi7gzp6O0bx45chYWAW09obo/Xz0Tc
 ArJ6w88JjBm3VpZZ2UtHKBVL7FQLDmKiEkM5EtnxKk9I3sw6EhOKgyRqMIAHXzrUO0Ac7a/m+L0
 /S+Zeb9tw1rOvckruDdq842r8Y+vOEyFwrRC2m8LXYVhLhrgWpzT661iliIWfVrmZ+kK80noZuB
 PRoF6KWuOB2IYSpcfzJtenrLtaYjlvFX9iQJANTFUaVTu/RKJtQlpLnZrJMmzTtMHlf0VazNY7/
 DQ8AhNZouO37iy5y8cbgLfPlYtRrYgWrCyfgxDtfNTH0PTqr0qc5lQjSafNd+tvXK/hhIEiYXNS
 c7yy8tzqk6F16Fs7jP+uBaIT90Vg9Q==
X-Proofpoint-GUID: gvTiUwDmNVYxECjMgvXOeJS1t8aDdeka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100183

Initialize result to 0 so the error path doesn't read it
uninitialized when the invoke fails. Fixes a Smatch warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b6715ada7700..ecd04403591c 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -82,7 +82,7 @@ static void qcomtee_do_release_qtee_object(struct work_struct *work)
 {
 	struct qcomtee_object *object;
 	struct qcomtee *qcomtee;
-	int ret, result;
+	int ret, result = 0;
 
 	/* RELEASE does not require any argument. */
 	struct qcomtee_arg args[] = { { .type = QCOMTEE_ARG_TYPE_INV } };

---
base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
change-id: 20251110-qcom-tee-fix-warning-3d58d74a22d8

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>


