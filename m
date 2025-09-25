Return-Path: <linux-kernel+bounces-832270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37BFB9ECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7970118909DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF02FABFC;
	Thu, 25 Sep 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYBx1KdK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276232F3C19
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796974; cv=none; b=kIkLEA0JrQtYpdeQuzVQ8Ks/LxiakSo0SuxQRi97oLJ359RA9HuxIDizN7IQpqmsAMCsUX7eTfu4E8lgJYwh/cvWd+VVAO0uSyDiIENIdavrAlQz7Rg/ZyJkwbv6nPFVhYUevES1sPSVl4S/uu7EjeqjrgGND1HNdlCC4h6qm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796974; c=relaxed/simple;
	bh=LInkO/nx2wI1fZWqmF4NU0yltD/5FgxKoXKOWc2WyZk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iffYkjCrooNV0QAxSAmWDqUivUK8TKKOvmAhyYJH0nwjcqy1Y1PqiNAn/y7OhswGBUMLBTm2sV/Hfcn9gEo1NMGNVnSyGEAeoLhKjxRjRWe8NyhxXsUwMJHXvdzcF7Yp+h1Ms0J5HfvmYJnCap5SOI+HeN6XKMl/qGlS5B/DKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYBx1KdK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9gCii002400
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wCWq/YTIiXrWmR7ttDtIOY
	qUi63gbK9WENznA2ZOMaE=; b=gYBx1KdKV7gFCTrFdAvzvjXuqpIsCRJtDsXDwY
	TFWMH2WGYNJTvNCX0Jg98J+3UBmoXp+Ry7HiPL5sJ64MqiYHecd+pvYjnUQwqel+
	/sAzP0Sc8IHR5Qvs7Dns16S95g6rUWd7XviRdTydl/lxXVBrYAgHd8l/W2JYEP4Z
	cC0yFvTq/eGS4AIe9w2eezg7qY+9GfbI0rj7vHdGoCRbGCDarshK1wWRYNEBGizp
	eDLzojJNe0wk7FAOZ3tQB8JLFqBcTxWZdnVkvTw2y6pWR9HlRM44oxnswXYWLPwh
	Y6mQswqDzPAMFraiq51CER36m7CbjGSBqTJVnx3DA4mseeJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qrt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269af520712so10964485ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796970; x=1759401770;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCWq/YTIiXrWmR7ttDtIOYqUi63gbK9WENznA2ZOMaE=;
        b=HPJgJlqxOrIQXVAv9ypr98t/eZ6L/uWFbpz/qx1EY//sizIp/3zdHVjhou2+u9biCV
         V5vfiuJxZ/O8CB+72gEk0ABuVNH3QPelrITwCgNfTRps4Ee1ieteFSHyjEy5kIkc+Llp
         E/PSBn27CsZRUwRXehOVrP4aNxaZ2XH9CeYleog+uYABXizwoUSWyuGzGszFdYLWSg2U
         Ft3DU2oQpPXeYOuVzmozyLRZPaSMxilJzObbvCPIhUpYsiG5cLaR3DQadN7uTy0KmXA1
         2iwe9JVTKAlFdu8gOiDt4C3NK8bABrUpMEVIWOWF+r6aIM0yxBEJAfQjftj5JVTwwo1R
         F4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZkB9b1L+AKHLxg+JuwphItj/3Z2f41td+mGtVcksQwscd2Hqgj5mYAVZXOVNhMQDMtMsf4IxNkzEZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8Ec1UMVx9SkEVT0xXrSjHZBNcq2kTzQlqSYFQ2YMKRyxRloe
	AeNHyKYijbO7JbsgGX9seBiB84Jdfi5dveqnAh00bfoKqg0VLezAJquthCjuoSxcJxj6+FoXjvv
	gUgG1x8bbVjvBhoJQY57oKVpAk4qeBHq0GNC1adQzFgjNt4I8jDw4wK5fWY0OrdysiA0=
X-Gm-Gg: ASbGncv6huYfNqCV5HASUegFx0R9DDsFYz7CSntU886Ydu9fc8JOt6AtgST0oB0w2Sa
	4EozjO8FBfOa9o+Usx0huFolNObcR0oXvEgytbmtXCyRXs4hBifR0gSpf7bqO75m5jHFY+wwthK
	+lzeGtp0+BUYOyAPctwfG4xTCesUq9UxB0EvVX1i1GyiGClArwSsd8YXswH1FSITCv7QZkg7htZ
	LiEenCin43e3eNtvsJ7tGGe//R+ulNiYXKzBElrDYvymCR5bKBrt5cDM0VdnCQlk7IXXzkyafIp
	Qy7Vp4c5rS/65WGtVEv7tPuo5YjyjqglNONA8gXA4E0bmB6PDxdtA1BTvDG9PxroX/4DQUG2Irs
	TEwXMYY/0c+PHkPk6H4pS8qBfqw8=
X-Received: by 2002:a17:902:ea02:b0:270:4964:ad82 with SMTP id d9443c01a7336-27ed4a91a49mr31884735ad.38.1758796970368;
        Thu, 25 Sep 2025 03:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeaT2eKj5qrrJzt2bg3BLWcEXxAXbXiVG2V0Z8kPJcO1D39oatro4Oz6xFObn0LQxLYstl1A==
X-Received: by 2002:a17:902:ea02:b0:270:4964:ad82 with SMTP id d9443c01a7336-27ed4a91a49mr31884365ad.38.1758796969889;
        Thu, 25 Sep 2025 03:42:49 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6727ea7sm21046845ad.61.2025.09.25.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:42:49 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v2 0/3] coresight: replace the void pointer with
 coresight_path pointer
Date: Thu, 25 Sep 2025 18:42:30 +0800
Message-Id: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcc1WgC/3WNTQrDIBSErxLeugaVKrGr3qOEIOZZhSQmmkpL8
 O612Xcz8A3zc0DC6DHBrTkgYvbJh6UCvzRgnF6eSPxYGTjlgirOifXvweG0YhxGvWtihaSss0Z
 JaaG21og1ci4++srOpz3Ez3mQ2c/9v5UZoURRgR1jQvMr3kNK7fbSkwnz3FaBvpTyBQ+WBqu1A
 AAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Carl Worth <carl@os.amperecomputing.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758796966; l=2517;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=LInkO/nx2wI1fZWqmF4NU0yltD/5FgxKoXKOWc2WyZk=;
 b=t8zV3ze/A647mSAN97+cif9kLqWiNiGcMZ/8TUs6JBfTRlHkirnpRy5cC7V51nLpOqxMTFlDu
 unOfp0EOptlAlP0K5Ekf6Mjx1gHy65Ig7OO5GRk+VAl3q+CSkQS5WHp
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: 5NmbAQU0GeDRk8x-UJqS1vLIqH0RY5UO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXxbBUmwjrjKsX
 dQ5f1gSQCT0J8MKecVuwgqCbYoJKwRdN7L6yM7GvkhIIbzGQkYl9agnPjBQV+ZC8iaxVzED4qtg
 MhCbyO07WGiWC83w41lRt7cJaHhztxAVavQ3ap29m+CCOYWwdvxR1TB9eT8Bpw1LfGYckna46l+
 aeG0WqXFy2c4PoiULyGc1tZF3kvkNDkpjW8wE0+nWnIHNQr0ixJrGTZWXhNTyhLlBgV8KFUwXbt
 XuXXIuczVAhLnBZ+Z55ffTu/45ThVqvs6u7dxhArR8sdLHTUX4dXAsGnnVriIyaO0w5Z5fKAVOq
 cJZJ8amc/n7HaCEFxmKh+TltGkzsqhTcj89Cx91gRBDE0HWXjCaGwN4C+kRbr4bZAufG68MghOe
 wkrOBl4I
X-Proofpoint-ORIG-GUID: 5NmbAQU0GeDRk8x-UJqS1vLIqH0RY5UO
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d51cab cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vzhER2c_AAAA:8 a=i-0O458ng5iwxdbG68kA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Patch 1:
Fix the issue that the catu cannot correctly read the handle of the AUX
event which is caused by the commit[1].

[1] 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")

Exeception call trace:
     tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
     catu_enable_hw+0xbc/0x3d0 [coresight_catu]
     catu_enable+0x70/0xe0 [coresight_catu]
     coresight_enable_path+0xb0/0x258 [coresight]

Patch 2 - 3:
Change the sink_enable and help_enable/disable to accept coresight_path.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Changes in v2:
- Fix error comment in coresight_path
- Collect tags
- Link to RFC: https://lore.kernel.org/r/20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com

Versions have submitted by Carl Worth:
V2 - https://lore.kernel.org/all/20250919174932.3490404-1-carl@os.amperecomputing.com/
V1 - https://lore.kernel.org/all/20250916224441.3008824-1-carl@os.amperecomputing.com/

---
Carl Worth (1):
      coresight: tmc: add the handle of the event to the path

Jie Gan (2):
      coresight: change helper_ops to accept coresight_path
      coresight: change the sink_ops to accept coresight_path

 drivers/hwtracing/coresight/coresight-catu.c      | 10 ++++----
 drivers/hwtracing/coresight/coresight-core.c      | 30 +++++++++++++----------
 drivers/hwtracing/coresight/coresight-ctcu-core.c |  9 +++----
 drivers/hwtracing/coresight/coresight-cti-core.c  |  5 ++--
 drivers/hwtracing/coresight/coresight-cti.h       |  5 ++--
 drivers/hwtracing/coresight/coresight-dummy.c     |  2 +-
 drivers/hwtracing/coresight/coresight-etb10.c     |  8 +++---
 drivers/hwtracing/coresight/coresight-etm-perf.c  |  3 ++-
 drivers/hwtracing/coresight/coresight-priv.h      |  3 +--
 drivers/hwtracing/coresight/coresight-sysfs.c     |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c   | 10 +++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c   | 15 +++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h       |  3 ++-
 drivers/hwtracing/coresight/coresight-tpiu.c      |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c      |  4 +--
 drivers/hwtracing/coresight/ultrasoc-smb.c        |  9 ++++---
 include/linux/coresight.h                         | 17 +++++++------
 17 files changed, 75 insertions(+), 62 deletions(-)
---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250922-fix_helper_data-f56018fc966f

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


