Return-Path: <linux-kernel+bounces-875436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBFC19082
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8A95508BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4574324B39;
	Wed, 29 Oct 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="NCCAic5x"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7F31327F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725585; cv=none; b=AViSRLE4/9C3j7cOlKtKFEwF8UuKQXROzWeMAO/56kfkIEnAcO6dlfrsWOvDoJP1TqQ4F6HqcUoOrwRcgSQMBGjetMp6vD154n5TpfvRTvnZBCaAdra+SacLDLnuEwVGO6Fes8BQOdp2nRx0+YXHUOu2X2fFJUrxns5bbTgODD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725585; c=relaxed/simple;
	bh=wnpYbp7ZN08ucpXdNVQLca6PgWG1rE3nJo5xqyRiywU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN+sDJj1Oe4+Ggu47iWODa1B+N835kKfMtYVEkc81puKfeYbZptzgjkRl8UnNSwXQ56nSKrQa1+F7CDBvWxv/G7Uqj3QtFdmkHtYk8JvyQZ9KrV4lutolveJhyNQBnA5E0AoJDX7DmC+qlAF8X1sesZ/TzDG8BbLN+9uSkugqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=NCCAic5x; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 9790F690569;
	Wed, 29 Oct 2025 09:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761725575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJP9P3q1GKK/L+3ZNzKe5LsfQCgQWs0cyhA4ENcB7rE=;
	b=NCCAic5xQqeB8wlvxNW7UDdrfgpBSt+uq6B6ymV+PizOyPTmBv/KmjL6p3JWgr8xCRiOmD
	u1ZpQgzHeHG0lfK4iPTUs3EiE1xkYXCi+Zw0ZbJNeNna9Av+Sp25r9KT2n3mBn3/ZWng/r
	x6hzOdCJIc4pampcxYdFdhwIa1zL59gbTxOlnO0qvc0k5OEGSmixvXnhvx1orfcK0w2iXr
	W4b4me/fwqV/h8VoGpzE+145rsdz9NILc+BHuODvjBuHwBtTd6urWfoz69xmzLAeuVAWeM
	VlULqBfhrIUFTa+oJ7GFgIjjYK1OJ7S87Lok3tS9tUaCOeIAxi/T215x/vqPVw==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 2/2] regmap: warn users about uninitialized flat cache
Date: Wed, 29 Oct 2025 09:12:48 +0100
Message-ID: <20251029081248.52607-3-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029081248.52607-1-sander@svanheule.net>
References: <20251029081248.52607-1-sander@svanheule.net>
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
index 86f7679175b1..3b9235bb8313 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -89,6 +89,11 @@ static int regcache_flat_read(struct regmap *map,
 	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
+	/* legacy behavior: ignore validity, but warn the user */
+	if (unlikely(!test_bit(index, cache->valid)))
+		dev_warn_once(map->dev,
+			"using zero-initialized flat cache, this may cause unexpected behavior");
+
 	*value = cache->data[index];
 
 	return 0;
@@ -114,17 +119,6 @@ static int regcache_flat_write(struct regmap *map, unsigned int reg,
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
 
@@ -158,6 +152,6 @@ struct regcache_ops regcache_flat_sparse_ops = {
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
 	.read = regcache_flat_sparse_read,
-	.write = regcache_flat_sparse_write,
+	.write = regcache_flat_write,
 	.drop = regcache_flat_drop,
 };
-- 
2.51.0


