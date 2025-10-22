Return-Path: <linux-kernel+bounces-864395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9426BFAB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BE146695C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEAD2F5328;
	Wed, 22 Oct 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZMVnFny"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0742F49FC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119536; cv=none; b=O2hEnmdYO4yoaGLeU9xhcnt4BWQizgZ6uAORZU+ieGRVqFQrjGeN/gggC1RLeuObRVWJXP5xiG76H2FF4eD/o1YVWXK8vOsQgutZ58L4vSie5Uy/Fc9co2BP6kjfZGAhnBxxtDJA1G4Q3NBUtRXJkV1uJk/nZ9f5kPfWjCzXsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119536; c=relaxed/simple;
	bh=J/90TQbFdCgoh5WWkO3h6Le1FNJsf9C3aI6j07Us/Zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u4dd7EA4VjJXwg6+C1bJdJWENCn8feVkwBd11T16BCN8TSdBWtprfnFP2uXcRT0pkOeF7MpHRDhha2GlYcujnKhHkI7BNilM9izC8g+r2KpjdZI3KZoW2XIULpQeGTOWJJbwmtFGprks3AwmhPT90RaY6CPjOvSlChnahlxVYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZMVnFny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3VOYW029822
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DPmvEIE8FlpuHaMWc6yWJW
	SlobjKsCAmEGxrwVOFSo0=; b=KZMVnFnyFxXDany6UgqO8LmgciO10tFG//aHNw
	9AOw68AQgmsfgYjOeObdzI/u6NO96Zr8f2fehgHN0wrlHzRmlbPRjYANaNSu5Hqz
	EWrEn6//gbVeb47fUuB3/+iY7O26Q1noU8tGO5+CTXLYcciDZhpXxkovMhEYaQZA
	VUkzK6zl35gviEsKCrs3iRG+NgsB2gp7inJskrr3WXO3bx2BTYfbE67X2y5Yc/oG
	ZaMwN8A+IyrYDlSR+v7cSty+BVgOy8BOmzLGQHNf/7NtfwHF52LHFhamDad6efft
	2O6QnSV/y6mcqspqvmGS5VEDJ67u3yu9nOkT/OXqOjd1DYGg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge3rnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:52:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso115654995ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119531; x=1761724331;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPmvEIE8FlpuHaMWc6yWJWSlobjKsCAmEGxrwVOFSo0=;
        b=WnmfOwn8lehpKbrcE2hP9qnjSFRFpfb6lsYZAZpo/vPqWSJwk/NKlIFBIz3uW2IeWr
         mu89XRGfAg9Wpq2NG0gUH1SRXWzUVFjct7cUUOou6QREQkwnpO+1Us+5be2ZJhDxSXGk
         OBaL5mxKh0Z7yR7FgpAFFLAcKKQGBwhhO0odul67l4mifZ8VJmTS1LQMO0jYj5n8mti/
         Z5qQFGrxD5hRE2V9rEoEDrGO7SgziaW0DjzXUWwULJpKsGuLatycNIZOOX4vo0G1uugu
         pl6ZYzijjxc6HLqGn0Y7urog2z09YnKJhghXQrgNUsz68F+grYrpUz5KRGjLxW2P3Cgv
         O4tg==
X-Forwarded-Encrypted: i=1; AJvYcCXWyDqNxvfxvnPS+2F9PI7GNJD4ffAiC8+OqF+LK0AvkDtIywFcinPvHaA7bVEODeuGcDQ3GG0tKIEZGH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqC8Tvlo5uIW2P6sgxvlBjXlTbTrDfHdDjeh/1uvWM7P2muCN
	Lp1A+VO/UlZvbgSnscjjV/0v3LgubHGslrlWX6Y3DdooeFV4jfzOGB44vpMLpikqWfrjYbmsC2f
	oOaomeRU4Xmjcl4X81Bl3BR/NCTgQe1nUGTj9AoEFTOQlNzG/3lIMpIP4tfjgjhgpAos=
X-Gm-Gg: ASbGnctKTHtJ3FJmXy3Z9apZTWTBMnSIRafGdRKSczvdOOj6MTLHXBrxAR3IKYFsgJ2
	ujQOQaltxLVIrRSEXHGTQZjk1BDQH1Mrd0LWI785x4HZ3JzHe12i3A4e9vyslxWs0Vf6N7Zxne2
	/bhMSCS5PSQ8WK3xZhBNs9WDexd86YYjxVYS96oUaWDUwsf9ViAqpQFNNjF2yZol/DDB5cOKupK
	av3UZkl80rnlh6vr1U/1s3I3gXV38UftPdOG5GoUd3TCwInDBo18HP/V3OEhCvic7wdyW1eQOxV
	vl09xh1XDtqzKj7g044Fsd64VW1yAMEtOhj0nJxK0Ov89fyHPqvimKp7V0JauUtZx1Q9zOmlDIb
	L//6OHByVLIoboBxu2hwzT01LwRE/gsZjmA==
X-Received: by 2002:a17:902:ec87:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-290cb65c5a6mr230159955ad.45.1761119531235;
        Wed, 22 Oct 2025 00:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4K8gARg09FJVPfkVnVqfI6o1el0oPDHVpa0x9imn1Oorz714MewTKuS4CSpiq726izRzsJg==
X-Received: by 2002:a17:902:ec87:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-290cb65c5a6mr230159685ad.45.1761119530739;
        Wed, 22 Oct 2025 00:52:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm130962275ad.79.2025.10.22.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:52:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Date: Wed, 22 Oct 2025 13:21:59 +0530
Message-Id: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+N+GgC/0WMQQrCMBBFr1JmbUomNS248h5SJGQmNmAbTTQoJ
 Xc3FsTNh/f4vBUSR88JDs0KkbNPPiwV1K4BO5nlwsJTZVBSaZSoBVszn51/iX6PhKSZBiSo91v
 kqrfUaaw8+fQI8b2VM37tLzL8IxmFFK53xnQkmVx3DCm196e52jDPbR0YSykfVCVdpacAAAA=
X-Change-ID: 20251015-ecam_fix-641d1d5ed71d
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761119527; l=1313;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=J/90TQbFdCgoh5WWkO3h6Le1FNJsf9C3aI6j07Us/Zw=;
 b=vo34Dz7sxlIswBIIP74F0bWqldDvPxdaL8dMP3smt5FIhASG9kExka7DTZX35BoMortsAmyQJ
 qf+N0V9qlR+AJOx1rVcvDZOnLGc/MX6KevnRq9tFQu+O8eFHCbfKJzF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX4F0wYe1DhDJA
 ad47lYaIlJliiLvL9Kq+n4LT7oy9XBWxC+lyH+Z3v3Js9nVLXet81w6W7SOHKNg/i7dHm19TqNI
 uHmI8TLzC08fJ/8jaHZnQHIV/IPHJKCAK+hmiqkc3GM+yNlynvKslJo1RHxL//FU++0MyXmXO1j
 +Y2fqN2Nx6huifoXcUb/6Qrpy/CwfGwr/AmxZMy4zTdQhvaR/06q7fu8wWVe4sF8ZLISOyBY4gT
 VWCx+Q90NlvJhleJtg5/U748cmtqx5IEQPIJnYQna+Rxj+PLVyDdsm5xcI0KqriFFB9GjIH/C0F
 cw9yKZ8ZuCB6oTnqqItxTfRjRv/oy10F/VkfjMNsDqxiZpnLUde2UihZdEAWjzRSVRVcQrdNwrq
 cSafm1LFXpt18CIhhvvzpw1asdRu4w==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f88d2c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: EYf-_2E6kuTEeLUusnxnyh0w4vb2iX1X
X-Proofpoint-ORIG-GUID: EYf-_2E6kuTEeLUusnxnyh0w4vb2iX1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

This series addresses issues with ECAM enablement in the DesignWare PCIe
host controller when used with vendor drivers that rely on the DBI base
for internal accesses.

The first patch fixes the ECAM logic by introducing a custom PCI ops
implementation that avoids overwriting the DBI base, ensuring compatibility
with vendor drivers that expect a stable DBI address.

The second patch reverts Qualcomm-specific ECAM preparation logic that
is no longer needed due to the updated design.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- remove bus0 is for root port always(Bjorn)
- Link to v1: https://lore.kernel.org/r/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      PCI: dwc: Fix ECAM enablement when used with vendor drivers
      PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC ECAM enablement"

 drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
 2 files changed, 24 insertions(+), 72 deletions(-)
---
base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
change-id: 20251015-ecam_fix-641d1d5ed71d

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


