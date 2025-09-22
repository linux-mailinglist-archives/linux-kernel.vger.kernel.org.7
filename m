Return-Path: <linux-kernel+bounces-826770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1469B8F4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872F5189C3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120252F5498;
	Mon, 22 Sep 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAwpi30k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CA274B2B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526328; cv=none; b=UOdX9O+mhLxjgIh8SW6U5Hz0hSpOLw/94NZqFs//oE7sCROipRVXg2lOcYWPFA+Q2RzntcaWqoCIXgri/yCl0m33RWHDhgIiZWckvKrqcoxe8h39IPiG+lIXdl1uGgkPmtGv/udJB2vr3WKMDo5BajmNZ2Ff9URVFLwNWTShqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526328; c=relaxed/simple;
	bh=YrT9/6cOaNebvdLrOWVAkYW+o5XEoVq2kg/YXaHHI/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XH1RtqOAGE0Zchbxesurk3XleBcC266Lq16MSbevxsI2QYi9LHlGrgz7rxZukgc4OVPQ7+djDfp/XGCrZUPeFB93N4HVVRCUzUebe9kT6aeVeXv0LL/Qn2Q37ybhUdTB/C53tyu6d2Wle8F/C14TD39oakhr1oxeBJRi9oYsri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GAwpi30k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LNQ8fp023579
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OWi7tLFsC3oHaAFTRIeTnd
	u8yLUafh5CrbBfm6ky0VI=; b=GAwpi30kFHiiuARFWDw1oBImLiZqpXVP8ZzmTS
	m9p2cN7VEFvmQi+jHQhhNgI5oB+9deNPAMrLRtudClo24Fff+dkjeI0nX3X+vBTZ
	MvfVkH/JwTNV6PYRyDfGF0eKjhyOC9jIE5jtzF7GeOkE9ypvQ581bq2GKHtY8fr9
	dq4ARzvoGKxXcIa1ME8GyhU9Ha25W8T9VpY2M7vrqXhVLHNL97+FAXenwE9rNWe8
	EqhWuLOEUh4MWnWRoznj1eyJU8UQq/SX0pR1eO/uwfVQmGMvhrTJkhqBzVRcmito
	9uv4dCryadcD0h9GGJ9wLTbYcwMEWNUhq8o+aWt5pjPWIAtA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kkhktc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697c4e7354so40715745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526324; x=1759131124;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWi7tLFsC3oHaAFTRIeTndu8yLUafh5CrbBfm6ky0VI=;
        b=OLOmUoJ12GYT5NQ/ZXCwv4ojcK6wioCo+v8JLXMu3Oq54J/dtz7w3AwG+3zCOzx09F
         9RnmEZVjadUH8lFZDH3PT/ObR+hI12wogKzU83JK4m04cJoNSs0uXeFSvLEzZwXmFnOM
         5wY15DavRtudOoqZlpZVdnYHKD/xp0PCRlL74wE84RyLdyOlme9wp6QfL632oOLF7pUX
         n/vv9Q6NHa4jUjnbxEkccr3REhPV61mucIjeXrudpoNmWBa1d3DpvezZaJ3Jzhj06kfQ
         /6kzKrEzDO7xQtYgxsapJFJNf75DzdmSDnU8k/FU33qZB9vE0A8cANVt8U+omxdHWJaQ
         aJPA==
X-Forwarded-Encrypted: i=1; AJvYcCXXuRPvhzcA2/AddJyRLgrSfuMsVohu1/S9Q+Zs1ZTxqldWInYymIYzyH1DHHMuJ0zz95eFfIMK0zJxe60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDBg8v/INOmTertcB5Y2umwdjSa7j/An1vGq4QJ/d+m7LCmcI
	w+DKHY09njPTSx0h+6dZPlInKarA2g//stZQgw9OaAxo5jjUE9xaO1IrP81byg8lStedvFTE6Ez
	3aEKA1lKGn7GKlsGNceh3gCizIZZLb1vCPbOnoYWG/GLE4Ae6dXnon9718FKfYuTISZ0=
X-Gm-Gg: ASbGnct/Nwi2GuibybEogiCZEon65fMLXapHm/0aiz2OwpXzv5bsKkb/ma8JPau4qbH
	B00gd8dTqi+PdVu2Eyo8L3m2y/dN0NgmBhZR8KlPaMSo9fBsk3BFRxYM4+snpFL6hPGiXRCRvqt
	YH36p4chOHV2zDWnjPENT5XGiPnZk4gAR4KHYkw2AAB+w/iXbxEz3dw/lwClIAIol72a/xL9J/F
	gj/Diy7oms9ieFXPV0GKjjIprd6m0No1cYMG5PppHIGpCScj5a3XW8XDPLViwE+lJazOZUOsLS0
	EMLOwXj/ByuW4yUzOZ/L3ckZ8pvRfIwFGLevYDecL2XutHD4Yt6S00FmeEM9fY0AM2AeW4+KUQ5
	+FxcVqG+dv242BwP0lAmF5Dv3Jss=
X-Received: by 2002:a17:902:f68e:b0:262:f975:fcba with SMTP id d9443c01a7336-269b7952ec0mr154757905ad.9.1758526323484;
        Mon, 22 Sep 2025 00:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMjZkCKxOtZY/ljG3yp4aaA9ZSaDbW1wn7Y3F081kioXdQoygdRhRGBnvJWT+ILCt2MI6gTw==
X-Received: by 2002:a17:902:f68e:b0:262:f975:fcba with SMTP id d9443c01a7336-269b7952ec0mr154757605ad.9.1758526322703;
        Mon, 22 Sep 2025 00:32:02 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800529cdsm123806865ad.22.2025.09.22.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:32:02 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH RFC 0/3] coresight: replace the void pointer with
 coresight_path pointer
Date: Mon, 22 Sep 2025 15:31:38 +0800
Message-Id: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFv70GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3bTMiviM1JyC1KL4lMSSRN00UzMDQ4u0ZEszszQloK6ColSgErC
 J0UpBbs5KsbW1ACGAKQxmAAAA
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758526318; l=2227;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=YrT9/6cOaNebvdLrOWVAkYW+o5XEoVq2kg/YXaHHI/U=;
 b=zLvwT4JNV1lIAn120SkbsdBOV6Lx7oJRcAmeJQk1x0htNRlJon6mYHSDodNKMnLhhde7pD1qV
 ce4pfeJTocHD1EHELMcRKuUrAf76kdB+Dmk+4ryq/tazgAn8PSVqCw9
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: qiwzddLAdCecnHrMTmiGB03IGY65EtJl
X-Proofpoint-GUID: qiwzddLAdCecnHrMTmiGB03IGY65EtJl
X-Authority-Analysis: v=2.4 cv=JMo7s9Kb c=1 sm=1 tr=0 ts=68d0fb75 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=i-0O458ng5iwxdbG68kA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX5wEmOo7oQyAN
 OZ2dFHleetVd0uCgeY4ZSdf0AyUoIeFEv3Qy4bDey/LdxkSWw51KqApz33ZmrO+9EUC5ZCoMFvE
 IZCtlxBtDbTA/NEqNazTfxNxSD6XKNSTC8kvQWaiPorcOrJIQuXFqCic+VNcqGtCNE1/lZzfcRk
 ZNeox81PRsyQyLezJmghqWBA4C8rWRFWEVd+nHVSvh/ktEY32JwBrGp6wYC5DSV6pNag1jv558X
 IR2iSZeo502EjyYmlwy4u/GLPv0o3nwnN2cdLEliCNYBMgR4eMvvXjxSOcfMDw2stNW5ulkkpI6
 EaB4SmvNAcsWScCGn2+FNG5/S7kllxTU12kRYQnfsEE9CzVPURj7UwvY3T2eixQ14QEsV1ypSmO
 C2Q5eTbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022

Hi Carl Worth,

I just created a patch series as an example to fix the reported issues.
Please feel free to check it and let me know if you have any queries.

I think it's better to explain my ideas with codes, so I directly created the
patch series for sharing my solution. Please let me know if it's offend you.

Thanks,

Patch 1:
Fix the issue that the catu cannot correctly read the handle of the AUX
event which is caused by the commit[1].

[1] 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")

Patch 2 - 3:
Change the sink_enable and help_enable/disable to accept coresight_path.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
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


