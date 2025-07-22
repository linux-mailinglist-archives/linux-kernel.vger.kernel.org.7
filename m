Return-Path: <linux-kernel+bounces-741247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FFB0E1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075A7170AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7AE27D781;
	Tue, 22 Jul 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUyjQbFB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD72797AE;
	Tue, 22 Jul 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201992; cv=none; b=Bqc3r7tR7MfGAOCGr5P1b8Cf4jzECuZDSE8JYc/rUrnQIolq5gAUZUb3YLIdtFr20Jpx1zNJMOSG4GI7AfYPHi+/ToOZ42DmkBmCk9W6GcWKImtwTZKIqNhaYzhFmp9eisPhGmwjPnjL2EI3OC0h/hsvGhkwPW3UsW7Nr1nH8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201992; c=relaxed/simple;
	bh=w2/ci76DUFL6xmng0J7+GpGfL1XTqIZLE6fWvpruW3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJGaWGRCiXPI/yjssJqx1BSRsFXKavnjPVhrxojCrBBSIMTcSvRvweSqhCmKpGQ4TojALYWOsOURGJHAu4ITB4fPXNy+d9+4rGZSGMGYJeVLFa1hYC9U2+SbaDTEWaCQwG8L3hVOgV5iXfyrZvNdzugMjvyiHW0EJ5QPYXYRuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUyjQbFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BACEC4CEF1;
	Tue, 22 Jul 2025 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201990;
	bh=w2/ci76DUFL6xmng0J7+GpGfL1XTqIZLE6fWvpruW3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUyjQbFBa25rFaLtI4a0MJ5dF3CtVjOjO1VnuRONqZFsfylOqgw9EWCznMyAtut+n
	 HmGR4XlEeSKSarrlab1rJP6884OW0moewIKrS7/wMe6SMWv44dBSMhr9+RWE+nM3EY
	 O408prv1drYa44V5ouupdWBZyPyQhVmX1IrBzBF2ZsAParjPo91irK663P7fxEcohq
	 UtuZhd48iUXNpfM7MiAPKKZ4CqhHXiR9L8tpws4Vh4dHWSMvuWsEdjN9tYPd47HjeH
	 iC04WAlYI1fgpuIG80ZVlSDmq5YgVFX5Kx8gDh29Om5rnaOIQ5DPLI7EhbE879fXCD
	 us4qRREgbyG+w==
From: Sven Peter <sven@kernel.org>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>
Subject: [GIT PULL 2/2] Apple SoC device tree changes for v6.17
Date: Tue, 22 Jul 2025 18:32:58 +0200
Message-Id: <20250722163258.62424-2-sven@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722163258.62424-1-sven@kernel.org>
References: <20250722163258.62424-1-sven@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sven/linux.git apple-soc-dt-6.17

for you to fetch changes up to 76f3ffeb41d8700c22005211521bf692f2551668:

  arm64: dts: apple: Add Apple SoC GPU (2025-07-21 15:22:10 +0000)

----------------------------------------------------------------
Apple SoC device tree changes for v6.17

- Added the bindings and nodes for Apple SoC GPU. The driver itself
  isn't ready for upstreaming yet due to rust dependencies but we're
  confident that the bindings are stable at this point.
- Added a missing node for the touchbar framebuffer to Apple T2 device
  trees, which is the BMC for some x86 Macs
- Fixed a W=1 warning by adding bit offsets to NVMEM node names. This
  required a change to the generic NVMEM cell binding which will be part
  of 6.17 through the NVMEM tree.

Signed-off-by: Sven Peter <sven@kernel.org>

----------------------------------------------------------------
Nick Chan (1):
      arm64: dts: apple: t8012-j132: Include touchbar framebuffer node

Sasha Finkelstein (2):
      dt-bindings: gpu: Add Apple SoC GPU
      arm64: dts: apple: Add Apple SoC GPU

Sven Peter (1):
      arm64: dts: apple: Add bit offset to PMIC NVMEM node names

 .../devicetree/bindings/gpu/apple,agx.yaml         | 94 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/apple/t6000.dtsi               |  4 +
 arch/arm64/boot/dts/apple/t6001.dtsi               |  4 +
 arch/arm64/boot/dts/apple/t6002.dtsi               |  4 +
 arch/arm64/boot/dts/apple/t600x-common.dtsi        | 34 ++++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          | 34 +++++++-
 arch/arm64/boot/dts/apple/t8012-j132.dts           |  1 +
 arch/arm64/boot/dts/apple/t8103.dtsi               | 68 +++++++++++++++-
 arch/arm64/boot/dts/apple/t8112.dtsi               | 68 +++++++++++++++-
 10 files changed, 303 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/apple,agx.yaml

