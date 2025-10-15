Return-Path: <linux-kernel+bounces-854807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3CBDF717
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131224ED48A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6F32ED3D;
	Wed, 15 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6vs4vGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2B327787;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542870; cv=none; b=u/V+jc77ns/pKoQK6RWm7s8DgwroYdzeZK42QaZy6FEXhyNTGUWtuRc/QIveBM5USTeLZ99G71TumDx+uDnbCD3ul8FLqglS1nuTrLYnSqSWnrqr1BrbKRBQfxUcEE/UOZ7x+FytvWD2XXV7UHkk0VmAQlVYZ0ykeWmLpiKvZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542870; c=relaxed/simple;
	bh=jDD1jxLWDqxUDxesIU9RCN0rgJCoWLFeBdfc8PLouSE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P28dcM5yaSB0TqhSH+DseitWmNDBBunuq+osu1HZgXefo54MNj/HtdmezkXmfWeEm0WX3VGCYJpoak/hFTTuhGCYRm1wlY5D1kii1P0fyPy+u5ljpBLdbuUGDo/6WXiO1JWxewkQ3uUzHZjHxi+zfWUT/+WtF0ucR3w553LOYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6vs4vGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65AABC4CEF8;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542869;
	bh=jDD1jxLWDqxUDxesIU9RCN0rgJCoWLFeBdfc8PLouSE=;
	h=From:Subject:Date:To:Cc:From;
	b=a6vs4vGq03raDuXSgrQqg5hENlMl0xnf5Vu6aas3ObbKOIKH780VRpmv2+Y8Bbdfn
	 bNrvL6vf0CU1rqSE1Ve16c/N6kxxBUsfrAhNLMkJfy0wU+bI9s4EA+ARuiyF2Fk09V
	 KI6lYhh5w90WeblZDVIOHTI7LMo12jBWJr2yLnmyCItRdmTzhU6k14NzyLKIp94e1E
	 4M9ywcK/GmxPEb+WprYIujw5IEKl54RcXLirNtIlZiydxf8uIxG2L7MvOW/5YVsR0s
	 7Zev2ArYnDG1zp9ESpPS1axy/W0rUEsal8w3yYCITQjpTP3eHvlY2H1dg+1JR6NR9o
	 +5W1t4DSUqJJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EBCCD199;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH usb-next v2 0/5] Apple Silicon USB3 support - dwc3
Date: Wed, 15 Oct 2025 15:40:40 +0000
Message-Id: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjA72gC/3WNQQ6CMBBFr0Jm7ZiZUoO44h6GBZQpNJJCWkQM4
 e427F2+vPz3d4gSnER4ZDsEWV10k0+gLhmYofG9oOsSgyJ1Y+IcW43NPM6C3cfkqG1REpeFZlt
 C2sxBrNvO3hPesUUv2wJ1MoOLyxS+59HKp//TXBkJWTXFnYgMsa5eEryM1yn0UB/H8QMSfIMRt
 QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=jDD1jxLWDqxUDxesIU9RCN0rgJCoWLFeBdfc8PLouSE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8b7A93N2e//l16/ae2y5/XqqMWmLmbfWU6WG6zirWaUS
 e8Pkn/TUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZiIzl6G/56xG6JyT7r+iFV+
 9Wvx5YgDi5+ntc2Y5ioaZ/TnaM/r6UsZGaY/errN7IaZ5rYq329vmDVmvvK5f2FC9dElvDN3GoY
 7tLIBAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

As discussed in v2 of the combined Apple Silicon USB3 support series
this one only contains the dwc3 changes without the DTS changes.

Changes since v1 of the dwc3-only series:
- Link to v1: https://lore.kernel.org/r/20251013-b4-aplpe-dwc3-v1-0-12a78000c014@kernel.org
- Rebased on usb-testing
- Fixed a trivial merge conflict in glue.h regarding struct dwc3_properties
- Added DWC3_DEFAULT_PROPERTIES to dwc3-apple.c
- Added Thinh's Acks (thanks!)

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
 drivers/usb/dwc3/dwc3-apple.c                      | 489 +++++++++++++++++++++
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/dwc3/glue.h                            | 143 ++++++
 drivers/usb/dwc3/host.c                            |   7 +-
 9 files changed, 745 insertions(+), 6 deletions(-)
---
base-commit: 877c80dfbf788e57a3338627899033b7007037ee
change-id: 20251013-b4-aplpe-dwc3-4f79019741f9

Best regards,
-- 
Sven Peter <sven@kernel.org>



