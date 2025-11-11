Return-Path: <linux-kernel+bounces-895470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF68C4E07E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D248118976AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A8A324710;
	Tue, 11 Nov 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vioiRNQ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF0328250
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866400; cv=none; b=Z3bv3Z1xVE0Dlcl6vTv7zE2R4IJQ9G1PEG8vkP4bxsBKCiAg8w0Qf3Bm5m+lbXwoUk7aEhw4KkDD/oABud7Si4qgrmbqrDCMLIzJU8x6JZtIIx8cBW+zsuDq6fVz+IWed3Xpgz3oDfs+fsYkuFz3Ice77oi81fICliZGJm18o8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866400; c=relaxed/simple;
	bh=CThgWWPtEqJWZJez06Yg+7QIG9rxsQTAq9Wa52dMb1U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=atj4FHqjfU2zweX3dxuy0VacgFvhzyi+++j63h6mk1adp06UhO4JIF/KwykckZlAn+Ur5zdC+g/KUpGr7CaHdNdKfjc3/lswb37OeorlfFXTYx2CcN5Ea2OhfoqhOxCGmulclIjqWdKELNJ2wEPnNrQTv16qywfs11L+zK1ac8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vioiRNQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2955555f73dso40908725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762866396; x=1763471196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLA1a9NwMSaye0i3Nk+UwWtVJYN2Zgn27uLzKW7b1TM=;
        b=2vioiRNQEvxQ7SWD7+KQOM6KjLEdP51J3M6K6s5Cx/ayU6hLDgQfP504QuOd0ddENr
         XvWINyZpaUeIvVrW3ZWYCrQAssTnT/TXmLaBM4PhYZaZuua8Wv0cjLPS0c28IerYMDnc
         OSuiI6mUZ+4hKqpXT/ULhnj/UaTuTsfH+JMXu9vUvJY/qkv/cDk9oQk5RQ7n295IJxdF
         EB8XaSBk1ssLCI2zAXaMKZmRGWDMch8howANpaYcF4wOQPX/KAgaTCowYuYQ9ltQIbLd
         KmCx8BXsXpAizTcL1tubLTsWVmMbN21DAImqu6B5IEKaQ4jtqxvT4PXqFCjO/EWccU+1
         NzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866396; x=1763471196;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLA1a9NwMSaye0i3Nk+UwWtVJYN2Zgn27uLzKW7b1TM=;
        b=M4LXnsyGid2u8RvxQNPGKJQPcrPczWVv9Hm095BNCH+SoEN55v3eEV+5tysNp4F5nS
         E9kX1sgwanuJjzrcB2tRbiOV25peidKtGo0NyCXRN/iZSjGZUU9yckFlaWGO8PBXOrYo
         aumM86Srx3NqVBYOLsPGwrWJpLW3qPxX+oknCkUclwkzoudiHQJ4/OuuIRYc11vVnXqo
         X+fhcm/fc1n9oOCpNMKjHlgO6qU7O+MEmtFNgPlgxQuiDspaIKRh1GczfLEzF7JMkd3f
         Gv8a5xbqXxaQ0NlItOsYRBtVFV+V0rFEKnrd7oABIBeu78+TFSrWPlM2VzRsP3JbTgrW
         watg==
X-Forwarded-Encrypted: i=1; AJvYcCXAkErGkWjBVujNfZjZZpTX3+FfH5Yda1W7jJac6gbw4TTK7C8zO2h+r7On1uOmjcY9tUZBukHp4feL+uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MA+PGHOwtXSaGOxGEMHR3qowCK91xBGcgna1TNpjG39cUrel
	5jYlK2MjS4MnZ2mdxaGBCnZ6f6szlrOx3jwsj2Qo1w9jXft4zlLCWEiQY7hX9wmZ+QrJgfDw2Gb
	o91cEGg==
X-Google-Smtp-Source: AGHT+IElmoSTCWhrtDQMxFiiHT8qX+5BcFGeEfnNbpvXgiMm/IRBQUBpX9auVk9JMiKJ6y0sU7Gv4vGyA/A=
X-Received: from dlii28.prod.google.com ([2002:a05:7022:419c:b0:119:b185:ea6e])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:283:b0:295:32ea:4cf6
 with SMTP id d9443c01a7336-297e540709cmr156079625ad.5.1762866395690; Tue, 11
 Nov 2025 05:06:35 -0800 (PST)
Date: Tue, 11 Nov 2025 13:06:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111130624.3069704-1-royluo@google.com>
Subject: [PATCH v5 0/2] Add Google Tensor SoC USB controller support
From: Roy Luo <royluo@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, Doug Anderson <dianders@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces USB controller support for the Google Tensor G5
SoC (codename: Laguna), a new generation of Google silicon first
launched with Pixel 10 devices.

The Tensor G5 represents a significant architectural overhaul compared
to previous Tensor generations (e.g., gs101), which were based on Samsung
Exynos IP. Although the G5 still utilizes Synopsys IP for the USB
components, the custom top-level integration introduces a completely new
design for clock, reset scheme, register interfaces and programming
sequence, necessitating new drivers and device tree bindings.

The USB subsystem on Tensor G5 integrates a Synopsys DWC3 USB 3.1
DRD-Single Port controller with hibernation support, and a custom PHY
block comprising Synopsys eUSB2 and USB 3.2/DP combo PHYs. The PHY
support is sent as a separate patch series.

Co-developed-by: Joy Chakraborty <joychakr@google.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Co-developed-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes in v5:
- Use syscon to access host_cfg and usbint_cfg MMIO space per
  discussion in https://lore.kernel.org/linux-phy/89733ddf-8af3-42d0-b6e5-20b7a4ef588c@kernel.org
- Make warn logs in dwc3_google_resume_irq() dev_dbg.
Link to v4: https://lore.kernel.org/linux-usb/20251017233459.2409975-1-royluo@google.com

Changes in v4:
- Separate controller and phy changes into two distinct patch series.
- Rename dwc3 core interrupt as "core".
- Remove u2phy_apb clk/reset (moved to PHY)
- Configure usb2only mode when usb3 phy is not present.
- Adopt pm_ptr PM macros to fix build warnings.
Link to v3: https://lore.kernel.org/linux-usb/20251010201607.1190967-1-royluo@google.com

Changes in v3:
- Align binding file name with the compatible string
- Simplify the compatible property in binding to a single const value.
- Add descriptive comments and use item list in binding.
- Rename binding entries for clarity and brevity.
Link to v2: https://lore.kernel.org/linux-usb/20251008060000.3136021-1-royluo@google.com

Changes in v2:
- Reorder patches to present bindings first.
- Update dt binding compatible strings to be SoC-specific (google,gs5-*).
- Better describe the hardware in dt binding commit messages and
  descriptions.
- Adjust PHY driver commit subjects to use correct prefixes ("phy:").
- Move PHY driver from a subdirectory to drivers/phy/.
Link to v1: https://lore.kernel.org/linux-usb/20251006232125.1833979-1-royluo@google.com/
---
Roy Luo (2):
  dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
  usb: dwc3: Add Google Tensor SoC DWC3 glue driver

 .../bindings/usb/google,gs5-dwc3.yaml         | 140 ++++
 drivers/usb/dwc3/Kconfig                      |  10 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-google.c                | 628 ++++++++++++++++++
 4 files changed, 779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-google.c


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.2.1041.gc1ab5b90ca-goog


