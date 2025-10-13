Return-Path: <linux-kernel+bounces-851019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C1BD509E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC4418A385E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A6223DC1;
	Mon, 13 Oct 2025 16:29:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340E23F294
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372964; cv=none; b=jdz2r5MQ1bdNEqK1Z7TMZPe1vSSR71hdulCCejJ2G46o4KRHxGAh9Iv2VlvyIz/v7B1fIQhFgFnCG7tC9KePYZxfQlhvcLQ5cnvVJP/1QGETvBhU9XvlOG2m2Hbi/QZYVo9ST7fEhTSGwsqNVe/HS7UtduX1wgGp8SnaENViK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372964; c=relaxed/simple;
	bh=+GsqAcpAZtimI0tfEkziv2jHlRkwx8MIxs+AeFbCkQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ek+GpbSHVFbQY/tvDeSo8+5NozvhG7y5H4Lpqd4bVDYyNVE3cJsK78pLwBGK2796rWoIdejZeUU0yMEIIybbX9RTVbYK1zSt0JqPmmA+RfnYhLQKOy9HK0AXmwDbn7DmscBMK5ctEDCfDLYuOQAMC34AS7XaQz/SJr4H+H0pgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f95aa375bso122135115ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372962; x=1760977762;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeFH0Tc3azQdV3QazNBaeM8J+Mk8kLpsHhb9bhlSXMQ=;
        b=LMl9iLgPAWLhMncC6z14+NgR4NUeIU/LamG2Sp04VaHPCuquAPnJoTxk//OzvMX0S8
         5Cb47ncyh5NgF3h2Ti/NCg0qBHgy2f3Tocxhdjmip5WJ4Y4h+r7oM91w8FWbyDQ57dk8
         H0bLh1AqWiOkdiJnL70+GoLJSIi0J+OHhlK3peg3FcDS0v/xH3qbCyJBclSttLidKyEf
         J80dt/yXH+LnLCxLQN7zirBf0NNpNu5KEO4FVDxjybiS9Y+KWhSIl7U4WGZjVUf2QaHT
         8isxZPNO3urEkb2YQ7QkzJciYZqOCekEPjgIvwOS5U9p1HIRZloIJy66jpyRjGkQW+1f
         ihTg==
X-Gm-Message-State: AOJu0YyGnzylk6PY1M608W+2J40VjipOFa2Hw7yE40VX1y1kO8EBa1Jn
	YIhq1uwgJ2007Bclb9d3cou5nmfvCd/7Ahl8wX6bKo05gizh4B8jBAubA78WKFuoTa3/MkITxl8
	2odwszGAX5mS5JVAgXiLgL70e4D/Hg92BkAfS0WHLSgcOTD1o4FLnUs6Y49U=
X-Google-Smtp-Source: AGHT+IEpAkW3+KZL38koCa5hf7lSx/8vk/cSAaSymLF6scfuMFRdVt9ZbpQzdfNAuvLaxsh/XroaZ2kOJW5gMyP4IavP11Yad3Hh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:42f:9b0c:cd84 with SMTP id
 e9e14a558f8ab-42f9b0cd065mr153828535ab.3.1760372962015; Mon, 13 Oct 2025
 09:29:22 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:29:22 -0700
In-Reply-To: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed28e1.050a0220.ac43.003a.GAE@google.com>
Subject: Forwarded: [PATCH] bpf: avoid sleeping in invalid context during
 sock_map_delete_elem path
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bpf: avoid sleeping in invalid context during sock_map_del=
ete_elem path
Author: listout@listout.xyz

#syz test

The syzkaller report exposed a BUG: =E2=80=9Csleeping function called from
invalid context=E2=80=9D in sock_map_delete_elem, which happens when
`bpf_test_timer_enter()` disables preemption but the delete path later
invokes a sleeping function while still in that context. Specifically:

- The crash trace shows `bpf_test_timer_enter()` acquiring a
  preempt_disable path (via t->mode =3D=3D NO_PREEMPT), but the symmetric
  release path always calls migrate_enable(), mismatching the earlier
  disable.
- As a result, preemption remains disabled across the
  sock_map_delete_elem path, leading to a sleeping call under an invalid
  context. :contentReference[oaicite:0]{index=3D0}

To fix this, normalize the disable/enable pairing: always use
migrate_disable()/migrate_enable() regardless of t->mode. This ensures
that we never remain with preemption disabled unintentionally when
entering the delete path, and avoids invalid-context sleeping.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 net/bpf/test_run.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..92ff05821003 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2017 Facebook
  */
+#include "linux/rcupdate.h"
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
@@ -29,7 +30,6 @@
 #include <trace/events/bpf_test_run.h>
=20
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -38,10 +38,8 @@ static void bpf_test_timer_enter(struct bpf_test_timer *=
t)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	if (t->mode =3D=3D NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	/*migrate_disable();*/
+	rcu_read_lock_dont_migrate();
=20
 	t->time_start =3D ktime_get_ns();
 }
@@ -51,10 +49,8 @@ static void bpf_test_timer_leave(struct bpf_test_timer *=
t)
 {
 	t->time_start =3D 0;
=20
-	if (t->mode =3D=3D NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
+	/*migrate_enable();*/
+	rcu_read_unlock_migrate();
 	rcu_read_unlock();
 }
=20
@@ -374,7 +370,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog,=
 struct xdp_buff *ctx,
=20
 {
 	struct xdp_test_data xdp =3D { .batch_size =3D batch_size };
-	struct bpf_test_timer t =3D { .mode =3D NO_MIGRATE };
+	struct bpf_test_timer t =3D {};
 	int ret;
=20
 	if (!repeat)
@@ -404,7 +400,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ct=
x, u32 repeat,
 	struct bpf_prog_array_item item =3D {.prog =3D prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t =3D { NO_MIGRATE };
+	struct bpf_test_timer t =3D {};
 	enum bpf_cgroup_storage_type stype;
 	int ret;
=20
@@ -1377,7 +1373,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog =
*prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t =3D { NO_PREEMPT };
+	struct bpf_test_timer t =3D {};
 	u32 size =3D kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx =3D {};
 	u32 repeat =3D kattr->test.repeat;
@@ -1445,7 +1441,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog =
*prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_att=
r *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t =3D { NO_PREEMPT };
+	struct bpf_test_timer t =3D {};
 	struct bpf_prog_array *progs =3D NULL;
 	struct bpf_sk_lookup_kern ctx =3D {};
 	u32 repeat =3D kattr->test.repeat;
--=20
2.51.0


