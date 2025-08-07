Return-Path: <linux-kernel+bounces-758723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96EB1D327
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FAB16538C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134B230D35;
	Thu,  7 Aug 2025 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lln8OEvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664098F48
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551147; cv=none; b=FVitD7Nno4KWfdZ39V8eRslQvqF3KqsbkF/KwEbq9XItroae2FRA3LSSQDCaOF6b10/iwqibzoaGV/yKVOjoxdX5OFH7ceGTtrlIqxX+PBfJdLZRNDxAXASaj/aKbN3qVLDx+G4hE6pcEYKXCaY2kZ8VIByCnwKibAZV4j6M38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551147; c=relaxed/simple;
	bh=5W3eN28C5zYIrodwX3zckGt4s9fOCjzucNG8qbTTNnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSIiJpExgi+u6nfa7VDjrmbDao5fNC2IFsV4h7dbdsr/a13tCMrIUFU7b18sroP8WD+cJK1tBwX8mnSKV91caUyn2m8XsPgS8EY2wwMR0B7BdOCJd9cqB1DSFnFKTylJzUPSuKAeR6N+totcv11/P0KPrPGnsSTkwNrpd3/u52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lln8OEvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDEC4CEED;
	Thu,  7 Aug 2025 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551147;
	bh=5W3eN28C5zYIrodwX3zckGt4s9fOCjzucNG8qbTTNnY=;
	h=From:To:Cc:Subject:Date:From;
	b=Lln8OEvtE4EmZaUPkO/SuUQbXKikByck275Nph7310ezAasuJsthP4wwbCIXmWsSY
	 QORYwUisgs47VOjSy7ip510ENuaoknOU6q2van/WF2b/X6BpIA9fC9vSK3ggnqZ4R0
	 A4b50Y4vjMHPuxDiYxE3IKETWDD825uhU08viGVW9cKML7W1E34Blq15pl+jCqFV3d
	 v+wL9QCy97rl9BhLyYCv5SQYajCkIy/Y1hC7DpDEL6aGs5gGPzuUJ6GiMojMwTyi27
	 +AdmxD+rlNdNo04YsgojYRih/wcyeqgzJM2JEq0ocnjf+1UJRKBEOyuxyJm1xdDnEA
	 8NtbdlPW433dQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Li Huafei <lihuafei1@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Waleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: stacktrace: include asm/sections.h in asm/stacktrace.h
Date: Thu,  7 Aug 2025 09:18:58 +0200
Message-Id: <20250807071902.4077714-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The recent kstack erase changes appear to have uncovered an existing
issue with a missing header inclusion:

In file included from drivers/misc/lkdtm/kstack_erase.c:12:
In file included from include/linux/kstack_erase.h:16:
arch/arm/include/asm/stacktrace.h:48:21: error: call to undeclared function 'in_entry_text'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   48 |                 frame->ex_frame = in_entry_text(frame->pc);
      |                                   ^

Include asm/sections.h here so the compiler can see the in_entry_text()
declaration.

Fixes: 752ec621ef5c ("ARM: 9234/1: stacktrace: Avoid duplicate saving of exception PC value")
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/stacktrace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index f80a85b091d6..ba2f771cca23 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -2,8 +2,9 @@
 #ifndef __ASM_STACKTRACE_H
 #define __ASM_STACKTRACE_H
 
-#include <asm/ptrace.h>
 #include <linux/llist.h>
+#include <asm/ptrace.h>
+#include <asm/sections.h>
 
 struct stackframe {
 	/*
-- 
2.39.5


