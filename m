Return-Path: <linux-kernel+bounces-881270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B7C27E08
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EE714E5BDF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C1A2F7AAF;
	Sat,  1 Nov 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3HmYtja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53B2F693D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000192; cv=none; b=cY59PgHSAOyH3UIkES/dZoPtglrQMd6joCK5m2wSKKUtR7ovzWOWKoZzySLZI4OUU3NHHFbj++IHvqqkRsiLflLSNyPvL02KNGajyEKhH+KuzLyJWZ/kdOCFAzDvw9b2Z0uLaAKFk08MYJ42Af3LcmXOw79mtBtKC9dvd954h98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000192; c=relaxed/simple;
	bh=7Pp2Ea1CXxsRy/fcar0zlvWA5a/+LYAssggYWeY/GOg=;
	h=Message-ID:From:To:Cc:Subject:Date; b=lOF+e3UZ1ItFYCfbnLzF0o+/DETk+1oA7s7d3BzeVLkyMgsl38dMQ/xFrQEvC857zqmDax5c4LM50eo4Qyhl0TiaCUDzAmZe0UfK3UmAOH12uWc51SSwgsO1tvA3OMzCe5nFJ+VSz8oKdRbBgXoovpgIxJB2N0e6cC+vCN1bqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3HmYtja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0707C4CEF7;
	Sat,  1 Nov 2025 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762000190;
	bh=7Pp2Ea1CXxsRy/fcar0zlvWA5a/+LYAssggYWeY/GOg=;
	h=From:To:Cc:Subject:Date:From;
	b=N3HmYtjazJ3d/8MO76yTz3QfPQEpOGDJXqNigbPQye3ZvzAz6IlVzhVYrC+zDhU2Z
	 /b7Pq04MIqjYDK5FKBidqCD0a7FeaBQXojba30giPAo0JHs4l9hZ9aRd318OkzS6xQ
	 js/WFo1emBQ0pVqhKv+cByESt7SOdoSAJR4sOpC+8/FIJIFnnDT/9Xo5TJWe6M9Ig+
	 6MyHIlQa3QQ0lQqfU6G2qy9n/+dvdhF0UPGp0PqkeQ9FBEEC0BalPSSgFcJZV5mkOb
	 kDchQ2GfXx2VW8BJqjb2HuNKm79Rcz5b5VQn+e0lvoOty0o8ho+EFYn/481qL/JvGt
	 /1faKoTKRxaPQ==
Message-ID: <08892eea9f05f802e60bbda49e27bc59@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.18-rc3
Date: Sat, 01 Nov 2025 12:29:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.18-rc3

for you to fetch changes up to 48cbf50531d8eca15b8a811717afdebb8677de9b:

  regmap: irq: Correct documentation of wake_invert flag (2025-10-28 15:17:36 +0000)

----------------------------------------------------------------
regmap: Fixes for v6.18

One documentation fix and a fix for a problem with the slimbus regmap
which was uncovered by some changes in one of the drivers.

----------------------------------------------------------------
Alexey Klimov (1):
      regmap: slimbus: fix bus_context pointer in regmap init calls

Shawn Guo (1):
      regmap: irq: Correct documentation of wake_invert flag

 drivers/base/regmap/regmap-slimbus.c | 6 ++----
 include/linux/regmap.h               | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

