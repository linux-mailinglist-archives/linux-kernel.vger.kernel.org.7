Return-Path: <linux-kernel+bounces-875338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3BC18B56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C035C3544E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487430BB87;
	Wed, 29 Oct 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kieJ7euN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31D2E8E06
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723113; cv=none; b=uALEE+gNBWPxAmmjyEjhFXpC6sw7g6A2V20dDabS877tW/3sWuVO1114X7N0ERIzq0aakDJLmdcVQC/NQk73G73e4aJ2c7a1w+h4ylI9glMM/rrz2UTVj6o7GbdUwiw8rY4SHENNb9+2duspzRW7Q2eprQH+cyuLb2Y1Rwszw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723113; c=relaxed/simple;
	bh=vqV1Fjx3BO3rUh6GRCACrMMeFbLW2LNJ+Pus0+1NwVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WD0v530E+AIdzPKoBTPORKLb9B2wm0fbypaqATH6TMfcWbNaPiLFwqC8DO6/E3KU4DCDLPO3YI3XWLpuCwrjPsNht+iFWNiqJJps76KXzMi3B3f61JP0Nl3ocsNue4QYS1i2XTxKq8/yNLuKHAQ9Ybs9zk3CzLag+k4zP6+QTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kieJ7euN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723111; x=1793259111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vqV1Fjx3BO3rUh6GRCACrMMeFbLW2LNJ+Pus0+1NwVI=;
  b=kieJ7euNKvw0FShDImm95xiGDoC85UrwIHVI1qwzhE5D9SOYfhzYOMUt
   ajmroQsku2dRfR8eEbJKGDi/C7yeoeQlt0OzX32V7WzqB/GBfGqDj6if1
   5vkLHRVKBaOiudPI4zDR+VV7lb+/nnUQ1gnUedSyUHq5e/2rDktfwJeaV
   zRWrfu46idT6W/keJJBlxx/EB1/qqxndj65pwPtQ6Xd4pMbeXbgJZhDKY
   6YTGeoBMhxGfP3D0gPzIAARde8HMu5k7AfPYomplYpAH9RyAF7uPrQFx7
   0lqAunzexvxDhGyON0aDcdfND8F7vkYVkIw5q6rfiDAOHwAApAQ1GTNES
   g==;
X-CSE-ConnectionGUID: RIEmP5IUTSq1c5oKhql3ng==
X-CSE-MsgGUID: TgPQqfhOSsOZtL1VwZnS6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75282486"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="75282486"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:31:36 -0700
X-CSE-ConnectionGUID: ssOsBI5rTR+XPGC1328/Bg==
X-CSE-MsgGUID: Vs9N93gJQye3HsqrHXFwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186332096"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2025 00:31:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5AB0F95; Wed, 29 Oct 2025 08:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 0/4] regcache: Split out ->populate()
Date: Wed, 29 Oct 2025 08:28:57 +0100
Message-ID: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (4):
  regcache: Add ->populate() callback to separate from ->init()
  regcache: rbtree: Split ->populate() from ->init()
  regcache: flat: Split ->populate() from ->init()
  regcache: maple: Split ->populate() from ->init()

 drivers/base/regmap/internal.h        |  1 +
 drivers/base/regmap/regcache-flat.c   | 28 +++++++++-------
 drivers/base/regmap/regcache-maple.c  | 47 ++++++++++++---------------
 drivers/base/regmap/regcache-rbtree.c | 31 ++++++++++--------
 drivers/base/regmap/regcache.c        | 16 +++++++++
 5 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.50.1


