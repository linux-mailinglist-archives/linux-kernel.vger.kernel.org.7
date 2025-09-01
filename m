Return-Path: <linux-kernel+bounces-794856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DEFB3E81C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DFB3AADBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBC33A01A;
	Mon,  1 Sep 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uooPNlsJ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BB21C17D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738942; cv=none; b=D9A/ptyCYdgyP1A4oH544wqrplBmL0XslY+EGWW7Uo6S5eqHPxEsPSG5Fc5DUTVtK1NRN7aa6VbWSm4ac4SZzmofUSBnY7NMFxrGrT5yR0NHKTvoZLMTi2kl0ljVaNFbcll4kmYXtxNxSzDBKKyz0YZR8S01DWw5DOyqWwYT9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738942; c=relaxed/simple;
	bh=U4OXJtvN8vRCBlMT6T7EqGLYf4Ogc0t2cuxAXm+kGdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9PSAs54cPuOSuKAzZ7PmFD+PgbnlUtkMckCi7gxrWE+3cHvz9lEkUmUOFuFRa2R83plHDZmh6FtYaI/3S7SiX7L03V6mGmpWdcSinNHv24KgbhGawFw816U/AdnYR8oovoE5NpAs6+6e8XHz+ggpmV/YEHhhrXQI9/RwlzPt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uooPNlsJ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756738938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nivWg6+wmlPawo9eOsWBpM889Z0+ZVfC6Vlz9wpOjtQ=;
	b=uooPNlsJRrVzcR2fbvTqXWWslvEJ4OLz9v29ZDCbtJw2pvhviQUi9/ENd9Sv8agGAHBhLq
	P6rOnrB7tSeg5rewGwvtGbQyHB0rafMTUqKhVAwGMKp/QFLKzLWrzPszDJXIjodDWr3cFC
	I97e2b2gab25NLgTZSqC51+NU+X2pzg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: scrub: replace max_t()/min_t() with clamp_t() in scrub_throttle_dev_io()
Date: Mon,  1 Sep 2025 17:01:44 +0200
Message-ID: <20250901150144.227149-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace max_t() followed by min_t() with a single clamp_t(). Manually
casting 'bwlimit / (16 * 1024 * 1024)' to u32 is also redundant when
using max_t(u32,,) or clamp_t(u32,,) and can be removed.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/btrfs/scrub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d10..ebfde24c0e42 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1369,8 +1369,7 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx, struct btrfs_device *d
 	 * Slice is divided into intervals when the IO is submitted, adjust by
 	 * bwlimit and maximum of 64 intervals.
 	 */
-	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
-	div = min_t(u32, 64, div);
+	div = clamp_t(u32, bwlimit / (16 * 1024 * 1024), 1, 64);
 
 	/* Start new epoch, set deadline */
 	now = ktime_get();
-- 
2.51.0


