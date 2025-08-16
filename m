Return-Path: <linux-kernel+bounces-772137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DEB28F24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0E17B60CF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883B2F60C9;
	Sat, 16 Aug 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C/iUMJzM"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64323AE93
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358148; cv=none; b=MJVJBAR9VZ5TF3pdopbZU89TbCbUnBcR2UiyJeI+w4JiPW+09zUGmQAf0xval0yfm858d2hB5TG1Estye6KKY/SnT5qEr0lGriixc0KU5dczggd0efY50vXbyTd6ssLaJsP2wIjLIdfrvIe2Z4urPZUq2UejhgNuBXbVMdCUjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358148; c=relaxed/simple;
	bh=31jnk17xwQ5OcsxD6Yenw63IC3R453Q2ssSYzpt08ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pbg+vB+NSLJU1eIMJ++O1VweKJTlRC+8b46flASYrZxGdFOUOTLpXBr9t0v0SWA5RCLAKrAKLswuJ2seS/UFy8qwRIET+jX6pcUg+cpjGF+mEY4DNWssF4i1ZgvDVbb5e0m1UviiE+VpCBPcaptVFsfgb2soU03dKqM1dU9+/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C/iUMJzM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755358142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nNPBiDarfiDwQJUO4w6F/uEq7gVni974MwnVOcFZyFw=;
	b=C/iUMJzMf0DeUsuZXtPiEMkR2iafIojulpEEKi3R2B2W6maHHEbOaJB1WHq9zJhlJfq87z
	5jhomeFUMsaoRlgXbwdsYnnthpbifob9fwbJIkLtTU335HHcW0XCNHZEDizhH3z22LPnMZ
	DdNMo+wr9vlkfRhWCmfqyyhl9CzgXPg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/common: Replace deprecated strcpy() with strscpy()
Date: Sat, 16 Aug 2025 17:28:18 +0200
Message-ID: <20250816152820.427784-2-thorsten.blum@linux.dev>
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
 arch/x86/kernel/cpu/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34a054181c4d..8aa170762cc7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -184,9 +184,9 @@ static void default_init(struct cpuinfo_x86 *c)
 	if (c->cpuid_level == -1) {
 		/* No cpuid. It must be an ancient CPU */
 		if (c->x86 == 4)
-			strcpy(c->x86_model_id, "486");
+			strscpy(c->x86_model_id, "486");
 		else if (c->x86 == 3)
-			strcpy(c->x86_model_id, "386");
+			strscpy(c->x86_model_id, "386");
 	}
 #endif
 }
@@ -2013,7 +2013,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 		const char *p;
 		p = table_lookup_model(c);
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strscpy(c->x86_model_id, p);
 		else
 			/* Last resort... */
 			sprintf(c->x86_model_id, "%02x/%02x",
-- 
2.50.1


