Return-Path: <linux-kernel+bounces-895263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89FC4D63A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E66B4FAD08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA353559C2;
	Tue, 11 Nov 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3u6bJhx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD033559E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859978; cv=none; b=W82ebsv8YZMoXkBKcR3mPTL4lgkrTGX5g0EfXNZF4WkgmEZJKydASYRI2uZ78byPC+EpeHf0Iz8ABBzYO+G4TFAFu4uAMQ3EmlGN+D+xZV79FkXwFz7J9Psdbx7RX2XTBiwsDsmkIDO74aatlmzvAAD5JxjpZjIARViUny6QlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859978; c=relaxed/simple;
	bh=iFxkT7B47RCS6uuoDSZiQSPOjd+qK9G8OyWkqKGNTlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+PSMcd8jdoZX3DF2OE/rBKUCq4nl8IodZqz83Mx8n+3IMDNulj4XdAVUy9yEwDxvSr4TWnTbxnPy9wkdGPu575zDrAsxfgQ6J0bLHMWM14m6IJf/g8ZjhekhuNb1K4vjKIPKKZMgONP69miktTAwJD5xDRQMVkehdNpyvyeyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3u6bJhx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762859975; x=1794395975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFxkT7B47RCS6uuoDSZiQSPOjd+qK9G8OyWkqKGNTlc=;
  b=j3u6bJhx+6kln45+JnFe82dVWKnrmy9wTr8TccVHfJDU134qDDm9pxlV
   UsUyIIqNkDryaFMWqtBAwA79S1TjXdr+TDTD0wmXzkgZU6yaxnDPg5P3v
   nCRfIOGktfymYHJ3+oeIW1yjUfJlmi2phSA8BhnNCe6UNHmJJMDrf3Xnw
   kqHhUkKTJOd/VNK5bChaL3hwO5fH+MpnSvmA4nfy8wJ7tQeUmVA3Xp4Q3
   VBMaSNymillsFTUt06mH42a4BTjwLUGrvZnSqb/jZ5jkPhR0h121iD2UM
   j3RQTtJL2IkCqzx0iDBgOuwv51BdqBEA3ThO4jl0OWhzTZMd+L8QfSGRc
   g==;
X-CSE-ConnectionGUID: 6GFsSB2CQK2uIYLdW5splA==
X-CSE-MsgGUID: dl20xMRFTE6oycEEWS8hKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63922921"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="63922921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:19:32 -0800
X-CSE-ConnectionGUID: LM+Tx7byTUSiOs06Nl6lFQ==
X-CSE-MsgGUID: c/kstrYRQOeX5wjS4aPC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="226200395"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2025 03:19:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7B64397; Tue, 11 Nov 2025 12:19:31 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Cc: Yixun Lan <dlan@gentoo.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] mfd: simple-mfd-i2c: Make ID table style consistent
Date: Tue, 11 Nov 2025 12:18:35 +0100
Message-ID: <20251111111930.796837-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111111930.796837-1-andriy.shevchenko@linux.intel.com>
References: <20251111111930.796837-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lines in the OF ID table are written in three different styles.
Choose the most common in the kernel and update accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/simple-mfd-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 0a607a1e3ca1..5fd0ef3fa44a 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -114,11 +114,11 @@ static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "fsl,lx2160aqds-fpga" },
 	{ .compatible = "fsl,lx2160ardb-fpga" },
 	{ .compatible = "kontron,sl28cpld" },
-	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
-	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
-	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
-	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
-	{ .compatible = "spacemit,p1", .data = &spacemit_p1, },
+	{ .compatible = "maxim,max5970", .data = &maxim_max5970 },
+	{ .compatible = "maxim,max5978", .data = &maxim_max5970 },
+	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705 },
+	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a },
+	{ .compatible = "spacemit,p1", .data = &spacemit_p1 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.50.1


