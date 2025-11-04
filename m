Return-Path: <linux-kernel+bounces-885494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CCC3320A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9514EEE99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9762C3255;
	Tue,  4 Nov 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMqgrX31";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrZwHjGD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B81C8626
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293780; cv=none; b=n5YOE5EmXpT6LRHMhy1xRw24SktGRqXgAP3O2F58dHT3cYDWqI6x1ZGtkLPMGNVtD0HpQfDBmWkf3xeGGsgvtsqAmKZEtMMDk/LOYTwGZ655uvQwMnIEGG9jkVRvskzgwFWJpDgosgG/eN0j1da56b7goHN9HfWaasDtplq2tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293780; c=relaxed/simple;
	bh=R6DWXIQtTgOVqyqFGntHzJ6y2K58e9q9hULx6A0wDQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=be4nsFFQQda2JuKshqttQJ/9dr0IfUzy3/+++ue6hNbRiMrJQTnXbZViaVJ6HA7Q6lH5TfiC7tkPgVX7Lf1KyeDT0bz9aQln7+E/fVuhO3CyjryDf5XSwg3JknztqydFXZosb8koKbsdtGoEgZb7tFJM65ItjVd5Xo3sq29PuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMqgrX31; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LrZwHjGD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kg8Iw2968532
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 22:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GwIOE/j7bW3rjOQQEU9BoakITgjwxGcmKM3
	SVmsTbes=; b=VMqgrX31AcZ6G8tskHhtcPsAKSqJb1QDPVri5FJT2oZ3JJZ1uGU
	romt4jBtJVRYRcXUU6hg/t4Wb7VVd2m2gXkP/GiYFJNzF8kM2Z3f2Cgn6xJgd16q
	PBwMUhJnvr91WMjQ1frIYeuq3D+qvxa+PzKbKiOqFSzxDrqzbFy0wB1SmZBPriPW
	+6nIIQTErlFKzjiFvwSeKFTC/+nu66nqh1M1aNHGygavkn0eeImd3WQeY4XoAbi4
	oGyQtxW72vAnuLjDRf2R5ciLXIFYYPIpfH0W4SJ/d8Jk9TDMH0JpS9yyzgzAB8NQ
	QAOJEyZm8j64Ywq5+Ck00vkTtbpPrBDr6Gw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heahnj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:02:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290e4fade70so76103775ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762293776; x=1762898576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwIOE/j7bW3rjOQQEU9BoakITgjwxGcmKM3SVmsTbes=;
        b=LrZwHjGDvx2I9inBA/A7gTW9OoUCQDzNr179R3aiDW69wOUyvBTlxCl1JFLMIxH4Qb
         UDHRjYfdLXJp9fBUhhrdeVrnHwtdRx1pB+WQkXMf1zdeN344+En0xtoHjQ9RduCMLlxo
         wnbIqfhtWhVkIsUbE4/wMZwqOlzpNoqgVzjN3ieCx4IJ+qVWhzBJDke2LgYuLC1MYBj9
         ZhXuB9E4Z4JgoLdJYJwk6QDlXstzlPG/0kUooeEcppnElPFUXSEO+MhCNvyfzd+cKdi/
         qWhwGu7a+fNJm5SI9AfrJ+LUEmtERxdq9WkoQi+mz5hv8VcJRWKKyvoYK4mc20BdlF9b
         SZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293776; x=1762898576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwIOE/j7bW3rjOQQEU9BoakITgjwxGcmKM3SVmsTbes=;
        b=OvgYEPcGAbYvX0170wy4gLsPlprh6m6eydvnH3K3uKw5YRT4awjmXpGGU0+oIEe5WH
         7C/lA+2R8AVm3DNfpKmQmagU1lSWVCiRaiuj5xp5KUNAHTsYavzZAXkpOFoSPY/Rtb0l
         26WHQt+Km7QwXddkzkSBnBIsQjWaX4z6uD6kktUOcUuWFWhLfrb46x6AtndpMMdJZxsd
         fUt+JUB8C2tM4yraSRNcuC1xqDxBjnzgy/N4i2WgS5mwx3lzOaLz/WbS0NNC73Mj/Saa
         XO4cgM1KMTyqe6im+y525hcn/8uBavDWcNMdoV5umds2oLMk8QFMKOAAOyZB4H9CjMkt
         ZaUg==
X-Forwarded-Encrypted: i=1; AJvYcCXiBaEc3qIph72kkhBn/+gY8jdXqbIRnTxRkRX/kNhIjBoXpo6CQOv0LDfkD/fz/xCUH8ufROJNPyos4Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxLOTKRb1Fn8Xzho87+ZZpEJUNidi9dO1l3J2cWdxmruR7hzi
	Qm5Nb0CoY9HZUHnI+/T3DZV3GGkYzV0MDddtVHT01U6ljrs9355aoMRkwsL3nX48MY4F4Qt6oDu
	4PCGqg4w6CHojCnNAe7K2bsGRtHLc4ZmgXg0sLiujTMl4qzhPCL4gCTDl3xXN6Hj2GBM=
X-Gm-Gg: ASbGncsc6exlHaO0H8sy611lohbswrFC7VgTfTgZFhnBach2qpxrLZGUj/8AqKACXuC
	Hg/Aq42HvNGmyhwSkjiq/+2gBEdepw78kOHzDKaCrFsYF5Wfj1QwQPeN27/IyoZshtWNfhEXuxW
	VYnMF34qoX+dQ+KwVdtLnGTVelE6u7qU3AsQAMwmzlcQLUP84eq0wgND1OFCcICEnmKudYlU5Uo
	sE7W6eRaKK6GhkFh8rV/JApS0aqKhOwFNI4P/A7pp7BLhSkK0Z85TOFFNj0UHpj1Y4LXmwcGHNF
	YwWLjLV91bSXnDD8E9YV1TEO4Q91JtJPwVMRAWWNcEex+g4O5zWMitdpRjJofnG+67G7aE24eVg
	92Zzv8szBEA==
X-Received: by 2002:a17:902:fc48:b0:271:479d:3de2 with SMTP id d9443c01a7336-2962ad13fd2mr16326265ad.13.1762293776304;
        Tue, 04 Nov 2025 14:02:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFavk35ju6KTwN78IzRXYY+q07xxAOOCvfNpXlRntG/9emf8L8fCqQYtFVa2gtfvOtl9wk9DQ==
X-Received: by 2002:a17:902:fc48:b0:271:479d:3de2 with SMTP id d9443c01a7336-2962ad13fd2mr16326005ad.13.1762293775845;
        Tue, 04 Nov 2025 14:02:55 -0800 (PST)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a80459sm3394989a12.15.2025.11.04.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:02:55 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: Add Akhil as a reviewer for the Adreno driver
Date: Tue,  4 Nov 2025 14:02:45 -0800
Message-ID: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690a7811 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=TbDdNxe2xOi8XIqjo84A:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE4NSBTYWx0ZWRfX4mzJHQUISbuL
 KpSX+yFB2Am+amQYomyMRh9b/DP5FZjAxeaUQMlD/XAmkLMm9upGqkpn9lnPmMZY2KJCB7Mq2vy
 U8iqf1ZBSfIkl93xWNzQSizRP8MjjDnHQT85N7RuZiHdzMuAAO+IZ40FNZHh3OvzHQBIY+c+mIm
 0myrrTvfoGgXNl//o3BUbZeLajarDfpOkv5frE0ozzPCJP30EcWtqjz232SiqRdgL2uV0z/0rA9
 duAwQGZ2pZwv3vGhkiLCWn0jyR5H15/r6AgBRH+Gd/axfyn3K314/pS7CT/dKs/jZczQc4zJSat
 ikL7w7+zQEihtsOGs2/jQbRxlskNibRUzanG36a3UmuDPlmwIqwDAhZc49TtiE1NMGN2oiChoRo
 qGZOOdH7UTHi2PfQkaupRR2Ig4Ur1Q==
X-Proofpoint-GUID: 504fOOKUdZ7opq1jziTDRekLHAoIXO65
X-Proofpoint-ORIG-GUID: 504fOOKUdZ7opq1jziTDRekLHAoIXO65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040185

Akhil should be getting tagged to review GPU patches.

Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1083598bb2b6..033675aab0d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7880,6 +7880,7 @@ DRM DRIVER for Qualcomm Adreno GPUs
 M:	Rob Clark <robin.clark@oss.qualcomm.com>
 R:	Sean Paul <sean@poorly.run>
 R:	Konrad Dybcio <konradybcio@kernel.org>
+R:	Akhil P Oommen <akhilpo@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
-- 
2.51.1


