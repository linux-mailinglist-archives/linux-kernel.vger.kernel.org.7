Return-Path: <linux-kernel+bounces-865824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B2BFE1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E396F1A072E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46D2FA0DB;
	Wed, 22 Oct 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="t5Rkj8cm"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C92D0C97
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163499; cv=none; b=OEd+p/LK/ONFvIt3qAdX+frgwmZuU67tvfcLtxWhxWv/eiY926gzOdKfjKc1dJs3QnFcYxg0pRqpPHWPAkI2U13yLwhYWn8W2J2Sd8jfcrWzgZ7S11YlxxQzG2TJchq1pEDNTamKQfN1gUwpCrwPwUrfGdPO1+g1uJ9b7E9/PX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163499; c=relaxed/simple;
	bh=pKHq4tL/vSPCuT4H2cv/OCDdlZ8gLd53YfR8eqd9WNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eq3isBHF6p5SuzAIU06XwFmDF+N4Se8LjS4hNgYbL2Y/qaqUJcxZ/0qdl6Gx447hOpWxUWDm+oPkp8/GMILrlYm6Old7czTjxGndI/oOkxVjcdR3apirJLl02380cKRrN1S+HzFgBxqWtjytYOUQAlagy6REOkzBJaabDHDFNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=t5Rkj8cm; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id BB21D68B9A1;
	Wed, 22 Oct 2025 22:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761163489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOjs6gmHYhxAucDQWaCaiSvU+FT5q72t/PAw72NC2IY=;
	b=t5Rkj8cmzSccGreeVgIpstkrRV8lW/XZvqkKkzBzCu13W3hpT0u80n5vmfoaMEKdNeEmPg
	vHbB1goEpXdYZO3QgLqeOuxoKrlJ+SbYM0324sb7eRVNY2zO9CHjCyN0rM6sc3zy5CUoRw
	0H9Y2LNA1rn2su2E+j7oxzKB1gQ1GiWtMp54d3zP4R/Nux4GYXZlobDkKeCrRxbX8bpR14
	S3NYSnTQqM9aFeanhAuHKvO42QO15fHyb3fyRSSRUS25SsGUwHM63VBGSo8s4kvT+2+Ulb
	91O9Oth/wA2AE1y5qaEIHf2Pzjj4LF932WQDhuUftr/qkfZiThpTvnvL5F34kg==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 2/2] regmap: warn users about uninitialized flat cache
Date: Wed, 22 Oct 2025 22:04:08 +0200
Message-ID: <20251022200408.63027-3-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022200408.63027-1-sander@svanheule.net>
References: <20251022200408.63027-1-sander@svanheule.net>
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
I've decided to use dev_warn() with __test_and_set_bit() to avoid log
flooding from e.g. regmap_update_bits() deciding not to write an updated
value. This way the warning is only issued once per invalid register,
which will hopefully be a bit more obvious than a single log entry from
a dev_warn_once().

Changes since v3:
- New patch: emit a warning for the flat cache on suspicious registers
---
 drivers/base/regmap/regcache-flat.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index 52ce125a74e1..8802713e0cc6 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -90,18 +90,13 @@ static int regcache_flat_read(struct regmap *map,
 	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	*value = cache->data[index];
-
-	return 0;
-}
-
-static int regcache_flat_write(struct regmap *map, unsigned int reg,
-			       unsigned int value)
-{
-	struct regcache_flat_data *cache = map->cache;
-	unsigned int index = regcache_flat_get_index(map, reg);
+	/* legacy behavior: ignore validity, but warn the user once per reg */
+	if (unlikely(!__test_and_set_bit(index, cache->valid)))
+		dev_warn(map->dev,
+			 "using zero-initialized flat cache, "
+			 "this may cause unexpected behavior");
 
-	cache->data[index] = value;
+	*value = cache->data[index];
 
 	return 0;
 }
@@ -120,7 +115,7 @@ static int regcache_flat_sparse_read(struct regmap *map,
 	return 0;
 }
 
-static int regcache_flat_sparse_write(struct regmap *map, unsigned int reg,
+static int regcache_flat_write(struct regmap *map, unsigned int reg,
 			       unsigned int value)
 {
 	struct regcache_flat_data *cache = map->cache;
@@ -159,6 +154,6 @@ struct regcache_ops regcache_flat_sparse_ops = {
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
 	.read = regcache_flat_sparse_read,
-	.write = regcache_flat_sparse_write,
+	.write = regcache_flat_write,
 	.drop = regcache_flat_drop,
 };
-- 
2.51.0


