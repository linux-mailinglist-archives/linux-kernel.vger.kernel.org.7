Return-Path: <linux-kernel+bounces-833937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D091BA35F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF9188C025
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA252F2913;
	Fri, 26 Sep 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="axnrzOSE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FF21D3CA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882898; cv=none; b=s7vwV+2oAOUlR+W03/E3X76FrTHWDkiVj1BMOhW+bbwGCl0W15JPNK798TdTlHPnqs2cvGt1LQdrThotvgJB8VqzR+Q+a7rAVW+1ZaEm1kSzQYZsa6f9aWcq5qRW9GYWnHziThf043ShbCrW7Fa/FA3WzC4xKNWbD22AZCMj2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882898; c=relaxed/simple;
	bh=OWvMQCRp32XJGYw2MjISATImcQCJhL5zooCvLtI0YdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f9yKNQvV4mAJgQbMOMA6ecDELZtxvC2eou2JLgEvKVXFfgvdirh2+QLqAWRQ/CKB7QfwLAFGuwgTDF8RC94MsKF1bp2c+07dFrcHKNySUAXVWxjSZnZC0OSf+ra8QK6H1HE8uLj22+2UGeRgP4CgSPKy5zSlYqpb7UlhA6u7dp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=axnrzOSE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q9jjlZ024040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QfqY6J+qOu9a6yKbsemysP
	toOI3pe2aKtqgqEpcLgbI=; b=axnrzOSE61HZXQTnaFM1HWOoDmRo/H8yb7eCot
	gQmm+U0hfgtCvGTfO2dU1nlISsnKJeiFFxCvixvLvR9BJ352qt81El1usmHxRBFg
	OIcpVh8HG1q7kcM/OkhJcRGgHZ1rFga8uMAiz4mH/6J3pyYkwcNFV4LLHTT0a6fy
	P1ZNd9YDuuR1Gw9bsGxyYafH7bnNx8gnv5hOSKOxixCXFTmDPrRGNqT4okdm0r+l
	fzu1hByWg6QzbGjcxrOQIDAbPYNvKK2vWeWA0PQI1vvovOx1MH8IKgeEFlbyyskX
	1sUB2IigDqNeyxp2qZrABHzIc9k/eXtPIrqaUVCsrM2k5Ppg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49drfwg4xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697410e7f9so45074755ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882895; x=1759487695;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfqY6J+qOu9a6yKbsemysPtoOI3pe2aKtqgqEpcLgbI=;
        b=B5jCzg4WXwfHJb4wEEMfagZ6b6menfjzyKft5DqzBntILnaKeTN0hZBgQwY8Iu/hvi
         2JiU+LpJilbv/7V4NQ1H6tLATEEFYC9n/QoRZPATnGFZc+TECTXTFRU7o7dY9SswLdUa
         x5eTFQdjD2qeTM5wJ0HOen1NyhHLYiZGGdoNzv1MCKakrLpHHTXhRLmrJHcE0MpWmoZv
         4+0ellLlF/B9ZB9DWtVu4KBiqnRF3BAMjA+HuvafIx4PDXGfZJWkc8g8oEjoGrw40Mgy
         txRas8yGxmeFhFvzFaLezf91Vxa722QMoNCQGyxEcpFMPZui1QNrA25hAhs2EUr3lX21
         GUQw==
X-Forwarded-Encrypted: i=1; AJvYcCW5IEsd7nzitRBObneekabWiXbuIyQhFAUp0qoctma33OrGDqXPYXF4FQ/w9kRmwSiWPC7fyR/Giibgdjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1IrHPtgP5EW5lCY4l1o6oCavQsid44jYEAani7C5CEQWrH5H
	cxpb+Bop+ZZEJJSMEqEwXkqreXWwflzzR52jewrqNxykJXvLA6UzO1ea+DuQj/G7nIPs+8z6hBq
	banJlorzs4LiILlpSokvEqUtFlUsd7mFSSSDai+IB5G0+xrXJKG6Xj1FuSCWM9FNpWxXQqTeZos
	Q=
X-Gm-Gg: ASbGncuaFp3akAn6reMWPavo9lrBJ0nOpyeIZV5wI/uOHsscFe1/dVE1BBltofddoJb
	y8K907Z0uqJttwW2NqNKD++NiYNnA77hkTrEoiw65CSItln5fm45MTfoKafb3AOxLzVlXcC27KI
	KwJzyHlO8QYRefVBBFONJwq/iu87WXGfXdb2shWhuntPNy2bYpsTPN3DWFnsRWUkIDjJ121bG0K
	94fjNYfcg4o6sK944IRE/89y+58lheBEnIbwDRHtLRk9aopv8wBSBhj0GeY4FGLMn8T7riQ6NLZ
	y3UAT5jdoF6JRlIleMT2rV7iV3K0e4wDCAJj1fdpjJI=
X-Received: by 2002:a17:902:e806:b0:267:6754:8fd9 with SMTP id d9443c01a7336-27ed4a3cfedmr75024765ad.39.1758882895051;
        Fri, 26 Sep 2025 03:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/u3G9PZR3/QB2V0Qz8ijnNeSE9rxuzoy7V4TGm/s9nLG8GanxC+UotJJjkoA6qHccMD26g==
X-Received: by 2002:a17:902:e806:b0:267:6754:8fd9 with SMTP id d9443c01a7336-27ed4a3cfedmr75024415ad.39.1758882894563;
        Fri, 26 Sep 2025 03:34:54 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm48950175ad.138.2025.09.26.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:34:53 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Subject: [PATCH 0/2] (no cover subject)
Date: Fri, 26 Sep 2025 16:04:48 +0530
Message-Id: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhs1mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3bzS3ETd1NxSXbNUs2Qj86QUizSzNCWg8oKi1LTMCrBR0bG1tQC
 m0lsFWgAAAA==
X-Change-ID: 20250926-numa-emu-6e6c27bd8f6f
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758882891; l=890;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=OWvMQCRp32XJGYw2MjISATImcQCJhL5zooCvLtI0YdY=;
 b=tbaw8DFfFR6DjXHG+FAxfSytsv5cnSea0+z36/o/PZQoluo/QZWhniO73vt1Yl/Ou2FmbuacA
 q4sSBKgvfH4BOXCW2ONM8RjhdtCBs5gnHeGHjtwA5d+5MEgQ1PpH+AK
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-ORIG-GUID: ishBg-GKX4O_qNSQSfWbJCH3WomIwagf
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=68d66c50 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3PCUcf-SIovVhYl1kxwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ishBg-GKX4O_qNSQSfWbJCH3WomIwagf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4OSBTYWx0ZWRfXwXt3IU7+o2j0
 jEfNBN/wQu7pZD19xNkdLrkOyUpsdnWlkyTIp9DdP+ImuXCOjPWWWvjMPqj4Jr4AJ//YOt6Wy5q
 2AivJudj4kNvwDj2Nc/WD564FZmNrLR0h8LC/zadJc2GcJ/v0GgQnvpWfFfgovaMZvVUhteQDSe
 UNFKQ3MbCK/+8c/Kh2LYRIY21teecTQQ+fqK0MQdc1ODHmoLAqldgQU/2C3xpuYC7povNp7Qcas
 a/LRhRixyiJzT33Uj02SQkuSvgEOpk+AFgMW7rz2mieCcl2Bh4z9gLYLZbJhiYARLNhV+G0LiA7
 XmCYHgkN/P89xhSa0cIZl8ZQgeJk6Wa4lM2fXtDFJbUdB8/EfWJSFUr5d+C48EEnnuwkos8GN6f
 kJDJlTAbOvRLAlfB9+uiCbjcCdUy3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260089

mm/numa_emulation: Code refactoring to improve modularity and
readability

This series intends to improve the code readability by using
existing macros instead of hardcoded values for size and improves
the modularity by moving the size calculation for emulated blocks
to a separate function.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
Pratyush Brahma (2):
      mm/numa_emulation: Refactor NUMA emulation size handling to use kernel macros
      mm/numa_emulation: Move the size calculation in split_nodes_interleave() to a separate function

 mm/numa_emulation.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)
---
base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
change-id: 20250926-numa-emu-6e6c27bd8f6f

Best regards,
--  
Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


