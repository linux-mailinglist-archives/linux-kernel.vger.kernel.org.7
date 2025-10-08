Return-Path: <linux-kernel+bounces-845064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5DBC368F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53B3E350D52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421DE2DAFCA;
	Wed,  8 Oct 2025 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ka3L04dx"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AE2BD58A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903213; cv=none; b=JbWB5IOEUD+3aqXihRxZt72PZ4vISjtRR8k2O1/khwlUQCB3P0uUsaAWBRp4hNURh7jySMddFbOSVocaHMkJUGVMpagV6VZRvz2sTccH/HMGUaBUnNlNlw4d0X2YgTyvhUFvzbrFVEQGrS6VuT2KC2LH6AxI7+79c2yfM37z+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903213; c=relaxed/simple;
	bh=Re4aYmVY4+mRn8xwwmfbfR8Zw01dBZqm91ZI3IkjBPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MBCRnnQ0wXGv4yEfHzdMTUsl7zvmnwPXWXHerRkpuhbydthmdvAodPVKORr9eviH6AXEdfj36v+5zHvBNQdtrUEutvZn+02++/z9squtdbIzD4YueCQzQs84ClDWtX3VBIXLWdldbRcI+g0Zh0HC4qTb/mRz38c98M+KBdmOoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ka3L04dx; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-64c25d8be9bso1315661eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759903210; x=1760508010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AP6DiX2vSgFvsuE3fKRpRDJbOdj4dqy4q7VW/8dnF2Y=;
        b=Ka3L04dxu3SenDU+iB50QOyc4oTm1wtaJPJxc/OQh29r0I2vqrAi75Vp6TROGXeuHv
         RkNG5vpi5Xk7EkUgdALUuwPYNterzOdzi2Q09JUxPMf95dXC8F6yyOUb6wQqFvXKezd4
         bhvPccBnwoYNccM7QV1LRmU8IL+OCK1kH0OpFLVHXUnYiY4lXw8hNuAgKWrg+7XrRfPN
         mRrkoxDXHi1jIdqxmXGctwShhn9lxOvgta49PlJ8mSiwK1Yvs5Z2h0DOfzPII6sFQNz7
         WWyUtgzePI6vtaf/FX4wAQqmDCn6UX5VJnl6/SdCEFsumdOpWw4VPV/R2F+4OwlKpeLu
         zbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759903210; x=1760508010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP6DiX2vSgFvsuE3fKRpRDJbOdj4dqy4q7VW/8dnF2Y=;
        b=l621COtvQaKsYqNhOwd0cBFs2S5FnaWTvFH4A/tYHEiBmGu/2oOoc9B1pVdIL8eVTt
         oT3Kk9MduQxbMmNI9dSYE4nEF6LEzluHhDgxGBgBudW6/Wdtxjwg3TgbMrcVsDkIF+x1
         CXHhu9/WqNqYE9tiXrg08JzIicW0XbidmTKPaTn+KegVp2Ln6VIxq/XznB3vNCR+r3bc
         DYPxuDMmwsV0ChoSDoBZ62eiPU66DyKQM6oi5rR4GIV56lmPl4ttNXqDx35PWPdb7ewO
         RR7bFof57d741Sa43CjaSg0VXIFdpbLPx34Z/8twChYJPNEAj/UYd96q/svSDKKIlCI8
         CHmw==
X-Forwarded-Encrypted: i=1; AJvYcCWaE4UgVon1DZKMMs+gQAge/k/QbDEikH7yIgfmlI8OzgdkD3kwIXQEcRO3gUYo6GJjY7HRye0OCzIIpvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8eSqYeVYZWXi33uVhyRxheSLOlNhZ15zYrAUHIQ53HHnZkaI
	/2qFzNSDVVNdbH/T/oLh3jpVA9cA/Xw/eIcnShV35g1cZ+P19UXojVOXX2w/DgaD4N0NbLv4/5x
	pR8QW7w==
X-Google-Smtp-Source: AGHT+IExUaS0sEpy2tAXscJ/2X+pom3EjFHo1AYYt3+9hKmXEYWCEaP2JPhBawFpp4MTEQMwGSBBqKvOJGE=
X-Received: from oacoo38.prod.google.com ([2002:a05:6871:4526:b0:331:9a49:4dbe])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:2b25:b0:36d:287c:694f
 with SMTP id 586e51a60fabf-3c0f80edcd7mr1302345fac.30.1759903210532; Tue, 07
 Oct 2025 23:00:10 -0700 (PDT)
Date: Wed,  8 Oct 2025 05:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008060000.3136021-1-royluo@google.com>
Subject: [PATCH v2 0/4] Add Google Tensor SoC USB support
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces USB controller and PHY support for the Google
Tensor G5 SoC (codename: Laguna), a new generation of Google silicon
first launched with Pixel 10 devices.

The Tensor G5 represents a significant architectural overhaul compared
to previous Tensor generations (e.g., gs101), which were based on Samsung
Exynos IP. Although the G5 still utilizes Synopsys IP for the USB
components, the custom top-level integration introduces a completely new
design for clock, reset scheme, register interfaces and programming
sequence, necessitating new drivers and device tree bindings.

The USB subsystem on Tensor G5 integrates a Synopsys DWC3 USB 3.1
DRD-Single Port controller with hibernation support, and a custom PHY
block comprising Synopsys eUSB2 and USB 3.2/DP combo PHYs.

Co-developed-by: Joy Chakraborty <joychakr@google.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Co-developed-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Naveen Kumar <mnkumar@google.com>
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes in v2:
- Reorder patches to present bindings first.
- Update dt binding compatible strings to be SoC-specific (google,gs5-*).
- Better describe the hardware in dt binding commit messages and
  descriptions.
- Adjust PHY driver commit subjects to use correct prefixes ("phy:").
- Move PHY driver from a subdirectory to drivers/phy/.
Link to v1: https://lore.kernel.org/linux-usb/20251006232125.1833979-1-royluo@google.com/
---
Roy Luo (4):
  dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
  usb: dwc3: Add Google Tensor SoC DWC3 glue driver
  dt-bindings: phy: google: Add Google Tensor G5 USB PHY
  phy: Add Google Tensor SoC USB PHY driver

 .../bindings/phy/google,gs-usb-phy.yaml       |  96 +++
 .../bindings/usb/google,gs-dwc3.yaml          | 145 +++++
 drivers/phy/Kconfig                           |  14 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-google-usb.c                  | 286 +++++++++
 drivers/usb/dwc3/Kconfig                      |  10 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-google.c                | 597 ++++++++++++++++++
 8 files changed, 1150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/google,gs-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/google,gs-dwc3.yaml
 create mode 100644 drivers/phy/phy-google-usb.c
 create mode 100644 drivers/usb/dwc3/dwc3-google.c


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.0.710.ga91ca5db03-goog


