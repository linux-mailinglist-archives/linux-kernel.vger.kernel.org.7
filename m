Return-Path: <linux-kernel+bounces-838812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A417BB032D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B850E1885A09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF72D1308;
	Wed,  1 Oct 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JmWaF0kP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9F2C3247
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318711; cv=none; b=AJfnyG5nq/bMO0T+71mRvqH2wVL3iSuS2GOuD9JFdTQAByAKqnFHmxxr4eh95v+esdGG8ySdH/F1MjxyTt0PM9bkOFZNXux+RDh04sTv5XnHqkW6Juzx64fLCirrATTymOmsDdm8gh3S6p3uWFyByxrR2MF7TgqTRokmffE8ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318711; c=relaxed/simple;
	bh=WoyeNOztcb+Vnk81dBOL+aT2GzfNPFRVc4TyK8sgBVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oQnZSxMKKekUtkFbTqZZSiaERTHPoJ1a6u0gZXnX3qycILp/NQVpkl4mqlw6bfb3rTDk/JRJ38WE9teLbv7dA/4T+AdO7fHSx37F78kULqXUjHXXyX1lNlCsieYTdZsUEV0zvVNQ1Ard9LcF3uZbJOan/pKB97Ch09q74Yw6L9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JmWaF0kP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917Kdte020531
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 11:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TD3Ehl3AFe7cNv5YiBoEzt
	pI0Xi1nVstsVb5Bpudtws=; b=JmWaF0kPY4GoXLLokOsdypffGVMatpgqtXiJTc
	Q9ZCEYu2dFrS7pnFi6yj/+CzYk0x3wmidQOqB9vfKbEWbl+W5l6+y4iZWyMrhk7w
	ArnNdQsHArxVW/S73pdzeziQk0R6dSp6+MszYsV9f9yR0Ej16bCG21ezsMGKDHnZ
	2UFY1XacwN0cDDuXMTDQygxRUTrNgSIfYPJkh67O52U+v3MmORtklVMEiQaY0uHs
	pGKvf8HwdjIYZPP4vgyNcQdCqtv3NLiTNs540dZdIJSOErIcFLdihAFMVZzsfCn1
	c2oY0y9xEA0s74Hhxax/xGLWOqfThLKFr5AAuTh+jqmQHH4g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu18r0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:38:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so6167489a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318707; x=1759923507;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD3Ehl3AFe7cNv5YiBoEztpI0Xi1nVstsVb5Bpudtws=;
        b=KFZJW/lOxFArdKjA2KxuvF7NRWfz5R1JYv5V/r4Dft314eNaj9OnXjn0E/AFeASRvt
         UHMyLuZ0PH0mLfFN5GWFzlnN+CIZ1x91jSMEnareh2qrGfQn1ZeTX4mcK+aNaWex9R1V
         5XjfalAG/fvmlzprn7NZD0oJpWnB5gpJUSDOPEWpXrEUs6ywtib3kgYV1V65TLGbzsy1
         f19ZRfV0xnPfnbsHFw/WY1kzJChy4Sy05x/O/edqPKlfbW6PP7CGoyLDg470O1UOHHJX
         3hUI/Om/F6Z418S81b5EBaXGLAWM5Zce+CbUV8JPPO9dfbCFnRMEgH8v21Y/6XpC1aVt
         W5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD1d3/DpSNmYQC4ll6OtH+gEDm6aGIYnlqvylRL0RQPYpw8v96S1rqKhNtHqLcCc77dsvAj/vsJFGbB7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKFyplPBTTKGZ7EONH+/Q3KSydGbf6hdI9NVGfh66p00KVWMS
	lhPIzck7Pv6y3cJm6LSD6jEfz+lDmW/V7ze4N/0j8DsYcIqgIGW+aZgmfiQAkjWOLEOQrfmQl5g
	wdAe/vAlCY8R+Z0a1I6HWTJmGOnRi8IUJOkykUzoSuVrWTeCZsI2vOHc5dCr1cqw9A9M=
X-Gm-Gg: ASbGncsBRmgGx+Izf0N/3kta37peNDOnYg6G8a7qp7B20N+JNNil6qooaILQcK/m9Xs
	5FNpb0sNIP7YQ7JMfkGiXYzjBpXOu3a1bBKAtsoXtTZhqA+NDOiczuDYiPJfR7eGYGSUc38uRxO
	7kQRkYQ5vqlo7ARn+ktjfH2wh6PdTH3jERg7hf6YGITOLcCSkOy9gdhnznl8JxehfpvENhGG8vi
	k6ohP6WgXC38sR8406GrtQ8aoJD0z2JCBOkVKXxg5iEHSoNn+hEFYsjejNnmIeKJ7lgKpuAWxnM
	gckhdObLci6vseGd/W2gY+Z2oFa0BoO+/1jC2bxjkC0z8wKE/wWVJVNq7r5nT+RPBIyDsF1dx7K
	pVZ/0Ub8=
X-Received: by 2002:a17:90b:3843:b0:332:2773:e7bf with SMTP id 98e67ed59e1d1-339a6f3cd62mr3333625a91.18.1759318706996;
        Wed, 01 Oct 2025 04:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMafiEGimHKc0YfesDgOhniAOMnM4qXUrYhpaT/0+SzzXPVKsLHZShVPI8EJXqlbEe44F44w==
X-Received: by 2002:a17:90b:3843:b0:332:2773:e7bf with SMTP id 98e67ed59e1d1-339a6f3cd62mr3333592a91.18.1759318706537;
        Wed, 01 Oct 2025 04:38:26 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399ce47d7csm1861646a91.10.2025.10.01.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:38:26 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable UFS ICE clock scaling
Date: Wed, 01 Oct 2025 17:08:18 +0530
Message-Id: <20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoS3WgC/x3MwQqDMAwA0F+RnBdoC5HVXxkeuix1wVKlYWMg/
 vuKx3d5B5g0FYNpOKDJV0232uFvA/A71UVQX90QXCDvnEep6VkEP9lQWZDLxisap6J1wchEFO8
 hUh6hF3uTrL+rf8zn+QekTYxpbgAAAA==
X-Change-ID: 20251001-enable-ufs-ice-clock-scaling-9c55598295f6
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68dd12b3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=leelLz0WBGCC_s1OHCUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: tjGtB0vcOwuBNuxd5M1pvQfT6XC_m9o7
X-Proofpoint-GUID: tjGtB0vcOwuBNuxd5M1pvQfT6XC_m9o7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfXxuXrNepjT3yJ
 7XwYCQVMqBHMCcntTsX3xs3m1IHqTPeew32pvhDsDU01KJZQNsHlX3CCBEsLoD4Bz6wDKrUrTTC
 dkdWjdMokzGZ1H2Kq9mvAuNicwawl2CfbYuYDOrRxmXMbpxI43rlG++OgA03I9Jz500g46fz75Q
 A1H3RN3AnXfhSsr6shmMhbDHxaP8EUSx3y2l51Gr9UYjEQRPtA9VMQoEufdx2IeTuicZWyhdEcX
 0H4ZMCRUBOnYj7igxcyds83GP7HV9gcDVu8gGGrLxYmkBWKPlLItsAIjjeZg9uWOTmz84ta4tg8
 9aR3B79TXXung8fak4P8aub4FE5eTLVGDjt6jg/Oo34VxWamCWy0MaHfr1tEHqix8t18j10IAVF
 ZSosJXIyXXH7lkHLR3kjadcOq+T+9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

This API enables dynamic scaling of the ICE (Inline Crypto Engine) clock,
which is tightly integrated with the host controller. It is invoked by the UFS 
host controller driver in response to clock scaling requests, ensuring
coordination between ICE and the host controller.

This API helps prevent degradation in storage read/write KPIs,
maintaining consistent I/O throughput performance.

The implementation has been tested using tiotest to verify that enabling ICE
does not negatively impact host controller I/O performance during
read/write operations.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
Abhinaba Rakshit (2):
      soc: qcom: ice: enable ICE clock scaling API
      ufs: host: scale ICE clock

 drivers/soc/qcom/ice.c      | 25 +++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c | 14 ++++++++++++++
 include/soc/qcom/ice.h      |  1 +
 3 files changed, 40 insertions(+)
---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251001-enable-ufs-ice-clock-scaling-9c55598295f6

Best regards,
-- 
Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>


