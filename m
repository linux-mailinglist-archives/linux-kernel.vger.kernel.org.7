Return-Path: <linux-kernel+bounces-867079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D744C01891
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF819A4CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631AF315D35;
	Thu, 23 Oct 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="kUvfqWhr"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1E312819
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227441; cv=none; b=rYKidD527SgccvMzzYLqdc7WPEchbQYNu4u3FOY8iNV5ATxNwCu+vyd25/oK/6gcTX81rCJE2efQq8nZkcsx4uJFPYK30Txm+ilLxtWNeZ08+Eso5GKzNvk8b15nbp5xKKDaDMPw3zAdbCXUj8iH+W8tFFd35h4hBgKAioSYmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227441; c=relaxed/simple;
	bh=DFGd5uHumRSJjMCI6QllEeLtcxJNFOIH6vHq8RMi/0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBUwWCBS0MS+CFIQ1l+195MywMjC4yL9ZYQETrXOyLggpInNi3/wJFzqJI1nYsM1N49nfRM5TD+Ug//cJBgkcTork1ULjeUDcS9vwQ1oq/6h9zJp5BjvH37OPpsr1Gf0EVC6HbPHRrmkG6l6yybToPhGHZNEnVtaqDCvXWb6vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=kUvfqWhr; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 3173068C2C7;
	Thu, 23 Oct 2025 15:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761227438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHLuZRoQCceH6t2qNi/B89BYn2kH/gXjf0ERQuTJebg=;
	b=kUvfqWhraiT6iYK6GbFiCKW4Zb6kfL772PSIKhoKXWpuH1fsLsXZpJAV+q1oSBPTWL/y92
	C1PW2d8+U/rVMUzcFtM/p7cLwRknDQ3vqW4wHaxBK4d+0sYq6AI9FM/15BETeVaO4SpWNK
	I5tNZiyF8XNx+VISVu5CCNp3dtL7LKY6oVL+DaMnT3yBp9g5+1ei8TtxjOFchMBWRbz0Al
	p81lcKsEgGeMJ1M89MQZB9bfIQ0YJkk0cak7rpLjRMBUmR0icRPZBcfeM+r8OaEnPwRfvM
	shxjedqy1KsYwaQjJkTohI0rSkGhFOvv6J0E0+jl/62zBPNRyxnzCxC1L5T2Yw==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 2/2] regmap: warn users about uninitialized flat cache
Date: Thu, 23 Oct 2025 15:50:32 +0200
Message-ID: <20251023135032.229511-3-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023135032.229511-1-sander@svanheule.net>
References: <20251023135032.229511-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The standard flat cache did not contain any validity info, so the cache
was always considered to be entirely valid. Multiple mechanisms exist to
initialize the cache on regmap init (defaults, raw defaults, HW init),
but not all drivers are using one of these. As a result, their
implementation might currently depend on the zero-initialized cache or
contain other workarounds.

When reading an uninitialized value from the flat cache, warn the user,
but maintain the current behavior. This will allow developers to switch
to a sparse (flat) cache independently.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes since v4:
- Use one line for the log message
- Use dev_warn_once() with test_bit() to avoid log flooding with offset
  register spaces

Changes since v3:
- New patch: emit a warning for the flat cache on suspicious registers
---
 drivers/base/regmap/regcache-flat.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index 1ca308916d5a..29934878ced6 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -91,6 +91,11 @@ static int regcache_flat_read(struct regmap *map,
 	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
+	/* legacy behavior: ignore validity, but warn the user */
+	if (unlikely(!test_bit(index, cache->valid)))
+		dev_warn_once(map->dev,
+			"using zero-initialized flat cache, this may cause unexpected behavior");
+
 	*value = cache->data[index];
 
 	return 0;
@@ -116,17 +121,6 @@ static int regcache_flat_write(struct regmap *map, unsigned int reg,
 	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	cache->data[index] = value;
-
-	return 0;
-}
-
-static int regcache_flat_sparse_write(struct regmap *map, unsigned int reg,
-				      unsigned int value)
-{
-	struct regcache_flat_data *cache = map->cache;
-	unsigned int index = regcache_flat_get_index(map, reg);
-
 	cache->data[index] = value;
 	__set_bit(index, cache->valid);
 
@@ -160,6 +154,6 @@ struct regcache_ops regcache_flat_sparse_ops = {
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
 	.read = regcache_flat_sparse_read,
-	.write = regcache_flat_sparse_write,
+	.write = regcache_flat_write,
 	.drop = regcache_flat_drop,
 };
-- 
2.51.0


