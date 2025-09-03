Return-Path: <linux-kernel+bounces-797646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84418B412E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDD5E6421
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC92C3774;
	Wed,  3 Sep 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SfJ3DUc4"
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0F2C21EC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870021; cv=none; b=aXWS6nSBUGTG/2d0kdWqhnesxEbys9rviAfBt32p1Ox13AU+yUY3P804XFbHburB3Ose9d/Mk0jrh6L1iw57Zw/LNnRNmoyCcSPObiNK1NnomHXjTq3FaGlv1M0Y3hW4WJ0rBOtkBpH06zMDjt6IFu2bpqK4UG+mNbLugJ+pDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870021; c=relaxed/simple;
	bh=hFmR3pVdhT7xfVLKpbhJFsgBB3+5r+/8jlK7QV+iOBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgocCI38IjfAsiWQgfmsPSEwf5IDrC06jRzJzDdm5A/g+8RmQ0LHWRAUQ1uJwFLt7Udol2xde96I2AnvpWp57zTsJlXDWu6QcCrbBF2BrRyll385MQ07tuA5I3wTUAZnJEp3UgAls4nqggnCQX7SWA6rjvlWigjXCmXMeD10kI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SfJ3DUc4; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-52e6ff36cddso56316137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756870019; x=1757474819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSqF8u89jLv/Gbai9ll4AlOnIZ8yRMDq0tMj1xwV5eA=;
        b=SfJ3DUc4R1HrK6TWTCyLUp4c1a0p5ZuQ278IqlaKPnWsvH4kBgPGyOGYRcJpXgzYZc
         DcGwjuJLsmQ0GE7KO1TwkCxcWIHB8NxlZ4Z5A+3Y4jigS9fzz8UqtWYlYUQw08n0xtT1
         DN+UbIBtZHOA/2DmKFWMVzKzeVI0O0RBXiIIphtO8kphteGOB96hhRGYxChQeQSj9L9U
         10o/b+BUetE/9AD0TJzoFsLTmBtaQcYxFa8+skdkrA1Ki/kMswnJFRceAVj4eoxyrGV9
         b81QTO86gAcAjHybeaODw4PcyWPtE/+OKYC9RHdYeIpVc40l+EbuMI0U0gTZditNSP7b
         UY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756870019; x=1757474819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSqF8u89jLv/Gbai9ll4AlOnIZ8yRMDq0tMj1xwV5eA=;
        b=pKiZgFIJ/dUOkiRD6/qeMreSXI3XI/nXC4JbSViDntq3J31YXqDqBpF0VW+jhO7/wb
         CFDthhdD+ne3fhFAHoc74tG5cInHsIDrirOZOI/4mEsMlIvmDe+8ykcxhez57M6zYX2X
         1VY8UfEhVju73FqKJ9cqHR7oqMjoVVyF5SRsj6mJmRGJlmV3JMBJUoozzKcE28dqbPXY
         AyVO+Rd6iRk7kKDHXhJY6I86cUOq3PojsmfWRI8X8KgB7cmUEhoWhEyzEW4AIypOZQaF
         ZBoeKAmkSC4jX7/an9suhgr6mPQDf6mN0YfDEnZ7vL2lX8lPhxd3jUTh/IRegKH/dWQs
         XNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmM/WX+ieGuKt71qqES9lfVOx6NZrYF9vUyiGSJ087QQZ0J87PcYZkmA+joUr+Bg49Q7iEiD1L8mREOmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPAry04jmq5Y80ybJ0n5Do22uSYahJtlKY2HxQK0xMMl5q2c1
	1IpYkSddjlMobNRe/fPPgI1GV0UiXQLj9e15Kg7wlHkzucvL7kfsCAER/N6uz7hY+p1k4KMUVNp
	gFMlATzOWnxWrcpl/UQ3FF/bRYx9DDpn/4c7jsXjxyq8Cmy84U0Rs
X-Gm-Gg: ASbGncsQxLFRCJDmcJNX1Jcn2JuIvWHPAKKQRo0/oKT3H/w4fPhk+hGWuWp557CU70g
	lCPyxsuF55e+IbF6/id8ItZEkByUn1TpLFaIevcpUBt1Qwldge/Sj3+TqzDhMNvJ5SK5BEZd/XY
	0V4h37RWkUCqyu7jyVgaSi2/3DQdiLgpnTRxfHi03Kzdut/DwteeYLrFB9ZqwPchDXPjyZNqsRS
	1tuZevAwyETFHuubrs7SHU9dPeHZsE1cmPTQrFRtbxyVV9d/Y8VeHcsyqgS3HCyvVMBtZbs9qLb
	mc2WL+nq6FO6cdB/Jsyj5nTDbmjHMLm4E1I3Lp0zXG7facBbVyMwEth0kA==
X-Google-Smtp-Source: AGHT+IFehSnrrzLkenHFKrvF2fQBZ/Hq0de+LCBKeNQJKzQhedbF9DLqRHrw6Abi/Dp8WwHLWwZOnSYtgIX2
X-Received: by 2002:a05:6102:149d:b0:525:df9e:936e with SMTP id ada2fe7eead31-52a343e4a6cmr1745805137.7.1756870019067;
        Tue, 02 Sep 2025 20:26:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-52af1212c63sm1232773137.3.2025.09.02.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 20:26:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D1CD2340344;
	Tue,  2 Sep 2025 21:26:57 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CF728E41964; Tue,  2 Sep 2025 21:26:57 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/4] io_uring: don't include filetable.h in io_uring.h
Date: Tue,  2 Sep 2025 21:26:53 -0600
Message-ID: <20250903032656.2012337-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250903032656.2012337-1-csander@purestorage.com>
References: <20250903032656.2012337-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring/io_uring.h doesn't use anything declared in
io_uring/filetable.h, so drop the unnecessary #include. Add filetable.h
includes in .c files previously relying on the transitive include from
io_uring.h.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/cancel.c    | 1 +
 io_uring/fdinfo.c    | 2 +-
 io_uring/io_uring.c  | 1 +
 io_uring/io_uring.h  | 1 -
 io_uring/net.c       | 1 +
 io_uring/openclose.c | 1 +
 io_uring/register.c  | 1 +
 io_uring/rsrc.c      | 1 +
 io_uring/rw.c        | 1 +
 io_uring/splice.c    | 1 +
 10 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 6d57602304df..64b51e82baa2 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -9,10 +9,11 @@
 #include <linux/nospec.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "tctx.h"
 #include "poll.h"
 #include "timeout.h"
 #include "waitid.h"
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 5c7339838769..ff3364531c77 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -7,11 +7,11 @@
 #include <linux/seq_file.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
 
-#include "io_uring.h"
+#include "filetable.h"
 #include "sqpoll.h"
 #include "fdinfo.h"
 #include "cancel.h"
 #include "rsrc.h"
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 545a7d5eefec..9c1190b19adf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -77,10 +77,11 @@
 
 #include <uapi/linux/io_uring.h>
 
 #include "io-wq.h"
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "opdef.h"
 #include "refs.h"
 #include "tctx.h"
 #include "register.h"
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index fa8a66b34d4e..d62b7d9fafed 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -9,11 +9,10 @@
 #include <linux/io_uring_types.h>
 #include <uapi/linux/eventpoll.h>
 #include "alloc_cache.h"
 #include "io-wq.h"
 #include "slist.h"
-#include "filetable.h"
 #include "opdef.h"
 
 #ifndef CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
 #endif
diff --git a/io_uring/net.c b/io_uring/net.c
index d2ca49ceb79d..cf4bf4a2264b 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -8,10 +8,11 @@
 #include <net/compat.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "kbuf.h"
 #include "alloc_cache.h"
 #include "net.h"
 #include "notif.h"
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index d70700e5cef8..bfeb91b31bba 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -12,10 +12,11 @@
 
 #include <uapi/linux/io_uring.h>
 
 #include "../fs/internal.h"
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "rsrc.h"
 #include "openclose.h"
 
 struct io_open {
diff --git a/io_uring/register.c b/io_uring/register.c
index aa5f56ad8358..5e493917a1a8 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -16,10 +16,11 @@
 #include <linux/nospec.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring_types.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "opdef.h"
 #include "tctx.h"
 #include "rsrc.h"
 #include "sqpoll.h"
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f75f5e43fa4a..2d15b8785a95 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -11,10 +11,11 @@
 #include <linux/io_uring.h>
 #include <linux/io_uring/cmd.h>
 
 #include <uapi/linux/io_uring.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "openclose.h"
 #include "rsrc.h"
 #include "memmap.h"
 #include "register.h"
diff --git a/io_uring/rw.c b/io_uring/rw.c
index dcde5bb7421a..ab6b4afccec3 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -13,10 +13,11 @@
 #include <linux/io_uring/cmd.h>
 #include <linux/indirect_call_wrapper.h>
 
 #include <uapi/linux/io_uring.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "opdef.h"
 #include "kbuf.h"
 #include "alloc_cache.h"
 #include "rsrc.h"
diff --git a/io_uring/splice.c b/io_uring/splice.c
index 35ce4e60b495..e81ebbb91925 100644
--- a/io_uring/splice.c
+++ b/io_uring/splice.c
@@ -9,10 +9,11 @@
 #include <linux/io_uring.h>
 #include <linux/splice.h>
 
 #include <uapi/linux/io_uring.h>
 
+#include "filetable.h"
 #include "io_uring.h"
 #include "splice.h"
 
 struct io_splice {
 	struct file			*file_out;
-- 
2.45.2


