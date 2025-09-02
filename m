Return-Path: <linux-kernel+bounces-797390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4038B40FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8477B490E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9226D4F1;
	Tue,  2 Sep 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="baQ4c0bb"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD626CE02
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850892; cv=none; b=RHoKdZF4NplLnJaWlVxZmGVTXo/MopcvmGsaaiGxqDW0inycgJgLIDO6gYrRmcP50el4BJQbagRPxuMFju0BP+/c0pPcCSMu2uKpvKA0iY6WBEQ1NuZ6B32Kjga29ikvHHULKnO2YHQRFbqO5YY5+V0c2k5fQNBxyiWb2eQJrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850892; c=relaxed/simple;
	bh=hFmR3pVdhT7xfVLKpbhJFsgBB3+5r+/8jlK7QV+iOBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ8SKaePM8lhe7o0785bWoJSP44wjf7T7tJaB5PpHj+CwEBhd/uIY6Q7Yrn9xH863k79b3avrrwfncgKt4HzjwepaOLlnfA4ZvLHeRJU9XHw+KkSZFOT6GAHvZUrfyRNcqnVbOhX+Lj+DzS7EPSODJ95rD4XXqYx9FbGWLe2RU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=baQ4c0bb; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-24602f6d8b6so13540195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756850890; x=1757455690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSqF8u89jLv/Gbai9ll4AlOnIZ8yRMDq0tMj1xwV5eA=;
        b=baQ4c0bbNpsl5/vhYatrDV135lymVK7/1pkNwSyBinG3DcpesPW9WwXLvNZgr0jLPC
         PNApdOPNAG2Kh3kEg4FM+L3yKOglPFotm7+YvGCePcBpBlz82MxM9+vMLb4FxgIkWIGi
         jJqXOP761BRx7nx3ZikY4gNAaeYhAC3bvtAV36ibXeghQzLBtOeaO8cwp5p/H5YVTnG2
         JGsLPOMQt7mmh/xvoMYt6R6zUUNOQ+IjwxLzhMCBKZ1kTOchvIW6aN5MwadAqoxnRwMk
         9q4h/pPPxBeE64tDBLxYut6uooxnYLvUJ6NQG/rjLaTvnl2TX654jFRXEDNOyV5SODJ7
         BYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756850890; x=1757455690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSqF8u89jLv/Gbai9ll4AlOnIZ8yRMDq0tMj1xwV5eA=;
        b=YmQAK0QOtQNMbLSkIlHKY5I08dVRakP+PGxCP4chlV4UbM01oRDz5Z4bGrxcd224Ri
         P5gTg90hAjH2nXTKrp6iUFBWLpTA0xD0g2rNf3ucxlu1aqgTyZuLoCtnLdBhqe7bLjVh
         hdkeF4J9bAocCNuIXNi6K9Z09CfdcLc6LCKOJrq/f978rcfmveDefEljntMoZr99F7I5
         ypf+B2MseBkkgP5FKGcdhQlnplOmWiZxdeqxgCkwDAzNHRtZzsr3fNZnDDiuLEsCgRiC
         deuUKrSDQYPbNMO76Qps/3Y5WEzy95R7OeKxPAgvYtGGfUREZB4h/nQwFFCaBEE0DMt2
         2E5Q==
X-Gm-Message-State: AOJu0YwCTziH731RqeO1J3E9MMzb4XsASICEke9kSeKC6ueuhhibzair
	8yeO7gw0fg3H+PtHNbFTk2rPVzq4fFqeg8DdLB3Q43Ma83mikeFM7tiIA/5+LrueOLFZjVFkyPB
	el8Q4YKNUtWAhdIn9BCPTHFayZDZHtQZiYUuDz/JHfH/l94J4hJx3
X-Gm-Gg: ASbGncsliVvQwT/8Fu+2hu0IGvAYNzMrp/0O2zzCa3CF5N7w1YrCqjg6yXk1F9MsTld
	8mZLT91aUccFHivst2ScEIoMQy+2aSWFzkZiqbkPfxJgLxtslbGnLhokUZ11cELOFn7ThNpSbcx
	QQD3JcKbsDjiU568EV8PBoeBDJPFO2Fn2BLINHUHQSvVj9dHWQaFnaJKoRfAosaNowk9Xrxf48g
	cEae4/5xCZBupMenHOxgfjU53T+fS63rCHqfIDwdwA0LScKq7iHGQub4JWz03xQyde4wyiTz3Kl
	0iez3weat5Crk4SNeyaZ4Lt8MUqNlUSpIY3f/74CeHRJGUD4ZJXj1OFgLg==
X-Google-Smtp-Source: AGHT+IFQAxobPEyPll3hbTYQpYKNDg4/FRFYEZXeTUFwYEleQ/HX1aYVDJlg6pXG6yHMZNm2AiQG7ZPAjx8t
X-Received: by 2002:a17:902:c40c:b0:248:a01f:a549 with SMTP id d9443c01a7336-2491f27a5ccmr127708605ad.11.1756850889760;
        Tue, 02 Sep 2025 15:08:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-24c786c4e59sm1170365ad.20.2025.09.02.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:08:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1D51934049A;
	Tue,  2 Sep 2025 16:08:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1B334E41920; Tue,  2 Sep 2025 16:08:09 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/4] io_uring: don't include filetable.h in io_uring.h
Date: Tue,  2 Sep 2025 16:08:00 -0600
Message-ID: <20250902220803.1932692-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250902220803.1932692-1-csander@purestorage.com>
References: <20250902220803.1932692-1-csander@purestorage.com>
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


