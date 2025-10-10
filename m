Return-Path: <linux-kernel+bounces-848529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D8BCDFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8134E7041
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAA2FC03E;
	Fri, 10 Oct 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNsikZVo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA426657D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114795; cv=none; b=gy+W0qs6Dez7wLly60gyjwXeRYizhakt1YyqCdFlL6w5lCH/++Q+pAdfL0wikOnOLig9BggmQc1xIQE4iTRQsTlz2TZ72TCarEtCb8aN/YBP4DlWDArEXGByuey85xei8LKKxJmeYHG/Qs9u44nb5fIJhVa3l1c30bkcaJwg1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114795; c=relaxed/simple;
	bh=Uco9O1s+Z0nETMe4wo2Hqli+tBmo6Vhv86UjwJBIzAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I47x2DgTjHRj5laGy1APNbqjKAnYJVq1kyllor7k1OwH+fAJX7JMeZuSODl56mESwi/jfoe3gU0Ny0fh0qlLZZ4DpZMfAuqMGX2Z+j6bDsZmAJVDwWCndt6ZuNTM6CV9gO2ZQNg9ESvaDbL/SN1n2C5cd7qaQmicD00o1Mpctt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNsikZVo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFkP2U032431
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kh9iEsij45plAaoQh2Xc29
	0ky/7j3jYE95CHbVbG25E=; b=mNsikZVoe5M/oxcLYiOMu1TlLhRHTRlu9Ae5AW
	Awhg61idruVfkNKBHktD4DK29ggixRwj3heXjEKJJeaRlTyEPhqac/0CITvlmmwt
	4if0YRZWkJMRmtNSBOwGmOWliJMAbSfd+quYndS6XymL53peRvp2AutAZN7v7aIm
	lvWZIUZzoyveuJdnBHSTRQLAOIki7wZCvmZH9JaRWyrE2VjRoxrWXazQ1zf2yq+u
	Bfplw5EOrp7CvC9RWfq5w/iz5OrgmC/lvbz0vv4OUFyGZj28IyUMDzYXJkFL54oY
	1+X+pZ/J3QI2A32X1GAudQO+s6FzKd7ajeCdEC92w0qQ+hng==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ky32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:46:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so55532165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114791; x=1760719591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh9iEsij45plAaoQh2Xc290ky/7j3jYE95CHbVbG25E=;
        b=HglEerbQEbj85CL8ZZFbB0+soB6rTQDcKU2Co3RHVAyalDVqSe0n1UxeJS6n2sllHw
         9naaYKTnee3u5mgJ5o3jUrVmMb0QbJjvhHSrfan5y8kBQU5TnskD2cdGXpBMCSp1ryAC
         qv6SNRmNGm4+Idivb6BXVfF3VDlAoo5J5NduHYdq3iweI//CVRxUY0CX8Dq4h5TctIN/
         VXwf+YuMsP5uUpB3UAeM+x58n+wVXLcPfTa7PZ3YYjnraGajNlsgwkYraUhW8mT+DKDU
         dDrBYtjHkSyJIc8F+s7U0RFbAoZQ1nj9gFEkja9xQaJg/wPmnuUO+DfQlk61RbRywjem
         T4kA==
X-Forwarded-Encrypted: i=1; AJvYcCWdLV3v+B7fj5UPw2gnImQzS7cEy7bO7wt1RSxzdBm1/7VQm3AgCX5IJXo2X8JltAWsQSWzGzMbP6NwDY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+Dy4XUir28nDsB/urRDHiydCT/hn8byZbKyCxEfKqkgG9OkP
	MY+XjwzTv3e1G4OtWWE+rdzyTIJcLviSwZB66PbFZjirl5hp/0jvNSOriZxXHiQvKHelezLXrIK
	ZPe0ffDZ+br0gkt5GIy0+Pmst95r22fPqr2gzLNXNLe4Jh2O6xsfzUBxyzkDevnWjE2pSrzX5eb
	8=
X-Gm-Gg: ASbGncumkMgA0LnGkslQXloXPbLcgqVMpdB8nFGt+dPgDi7vfKFSlYrnQAe25QdMOmQ
	kx6ggZnESuE/mpKh4Hd1m/8wGlAfM/TY7ymDEuyN2pruVIzGocRzyzXv3HJEIfRvR9D0YbpWEQY
	u5R8AcpBkm5+pSjju0JXbyohQ7VaiyOLn7R5zWGaQtCvSQVEuo8G5f1ilwzpTMO4PNB81srfs/f
	veUMx7EGutHAqBa7QFWEOy8aG+fXiTvllvGh0N1I61ieIE5DMN3g0JDid5Ah8XbsI6rlJ1+MlLi
	eGuifIksL9DY/99m1l3e0YRKYEgsk8dQLjg2qP4Flx6ILmFtow9YndkA4Jd0mze4HsY6POBTeTr
	U
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr164572435ad.49.1760114791457;
        Fri, 10 Oct 2025 09:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsxeyikdMvc9n3cRyalMxLlb1YcFKQRAqMJOZUbfHHv0r/1PIx3oESwUGS4QtjuZ977iaUcQ==
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr164571885ad.49.1760114790829;
        Fri, 10 Oct 2025 09:46:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c07sm61831635ad.1.2025.10.10.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:46:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 09:46:27 -0700
Subject: [PATCH ath-next] wifi: ath11k: Remove struct
 wmi_bcn_send_from_host_cmd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGI46WgC/52OQQ7CIBREr2JYS8MnthVX3sMYAvQrRAGFWjVN7
 y5h7UY3k0wmeW9mkjE5zGS3mknCyWUXQymwXhFjVTgjdUPphDPeAmOCqtECXGh4XJA+vZPaBJk
 xDPKUopc25lEaP1DFOG5BcBTYkwK7JTy5VxUdSGHQgK+RHMtiXR5jetcHE9T9V9kEFKgApQdoT
 ac2233Mubk/1NVE75sS1TTx/+i80HvdCdSKdUybL/RlWT5wFwSCSwEAAA==
X-Change-ID: 20251009-ath11k-nuke-wmi_bcn_send_from_host_cmd-a02e8192e9e7
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXz3xTSkvQ5nSG
 h4u0ygmuB2eIFHrgU1C2zAcRcCAByr7cQDJTlxCjwM/2uomJFBGc/B00E6krmUDLMgWXNLp97Wt
 Xni1Mx/GdhO5Q6ykP2IwZT7DLEccIXhHXNOVRq4Kn3Ns6wOFM1Uu6GsJAqwIQ7z9FZ6NJvRBP2v
 F6s6EdjhQwCf1JGK2+/zUUIK4+FC2drB68HC1T/V+NqAZ0ncIBfcki+2GgfewNYG72KgKq4CO7b
 oL0HYrf9vJdum0WFmY+zDAF+FE8xwbJ+HSvmhuSfhviO1aIxqI7mecW9Aq/CaTzc1IJmTJLw+yu
 B37TobKD+TsDdFZ/oCHNGo6Wz2pUgJ55GKA9WxEJyF0URAo3ZEDp0NauLCqLrqrQ1LVzYsAP7sI
 6faDODDo4zJO10CWzdxCm0lxqMNTqA==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e93868 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=IK4e_bFUgs84OYqGAtIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Hkm0KNCrdoHJes77hipAp_xiF9WMsSVk
X-Proofpoint-ORIG-GUID: Hkm0KNCrdoHJes77hipAp_xiF9WMsSVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

struct wmi_bcn_send_from_host_cmd is unused, so remove it.

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 9fcffaa2f383..3c4885a12855 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_WMI_H
@@ -3463,20 +3463,6 @@ struct scan_cancel_param {
 	u32 pdev_id;
 };
 
-struct  wmi_bcn_send_from_host_cmd {
-	u32 tlv_header;
-	u32 vdev_id;
-	u32 data_len;
-	union {
-		u32 frag_ptr;
-		u32 frag_ptr_lo;
-	};
-	u32 frame_ctrl;
-	u32 dtim_flag;
-	u32 bcn_antenna;
-	u32 frag_ptr_hi;
-};
-
 #define WMI_CHAN_INFO_MODE		GENMASK(5, 0)
 #define WMI_CHAN_INFO_HT40_PLUS		BIT(6)
 #define WMI_CHAN_INFO_PASSIVE		BIT(7)

---
base-commit: de7674ee69a0023a2dd1c6f0cb66f3cbbba89923
change-id: 20251009-ath11k-nuke-wmi_bcn_send_from_host_cmd-a02e8192e9e7


