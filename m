Return-Path: <linux-kernel+bounces-772191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5448B28FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64F7177E66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED42EBBA9;
	Sat, 16 Aug 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+Xmw6o/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2B139579;
	Sat, 16 Aug 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364564; cv=none; b=Gha3mzMyLfsz4LbUjVHY+ZhYvzA9qwNSH4imScR17tRx9MnWsHkHtOL5IBu8V4h08wW92zQEW0qk0IFH12oWFjWh0EKMNUZYfu+LlhQCkhx+X6/9yDaRyqdskEWpO/yCCO6o9EdABoSfvKAlOfKJ7q2q5LaMXJRCGbxpMhcrY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364564; c=relaxed/simple;
	bh=ao8lo751AGNzX2v8GLWik2TEF/A3j9GyMFvXVbbqS+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RaMeCUPZtI48hLVr1UfFzZDKjijy8mMOqfFOgbI/Y5o9OsiKnPi6Xr1LNva9VZb6vv7u0PULjT7YHQmfQJPakfWggTcHXLzHAWhDltLqDFtQjaMDaGm/3dBgcnhve7XXMFRQRKxi+UlZbOO7ooCM/HgVRWm4X3dCWc+WU3olVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+Xmw6o/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6D9C4CEEF;
	Sat, 16 Aug 2025 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755364563;
	bh=ao8lo751AGNzX2v8GLWik2TEF/A3j9GyMFvXVbbqS+o=;
	h=From:To:Cc:Subject:Date:From;
	b=d+Xmw6o/iwobRjqC3S6SVSVDDs2vuVYW5O2HNDL3XQWiZhxzU+DI6/0lYw/ScSLsr
	 jxnGo9X39gNEqgmMMq73caB6cUlifePPGwTVlxY17BoVo+k5TEGUvtEAEg1RfK0f+u
	 a6JAOu3gTkfCfu4UiXZk28wcNb9zKBBNES0jKF/pNACIkGeQ03rpdlwEAydzFmlBfO
	 jBkDqnVCXesOrLAU7TUXwnur0eskpTZX+xAJ4NjhaxhiWfs8VhIRuGd7DzNi48xNMe
	 TOJS5RE5UIjABjStkF3zXSRjGOMpH6iQtg7vZlqw65gVhlZftz5/hR/3keVCsyn6gu
	 9OACVze1QjwBA==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>
Subject: [GIT PULL] Apple SoC DTS changes for v6.18, part 1
Date: Sat, 16 Aug 2025 19:15:01 +0200
Message-Id: <20250816171501.31944-1-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnd,

Here's our first very early pull request for the 6.18 merge window.
All of these changes could've been part of the 6.17 window but the dt-binding
changes were only picked up after I had already sent out my pull request which
was already very late.
These have been part -next for about a week now.


Best,


Sven


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git tags/apple-soc-dt-6.18

for you to fetch changes up to 4379305ffbc2eebe3de673fc965145d441c89b8f:

  arm64: dts: apple: t600x: Add SMC node (2025-08-10 20:21:57 +0200)

----------------------------------------------------------------
Apple SoC device tree changes for v6.18, part 1

- Added SMC nodes for M1 and M2 including the PMU GPIO controller and
  reboot sub-nodes. This now allows to reboot these systems and is
  required to later enable the power GPIO line for the WiFi board.
- Added i2c nodes for A7 - A11 SoCs

Signed-off-by: Sven Peter <sven@kernel.org>

----------------------------------------------------------------
Hector Martin (3):
      arm64: dts: apple: t8103: Add SMC node
      arm64: dts: apple: t8112: Add SMC node
      arm64: dts: apple: t600x: Add SMC node

Nick Chan (8):
      arm64: dts: apple: s5l8960x: Add I2C nodes
      arm64: dts: apple: t7000: Add I2C nodes
      arm64: dts: apple: t7001: Add I2C nodes
      arm64: dts: apple: s800-0-3: Add I2C nodes
      arm64: dts: apple: s8001: Add I2C nodes
      arm64: dts: apple: t8010: Add I2C nodes
      arm64: dts: apple: t8011: Add I2C nodes
      arm64: dts: apple: t8015: Add I2C nodes

 arch/arm64/boot/dts/apple/s5l8960x.dtsi   | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi   | 57 +++++++++++++++++++++++
 arch/arm64/boot/dts/apple/s8001.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 35 ++++++++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t7001.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8010.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8011.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi      | 76 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi      | 35 ++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      | 35 ++++++++++++++
 11 files changed, 694 insertions(+)

