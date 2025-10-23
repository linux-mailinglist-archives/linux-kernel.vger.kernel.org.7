Return-Path: <linux-kernel+bounces-867078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09603C0188E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E358618C92E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BA314B7C;
	Thu, 23 Oct 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="hxYeEfkN"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158B17332C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227441; cv=none; b=aFEVsLcU31BwXWZMiDkdoaLQeEKUlDv///WsWcvFoaDrWkJzL6NoSOKTvsrUqNx0JPeUOXUef6mRKQHiCIYzblFYw7oimcv6l4M1RZRWkst9oqEyOWJqeHtWYFutGbIAirup7BOMxt8R4IukH7Hv4Vmpjv4r2FkcDeDoGZxj84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227441; c=relaxed/simple;
	bh=L01udPq17QIaPKu5SWEuskNnAJu1e2f5DQKnfWau/WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=md96mLIlKS7kkC0WxfCpm1Tb9dWNZkhqGjYvFgX4UG6PfJGVr6VLtCZJK4NeTxwDHy0Hn9m0U3KywKFyQ1HAAJLdrx9bObJ28SMP5OuqttIQq1wwaSiyZx80wgr8sqJRJGGSGLxjT2HvXSHNoB2q3VdTssWSYuFWN7ZKfYeHhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=hxYeEfkN; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 8C0AE68C2C4;
	Thu, 23 Oct 2025 15:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761227437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wz24+/w2fBgjLz8lqMduiKJJFVkG5McYbmxwuKw5L1o=;
	b=hxYeEfkNaxIE1SkORlg5cbB4nQn8ajJRJLjipxMWyG+toeDr0tX9g9CrLAeGE5IMU+qZMb
	Y0fj153wbdFzJF7j33/PcdoruHtDpMwUPVFVcRCrzvFuT2H6LXFvvYRHr1G4X4VFtY2rL+
	SaagsRpATCvRulk01x9XURgrgJuOyaVK2YRsW8KW6jr2Cn9PD+BhkClvJRhzASjCrRmM1u
	qDceksxxCJxfb9+dwyqqGo3k0SNuUItVi0Ja3YN4YlWU5BGP6lgPQz+9atVYdFPuAQ8Yvd
	EHymeG2uozaxWaVZUvj+TsUE3yZMeWZjXWvd4yoD/Gfl8lBlm9NM/vpNriWxag==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 0/2] regmap: Introduce validity info for flat cache
Date: Thu, 23 Oct 2025 15:50:30 +0200
Message-ID: <20251023135032.229511-1-sander@svanheule.net>
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
Changes sinve v4:
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
 drivers/base/regmap/regcache-flat.c | 98 +++++++++++++++++++++++++----
 drivers/base/regmap/regcache.c      |  1 +
 drivers/base/regmap/regmap-kunit.c  | 22 +++++++
 include/linux/regmap.h              |  1 +
 5 files changed, 112 insertions(+), 11 deletions(-)

-- 
2.51.0


