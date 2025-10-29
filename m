Return-Path: <linux-kernel+bounces-877220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1FC1D779
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04694E2B21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165231A562;
	Wed, 29 Oct 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlXt8/7K"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6431A062
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774058; cv=none; b=fknL16u/dE3iiXiWpFcNgbmow6B+uipQdHRzoBj+gH+dkXQuRfR4P0TqwU6o0W8mT8dbNzFwgF5sxcgqRHQ/1GehKglzP/ILiSapcSkiAahxTpA6kjD9pHxaP8OXy7k3EiyNx0WUqSi+2Ay9rnnpqfxG332PaY2JSAfgYddsBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774058; c=relaxed/simple;
	bh=YC4Rx9Z+7FlNqD5iuesqXET6TUuf9BmxekmzsGIWubo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZF6Mk3Y2ppQPSB8Yfp28MWCDpP8RF/+K9ry2Pg5+Ke4q6nir2ybQaF2KWd5v2YfO9gQcYeWgT7z3XFyqVA/jYMZX0B3N2vr9jBCSv5kJxPIZucYal3jYtHF7J1sFMth8TE/v7wFV+P7bAq6rETDFAiXQyJgmCjBDiiVLPZaBAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlXt8/7K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28eb14e3cafso5128445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761774056; x=1762378856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1p1oeYfspOx7SSAvPlr7bGgu5n9Q/dCaxclZDr61jg=;
        b=nlXt8/7KVBiJwrNLvfetoFEA+pdciTBhOwPWdh8toyrmmRgknnFxaps6dH1a/5muBF
         nlM6GhNlOMlDxENT1E8wxo+QDmqWgQotLrwTyiilF9KJjgWqWxlBjlaVoDlqBhmfg9Hb
         eSvFGUfoQXYy/+MYrbHDIPDMyfBRlBNwavKHyKrg2H2bvprfYkZkgutY3YZQAgUNOSmP
         5HImQEOoyAzpUS3xHJRpQAaLzPqXbtLERUOCkBA2BkUvRu3xCu6DgAquB55g0NOFTLFS
         5BxawoJScPXBbwGaaozrjHUw+RXSt3CkPIpLBEYvk3VuJ2qBKJX+3POUIofnWBgB55Xc
         J8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774056; x=1762378856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1p1oeYfspOx7SSAvPlr7bGgu5n9Q/dCaxclZDr61jg=;
        b=Kn8FhN2T00hPRBPGxGtE7neakVKSxmcZiLrJyRaKptTY7Ssm+gH13wKB3QybJA9ujk
         QA6iRusBFHCZ+ou66kx0waxVIgG61x59o10SlemzypBEvgLUwbk4VI+Nn2Ha6/2KFT8S
         PHEYtfrVkyz9sRhh4kqZ1tZUYOu6ZWVXcm1lN20rqsfUAeayZGqtfOoWr57reijj5dVj
         q3qecz79Dk2N4tF34aj0fMcIcTmUGpsWrSA+Ki8jXMDEFG6+HXHvTyKWwZNnXVa049n6
         O6q1mp4JsvnRjKAe6kP58vPmJ0jom9Xw3SM2s+e/vdIusZSjS8fh2weJcsfq15IIkUL9
         3wEg==
X-Forwarded-Encrypted: i=1; AJvYcCXHFAclSrCFDK2iOxRArLkyrumKhDnjWkri56DjEBIF8bzGnm6skdGKgLrZGqbIyx7BoMuoS1g9uuZMPbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6E0L+kpnPAnkbP6aPBwEJ1DnMcdyJLLClNuaH5COQxbvGCLS
	zM/lmUvKAvPTLb6+7XOWQO+fH1TCgNQRWKRb4bTfNLITdiA9OKrxj27ooyEjHAsJYU5G8K4/zCq
	Mk5iYIg==
X-Google-Smtp-Source: AGHT+IEVCwQK+uqTzDFeeOMYHV/ZNZOQw0zJsYdD8Ck4OGRaKkCeRa+O9z2vmnih+ac8NQhsb2enH3x6CnI=
X-Received: from plkn2.prod.google.com ([2002:a17:902:6a82:b0:292:4a9c:44cf])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3846:b0:267:9c2f:4655
 with SMTP id d9443c01a7336-294deeec254mr49534185ad.41.1761774056444; Wed, 29
 Oct 2025 14:40:56 -0700 (PDT)
Date: Wed, 29 Oct 2025 21:40:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029214032.3175261-1-royluo@google.com>
Subject: [PATCH v5 0/2] Add Google Tensor SoC USB PHY support
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Doug Anderson <dianders@google.com>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces USB PHY support for the Google Tensor G5
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
block comprising Synopsys eUSB2 and USB 3.2/DP combo PHYs. The controller
support is sent as a separate patch series.

Co-developed-by: Joy Chakraborty <joychakr@google.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Co-developed-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes in v5:
- Add usb3 registers/clks/resets to binding as suggested by Krzysztof
  Kozlowski. This ensures completeness of the binding, though the
  driver has not yet ultilized the resources. The usb3 clks and resets
  are optional if usb2-only operation is desired, this is denoted by
  minItems and descriptions in the clocks and resets properties.
  Additionally, rename existing binding entries for consistency and to
  better differntiate between usb2 and usb3.
- Move the description of the phy select to phy-cells in binding as
  suggested by Krzysztof Kozlowski.
Link to v4: https://lore.kernel.org/linux-phy/20251017235159.2417576-1-royluo@google.com

Changes in v4:
- Separate controller and phy changes into two distinct patch series.
- Remove usb2only mode configuration and the corresponding usb_top_cfg
  reg (moved to controller)
- Add more descriptions to dp_top reg to indicate it's not DP specific.
- Add u2phy_apb clk/reset
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
  dt-bindings: phy: google: Add Google Tensor G5 USB PHY
  phy: Add Google Tensor SoC USB PHY driver

 .../bindings/phy/google,gs5-usb-phy.yaml      | 127 ++++++++
 drivers/phy/Kconfig                           |  13 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-google-usb.c                  | 271 ++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/google,gs5-usb-phy.yaml
 create mode 100644 drivers/phy/phy-google-usb.c


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.1.851.g4ebd6896fd-goog


