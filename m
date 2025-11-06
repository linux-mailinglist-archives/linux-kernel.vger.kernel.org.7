Return-Path: <linux-kernel+bounces-887987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C41C3986A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03464E6AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546533009E2;
	Thu,  6 Nov 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbmXX43E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE43009CC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416438; cv=none; b=SFGcCipZJfkSb2yb2h5KYTDWv8WSXLxvlUaISoQTiLGGmp16atSrZ+hrheVXT0+KKgY3Bed980blNzm08nrzNQ8manhzUw5d7mJRmw0yXMsbQGgaG8diROnxvn1Kb8tlYTGU6/E6XmkcIv2pjdwCyN61Fjek+rLtx7DCkG5kRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416438; c=relaxed/simple;
	bh=U6NmHOZkcL9CSKmo/Oruq2767A5um3Nc6dpwwcZs+4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtwQXWSar88+DLhuu9R/wA3C6OJAx7lIRMmyLMgQy+/f33QqzjXgIZMPeVQBW7e6NyR7d9k1gLUzDhxDrkH33CpuT5c9Oi1NrkoNriCt9Wc3wGH8c6EP1BKB1evh2klzpUOWjbFn6sXpWHnOafhmI009/fNqKdKTVL3Ojl5EB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbmXX43E; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762416437; x=1793952437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U6NmHOZkcL9CSKmo/Oruq2767A5um3Nc6dpwwcZs+4s=;
  b=UbmXX43Eq8U72Pu8ipXtGUSxXSnacPADCKhvcRw4Jye/5JNtSj0luZYF
   hteeqJ1QP9M9OH8hKt+f11/tUUoHzVtm12B+J6Poav/1NYOp5FDa5iIdx
   r27aHM6zNlxS4fHXZUnexY2stxWVa3yjZUzsqbCgK8zW7oJWBCIvXWToi
   3G54KUWLQi/tySav7n9j3M4DTfaBAj3P969WGSijNYkP9SZWqySIVJtjm
   ZBUla3Q3nx92ZdS9gGxMYf0N3InEdgi+Euzw3X6tUDPWwv+jcFLge5ST7
   j4HLYi3IT2/HafnMhp5178H/74/HdUpWiOKK7Zk6yPlOkaUPTtJQ9o6xo
   w==;
X-CSE-ConnectionGUID: Q8kV9gZpQ5is1SkPZP8lXw==
X-CSE-MsgGUID: jRLDW8xqSFGf8iEI1JMdpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64454433"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64454433"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:07:17 -0800
X-CSE-ConnectionGUID: 2GhQB2JTQzSLW5y4VQgIIw==
X-CSE-MsgGUID: rEIiiUpYTZip1tgBVTxZ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187974683"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 06 Nov 2025 00:07:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D7E6A95; Thu, 06 Nov 2025 09:07:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/2] bitops: update MAINTAINERS and fix hweight.c
Date: Thu,  6 Nov 2025 09:02:49 +0100
Message-ID: <20251106080712.1885074-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MAINTAINERS and fix hweight.c to avoid kernel-doc warnings.

Andy Shevchenko (2):
  bitops: Add missed file to MAINTAINERS
  bitops: Update kernel-doc in hweight.c to fix the issues with it

 MAINTAINERS   | 1 +
 lib/hweight.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.50.1


