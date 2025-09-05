Return-Path: <linux-kernel+bounces-803121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF0B45AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7651B27267
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443B37288C;
	Fri,  5 Sep 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BKogaLWt"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7A1FDE19
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083338; cv=none; b=pc0jNNhQdfYm19SFMbDXHwNwausNngfYpkOylsTyfhHfMw4i+TlP/0KrPmqqW/+zvvQW6h7na6FA6oNrBt9xePG7npgWiTqs4yTZulEPt9q1poqlgJPTm6D+C0umkebL0Wd5oQUES5reoG1cZ5eHa/WQGqys4gpEvbOwnZcnreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083338; c=relaxed/simple;
	bh=Icz7Wcc1AGeZPzlyfhEBEhEWDqL8AjGxC5hvDsKiUtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gA0RZRZQtUPpY08QqMKLE6xQWbq92r6IMA/FVaATC/Uo2DHH9/5qO3D3AIg5w/rnuWotnCd7dG42Fo7lX+q8SLAS0qOMtc7VDIwgfFrPNxR1wcMMorvM6/Ka4NhUmMgnBeMT7JbQmlzdI6dOsxJDrmGTyTu5gONy6ts4Uik54To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=BKogaLWt; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5394080903;
	Fri, 05 Sep 2025 17:42:13 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:181::1:23])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1gjcva4GjSw0-D1ZPA6Kc;
	Fri, 05 Sep 2025 17:42:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757083333;
	bh=JY5XN8+c2SurY+f8DuK+Uot3xNUS29NLrgFhRn+6cjU=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=BKogaLWtZhWtRfbQRWm06V7zgCFelzgNNynEXxu+Dtsu2Sd98zYf8cOMXGoPaXbI/
	 Y9TODkUuTFiIfR85HWmm9JOYceWC6G06fGeUQTZqqOa/+3QVB7gyuRgQWE5Jqnxgdm
	 YJhkTRvuZuB243ZUzkWje1Xr0023T1oVmhkYiYqo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 2/2] printk_ringbuffer: allow one data block to occupy the entire data ring
Date: Fri,  5 Sep 2025 17:41:52 +0300
Message-Id: <20250905144152.9137-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer require a trailing id at the end of the data ring, so
there is no reason to check that one fits.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 kernel/printk/printk_ringbuffer.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 99989a9ce4b4..cbbd356b085b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -397,21 +397,14 @@ static unsigned int to_blk_size(unsigned int size)
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
-	struct prb_data_block *db = NULL;
-
 	if (size == 0)
 		return true;
 
 	/*
 	 * Ensure the alignment padded size could possibly fit in the data
-	 * array. The largest possible data block must still leave room for
-	 * at least the ID of the next block.
+	 * array.
 	 */
-	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
-		return false;
-
-	return true;
+	return (to_blk_size(size) <= DATA_SIZE(data_ring));
 }
 
 /* Query the state of a descriptor. */
-- 
2.43.0


