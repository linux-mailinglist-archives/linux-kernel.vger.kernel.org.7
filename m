Return-Path: <linux-kernel+bounces-712928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF7AF10AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996E0189BB2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B31D23C8C7;
	Wed,  2 Jul 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YADsAsdq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z1nffVr6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C9248861
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449954; cv=none; b=UEmZZpAKEuk7FmQ4esUco93k0BjOT3K7YEc+lmi7WzwcA//+ChY0vKJ32fSwXaqJ2NGjVho/d0dry4b8FCcIduxx7tCUFzevsfxm1VwttR4u1UK9+c4aoylBQhPoVLoojovfIhW+dGi3pu2AGj/WIMUMwHsydXLRmEwm8W1zc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449954; c=relaxed/simple;
	bh=3hyGAsEtpD97Hw9klU5GEA2j7HZbyfZUXeSJFlVFLHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/mkRRP5mQdkdVJXgEP9wROM+z1ah/uw0sCLnhsmEkdO40Gp2JZfioW1Idq6ZCYyFFR08L/zUfpfik/LAtLtMCSXPHPW36UAvGAD528LcUXiRhkjyCoh7SWaOGl8vDNs9s3kSwV/cETMs3ll83h8P+5c6E+DDZQWQ7XJ1bY+Nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YADsAsdq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z1nffVr6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 13E001F454;
	Wed,  2 Jul 2025 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVF0DFzYVjObkXBxp9UHHYRDAqZk/kF6Z4sTd3Ymd4w=;
	b=YADsAsdqZQooJDTQNIUJ8qce85SPhZyRGHjk4BNnw057R6mpasS6SJ4NNuqzn829tD2NU/
	i1i8K8/ZtNE1qIECyI41WMvIbk9N/bxXp6buCfRC6hVt41U9JMDlDpQlQIsthbAGa7IHmD
	i38U8Gitr9KooqkeosmPh/l8QKAikh4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVF0DFzYVjObkXBxp9UHHYRDAqZk/kF6Z4sTd3Ymd4w=;
	b=Z1nffVr6YBqytQG+ZmIf01mErrz6g4QIW1U24VHtg5vKLn9UEML40qhDA6l6ITzuXrtA9X
	t5rMDDQDQwjOuJyjvELqFPLo/rE/iP9MIdme08vXDM4TlO3rrgtUKhNekg/ySlnd4SmPYs
	+QVlosgqsqeQ3oYbD8O3+ZPjl/Ao0VQ=
From: Petr Mladek <pmladek@suse.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] printk: ringbuffer: Explain why the KUnit test ignores failed writes
Date: Wed,  2 Jul 2025 11:51:55 +0200
Message-ID: <20250702095157.110916-2-pmladek@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pathway.suse.cz:helo,suse.com:email,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

The KUnit test ignores prb_reserve() failures on purpose. It tries
to push the ringbuffer beyond limits.

Note that it is a know problem that writes might fail in this situation.
printk() tries to prevent this problem by:

  + allocating big enough data buffer, see log_buf_add_cpu().

  + allocating enough descriptors by using small enough average
    record, see PRB_AVGBITS.

  + storing the record with disabled interrupts, see vprintk_store().

Also the amount of printk() messages is always somehow bound in
practice. And they are serialized when they are printed from
many CPUs on purpose, for example, when printing backtraces.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer_kunit_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index 4081ae051d8e..217dcc14670c 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -123,6 +123,19 @@ static int prbtest_writer(void *data)
 		/* specify the text sizes for reservation */
 		prb_rec_init_wr(&r, record_size);
 
+		/*
+		 * Reservation can fail if:
+		 *
+		 *      - No free descriptor is available.
+		 *      - The buffer is full, and the oldest record is reserved
+		 *        but not yet committed.
+		 *
+		 * It actually happens in this test because all CPUs are trying
+		 * to write an unbounded number of messages in a tight loop.
+		 * These failures are intentionally ignored because this test
+		 * focuses on races, ringbuffer consistency, and pushing system
+		 * usability limits.
+		 */
 		if (prb_reserve(&e, tr->test_data->ringbuffer, &r)) {
 			r.info->text_len = record_size;
 
-- 
2.50.0


