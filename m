Return-Path: <linux-kernel+bounces-852446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013DBD9018
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCEB64F60CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D430C61A;
	Tue, 14 Oct 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSJnFxwO"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682730C616
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441181; cv=none; b=MvsB9tPssH2H3r7V72sSKyFjw9JyWRgOPKqyjIVBdbwAfpGP4AsPr7cYU0b5+6/E2rL+VlG9w8QqbKylXKj4HcqnCqTITQl0hJq6dEpDFLk+471Li5PmU3fPaQmol76mdVZTWpC/WN+rAzYd7Hv79N5QCFK5e69q4g/7abKv/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441181; c=relaxed/simple;
	bh=8/E7FaSI5rvegjTI/px7hhRjnssIUlowQQTI/mbFRnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp0ZMJBCE74mJrhDY0iSSjuQU5xP+XEQ6kWApdHMaCSAV4iqmBFeGHAPUnNfWTqJDOxNAFzYL48B70J2zzfZvmqPZt7cv3Fq/3LvJhmMp4sCHr+8B4BcMJS5+JKyU/YV5jI0NeQe/GwS2e9tKCPrPSuEYXb2g/R15ZsFbwQiHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSJnFxwO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42568669606so3812935f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441178; x=1761045978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xApoXVfM1p1GuVFpta8JwNFasmoABdjSNWmH1bTovrs=;
        b=PSJnFxwOqXX/fQ5fmKpU8t6ykGhCLTteNtRwKwrMTLAE4v2A3Yi9GAuBKXOW0/HP1f
         GC9XN/jtZN0jN+wT3q6XuYPVzDOkKzM8o9OtUpSNAxQNEbeaQscCOUXOKp6OpqM9Ln9i
         c+2tSKKPl3lpCSQJExbj++azHTlIM0xDbNo4K+m0eGvFp0BsRldZK1T68hLdH9ZucFI1
         XvW3Nhz9W1tR11/zMOmNc+qKHsIxTshY7o2mc/epeV32bbchXZ2EFy0UFuxY0c28YtTG
         iwzw05/Jx13SHFvc0KCsoiYMIAxyYi43KfG+GJV80Cf+hxQjSI+VzqO/kLumghvrCe6m
         HbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441178; x=1761045978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xApoXVfM1p1GuVFpta8JwNFasmoABdjSNWmH1bTovrs=;
        b=R5vP9GFmVKyIPhsWA9tsqc5S4RKe4RHMmrz7JS1WZ88AzeWajZCimKnoQd6bNwNUZc
         yT0x40wTYBkxABrkZevCHC4xvG5hgqumonEkUTds+2SFXlpmNlB+yeu+4hkIFQxKBZMN
         HUhcK5M5f9zlO/HnPa8fgKugpDu5jH1PFabaetCSlwt0VHYiHLaXTF8WwQiposBor8VC
         /k8r91rKYRTg+runFV3TgvZfaa2uUeywNE2FBiUQ3/InOrrszqqjxfl3hh4Zb/EdELA0
         g7mp+nKthzvDE4uoIOif6KFusRxb267M8Lbm0USXH+jGlJr8Qj2LavW/goMFuGp9T1Hu
         BONg==
X-Forwarded-Encrypted: i=1; AJvYcCWoQHXd49sXsP31roC2zPa3CPRUH1p4q9GPMQgbFNUbF/39oKwOE6r34BklizMZa6nY+VrNziCQutJb/O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2D1Ysb9tpAmp4jCrzAACrZIh41jHjxkmfjvtiM+Bjvi1ARci
	lA7IcdYrad7IOLOBsCC7RsMarV4KU4gYHv6iH41AfVUKGsB1FO6N5DYN
X-Gm-Gg: ASbGncs++R0ExnjFtUgOp8Qk8cRxcYfsqGpDO47D2/ips2E78nRwwucU6RYzYUjgMYD
	YD+MnpAHIbR2R89/fowgvpdn7Rt2DCxCuCgdKpM0hI2EW6bdlWVr7Ia/s+d4mWTfRkzy0S7hszF
	p0bKbiXpjRtHRkUDFwshQnFyW74SGiuPWU6fh8eKea/qDjAFFWy2yp706Zb/hGeRZSFq4riF47s
	th4+J4TIYU8bwC5LjEWBjn6AFZK4mwyP9fStC1ZbTkmnjtYa3LMkqquVKR2FeOFupgm29KxkDC4
	BTXpMsmRbP1E80eFT50oWQt+b2gQlrHYLRKKsxWkgJHHNunlYhtffccFOdlOWBNRzUQpl8LKyDe
	zxWnh4owgLFO1SJusOUnFVhGYfJWEjDVBky4rR9YebU/fsO3iqJlz9DwWpg==
X-Google-Smtp-Source: AGHT+IFWfNp+34zVC9dyzLTduZDnm2B91QRnGbKyuERKSKeyuloo/OgmgzHaIpkTTHvWA+zGZeVCaQ==
X-Received: by 2002:a05:6000:4027:b0:426:eed2:728e with SMTP id ffacd0b85a97d-426eed272a1mr1517873f8f.29.1760441177966;
        Tue, 14 Oct 2025 04:26:17 -0700 (PDT)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265829845e9.0.2025.10.14.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:17 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com
Subject: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add optional regulator supplies
Date: Tue, 14 Oct 2025 12:25:48 +0100
Message-ID: <20251014112553.398845-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112553.398845-1-ivitro@gmail.com>
References: <20251014112553.398845-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Add optional regulator supply properties for PCIe endpoints on TI SoCs.
Some boards provide dedicated regulators for PCIe devices, such as
1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
(for high-power devices). These supplies are now described as optional
properties to allow the driver to control endpoint power where supported.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index c704099f134b..a20b03406448 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -110,6 +110,18 @@ properties:
       interrupts:
         maxItems: 1
 
+  vpcie1v5-supply:
+    description: 1.5V regulator used to power PCIe interfaces,
+                 typically present on miniPCIe slots.
+
+  vpcie3v3-supply:
+    description: 3.3V regulator used to power PCIe interfaces
+                 or endpoint connectors such as M.2 or miniPCIe.
+
+  vpcie12v-supply:
+    description: 12V regulator used to power PCIe slots that
+                 require higher-voltage devices (e.g. full-size cards).
+
 allOf:
   - $ref: cdns-pcie-host.yaml#
   - if:
@@ -202,5 +214,7 @@ examples:
             ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
                      <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
             dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+            vpcie3v3-supply = <&pcie_3v3>;
+            vpcie12v-supply = <&pcie_12v>;
         };
     };
-- 
2.51.0


