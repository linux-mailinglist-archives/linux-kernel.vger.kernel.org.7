Return-Path: <linux-kernel+bounces-764365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26805B2221A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E0B56366A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB742E763C;
	Tue, 12 Aug 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cYazT4E0"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFE2E62B8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988533; cv=none; b=q9MTTjHmJ4mG54KZbLFOjgi3ImwUitB5BbRnGXGjZFPdUlWMo/D2+nAByHzAusbHz4VGx1WFCpMCg2DZcSpd74hQmMQ5FL4OmsZcrcuQiwC+Hn4y5oE3eRm3mUJbqfMVkaM0Ysn2Z/bZNFCQ+xtdRFYBbl5hS/X9SPEnj1c+F0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988533; c=relaxed/simple;
	bh=aFBF5dW26m6Z+lOf9QzPL7466+Foa5N95p4seNu5zUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mH5HvoQlYyOfZs6VUFCuZG55Oo3++BNUSi0I2aZ+esFg34lfSZh6x4HOSIfDrUmKGH27hzSVi6DwYmaWrBBzrkyxs+VjcAEbQ7CkUQf4rVnl2lR79AmFkuWYihV6T1VLnwzgyMLH8y/XBX6nWkkt63HgEf/Ef052g0N6etpyFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cYazT4E0; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso9508565a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754988530; x=1755593330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0CFpq1HCuyeYFLbDR8k9bWBZ4oNvj1i296rXTBH/70=;
        b=cYazT4E0MMtqGBX9s2zmIqO4LOH0HheT/sseXh61GRUfUAkg2Lv3E++8t3vqWpIxfb
         Ku7FPCSh/4S7MsTXFqiVvlh2c9cNy39fDHjLD/6AX4MrvPU6KV7WQcsNl7dbgZwPalvN
         oPJ25Je98xpZ35PsTYvxugW0OQ7DyObwXgtU9Aapuu61/rfv1Hf1aG6bGEMjoE/sUnP3
         Z6/MqCh7UFQWVoZQkSpzLWCZFQAMYoFa9qYzU8CpKBGf2n22/wrThWduWnD427yDZLMF
         JW5kkgKkU2txC8kwvFFlRDgdmv5vYhFA8MrHlUg8Kd9vHb4qfX2Oo8iGrMzYmOXvqMg2
         dNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988530; x=1755593330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0CFpq1HCuyeYFLbDR8k9bWBZ4oNvj1i296rXTBH/70=;
        b=JRorOgRlYKCKnWVUNYn5VghQdWNHBIVo57tjTPWf/NXFPSdEIrlQkKUNUN9D9Bmm8Q
         YgHo95DnyeYTVc2tIcqtSarZ3b35UhFs1/m9UxGg5Ca/xw3XCjOKj4jNX1gXCFrXwXe1
         5JmS5kpOxseetNUSLQ8H8nnmPTikEay68UiFufDZpGvC+HB6fTRmrwIC0vq+MzwnbbUZ
         4rD2nTLAx31SB0j6NHiNbmtZUNJqzmckKKH/HylIJC+2+i3aZPoZq1fr/XxxVc+FIwTr
         7gR76DQbOAo0nfVR0IYQrFwFyf16XpjoTPE98K5EHZpmxvqsGUE0UsK3jD5yO2I7z+D0
         2jdA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUj+MsUn7/6e6FnrVw92TdleithlbcT4c0nGFm2Lq6PTL9Xh2a8wpx+ypTMJW1hpgRbrt8ckFeGt7IKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksrzQZNq6q5Xlx3qRdXiXiC1i3xQkxjJi3F6aUvGbHf+iZZZ2
	SklTkUTSqjv2H2s0uzzmA7UjtWLxTYZJPhHTceUtUDmTfD+/mYoc5fXGRX1clxtHvCg=
X-Gm-Gg: ASbGncuehE0X3mDWOodx4etQEr6XVMpUItltwOnb+yvWTlOd+oMWQOXpDvINDXfJSD6
	QAbPcQ7FrYZmB0BOBKwatRAdTkK7Mb3+sA3fLALt7EYNk26csLIn4s91/mFCyCNt+UzLsVLTUO4
	lfuMamOnloz4S6FqWgEle1rNB1R6ci3rGm+Nj9mjwdtH56oa8mSmRoescOCOpt93NmNR9nqtFXz
	DI97ChVkAM5u4yKf8ay3azD/f+fRIemmguzHpfuZ7wEO3anw8hKkTXrd5uuhkbL+5m6987NDiGQ
	YjwXTKp+EA5kFzRtSiu0idVZnkh/M+dRK/DAI6kXu2pLUFySs7i+EzZAl1NzA1DF7CL5+/pLQxv
	2M7KyuUEFntjavDDFqNiXP0DUCiOdITBQRHVfiAzfKTKmrBXxoHRnw5xQH6oB+lruuw==
X-Google-Smtp-Source: AGHT+IHtFs8w0fVJyzS1M1cginNB7x2BJdFDZRxDj5MXgzQYeyqcq0scZCRhd7hs7865IgJzSU8QUg==
X-Received: by 2002:a05:6402:3111:b0:614:fead:3d56 with SMTP id 4fb4d7f45d1cf-617e2e8fc4amr8958140a12.32.1754988530010;
        Tue, 12 Aug 2025 01:48:50 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-617df37d061sm7754871a12.40.2025.08.12.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:48:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC warning
Date: Tue, 12 Aug 2025 10:50:37 +0200
Message-ID: <20250812085037.13517-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devicetree compiler is complaining as follows:

arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
/home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)

Add the optional node that fix this to the DT binding.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 812ef5957cfc..7d8ba920b652 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -126,6 +126,15 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2712-pcie
+    then:
+      properties:
+        rp1_nexus:
+          $ref: /schemas/misc/pci1de4,1.yaml
   - if:
       properties:
         compatible:
-- 
2.35.3


