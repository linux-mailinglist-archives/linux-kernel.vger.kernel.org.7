Return-Path: <linux-kernel+bounces-757138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6FB1BE30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F318A1945
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D513957E;
	Wed,  6 Aug 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KIf78Jsp"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF786334
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442626; cv=none; b=REa3C1eEj9fH/5+SMfqlZxXhguDqYjiXoFL/OjaAkvVOViLSPJn1rw6o34aKO9QQOuETYMix1qEsQQtkXIRaGn0lbqdmcm8O10zoXdSKQFzRsD7/wMkePqrMuU1F8bI6xJSTdtidJqzJQ/3VMURyJajapup3nGbah8P7WrqbF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442626; c=relaxed/simple;
	bh=0DVPw6O45AkUZvlXgh5UxLzYAIkyrauQJO2LLg6jfAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSetLHIUZCCwCf1NwLIMLCOtAy9A0FBN8qOw5vP4GG6XPNw0UzsOsgo3DhqdmOnlmXBEWiBeaRiGGixUQ7zQbUVyTR+XLPjAghGF+BQ1jIxHI04jBHuAk83SBQIxjXut6nhH3L8nIDKnPBjXHdFQS0eMA4v9bYH9TZhVWz1lgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KIf78Jsp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754442622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pg+CB8rchBFVimAHaKPBm1B8BHU3IpcAVyad+HNZZ+Q=;
	b=KIf78Jspc/VfghXIDY12PjKgHGzsDl1NesqMgJm6ZnVrjOeWM8PsgFF9TQ4Qpg5VzEl3Is
	7dpxemTY+8iVZIcyjzW4vtPNtI2wNmUAP8s0g2yyBT79BRxuBA9QlBYMUY6nqcRua4CZ3a
	/r5ff+W1nqnc3//K6yu6y/jlEQQF8T0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
Date: Wed,  6 Aug 2025 03:10:01 +0200
Message-ID: <20250806011000.62482-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 5304877936c0 ("NFSD: Fix strncpy() fortify warning") replaced
strncpy(,, sizeof(..)) with strlcpy(,, sizeof(..) - 1), but strlcpy()
already guaranteed NUL-termination of the destination buffer and
subtracting one byte potentially truncated the source string.

The incorrect size was then carried over in commit 72f78ae00a8e ("NFSD:
move from strlcpy with unused retval to strscpy") when switching from
strlcpy() to strscpy().

Fix this off-by-one error by using the full size of the destination
buffer again.

Cc: stable@vger.kernel.org
Fixes: 5304877936c0 ("NFSD: Fix strncpy() fortify warning")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use three parameter variant of strscpy() for easier backporting
- Link to v1: https://lore.kernel.org/lkml/20250805175302.29386-2-thorsten.blum@linux.dev/
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..954543e92988 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1469,7 +1469,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		return 0;
 	}
 	if (work) {
-		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
+		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
-- 
2.50.1


