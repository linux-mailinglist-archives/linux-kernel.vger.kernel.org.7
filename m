Return-Path: <linux-kernel+bounces-767986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65BCB25B92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C1B1C85C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C323236D;
	Thu, 14 Aug 2025 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH5H8SnS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF981BCA0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151587; cv=none; b=Af3JVdzeZgilPPFXbir5OsliWIYnAReu70J/GDr1+dW8s90+W6OGzXDEWIO/6zIWYq6+fgvmK28WU7KiWYQ2vk5Ob6W1ZEGxwcUtFAF1wZi7zcWJbvzTiqkKzQcoT1gRp9yOQLuEHMGfNr2Q1JRpOzrmdjcAeumkFIe7h8qX2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151587; c=relaxed/simple;
	bh=JuVy2DkCmG2B2BgRQdaH/IlofMa6+gNOQGrReSzMNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJU0DqshvzfC2lrf3K+EiIEVjb+036kfifVifLEHGllybsSJmOTZmM7aM9hMmtDUJqBsGQrpobO3oQPjTv5Nwr0j8xUnsu1dyNnzaa1/LCTaaR5iN22O1oz4OpCHgPsB1iJ1tw2w8shUo+bHoaxifngzpWzU0Kql5KHo/lix05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH5H8SnS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755151586; x=1786687586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JuVy2DkCmG2B2BgRQdaH/IlofMa6+gNOQGrReSzMNvU=;
  b=GH5H8SnSG0XNDvJy/Ww9gIrN0aQuuwao/THIZ5kwBXAdgmcuqNF112GN
   exOn9pwKeG07bll0j7LVZf4ItEbrp3b1znQwfw/zK86ihzKSXUCprGITR
   EX1yxuu4I4ekdqlel7Mi7c1WGDs9Yfm12ONUdsQqwrKldo5rCpd0LHl9X
   W1blLtxJ87BWIBHHmm8f3TE6zbkGttgB2OqGN/oPLuNoIkuLGb+VEkKX4
   OQx9WlNdqwcLoVdgBeT7T6Y9UvPn8poDqP5FoFUCcqV99J6qI7igtRuqG
   NjVvYt/EBgGD13TQPZDof+vSC4Ml9eHOFLQEMNY1LUcKNuVylo1Hxmxez
   w==;
X-CSE-ConnectionGUID: 0pC/k0KqTHCstoqR3oqEpw==
X-CSE-MsgGUID: CuNar7kuSTa0WQtLsgr8mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="75030876"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="75030876"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:06:25 -0700
X-CSE-ConnectionGUID: 8WLOKHulSQqEW63NL1ds7A==
X-CSE-MsgGUID: HmKqnN+mTRmnP7P66Yb6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="203862579"
Received: from junjie-nuc.bj.intel.com ([10.238.156.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:06:23 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH] lkdtm: fortify: Fix potential NULL dereference on kmalloc failure
Date: Thu, 14 Aug 2025 14:06:05 +0800
Message-ID: <20250814060605.5264-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing NULL pointer checks after kmalloc() calls in
lkdtm_FORTIFY_STR_MEMBER() and lkdtm_FORTIFY_MEM_MEMBER() functions.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/misc/lkdtm/fortify.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 015927665678..715598226037 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,6 +44,10 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+
+	if (src == NULL)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
@@ -109,6 +113,10 @@ static void lkdtm_FORTIFY_MEM_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+
+	if (src == NULL)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-- 
2.43.0


