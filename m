Return-Path: <linux-kernel+bounces-778699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E9B2E915
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216673B96BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C593C2F;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpw2jOXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEC2D023
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734411; cv=none; b=DzXiXNJdqO61x++FDkyNriLGUPZH88C78bD5Su8zRF0S1ij8/o8qWoMpVYykyUso4bgL52gWUf2SL+aHPiFdgDatp5Bmru+9nkguENisYdMpU8AmCtD4gEC2oI/peTTi3xMg10xNG+FBX2XfEIDlwWOypVL3m7NZrMIB2LC9Ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734411; c=relaxed/simple;
	bh=wCQzGlDHznXzjPtwUvnhjy0TbrJKp0JW6NNGxeeeBb0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XlETSrv6IKFgLaTfigf85B11QsE9YNLUp+yGkWASGRz+XivkKQD/cYQMpK9ip+fz3pHsuDaSxENM/DX8fzY3gcrXiOVtv1iQBtJc4Xqtj5jaAdNgJ3PPsSaXFdjHdGYCECH7uW3AyZ8qxPI1FUrvizjGBTgbpXbJVpfJ8qAEHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpw2jOXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3B8C4CEE7;
	Thu, 21 Aug 2025 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=wCQzGlDHznXzjPtwUvnhjy0TbrJKp0JW6NNGxeeeBb0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rpw2jOXaaji3dRqdT7BPCKj4ushl3NAc1x+hkjtNAUKsF2A9SqYaAwdfVsTeZkvmC
	 BYMxFogMRH/HurHkS1SVDUrsL75prazVRpBAYB84L4PYvNTBVd8NEFSgmGQL9ATtB0
	 LwgDNx1nKSAgFSJvU2n1g/YrO2fy6E3ESANnEve64DDAIeJJfLhq79s2jv6JeOUGea
	 JvvltQh5vLAe4w4YNAdTU9ehaiFc4ktalr40VIQMBX3HB6OtG+AT9A+EvIjEwkN/sG
	 1pf0vQMkmsATegRtyyn6eaA7lL9cq2DEdUMtCdLZ2fdGzpCY2Y+1W+72bntZJj0JUw
	 XKJmpLfJZWD/Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj0-000000013cl-1wAW;
	Wed, 20 Aug 2025 20:00:14 -0400
Message-ID: <20250821000014.311912752@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tao Chen <chen.dylane@linux.dev>
Subject: [for-linus][PATCH 1/6] tools/latency-collector: Check pkg-config install
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

Link: https://lore.kernel.org/20250808040527.2036023-1-chen.dylane@linux.dev
Fixes: 9d56c88e5225 ("tools/tracing: Use tools/build makefiles on latency-collector")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/latency/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index 0fe6b50f029b..6efa13e3ca93 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -1,7 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
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



