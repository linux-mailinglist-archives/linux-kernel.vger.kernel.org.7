Return-Path: <linux-kernel+bounces-779196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD60B2F051
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B45A21928
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D92EA484;
	Thu, 21 Aug 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWXX3/U6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9zk31Atz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2C2EA14A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763013; cv=none; b=l9gZIYvCbpg56ehUwQ8FpkFlKgmSdVjpPD/M/H/ZVKQ+Wk/svZbCK1utKT3b3NSFCnWATU6HK6A7FN/39sCg4TfoQQkVPhx+QKXTimO5x0kSwAT+WTGcOCoqrT4hWNL/1LXugUEWBhamM8A5ZKCoKhCSfyzjcaNEQuHdx5AapCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763013; c=relaxed/simple;
	bh=D/12OQ8vo23/Cq4trcCIK/F1NjLqR+YjyfQAZanzypg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXRlAYrTK/HNHosATSeR3oZmQNsh/3pQXIM3Pmxzsi0U294mmAeyiOqOzyGNjrDqhyrhEFxkiBg7Je8Npq+5rfXAuljfNFqs4DHt8jmIwaWw5/7CH4hj2J6P1vzvXwQuJ5XHh6R/h08AYFqswfl2f+9ZKGHUjwYfR3RffpNJd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWXX3/U6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9zk31Atz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755763010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKpe3z5G5wNg83hukDMWCPcV+/73KXkYMZGFSKYmlXc=;
	b=IWXX3/U6I7+HHr++GdGynma55/AkGgR1sm30+k+ENj1HdEFP04/N2xFo3VxFBXdNyWRKHf
	c4XJBTnY0iOBTUrLVwbBesiNo7pBwvnO5ufuQarcV5ljDTYujVA8Y/VQsniE9h27dgnuJ3
	0VJ4eVTsqU0f+m8oDe/HOIO/Vc/rDBthT1PCnBQ1MdOrdBGtsH0WHfEFUR4JTKMN8reEYu
	FNl0RnpUdX408EvNfEwU/RrzO2HIxgRUuJ0wbARP+WYcuOVafUJLWf6da2xR5JVV9JYS7R
	mGAl3m8m+zDkWmj3bnaWYw8QAxjR72SLEph+rk9FH1HiGLZ/YRMa3BIb3yy+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755763010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKpe3z5G5wNg83hukDMWCPcV+/73KXkYMZGFSKYmlXc=;
	b=9zk31AtzpdmPxaTFSQUbw+mBH1MWo2IADY3PWWNi9m1UfpZKEJKwFxlnLwl2ItR7AGZdaJ
	JEB58TfQDYMEAzBw==
Date: Thu, 21 Aug 2025 09:56:46 +0200
Subject: [PATCH 3/3] arm64: vdso32: Respect -Werror from kbuild
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-vdso-arm64-compat-bitsperlong-v1-3-700bcabe7732@linutronix.de>
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: John Stultz <jstultz@google.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755763005; l=1019;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=D/12OQ8vo23/Cq4trcCIK/F1NjLqR+YjyfQAZanzypg=;
 b=UOnKhtIauSWminqVFhBdCB8SbfiQ8ZETo2KzSj4wDnSfKf2vZnopjrVJZNjn8WlU80go3kso5
 ShCCXhPMl/yBtMt3LrSOHvneDqpjioh+1OUKnhXObFwLaaGdUenORfV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The compiler flags for the compat vDSO are built manually as they are not
compatible with the ones from kbuild. CONFIG_WERROR is not respected.

Explicitly inherit -Werror from kbuild.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso32/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index fd80123bc8e620d868040a61244e83575d855e35..5de4deaf42992046463963df193de47cd07ec1ae 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -61,6 +61,7 @@ VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
+               $(filter -Werror,$(KBUILD_CPPFLAGS)) \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
                -std=gnu11

-- 
2.50.1


