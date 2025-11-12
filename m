Return-Path: <linux-kernel+bounces-897210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF9C5248B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C2B3BC677
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20F335090;
	Wed, 12 Nov 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYm7BLOr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228753358A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950818; cv=none; b=fsNDB67Es3JYMH47OY+gjGR2whzAGIMacEpvW3tG9Y6X4SuyItNQ3Qh+V43gU6zhETFSkk9KbjPVd1quRKf0oLel2Zaxag2lOMuFm/t+/gTWptXUIY4XWRPKmXJCQgljRjKeYIn8+ERVSmpIQOTBM9j/rrUkOPg6+3qnwTFFekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950818; c=relaxed/simple;
	bh=eJGTRxnOGVlYO1XOKNxCxIlSAwDMsw++4ZlRAIAiDyU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ThFZJnoZgxHJ3I26Mp3i7yh/XJzcRTikI1ebQ15niupqQw79NmZs6HC3PObpUsvrrqDnHbj7c6DvmoXBTs53rN18cOytwLzFSlwbXLJfzN/7vt75zBH/3sNWXClI8i+R96GBLT90FrkidiFy0PeXcSKxlnaPoQdpmsfwpr3N2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYm7BLOr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-298535ef0ccso4433955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762950815; x=1763555615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lvK+uc33/YSncyDEJOxI3GlGodXaiJ9TvJi/yjxYBw=;
        b=FYm7BLOrDMM4113BBGhall0SNW0H6Orc0Dsr9kKpDKla2moSkjbDEmMvq1eOv3NHpW
         lRbz7cN5As8pHAja4yKW/Bj9LMj+pzFw5OF7t780XNbEGox8ZU5ctSmwD4q23jjvkGTO
         XVjTUbtBtP2nwJhtWRmjcwcEkiQIQokySmceS+rnREV+SST4eiOZuLRD9JzUJlpVM+6y
         QufdMyE4N0zm024f1v+YDhPW/De/mdRyYfrBgFPLynUQhpC5Ds4ZVZUidZ5tf8uxAM8L
         oVwSmPheoOk50PJwZzmjnHbzbtao6uv6WxNdwHHLRZyyHxE0e/AAwkQTk04DJrO5I9Tp
         t8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762950815; x=1763555615;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lvK+uc33/YSncyDEJOxI3GlGodXaiJ9TvJi/yjxYBw=;
        b=ZtrHssnbdjQ46xsEJh0Zl8xvUu4weILkBgu34lWvfyocvPiwYIBDD9FrmNsZaOi2cl
         wdihRB3hR6ghAEU3SaEZoBK5beW3Xo8UbEE3SvshKnfTEMvY7vv0cv0yKrHVEDb6bVm5
         /EzLv0siLr/eM1j42IFyc5v0QUkK+NCVAfywgfZXWVEtzE11XS28hvfVmnRrIdjWPGE3
         r2lchf4i0JZJmwoVyLP/a8SbPNOYTKMHmTdRKpFC9OxxV/8xg87OYp3jZ3pwGFLyVIXi
         tBGspWTcmk4sZnaASC1qhkWWh/cqlTk75kRiV0LWjj/nT06EqY+JlUqqrE5vO2vST8P1
         bi9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcq+iK4hGIy4m0q+4NfW74tLE2mguhjvMJNZJsJvGNt5Maor6m5cGlwCEESZYHj2nTvLeFzoExbgV9Nmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbtIXbDRNG30CBjN9rpUADO8SLaT6LtksS69n5LSqe0lG7Dw8
	iN3YDlSuvBdjs3PCVyLcFaN/xrA7kzK7SrsDJyTASoN97honrph7/aqMw9GYGTVYfcbH/L0TtNH
	yeU9BOw==
X-Google-Smtp-Source: AGHT+IFLqNhYrJ49MxXnkbzra9diXQg1Vv0DtfGNDDqWdo1vsY+CTaFtQqSWQk1ZZK+fvX+HgOTe5Uof+d0=
X-Received: from dlbur6-n2.prod.google.com ([2002:a05:7022:ea46:20b0:119:78ff:fe15])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:286:b0:295:5972:4363
 with SMTP id d9443c01a7336-2984ec8f54emr35613555ad.0.1762950815330; Wed, 12
 Nov 2025 04:33:35 -0800 (PST)
Date: Wed, 12 Nov 2025 12:32:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112123257.3755489-1-royluo@google.com>
Subject: [PATCH v6 0/2] Add Google Tensor SoC USB controller support
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
Changes in v6:
- Use "lga" as SoC name instead of "gs5" to align with Tensor G5 device
  tree https://lore.kernel.org/lkml/20251111192422.4180216-1-dianders@chromium.org
Link to v5: https://lore.kernel.org/linux-usb/20251111130624.3069704-1-royluo@google.com

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

 .../bindings/usb/google,lga-dwc3.yaml         | 140 ++++
 drivers/usb/dwc3/Kconfig                      |  10 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-google.c                | 628 ++++++++++++++++++
 4 files changed, 779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-google.c


base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.51.2.1041.gc1ab5b90ca-goog


