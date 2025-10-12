Return-Path: <linux-kernel+bounces-849753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E7BD0CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2A734E64F7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B362566E2;
	Sun, 12 Oct 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LV+xpeWm"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CE2417E0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304272; cv=none; b=bSg8SiOXniywT/E/fTRFSBjuBI+mtPvEYpCJsc0CGjh6/F785Bs5eNuBW8gbblWk0xKIbi6faSVpYJfWyB1SbXXGbttg9xw04IB27alipuNvUpgWgNaTXNaYpgx9bTamS7DD1q825TlfHOgzC8G8PeOnMNfypFLWpvPuB1zD9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304272; c=relaxed/simple;
	bh=E+NwvqNKQPDoP9IOTvsJFY6yXIqEEdE6aOeCoA+Zpx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfQLfasqHYgF//vB0NRgI3tWr+hdhLHf3feXwgrHDw2t/DVpEPOt8KIMGpGb4sd9j5iXwJ4iheM+Oo/xhQzPjDsPo0Q3pccldmEXpHMRtPYSusXC236z2Fz8Yu1sGNRK11FRbG4We4PEo9Xz2IttPEmSjSqyQeEwDjkkTzKV4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LV+xpeWm; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skKjuSA1gxdZITVYhcLcHqL1gW6SF0W1jTkGYAWJENk=;
	b=LV+xpeWmDI8jczSpK7VvTtMCj5UK0oURcm211GlIOCd4gmUL6nryJ+bloY5oUraNjMnaxS
	R1H4rm4XSxex1Fij2H8rv1tUBpi7i+bSup4e8LnOHpeDJV/P9Hq7xcfTBRqNpi/8+9MvRD
	9gy0S2OojoxesRDXQww7GPyvSNDePWM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	NeilBrown <neil@brown.name>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 6/8] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Date: Sun, 12 Oct 2025 17:24:09 -0400
Message-ID: <20251012212414.3225948-7-kent.overstreet@linux.dev>
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Give these config options names so that they show up under the "Library
routines" kernel configuration menu, and can be enabled by
distributions.

These libraries are needed for bcachefs to be built out of tree.

Per Neal - "the proposed change seems appropriate in that it makes our
code more available and hence more useful.  It has no apparent cost and
I can (now) see no better way to achieve a comparable outcome."

These libraries are both for RAID5/6.

Reviewed-By: NeilBrown <neil@brown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 crypto/Kconfig | 2 +-
 lib/Kconfig    | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 23bd98981ae8..da4f072abae0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -3,7 +3,7 @@
 # Generic algorithms support
 #
 config XOR_BLOCKS
-	tristate
+	tristate "Accelerated block xor algorithm"
 
 #
 # async_tx api: hardware offloaded memory transfer/transform support
diff --git a/lib/Kconfig b/lib/Kconfig
index badcb5ca9efd..e831f4462453 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -9,7 +9,9 @@ config BINARY_PRINTF
 menu "Library routines"
 
 config RAID6_PQ
-	tristate
+	tristate "Reed-solomon RAID5/6 algorithms"
+	help
+	  Provides routines for block level reed-solomon, for RAID5/6
 
 config RAID6_PQ_BENCHMARK
 	bool "Automatically choose fastest RAID6 PQ functions"
-- 
2.51.0


