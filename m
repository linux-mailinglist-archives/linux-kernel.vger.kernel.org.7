Return-Path: <linux-kernel+bounces-870243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991EC0A43C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381E818A121B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08FA26E6EA;
	Sun, 26 Oct 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SJWTcwSZ"
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217C1EDA2B
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761464525; cv=none; b=owQFC6hrc+XX8iQFNjZOua1GSyEz9M6yFVx7FHHsIeNjGRFJmkA0pkoIlTanh+0Jk3oQJ5B4XYiZUlGLCDOLPnNbO7x7qBVvXkWlj1FvTrqLNrdUSd/kaDlBR3Kpegc4EjJre/G2XuDx7gHPRS2NAxXjpX/B+DipucZ9ICSGS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761464525; c=relaxed/simple;
	bh=nBsmSQFi+vaIAicJvhip5z+1yFa/mkWHTlFBtfY7AUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCyUhIj5erxSs1jdSN4FUv/Q4ceE9lrdnzMOiZp/YyK47/PFV9dPoXq/3AXvJqaqKCpRpPmCaKZijyeKsQ4esgJZfg/tYAzWMzVT3+7Vjgxw6gWZuam+cof22JA3DJlGYS9aFv9doa5E3Fs+2GLauVNLXL3ThWMKaJdVNTlzk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SJWTcwSZ; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CvO2v84G3ZqBKCvO2vv2ZO; Sun, 26 Oct 2025 08:41:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761464519;
	bh=uEwnxd7x2uL4HaQMJt0KEV7togDKpOIRB+P5azfi0BE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SJWTcwSZINSRGkeVF6+BK/NXjX9+SV0tGZ3du/AgOQ0yLuzJLhTQIK6OXysvEOTZr
	 YDBf8nvpqo2g0wZaaIRK+rKuGIgGCBrDeSLMityAG28n65G9c25M7m15sIOo2Ofpwj
	 3QFlv/RzsDuZCInwtbmISOwXvTqtZWpLJkO2qOyf8oit/2rqTNjhe8NVy8h+Rh/OXh
	 IDxtLbqVLQvXpSOAgJrY0tVgKvcXP8An7DKee5FognG2/Wyf9SpINyDe3/JmFgFBB2
	 yUQBvjhWTGET9mydmlyKbTE3vgjCUtsuCzAQFc5bsEGDc4Z0e4DPHrb5Lm5M8rqB3H
	 0JEQrDeNzrRKA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Oct 2025 08:41:59 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
Date: Sun, 26 Oct 2025 08:39:52 +0100
Message-ID: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'first_bit' is known to be 1, so it can be skipped when searching for the
next 0 bit. Doing so mimics bitmap_next_set_region() and can save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

For the records, on x86, the diff of the asm code is:
--- fs/resctrl/ctrlmondata.s.old        2025-10-26 08:21:46.928920563 +0100
+++ fs/resctrl/ctrlmondata.s    2025-10-26 08:21:40.864024143 +0100
@@ -1603,11 +1603,12 @@
        call    _find_first_bit
 # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
        movq    %r12, %rsi
-       leaq    48(%rsp), %rdi
-       movq    %rax, %rdx
+# fs/resctrl/ctrlmondata.c:133:        zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
+       leaq    1(%rax), %rdx
 # ./include/linux/find.h:214:  return _find_first_bit(addr, size);
        movq    %rax, 8(%rsp)
 # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
+       leaq    48(%rsp), %rdi
        call    _find_next_zero_bit
 # fs/resctrl/ctrlmondata.c:136:        if (!r->cache.arch_has_sparse_bitmasks &&
        leaq    28(%rbx), %rdi
---
 fs/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54fc4de..1ff479a2dbbc 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -130,7 +130,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	}
 
 	first_bit = find_first_bit(&val, cbm_len);
-	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
+	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
 
 	/* Are non-contiguous bitmasks allowed? */
 	if (!r->cache.arch_has_sparse_bitmasks &&
-- 
2.51.0


