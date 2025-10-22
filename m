Return-Path: <linux-kernel+bounces-865823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E1BFE1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DC43A6E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49E2F9995;
	Wed, 22 Oct 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="tqTyEke+"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775015E5DC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163498; cv=none; b=QS6BniVs6aFeANshGmiR19XxbtHcOrTYmPXvECGdCHw66YcokPCPAAE3K5qKVYJqMu5WSlWjVKCwU0OazkUOkdZWg+HjYviKQecuzwotFSTzz8gYqQnlJx2L+yu0qQPt0TQEEA1pB0hzVSVHVjbHl2hkyNBX4LFzlXln6puhsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163498; c=relaxed/simple;
	bh=tM3LzbYgRsWoWpqk1nzLkA6cInb4SME/Mu+cQCp/XUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPolUiFd7U4ZCzmSsOhMGOZexq25y72a1YgmDH6tsYoa8CsBiO59D6KfSPlbvpP5ZMYDR2Tt8ADGLMYgYLhmpxDj5hpFY8KxNXNeWnpRSEjULJ0ZHmGnOfIN4Ph9kl/2pY79YPH8pegUu+fbDzDwdd+8kyt3UUXciDvDz7SWD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=tqTyEke+; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id C83C468B99F;
	Wed, 22 Oct 2025 22:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761163489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Djfh+pdab3qDsHOF+CIqcM7UwYJD+8QsISBeqv8Iq8=;
	b=tqTyEke+LYrMy16X9QeiNqBuXSMcOi5QL2j4TmRztF9jace2omxuDb41QaedKE2kQAD37L
	okCarYwJblJSClwGYNYThGWg7Sz4bDKZHJcQ2e08YZkPdLvF2Qg/SjltxXJ6HWWY+qeDTx
	IhZvB7FGK5yosuC5lggFKLYvjMuEt4yAzmAzzc4XNTuGxRLrcnSlJHtjTadSaR0bvRaPD8
	dZuDbCFYRuJtM2VA2guiLv4ddsnobfmRpyqDBFzWcYOE3cVKIczITCQzeOtbE3YwDhw5PT
	OVv1du1Zdsv+NZ0TJjQQOryP5fuiCBJL/wzsY17cGsssrqGM8eWbOtJiwjn5tg==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 0/2] regmap: Introduce validity info for flat cache
Date: Wed, 22 Oct 2025 22:04:06 +0200
Message-ID: <20251022200408.63027-1-sander@svanheule.net>
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
 drivers/base/regmap/regmap-kunit.c  | 14 +++++
 include/linux/regmap.h              |  1 +
 5 files changed, 104 insertions(+), 11 deletions(-)

-- 
2.51.0


