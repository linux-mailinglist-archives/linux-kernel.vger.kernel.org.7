Return-Path: <linux-kernel+bounces-850988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A2ABD5578
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 485F4542778
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAD30DEC0;
	Mon, 13 Oct 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INDtoDFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC173093A6;
	Mon, 13 Oct 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371438; cv=none; b=JPQ9AMRmv/j13UvWVCKpznagkSX+gqCV3RAYNrLyO8NddtK1wu9JaGmJmrlJozIRSZ+RHk72TurcbkESj+YalKRab/zVS7PCQVlwMRgaLf1m9yShbENnTur18i+Ceu51xYdSsmYqnvowvb5EX3hSoeuaKf8aF+RAl0/ilMxNGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371438; c=relaxed/simple;
	bh=rWotubb4CBnANwxKjnVhMxklcZzF6pHwe+WDhBKK4YI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mx3ciy9w4afzskns1izRWra2/RowLe0RW5fMdKcF68Wt/od68S+icKqaywbhJM1okcF6rMeaMPP3DhypHugeESToZDsLrOQ8f+91ix5mhZtnKPhFriewsvx6HptdN6gchmXoecTT+h8h+rHFRd0IthGqf/5fmSLtbZovLKafcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INDtoDFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E35F7C4CEFE;
	Mon, 13 Oct 2025 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371438;
	bh=rWotubb4CBnANwxKjnVhMxklcZzF6pHwe+WDhBKK4YI=;
	h=From:Subject:Date:To:Cc:From;
	b=INDtoDFE+pjOgH/g6E2xzS7J0AOM6w7kxweMsusiOCCdbdH7hEsB+UGFAiqAaQGZq
	 AuD9u4OIfNVSHF4CqqBqhXdf7ZXHZg4yjh6qLsdiMod7MK1QS37pmIYoSQMBrdqhXm
	 IhKos1I8nif5ocV64OGWVr4XS7GipKFbe2yLbd77ZL4C6RLWlyOM0LtH7te0gMH0fZ
	 FMpLPwsmPcp32rT6RfSKLtsUbdGKm+IGX6NIVNyr07REuuJl7nYHhehdUuX1+f5Cfd
	 nXXR8hzWOin2YkXeVbr5W5enfPZAuzJcfpIfivW03KvCtl6/HXdHrNz4JMDAjGLfMY
	 aRZhwqN3YtdiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF789CCD18D;
	Mon, 13 Oct 2025 16:03:57 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 0/5] Apple Silicon USB3 support - dwc3
Date: Mon, 13 Oct 2025 16:03:24 +0000
Message-Id: <20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwi7WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3SQT3cSCnIJU3ZTyZGNdkzRzSwNDS3MTwzRLJaCegqLUtMwKsHn
 RsbW1AN+dgqhfAAAA
X-Change-ID: 20251013-b4-aplpe-dwc3-4f79019741f9
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, stable@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=rWotubb4CBnANwxKjnVhMxklcZzF6pHwe+WDhBKK4YI=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ZbpYd7Mhtrgqq4uP7eSDjAe5Oh40mhc8r+3ScKNr/ep
 HnR08qwo5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRnS2MDIuq1yQ2fuqavHjV
 5alW85k9jS1uHLeYZ/z2ykovNZujv4MYGSbO5L1yrmPb1RniF8WmJm/Yz3Rl364lh8+Xn28uZ4+
 TXsMCAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

As discussed in v2 of the combined Apple Silicon USB3 support series
this one only contains the dwc3 changes without the DTS changes.

Link to v2 of the combined series: https://lore.kernel.org/asahi/20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org/
Changes since v2 of that series:
- Documented all functions in glue.h
- Fixed a typo in the example for the dt-bindings
- Added detailed documentation about how the dwc3 hardware needs to be
  driven on this platform to the glue driver
- Renamed dwc3_apple.mode to state and folded in the probe check into
  the new DWC3_APPLE_PROBE_PENDING state
- Collected tags

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (5):
      dt-bindings: usb: Add Apple dwc3
      usb: dwc3: dwc3_power_off_all_roothub_ports: Use ioremap_np when required
      usb: dwc3: glue: Add documentation
      usb: dwc3: glue: Allow more fine grained control over mode switches
      usb: dwc3: Add Apple Silicon DWC3 glue layer driver

 .../devicetree/bindings/usb/apple,dwc3.yaml        |  80 ++++
 MAINTAINERS                                        |   2 +
 drivers/usb/dwc3/Kconfig                           |  11 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  16 +-
 drivers/usb/dwc3/dwc3-apple.c                      | 488 +++++++++++++++++++++
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/dwc3/glue.h                            | 143 ++++++
 drivers/usb/dwc3/host.c                            |   7 +-
 9 files changed, 744 insertions(+), 6 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-b4-aplpe-dwc3-4f79019741f9

Best regards,
-- 
Sven Peter <sven@kernel.org>



