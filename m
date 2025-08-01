Return-Path: <linux-kernel+bounces-753464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E1B18368
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5368C581395
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2F26B2B0;
	Fri,  1 Aug 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRYUGJ0v"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD1267B02;
	Fri,  1 Aug 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057498; cv=none; b=mSpCuvloXi0c4rBo355dZe+COJA84N1zSJHXL4kJQQ2K+vV7DfmFAH7ezNLocKbbyAM2aYnntGS0RcWQUTnCoZ5BuVc/suldiLffn41aAKlQ+GeSx1rZnA6P/520RiDdj+SJE9B+J/pi31Nb/hXFj3pMDFOdXF8bQ91axymns38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057498; c=relaxed/simple;
	bh=S1xP0tOYrOczN1D+dwECc5Spbiv6R6fqligjmc9PML0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsbOpMXD5aFF+18bIu4Ci2w5urnLo7ihC04569m/9vGVQh+Z3d3CgMaibmF1HQY7pwYg0evx3BNG3DG6hwp4Ywvku9H4fub4/Yb7CqU6o/a605b/58D/wkJyFon5efYhiLWP36gKvNv9GNF3zthWKCOjN9iYDYqyd41eK/S2DH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRYUGJ0v; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso163253b3a.1;
        Fri, 01 Aug 2025 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754057496; x=1754662296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDlYysWEDC9bsdNUriekyMCwXLSh3PKSI3dkxy/uoG0=;
        b=QRYUGJ0vuJHBkE8hOM+AIf74merHlZ44RYaFrtyBvRs73Krabpbak4Do10aQaZn/oF
         hB9AA3Lti4P4XMaBaXgGmpB6QlxRapvaOutL3+Zzeop/sdvCi8wOo4TkwoH6/XIgKmo8
         YBdwAQpLrGuyw1mDcRcXyTpHMBkNygN2DqFSU2HB5hSZVvh8weiN5OCwO0cb71yqL7Mq
         aqC5PxkSLwyjggPyOCEYBIjeYAZRKCB5ndhrrelquvf5XkaaUEGmK2YYNGcnFpURq40P
         42NqG7kWxyQOPiHZpVFuewJutrfNRq2aqCBCAMDRgklYITtG+qKrHgPZC5vKOUaetsWK
         dc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057496; x=1754662296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDlYysWEDC9bsdNUriekyMCwXLSh3PKSI3dkxy/uoG0=;
        b=qA0WK5IB+U5m4q3uTz5MdrtweEHdrzGZxb+Qhn7urmsynQhRTN/Yqp5q9jWCRNRMs4
         7HO5YTR7aVmou7OEwzHpwQQEncSP5TLsqZncdJm/W6cK/p9f3vZ4UHrMHR3eLnLn+NFc
         Q5x5l7Vb9OOZFQqXdvymc+sE3h7CZqGst14j95WPqTKZxEKyKMXNKWzgv/Bi2uN8xxVf
         Ej9nQwdzvXXE/QXnDJKvq6thOIa1HLPbZ5aZHcRBzSXDDn+HzcILSmr4Y97CCSmGJGU1
         LsCgwAwHSvvaR9Do8FK1pIRtkP6XbVn1Z1Lzz89Fqmil8FziEiCL3KpwJ5kRgB7bxRNg
         phjg==
X-Forwarded-Encrypted: i=1; AJvYcCVG6MiQnlChxWZT5/8tIqzoH0v9xDwwsRl2ZeqJ0xZSwLshsuJ4lSNbSRbmM+EsVFgpuIHlN0uo/+RhGJx1@vger.kernel.org, AJvYcCW6J6AzFQsg24aXepnLjP5bbIJtApYIDYM3rYyDvnctAYXbfVG1WR6xJv4aEp3s/qFIrYaLQQJL8Qas@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOoscGomtiyM6R5jzHrpQfPk+GVgoBB02pKi//x4vPZzWr+gA
	69TRNaZS9S51f30/STGHWp3FRcTn53N/qsghnjR3YEUv5E85Y0Bd8JDJ
X-Gm-Gg: ASbGncvQbRpdes2zvD05wviBNlHZUU1bxMpmlGltX8QY9aPub3Q62hc/pXmB6e9ZXln
	9Qwf20aPIP2gF7bFBwSmmTgN1eYW53diO7IiZwPUzF1Jv0A+mzGgmR35sN3h4elhSF1bQbZMHMd
	PEsxYRNHtAD3gcoBKFn4h0Q6oJi6+Ns8nZkdfp9I3DsnlwctXMrs1V3mXxdEIOZ4AiR19EELgMn
	OricC3AC1uiea01K2BBkSb6qolOBEV+QhkQhnmhvFSwLVIHkWtKW1L3w4xWH/3xuVsDFSKNKiwA
	xVLviWbxhyu05dZfuDYGhtct7sHeqC+HEW3xDr13jEYORZMw0pf/odHWeOQaGT5sDknkpGhWbZm
	cJixo9kwk5Nwd++oTkLH3cdgBrjUlp9cwqmHo24ABZRLlB75yhlPnmuE5CVu0BSVG3ooAj7lLIu
	3qHIn1aawv
X-Google-Smtp-Source: AGHT+IGgtdwqNeqGthVbBLzr/jwmqUMgf3GK98QWSEdaavZ7/9GNEF8oAglRAXDDwnehneDYPluCUA==
X-Received: by 2002:a05:6a20:6a1b:b0:232:1668:848d with SMTP id adf61e73a8af0-23dc0e445aemr19952336637.27.1754057495754;
        Fri, 01 Aug 2025 07:11:35 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0db0fsm3849984a12.61.2025.08.01.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:11:35 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v10 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Fri,  1 Aug 2025 22:11:29 +0800
Message-ID: <20250801141131.2238599-1-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
v8:
    1. This patch series has significant changes compared to
       previous versions, and quite some time has passed since the last
       submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
       tags are not included in this version.
       If needed, tags can be added again after review of thisnew version.
---
v9:
    1. Reordered the node sequence under i2c5.
    2. Added a description of the platform's intended use to the commit
       messages.
    3. Added 3 GPIO expanders to i2c10 and defined the necessary GPIO
       line names.
---
v10:
    1. Added IRQ support in GPIO expanders under i2c10 to handle edge-triggered
       events.
    2. Reordered the nodes.
---
P.K. Lee (2):
  dt-bindings: arm:aspeed add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1578 +++++++++++++++++
 3 files changed, 1580 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.43.0


