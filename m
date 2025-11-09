Return-Path: <linux-kernel+bounces-892130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B70C44668
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58C4E345FAD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1F9262FC7;
	Sun,  9 Nov 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idA/49uo";
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNxp0bjO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2E261B99
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=10.30.226.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717742; cv=fail; b=Fh3KYw2dNiXo7kahmutZE4gUzz6nqPf0/98tBMzGbrA283jzM4pqBZ1WkePtIM7A3Hu/1qtvejuftG1PG8R3U2fAsGp/avqcOBwruFp7j6MJ4QKoGhFh0VvXmay9FpMp7+V+6KcNFc/o3gntiaQgbAhLDd6+z0AgzUnNcTijjFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717742; c=relaxed/simple;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZRt5KTfgMdFIX7sPvA56F2JeqQfMhz/qXEvkMYFkleXaQRMuZffnqVKUy640ARIM9WlkwYbpjmfQ3/YJM0EL2q7Mcry30VgozCwSOlfLRhF3y+6Af7nlUmXAbCNEqViyzbBESja9fiMbEsTSvfFnInQKzrZo18mvK59pWTzqZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idA/49uo; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNxp0bjO; arc=fail smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C722C4CEF7;
	Sun,  9 Nov 2025 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717742;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To:From;
	b=idA/49uoQB1Nz9HG08wqiiSTZCj0qOCZd9J5menFA9tuSL3n9Kcxg2WBjgLzqvm+P
	 UAODqbXd1g44bCNskk9jsIEgb3mnp4vJc97/6JcXi1zMLTxWTmc7A9vrbwRlNnhOT7
	 TJJ0F27Vk7mQrpABr41jWe07fQBOQHCPxnAwFib9GwacMsxcHrPbxq18govUnUw/vl
	 xlnDhwWo97gsZ8HUIfA7SEjXfyDw1U414e8K7ReSAroWmxg32XKxIQtqNkLuvXTdRo
	 bgL9jSe8L8bKZ3iOdyT1Hv62u4fOs4oTqqmtF99Q7z4chylQLkNuYweB3liffo96M0
	 oM+uIuunhVzVA==
Resent-From: Alejandro Colomar <alx@kernel.org>
Resent-Date: Sun, 9 Nov 2025 20:48:59 +0100
Resent-Message-ID: <wqfg2ot7yv7gkmwfr7ojnkjwad2p4tvcd2mmkhhqoivt66q6ek@hclvvebgktnu>
Resent-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Received: from mp0.migadu.com ([2001:41d0:303:e224::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by ms17.migadu.com with LMTPS
	id CCgvI27vEGmVSAAAqHPOHw:P1
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:50 +0100
Received: from aspmx1.migadu.com ([2001:41d0:303:e224::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by mp0.migadu.com with LMTPS
	id CCgvI27vEGmVSAAAqHPOHw
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:50 +0100
X-Envelope-To: foss@alejandro-colomar.es
Authentication-Results: aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oNxp0bjO;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alejandro-colomar.es; s=key1; t=1762717550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jX8msigRXIApZg9OK2U1b7wFE91+OTEGS3ZaY6JDHQU=;
	b=p6U+Yfpl8BZKqNby9N/fgVhnxR2CT/riJLFPig2hRklY3MfouLHl54o8/kiyahXF308XfY
	hcJ9f4b2jKGRwAgam6R3qqCqsAo1km7MJn/ZNsKp0oqARHRIpH74481+MLJs3iB9QyJE+o
	OrtDRgaxaX/iI7fdoRpfSGkEVovc2k/9VQrOi3xSh73aQUZxnFSCGv6kVLbOKjoxvbjYqM
	Nm88x+0Tz4llMFLMj7qDmTA6vEqSm3GvmdtEXxzTRhuT5SQs7dtE3m3h+5S6LrspoULlDT
	Yhvlv5hr13eVGMkMbFxU6YA0iBC963r1984MEB2z/jO/jhwKUuVXOj8RGKfJaA==
ARC-Authentication-Results: i=1;
	aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oNxp0bjO;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=key1; d=alejandro-colomar.es; t=1762717550; a=rsa-sha256;
	cv=none;
	b=UyRylDON+FCRJ/M1y/LKNhqS5tuFMuajqMt8hiXajM8UVkigghddvBVrn9K0RzctFHwz9E
	QMcZbfRI60eUtrOaBOaAxNkcgDAPCI1oCAhiW7+QuLi0xZf3zx21F48oR+lBsAMGNr61Ga
	98eFKW7JgeieNBOGWiCJ83X0UxC/DUtZZneVDFHq7aHfhzirR5l/C2MQ0R5OOC4xZosawO
	ozHLOLG1E18mcAX6fgR2X25bCjnCxXE2b19vNqLOSA6g8xijTE0X+lBLgxtjXV7/J6227e
	13G5cYBJnefZAis3GNbgeC7DA4OcHJCt2fVQk4dulmzPx0Bp4cEozJsfAlm0Ug==
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aspmx1.migadu.com (Postfix) with ESMTPS id 3A1A3CF432
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:43 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F59760010
	for <foss@alejandro-colomar.es>; Sun,  9 Nov 2025 19:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 06B96C19425; Sun,  9 Nov 2025 19:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E51C4CEF7;
	Sun,  9 Nov 2025 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717528;
	bh=kaO5/IVrebOzmYLwKVSEsBGlfzzeuU+iOQME8bN/Vgw=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=oNxp0bjOAvsa0Lb+vuYK5NWUqIHpS+NZERhHFW4TqreExEGs1Ujpc9OzjtRdEqmmd
	 rInqVtxNh824Ho+90BpwQ7jRyghuwrsCK716/xcgXv778eWLNOloPyA4DAoq1eZjQy
	 kPChbSoCfSGIehHd1YysDmf1EkemtwaiuYKUqyxIDEuxMfN4V9WNsbebozayzbkh6T
	 OVUwltoEPQMpphBmIJhI3XiJWWTfo8yAL2EBRyxRHGl4HCLbCMhIa1+3VFkV47eJMa
	 oEgMJNmQ8WNTmSH9wTCUunzXlIsWFVBsKdg5Wl0dFY7qTo6cqkvPneikOpmaowDwbp
	 68YybM6Oh5f5Q==
Date: Sun, 9 Nov 2025 20:45:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v4 4/4] mm: Use ARRAY_END() instead of open-coding it
Message-ID: <980c8fe8a6de9409f241334262a08538a39a353f.1762717358.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762717358.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1758806023.git.alx@kernel.org>
X-Migadu-Flow: FLOW_IN
X-Migadu-Country: SG
X-Migadu-Scanner: mx12.migadu.com
X-Migadu-Spam-Score: -3.12
X-Spam-Score: -3.12
X-Migadu-Queue-Id: 3A1A3CF432
X-TUID: O4mvHhl2plsn

Cc: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/kmemleak.c      | 2 +-
 mm/memcontrol-v1.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1ac56ceb29b6..fe33f2edfe07 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -510,7 +510,7 @@ static void mem_pool_free(struct kmemleak_object *object)
 {
 	unsigned long flags;
 
-	if (object < mem_pool || object >= mem_pool + ARRAY_SIZE(mem_pool)) {
+	if (object < mem_pool || object >= ARRAY_END(mem_pool)) {
 		kmem_cache_free(object_cache, object);
 		return;
 	}
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..b2f37bd939fa 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1794,7 +1794,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 	mem_cgroup_flush_stats(memcg);
 
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+	for (stat = stats; stat < ARRAY_END(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
 						   false));
@@ -1805,7 +1805,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_putc(m, '\n');
 	}
 
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+	for (stat = stats; stat < ARRAY_END(stats); stat++) {
 
 		seq_printf(m, "hierarchical_%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-- 
2.51.0


