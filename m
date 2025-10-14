Return-Path: <linux-kernel+bounces-852019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD2BD7F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53AF3A3712
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE42D9EF2;
	Tue, 14 Oct 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxJx0KAx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5F2D3EC1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427340; cv=none; b=DQY+AujaqKRl1QUTGYGOdr0fuMwoYLG461gsQjFao8B8D3jUFpITwW/U2PcFNtJr6lo9cT+RpEB9+3tlAwdgCyxxRC4bzd+OPv5ZlZD1y04KluuyR5qlfejfcK85bBiQ11tlDLAu2Qv3rjauifJSzYdeQzzfZi35p49uhx7t630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427340; c=relaxed/simple;
	bh=+9KJgUfIBS11iAKR5LnNdo1j7qdwGm2mPaEPeiV2PwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yu8W4Av6+VyX1YVYdkNULTtFSYqlw51VyCZeXnOhjm/kwU/rVVkgWclULA9Nn4C5x83uxvoT5JoVst0ON/g73QZsT4cgdnKP9nqPn1hGm2Fm3IBXgs6HRApIo0ZSBEUXa+GRtyJ0ipO5wEEcl5i3A00NXLQpQy7OoHWR8lkQt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxJx0KAx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6RE80016500
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aA7JCiuVVRCy3V30ThlamZSn/80oafKR6lF
	slO98isQ=; b=YxJx0KAxO2DqDO8I0IKd7HJf3ZDdKG0xzvCT/lLqkhtagBriu9E
	qR42JQe0OQhY2Nke4Vpeh9pTtdbGcOAVVfNmtg+l2gTL5Q9iWQAoBlQFET1Wiere
	cY+l05G5XIiXa8S1mE4DhMJ9Lqhgir+iR2ftCKJUGRcUOJjKDRmL9mQaJ+qfRwEd
	6fILSLEHu+Cwag/8EcpfEgRIB06tWg7Bm6J9U9gWDisWxCXc3W4cn7sJz0ssCohl
	2JRGe6Jph4NnrktfzmOxvVOoxqVGEsRTdCHbT/QAGbbWy9MyEAUVGjnszAi7uIdv
	WkBaRAjf0QALrxwJ6CXxZJn89NMjzq1BobA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1abwhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:35:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso178209995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427337; x=1761032137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA7JCiuVVRCy3V30ThlamZSn/80oafKR6lFslO98isQ=;
        b=Q+fiy35xxeRi0Sbb7Yhxs7NYPBBTa0CmCl01tYqCdPsgqmP0QeVsY0VCVsqzaH6AKU
         ZlXuiAjpUu0bZgSjr9xwSnxBw6/F2QbWlpP1sgQDD1kuLSXyx/YRlJB5D0dev5VwHlu5
         Qrn2aqSiTI/9GqIfHKNzaHeOcijMl4XeINrWfvoLoYwt115Z0qxtPIJ91VhcrEDs7kwp
         E9smxZ/hRlI7stQKgxfMDS746IPt3B9VlrcTeNjgU74LVABwAYAIbS7Z3Oj3YO3QgooY
         COgBxKQxC4P91o7reKvYs2nLzYJtqN9BaXJTr1aElF7wXQh5PCEiFUSud9CKUr+dkbPf
         qT3Q==
X-Gm-Message-State: AOJu0YyAAj6njucnlIJuWCvVFhTy54gqHfOPpM2D6Q9rcBKzf+jGM+uM
	ExkrN/QDOekYuDYAO7hrWZafKyJ77seiKWZadqTzppzWJKpJCHcDvKIEVUjcjPzOJq1K7c/+iyR
	g69O80Bog46daChm7aJzFGUTykokNQ/lz94YVVcsnsMsFaei7zvKYttqMzoNH44df8qk=
X-Gm-Gg: ASbGnctB7rZhIKNjzS4KIgU1KZ7p4OvnZpjZe2bNjZtEiXPKVJikY6SfMeileZL1O3f
	X8pZR64GaqYR9Qnf+sCZpw+Mf8JU0rH9svfZAUu7N6aCsCJxCxpvswegl18B2B15FVat+0YtXYB
	faVk/sduxVfp4C0HlPn0XQQQUTomlBC4e5i4GOQp4prTHUmrXy9bRJ/DrPgqX7GgRFwydX1nYPP
	iUYn/xJKqDRAL9ygnS20EZU0+NT6sn9jk3gQ9JZ1bQc+kPy5wNbZOntXFtCw5VCjbBFtzWPXoCZ
	YStx4JvY4cA9dEKbgS8TgGBrrmFNfrkXj8bzU2Ii7AkJPqgBQU1VTRQW6LYwdQZW3ed8LI/Rq78
	N523YqzkTD1CQqBjmUSw=
X-Received: by 2002:a17:903:2acc:b0:264:ee2:c40f with SMTP id d9443c01a7336-2902730237dmr320265105ad.52.1760427337281;
        Tue, 14 Oct 2025 00:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOxdIo88Y+BDPv1KzmWMec2XJ9wxExeRxOPDZ/MXxz4c5ZQPBmyG0bxZVL0yu6B0smPV2waQ==
X-Received: by 2002:a17:903:2acc:b0:264:ee2:c40f with SMTP id d9443c01a7336-2902730237dmr320264835ad.52.1760427336782;
        Tue, 14 Oct 2025 00:35:36 -0700 (PDT)
Received: from hu-viveka-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b66sm156070585ad.124.2025.10.14.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:35:36 -0700 (PDT)
From: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
To: sudeep.holla@arm.com, cristian.marussi@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mike.tipton@oss.qualcomm.com,
        Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Subject: [PATCH 1/1] firmware: arm_scmi: Increase MAX_OPPS to 64
Date: Tue, 14 Oct 2025 00:34:54 -0700
Message-Id: <20251014073454.461999-1-vivek.aknurwar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68edfd4a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=5ooIImjpSQmp0NYUP-EA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HJV_T-8toN86AKBbVkPjTVERxZvabEqv
X-Proofpoint-ORIG-GUID: HJV_T-8toN86AKBbVkPjTVERxZvabEqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX4Ls8j2mMW08Z
 Wkr7wcm/ItVE8hiQmB7OaFhtpjWsBJg+rS1EZeGN2U4tbN7c6WgNA3CFYGuui27kK+11GLL+Ipo
 Z/Ult7Is0jf2uKnDxaeiN2Rec/Sg4Xw9Z9p6OkQRDaoPI4SUQq1UQUVYigpYZr8GI+OjWxndGRy
 tRGderyBJostaZK7xLhCRE8Ef5qxkYtT37c98Vrkjk9tXyZkS5HrnzPYPGTB+QO1gFO5M5OI5qN
 GcHX2IFQJLFx4mf7k4fYxWn9qMmyuPVD1MjJQRJNzW9AcR+hfzzBtT6WB0YJjomBK7VSSo9uwV9
 9fC+YvxN9nGe5byfSHGWHn3P3XJc+f8tQOkUx1kZcUsJmOPF+LT24lBxUm94uHpTqohIgP+n0Px
 GGd7qOe6pLOFfHvz3nglpwyx3vkFcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

Some upcoming SoCs define more than 32 operating performance points (OPPs),
exceeding the current SCMI protocol limit. Increase MAX_OPPS to 64
(next power of 2) to support these configurations.

Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
---
 drivers/firmware/arm_scmi/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 683fd9b85c5c..2249ef7fe790 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -27,7 +27,7 @@
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x40000
 
-#define MAX_OPPS		32
+#define MAX_OPPS		64
 
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
-- 
2.34.1


