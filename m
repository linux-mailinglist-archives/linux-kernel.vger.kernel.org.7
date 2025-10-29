Return-Path: <linux-kernel+bounces-875434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B91C1902B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF2567531
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7390322DCB;
	Wed, 29 Oct 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="QiF3Cw61"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EB311C3B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725584; cv=none; b=ONWQV/OnSjFvwVkZ7k43UghgbwHryfqYh5icyVrPrlwh9x3MVhZEA0CSd3SOF6wpqVB4dzOMM7WDYUrYrfbfYKobLNKGp85PhCjTJ9i0kSMG9uWRJk0vjHvD0i7hv9H3M2i5Tw+n5is/fAUibUIMrYIab4Ym+uZYah4xc29+C7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725584; c=relaxed/simple;
	bh=XXRRXFWdZ0VxQByzpM6FNRkKGXzZZbWI//Uo2d8F8UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlwJzhpAodcXh4tGBuEAJqQCcxsBwrGZEBA/F5Xr3PazWqgZs3Oiz4izEM3ejDL1HeSfNMzB8nq0FmKtgI07ld7tyQZnPkzV6PirMSrPnMHQeo+f8RQioPJP5HyzqfJ37ckfy3E3Scb+QlOFpFuT4WVXqAZVROWKyaXvKD1CRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=QiF3Cw61; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id B87FA690567;
	Wed, 29 Oct 2025 09:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761725575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TE8ZOOM73wGhypAggpwfjVvh8bO3PXtAh1vc0y4Fz/o=;
	b=QiF3Cw61U0JHuiYjrNd4wJTzZGnkMaTDEVsrOzOrX5mPi4nX/Zz9ZkkmrSmQSwoXBroULc
	K+bg0NBauF4d9jW3K90nG+CPwTNyy4nvEBnDZ71bu36AoOo08GBRX6QW0oIbfO7p+ncp/U
	dateRUsJstymlLexMTM099CP/rRsQeNrTBRhXFoXs5AhyEnAbK9doDczbaOciDYfVMX1Oc
	/1oCvnz9a+y/34EUSPduX1AKIiMaEjicWCa7ijyBAuOFiDe1x/Hy4v2uU6DWmvreX6LccK
	Io3AMYj6t9XUmnVn1278uXVPIaIfj2I8qfaYIPVrccDHLWzGkxxXi3foVVMkVg==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 0/2] regmap: Introduce validity info for flat cache
Date: Wed, 29 Oct 2025 09:12:46 +0100
Message-ID: <20251029081248.52607-1-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flat cache behaves differently from the other caches, in that it has
no way of knowing if a cache entry is valid. Initialization has to
happen either by providing defaults, by loading defaults from hardware
(via num_reg_defaults_raw), or by performing the required register
writes. This difference in behavior may be unexpected to the user [1].

To provide feature parity between the different cache types, a new
variant of the flat cache is proposed. This allows user to migrate to
the sparse flat cache (or a different cache type) when possible.

In order to encourage migration, the second patch adds a new warning to
inform the user of their suspicious cache.

[1] https://lore.kernel.org/linux-gpio/e461ca08-ad28-44fe-85f1-afe332c1d43d@topic.nl/
---
Changes since v5:
Link: https://lore.kernel.org/lkml/20251023135032.229511-1-sander@svanheule.net/
- zero-initialize cache for compatibiliy
- Update regcache_type comment to document the difference between the
  flat caches

Changes since v4:
Link: https://lore.kernel.org/lkml/20251022200408.63027-1-sander@svanheule.net/
- Improve formatting of log message
- Reduce logging to not confuse KUnit test result parser
- Add sparse flat cache to all KUnit config lists

Changes since v3:
Link: https://lore.kernel.org/lkml/20250109180256.6269-1-sander@svanheule.net/
- Split changes into two patches to provide a migration path

Changes since v2:
Link: https://lore.kernel.org/all/20250109151106.38645-1-sander@svanheule.net/
- Complete renaming of index variables so regcache-flat.c compiles again

Changes since v1:
Link: https://lore.kernel.org/all/20241231100256.194753-1-sander@svanheule.net/
- Fix off-by-one in length for bitmap_clear()
- Add REGCACHE_FLAT to the list of sparse cache tests

Sander Vanheule (2):
  regmap: add flat cache with sparse validity
  regmap: warn users about uninitialized flat cache

 drivers/base/regmap/internal.h      |  1 +
 drivers/base/regmap/regcache-flat.c | 96 +++++++++++++++++++++++++----
 drivers/base/regmap/regcache.c      |  1 +
 drivers/base/regmap/regmap-kunit.c  | 22 +++++++
 include/linux/regmap.h              | 17 +++--
 5 files changed, 120 insertions(+), 17 deletions(-)

-- 
2.51.0


