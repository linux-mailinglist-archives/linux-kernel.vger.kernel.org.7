Return-Path: <linux-kernel+bounces-856107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09DCBE3185
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0644D189BBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F931AF33;
	Thu, 16 Oct 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="oN19KI8J"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C330F930
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614540; cv=none; b=n1u6ZJrAkcN/qwpKNPSTwEVHUUqqQ05tLgIEZxdqq3gaeqzFOWlWc4UYr9+NKL9dby1CeWSQggctFB9lNQpbMR4WUX3MI2WTKsiWGiD5Tx8ixjQjZ5vA93xWGarqmHRQV9iWRyIQZ48xgy5O6NXztTJOdlgwE+Bm3JTGlef9LgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614540; c=relaxed/simple;
	bh=G+bK+NmNcPtLIwUNCx9SkAGluVgBws5cyzPja7HMOcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J6oGjBwxLogvomBjT4OQCAq86Tkl5RIn1F5g1KG63dGnfP6a1GBq/8obDVs0HfRfHxLJeXigoH3ANPxpvBNPPa9HHRdiDY//zCB68dM4kchWTgS8GMx5u16WrtP3r5+m5Xg6J70KW5BfvcilyNNVFH/I+d/Cb8sVzC6/B7/TAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=oN19KI8J; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso814278a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760614537; x=1761219337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tp99DLOZe72TdwYEInarWZxhqmTKcbyqOFxQ+068oU=;
        b=oN19KI8Jos1cOea7COuTVT01O0Z5hyZx+nXF+IUPH4EwVvN4uoOcCNHom/TQhFt7XH
         4z/7oortwf+QtKcL82SvcZpJTwg2OanhcTkIlSF5qaB61aidii9bxIhbhPido20sgugJ
         wNKHSX0RBqqWhO1VXezHuooEn5yr9I2gq72dzckXDzsUWOAzmAZZ2IaaJwxXqCuS3kPF
         uTX0cmcaOKQlQ1UngMLgXSEPFMk/lTfZaQChJwCZEZhxwu8pjq9OlItfrNxSMQmZm5eF
         U1YZzZdMrhpzWiK8zHwzhjI3szTodWil9SZpurmsbkli4Cud95UujX510LRUbsRvDIzX
         dDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614537; x=1761219337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tp99DLOZe72TdwYEInarWZxhqmTKcbyqOFxQ+068oU=;
        b=KtqSMJ0veizUuCTJWCN6WYSxL8MDWFPXphROxtiw4swuF9gxuTYlYH24uS3UofFhYF
         0BBX4TsaCkpgZBrcJX1/IHQFW1EnDdXU5E2kY/+KVoX9oc0zviprVOYIdPr2FpH7kwHm
         6q3gW+CiGkzVTkl0jRglGwLoPd6LYXAy3/ZFADZjEBkgG0GKU8RG5Q8TKJ7UohYYUoc6
         cGrxbG+efNor/4ve9odsaYHF5fWi1nV2IEb+csgBR7HjWeQWzPUqcfoGg06luLDrYG1f
         CaLns9wZz0e0jvDh/EFbZIL0T+bhKVNrRCLX9E5vf/VcKzmukSzHixlrepmrqs5YrQwR
         q5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVDCfd9DV5AR/RuhKhQcXSi8TtIhbyyJs4MIdRgOZC6A6KhrTZ6gKvlVhaAUOQ0SrkHqQT9khFPyyjU8cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1aVicflMsQWvcxYbeewO/oCWkffRIr9D5tiu69Dik9lrAlbLf
	6gm7itZsKDKT2UliqOGXgSajoD4z4maaC9Ppr+D3AA8Va/0JwFcd/A+NP2+VnWUB0Og=
X-Gm-Gg: ASbGncvHT5GyeCS0og07uXadgttjnLLjEUf6DT/d2Ythftq/QIbaC/YDVY1/rSZ1fYW
	cvRm7gAZhr06ofRNOAg2j+rsMIwSuRZkDlVo6FFrzk7p5VuxbJWdfPcetM5+SJibbZBjE3Nqx2R
	3lr0G3+nhCL62sScJC7kd06E9rjJEPCIQ9Ppd9xgz0EViFEBfhlvPcqdgaf11N1Mn0sLf28JXmC
	BVWwSXs0e2itUVtVpn/1tIdO+K2PCHsSuLVspY3YjVY7gpxr4cF+NABO7OznyaM2SbagPfVTB9A
	2u6y8aB+4w9tMd6KMIypDddOyYcGIMx9vECpuI6RJVsefvFME+5uEbE8CHpggdtVCOaUWH5kT8N
	oyAIsK8XAst8jOxtvt6r4EITyBjPfK5rZ8b9QMBvBi21jv6amhXhGuzmeMeb/2+qx7IgPDyLaPG
	bz8+WaGNuJiBiq7hQETRDMENKZyH7FF8ovIN5qpvMbRX2DVaep32tyJ9SnPg==
X-Google-Smtp-Source: AGHT+IFHqJk19jC8n1bUeBEPX8FB0MCxgaXfzbN/9GHE1jlBcwkygLKDdpaJB1k2cw46+3+6ZZal9A==
X-Received: by 2002:a05:6402:b28:b0:634:6d87:1d28 with SMTP id 4fb4d7f45d1cf-639d5c74a9fmr21365026a12.35.1760614537149;
        Thu, 16 Oct 2025 04:35:37 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm15849397a12.19.2025.10.16.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:35:36 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v3 0/4] Add support for Dongwoon Anatech DW9800K driver
Date: Thu, 16 Oct 2025 13:35:21 +0200
Message-Id: <20251016-dw9800-driver-v3-0-d7058f72ead4@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnY8GgC/13OQW7DIBAF0KtYrEs0A6YGr3qPKgsHxvUsYqfgk
 laR715MFq28/CPN+/8hEkWmJPrmISJlTrzMJeiXRvhpmD9IcihZKFAGHFoZ7s4CyBA5U5TGIhg
 fWmcIRPm5RRr5u3rv52eO9PlV2PV5/FP7ppoduN3s0Ek7WKsUjR4v2Ge1e5chkfTL9cpr3+TXE
 3ZiZydO6xJ/6uqM1d0xBFCHgRklSK/BaGWpbUd4GweOt2mZ6VTcqpWqf4I7CqoI2mvtfcDQtXg
 Utm37BVD4FtdHAQAA
X-Change-ID: 20250918-dw9800-driver-58105cd495e0
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760614534; l=1951;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=G+bK+NmNcPtLIwUNCx9SkAGluVgBws5cyzPja7HMOcE=;
 b=1JTp+690ThAyDdUVVFFPMkCPf0H7fXL5rOt3Pt2z++9CUEGUGXosAn5jV/8e2znW0G+KI71uS
 /iU5bDh9zG1B3Jghqc+2I6zw0JI0xx8ZIhwWYc+NUU4gRAKyvqKnh7p
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and driver support for the DW9800K VCM driver.

The driver code is added to the preexistent dw9719 driver, which has
similar functions and method order, but different register sets.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v3:
- Added default case to switch statement to avoid patchwork warning.
- Link to v2: https://lore.kernel.org/r/20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com

Changes in v2:
- Reworded commit log on patch 3
- Changed code formatting in driver
- Link to v1: https://lore.kernel.org/r/20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com

---
Griffin Kroah-Hartman (4):
      dt-bindings: media: i2c: dw9719: Document DW9800K
      media: i2c: dw9719: Add DW9800K support
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable CCI pull-up
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam actuator

 .../bindings/media/i2c/dongwoon,dw9719.yaml        |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 11 +++++++++++
 drivers/media/i2c/dw9719.c                         | 22 ++++++++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)
---
base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
change-id: 20250918-dw9800-driver-58105cd495e0
prerequisite-change-id: 20250709-dw9719-8a8822efc1b1:v2
prerequisite-patch-id: 5a1b6083c0f5df1421cfe6952dac44d9ddb7fb07
prerequisite-patch-id: db5f49e91aaf521fa487994765b4107f543531d6
prerequisite-patch-id: 76bfa65d3ff23fc827790b0868bc34655cfa93fe
prerequisite-patch-id: b76d61c90bdbf20f437d2fe438d54e707621e953
prerequisite-patch-id: 46fc09662693e6a51bb89ab4d0914265c74bc3bb
prerequisite-patch-id: 4e0012f76dd03d5653ba185a8ccc59017a1b90d1
prerequisite-patch-id: a618641cd4b7cde40825fa0d4201b6c27e74266d
prerequisite-patch-id: 8b43ff7e81258cc7624800e4bf645458a0f05380

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


