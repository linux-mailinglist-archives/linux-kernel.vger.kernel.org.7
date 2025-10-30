Return-Path: <linux-kernel+bounces-878130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6CC1FDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CB133476C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655933B94A;
	Thu, 30 Oct 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNf8xRjI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F12DEA74
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824261; cv=none; b=rXH5GsIm4ru090EqJ4MXcWGRPTLdKzZnpUTlF5d8MEqcNifAdCSnIcb978ISWLNHAF513sR/IycTW0TePE1iS+odA9RMOyE1MF/Q0f1xX+jNzQrwHecew0ySGpJxwhkkSfOVVUdyLhyt7xGneoGTkLlnp5ojEjoqvrBNygd9u1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824261; c=relaxed/simple;
	bh=7W1qZnO/sR0ECU4Mi/Uts9XJ0sXwDlx979UEUhJUMwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYzQY1Zp1N+/VSRrue/+hT0jPlozxBxS804zQlZSZUXcWY6tsZMNSs2vBmzDM7+lDZCVHp3TLlIJhxvmdN11NXNqYBG7rCiVntxUcsm78UCuQTPgk6khcC7Yh1lbLv3XFyZzuLYYKvrn2TPBMTRJd73mK+lXzClO9LA0/RLizIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNf8xRjI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761824259; x=1793360259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7W1qZnO/sR0ECU4Mi/Uts9XJ0sXwDlx979UEUhJUMwU=;
  b=NNf8xRjIHKYC6afHVLl4MSeLnJAduP+6IIqz5S9wBSN+9U3yRSURpUIb
   T09VyUJdzjU9OC8RUqKOiHOkymr2ZgWmlpJXtjTCHAN3z6j7ts65yqZDm
   QdZNLOnyHdWE2/MOHTITWkCFpC24huQI5+bb4R7PReP2frlAJLxTcXjKV
   YsBjfHzpjhFmJRfaqf8tSLzbsS83Y+liK0wRUiwhuJgixFVAiNOqWJrsW
   D0BA9K0uNTH7NmVRopq8CJC8NhJWYB8Y9MoDim2EfwZW+73EUkyyevOss
   LeFTFkJc5v0OF/JsIJR9n8IFJbiXAvj+s3IiR6vQpbdzOWksclJr+knxF
   w==;
X-CSE-ConnectionGUID: 20TLUwTyTx2eHjY1tCqVcw==
X-CSE-MsgGUID: 2A5Rgb8cQTuRqe60NZJC5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002273"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64002273"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:37:39 -0700
X-CSE-ConnectionGUID: KhbTRsytR6yzv3QXTGP1Tg==
X-CSE-MsgGUID: I+5v9/FuSJmDuzCqImj6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185129328"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2025 04:37:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B5A8895; Thu, 30 Oct 2025 12:37:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/2] mfd: ls2kbmc: A fix and a refactoring
Date: Thu, 30 Oct 2025 12:36:32 +0100
Message-ID: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just an ad-hoc fix and refactoring as I have noticed the problematic fix.

Andy Shevchenko (2):
  mfd: ls2kbmc: Fully convert to use managed resources
  mfd: ls2kbmc: Use PCI API instead of direct accesses

 drivers/mfd/ls2k-bmc-core.c | 38 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

-- 
2.50.1


