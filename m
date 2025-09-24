Return-Path: <linux-kernel+bounces-830931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEDBB9AEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E383AB9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5973148D7;
	Wed, 24 Sep 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDoQF4iF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB42EC54A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733083; cv=none; b=aiANopc5Cc+ISPq22isFlRC3bbJdxzrKFlKpqVx7b6oUCb6+ZoucqiJTMAAd6/6sD9GPp3uZEp8ke5q1o9IIpri5/XHCsXvVwy5mcAgw8Eap4GPnBxeIF4ZWg/po5Ay0JsTaFKXp2hZpvrANlQp4Yclgqj5wtvxgac/o82EmbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733083; c=relaxed/simple;
	bh=cfSBFwSjwoQmCQsFiqKfw8JSBHbIagNIApfS7uUEC/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rxOtNabx3bFWDzqPA8SYYkPA7z2iPPjWldOTvB+LBJfh9lBO76p0ojC01fHj7wp9QrthCmLCo5NkD26rbB/i3NMVMJL8rWrBu35uGCKptB4pFz2ByQmPijfhjGZVqwxVnY08dR8s/78TukUynZ7Om7DK3rnISDEC/ci6398j7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDoQF4iF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD7PAh019934
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eWtPgG+KOFtNwSmjhrecLj
	9/bPWZBlTGHCrdFRicffE=; b=cDoQF4iFZeID/Lz0bQdFvy2um1Gnfai1XwUJkd
	hWpZIGpXx/Ja37WpG/Nwa+aGZmamXIvylUDwDz3tGYtcSkdl/Gl/89ksFbRsvZv1
	MQw7TsFF8fed3UetknP4QIpCr9TVeWQ9BILZT/yIlApz5aheoFtjyFS1vbboB9Eq
	HbPjtyXy7v8pC0gUpVto2C2rYr12QwcNPWT5jDYbirGSOpKkhOpG74Z9gwVQVSwm
	6Mr/1TNSaUlfyruFgrfyfNYdHKXnoQnD3plr9STC4wSUtLU79SdA+o+VVtbWdJvm
	foZV/j/wbBFTkOS4NW0wgSBu3plpegZqR8CwYrGeNVkX1rLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdxacx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:58:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6ee6so283725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733081; x=1759337881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWtPgG+KOFtNwSmjhrecLj9/bPWZBlTGHCrdFRicffE=;
        b=s3f8cPq/kIENpVilaNi6RP5b00uLg+HSE5JHD43XAgNoVyhRbsHWAFltVXnxh8C6O6
         U9FLCEHJHnW8j9tJ9mPFfpdYIDSwsieQt+lr+KGVy+MTW3bEbF9jODSvHZjkUrFr7CRl
         yTOQlSN1yfCYRaXuZCXdrxp8x7qfwuFQKh3pRNPZwiZiUMHgAD6nk+D212CqpeclGZtP
         FInF0XyvgHZH8/zEXjH2DZ6G1XHvuKuA9sdI39AsKC4REQnGmdW504Fc4nQWp50jZ8zi
         emRT9Fd/HyUp4ow+hoCBgVquHXxNbQYRyNtOmFS/GwgKGTIys6jYl8Dpth8lofx5ODTo
         4wXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKJnxomAI/REzAVVQL5wQyKFi8VqoAcl7oGqRyY5ST8O0iv6C96P7dluENPH5A/vPIn4zhv+7A2hqpSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxheqJjyVy/vEQxEpFRCQY5RY+Fn/Hf/IpjU8XXIdRmqUV/Bcu
	0R54+W6U1j9M4TsZ+sNUeOB2ib9Jcqqe9s9ryQTH/YI8yZ0dNKj7jilI/6sBdbXVilaxJQztEhP
	D2dXns9V6Z/hnxTrgO/01+bXcRrQQPMTOKxDhAIzpHx4Q9DsdUlz8YsqmsXQ7YBFqXrI=
X-Gm-Gg: ASbGncvhla0YPK+WG6QCJdSWyHfY3Ax6BmWahfQnRUG82pEVBnQPowtElNWtc+4grut
	fJki+SEH5vMlpULEGK+avvDsEnxjgf/OybHbefz6jjOdfw2vPV2rc4bA1UMRj3ICbtbzTpGnsN/
	4Ie/T6kndZZ7H3wBdX8S1ZHNTmFL61oU5SUnqPEk97CaXaDuyO3p87p8G7DtaMEO6QX3bYhW2nf
	39CFL3WEKdg/jqtRZa+gH4YAXkMHyK7PXpJdBr7zNFbQ6m9NJsM5BOFF4XYg9iozQTePypjCxrD
	zef18FEazMTLKu4DxM4asNCjCEUpll9BNcV+vAnoVbKjgFDna0LxKxUL6915Jxvi57mB3SYuyl0
	TgJvWmhJo9rvQ5ts5YHR9JLjRDw==
X-Received: by 2002:a17:902:cecb:b0:269:8d85:2249 with SMTP id d9443c01a7336-27ed4a0b73fmr4109565ad.22.1758733080619;
        Wed, 24 Sep 2025 09:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWZp/jrEz0lysruVEq/JdMwVzqihX1dhXJ5tU7EkYr5wM0PX0RonyN+rLKNBO7q8AmofqUVg==
X-Received: by 2002:a17:902:cecb:b0:269:8d85:2249 with SMTP id d9443c01a7336-27ed4a0b73fmr4109275ad.22.1758733080164;
        Wed, 24 Sep 2025 09:58:00 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053078sm197415895ad.10.2025.09.24.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:57:59 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] spmi: spmi-pmic-arb: Add support for PMIC arbiter
 v8 for Glymur
Date: Wed, 24 Sep 2025 22:27:32 +0530
Message-Id: <20250924-glymur-spmi-v8-v2-0-202fc7a66a97@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwi1GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3fScytzSIt3igtxM3TIL3TTDRFPzNBMLSwsjEyWgpoKi1LTMCrC
 B0bG1tQAWC7R6YAAAAA==
X-Change-ID: 20250924-glymur-spmi-v8-f1a57f489824
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758733076; l=1410;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=cfSBFwSjwoQmCQsFiqKfw8JSBHbIagNIApfS7uUEC/A=;
 b=lDwhFqEMR+CJTxvPgKeazeYLPyQAmXFBVgRkdtoanUmV1WyEYLVghRAWVXhsTffXq/EbTz0g+
 pa1dUSuv4TjAdj3QzKbAb8CRtcI5GTgxDd6MjEUetwiwU4aZzV/EgHK
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-ORIG-GUID: -0DpoEtvbfYZMramAT8uauUixzc0Ks5I
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d42319 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=xuEifUzSIGPJdBs7rF8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: -0DpoEtvbfYZMramAT8uauUixzc0Ks5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX5QL7rXZ+stmD
 Q0XawjjpJEfglwrW6yzBDsKc4OWkzuFmSPGCugtXEBUPYWvWooB8B1RrvupahubUTorbMpef8Di
 w9PI/xgVdhwD9kSiCVJL8SBKejc4V4+Hunp/S4Y/7maC0xXjTVpeEGXjjlB+a+szm2vFPJM4UVv
 DftuDfcd7LZhjtHDmL4syYGx3c/8dhaNVoqYz8+M87v+TZ9v1Df3vdp/Se48+uQ6iufYROxEm1n
 IZ4mbJ0FyjiVPl9wPfwooXO5YsCz9a+saerhTT3+Cr4JRY0r943h+lHoenPzKwslsFlMFxtFq80
 X7sf6oHgEdasc/U0NdF5ewz88jgaQ9gYn8d8POBD7OgbRR3QYPqjKVN0HTF0XLb47gj6X0Og4+I
 BHjFjC52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

This patch series updates the SPMI dt-bindings and driver to add
support for PMIC arbiter v8, targeting Qualcomm's next-generation
compute SoC - Glymur.

SPMI PMIC Arbiter version 8 builds upon version 7 with support for
up to four SPMI buses.  To achieve this, the register map was
slightly rearranged.

Device tree changes are not included in this series and will be
posted separately following the official Glymur SoC announcement.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Changes in v2:
- Split into two series: SPMI (this series) and PINCTRL.
- Included the DT bindings in this series, previously posted separately.
- Fixed kernel robot reported issue by including bitfields.h.
- Link to v1: https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com/

---
David Collins (1):
      spmi: spmi-pmic-arb: add support for PMIC arbiter v8

Jishnu Prakash (1):
      dt-bindings: spmi: add bindings for glymur-spmi-pmic-arb (arbiter v8)

 .../bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml   | 158 ++++++++++
 drivers/spmi/spmi-pmic-arb.c                       | 328 +++++++++++++++++++--
 2 files changed, 456 insertions(+), 30 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250924-glymur-spmi-v8-f1a57f489824

Best regards,
-- 
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>


