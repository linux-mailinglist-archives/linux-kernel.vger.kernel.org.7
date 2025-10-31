Return-Path: <linux-kernel+bounces-879671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6AC23BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A35426D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE5340298;
	Fri, 31 Oct 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A18xIDk+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB532E6B0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897947; cv=none; b=Cgrok2b2R0n06oDuAKM2d/oRbKL9xxVC+tdNJnSBED72QyGaBKkyxZJuk5rQhPBXgOc2yVgRayjhknAh7WUNoes+a9+ZsBEz45gixhtJ3igR65nb9y/L0GJHWtMlqhifCFX8ilxZkL24AJYRwlsMR5fzOjeJnxzziQjmLjZH8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897947; c=relaxed/simple;
	bh=Q2xZkwCW0AmTa4qnwcYOKgh1ZpeXBgV48tHAsig79RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9m5vG9FG5+ms9rCpz+gs79GybEuSNNTGXOemF0Nt4MhgxFS/YL1ZCs3XiaEklojSPj9QuaVdYPKHo3eXY18SpUozGkQRzRIjmN8wvMqDfjXtMuUDis9OccYb4juCEQoZjMGxmssPp33ZBkqRPWBQeb5pk9f3sToNppOIJ+f1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A18xIDk+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897946; x=1793433946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q2xZkwCW0AmTa4qnwcYOKgh1ZpeXBgV48tHAsig79RI=;
  b=A18xIDk+crcd/sdj/qQKLGRYHB6uqm6l8HsBNSv3ut0nZBU0ABOaveem
   KVWzkB5Woxz6+7Z8uSotexM+8BpgbK9SYzKnVAsPhB0N8LT1v+kyzsRJy
   h5+UFYDJxKJtmqz6LwG7h+zTKhQ+4bpdv6VU5O1wUaMEsMZfIYOvqzfnQ
   yGQhdwGohwZi+B/E2bog5RhdLbp0/afvwQOxu51L1Z5ArgwCCTBMFTX3d
   ne133H0tReRLy6aaa+uK03gxHhkhAzAwX2d2E1hHUuZIs51esl8OFvRTC
   EYz/pjbo1u4s5NnM4xExthVjblUJ6uiwUrvVymSKYIGI9/9m80vDz/UCj
   g==;
X-CSE-ConnectionGUID: uFx7GIAOSSqaWdDW1eO0Vg==
X-CSE-MsgGUID: gwn+ZfZSRpOdPfvk9Fhhtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="86676353"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="86676353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:45 -0700
X-CSE-ConnectionGUID: mwoy04vURTS1BdedhmpToA==
X-CSE-MsgGUID: 1p+/7rVVQ/uQnXhpXxeGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186631607"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 31 Oct 2025 01:05:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9349695; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 0/5] regcache: Split out ->populate() and use it
Date: Fri, 31 Oct 2025 09:03:15 +0100
Message-ID: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a refactoring series to decouple cache initialisation and population.
On its own it has no functional impact but will be used in the further
development. Besides that I found this split useful on its own (from the design
perspective). That's why I decided to send it out as is separately from a bigger
(and ongoing) work.

Changelog v3:
- added missing space (Mark)
- collected tags (Sander)

Changelog v2:
v2: https://lore.kernel.org/r/20251030173915.3886882-1-andriy.shevchenko@linux.intel.com
- rebased on top of the recent regcache changes (Mark)
- a new clean up patch induced by the previous

v1: https://lore.kernel.org/r/20251029073131.3004660-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (5):
  regcache: Add ->populate() callback to separate from ->init()
  regcache: rbtree: Split ->populate() from ->init()
  regcache: flat: Remove unneeded check and error message for -ENOMEM
  regcache: flat: Split ->populate() from ->init()
  regcache: maple: Split ->populate() from ->init()

 drivers/base/regmap/internal.h        |  1 +
 drivers/base/regmap/regcache-flat.c   | 37 +++++++++++----------
 drivers/base/regmap/regcache-maple.c  | 47 ++++++++++++---------------
 drivers/base/regmap/regcache-rbtree.c | 31 ++++++++++--------
 drivers/base/regmap/regcache.c        | 16 +++++++++
 5 files changed, 74 insertions(+), 58 deletions(-)

-- 
2.50.1


