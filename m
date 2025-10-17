Return-Path: <linux-kernel+bounces-858653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C2BEB5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46BD24E6DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09C31197C;
	Fri, 17 Oct 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rmnKi+FM"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427233F8C0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728069; cv=none; b=gcfuuPtag4dUzQ2ssNFoPwNpkt6slxQXOZP3MVfA3zUbsUGSugpZ0k5/leQ1amRzlBNpwu7gJeiggRyrSULxpjDLYV7y9ibi1RhZp2BVy6jIfPBixvgguBlKOalBR2zePO6kIOyYnHXVl9MRI8GB/G7/lRJQBwxWCpDRbSGC130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728069; c=relaxed/simple;
	bh=LqFmCYRDrPtkcUDZw5zwYA2weRZUj13NHO7zeAuhORY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KINClJn5DPrOhFaiJgDHrjMpEA5JJQa5obq/NUMNT6imyMfC8ZBiNXCtBRpRnBlEc5RvwVjk2McfQAPjdT2qswrlj5M3SSgDwH6ggS3AwwkHra7rwGFvTvs1Qc5FYGfLGWoZ4plMxgkFCarLWoozHwC45O7NcYTNalJa3Bd6A34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rmnKi+FM; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-917be46c59bso223028639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760728065; x=1761332865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AlkAll+OG6DFncv4Mizto8zaWsmmVbaRHf+nrpHgq8=;
        b=rmnKi+FMoDIGzf3rcVRrvUav6f6ihKSQpWXBo54c+7YZ9/CiqHPxxMa1Hjx5QG2Pvf
         AC6OBOn+DfLAdBc8wgFkqGFBwJa3F6TRBx+7jsvBvNFWin19/iZha9l8D4RMjg9ZqURC
         9Kpry/105Z/qOqerC++6SNg9S8Ss3TcrJjmbJPiJnpOWcys7yF9f8nIBP2tQT5i626+6
         nDJo01Rm+QpldHdjpRBmzAOSCa5iXZZs2vkba9PPDvNIJDWYQPXVVB86LWrk0XOriqmr
         a7CbGQj09GZffCZ8qcV86DZcLvqV5/yVujc1GnfsRCiknOhDemrBV8jmpqSGefCeTjUx
         bBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728065; x=1761332865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AlkAll+OG6DFncv4Mizto8zaWsmmVbaRHf+nrpHgq8=;
        b=K3vcN6OBRtbnBchdX5NdnXJeUlbWVD/P7s0MYm5PBbInKic6Qh59BHIjpG99xRlc+O
         +Qym3lxwq+5MYyK3VcXEZyEzPv6S9s0el+FHZxHFjrYhTFBEw/M+bDODyF4O/4W4iEAM
         4WD6OgKzCH+M5cDmjeVVIdjXXK+KLnlJ4uDRxJ1pOczhjl0SuKmdqdOkFB9O9Skr5U/r
         NsNwVenckA+uzjBXlveBODGpaHSRe3RHI7XeENuGFqG9Jwc/23B5xyjML98r2dJ7CKft
         v5nsDrbm0tPFQyEODgjdigwd5NJ3mYaa1LN8yzn8pfy0J3lx2b8Optx3hjjf/F/Z3Mpp
         dEew==
X-Forwarded-Encrypted: i=1; AJvYcCW39giN8z+ZP3bGvbwVCCF+5yLYe3jVQM4tSfkFfMlMZlZU8wBZz/6yy4eeVuCJBXBBv34ww/IMGUsHMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8u2S0Wx/VbB2tQumn74tC1IpbOtwbtxUlObAR557i44cPtVnr
	rPTP/8MCCBDp6tqU1aNA31ZQt3EqVw3A0mNJGDRFqxyiWLI5UVvTFB7P+u9/ozcE/OQ=
X-Gm-Gg: ASbGncugYo3l2K7HUrjQ3NfSHE9Dar7QlTR9Vg7CkN7j5XJkpeKl3plGCq8cnux8jWj
	F3b305ZiBOGeOPTXETxscfFg9Wd/LXUljr6nVdkQnhev3MLT4nPUpK8X8ScD6zlc8ORX/ZxVITp
	9T3T+jMbwgfT+Hj+3Ey4Y/oDTppg/JOHlvOHJlJLhZHDVjCAMnKGT5TnDcBKlw8vWlzGCU4Rq9g
	tLA8u5nTSF7zFe0TvUr0GdFWjQaODBVVM1ec1WA6gbv7RO30LhG+78ojA0OmnurlqiifIwLG/Qq
	0/+iF3/09ygfGM5TmJxGj2sAZB0bA/Bi14fHCIe4GphkypP2t83q22nn0Bk/0gO0Ktq7KqZlmCo
	bFS6/pADc48gwoE2RGgiN0NezLx1LHNQ7Vn+QhIDseZf9+MDZ56o87mJvbvnGPYj85aiXUBp79Y
	Z5XGjHwdANsHue/EsPHClYwV8ujki28qOOZr3S75zV0UB9WbYpDkI5Gg==
X-Google-Smtp-Source: AGHT+IFcpf2h7+KbWg4DjQlVTU7Ya1aj204MdKeqW83UKVIYqzbU0vSTSCHA4r5eCSfPwXiiSMaLeQ==
X-Received: by 2002:a05:6e02:4510:b0:430:c77c:cc35 with SMTP id e9e14a558f8ab-430c77ccd47mr56314875ab.29.1760728064783;
        Fri, 17 Oct 2025 12:07:44 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768b98sm153462173.46.2025.10.17.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:07:44 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: ziyao@disroot.org,
	aurelien@aurel32.net,
	mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Date: Fri, 17 Oct 2025 14:07:32 -0500
Message-ID: <20251017190740.306780-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a PHY driver and a PCIe driver to support PCIe
on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
one PCIe lane, and the other two ports each have two lanes.  All PCIe
ports operate at 5 GT/second.

The PCIe PHYs must be configured using a value that can only be
determined using the combo PHY, operating in PCIe mode.  To allow
that PHY to be used for USB, the calibration step is performed by
the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

Version 3 of this series incorporates suggestions made during the
review of version 2.  Specific highlights are detailed below.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pcie-v3

Between version 2 and version 3:
  - Reviewed-by from Rob added to the first two patches
  - The "num-viewport" property has been removed
  - The "phy" reset is listed first in the combo PHY binding
  - The PHY now requires a resets property to specify the "phy" reset
  - The PCIe driver no longer requires a "phy" reset
  - The PHY driver now gets and deasserts the reset for all PHYs
  - Error handling and "put" of clocks in the PHY driver has been
    corrected (for clk_bulk_get() rather than clk_bulk_get_all())

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20251013153526.2276556-1-elder@riscstar.com/

Full details of changes made for version 2 are available there.


Alex Elder (7):
  dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: introduce PCIe PHY
  dt-bindings: pci: spacemit: introduce PCIe host controller
  phy: spacemit: introduce PCIe/combo PHY
  PCI: spacemit: introduce SpacemiT PCIe host driver
  riscv: dts: spacemit: add a PCIe regulator
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 147 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  71 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  38 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 146 ++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 311 ++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 670 ++++++++++++++++++
 12 files changed, 1553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
-- 
2.48.1


