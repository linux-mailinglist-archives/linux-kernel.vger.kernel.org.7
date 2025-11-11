Return-Path: <linux-kernel+bounces-895224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED874C4D47B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294F718C2403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB243563C4;
	Tue, 11 Nov 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id0Y1lRQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF350D51
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858405; cv=none; b=Rpa6d674JeDRG093y1ylxTI1deL2xdlBZ6Z4GQ3T4kizaqgG4pxF4LQeq56cW/Z2xU8mKFYNIBGyFZoYyZNQ/3c8vK9pVNWLhQ8/A0D9LTEzELG3Sj0T4NmA96hQYgaMdPoLVZ3aZx+R3sL3aAHd97Ui0/VTq6VylZfzp1JS8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858405; c=relaxed/simple;
	bh=N5GydQ/e3mRKRW9EiNCU1KdecTj/dUauGG6TqSyCa18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBqq63Gtj2jXnYqH0dqVLNI8qM0hVqQMwSme+k+Vvb97oVxa6cyURctb58EB5Ou5912g9LFO7vKUlSjvJDI6Cw/VoCCzlEZwi3xsxjM3K2E1xyiHtvtBlCn8iP058h58OR1lGBcRP3MZYO1CdLk3BQwClIIoYCMZm+GYxp3Z9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id0Y1lRQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762858403; x=1794394403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N5GydQ/e3mRKRW9EiNCU1KdecTj/dUauGG6TqSyCa18=;
  b=Id0Y1lRQSVWm/w+o5rj8KxOAo2XvwNrtLeCEYaYZziZIt5BQvpPDGDJ9
   +oC3Wg00YM7jgqinPmjRpc+beFdLXVoLD+CxDju8/rjgG70/iOisvj75r
   hvLjmonAxRmuoj+bja/+66m2jJ1tEqr7n0192vmp97QOgeneA7AZ0Duay
   fkKhEPMnTBKGcr70ow/glT3rpjZM8kuBPg8xM7y3gQ6X8Sdy9GTjIcNKv
   NsKR6fd/D5UZLqNerv6QaFiZM8XjbNW5dRWnQLebKoQQweJbQdoGmjjGT
   Fna4628ktox/xM4gvJpUFTHrWEdBEk619MsYpNdNfQa2H3PH2RWhmQ7pK
   Q==;
X-CSE-ConnectionGUID: fVfXq5RhRVeeTA0HRIQFyQ==
X-CSE-MsgGUID: PkJj6JI1QCG+bzlP9OKjeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76265233"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="76265233"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:53:23 -0800
X-CSE-ConnectionGUID: BAJh3ywhQx2VgcTye0GgQA==
X-CSE-MsgGUID: +VkrPL8sTc63h7+EJt0Iow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193934799"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 11 Nov 2025 02:53:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 135EB96; Tue, 11 Nov 2025 11:53:21 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: max5970: Drop OF dependency
Date: Tue, 11 Nov 2025 11:53:20 +0100
Message-ID: <20251111105320.750131-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the only Kconfig symbol that depends on OF while selecting the common
driver for several chips. Drop this unneeded dependency and make the component
available on non-OF systems along with wider compile test.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index dbeac6825a10..0c39cce3821b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -896,7 +896,7 @@ config MFD_88PM886_PMIC
 
 config MFD_MAX5970
 	tristate "Maxim 5970/5978 power switch and monitor"
-	depends on I2C && OF
+	depends on I2C
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  This driver controls a Maxim 5970/5978 switch via I2C bus.
-- 
2.50.1


