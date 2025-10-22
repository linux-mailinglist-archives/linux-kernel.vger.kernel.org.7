Return-Path: <linux-kernel+bounces-864862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B3BFBB76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8182F3B35D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762C3431E2;
	Wed, 22 Oct 2025 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P6hCIQDH"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C20340277
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133541; cv=none; b=oN/V1I1zDgcprauGWM3390le+OVdIxrqFQRb9QDSLoXE2OWuVEdkL+3KgSP8FM3TiFqKAehr4ML4XyYIMa4SbhPmNIa/RvAaJDkTXqA/XplzAS8pHB6O2ZEgrPgwjNUSD54IznccS51AeSez/+EljiEQB8tvYFI17zntEhJrtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133541; c=relaxed/simple;
	bh=o8ztW3OV5ssU0Xjyw3TSXcTCCaUPkOarilb/1H5e9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi4F8WmC0h3/tMfmJ5wZQgkhOWx3TXWHB7k1W9LgQXpQuQW3OCEdtxToSTl0tachLAsxwpK0XpILiLINbp16M16SIXFSSQXEl7WfqSO9iWLyIDkFiRISVH8opnKYAnc8emmpvL9d/BVwIba1mrlqMur64zmsfyBhriFWsYvazWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=P6hCIQDH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so1141848a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761133538; x=1761738338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49eaRr18+MumRWn+4RP9kE8HR0jk+ps2vEEBUcEesgw=;
        b=P6hCIQDH2BMxXJfeGrTxgSwXUZAm+BCG6INsrTFqTWvuIEHC+2dgBRtO1i4lYqWMYX
         i/CCuuHGrcxHpnuamf4cu7H9L/EXMK0U8PU8bR5r+m2Lj3WxAJVBkD+gRZpbPz/aPLR7
         oq+02V3W4thDnSnoiTVZGbVWSoH06kNsIKhC0FTtiugRdnL0gCde138YRllbM7RD3kT8
         RYabKwL4GD05u1G4xM9+H9ucCnP/C/oLzjgol31q1e8IC3YXG8WhSCCk7LQ2V50uaWKX
         2ypVE1xB++diqAe4zfF4At4RPd2R9BvWpsEM728dwvsg3xr8cjnnI3CuSHhkRJ2Qt3Nk
         GEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133538; x=1761738338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49eaRr18+MumRWn+4RP9kE8HR0jk+ps2vEEBUcEesgw=;
        b=sxNBinDuoci4g7qfyXAlxr2vl9P/9biFLuJMBNIVNnMShY0KZ5fODMK2iOL0x9aivl
         TtdasA1NwbTYY5SNbVWsoW3x0qkZ/nEgWWSI/3Jd9c1+gVj6Nov/A5lEQK6OQmt0SLR5
         tM8a9oZKyBSABChZWrYC1DYcnUtBCkyIN5unGlO58DMTfPzCsjwdpS69JM8MjmCeJm4Z
         5sXdQNLRuH9Y5wUeNhi6V2fXFol923HH4QWHAF8a2oOWN0wNKlbDhW7iJT8PCRjdiVAS
         9g8WU/yY2MCK/VMPJzl6+8L1YPo0mtyIr+thAyVIkc4EvWTpHdV08mErkTXPNl5P8coh
         xGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpAzFyp7JNWw1eAod2AO91FjdDFAAdJzJOx3YOdznQq2MtKv7xBUhBkpE4kJ+o29O7ufG7rD8XoWeS1h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASuNFMIt/CC/nlSXTSHYZmqVlENLhCuorult8CGl0luVSDw1H
	HVJXY58BCDgl3QSHfqTlBCYRr2XX5XUGNskL9KLTZfucZQ+YNFtvPiON91o5vxV6MA==
X-Gm-Gg: ASbGncsORoRwG+1n84d8B8I5PCppHFI+tUs55pqzxyNCFm8NTw0zn6AT3DRwzdtKg+V
	CNbQvLlaVBbHL0+7SiqmkmHsIpfUafgtwvgfJnfEn7CIZB1ONHv5E4m3uRlsOLtgIyifzJuZug4
	5yiSiK55CZzYIUp9byHevESYtVhHvyhwY1CsxTpAskAlp5temBSmSfOOMgk1ByQy4kwnEfZBlK0
	GrmzyLH0SxKuM/0P4TJm7ZkiLzuVlpBFQDLpUGQoczCOU9AEnyt4XCeDDftQmb5avLURLREMCWn
	Xj+x0JOtB+jLt2EG7/rYmI3RKDeAHe4QTn3VGvzxTWQigkLpx4vNawkaCo5DpRlADwP2qDw7Yw7
	rWk2Ua8i6/4gvPzcqS2JlwQfpGiXbCApxPUsIv0LN7t5HN48tnbU9j3ni6QGvMnEaUkNKMAW2yn
	qrR9yAgCAdm7V0vj9StMofvP6rHc8nRTZBHmMivr0nS8o+qwflya9z
X-Google-Smtp-Source: AGHT+IH1F2HDfDJqodJiBmZrV/OCED7jLp8yXC3+HpRSlNzXPItJQMIf8cXLIEta1UaAURCWiFeh8A==
X-Received: by 2002:a17:90b:38c7:b0:32b:a333:d3dc with SMTP id 98e67ed59e1d1-33bcf8fbb2cmr14029661a91.3.1761133538224;
        Wed, 22 Oct 2025 04:45:38 -0700 (PDT)
Received: from adriana-field-alert-pcie.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22416d3csm2399895a91.18.2025.10.22.04.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:45:37 -0700 (PDT)
From: adriana <adriana@arista.com>
To: krzk@kernel.org,
	robh+dt@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com
Cc: linux-arm-kernel@lists.infradread.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	adriana@arista.com
Subject: [PATCH v2 1/2] dt-bindings: firmware: Add binding for SMBIOS /chosen properties
Date: Wed, 22 Oct 2025 04:45:26 -0700
Message-ID: <20251022114527.618908-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114527.618908-1-adriana@arista.com>
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: adriana <adriana@arista.com>
---
 .../bindings/firmware/linux,smbios-table.yaml | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
new file mode 100644
index 000000000000..7e0e767fcb80
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Arista Networks
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/linux,smbios-table.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory location for SMBIOS table 
+
+description: |
+  These properties are used in the /chosen node to pass the physical address
+  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
+  tables from firmware to the kernel. This is typically used on non-EFI
+  platforms like ARM/ARM64.
+  
+maintainers:
+  - Adriana Nicolae <adriana@arista.com>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  linux,smbios-table:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOS (v2) entry point structure.
+
+  linux,smbios3-table:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOSv3 entry point structure.
+      If both this and 'linux,smbios-table' are present, the kernel
+      will attempt to use this SMBIOSv3 table first.
+
+additionalProperties: true
-- 
2.51.0


