Return-Path: <linux-kernel+bounces-878810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB33C2185B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901C81A22635
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCA36B976;
	Thu, 30 Oct 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTK6Abm/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672C36A615
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845961; cv=none; b=ayL2tE1/OTGx4RUEw4RtxEEjchx3eaPrhmJE920dWFNWaEvYwPk7/LR9NGZJVADDiCs9GXJGk7F9XqDdfY4SCeEWa/coA8j1HcAKdjLMRCbPbKHEfuDS2NdZH+J+9Doz+eeZ7gRSV1WC99qVniBdaJnga5JQ0uNDANpoMK1G3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845961; c=relaxed/simple;
	bh=q94FuD7+USLpqHSufJKiS+yzWltjiZgeIC7urhqQdZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUV5u04eAwboCqGwUfUX/+w0zUPrQTW3n8DYVD6GhQR8aB5HDnCuQceBmDYG3ht9OueYcusuQUHaPrgdLJmdm9737NwE9+Hf9jBMdSRX/ouU9JBTSG1uDwY9BFGyuwvglK3gr8zJVXgwvyqS4HICdnxM257bDyTkMEv5dyBE2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTK6Abm/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845959; x=1793381959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q94FuD7+USLpqHSufJKiS+yzWltjiZgeIC7urhqQdZA=;
  b=XTK6Abm/Hv9wA/SutwVYbbV23nkTMWr6SFhYvhSlPZLcBnaEWXKx0AJ1
   vozcHYPavr4AlA9ARj7LbOFDfLvvF2YlONr430/fxvVzmmkEDX8i28g9N
   OEiODmjOZ2PJw/iNzv5ENM9jwk1OdqXAW+tT5jAMfAX81DJY9eRxwT0pR
   aJxIoXer2D3GZ593tiaVaPQO89CVp9gn5PMxd70uNf39QE6oIUaz53cSf
   bY/UfjLIiHI9WIM6PVMjVYUWc1LDkryPlQFIhOU5kq1f5sSy+M9HgIm1M
   WgzMi1kt58LjrmI44Es782BvCHhEzTYTfYXvkaatCalenybuCsiDvMSvA
   w==;
X-CSE-ConnectionGUID: 1Q4XyXdBT7aUluWPADxgkA==
X-CSE-MsgGUID: gtPo/L/BTOeTpX1bVqqUzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67649362"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="67649362"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:19 -0700
X-CSE-ConnectionGUID: u9YTXKlfSzydsC8Qd5d3+g==
X-CSE-MsgGUID: PVlJREPORbe6eGt9cgvdAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="216862040"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 30 Oct 2025 10:39:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 60A4D95; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/5] regcache: Split out ->populate() and use it
Date: Thu, 30 Oct 2025 18:37:00 +0100
Message-ID: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
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

Changelog v2:
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


