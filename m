Return-Path: <linux-kernel+bounces-872919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C485C129DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4810D3BDE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69871917D0;
	Tue, 28 Oct 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBEguiU5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25241E86E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616963; cv=none; b=WKsAHSCjzxK62/gpi/20uRLL551tEC1jS6LGQezktDHLOeDd2EskkJKLo3gAlswdz6EH6b0k93wQce6KN1Nz1dHSTzD3E6dtxm6IzmGKKW9NMp7jn0wIJpxtaiGX8z5zknexymvLN1Cjh9e3KuQywh19F0ZS+aAoKZfzyToCR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616963; c=relaxed/simple;
	bh=vvKVnKH6htpSz7iLRg1sh/CQNlAK7dhkNwyYH3ZNDeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HXAHhjRZnV0y+z29AlMVi84RMorai9TncWQHA3U9ix2v0HfiODzfgljx22MbSspcCS0CpMtC3muA0RzCpUvjGNGTx99YgYmrv25SEsP0uYXKtvfrxoq768KSpByRspkPa6vmO/N9nvtNcVig9UKioDU4L8BHdhkM1nSvp3SGTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBEguiU5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RFLZHd2232076
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LdmklqBZnSUukzci3Q8f9S
	kI2ZUMbamwVnYi1aOm4jw=; b=QBEguiU5sS38RtfWnoMRT6NLYWdHrPbgPx5skc
	1GAG31s00tYEw4AZQrwJ7lKRAFiypG3wsqWo/yd43WXjCMvMgbJEbgvR9wpMNVC0
	sNvY6wccHBRSaA61h9cPSYJ77JFhDubwhYPPIM24jZW22h2PFZZngTKNeuixl2hk
	+AP9Q/OBJaERTXcPT+mTShNnVCSJQ51MhzHEY43YlXMhQXmfWd0xGJC+wvl0Xlct
	vjLMvHb4EgeJdEZf20SMv/MB5idJLobV7wFFnf41BamTsFNpXUrxv9LC7P2OXPQe
	3v1HCFgZUXJc2CyKoW3rA3hFL2AMo78VSPGJkovR40d0xF3g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wnaxrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso138181795ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761616959; x=1762221759;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdmklqBZnSUukzci3Q8f9SkI2ZUMbamwVnYi1aOm4jw=;
        b=PyAVZtJpayH3pOwzAryndMlQxfsAF4YgYJ2fQq1W47po/LaceUFqP4NcDXV4BMYg2w
         w9YIgTdLIHNKY+vPQgI1a25MsEc5BTSp/IPv/Qws2tZVD7q0rDaohEVSeIJNizgNtIZb
         hxlwkSY94rLtaVkToC4CDCWcfby8KgpywCNMd3CLS1dC2cRxK39e99tZGCqA3BD4a9qd
         I+Bs1JxWH77GiY0yjiWOA+bjxpG4njaW7sQOnhjukdtynInWCeq5hj00x8s8c/P9anaP
         5RKaXcE9UIwUPc5s6TIarELz4JGyzotbWd9dWTJYriXisxSGGAoisE8DVcV7uQIK0O6O
         xU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP7aHVb8nRCDJOTKriKx4i3KN3p810AzpuzCJdSDqGZo4dV1LhdoaMWypj7aZ4Q8bwkOR+KPN3DzYm7YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYR/lw6+xUboLdsHV6O0ssjP4MG24m2fdysc/zxhp8k4owqFH
	s1Qjq1B2hNxHpKYkjSsghwp60qDvu8XLhsAcbPqW+X/FI5yg3VUPYzZ16k0efsaqEHtDpH4DgAP
	bmmIUsMdClr61nCu2fjPF9kgm6JJDxWtBTmmFMRLymw4HVyJAHTjilaNSJvaZ40wlZyivR9ssKZ
	Y=
X-Gm-Gg: ASbGncshssdMjjn4I8GymgiQ7JVvAH0Fzyq8t0GgwZe3eYQYqIHTBBaiIIFvJ56SS9P
	o+8d7aBFUwIrBFocgOOo6PUseFXELXe18VO8UKfbIO965dsdvt4Ho2b+CzWtbVO7dN4ZUne6ao3
	wqJA7c6m0Q6ipP3f8wGnG9UAYfCf+pe9SCTgqg6b8jChx0PjPSMZjxowjxkqVt9/eTVHZT/fpY3
	ZDfW1fyspCE8YG+wM3eVFgnhr9NxXAiTnCUNQcbfNqgqaNju9cdimqS9RQUaIQksWranfPPIxMn
	J3l5yNv3Cmd2s5f6arH2aXdGStAFjPqJWV+cbGrM+iAViZr9yCmLrwJ70GUS78XPQg0fvzDhOe9
	z+xqx1ve76yBbpHUjSq48TemdcnpES834tw+nnkzgNGBymBUggp6odY5As9u2cRHr0w==
X-Received: by 2002:a17:903:1106:b0:293:33b:a9b0 with SMTP id d9443c01a7336-294cb507d15mr21025025ad.32.1761616959249;
        Mon, 27 Oct 2025 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQLv7Y6Q7LlJX8G4TmUxuMFLXzPFIc/VsgRRICor2MN0xh3ODz7AC5f3H4KtiKDHj57YvB8w==
X-Received: by 2002:a17:903:1106:b0:293:33b:a9b0 with SMTP id d9443c01a7336-294cb507d15mr21024605ad.32.1761616958762;
        Mon, 27 Oct 2025 19:02:38 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm95861895ad.62.2025.10.27.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 19:02:38 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v4 0/3] add sysfs nodes to configure TPDA's registers
Date: Tue, 28 Oct 2025 10:02:14 +0800
Message-Id: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgkAGkC/x3MSwqAMAwA0atI1ha09VevIiJFk5pNlVRFEO9uc
 fkWMw9EFMYIffaA4MWRt5BQ5RnMqwseFS/JoAtdl4Xu1LwFYn8KTse+uEnQKzLGNmRbsq6EFO6
 CxPc/Hcb3/QDhE7sCZAAAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761616954; l=1755;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=vvKVnKH6htpSz7iLRg1sh/CQNlAK7dhkNwyYH3ZNDeo=;
 b=W3YrNb3jElvv1UmMrfOswBfrlRWpgRigaGB19E3fevLHfe7eAySR8eYSbTKdoRAaj73/ComKp
 rURy7lW8VtwArv6RA8t7fY3lTzuCoMAxMmHHLcFHQ1U/t1gaO+twiWX
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=69002440 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=djTE8_U5qf4PL7r0gQ8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: vcZqQ86DZ4O0NaFUY_H5lVJ4UPsQGifU
X-Proofpoint-ORIG-GUID: vcZqQ86DZ4O0NaFUY_H5lVJ4UPsQGifU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAxNyBTYWx0ZWRfX5vcwp9n+IULf
 qm5WEm1i/4wiBmcR+ivYLBqwfR2OHSVkbti0QMbFyJDpxVMolGXxOD5LinCk7SpwVd+qy363dHf
 YvINMVxqcxZcgcEIlZZ74CRr5ScrJO0uar8Zh8nUdFEqaQfDXuT5rA0Pz5ziWZNR6zlDkAeTeYF
 wLn2SYAC73e7YRqauiF1X/XIuEM9strfDq7wK/H4yv8LBGRUD+gskqeUVMwPKVzJSOcXhb8Qc8P
 62uwrw10w3drPD+QSPYEkNTbWaXBHb1b3y8w7NdVY46lx7vsnz6PAgj6dxAQIhsKQsxFAeZdMOo
 2Sxgmk5DUF22MR1YZVFH8WBGmGXIfAP9BVPVGZdV8nRBBMAylytoNlNycK9/GMGZw83lYoXr3eE
 HkfpmKNfcGNsnQ1ekmR5odBQIYj91A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280017

Patchset 1 introduces configuration of the cross-trigger registers with
appropriate values to enable proper generation of cross-trigger packets.

Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
which determines the frequency of ASYNC packet generation. These packets
assist userspace tools in accurately identifying each valid packet.

Patchset 3 introduces a sysfs node to initiate a flush request for the
specific port, forcing the data to synchronize and be transmitted to the
sink device.

Changes in V4:
1. Document sysfs nodes with correct kernel version and date.
Link to V3 - https://lore.kernel.org/linux-arm-kernel/20250827105545.7140-1-jie.gan@oss.qualcomm.com/

Changes in V3:
1. Optimizing codes according to James's comment.
Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1-jie.gan@oss.qualcomm.com/

Changes in V2:
1. Refactoring the code based on James's comment for optimization.
Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1-jie.gan@oss.qualcomm.com/

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Tao Zhang (3):
      coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
      coresight: tpda: add logic to configure TPDA_SYNCR register
      coresight: tpda: add sysfs node to flush specific port

 .../ABI/testing/sysfs-bus-coresight-devices-tpda   |  50 ++++
 drivers/hwtracing/coresight/coresight-tpda.c       | 278 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h       |  33 ++-
 3 files changed, 360 insertions(+), 1 deletion(-)
---
base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
change-id: 20251028-configure_tpda_reg-f3396f97f9a1

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


