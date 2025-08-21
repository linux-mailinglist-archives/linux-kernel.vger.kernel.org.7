Return-Path: <linux-kernel+bounces-778700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18BB2E917
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE497BBD58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D817A2E6;
	Thu, 21 Aug 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrYHFYdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92615265CA0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734411; cv=none; b=Rl76nHUr/LzGUJPaAEwP4aoV33klO5ufw3jJJGA7b/sOFdCVSg2RUtAgIglvhpO+vHy7iY+uXtPfW21kjCwXf8FfY8yHYGlYozswtdbLXYbhZjfRpT3Co8F05iDODsagbh+UXBKI70fmZVb9sU9JZSyB4uk3GKkXASu1nfo8J84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734411; c=relaxed/simple;
	bh=rynmEzABuR7PsOH6QIS1a/CfJFN+KjviQjXtNvTrDQw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=diRpOmWOFpWe+5lXnRo4UirmdHp7tXvzR8OW7diYb7vbzXfZUPQaUsQJ97MT33MoxgxRYfY7vpbZPVc2+B3KNfMbyZDkO1kCp411LjUVl9lz4pFTfD1lxsKp2De/MFoQV6unOEVgoTsKkldWbs3EubhZqYAlrveZyyDly4ArHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrYHFYdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E24C113D0;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=rynmEzABuR7PsOH6QIS1a/CfJFN+KjviQjXtNvTrDQw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GrYHFYdd/pnlJ8pPy6ITA3MhokVtsJO7Oe4jhP3gX6LF20j8ZwVPEHs/zs870gOu5
	 Ttz/QVgwPBZU8D9qttyywsWnMd3Y2bChd+iKL3s+wXHHuYbOtU/5CmbhGxc0Vpyyyl
	 gA/eNwXx59u/JWC+4r9XHnbjb/40O7wEIfwhIe+Z3YgmE/qoGCgVPu8Xe49/lm4wal
	 f14PUvN8V6VhOvnXLcpx+GgjjYrGj2AsMoyJgMKtnUke/5vI7xKqA9XQ5aLROKJg1F
	 Z3myZotourYtZdExrqXwW6Wgez6pQ9rFy7r6rJd0V/sECJYpsEX51OloL0AoIiBACp
	 eSOiGG09wTtxg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj0-000000013dF-2d6M;
	Wed, 20 Aug 2025 20:00:14 -0400
Message-ID: <20250821000014.480414046@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:02 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tao Chen <chen.dylane@linux.dev>
Subject: [for-linus][PATCH 2/6] rtla: Check pkg-config install
References: <20250821000000.210778097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tao Chen <chen.dylane@linux.dev>

The tool pkg-config used to check libtraceevent and libtracefs, if not
installed, it will report the libs not found, even though they have
already been installed.

Before:
libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

After:
Makefile.config:10: *** Error: pkg-config needed by libtraceevent/libtracefs is missing
on this system, please install it.

Link: https://lore.kernel.org/20250808040527.2036023-2-chen.dylane@linux.dev
Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f2231d8d626..07ff5e8f3006 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.6
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
-- 
2.50.1



