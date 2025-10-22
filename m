Return-Path: <linux-kernel+bounces-864284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21926BFA63E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA01A02B75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB22F39A1;
	Wed, 22 Oct 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry5qwBNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04372D8DA8;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116342; cv=none; b=enhggSZPJ+E3/zDvi4LQA14YC9tJFrinBuGNeSTShP5Z/wRffFWjcN2YThIVKNXsQ8HKLtWDMXatAEucZR8V0+sHslNoqkUj1E3MqRzcGMDoPOhvM4xqVW/dsGoo7HHnJnxtSRVxngu1+xBsBY4N542cga5w+1WuXDyzrAUG3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116342; c=relaxed/simple;
	bh=AD9HSHNdMY0OM9nnzoBOYxn8pv3LYh4EXRbZNlxGZDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H/j60JWFbhIXLbhVmaTnwOAyLQQj15NKrqgkdp+ZudYARlL/U9kzp0ltqygffsrLD1kfe7u9+eTmxFH7goPHqYrsVSUZXghiTtjT6B6Ycsshgh7Y6XSWIb8EUugf/M8LaQgMyg79Y6wo2dcfwFtAjqT0Dn9tP74U8mnhHWEYyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry5qwBNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56191C4CEE7;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761116342;
	bh=AD9HSHNdMY0OM9nnzoBOYxn8pv3LYh4EXRbZNlxGZDY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ry5qwBNtHUsVAtOGSQ6ItB9v1IFtHufldIsqgs6ywIA7XrEkDBKcd+r5ebFA4WMaw
	 aMKFf9ZfSU0gghPSPV+qTFLKVnTk3x4l2zxDjo3YM2NvD8SNl8w4yAHNJWCgmjWU8Y
	 4NjVy24kZLbVoZqw04Og476zfvkN7Ywb2e23c/YVutD/ZdeQRMuHhakNcUSofc8nc2
	 uAX40iJH6E8sgYsrHX+m1bcECsQCnXIO7ljbP5baBVA0tDUa3LCx2560cP5Wdc+NYd
	 0uCzxR99ufvjH4SrDDY5EN3Ubt5GLSyse4dgR9MGiPW3K59KV+qc4/os3Bsl7cOezt
	 Sh70XZGSBaACA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C5CCD195;
	Wed, 22 Oct 2025 06:59:02 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/3] clk: amlogic: optimize the PLL driver
Date: Wed, 22 Oct 2025 14:58:50 +0800
Message-Id: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqA+GgC/x3MywqAIBBA0V+JWSeo9P6VCCmdaqCHjBFR9O9Jy
 7O494GATBigSR5gPCnQvkWoNAE799uEglw0aKlzJbUUuz9opRuNXxbjmE5kUQ441qoqC5spiKV
 nHOn6r233vh/2hlFmZQAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761116340; l=880;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=AD9HSHNdMY0OM9nnzoBOYxn8pv3LYh4EXRbZNlxGZDY=;
 b=kxSqjlsNE/85yLqBjRjfLRykrNWn7ajZhDatN3y6+Uqup7ZGGj2wCQC38UPxyBoTzrGMwIpCI
 lqHa5F1aU8TANQvaBZLFNKRSHEx3VozY1u8BZQvzMATv8LCUjF0UH82
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

This patch series consists of three topics involving the amlogic PLL
driver:
- Fix out-of-range PLL frequency setting
- Optimize PLL enable timing
- Correct l_detect bit control

For easier review and management, these are submitted as a single
patch series.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (3):
      clk: amlogic: Fix out-of-range PLL frequency setting
      clk: amlogic: Optimize PLL enable timing
      clk: amlogic: Correct l_detect bit control

 drivers/clk/meson/a1-pll.c  |  1 +
 drivers/clk/meson/clk-pll.c | 76 ++++++++++++++++++++++++++++-----------------
 drivers/clk/meson/clk-pll.h |  2 ++
 3 files changed, 51 insertions(+), 28 deletions(-)
---
base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
change-id: 20251020-optimize_pll_driver-7bef91876c41

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



