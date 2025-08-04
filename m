Return-Path: <linux-kernel+bounces-755612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48DB1A92E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D07117FA46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE703286D76;
	Mon,  4 Aug 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGNCSbfZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED51D9A5D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332174; cv=none; b=YfeLxdtEwnvTsesmYZK0eDe/Y+IlayduxfPWpm73d2yamgatsFZwclRnbRYPkvSEdZ9P0ZyDkYj1xQv7JQp5Q4DwMhz0an1KamVoSk94py837eE9WMu7+1gO217P8mSPPVmomJwP8mICOhWwQBKgTMwxQSmmGo4HakvrdW6m/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332174; c=relaxed/simple;
	bh=97Wf+005AjX2fyW62YinF32DHzBNO7WW5hMyEiyttls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IUCvFSMevJLmhO0nc68S0Ca6/9W911lKwfpIxaYxhGmaNavKMwRq5K/ydkN2ywe1kelxZ3ThMl92BufYSY5T5qUekbDYPO8kOnZ0m9t48cgF1f7DC65UUUtv1y497zLysUkHOYbpxmRCFZwHithvmICASJLUGvrZ9Cq4JrWLg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGNCSbfZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574HXUHO013637
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 18:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4ZRS8X1q6T0ZLRueHzSZjd
	xm433yImBfAQNa/j3W3Cc=; b=GGNCSbfZcMkjB5y7evYdsnaCStsZoEky7Ae1tk
	nmO4sRjd3j3CX9+ZTbvUd/NGLMVEQ71LqdwhFRfraf+aLxjXNgMvar7cYbeaaLrx
	V7LWl6U1gorPCuouMU8Bdb1hsHdylSMhl9T/cnQqCt5jNb4YIizVUbyRFYlIJdfl
	0ak5+iG2IevxTt0opjHINMctSXOP14TXxtWCzeSF7njra/MCjhtqLbqN0YjzC8/j
	SkcPw6LLGXt7ZVIlfNXdQ7/TePW+gT2QMYjz03Z5VkekUD9P9BpOH13NSMj6e92e
	lI+3wwbDk4R2WJNNKdwUQ14F3zTH0SdAwSV5bEemjRbV6zJg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek5x4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:29:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23ff6e5c131so37538265ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754332171; x=1754936971;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZRS8X1q6T0ZLRueHzSZjdxm433yImBfAQNa/j3W3Cc=;
        b=Kdwm0ThiVyeblJb4JLSXHaOwcHlE7fFG6B7LPAkpBgmDPNg16RGxOPYV6b5nXNYWBs
         XfKmESI3+LpIbtB+TMtWSSBZ770A7Yfc5kXBZsVXf/6IPAzGMQH38v1nk+hptoX+nCE7
         9Q0GzGfQ/bc3TLIjRNPP3GmwB7MuoyPresK8uYcc0FEXVq0mvsAyM0gu54XAs/i6AcdO
         P9qr5ZCoXpBvXoqTM9t6Ka6sxGx8aVZCB61nXMY3Blg10t0eG6saWkqYr2bTFx0PhSSc
         n/5p8TOf/Cok26z2ymqUjZmjJpVhdu/ZsBw8C/WDNrm/tUPpdWzomFLvHRD40crAhdTp
         DGbw==
X-Forwarded-Encrypted: i=1; AJvYcCXDEET8WxaZLzF8hUbBFyDhHtdZvbhRrgaGTC5K5KmmTS6CzMujRqBMxX2+oYx+hdd+7gJLhQsJzszDDOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmx8u34muankDWSqKi3sqGCkbyDOyiwsOs3+OqhTwDwB6jmLLi
	UYZD4sP3sHion9gnZex61qd+V4p61910J//7cPYq3FjRT1X3wGjJu5MTF3NY4N+tiFuml1QYjCs
	VqD5ALBEtiRd4S8Nxfd8QKlaLSIu4Ky2Qc3Zkjlh26KLBIzTK1elDPcR8jfHg7Lc64oU=
X-Gm-Gg: ASbGnctG64i1wEAZFgEsj2MKfKAB5fKil3OHB3E4CVvl9V/MKccIT0u1XMrwBJwcuA1
	ImqNQxxeopofH+G/iaFZIPuE2zJbI0jsPZycqBUwJSUfaJJXR5NbliLebGwH7PQdrW67qHJYUwp
	NstTixAlgDCd4DgfjiZJrdBKidtYpemzYjej8RQ6eSjxFjHT4/BdUDtTdtlnMXqmTU8jgI0vU+L
	skBmMAa2j3Ji3JBvWlfQl7ELClZqIK3fDPIne1emUu2Klmt6M7DGFB3iWhXrt64qSRpZCuWYTDa
	xB3PrTB8lIOrtBLIy3S9QsYzsDtdLFPMIQ10y+FqrW72CWNCpNdLbJqB+1BkgX6D
X-Received: by 2002:a17:903:1245:b0:234:1163:ff99 with SMTP id d9443c01a7336-2424705444bmr148283425ad.43.1754332170833;
        Mon, 04 Aug 2025 11:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI/N3VZbz9RZmPiG99XcQflvUuxhU8jRiEQZfNcOiAlYNY9sO/cJUZlj+swyKOmrjO6HOihA==
X-Received: by 2002:a17:903:1245:b0:234:1163:ff99 with SMTP id d9443c01a7336-2424705444bmr148283045ad.43.1754332170443;
        Mon, 04 Aug 2025 11:29:30 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm116664345ad.159.2025.08.04.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:29:30 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 23:59:21 +0530
Subject: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAD8kGgC/x3MQQqAIBBG4avErBNMSqKrRIjoX82mYgYiCO+et
 PwW772kEIbS1LwkuFn5PCq6tqG0x2OD4VxNzrrBjrY3mlMKkjYXdI+CHM5LDaKH8904rPBU00u
 w8vNv56WUD3ZyUNdmAAAA
X-Change-ID: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=6890fc0b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PH1V8s2_vfPofe0uiFIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwNiBTYWx0ZWRfXyZjItEMmeMQ1
 F7Yy67FjcB2L+O088LN4PjpI59gwpoeraeIOuIqmnY1CojTgC0eg4eDAZJRO7DlTa6GsDWGOTgg
 8Y2j6BmR4xwmQx+TxpI9u2jFIFElVtCJulRPnW4yhlFLtCuSg3vlCUgo+KI722hTiiI8fSUSWwY
 qFK/3hyGbYkMqUHFfB/ByypKofk9cuJT5XQfEjLRwn/c4TXpzIkTIocPNd94/hTZRtQjFmg5wD1
 iW9C4zt5W47yfjex7bk8bZruuU8urZujYHhVkVKsRUPsITLWvU4F0zCkCw11nnrmTr4CtmlEuuP
 WlWwHNYR05XFFLUyHBH4y6c/730MyXojZ3fyC9fUQz56Yb+r1lS7g72O/U6EX6nqTkVoBzSxTAP
 D4mi8wB92cPU2mIg2HdYUkdTABPv13KVnWeaKNSsC21RWQxMPqhaXY028XF5LZDm7c7cMLUL
X-Proofpoint-ORIG-GUID: sXO-FdZE1ddyuD7uISeZqTQOmBFc1JvT
X-Proofpoint-GUID: sXO-FdZE1ddyuD7uISeZqTQOmBFc1JvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040106

gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
boot. This happens due to the floor_ops tries to update the rcg
configuration even if the clock is not enabled.
The shared_floor_ops ensures that the new parent configuration is
cached in the parked_cfg in the case where the clock is off.

Ensure to use the ops for the other SDCC clock instances as well.

Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-qcs615.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
index 9695446bc2a3c81f63f6fc0c98d298270f3494cc..5b3b8dd4f114bdcb8911a9ce612c39a1c6e05b23 100644
--- a/drivers/clk/qcom/gcc-qcs615.c
+++ b/drivers/clk/qcom/gcc-qcs615.c
@@ -784,7 +784,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -806,7 +806,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 

---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


