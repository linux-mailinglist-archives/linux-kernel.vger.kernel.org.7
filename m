Return-Path: <linux-kernel+bounces-772996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36883B29A44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7871F5E3CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD227935F;
	Mon, 18 Aug 2025 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BiNL5KUr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89D25392A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500171; cv=none; b=mtHQI5jhdUxDK1mGebN2LcDSF+RLkAeRYIWCfvgDXHH4Rodv6QTJoflWLsea5uQkv+y+gKJ6mcmTq3wLVYNE39+L2NU9KcUU1Ysu+luWAIl1TJkxNmSrg8sR2P3qtnRpVdX5767TTMXPAr2KpX29LlJFN51YzW23HAeTdS6Fmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500171; c=relaxed/simple;
	bh=XOmyi+HYU+PbY5LmpbbgTr7t8C098ZGYJ6WBPF2+jjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R0sCN5WUl4I7jsz7A1XEcudVfWNCIfXgp7dgUBId7SVwREdf+YSJBx7wPqKyNrMmNSlMrHzHrceovElBbW6ZBcuR0x3pI+2Nx3SiAYg4pManxGrOHjRYoUBNbpbslkxyCRjM/UwqCqPyMtxDO+A8UysvviU7L0PrE9xeMs6fjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BiNL5KUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0BI3N011948
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WxPU8jx/E0ugmv2MkSniZJ
	rHGnhtr+rttbyBasPDL9A=; b=BiNL5KUrrfdCLAgHH7n9kxYZ80sZ/Zogv3GKRX
	Z35fnrBD6PjvaK1+2jwImLqo+TAkEk3pLNtNv3WV4JTIzbNi6vTdW9L+KoEJxvFB
	1PhBIgRltdNiKqXZATjT5LYDAKPSKgrXONCNnO3LX6AdlDkMrLCDvmIj8N4mOluU
	0oU8gMNpIUUbNkefB41RmcD+b5VJkF2ZlkisULgcSRGtWnnov5IjxOJlIfgTQ10n
	4ipYvPaCNPD+qeBUezK8i2ZAuxtw0vwjo2lxZOETUvXFsQKxaCP1e2jIpN/gYHqm
	UHWJYLM58IufbZVI3bmhdafdl0Bp4pb+CLloc3m+Nl29e18A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99kfsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f54bb2so92519285ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500167; x=1756104967;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxPU8jx/E0ugmv2MkSniZJrHGnhtr+rttbyBasPDL9A=;
        b=ZJIv7mUYCrjAPdUmelKVLoliu26mYwrqOYBlUvLs0K+vr5mP/TXrNHWNt0PdDBRkI/
         Y6qSR9WfOe3QUtVAOpPqrFlI3Vuf7XqAzbe8ok2uLig1746QLvwDQNwiuOeF6QV5R4ZP
         ZO9A9En0GFuQY6YvkTeO3unuyHBSl+F4YXv4DdUfr+jyO+Ma6TEk1LhrFQ5lrTfYzm0q
         g+zPdIoBqSAWliofaQ2KcYhhamRleFGVsHPYer7SpHFlQGFVZzyhSYluAZVd38AnrUxH
         SKp9X7Nsk96EdlwWdR+q7mvZN8GRDrgP2/k4oSrR9YpKUOgskZC9EFaeZdq2Z2Lh7UGK
         jxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnOwMXRDYunvbR13R3r0rMmTcKM8mLNwsPzPS82gqOQOxZJ6GDf/H7F4qEYwIHUjanV+Fu7OY0tzDmuDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyavZSIV66Uc7p3N35cR3sz8sbZbqqI+BjSjrjNEC42AhQf/ZsW
	8Ajx3rO6xYNTtk5KlZV+ub1sT7WcI8OSexqqFyBL9BgHx/+oblbXbb7cowpMcmmoiZZHiu5TcsD
	RZ72eGiCZ8scVMC4wcDr6e/9+8SF6z+cwnd9M6PL8QNOifiLAtbWQAYdtdu32L+ukiAo=
X-Gm-Gg: ASbGncttm77VAjxxQBr5hNDhc6io44cmBT21KB+0MLxUAlaR5d5lhl5e4OzjA4hE0eH
	DX9GkdjT7xgcnIX2H+9xDiAuOQtWCwxVdjOTirKaRYI77/KjkiVraLA7fOe7eSMDHHMmR/0LU5M
	4lgGueJqg+lQw6IwMu0KQnvodowzBOA36R90tx/xGWb62ig80WyLVh+D4Uvskr4i7d6EDoc0GjJ
	RXHO4cEK6VbRGZGEkaumoz9mCX+8elR7FzQWkK8bA9krHbCk96pilFUukrHdx/uhCyNtbgVOFj7
	PjTdQZdvN2QJrNfQ0E8Yru0JBmJre4UIabFVoNYvYYS00S9VYWZKlhNeGxzaqxviRnibH14QTJ0
	=
X-Received: by 2002:a17:902:ce04:b0:234:d292:be7a with SMTP id d9443c01a7336-2446d71ae4cmr187561875ad.1.1755500166902;
        Sun, 17 Aug 2025 23:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/5zSY5ws7t+A3f+gy43WCVEOiGAO+ZvVq9U6cZZhX1cPtu5cRz8y+ICKkzfGxpgl78kwstw==
X-Received: by 2002:a17:902:ce04:b0:234:d292:be7a with SMTP id d9443c01a7336-2446d71ae4cmr187561565ad.1.1755500166450;
        Sun, 17 Aug 2025 23:56:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm70240105ad.75.2025.08.17.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:56:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/5] bus: mhi: host: mhi_phc: Add support for PHC over MHI
Date: Mon, 18 Aug 2025 12:25:45 +0530
Message-Id: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHOomgC/0XM0Q6CIBTG8Vdh5zo2xFDzVZpjAoc8F5IBuZrz3
 WO51eX/277fBgkjYYKebRBxpUT3UKI6MbDTGG7IyZUGKaQSXdXxnKzONKNO72C58yjtpWldayS
 UzxLR0+vrXYejIz6ehc3H+Fd79jPnibQdF14baYxQTVP7c78qGPb9A5W6pQ+hAAAA
X-Change-ID: 20250818-tsc_time_sync-dfe2c967d7b2
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755500162; l=2651;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XOmyi+HYU+PbY5LmpbbgTr7t8C098ZGYJ6WBPF2+jjI=;
 b=JoWS9I/SbN6taF9CRgAUctPTUQ4cYTrqVu0GbCduC+/QAGxRWyWw30G5R/ctnppOLtRPikAio
 a+go/fBPmIqCZYM8fcWCySY9N4/0YJhOCAbXSrW0gUBLljb+ABVSdHd
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: e373-CRnfmsyI4MViJo7DfqsuhJNPCDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX+fDKl3iHY6R7
 lWowFXJMDLGq5/SZvNLm17NDLs5n1qiFbOARNGCQ/7hvAK4IxJzCHF7laD6uceGb/egeMJDI2G6
 e22OLCS/PZ4oTQYdPwM+1oBKcdZ/x8z17qQdY47xYhZWgtTVbOkhQTy15jeA3a/UhW+cr6xRJHN
 DHx0M/wypBpaWhoouhBJwq15VJ/ZDHtXq989iySwDzuAC3Cp6GVKmWCPubrCSvcA3HSvPGJI4Cl
 4kflBTYyHV5vI/fKqouGT1OXxReJyMslASA3IB4q1C9eamNQ9V74J1GC8cthHwFaZSnIcGCH6mG
 5LYF7WVBctR28SKvSgn2ABNUE4D6RZsFPmC6Arqxm+y9g2djgIwjca/ikJcT0/2jqd9MwAG4o9T
 q9CeQGHU
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a2ce87 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ZFGd2MdK1819gLI47OcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: e373-CRnfmsyI4MViJo7DfqsuhJNPCDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

This series introduces the MHI PHC (PTP Hardware Clock) driver, which
registers a PTP (Precision Time Protocol) clock and communicates with
the MHI core to get the device side timestamps. These timestamps are
then exposed to the PTP subsystem, enabling precise time synchronization
between the host and the device.

The device exposes these through MHI time sync capability registers.

The following diagram illustrates the architecture and data flow:

 +-------------+    +--------------------+    +--------------+
 |Userspace App|<-->|Kernel PTP framework|<-->|MHI PHC Driver|
 +-------------+    +--------------------+    +--------------+
                                                     |
                                                     v
 +-------------------------------+         +-----------------+
 | MHI Device (Timestamp source) |<------->| MHI Core Driver |
 +-------------------------------+         +-----------------+

- User space applications use the standard Linux PTP interface.
- The PTP subsystem routes IOCTLs to the MHI PHC driver.
- The MHI PHC driver communicates with the MHI core to fetch timestamps.
- The MHI core interacts with the device to retrieve accurate time data.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Imran Shaik (1):
      bus: mhi: host: mhi_phc: Add support for PHC over MHI

Krishna Chaitanya Chundru (3):
      bus: mhi: host: Add support for 64bit register reads and writes
      bus: mhi: pci_generic: Add support for 64 bit register read & write
      bus: mhi: host: Update the Time sync logic to read 64 bit register value

Vivek Pernamitta (1):
      bus: mhi: host: Add support for non-posted TSC timesync feature

 drivers/bus/mhi/common.h           |   4 +
 drivers/bus/mhi/host/Kconfig       |   8 ++
 drivers/bus/mhi/host/Makefile      |   1 +
 drivers/bus/mhi/host/init.c        |  28 +++++++
 drivers/bus/mhi/host/internal.h    |   9 +++
 drivers/bus/mhi/host/main.c        |  97 ++++++++++++++++++++++++
 drivers/bus/mhi/host/mhi_phc.c     | 150 +++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/mhi_phc.h     |  28 +++++++
 drivers/bus/mhi/host/pci_generic.c |  46 ++++++++++++
 include/linux/mhi.h                |  43 +++++++++++
 10 files changed, 414 insertions(+)
---
base-commit: 76dc04ffefccd3cbd8cfd160d8f3ca2667fd8dcb
change-id: 20250818-tsc_time_sync-dfe2c967d7b2
prerequisite-change-id: 20250818-mhi_cap-3b2bb05663f4:v5
prerequisite-patch-id: c19893c69b10f975a4f675273f4277030a429d2d

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


