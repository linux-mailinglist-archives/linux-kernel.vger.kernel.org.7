Return-Path: <linux-kernel+bounces-801347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED2B443F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA42B1CC0918
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B930C341;
	Thu,  4 Sep 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qc9omjGs"
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDD308F3C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005754; cv=none; b=bHRtu7CLP0vxduWx6ADNxRtxmVKlLpO0nRAEp2Lc8msa3Wr13Zc1h9z/Fb9ut8TlydyLYeDLeZpp9EdYojWIVQkkVO2V0mbEmu+G8ik1SQg7oB+0e0gnTwZn20PAQWp31/5KUO9peV0gYHlWhmTloAnBD3Fgh7WvmTeILcDB4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005754; c=relaxed/simple;
	bh=S9+J8c6uJoGkSJ+/2mNDAmkmcjUh5kaHlPNxJk08Y9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIiKzXsD0MmdjuSi1E4tPWWE52VlTIQm4BAFac5i9jw1OA39rF3ajKLPt4dCiUevv7V/vKKJtnXFzCNCSRK+Us59qyOcqARJNHXZQic1rJhFi/Y1gPWX7M0rD8JhM8IELkamanWMeedb82H/Cpys+Mva8I/UQnBLWywrC4d3cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qc9omjGs; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-745619dbd66so63075a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757005751; x=1757610551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFPj+XIfDMBq9+8k2vp7uNfG6or9K1IoHmIuf7RRueQ=;
        b=Qc9omjGsb9EUdJbsI2Zx0z91FndDcYGStRE9/D7zPuij33WmZ9Gw2nL81IPCuXbLgH
         WumPfwmn5A5PBesWruSMIG/Wmyuad+xCRB4j/qc0h1ID/9wEr0AbmknXohI93qxBRK9F
         2E24yRZgM5uHnyZ6p4fCk3aJoMtNbKPASRjruDr63C6FG54JSOdNwNG40gVNMe/WzDxg
         XTh1vjUW0g9lukmPMwsdozxns5nhoWUIhQAHhTlISCZTcIS7+noOKCJY1WgLy0yCWBIa
         AkTYk3XCSK6DGHGZCNCUtq8+mDIF6xaxvIQR6C/1yEE/6p0WwBCjwsWrtOAgkSbuTeKU
         UK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005751; x=1757610551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFPj+XIfDMBq9+8k2vp7uNfG6or9K1IoHmIuf7RRueQ=;
        b=pw7suOrc/qZUvz8bdBHxt2e5UZo+5T5G4hozf+bD5U6KVWJQfeG02vXE9cwLPDgb8P
         06SWE4czqcu8ygHa00n/3YzMHbpzbNPSuwWT58taRNqCLD00Q1ScajGN4Ca1agbI8DX8
         sLJbfQDLW9NnxAtGkssmh9QJsDDEpjMbe3bqerJNqVHO9/qq1MFhVVLJeJya19WM5w9d
         xOoymaqgMxU0GQbVtX1F4p9v4iPBCFhJl+0eyhYmWG2hmuWRfJY48oUIFwk0vB+MK9z4
         fr5VF9Q9HQ3vef+ShovSXhLnk42RK1BAdfAJ1JwVUrbqFwUNDBNx7k5dmgdy2hV9P5xm
         q2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Uz33V4KFbEgUAu5PgU6VyR7pCE0tUOh2CapSzdVkj32bMl7WcOokkZ5KzY7NVD+mOFohbZvxbfH3nOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/yV8GCKAOoIW4QKIiRNVMfy0VSIRuaVtp68IMZsP+1nwNSxA
	J49AU1gE2Kqk7QcY59mPYzStbkqrLSp28Eko5NUqF/yVGxRG4isgFi5bYTbbygWjI9p6qDikXAM
	qnsr6qfq6gYvN6edHki5pXZYzjCPoJL2kw8vP
X-Gm-Gg: ASbGnctxYtOdJN1ouFX0BpoF7MtII7VICjQJbgWl6ouea29+HnH/Lxxy0jw3Ohq0HZS
	FZy4rp7PkSclIfuzaKJf3sRCyvBYMlrrr9Pq2yWMYBr6w33EUlOJ0Fm38h5Uwh2oqwkeR6M/ott
	CHM8EpU5N1AhUWy76CHh47nq08ZfAbH/pbS733KClwpuH2EtVr2Wul1aN6co6VZm72bXqsymDkD
	egVWmDna0TA8i72jKHgQ2I9MNuc3S14Bzc4WjIqqg2Hb5Ny/8JXT8AmTqsYcSMx5ET7UH+delSt
	Tmebutl9zsa3dRT4EhwoyfKcnS6nENBLYBXvRrFrs4AgH1p/cY60iDCcGi5pBDXG4sAt+8N9
X-Google-Smtp-Source: AGHT+IGJgS/IUffF9p63LvHQ0o0R0K5s5za+CBYy1R4Hn6xzANPlWmmAlfDsGucMj62UyDXUUOiW8+21PSu+
X-Received: by 2002:a05:6870:4208:b0:315:288c:ae99 with SMTP id 586e51a60fabf-315bfb08699mr5650927fac.8.1757005750749;
        Thu, 04 Sep 2025 10:09:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-319b4fcbc18sm698100fac.0.2025.09.04.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:09:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0B8A73407B4;
	Thu,  4 Sep 2025 11:09:10 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ECC10E41979; Thu,  4 Sep 2025 11:09:09 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/5] io_uring: don't include filetable.h in io_uring.h
Date: Thu,  4 Sep 2025 11:08:58 -0600
Message-ID: <20250904170902.2624135-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904170902.2624135-1-csander@purestorage.com>
References: <20250904170902.2624135-1-csander@purestorage.com>
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
index 20dfa5ef75dc..42f6bfbb99d3 100644
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
index 226fea2312b5..f99b90c762fc 100644
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


