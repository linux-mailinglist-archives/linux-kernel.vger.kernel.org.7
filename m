Return-Path: <linux-kernel+bounces-807194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46008B4A16F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9C71B28621
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584C2FB086;
	Tue,  9 Sep 2025 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHgoKVVR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FC257853
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396606; cv=none; b=FGOLEn2wx7b4is8vbgRxFl6EdtQ7hKcGRW1ocLfcPkspdHZg4+M5oI+AmtSQfT3P+xkJ7GayPRdgtR/1jzuOP2vQruVe2VfXD9IIQKIvZO9Yee9dF0AI6OZAYL7g82iC0MArjlmk5oMnrQM9+2VxFnS1D2OzxGb8nR7ByqVA24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396606; c=relaxed/simple;
	bh=2bf2iKKo4zMs1TgQjTkYPwQSxOyFHpgz2inMqMIRFvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teBFlx70UR+tyO7Ujq2OizawLjwcGZ+wfNwhxipBr+biCeMU47DiurkTosmXBKMeAOz8ZKXKaCeR6Y22M6Td6MIzvtuIWw9uY058ao9qI9mJlywbc/ZUAB980SBDh5/gKd2WkgbZ28EwGaOazS3LZn3VvU9CQdWUXYOojkOh+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHgoKVVR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757396605; x=1788932605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bf2iKKo4zMs1TgQjTkYPwQSxOyFHpgz2inMqMIRFvY=;
  b=jHgoKVVRtJZBGQfybfe2o544rdZmoDpW4u5C2amj8Q1l/fy+vKp2DrD9
   9K64pAzLINnDyOF89UPWd+/adRa3IYKocOU/7YBPpVKxs50qHBXFDkbh+
   vMmfHyOvl1XZcF3NRtX/DbETHTp0GpdCE9Bv4fkz4yx1Sm883ly7FXToN
   b7HOFWADAkJ3v26EA1d79+zTJ20NA3xtD9owXBcaoWp9QY0Xhiw3G7vDt
   x/s0i/rSegU0XRCziWvi64EVtIiDlCpo9+yzOD4WKOtFs1GFIwdvPw221
   WakIRxZb7DU597LTMOMKZrD6la5qXFJn4guFp9emQqbTPiu31TvyEwoO+
   Q==;
X-CSE-ConnectionGUID: wBWqMjdWSGW/xCg93XDJPQ==
X-CSE-MsgGUID: K8ai0BXHQFmwxZCp5bqBJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="58883575"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="58883575"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 22:43:24 -0700
X-CSE-ConnectionGUID: xQxdB+FARhulFbqS8gJecg==
X-CSE-MsgGUID: qrVJgEDwQSq7RMVWMzgSXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="173787308"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa010.fm.intel.com with ESMTP; 08 Sep 2025 22:43:22 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] refperf: Remove redundant kfree() after torture_stop_kthread()
Date: Tue,  9 Sep 2025 11:11:48 +0530
Message-Id: <20250909054148.1573012-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
torture_stop_kthread() already handles the memory cleanup for the
task structure internally.

The torture_stop_kthread() function is designed to stop the kernel
thread and free the associated task structure as part of its cleanup
process. The additional kfree(main_task) call after torture_stop_kthread()
results in a double-free condition.

This pattern is consistent with other torture test modules where
torture_stop_kthread() is called without explicit kfree() of the
task pointer, as the torture framework manages the task lifecycle
internally.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/rcu/refscale.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2c2648a3ad30..2bfa987f4ba9 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1050,7 +1050,6 @@ ref_scale_cleanup(void)
 	kfree(reader_tasks);
 
 	torture_stop_kthread("main_task", main_task);
-	kfree(main_task);
 
 	// Do scale-type-specific cleanup operations.
 	if (cur_ops->cleanup != NULL)
-- 
2.34.1


