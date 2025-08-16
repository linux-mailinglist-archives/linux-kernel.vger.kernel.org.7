Return-Path: <linux-kernel+bounces-772074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF12B28E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50B7189A971
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A76B2EAB6E;
	Sat, 16 Aug 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9Whfvkk"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6338462
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755354881; cv=none; b=T9FXK/5dyjPl6aX3Pydzu8Mse6ii/ouH9QcxqLaR/4vVsIg4DSbp4Cc95JoUGJJs6d+TdDePR0xvCD3DDtrzy7LAfppwkltF33eGnqYgIHFC0BHDvt7KTe+12HS+0qWdXTpm1mOMk39IYMUJ/OzJxpw7f5tEoRb4fQjenAh/K7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755354881; c=relaxed/simple;
	bh=/m4r4n3DCZDR+D/6soZNQEByd1DUSGxRVldlxW9knvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NY8+d2+9uYpWKOW3G6a9X/5gr507Q1fho1zkdSL450RniwrzhUO94d3AjWnn2bwF5avjoKG0+BeITVXY7MCk99ijB/FRv25gN7K1mXc891fYbLWeAQzeMyFqPt4dRe1sv2AE8rwzLDi7XHu+5lj+r3uC/wp2BrY2KwDqglG1rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9Whfvkk; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755354875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YH+CcFBJex3jqbOvIAk2XxbUjPkJEFpmgZTAWcKZ2z4=;
	b=t9Whfvkk2edENZLRYuepgC78Ip8+s6VoU0LVVa6K8IBr81forbQ2iMYiD9Sz+rtYucqOa2
	cJBOV35HEyw9/Bw1lVM2UXuq/tTn5aNKTLeCOrk34/pZGTYWtKtpZCnn6RlQ3LYgsZaC5y
	u7ypb0o29qN/CZK8pkmqIaLwFT2AYr8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/intel: Replace deprecated strcpy() in init_intel()
Date: Sat, 16 Aug 2025 16:32:08 +0200
Message-ID: <20250816143208.386842-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Note: I already submitted this in April as part of another patch [1]
which doesn't apply anymore. Submitting this again as a separate patch.
[1]: https://lore.kernel.org/lkml/20250425074917.1531-3-thorsten.blum@linux.dev/
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..c4ea3325d3e7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -607,7 +607,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		}
 
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strscpy(c->x86_model_id, p);
 	}
 #endif
 
-- 
2.50.1


