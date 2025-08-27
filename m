Return-Path: <linux-kernel+bounces-788146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E9B38060
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456FC4606B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063334AB14;
	Wed, 27 Aug 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQGO7Kcz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00891301014
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292154; cv=none; b=PA5lIls/ho5Jis3ai+bep3zqLKsVcc+qX9ovnw1C0HBRP4j7Pyw+e5Q7YtJgmUeOyX5u2ijCBdqTG+gRFjDdszRX1YzfWadoD8LacND9aXmKGB+zHqyXcXJQEfXQw6N8nq1YNpEZKe7HHdVcWBnSJ1dAeyLZ4RX1RPxyBewFj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292154; c=relaxed/simple;
	bh=F9x8TdUV+UhMn8v7bE0wMU2bAIkaskGlFBsUzzEMYSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mWJ8MoLRwF7H8MG6X5Op44TXnKIFgGMPbgl4rpRQxl5S51PXbZR5yw6PL4n61z+JHkqsdo17BNZh8+4j1WsSibb96iCZJFL+FxENy/oV8oF/IAaMD8A1gqkwNdvBYmLfkRjh3cGx0GZhYy4J9+BzqYZ9WlkXtw0X5Ej7/2i7UdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQGO7Kcz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kDkw030203
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9wdkqfpaZOOvxTwoHvHvU8nhHI49YCbpuNr
	KJU42fBg=; b=QQGO7KczCjbgvYYk+9uhic9rtK0iddHdETY+RpOHmkKn4up2YXn
	L1Q2n0ZfFDweFi7bZrN5hnOvJEwWCPUNlVxsJY3qdyCNIUo+2qk//dWhwyulZQc3
	ibNg1Pik+KCZdEk/Fg+yM0Q6I1YtAxf73Jd1ZgK22qkuQqoccFQpsRNRvd/ZziT2
	1aDoGUzWMxGY6t/jP86V2fQ5rRdeU9ibCoKmD+wCMFuQCQHLFaAlmSKM8+7NFMlh
	skmjYHRYKlOLd+3mCESuErznGZIvHxRiH9EWUDJoYEzTlOnlpHVitm2mqlMjQ+z1
	B1vBSEyaCnmNk7j7nQaU7Dm3842OdDTm8MQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unv8q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771e331f0fcso2611957b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292151; x=1756896951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wdkqfpaZOOvxTwoHvHvU8nhHI49YCbpuNrKJU42fBg=;
        b=Y8+qk9P6Dyw4KcomvNqMipN6jwlOZMwemAtShPi4nIqvGQ4dqOAGT6Kjcx2uVHRFvV
         LYpmENS0ZxHmZFmUbrcDpC4MxrvNMZQc7oWhJ0c6yjrb6/UgaEjFdWHU0MJFpwZMO8fs
         FqN9EtR6fZ4XN+HCvuQTtlXmDA9BfpwiQkH3xSnz+5iuaTSQT2XUcSLY6V3WFQIH8eEw
         NR7Eseb2rLnmoPJwZQdtkRo4lL1T3RhAw6V7Ogb7W6fcuazPDD7jpd4kgzRSTPpH3Yqg
         EzzXw/cXaubGu3GY4CVyfYA8JcQNyCx7I9qsIDc/lKLygJli39/Tg8zGTALipf5abO3M
         dOgA==
X-Forwarded-Encrypted: i=1; AJvYcCVwlpwgbte9/yzW9cebX+C6hzQdeTgqzfLh9VmnKm58dtUVrymsOtk7xqpxHZ9H7F5uLWb1GBQMtXHdSXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjWYgk7T3emTEC3KhlInFOBy1qgd2dORWIYyRnysUWTik0eOD
	HrTpyS5/GTApojVbWeTWSfiupLoOMq5IGEfYMxPbliJ3uX33fyOPUFQ2WPKhBQbXPf8ITVy0s/0
	L3O6XF0QkD1HqZ48cfGGlt4W+dQS18nEYK5vo+uxPSo3+1tPLaV2UG0zcSRRtSg3q6cs=
X-Gm-Gg: ASbGncsuMPsm0s3Mi30G0pxBoher0nm46Z/NarTnbgZRHFdpWeBi5pBq6XxKc+/FDkH
	ByEUgP/VIz/NJbPK478QCXmYwJy6XdlxgSR2HgOk0LGwxzt8DMoOfiTk7TQJxqBYZ9VDRfDIgLO
	lxOUqDFr2rbDqv/Qmqws/L4AmW7Uj+b3fmMPVt88qvbaztKFnkiJgvvBOu3Dqv+So2+8W1DVpLW
	Hga8Iz7F3jqflOvh/R+9L12jD1VtCjtZ5juCKde3FtJswXSKDiIw6565ddAONpOduSARZnvjwfz
	Ctbp9T/wCax3pnWhGnFuVLgBDAHTDGpiwmU++c7Yk3Tsayx1da0L4AmXAbvhmmu8QRiwUfpBsuO
	YXU8HY0kxMF8pyziiXSxy
X-Received: by 2002:a05:6a00:b44:b0:771:ef50:346 with SMTP id d2e1a72fcca58-771ef50091cmr10777475b3a.15.1756292150580;
        Wed, 27 Aug 2025 03:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqpJCRpa3pgQwwL2DXQzr+CaxFnBbfnfaaX9zy/10KGXLksC4chuBLZap7O/yZiDteErLiCQ==
X-Received: by 2002:a05:6a00:b44:b0:771:ef50:346 with SMTP id d2e1a72fcca58-771ef50091cmr10777433b3a.15.1756292150108;
        Wed, 27 Aug 2025 03:55:50 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2f2ac7dsm5573035b3a.43.2025.08.27.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:55:49 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
Date: Wed, 27 Aug 2025 18:55:42 +0800
Message-Id: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uAcw7IMG4Blrphl_RRhc2oFQUeUuqLSi
X-Proofpoint-ORIG-GUID: uAcw7IMG4Blrphl_RRhc2oFQUeUuqLSi
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68aee437 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kL9tw6tk32Vw8pM4mOkA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX2WrBfbCXquaA
 NFMQDwsopRSZ6TmsVdNg5fSM2r4GnOKFukIvaIqlz1VNN1/AKhBLzmumBrDOmpte0qlRdbITBXg
 n0E3xVZ7lHJ7kj8cYpnIwXA7SgfuDG72X4MM9xw5EPAY0/yxeXrNbf2ouOGXz+TRzxDt70ECz3x
 Ye+YUBthE/gH6H9QCsxt7Y94s/ih2yNxzZtsU7mDWLsCSAH35syB5+fQxFSiVvKPr7MK/U69+EM
 ICGnuxlNMk03HMX09HYsFkMtvxiuyabxwEcsqFjAytp1RLW7L0j0Cviu6NuA6ZQ1ghintfgWLUl
 XULy3YDywXG+cJ+Y6ewRCzTobGWrFWeyMgZGN7+00ssFDpXzQGV9FpVj+wDuTXoAeX0toAWox9n
 FcUnPNTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Patchset 1 introduces configuration of the cross-trigger registers with
appropriate values to enable proper generation of cross-trigger packets.

Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
which determines the frequency of ASYNC packet generation. These packets
assist userspace tools in accurately identifying each valid packet.

Patchset 3 introduces a sysfs node to initiate a flush request for the
specific port, forcing the data to synchronize and be transmitted to the
sink device.

Changes in V3:
1. Optimizing codes according to James's comment.
Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1-jie.gan@oss.qualcomm.com/

Changes in V2:
1. Refactoring the code based on James's comment for optimization.
Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1-jie.gan@oss.qualcomm.com/

Tao Zhang (3):
  coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
  coresight: tpda: add logic to configure TPDA_SYNCR register
  coresight: tpda: add sysfs node to flush specific port

 .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
 drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
 3 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda

-- 
2.34.1


