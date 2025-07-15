Return-Path: <linux-kernel+bounces-731277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2EBB05216
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB24E2C48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAF1E1A17;
	Tue, 15 Jul 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LmxAEIap"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03319ABC6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561919; cv=none; b=Gb5FQkyW94yTCa+7tKKbm1m3O7USkNth++2HdQko2m94BXMZDS0GbLeoIIRdNQYF6WjEW6N8GIbjcSFve8p7tKSzV+wrkHKDJzS24GaIx4aX0yrfUkYgF58GKQqTffB7f7B2tMCgMZ5Go75qPsOLSSBqMWt51mlw+qfOMZT5Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561919; c=relaxed/simple;
	bh=IEbgbGA4sOfzZc5NT4bgmXsRlsWq4nI6BWijQyrP8vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFpOtXMeHjdjyrYErq2M0Se9R4LNiNq4yk8rLxvKUUScBvk+kXqY35nZG647yv/rJzVhYSucWtyY0bkafWTxLewTZ5kG3A+S8BeMgGJXaBFAKxPnBzKNPuZq63Hm1HqibMj4tgqPj0zoG7Yc4EJDfMul8qrRauSXJ+2K55+Lfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LmxAEIap; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56F6ibV8807579
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 14 Jul 2025 23:44:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56F6ibV8807579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752561882;
	bh=agsy2BRFVzJLcy+SHG6uUVC0KzT0EstGzfXNVH6PpaY=;
	h=From:To:Cc:Subject:Date:From;
	b=LmxAEIap30yukfT/bo3MVXKMN3BK2VUv0MglyLgauZCTJNBNkiqnld+R+g+xkjyDe
	 kgZDWXosba9TSZuo0uQVwlH+L7mrWiPzFhW2ndE82GVugrftNk7UD4gALAeCPD0mrQ
	 jXjZkovwaqFJwL3PK3mss1o6USUqc3zY3HuW4+5pwo6Vlnu0/IbPGNKissUXqRXaGN
	 NoWwQD5bQSKYSwVij3ZvRCFk65VoisV4Z9IVhklbuUDPoJ3/Ind2lnO7q9Ro0NQLDX
	 En5nIvJ6NMs0C316NGKfW7LdPIfieWDYuL3YIr831iE2ukzfi2mDPHDaLLGz0N0+PA
	 ZQ3AkStbnD17A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmill@asu.edu, peterz@infradead.org, andrew.cooper3@citrix.com
Subject: [PATCH v1 1/1] x86/fred: Remove ENDBR64 from FRED entry points
Date: Mon, 14 Jul 2025 23:44:37 -0700
Message-ID: <20250715064437.807569-1-xin@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FRED specification v9.0 states that there is no need for FRED
event handlers to begin with ENDBR64, because in the presence of
supervisor indirect branch tracking, FRED event delivery does not
enter the WAIT_FOR_ENDBRANCH state.

As a result, remove ENDBR64 from FRED entry points.

Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
never be used for indirect calls to suppress an objtool warning.

This change implies that any indirect CALL/JMP to FRED entry points
causes #CP in the presence of supervisor indirect branch tracking.

Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
from Arizona State University whose work led to this change.

Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: Jennifer Miller <jmill@asu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/entry/entry_64_fred.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 29c5c32c16c3..907bd233c6c1 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -16,7 +16,7 @@
 
 .macro FRED_ENTER
 	UNWIND_HINT_END_OF_STACK
-	ENDBR
+	ANNOTATE_NOENDBR
 	PUSH_AND_CLEAR_REGS
 	movq	%rsp, %rdi	/* %rdi -> pt_regs */
 .endm
-- 
2.50.1


