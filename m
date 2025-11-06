Return-Path: <linux-kernel+bounces-887686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50627C38DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0123B384B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA38834;
	Thu,  6 Nov 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s4khbDwW"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC1242D72
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396245; cv=none; b=UfubmrRllYpowGClUiaFDRxWZjoUSoYZ1xyodHom24nkW+t8ALExFxSPaJLR7wVErnrDFJ22BC6g9hynaTz+8WMvo4Alt0lwonw7aNxRqtpp1J/Vk2ArNfvApSBDKGuYLNNNqRmquHzFkw+soo3P/lRvZ4H4aOJnvC8/uY73EE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396245; c=relaxed/simple;
	bh=88Y4Fzkuyb44cTtdgkZImDMFHK3mk57+XzrGQaNYdeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMPJRPsh30Pgr9SPwApaGhuHcJrJf6/L6vgicPCVcHi6JYNHabSFGInoJsb92s9TDycCg+b3rg9C31WN12+3Y0Ru/8r/Xk1AghitENp0mriWNMfY47URn2+y+28Bn/aKmTa+w9nnyCRtPxgOXahtImfGKgFic0gfcemY7Px32J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s4khbDwW; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762396234; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A4LB9QeXq6PqZy/d5x1sqzHwaepaEVOdKeBhBHktmu4=;
	b=s4khbDwWm2BsxaH3DpC7onQQAKjSds2qRV1wLGxL4h6iVkSLUVzxetrWs1s7p44pAhQtDrjZrC7oIeNliVp3jO6FKE/5TZ2abtyUQ0UAfbG6ZaPv3kq5BAjA7fASq+QtIvc16IfdZKg1yUQS2ODXn9KdQWRlEXAc0Ej5iZKaC8g=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wrne7Zk_1762396233 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 10:30:34 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Lance Yang <ioworker0@gmail.com>,
	paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 1/3] docs: panic: correct some sys_ifo names in sysctl doc
Date: Thu,  6 Nov 2025 10:30:30 +0800
Message-Id: <20251106023032.25875-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some sys_info names wered forgotten to change in patch iterations, while
the right names are defined in kernel/sys_info.c.

Fixes: d747755917bf ("panic: add 'panic_sys_info' sysctl to take human readable string parameter")
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 0065a55bc09e..a397eeccaea7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -911,8 +911,8 @@ to 'panic_print'. Possible values are:
 =============   ===================================================
 tasks           print all tasks info
 mem             print system memory info
-timer           print timers info
-lock            print locks info if CONFIG_LOCKDEP is on
+timers          print timers info
+locks           print locks info if CONFIG_LOCKDEP is on
 ftrace          print ftrace buffer
 all_bt          print all CPUs backtrace (if available in the arch)
 blocked_tasks   print only tasks in uninterruptible (blocked) state
-- 
2.43.5


