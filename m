Return-Path: <linux-kernel+bounces-775046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C069B2BAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125095256B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A6264FB5;
	Tue, 19 Aug 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWMi/5jt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7pV7SV7Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9920B80D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588397; cv=none; b=XMVBbAAu8/yhu7kseWqP9+KEb0vo6z65l4HgvyXLWIQ247tG5ueBdR9WHwAJNKRTVQMfi8qEffuLd7Zp6kS3i+hYi8wW1XOErrWNIV3aHi+91ox9N5Mvi1mvWf4oCkuGfkowtP3LjYrPF51muPrnOUfLETfvcbM4XvcPj7a+mrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588397; c=relaxed/simple;
	bh=8DogFpm/7UItthaAKtL7JHhg0evTH9gBU7V2H5qf+ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PHBXaWsc73TASxgc0VOJGyGKiejZM9qxJTVXFdoLzSvIDGx+Qw6C+jPrdmDRZ/JZFROWhpQtfxjbNX97YX4GodSUXItGV9WgbegjLF2iE3AkmrVEWBVHU5k7AO8J130oOq+H5SvQ4g7MOa5oD285c8oMZhSHFooK/ALrkkhPlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWMi/5jt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7pV7SV7Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755588394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LCb/OtwNsCJ1AhM4OPv8lAr8Kr8EX0ivkGLFWUE9/KQ=;
	b=HWMi/5jt+SV/tiNbEraktGy6cpvKI5aF4tUODzlFvxmONYQdwA2Iv37BqJRk7hhoImjq2f
	WtLCafzefQ8Mc+wNzT2TwYqe1D+2Ibr9K5K9EUWZD7qydOA96q1uDdbW/7yk/cVnhzbVtJ
	7l9LcExUJTKh82atJH2oasMA1VJ/D5sK6z4eU1ly0j1kzzXYyhbz6+E6c1eAUhV5UJ1qaS
	Ekpmc/ZtCiJ9ZFrQbCiq4pB3/VudQ4PozBoImY+Fxqcj2bNW0Ov8143ADfRCMuAYJVWVSe
	g9Jx332coggfcFq/5UdnmaW6Pwx0E3VDbK5CT9Jhz+c+7m69LuFNwk2al9a1Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755588394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LCb/OtwNsCJ1AhM4OPv8lAr8Kr8EX0ivkGLFWUE9/KQ=;
	b=7pV7SV7ZvGl7P796Mla2CBYUS3CsE6IeX7tCDEj+vjNPZZCNLNRUTHRzAyiF5vjqYqjT4E
	hRhHbdbQS8WYRFDw==
Date: Tue, 19 Aug 2025 09:26:19 +0200
Subject: [PATCH] tools/nolibc: avoid error in dup2() if old fd equals new
 fd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250819-nolibc-dup2-einval-v1-1-d6c8308cdc50@linutronix.de>
X-B4-Tracking: v=1; b=H4sIABonpGgC/x3MQQqAIBBA0avIrBsoQbSuEi0sxxoICyUJxLsnL
 d/i/wKJIlOCSRSIlDnxFRqGTsB22LATsmsG2UvVm2HEcJ28buieWyJxyPZEI9XqndaOtIUW3pE
 8v/90Xmr9AFMYrHNkAAAA
X-Change-ID: 20250819-nolibc-dup2-einval-825bfd77de7a
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755588391; l=1199;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8DogFpm/7UItthaAKtL7JHhg0evTH9gBU7V2H5qf+ko=;
 b=PhKUg9UigkTEdBeqcNyStnbF/pWriylKt088MDH7E3DhHSOQrdNSjJn7Ju6P7dBMOis+EzAV1
 IKtSrnyORhSCVkEocYtz/HSrlIQy3Xpdf1e6RRURqac5kyDl0PxcW/g
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

dup2() allows both 'old' and 'new' to have the same value, which dup3()
does not. If libc dup2() is implemented through the dup3() system call,
then it would incorrectly fail in this case.

Avoid the error by handling old == new inside nolibc itself.

Fixes: 30ca20517ac1 ("tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34abadb7f9c7ca995012b4395b6830975..22a2e834861e618451ec678bd11101147dfa3a7d 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -238,6 +238,8 @@ static __attribute__((unused))
 int sys_dup2(int old, int new)
 {
 #if defined(__NR_dup3)
+	if (old == new)
+		return old;
 	return my_syscall3(__NR_dup3, old, new, 0);
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250819-nolibc-dup2-einval-825bfd77de7a

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


