Return-Path: <linux-kernel+bounces-802010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA7B44CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEE27B691D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A227272E63;
	Fri,  5 Sep 2025 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZU481o/"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3626A1C9;
	Fri,  5 Sep 2025 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047318; cv=none; b=F88yNoTI/0fKbym2jeelxdk/vSmjXGRi6zooSxp/pV8FWK9THXKI2SslTkPnRnePx3DAMhdzK388ENAzuThx5aFaNK9ddEQ1QuuDMJyUBWsAfe8j8j+FmoAMzjtSjSeHjaMepx93xHQQzhNqtCQINvr2QuUR9S9BAn2JMAdZ1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047318; c=relaxed/simple;
	bh=rqwRzAym8TL2VAc6twmOgth3V52HkvGaPDgGP66Qezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffM77blkVP+d2XxOLmfKVyxct8qIk2fZuOJwDFzj04qsqdhY/Lf2ZCI2oSgUhdI7qOqrX2/KqkKuIhJNcGUtUkIXhsz7taioo/ntwzrcwHhHtq6T9rYPR8A1LmLfR5yXP/xVXdeIJUeaaDYotW/Z8NF8uyu4D/kPtTcGaIEbtZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZU481o/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7209bd264f0so32510556d6.1;
        Thu, 04 Sep 2025 21:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047314; x=1757652114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZ4jyqAebdFk40dMhQCeBc/em7Z7GJAy4Tky878tJlA=;
        b=WZU481o/ucsRTumiF6KNFIfb4EA8ROidIwcIMCL2lwrjhnmDNEjkC0J2xmldvH7j5n
         GRSyd9V8Q+QPR46pe/9Dbh87zehvx3X7CeueREhEMa54wT86WYYUz63jSVicOkc6EMHO
         oponx1L2/nyht55CizzhKAWNaoEOzn9qzTAz3HiLUNF9IlpvirgX/vvx+TDYL0phqIWf
         0o6UjCEUPaAWZIL2Vuy+0QGKLYweDN85heaj0NNRVObPAsQb7jNpo+Fs7NE1LYtMJ1Qn
         WD4MT6Pl+VAcQs4QCRcCNK+vt1hjHWgO3sjzKTnLeF1JADyiKfy0QJZGFdauFZh4We3d
         HjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047314; x=1757652114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ4jyqAebdFk40dMhQCeBc/em7Z7GJAy4Tky878tJlA=;
        b=r2Wh/8ciKVEHlzzqWGt08fjslRpG7LWPmOK/ROdfloLRV12zb5rUEi9er23lDjKWc9
         zR04eE6Ama3xj184c5kdrdOCY1InvVEY4uLr2rMuOOccZExd1fIBnTjqjWRWuObJ44uH
         8Su0gZSrwpxa0h6MdQXDfz/Ld10OrmE+JNJYl45/Xzo15nFl/UZzApyzGtnOBreZFNEC
         1ckXJAqFVIelnE9t08oTG5uPS6Ap06nmxE/9Ks425le7/++BKMwvsEW73hnFjLkQS/GR
         9wQZ+mzNppyAJyyoST49yKTmdeO6erMoTnDuGxnR+R8y8/iJXB8RyI1/CqOQ6WdgzJIR
         61+A==
X-Forwarded-Encrypted: i=1; AJvYcCXMCvfTR0e4m4ZiG3EsnihKEoR1znduAR+egClTzN71phK8zGRJvQxR1YFEi3zaovQyEfiIZ1k1A0omUsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nojwJzPJXdT8PyHsIHQOTGikDgDl5lpCk217fNGP5rITlqXT
	b/9kncPMAxbmr9Kgs+aYKQSnQess+AwBPOS8lLf27TW/+XN8dJ6jR+Yz
X-Gm-Gg: ASbGncsQ7OvuHqG7PRNg/9eg/WkChyLq7TSSuTQw0XkxhWzgzU2c0T9TDfGdSaebMdW
	jOrT1YvI6bYcn4ZrIH1ZcLPJv9eOlGeDYlK4pW1hau5xE09Eg9i1AYSErh+bfmo+DBIsa2JVo9W
	rJkjdMNoymum/MYX8Xo5E1AD02tYy3e1btNFgf0B+g6c8JZYTYYOv576f9Zk7+RoCtJQrAlTu8z
	al0NBq8n7c1vSB8htAbbBXHh7cJplLh/hFsLmh8zpr1Pm/C33zpy4lZhzoBJ63npgqsYHNcVwFN
	6nM5JgpUgSK55+5KSs2mtGd7ZqmZ0lm3PudmA9sid5HTBApK2FPhFAWjzZrKb8iGvDOdHBZf7m4
	Z0fgTVC0F8Ne+BAAmhDF1JLYFEVlYgv7QWitXczveb5h5TrfgvlcXJxbn5va2MCF01JxpFDw9SC
	cAKuxHY0R8iSxyperK+Vg4mVrONlJF83zLbA==
X-Google-Smtp-Source: AGHT+IHC5WKTYzhLeEpox8p85DRt8ZTciM306YARQtb9LiiwFMwDkaHh3Qd+eJ3+8ypPKRCp4OpqXg==
X-Received: by 2002:ad4:4ba3:0:b0:71f:b221:9aa9 with SMTP id 6a1803df08f44-72bc365b6e0mr22245536d6.29.1757047314297;
        Thu, 04 Sep 2025 21:41:54 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16deffsm58118856d6.12.2025.09.04.21.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:41:53 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6EF63F40066;
	Fri,  5 Sep 2025 00:41:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 00:41:53 -0400
X-ME-Sender: <xms:EWq6aIboi5c2GjXEsrnXebpsLTFyMa6TmpoDWF0Wo3ydvCw9VoX7hg>
    <xme:EWq6aBFMFtJtFoVfgk-qFoXmauUCCWnSyiH9EnacMQroxp4EFjyjh6oB4Ds__zAG-
    Qh-DkEeeK_feZayUg>
X-ME-Received: <xmr:EWq6aEuT9KwvmHF2-6uhpnKEyVbebz7VD1jPDzPiCctOmO-9H7AyNEQjTZS1_960RyB9NGLzi5sSKCZwIwh5ErbmlnvlEhUL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EWq6aPLRB6_x7TepPlpphNqgc1zpwsgkBvH0P0xrgBGiHR3-KvW-aw>
    <xmx:EWq6aKNmZ7T6qHcpF6uKQnTIF_0pNRy9AaQ2JMf-nMn-WHTuv_n3cA>
    <xmx:EWq6aPZGS7hXQBfbRhGsw_S6KrDbLkZVPe72PMWWppAxKRrjImT9GA>
    <xmx:EWq6aOzupKIkuXsz3Ic8JHd79RmpoqKKKbAzNk-VFL0gUf16Hei-nw>
    <xmx:EWq6aDHQK9dwLyGhqbpeWPFK9UwvzRDGkjhdcZNUR7mcpWSmGTmEhVsi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:41:51 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 01/14] rust: Introduce atomic API helpers
Date: Thu,  4 Sep 2025 21:41:28 -0700
Message-ID: <20250905044141.77868-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support LKMM atomics in Rust, add rust_helper_* for atomic
APIs. These helpers ensure the implementation of LKMM atomics in Rust is
the same as in C. This could save the maintenance burden of having two
similar atomic implementations in asm.

Originally-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-2-boqun.feng@gmail.com/
---
 rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
 rust/helpers/helpers.c                    |    1 +
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 4 files changed, 1109 insertions(+)
 create mode 100644 rust/helpers/atomic.c
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
new file mode 100644
index 000000000000..cf06b7ef9a1c
--- /dev/null
+++ b/rust/helpers/atomic.c
@@ -0,0 +1,1040 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after INLINE_HELPERS support is added.
+#ifndef __rust_helper
+#define __rust_helper
+#endif
+
+__rust_helper int
+rust_helper_atomic_read(const atomic_t *v)
+{
+	return atomic_read(v);
+}
+
+__rust_helper int
+rust_helper_atomic_read_acquire(const atomic_t *v)
+{
+	return atomic_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic_set(atomic_t *v, int i)
+{
+	atomic_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_set_release(atomic_t *v, int i)
+{
+	atomic_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_add(int i, atomic_t *v)
+{
+	atomic_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return(int i, atomic_t *v)
+{
+	return atomic_add_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	return atomic_add_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_release(int i, atomic_t *v)
+{
+	return atomic_add_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add(int i, atomic_t *v)
+{
+	return atomic_fetch_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_add_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	return atomic_fetch_add_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_sub(int i, atomic_t *v)
+{
+	atomic_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_sub_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	return atomic_sub_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_release(int i, atomic_t *v)
+{
+	return atomic_sub_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_sub_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub(int i, atomic_t *v)
+{
+	return atomic_fetch_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_inc(atomic_t *v)
+{
+	atomic_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return(atomic_t *v)
+{
+	return atomic_inc_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_acquire(atomic_t *v)
+{
+	return atomic_inc_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_release(atomic_t *v)
+{
+	return atomic_inc_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return atomic_inc_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc(atomic_t *v)
+{
+	return atomic_fetch_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return atomic_fetch_inc_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_release(atomic_t *v)
+{
+	return atomic_fetch_inc_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return atomic_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_dec(atomic_t *v)
+{
+	atomic_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return(atomic_t *v)
+{
+	return atomic_dec_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_acquire(atomic_t *v)
+{
+	return atomic_dec_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_release(atomic_t *v)
+{
+	return atomic_dec_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return atomic_dec_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec(atomic_t *v)
+{
+	return atomic_fetch_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return atomic_fetch_dec_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_release(atomic_t *v)
+{
+	return atomic_fetch_dec_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return atomic_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_and(int i, atomic_t *v)
+{
+	atomic_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and(int i, atomic_t *v)
+{
+	return atomic_fetch_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_and_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	return atomic_fetch_and_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_andnot(int i, atomic_t *v)
+{
+	atomic_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_or(int i, atomic_t *v)
+{
+	atomic_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or(int i, atomic_t *v)
+{
+	return atomic_fetch_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_or_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	return atomic_fetch_or_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_xor(int i, atomic_t *v)
+{
+	atomic_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor(int i, atomic_t *v)
+{
+	return atomic_fetch_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg(atomic_t *v, int new)
+{
+	return atomic_xchg(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_acquire(atomic_t *v, int new)
+{
+	return atomic_xchg_acquire(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_release(atomic_t *v, int new)
+{
+	return atomic_xchg_release(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_relaxed(atomic_t *v, int new)
+{
+	return atomic_xchg_relaxed(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_release(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return atomic_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_and_test(atomic_t *v)
+{
+	return atomic_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_and_test(atomic_t *v)
+{
+	return atomic_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative(int i, atomic_t *v)
+{
+	return atomic_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_acquire(int i, atomic_t *v)
+{
+	return atomic_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_release(int i, atomic_t *v)
+{
+	return atomic_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_negative_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_not_zero(atomic_t *v)
+{
+	return atomic_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_unless_negative(atomic_t *v)
+{
+	return atomic_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_unless_positive(atomic_t *v)
+{
+	return atomic_dec_unless_positive(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_if_positive(atomic_t *v)
+{
+	return atomic_dec_if_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read(const atomic64_t *v)
+{
+	return atomic64_read(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read_acquire(const atomic64_t *v)
+{
+	return atomic64_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_set(atomic64_t *v, s64 i)
+{
+	atomic64_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	atomic64_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_add(s64 i, atomic64_t *v)
+{
+	atomic64_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_sub(s64 i, atomic64_t *v)
+{
+	atomic64_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_inc(atomic64_t *v)
+{
+	atomic64_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return(atomic64_t *v)
+{
+	return atomic64_inc_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return atomic64_inc_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_release(atomic64_t *v)
+{
+	return atomic64_inc_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return atomic64_inc_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc(atomic64_t *v)
+{
+	return atomic64_fetch_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_inc_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return atomic64_fetch_inc_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_dec(atomic64_t *v)
+{
+	atomic64_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return(atomic64_t *v)
+{
+	return atomic64_dec_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return atomic64_dec_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_release(atomic64_t *v)
+{
+	return atomic64_dec_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return atomic64_dec_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec(atomic64_t *v)
+{
+	return atomic64_fetch_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_dec_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return atomic64_fetch_dec_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_and(s64 i, atomic64_t *v)
+{
+	atomic64_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	atomic64_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_or(s64 i, atomic64_t *v)
+{
+	atomic64_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_xor(s64 i, atomic64_t *v)
+{
+	atomic64_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_acquire(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_acquire(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_release(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_release(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_relaxed(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_release(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_and_test(atomic64_t *v)
+{
+	return atomic64_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_and_test(atomic64_t *v)
+{
+	return atomic64_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return atomic64_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	return atomic64_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	return atomic64_dec_unless_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_if_positive(atomic64_t *v)
+{
+	return atomic64_dec_if_positive(v);
+}
+
+#endif /* _RUST_ATOMIC_API_H */
+// 615a0e0c98b5973a47fe4fa65e92935051ca00ed
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..7053f9245759 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "atomic.c"
 #include "auxiliary.c"
 #include "blk.c"
 #include "bug.c"
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 5b98a8307693..02508d0d6fe4 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,6 +11,7 @@ cat <<EOF |
 gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
 gen-atomic-long.sh              linux/atomic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
+gen-rust-atomic-helpers.sh      ../rust/helpers/atomic.c
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
diff --git a/scripts/atomic/gen-rust-atomic-helpers.sh b/scripts/atomic/gen-rust-atomic-helpers.sh
new file mode 100755
index 000000000000..45b1e100ed7c
--- /dev/null
+++ b/scripts/atomic/gen-rust-atomic-helpers.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+cat <<EOF
+__rust_helper ${ret}
+rust_helper_${atomicname}(${params})
+{
+	${retstmt}${atomicname}(${args});
+}
+
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after INLINE_HELPERS support is added.
+#ifndef __rust_helper
+#define __rust_helper
+#endif
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+cat <<EOF
+#endif /* _RUST_ATOMIC_API_H */
+EOF
-- 
2.51.0


