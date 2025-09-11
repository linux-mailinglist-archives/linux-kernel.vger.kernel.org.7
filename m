Return-Path: <linux-kernel+bounces-811301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411AB52733
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DDB1C26E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48724E4A1;
	Thu, 11 Sep 2025 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O88QfUT9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E623BD02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562092; cv=none; b=j7E5qpcY9/q9gtjQZhEPjmaUA+wAiPUkTSUrJUGekd98JPHtF+yKGrHa05TZWq/2SBt1DRMyBcmtYp1xFj61N1JYwinTP2D59mKTYEhcLYUX4lClQJxj5fQAGf/WHoOTDb7x/P7mFlSK7Gmpeu2ps4h263Ajoe774N2Y24eMWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562092; c=relaxed/simple;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCwF6f8PfD6LrmKU9ZMp7SlTFSSr5tnXqOTY7OiONyJT7I27WF1xIsTQWGLPeDek4uLrP5M6t92DT4DyZ3qLWfQO5xollEa99NaWVxz0evg2GMj9kuAgDycC38oA/s/lPgT/lis+OLT3NkUcgBZQ9s9Ore/Jkqoak+bjuMvdELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O88QfUT9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IgR3026922
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=O88QfUT9GmAis5Ps
	Rd3Etve6sOMnGsOB1PoKeD8JHjerLUfP2tnBbArzZBPIyEuWUNXDvA90enzHZYIM
	jMDje6iPstBEmlMOQI0rDe8TGPMgSQ66X/hLrnByK0zob7QCeJHlUHP9PVPKnzPa
	RcC3Kvr248vdGcBYGqIDecQvOTyole3a9jungNRYUt4VFw+5F8QTQ82+JovIV5pY
	Q35cY677ctHy0L3+qubkkYTiZmCVZGMj9qJzY3hk0rLj6eOLDtL7r96VEgfcCR7M
	NMOtOdB5Fw0DLtcxbWyCJXKdIZuppx/BaG4rEIlxKmTIeUcbY8MEURsYwd/HohAH
	F8hwkg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h14e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b0e137484so2429225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562089; x=1758166889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=SX9fYvLAl2GkN7oM6NMdWPMdFGaNK6c6i/iFWJAaLTK9PXV+glfrSOxfugZta9RlVI
         2i2WMNt+5QKMMTqyM7LSYHw6cvh67ZbjCPBKvq+d06kzaRWLf6LctjlFPAhtwJa7TxRw
         QQzGKrtO62wUnVCVfIiQFyuDXuhm7rGHktVWfpXV3OpfGefZzi0CC0r3xdiODwBVRSuW
         RXvZ5rNGbtGsyZTy/mllyHj7Q5OHe9fVLKvufO+4mq7VDjyk6NSBN/SYrrphmvbTmCYE
         e84RbbxR3ZqeKQXei+1EZWbfaUkNzznzgUlQ+Twb5E5Nm4mF9Jhr7NwJxhyt5XWxvT2J
         h0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXXQmhFNh6HBDLl7gHjfiwrwjzcc4AXJzcL4p+8w0/TTF/Tl/xTJ627SbEHmqNouVoJDzRnGmvAVl2GrTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccxynF4/6pA2w9ohniNb0C3RS2M0vnNW1WuJJ8s5n7bRTa+Tz
	nkVfezvrbuw5DdVMrucvDalDir8ivZBazV5Jz6Lu9OD7SfvQD7tO6ImPy2nQ6eLFxVdhI3+MciR
	rXMOnxHDx8xnG8sQRTDYG5tHHOGCFeAWG+s7IccdFToATFt3IeyS9QquxwXIwlgN6tA==
X-Gm-Gg: ASbGncs40cHqnD7Ih/UUAf5NEfzjWVviYLSvdcfka15s+eMzA30+2DE/r485KcCiGfZ
	O9Z8xD8D4KF48YWe27jSJWEMwyqsoIL9tZ8JI/sMpRWNBvVQlotslX0ACtKq4PJmFBUL/xqjzB/
	p78h+MMVdOgoxTYmOCr1tP48a/v+8H0fGOQm8gn1mJht2Q7sufguvOYtFeG++AgUSY+RsJIHH66
	IIdLIBfoCy0iML84rulXMIA3i9vvDFeThhySY7zNcWEO04yhBPj10ixEY9LbJaKCuZjOJRFqjuA
	XpeULSjqR0qrEcQi9EEPYqtmAmlLHsuDFaOkma2YT33NC4JKh1JlsXcmKv//mSQ4QJkGvXxw+r6
	3zypGlGrrX8/tPj/w+Ysn2HA=
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434575ad.36.1757562088990;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKhpZZ7QQ2u4bajGkkm1KKWLUYyswJaL/iiPppE3MndRE8NjcBrWi4HRB5LTZP40i4NipFKg==
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434315ad.36.1757562088589;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:16 -0700
Subject: [PATCH v11 03/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-3-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: RVWQWNm_PngR250L30btTq1ytBDTj0Fv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX6DyaB7zmdniM
 3rcC360905XtAb9xvtXHAGHl1Fw+vv/kvZqaPND9hV+Phfxp0nuvaBcqXa86k8kqLpd6bOGENkK
 3dhDhjCp29C95Q4G+MOV7YBmvwPKurC1nfjVvziOeCYkr1B/oalPA7kuoIyMz6U0Y1StzsvNbb5
 w4kWgv8m8lJGjGnZ2dKlmXasLSZ5qpuExqodJCgsaofg2SjdJS6IUH8h8wL3n4x9y4s2SCV+u9K
 6xmEpC+MnHir9JS59G+aQ7bevBu2wuh9DgeRbZr8OULwgsBmTplZKZk/Yw2xM9gZ7sD8nT3qK74
 spfjX6/fbBjxgKFAaLLzH968aTbVm7OVO7Tqa3vRff4C03ICc0D5R+KVU1Eou/X1loondh6Og3u
 2B/zLVPt
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c244e9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: RVWQWNm_PngR250L30btTq1ytBDTj0Fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 807317d7b3c5..9fa042d80622 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -926,7 +926,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


