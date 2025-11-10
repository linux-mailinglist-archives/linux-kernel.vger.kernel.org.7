Return-Path: <linux-kernel+bounces-893793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3BC4860C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F483AF476
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737C2D8DDD;
	Mon, 10 Nov 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7qCZy7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF12D8790;
	Mon, 10 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796198; cv=none; b=KLiKgCnjDOS0VKD2mzuXlKmtUDzSn4R1+T2/yfmaexTluGL91nxaySEfrLW6wCp2egblW/qEjqavFV9N0w3FbFtLEZXJ+v7zj4nqdh5QLmgSDbLbC81lo+7SWBFBw6untXxtPzjBs+ehyXQmYLZDnDKP2+dJ4ZzldGClWdk3Zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796198; c=relaxed/simple;
	bh=1uZvx82C8D5WpkTJImvmsYLYSmOYGhbdYZ0x4PHMAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DImszNOPB7vFaKmYxqwzFyx250VF6+QqqVqTFgiY+Hnsd5YK6vb9/HKUbeKi0rbhCw47qaZqozGb0jl8IP4XZLH3m6FxXXsnPkOm70HUpSH7o/BgQu7QD7mEoEH9rUya6VnvVLopRc/ZKg+gobnWsVJGy7U0fID3gODr179P+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7qCZy7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108EC16AAE;
	Mon, 10 Nov 2025 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762796198;
	bh=1uZvx82C8D5WpkTJImvmsYLYSmOYGhbdYZ0x4PHMAIk=;
	h=From:To:Cc:Subject:Date:From;
	b=f7qCZy7qNzgNHfr9c5Gcjsn0ZR4c/UoNHslz23HK3vpkLXVRycRTWZx+6HeCbyUuK
	 SIaBptJjvSLJJvweCdfJ5eyjlW86+2jngdSqhNPcbuZx3+UptcEvxPB914jbaMoQHT
	 DCDc9V9p9c7r5p/AP7pS+kgVPFcBB478DucXSMChOQWZq4MvgZXS85wx8JrlF5YsrF
	 7FcMQoqQFknqsP1KiGZVVRr1BpeQFaI7r0evyUAEqGhj/1Kb1YGDCieHiFpZpHB+G5
	 ZDdrQhtR4VU705Bo9aQonhX35+gDjpv60XGzjY5rdKA6ZlbTBudLJILaZQmscoCxfz
	 tCrn6wvbuvDHQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] memory: drivers for v6.19
Date: Mon, 10 Nov 2025 18:36:24 +0100
Message-ID: <20251110173624.3127-2-krzk@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=krzk@kernel.org; h=from:subject; bh=1uZvx82C8D5WpkTJImvmsYLYSmOYGhbdYZ0x4PHMAIk=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpEiKYhRrNlNcX+dXOOyQnco1YXMVo1rSdS1taZ DIRgMehD5WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRIimAAKCRDBN2bmhouD 1+j0EACNkqA8V9RPyV7MhI2DMYr7THG++Aw/HwvTajsmjoZFqSFsgrf6fDvyAWUOddT4XnTcuEr V3a1XsNVm4n+RlMgHW3KDOBouxgOJGZWg7InjdwmCZPxrIB70ePkDfRh1l5qWVCRsFiRjeKx0ga 9Yv6/76PUM59eqVSa2K5NWPinBuoPyMjeeBQY5o4e/eHgPkTZgSilSGw6L0YYln7VhuMRf0ILyi 9a+QAX/Te/BZ1r7Aybwg4mfSiNkv+qkXSq1b6QH+hG9Cu4wzvwPfACJaBFkpCyFRCM0QIY1LW7M 96VNpB2Q0uZi79reTE8TcKFwDOuZAoZ+9MhKhs03dDVLqOIZ4s365nPTX+B+Bkg20TiBbT3vMH0 3zriTMHrqiTqvJTQ3+RYoWJqwP4OlF9t/Xtrjd6pKSQ2lTK4AJQ4UKGk3EptR/1NiCHje9Jic5X WmYs+9jflyc6LeXtXp3XalMpj0rNTFPE5bMjlfBZhpZHaps6ElIgie7IDdE543kL4tlBUgb5+tI hIQP5fM+Oe5DUYDhi4XD2xNtki1c/Qjl8e1TLeHGhYSP2vT3T9feMWrz/PmGBrbHdYBRmtOlxHn AMtfsaUnNTBtPB9pG5GC6V1iGSiByEK/3oNjasavPtOtSN0x5LcYizpIVI6h6GmQZVGzTSpY9Av GzVXpjLomBWAmrg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.19

for you to fetch changes up to 8728bdd648f1b0f48ddfdb57bf6d9e7515e02518:

  memory: tegra186-emc: Fix missing put_bpmp (2025-11-07 16:24:13 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.19

1. Tegra drivers:
 - Several cleanups (dev_err_probe(), error messages).
 - Tegra186, Tegra194 and Tegra210: Add interconnect scaling.

2. Renesas RPC IF: Add system suspend support.

----------------------------------------------------------------
Aaron Kling (6):
      dt-bindings: memory: tegra186-mc: Add dummy client IDs for Tegra186
      dt-bindings: memory: tegra194-mc: Add dummy client IDs for Tegra194
      memory: tegra186-emc: Support non-bpmp icc scaling
      memory: tegra186: Support icc scaling
      memory: tegra194: Support icc scaling
      memory: tegra210: Support interconnect framework

Biju Das (1):
      memory: renesas-rpc-if: Add suspend/resume support

Jon Hunter (1):
      memory: tegra186-emc: Fix missing put_bpmp

Krzysztof Kozlowski (13):
      memory: tegra124-emc: Simplify return of emc_init()
      memory: tegra124-emc: Do not print error on icc_node_create() failure
      memory: tegra186-emc: Do not print error on icc_node_create() failure
      memory: tegra20-emc: Do not print error on icc_node_create() failure
      memory: tegra30-emc: Do not print error on icc_node_create() failure
      memory: tegra30-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra20-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra186-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra124-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra124-emc: Add the SoC model prefix to functions
      memory: tegra186-emc: Add the SoC model prefix to functions
      memory: tegra20-emc: Add the SoC model prefix to functions
      memory: tegra30-emc: Add the SoC model prefix to functions

 drivers/memory/renesas-rpc-if.c          |  56 +++++--
 drivers/memory/tegra/Kconfig             |   1 +
 drivers/memory/tegra/tegra124-emc.c      | 140 ++++++++--------
 drivers/memory/tegra/tegra186-emc.c      | 167 ++++++++++++++++---
 drivers/memory/tegra/tegra186.c          |  48 ++++++
 drivers/memory/tegra/tegra194.c          |  59 ++++++-
 drivers/memory/tegra/tegra20-emc.c       | 150 ++++++++---------
 drivers/memory/tegra/tegra210-emc-core.c | 269 ++++++++++++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h      |  23 +++
 drivers/memory/tegra/tegra210.c          |  81 ++++++++++
 drivers/memory/tegra/tegra30-emc.c       | 119 +++++++-------
 include/dt-bindings/memory/tegra186-mc.h |   4 +
 include/dt-bindings/memory/tegra194-mc.h |   6 +
 13 files changed, 868 insertions(+), 255 deletions(-)

