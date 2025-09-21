Return-Path: <linux-kernel+bounces-826118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E1B8D936
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C8B189E505
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAB258EFF;
	Sun, 21 Sep 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="g1FjR9Hb"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC082258EE8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449053; cv=none; b=Pq4lzRAXDDOR3QH5O1qM2fr/XufC/4oj3I+tY0xjruSmR4MU9eCJ3tS50T7swsK/0XoKxKeXIYRnS4DoQB9lObPuGGLfYHPh4OFfQf6k47b1skAyV67i/I03IKL5bKcv4bXFIVcCHnoe7xShg2Kwb9q6pbk9rozZA7CuIA6g4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449053; c=relaxed/simple;
	bh=SWqFgK204o4QyeApxPuxKaeEjF4rYueIw/6iwMZINIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1oEVZCKGslr/2DlkUOTV5vQFATRQcCXLGTRbkN1D002c9Mh8Gfackkp96l0JXETPzS+d8susKVj/pLujojs27JSHSfpz4wYTB1fpyzCj/shAhQGodksDCnNR8MIBGvm9O368efd081s+1fVbDNnUy59BwZ2qWofkMhTXCHkcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=g1FjR9Hb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cV1zk4ZWHz9smL;
	Sun, 21 Sep 2025 12:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1758449042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bQYFd+v+6gZA2rLVuPuYuEyKvPeB7/eZGPToUqaOUQ=;
	b=g1FjR9Hb5KLxZIrK4r9vzq/Nv4yWrF4BlDZ8a5ddgmMV5CxlhfIth6pkzyQrmwewCBJovB
	WdOQCBs7Y8njgn9r/TnBUe4WSC7EeJ7e6aYDKmavxEWsDWgO6QNTdM1jr8ToBF3XRbL1hM
	z3MBIHxEPJkoGslNAHKY20ZJ9gPp/CBym7cCweOzPYJ/LLEd14FN+OxokG/JmSmN4mNcM6
	/9w1hiSaqIozbA6gViSqF/P1GAoZsOtE9sdvw3sWko+800tMtM5D92/rwErkkqxPtBnGEC
	3vgNxNmc6+9dcFPYxt+QoJfqVJNHFa2r2Q9fW1CmeuC4d7lYqOEtzoFivrAFeg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/2] scripts/faddr2line:use /usr/bin/env bash for portability
Date: Sun, 21 Sep 2025 12:03:57 +0200
Message-ID: <20250921100358.19986-2-kernel@pankajraghav.com>
In-Reply-To: <20250921100358.19986-1-kernel@pankajraghav.com>
References: <20250921100358.19986-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cV1zk4ZWHz9smL

From: Pankaj Raghav <p.raghav@samsung.com>

The shebang `#!/bin/bash` assumes a fixed path for the bash interpreter.
This path does not exist on some systems, such as NixOS, causing the
script to fail.

Replace `/bin/bash` with the more portable `#!/usr/bin/env bash`.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6beef9f97..966e98197dbf 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Translate stack dump function offsets.
-- 
2.50.1


