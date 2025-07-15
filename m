Return-Path: <linux-kernel+bounces-731755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A9B05911
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770D14A0BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8E2D94BC;
	Tue, 15 Jul 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBoM/oxH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C4273D8C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579928; cv=none; b=q67lTKaoQWG+Zt2wkGIbsRIbGq9UcWkH9DIkhbcnb71PmO6xGF2Qlj8hfGvXG4YHzFAwim0cMiYvuls8yibPd8Z+H7hsENXAjjekPTM9dGBbDeqw2N7W1HRr8mpMno2iqwb99zzj6Md91PcVZvzuIvhCHJwdLJuVGQu0rEDLYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579928; c=relaxed/simple;
	bh=RSNF4QNrAE+1Kk9FftCVUREPYx43lWjS4Rbg2fpa9eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kxLI2zaMgKfP2ILGeq0d8Ikws2hIL49VgR+tO3lQQbWD38NJGGhwH/k1gosDNIYzUrLyEoNkrGjdsNibndY1g6/elBQu/cLrMgVKUY2Jq2rWpqZimLEUZIJiizNWM+ec12sBF6yrW9jYI/iL2LUidtRKqhhawDyneX449XSJrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBoM/oxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 807C0C4CEE3;
	Tue, 15 Jul 2025 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579927;
	bh=RSNF4QNrAE+1Kk9FftCVUREPYx43lWjS4Rbg2fpa9eg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nBoM/oxHF3ACntns3OkIrWJpbnSeboMsAUsRQhkZNEM4fAqklyWU/SFrB7L1+eGjL
	 9KLCi2YWLWXNl2+GYcIhSd6dScfPGu3dmi7a6x3jc5M+LXVGTivX3cUkgWUwcWng34
	 tyRoNHcX7WG6l65RnJB0R1NTBQL8/Lmt58l/S7QzH3GfcOMQLvb7ChB+n5pWyhvJ8b
	 1BPmx4I8dSNvPrv7u9TenIacsx4BRcTItQimaSnI6aFzeyLglAgRNETqgIH74DfLgp
	 pmmFSH+JXcw03FGLl86v0dFeyHI7A+lrIU0iE7ZzAogX1cjWeqxxLIqAFTSSSMbBmZ
	 mKOojuQ9yODbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76301C83F21;
	Tue, 15 Jul 2025 11:45:27 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 15 Jul 2025 13:45:24 +0200
Subject: [PATCH v3] ARM: multi_v7_defconfig add /proc/config.gz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-arm-config_gz-v3-1-70c45c58e073@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAFM/dmgC/42OsQ6DIBRFf6VhLgYeAaVT/6NpGiqgb1AbMMRq/
 PeiiUmHDh3PcM69C4kuoIvkclpIcAkjDn0GcT6RujV94yjazAQYSCZAUxM6Wg+9x+bRzLS0Sqp
 KamOlJtl5Bedx2nu3e2Yfho6ObXDmqAimOABnwKqCMw2qpJxak9BeccKxqOet02Ich/DebyW+1
 f50t9EEh/DrcoIs+RKkFYL7p/xy13X9AOKiRacRAQAA
X-Change-ID: 20250329-arm-config_gz-7d656859ad59
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=I/3GWpsPLyZxKfX4eh27wP6dQGm331pGxZH6FdZ4teA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBodj9W1Yz3cTm9JWk9P85lh50y/5Kv/xLk26ysX
 2Rxj5JveFqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaHY/VgAKCRBgAj/E00kg
 cuobD/wL7Xc/x/i1TjsG3wLOosZX6Ym3M3YIs/KGdJ1dpZ4C+8S1K92MxZq67fbFz9jX5yw6nQM
 uNsI4SxHGe8g+Yd9/gJmeXjq7ZgP9iiEUj/YJhIEOtGlt89pVzZM/M403WYJQPBaIlBpO02v9VU
 pLv2u+fuFvX87llrbCTVE6KfMf1d/3b4Z3Vo3u9o9p+CSurcdwr2xXTZIwjK370Q5l0gdKl1BVG
 TTYf4npyOqG7mKEL0Gh+OFQXMaMO2hj9VkHcTQ0Z43V0BngoMgGpRVNt03J9LuLI/c/sSniTzZ9
 lBHwtMNpyHsndM4l6u/oNn/ThrMR8QwFfWDx+bCOvG6egWNMX9fFNdaQyWdUie76b3JTdev4jsk
 AUaymjvsAF6vaz9FqWDfGISe+ThDyRMOjvUBi4d89P6ywz9D8WrYSkWr2wSdns2k/6BaMU3hMLS
 /eYzXjyH8PXCWe04B7HYPkLFniUONWWsWJRVGiV6l3dnlaPv74uARAu3nvZGmmbrjEwZn4dOkaA
 /wgaR3MtBuLXG7DaYzYu745iXHml5QZTrl56JiTausvUvgAwiltz8PglLhTcdkUd2zmUOFYnJ2E
 gf1sCBeN/1MCPlU9hrCRqSX30xf9fquMckYUYpmdLSOUezvF5JaqFnsNbahwvK6eLTBvvTofU9F
 h7gJ+KIyowEj2rg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

While 32-bit ARM isn't that widespread, multi_v7_defconfig is used for
building more generic images, where having access to config can be handy.

arm64 and x86_64 already bundle config.gz, so this is an effort to provide
the same level of comfort with ARMv7 devices.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Rebased against next-20250715; otherwise, just a resend.
- Link to v2: https://lore.kernel.org/r/20250329-arm-config_gz-v2-1-f725d331fb5d@ixit.cz

Changes in v2:
- IKCONFIG is now module instead of built-in (Greg).
- Link to v1: https://lore.kernel.org/r/20230612210208.109267-1-david@ixit.cz
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 65df4014c4a603bfc6d5810cacf50f904321e9b2..5180c90cb5da1cfc91db39346c4b20d888e0a621 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=m
+CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y

---
base-commit: f2b1f6a9f382564b1d4cf16c45e73ccccb917f1f
change-id: 20250329-arm-config_gz-7d656859ad59

Best regards,
-- 
David Heidelberg <david@ixit.cz>



