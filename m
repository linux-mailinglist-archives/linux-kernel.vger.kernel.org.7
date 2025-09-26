Return-Path: <linux-kernel+bounces-833831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D30BA32BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D0E3B8F21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3B2C0274;
	Fri, 26 Sep 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJ/ik+qk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47E2BD5AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879284; cv=none; b=HZu2RVCRmVVuBSYO8+dK65EW1/kHdPR5Nx+VO2Zi6XpC4k44KPu4RPM3fRByCpSqmq8IV78GuE1eb4LGn8iUFNED0kbeaw3qSxG5Gp8Hiueys3uhjxFYkam7iIKHaaKS7Y8yz0qs+dVDpv8K9H0QXxSSRzEIYnWSmML7Q3MF9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879284; c=relaxed/simple;
	bh=HslDZeshtL35gYUXXtwNip7JcioLUfxqJhAk+ngAsoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OUQCW1VnS0sjD40qAFkNOV/088Rt1cNOmm8wxHNBa+T2aepo5Ob/MReeW6U5SxUy07V9fvOwucHERjoj1dqL5TBuOBToxw7m9cNEfsBL+Y472rnn5XLR+J2Yel78KDpjnRZMxFefiY2qJFyQaJ3Gi1YlZviY9L75bGcp9X+qvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kJ/ik+qk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vbQK030585
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z6re8pVm+kTFFLtJaj2rtIpe8h69JBxtTA4
	MepScxRs=; b=kJ/ik+qkWCo7+RHgR5Lev1nMKvlvvbZ+OyKUGP8pnYOg3nA8b8t
	BTp+2W2eVKqzK+fJNrBxu4Yj0oFUcEqskt3f4CJ71r9TSjR7ksWn4BXMNi5pAY3n
	szWjk42FLdrPh+SH/Ol2eCLLDBFeqUWXMcRN53DovafPOnhpanZev8CRueeM3m2Z
	IgIzlwu9nbbutHO+hU+g8SUB/xCjdZOugSrR+03GlbgMvluUty0RlYFFJGVbtBBa
	mGISSXQaVVPN+nYT7pAg1+7mhnqsFwV/OZP/7P4KnOPsBhzO/FpDxlkjzlKks5B/
	AI3d2kImtpZRhJUhh3pK0lGEIDZda4zBVxA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u2agw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:34:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso20271845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879280; x=1759484080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6re8pVm+kTFFLtJaj2rtIpe8h69JBxtTA4MepScxRs=;
        b=mwzCcZMqiugHQgqI0CTv8Zb8CXgA6KlxwooaRYP9w9UkbNEJgNmYVcV8srnD6DCo7O
         3B5sw45Qt6wM00bDkdddj8kEiymw19JApN0kmw9y9b8hEE/7XB8fYVbTm47mIqhLmvc0
         CQTglK2hXLSQxtuxcpesJqrjJ73/7Rzv6W9Szw5jjOC8IqdZX4bTMWsv8A0MGh7ywDkE
         9DQ+4A0fP4GihPX8zMudbR0t2q4ndsfI1/MuJ78xkdyCFSWp/37oNVc8LBbHrHr4Uwkf
         80KYVD6KYKLzZ8u8juNSXtY16Ej6wJdCl6vYmM1cVZD1TTa+ScU5MtS7waGh/H3bYchx
         e1sA==
X-Gm-Message-State: AOJu0Yw6D3JqagfshXIDyZADHUenaAPQkIURwmpGwENQnK7i5MoFMRtD
	KcgKdyntR2G+DBlizLJE3LuwdJ39eIBeYOXwHVeKr14HCf0zGdH+DoqXAUeW1kTvVZwxrCpuuPA
	PFEiEQKynHB3n79LXA+N9TZigYWF/S/zm4e5MVJ5FmwIvEYTKvsdMCpXH26ds6fjGkDo=
X-Gm-Gg: ASbGncsaEMCBteQlo3TPDS30sYYqHW6D0Nko+YEFX1keucV+jurenNYZGHQOk8FnbNZ
	Qh9hNbrBGBpbyLpXysS41iMs68HTrgQh1KG1YtToVB2AUo7Ff/qeRImGAmqgNMcSbMXzJWJNoWw
	jlzvs6jHJvjLa4cWtSmawHcEPpwTOS1eq49yr7/nGEA2o5Ws2jbb9+eIxUFuFhgcSill+9ep1dI
	vAgCARgr9hsnFFRTBXlxQmOBlkF4C4cusDwsoIfk79gMI4kel9t74JmnlQsB50aqPbcMYoapa7P
	i89E3e5Mp+fP6zWLuXCsyZaAEvRT4S3zUXHQP+Xf8/9kqvpMJqr4GieBPnkwE61PRPEJ8Y/Ig0v
	GrdHHFt8E7gcsq87xjiflACmQUzpvblFxsW9ODi9Z2T5Q4BCclUTBrC0=
X-Received: by 2002:a17:903:32c3:b0:267:e3af:ae67 with SMTP id d9443c01a7336-27ed49d2f64mr71196355ad.14.1758879280269;
        Fri, 26 Sep 2025 02:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9+Sln3F5sgdTCpDsBM7EOJortBxqIREiFvU3XpZk26rNxe4tTXYDNf05HVd03KmfIC3RuHQ==
X-Received: by 2002:a17:903:32c3:b0:267:e3af:ae67 with SMTP id d9443c01a7336-27ed49d2f64mr71196005ad.14.1758879279819;
        Fri, 26 Sep 2025 02:34:39 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdab3sm49463455ad.19.2025.09.26.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:34:39 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: krzk+dt@kernel.org, andersson@kernel.org, jarkko@kernel.org,
        lumag@kernel.org, carlos.bilbao@kernel.org, hverkuil@kernel.org,
        akpm@linux-foundation.org, sln@onemain.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Sibi Sankar's email address
Date: Fri, 26 Sep 2025 15:04:26 +0530
Message-Id: <20250926093426.1735334-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fPy5_BiEhyNNE8fIRIAOnWG6CPpkM_wQ
X-Proofpoint-GUID: fPy5_BiEhyNNE8fIRIAOnWG6CPpkM_wQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzcoMZvJrWaiS
 vz1FPFhytAYrfOV6FtZd5Ar6KHF1hK1el/LDIV/otVQsh3pR5wzqFsIAOyVwXQFLMn4P2B4fO0F
 h9uoXvgqGwpULVA24sQDUTjhbW/G1E89Yzy7fQ9iQR5qeGiH0zn6mGFNKjI+v/9VADc34hYY+Gg
 1CxhCaWVrUUl+h+NMX3SZACVAzb2rCR/pLBoaipaG1nxtFx0U9HjqJBOKeorJaRhR5lcs9u2w/x
 PwezGHgq+KxqQD0agU1Ou38zZyD2rEZXsX5OVYmX3c+IGU2LZS1CbGfa/CIlGONmvKbJnq6Pt7q
 71X9pAjQm/6b0YCBGypAkuuhKUoj8usvkz9WHoVCXPfq1i7DsCq4fvaVG9K3pIPehRHtxQ57xLD
 O5ktpWdgHpoqHNwvLeJM6nRNNjJjQQ==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d65e31 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=cH6R9-kdAAAA:8 a=hD80L64hAAAA:8 a=COk6AnOGAAAA:8 a=LpQP-O61AAAA:8
 a=4jJoCd_fAAAA:8 a=iSFaNr4-AAAA:8 a=GsRvEKKJAJljR7cJZk8A:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22
 a=Zp0EBJ6X80L27f4Lx8pD:22 a=hXATVNy4aS8gdm-T1RL7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Switch to using oss.qualcomm.com email ID in the MAINTAINERS file.
Also update mailmap to ensure proper attribution across historical
commits.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

base-tree: next-20250925

 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34c3252f05b4..2a215e434754 100644
--- a/.mailmap
+++ b/.mailmap
@@ -722,7 +722,8 @@ Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
 Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
 Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
-Sibi Sankar <quic_sibis@quicinc.com> <sibis@codeaurora.org>
+Sibi Sankar <sibi.sankar@oss.qualcomm.com> <sibis@codeaurora.org>
+Sibi Sankar <sibi.sankar@oss.qualcomm.com> <quic_sibis@quicinc.com>
 Sid Manning <quic_sidneym@quicinc.com> <sidneym@codeaurora.org>
 Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
 Simona Vetter <simona.vetter@ffwll.ch> <daniel.vetter@ffwll.ch>
diff --git a/MAINTAINERS b/MAINTAINERS
index 8fcf4e34eaa5..ea35dfe0eb92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21047,7 +21047,7 @@ F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/pmdomain/qcom/cpr.c
 
 QUALCOMM CPUCP MAILBOX DRIVER
-M:	Sibi Sankar <quic_sibis@quicinc.com>
+M:	Sibi Sankar <sibi.sankar@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
-- 
2.34.1


