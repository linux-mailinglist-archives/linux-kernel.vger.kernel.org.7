Return-Path: <linux-kernel+bounces-760576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF79B1ED2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6062A7B1524
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCEB2877C2;
	Fri,  8 Aug 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbecY7Go"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94A287254
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671480; cv=none; b=TzVHWf5lymiUq1EvrFd15HfCwxA3iypYwCcny5dTSBDv8opiQPrnqlyjTCrJONw8pt6YpMfHhXPtDG0JUbtFlN29zuokJXjrCa+bd8oDRWB/MtfPi4IJMLRa1MRzuhhjgFKw1lywPyP2DjXK/9SUWOmi3/VQduiG3ahgu92aNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671480; c=relaxed/simple;
	bh=EqzL6rRNfDoERryCSv/CIEvhiAVHF+Sgc/VdogwlX2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rii+5Ho3337n9qYSyR653ELiPVBrpRH7OddirYKlleWKBPJBCCnUuXwrgbHTESfBZ+C1Z7hJ9Np9UVbOHHhc8QZt7mvgjVjppkbSQvnaFVfr/unJWm/atcc7ChP9JgT6uZPwLNz7EwMlFgEPjke8uU3CZPbcAJqChpGh+Oc/48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbecY7Go; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FZAep008408
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=huQmaFeVLUaz6BrvOTgjq7zFoIFLwTBr1MX
	tCtGIIfA=; b=QbecY7GocBo81F2WWovpuEGiFoR3MJTiATy3z4eN7gM0iq92c2t
	8hm5m4TBvHIH/DRuvSh7R2lIsG3BGx6RkE2xqbb+GflXOmEaGlnM7OIB0tz6Y4rY
	1wwlyFdUaDgU4NwIIgDh5b/N6rMJoqV3vVX/XpkSSF+PsiBq0bOkbOwlGUMAF70k
	004xSI3QGOLF4/u0nnwwX4+eiqdvSRLZM/1VLUVMZPw7P/DCa9RulJrxYjXGhuu0
	tdD5Vs2G8rLopoxZbYa38BBbewMpfxXu/V52EKXNANcDnsXDXLnSpmZB86quwVZJ
	uBruZwBikLFDgclQUetSznREQFtj13jyHwg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u27q98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 16:44:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so2494844b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754671476; x=1755276276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huQmaFeVLUaz6BrvOTgjq7zFoIFLwTBr1MXtCtGIIfA=;
        b=kHn2Y8CrG90F75x8frRLNDe1jXKiCaMFbTwEd/hZ3Excs2O6rugghXLfUQXFpC+8Ni
         StX0Rhq+o1/899zBejZw7zPxzISMGzT43OmXMnohFpL/Rf9A9Pa5FX3cJB5ryiTOyVC8
         AubDq5e4zuj+/hPKgg14jN3wAKHLvmsMxaajURrTrhpg8K2Di233aGZmmtkZf2PqFwSb
         guksf3jzYqNh8+xOFU9xupBJ5ArzDeuYNI2JIaocQGSYSZvi2gpzU6hJ+2XytqJNdjOy
         fK4uhFq79XMQfSWocUfuc5mvbTYRCX/fJZeY67YCdWBC1AZfPIhDusd87h2gXARJHIkv
         VrXg==
X-Forwarded-Encrypted: i=1; AJvYcCXjsmsrSVtmtRMo+InexnL89oASPr4jlR7ZhcZ+zb80/b7q+sf9pmAvhIJKYZJpp8P8WchvnWtVlWcqOZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mJzvlbGcOxDM/ZA8IN4JATgiV1/AuggiMKIg5zoGHDM3xELb
	XwVKaMxZBFELobhOWx+sVv7FM0nQvJtMY311/iCkisf/rxqG6RbOJvM/gxRTCn5wDFbLzw5cOl8
	eavDZv7LnXPypGkRATtyM0luZCz49iIw0QTLVQMLjSlqJLbcXic5utpq3obAQLTxuM4Y=
X-Gm-Gg: ASbGncvGpg/s6FVpp37zj7D1IjVKxXgigHKu1DNdrIjb5g1PmU2AyUrZDyQ/4r5f4oT
	69U9kjArJlubAaVxe5ZGzSV8v8MW2cg/4fq+ixSNM32Tm4F+4IphVgaJkzMZfVwBaO1z5reDdx/
	cg+SelhIXkCGIq7J0jXlUDhsszdzhtB5+VbMLv9a8DQHjGppe+deWb6YTJ4Bzo6H5vv1Zu+Pwl6
	xd5R4F2u/gZ7I54Sywjkj6LVU9THr6E6irNmHCqCUyTbUuyiDPUfFCpyV13JfhjtGlJmqlYWTm4
	nT3ttln9syhryw3+gZDpcOJXzekWP9dciJRnC9Sz0JwddmFBJ83QgxHJFEbO94THy7U=
X-Received: by 2002:a05:6a00:92a3:b0:76b:d93a:6a02 with SMTP id d2e1a72fcca58-76c45f67a5dmr5010281b3a.0.1754671475950;
        Fri, 08 Aug 2025 09:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRN9mDpNEYryQ+Th1q0Yl+AOPWnFZ0wbyScqj1Kwa64LHrFPfZCQPxWBECZkWS/S3tA3rHhw==
X-Received: by 2002:a05:6a00:92a3:b0:76b:d93a:6a02 with SMTP id d2e1a72fcca58-76c45f67a5dmr5010254b3a.0.1754671475508;
        Fri, 08 Aug 2025 09:44:35 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0e78sm20690165b3a.99.2025.08.08.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 09:44:35 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] remoteproc: qcom: Update MAX_NUM_OF_SS to 30
Date: Fri,  8 Aug 2025 22:14:17 +0530
Message-ID: <20250808164417.4105659-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NFGmtO_xy31IcRZaUpUbctX3p9jxWPx8
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=68962974 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=evFLFRRwLpfRx6s5WfcA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: NFGmtO_xy31IcRZaUpUbctX3p9jxWPx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfXw3nsRKRMo+ZP
 ZE3ZSbAN/L2L/SdKTqkgDiqfHZmbe6WfRhy8nJ7os/ZIi4KpXQdxeJei37j0tFA5h3E2TaO8mly
 wyNcm0q0g9d8WbPq00887c5S0zd4Umw2YzRx1AiyQH84xSEjSal6lCnwoypdCbqcZX+BqIA6Pdr
 VYzdudt9+BnETMnd6JJqsVKvRPwueocf4rg/Cqr2nTm2N2Fv6h5pJQnbHMHoSvLJFHJ+zc6YYsp
 jFlwSd9S/TtdT/dFNEmaEvmmB3p51sxpPyhVBUyrgndo9UKw0zwr1iCElevutWEyDmzhHkHepnc
 XMFbdWnK9439Ouwp2Lz8yFwE+hOBzAKF7T8cVETjqIMwWnqvBkyJxbwxOW/YPOIh/PubKkpeVM7
 U8IsvLUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

In the latest firmware for Qualcomm SoCs, the value of MAX_NUM_OF_SS has
been increased to 30 to accumulate more subsystems.

Let's update so that we should not get array out of bound error when we
test minidump on these SoCs.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 8c8688f99f0a..dbe3bf852585 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -28,7 +28,7 @@
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 #define to_pdm_subdev(d) container_of(d, struct qcom_rproc_pdm, subdev)
 
-#define MAX_NUM_OF_SS           10
+#define MAX_NUM_OF_SS           30
 #define MAX_REGION_NAME_LENGTH  16
 #define SBL_MINIDUMP_SMEM_ID	602
 #define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-- 
2.50.1


