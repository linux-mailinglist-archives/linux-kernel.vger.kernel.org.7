Return-Path: <linux-kernel+bounces-758763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A230DB1D39F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A54720E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD925394A;
	Thu,  7 Aug 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq23wH5D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619124BCF5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552618; cv=none; b=Dyqo5pIhNRWmNv2o0X6y3iv+EcZeTdHY2Rcjprh8kkFXQC/Y2oDbolGMD7a98HEkYWkl74aaaEGc2r+D0eUX0hWO3KKKB/ASlbuS5riE+kbDj18INteW0qWtiEpwk8rtFdzVFjLzPcxJZOVzKGHqVSNVFRshY0BlKFuqtweYw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552618; c=relaxed/simple;
	bh=RRxiBs16r7KTIHUs8Zak5jbdXnfM3F+ay1jRs1C93GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLHpgIxjpsLE+78B4XLAS2dPE+y40dqqru5/azKt3v+cjS7XQYD4HJJ0//LGcZ+r55S36JijyMp8h4LISG8DAAmPEMrbyxQEkHPHjhgP2O+7MvLYq48A5PEM+ViKP+vD7uumf1mJHbb9jKaG4Mvaio0+Jk0xEQGshk50geWt7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kq23wH5D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57702lPw011051
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IAd5Ze4vzEv
	wh8CRNYeZ2qA7tHf7jWkHfXPtXA/b2Zg=; b=kq23wH5DE2+oLegmUvtX/zF+xtk
	g/FzoL6TijTXlnE32k18k+uqSgh8GeqMAlROGd8glIE9JimOn/gvrPY6p1yT/M6c
	hvUYYjy4mKzw+PWBhlybCB5wlRK4tCqB0FCGCASdh1dyJ9cLEs6wAAtNrJ2azJPT
	SKfMOV/BLmhYZPeropj9mMsLU39N7O348ny4KPgPgyf2PN8cRiTk9ExORGz8YT64
	ueOIL8NOdJKbRwlbVIpTO626RO+4buwTgyDjSliJXBp/cbm1jPai0e721awRoUc5
	WYQjTUZUMkAhiXrnLddJIHwL6ITOAcnK7Y4a4wYDy9lIm9U/VAf+qaVK4Og==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw35gp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:43:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so1032055a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552614; x=1755157414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAd5Ze4vzEvwh8CRNYeZ2qA7tHf7jWkHfXPtXA/b2Zg=;
        b=roeCZhkfHagqEc7LuKQQnqMviBlFZdmFSkR210H6XcGxuG+hFOaOvGgNA3gNZpdUOD
         kSKMmYMTHJpIa8H48fr4ygxgYdjPV+uwIQnSVf8kAKczEjtyZdXhqMhScVkAqjm985cp
         zzzmTr+x2WAgr9viSvuT7pLwHAm5hrvwtN3l65xXa+/JBfGprb/P/wBy6TmegzOOnaVR
         jOaMn9hcBIiIfOQBVDeS6tXiNaZCtTogHAyjTc79v9EFbHeSQw7pSl8bwUjbCL6E69+j
         z5qdadYoeL3l6RUDBY9wcHmp4FzwVyf5MB5uK6E7g3aU85FcOJvDVzG+WEtpus7ZB2Al
         F58A==
X-Forwarded-Encrypted: i=1; AJvYcCW4yWVkxR4vvmQq8LCQcvm75tj645R5ZB6ebPWX4IGsoiqRN0hn4I/FORY82k+kgl0yvulR1hXavLU82Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcH5FCUh8xs9UXrjmMXlbTgNC2efPrMq/F1kn6UBN6vAKsJOg
	+uUCoDKuCBXTlggVFwcI3AQPEyZ2NPygOfn+UOdm++/GHsuF0S0RSQQuAMwB3UrFgrHMH5cSUbZ
	7bNcU3FeJDxmb14dUXu99Hy4xRVc5IMRk306+TNhMlyVmgY9ScHs/R1KSLAVpiv360n8=
X-Gm-Gg: ASbGncuqIRiRJNDz0F4TuzsG1vMQi/FDWkRIvs/AmKFXC8BlSYW4MZpkKVQQlCayt+d
	37XX6ezHiNDGFdXKfWL7Y0OZouuNYn4SSMbAQlJvnzAxh6XXc+qNWmAB0pcegEc5Q0D2SEkYYIn
	URsTm1Ds9Cn5B7+nlwwbbJ9pAyRAsKK1yTw5+fWkQwe8upqkGpoCuAe3rOHMF0EVUbiEdOk69wN
	aY/57XM6rsr4cD/0/3PztfBlz8u5BegckHZhSWSTgj9H4XaOwHpvMNxOx8u29/FuqbDEIyVXOx/
	hfaXuG8+JloczIy/r4wcAzEnUX/+r8KtU6Lw8dqOK5F3VB8Mu0g5NKp7J9LqSde5J2A=
X-Received: by 2002:a17:902:f68f:b0:240:3915:99d6 with SMTP id d9443c01a7336-2429f4abfd4mr86270785ad.33.1754552614146;
        Thu, 07 Aug 2025 00:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmQ70xW0VJBqeSlIUWMJPARL1fYQTkCAlkasjy9//oof5xTgkO6mW9mVoX4c12poiyfQ7JHg==
X-Received: by 2002:a17:902:f68f:b0:240:3915:99d6 with SMTP id d9443c01a7336-2429f4abfd4mr86270555ad.33.1754552613777;
        Thu, 07 Aug 2025 00:43:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm178166395ad.39.2025.08.07.00.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:43:33 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [Patch v3 3/3] soc: qcom: mdt_loader: Remove unused parameter
Date: Thu,  7 Aug 2025 13:13:11 +0530
Message-ID: <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXzkFh937Q3CDy
 QWEgg6F8Ey+YIu+7BC8qN+/WitTKTNczHU+w3C6poz7SAQ99VhFsvxdnu4jG5BN6ic1SJWV45H9
 ozPNJPs3eIgZZRzn/kLyPp5QcHE89wvB+BuQgFIJaSLJmkaoaxruihKYdV6zvjSYTPwRRgEJYLQ
 zUxRuqVVnZpPbrtFA2umPT/VeV4M7JKeGAFs84AQ90/mqqviI9N8h6oYoEFxSLDQhaKMLgiJ2eB
 nzGi9Qus9OU7RVLw8osRBqbNVALsLwOFkc0mT0r0rN/PYIRT9EoGuN6Kf9HZ7Trk+3GszXfYhoK
 lQzy5AUfk8COrTk69HIN3Xv7wv4XWXTp1/URlWtUBW8IBHhfPODYr6gDHnn9D8ZmCp2bHBre7/i
 3mGtPY8S
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=68945927 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wln2f8d1oZJPYHCAfSYA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: d7TlItg3FCeersJD7bEiuYps8vmN3heh
X-Proofpoint-ORIG-GUID: d7TlItg3FCeersJD7bEiuYps8vmN3heh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
used in the past for logging it but due to code refactor this parameter
is unused now.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3: https://lore.kernel.org/lkml/20250806172531.1865088-4-mukesh.ojha@oss.qualcomm.com/
 - Caller of qcom_mdt_bins_are_split() was modified in 2/2 of this patch in
   earlier version, bring the change here.
 - patch order changes due to drop of one patch from earlier version.

Changes in v2:
 - made this as separate patch.

 drivers/soc/qcom/mdt_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 74c415774657..7522223835f5 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -302,7 +302,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
-static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
+static bool qcom_mdt_bins_are_split(const struct firmware *fw)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_hdr *ehdr;
@@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!mdt_header_valid(fw))
 		return -EINVAL;
 
-	is_split = qcom_mdt_bins_are_split(fw, fw_name);
+	is_split = qcom_mdt_bins_are_split(fw);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
 
-- 
2.50.1


