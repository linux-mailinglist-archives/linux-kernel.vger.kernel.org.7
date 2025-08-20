Return-Path: <linux-kernel+bounces-777195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA8B2D69B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B5718993A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E72D9EF6;
	Wed, 20 Aug 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtl47Uif";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNZz2pdo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7D2DE6FF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678584; cv=none; b=Of4Gjg0FMUlyDD0g2FDzLU/I+6ndsj4PcVJeMfgQm01ZZsrxH1SQWPq+QaqQfsADgIS5TvxAAFcaCgDl0ne5K3EHUl18bv2y/XtlfYuzlDr22z+MbXOlYbHRf/Laryls1w5HB5a1gIDm1qBWpqiROFGFslC/oodbbu61avHF+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678584; c=relaxed/simple;
	bh=O2TwQOQ5/wk+OrIFst9Ecw8ojiLYbtDhnq3dpxRObow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JICkrzg9KnQdzeSyjzJyx74FpX0F89lWHKGcFeV4SaMO4DWANPBm9wZdLnWWxACwZxfCH3YsFuSwEjmigNS6+X1hVkxBoBbsXk+utyXvX8oyajeL0jvJa3OgfDTa+Xd7dCa38HL+WwWHVvwcRFowREz7p4Xw8vMl0i1uwvt+XH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtl47Uif; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNZz2pdo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755678580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RKAVO5aewhxEdxhtS0c+zjuQd0KhAW7koGUue2X2YUM=;
	b=rtl47UifNF6jdcBnVfuqMwY4qBFEOmPa0wjWjrWSFD3IRdM2QKOWH8myP1fTOKiaKMjUw8
	oLSRZExO/yZC1Bp3R02TdyHf8r/nNsiI9ippzpesv/5G5zjMhQZFHz01R15J19u9l+ql9c
	VtLKSLUcKQkTawFH4IGsY3K7rT0/KFugQq3sJGfOczxA2TjCUzP05BdcSa6uolAD6rE1bO
	Hj4Le/YoMDuZ+/UQUG7LKwAMvNXahcvAMA77TypubC7DYjviVy65UdbfYEAvEiH5AyiqK6
	p8nSFM6hY5sE8noOvmFX8KNzetfrnzWl5UXEiGYelpTyKnfT7Gn/xbOmk5MDJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755678580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RKAVO5aewhxEdxhtS0c+zjuQd0KhAW7koGUue2X2YUM=;
	b=qNZz2pdoelGS/l+JJEdtzU/Hd0FeGdEO/vg2+iolGxBaz0HmU32rMRuOGIvh49yiLpOyB9
	ZrwzEAozK20xiuCw==
Date: Wed, 20 Aug 2025 10:29:27 +0200
Subject: [PATCH v2] tools/nolibc: avoid error in dup2() if old fd equals
 new fd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-nolibc-dup2-einval-v2-1-807185a45c56@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGaHpWgC/32NQQ6CMBBFr0Jm7Zi2BqmuvIdhAZ1BJiGtaaHBE
 O5u5QAu30v++xskjsIJ7tUGkbMkCb6AOVXgxs6/GIUKg1GmVlbf0IdJeoe0vA2y+NxNaE3dD9Q
 0xE0HZfiOPMh6RJ9t4VHSHOLn+Mj6Z//mskaNdHX2oqwjV6vHJH6ZY/Cynomh3ff9C52hcwa4A
 AAA
X-Change-ID: 20250819-nolibc-dup2-einval-825bfd77de7a
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678578; l=1459;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=O2TwQOQ5/wk+OrIFst9Ecw8ojiLYbtDhnq3dpxRObow=;
 b=65UubdQPjmg7HOLmK+0FnlKpMPbG0u9dtv2/wJ9A6aZfPUQ688f6pt4QtIHL7g1oPAddt/qah
 Sjm912IC/yNCjZAMHCC9Z10c/wOh75aarvriolo+g2kSXpjSf7G0sKV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

dup2() allows both 'old' and 'new' to have the same value, which dup3()
does not. If libc dup2() is implemented through the dup3() system call,
then it would incorrectly fail in this case.

Avoid the error by handling old == new explicitly.

Fixes: 30ca20517ac1 ("tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Correctly handle the case where 'old' is invalid
- Link to v1: https://lore.kernel.org/r/20250819-nolibc-dup2-einval-v1-1-d6c8308cdc50@linutronix.de
---
 tools/include/nolibc/sys.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34abadb7f9c7ca995012b4395b6830975..8aed6c5f00a9186b943e388f9d5f702412c77dd2 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -238,6 +238,13 @@ static __attribute__((unused))
 int sys_dup2(int old, int new)
 {
 #if defined(__NR_dup3)
+	int ret;
+
+	if (old == new) {
+		ret = my_syscall2(__NR_fcntl, old, F_GETFD);
+		return ret < 0 ? ret : old;
+	}
+
 	return my_syscall3(__NR_dup3, old, new, 0);
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250819-nolibc-dup2-einval-825bfd77de7a

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


