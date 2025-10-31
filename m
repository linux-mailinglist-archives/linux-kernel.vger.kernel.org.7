Return-Path: <linux-kernel+bounces-879911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B11C245EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07D0C4E553B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19033710C;
	Fri, 31 Oct 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IOJbVzeU"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659C2D23BC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905436; cv=none; b=iEqSwSXc8JNJZHNou/olj3dmU2rpY7jwqnpGl5zVa1fqqtyteRmUA30loTg5oBnNZ/RUFeOMjdIiHHSsEgb5jtFXiL/H0jBped+Ombxa/mr0XIt13O0a5qgZ7YADfK4EllMzT4AL70UmqohdI+z8lfYXCiirV3+UL2HzecRJlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905436; c=relaxed/simple;
	bh=RbMe08vlLWqNMGEsZHE9UGbw90gmR9WrQSsWUknLDWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK0ZJoY66+YrTJOwdjhc70J9OMlxYo4KlOI7UMcIukSKgqbet4B0OwX1evW37gfPH+4SCjLS8GcF7whwza3DdXITyiKxovx85ny3Y8vOkfp97JPbXVGdllarE6H1iGdIdXSHZH/uftT4AuZ7iOpEPBUjeLNdsqIdJZcWsqIEnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=IOJbVzeU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ceeea4b46so113240a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761905428; x=1762510228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCqSLgxWkeVXekojaut52uxcCHN+33LWNwdmvrJ9Ias=;
        b=IOJbVzeUmAB7TuKv9QtAqoc6fVb7bL/e9tuiB8ewibay0cEamF+4MOmEEK2FAcsuzo
         qgoti8+g8PHV0zBePZpJH7KWCyZBXRl7HCGiXMe1Fx5aOI81lHLCl38PXk6D6pSxrY1M
         S8Z7xZxCAVCXSNIc6PkDRA5lG4gBhhLVLHqElp9Dh+shK+W5buHAXRC8wbpNhfSqQlKg
         xl8FFXm8wu9VxCth0q0WYP8DFagr0a9+V+cR74g1IQUNwVekJbx4RvULMFzdzDxVbPkm
         FzF5RFGdQWaTAUQcbSPukzC+o4TIR4aR1KAha3O2Au+aspZojk+84dDdMamTBal6RtgB
         dEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905428; x=1762510228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCqSLgxWkeVXekojaut52uxcCHN+33LWNwdmvrJ9Ias=;
        b=I+TtYIMX2MXN/oImbxyy5ZECrx5L1FnJnceEeQIX/4FbgznT95awe+KD36QCaB7GKY
         KYbIZtmdxTQv6r7BL2nuuWltPoUZouCtPo0L/eFh5dRa5BGfS6sAwJ2BQyDjNXBtsbpJ
         X0m0rGTD80o7eCrwuYvffnf2iijmFYDpFCe4HF56Ij5tvxmX7cMD7FEgjKWs6xdJ4XIP
         8JGgrORRdEhogqcEy90q5uoB/w7ff/3xJCUVwTmrsquyjuhEgd4HsZT1iPbAzh7VvzdW
         EyCAk6IpDaE6opR6zRqK0pjbz4a2S9UMYiKmKPqS9hyiR54uH3IcDh8VAymDUFyZRPp8
         keRw==
X-Forwarded-Encrypted: i=1; AJvYcCWYiOzS0Lp9qKSfR+mWQD4OuLLY14KvBICnkivpxpJuycflQctIon9wctk6BhJbmsVjdxs3+uilGemy9+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KiD4jBQUbl2tUPnKlX1G5+ytSoIwVNtgMOD5C0JZ7WI+3I7K
	TjQNsOkYgZnd3dkpYzQezDxsY3y9gMnqLhEJZRlw1adHxi7tYVInGzQSlTswtHaZrg==
X-Gm-Gg: ASbGncuul2ev4CpzeRIPGBysVKDSoLuZWoKIeOLtJncjyX64CxnKoyEHaa93UldF1me
	It+GxZCJx1ejRjPpMJxRJG/9H4kZBks85+4hyuAhyrImir/2QBDu9uxfFNlb62PF2p6CWnUgsbl
	xF4Bnk6IFLvG4ze5UdyuB+PZoNW9zZYpE74c6DZUYVcbkVtdgeuElFiDxBEkj5oGZANFhodw2ax
	1MHJ8HAsVuEfM7f6uZkNOEG06aXkTes3PONIIvzwS5CAhwCNwdZhAqntemChacQytNsYjp3D7Zi
	+nyZJV+LqSwLWZJVAnsrbeEiYBwAdqePDyaPFaqk8sTmZWcy50UTk17S2VSztZ+OU1DI/vRC7ou
	ah+KdrvzkFEx4gChpP1lMmLKUNizSRtH8/zLbRrJukb9VHjl5GP/RMrGgUj3Q9B5T8geIc3+89t
	9KpPhrW86tGP6o7ciFYLna47UFWCyoD/HL7BoW
X-Google-Smtp-Source: AGHT+IGBRA0aoJzpM2hpeOsBENB5JR9uquyfQ/tR+Q/1DkGVQwwAaqar76fSPxcZLwaLxPBcSDvpSQ==
X-Received: by 2002:a17:902:ec86:b0:290:8d7b:4041 with SMTP id d9443c01a7336-2951a524b65mr23527095ad.10.1761905428261;
        Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17458545ad.99.2025.10.31.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	adriana <adriana@arista.com>
Subject: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS /chosen properties
Date: Fri, 31 Oct 2025 03:10:08 -0700
Message-ID: <20251031101009.704759-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031101009.704759-1-adriana@arista.com>
References: <20251031084101.701159-1-adriana@arista.com>
 <20251031101009.704759-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: adriana <adriana@arista.com>
---
 .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml

diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml
new file mode 100644
index 000000000000..4d1521c685ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Arista Networks
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory location for SMBIOS entry point 
+
+description: |
+  This property is used in the /chosen node to pass the physical address
+  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
+  tables from firmware to the kernel. This is typically used on non-EFI.
+  
+maintainers:
+  - Adriana Nicolae <adriana@arista.com>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  linux,smbios3-entrypoint:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOSv3 entry point structure.
+
+additionalProperties: true
-- 
2.51.0


