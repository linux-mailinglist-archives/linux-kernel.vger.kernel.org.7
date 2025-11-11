Return-Path: <linux-kernel+bounces-895261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F5C4D61F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83303A30C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1635581B;
	Tue, 11 Nov 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9+6BQai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6A2957CD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859976; cv=none; b=C2MYiXgwxWA2psvNHQLQC9aidur2qHHA5VU3Dt25vrvh+WKjZqJ5EVbrtJ7nHSSbI0ifCTzYqOIkP8X4N1Cy7b8g8fC65X91WIucPDEvryoJ0gTGG4mTFeMFRpuSsd0s3Ex4PcJ8elMEud4/WCQVU0X3cBDMvsPdpf9JD0hFeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859976; c=relaxed/simple;
	bh=zy4IxmPtBkptPaMrQ2/mdRSxEEv1YrHvTsFXVxkdxq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsNnx7lreT4ITEpnsL745Ww7MVD+YMchSMqySKZS+ZtK2FvZcYidxaIblVFfU04YTRTQeSlcENvR520yLu+JYYDDTSf4CQ/xL0WPITxQ+hB1hZwk4+vnywD3lsIoiBxRuhr7438qwA4Tl7aYC7R9Rmix5E1PKRgzNnOXN3yZXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9+6BQai; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762859974; x=1794395974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zy4IxmPtBkptPaMrQ2/mdRSxEEv1YrHvTsFXVxkdxq0=;
  b=R9+6BQai98HI7uIN+81SHVFp0N5dzMAq//3aIJyBxmeSGb9YhXZRd7xp
   LT7xMQXKv9PzSdyFYn/3rQvPuG2ICwSehKE9viF3ABtikLWZK6y5fiug+
   o9o5a7TMXj0e4Qx0oIhU4jkgPoGgoTpterk1G1OZO0OKfkgpjmrpp/XKT
   tcvFKnbUPVRdThRJ4vMfHIeXp8q9GrfgpdxPjNfgJpKxG7sH/vzehj5DN
   0zUgI4sUOPPsFXnuwpCCzUUFi4UZx3l5/mE/WLbifcaRwa9fRzPQczODq
   sx0k+WPPScIeFHKd73NPpsvCrAxINWUyqQcAJ2RXipaKWaTLgfIKnKCgG
   w==;
X-CSE-ConnectionGUID: uqvc+SpoS/O0r1zFn4gkcA==
X-CSE-MsgGUID: n0piso0LSse+nOINbcEPOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82317377"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="82317377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:19:34 -0800
X-CSE-ConnectionGUID: BkraQmrLRc6DtboMi12Axw==
X-CSE-MsgGUID: /913gT0+SZyyILECWidl0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193053094"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2025 03:19:32 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 786BB96; Tue, 11 Nov 2025 12:19:31 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Cc: Yixun Lan <dlan@gentoo.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] mfd: simple-mfd-i2c: a couple of cleanups
Date: Tue, 11 Nov 2025 12:18:34 +0100
Message-ID: <20251111111930.796837-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is just a couple of ad-hoc cleanups. No behaviour changes.

Andy Shevchenko (2):
  mfd: simple-mfd-i2c: Make ID table style consistent
  mfd: simple-mfd-i2c: don't use "proxy" headers

 drivers/mfd/simple-mfd-i2c.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.50.1


