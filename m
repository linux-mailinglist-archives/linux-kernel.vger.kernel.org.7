Return-Path: <linux-kernel+bounces-841430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC63BB74B2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC7319E0F12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA31A27B4FA;
	Fri,  3 Oct 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="azGIcTlq"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8A1E9B1C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504407; cv=none; b=nL6rgKdbb2zyjxgDF9yQ4z6Phc5Te+gvLNBA/opeyLcyRbx+Qof/QEiKbaW0yDI9Qqs9m/prkdFws9FW8N4PHXKcFGyfw8GwsO/ZVSV7XYPmjMhatGvhJPpFFfzLo8NliZ1nuXVDZ/PAvGrmpzUwxR8CLNlAgTQXskso1FiXzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504407; c=relaxed/simple;
	bh=vB6BD3+74H6PBZk5qiiyqgX55cMRHdfH4PdyGZzuCGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEuHbETCiFHgwdbjdnb0B+7Yw+LM4sSKcHPXcfnnUUnxSwgzzuzaaGzxTV1MTCeRMhnxmtyEM1sNJXYFWbTIkw6xVdC7LiZ7UITIemsOJIHuNUipk7Gibhf0MWVMAOu+ZpMM8YbnS8crE5GLatbufeksQBTM+712ucpBgjwUaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=azGIcTlq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [77.106.22.74])
	by mail.ispras.ru (Postfix) with ESMTPSA id A68114076196;
	Fri,  3 Oct 2025 15:13:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A68114076196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759504400;
	bh=HDByeUCiDwlLYQ/3uCoLDW7qZT2XQme1mO6pbvFE+JE=;
	h=From:To:Cc:Subject:Date:From;
	b=azGIcTlqn1iwvjg8G1ry3BBWr+L1KoaPvPvOZS5QD9A6KjhMgl6/s6ynTYOv8Hm0b
	 Nn6WL6b0/rpkoBdb7oW+V4l4cd2RfqmVdSWYHQtMDya/DKqlsH8XPJGjDeyP5yqSfv
	 oUSj4lSvT5n03yG/oJBf+F76cHZNP0uFQLVbaJ34=
From: Matvey Kovalev <matvey.kovalev@ispras.ru>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Matvey Kovalev <matvey.kovalev@ispras.ru>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] kdb: delete unexecuted if-block in kdb_get_kbd_char()
Date: Fri,  3 Oct 2025 18:12:02 +0300
Message-ID: <20251003151220.1580-1-matvey.kovalev@ispras.ru>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bits of scancode are dropped except 7 low-order ones.
So, scancode can't be equal 0xe0.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
---
 kernel/debug/kdb/kdb_keyboard.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3a74604fdb8a7..386d30e530b78 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -145,9 +145,6 @@ int kdb_get_kbd_char(void)
 		return CTRL('F');
 	}
 
-	if (scancode == 0xe0)
-		return -1;
-
 	/*
 	 * For Japanese 86/106 keyboards
 	 * 	See comment in drivers/char/pc_keyb.c.
-- 
2.43.0.windows.1


