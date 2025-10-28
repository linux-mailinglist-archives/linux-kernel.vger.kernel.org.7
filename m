Return-Path: <linux-kernel+bounces-874446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0FC165AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3CC1A60D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046334EF15;
	Tue, 28 Oct 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1OBot5E"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0134DB4D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674204; cv=none; b=qMVGFgLwWBPL99jHnD0v+QmCQlrey5R1ps9y0KW2K3rpWNNUtk4yXlLScSBlhqNwe+KNA4VW2vfiYxAI34QVdd64EZZIPFWehGxlHiDetbjNZFSEy4r8pJNbxjZlVzMu2kfTAkScZYrAS12pqF8vKvF/F0frLNDnytYDVaWR38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674204; c=relaxed/simple;
	bh=0EfawnbxLb1BmwLFgoX+8DLLDDalv+0ddjD9GUkJAsU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kt+S1mknengLmqPKaYmhClTG2YBuh7khzQ+hDQau165+hcI8TjdghIwaWKgS4V1yDp8zhfYCac/2HiZEwWAExjQ88CD+1LSTMmZJfeRexsnVWn7ojuqTyOPejJBM7DP3Tyz9qFAFlPOcs1rYxLsGv+fTCuRLj5nNnCNA67iduhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1OBot5E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-286a252bfbfso146283755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761674202; x=1762279002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jY5Cgm9oSz0Lej/y+45LFHbfapMhlfFm1Uyat4S3fgc=;
        b=x1OBot5EnVEyZZWhnUDgk7B9Gx+VvNx6eUqZ7xUQv4CXIiS+ifNzKPCJfLMyMlV8LU
         hj5ZQrDihqwD3GDS/b61aJkcE7ZElNAAgdD985+1d9Y7VBAxTsRjnyFP/WdqVm+OB6rT
         +EdlDbzuw0GuAsiHFV4Uz6GDlCGYMcvLg4VNA0zP6umI1TaAbGurcQJMZ8/uVUvJQYMz
         nQb31vBa49lK/zkV9aIzLBwXjCg1GdVrFeqAFCEBcESqiB15r2spHyZykABPQOP/s8up
         RgrHX9ExS1cFDrIOa0BwYgWLreKUzPfQCF/py+4br51Dc27lFzpdKk7GVOxrnT3dAo9G
         77DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674202; x=1762279002;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY5Cgm9oSz0Lej/y+45LFHbfapMhlfFm1Uyat4S3fgc=;
        b=U1n+xY5aq8KAsuMHyKCYKLAYibxrnCNiju64eUsr6vEJSqDeFaDRY0E2rRUzWbaJf0
         4rxdbNgnWEwNAXtFesisJPKFXeaEwH8WFxVVSKf+JFjHXxxZeuLc0Wov0wtqDx+xDvuI
         K7xRWkX91+BxzScHGoQk0jICTVTs9iJEnWNfo+BFpdFF2ldFv3mH4Ydn0yVu+bD/cN49
         f3RXG+0ZdjxkdOPlqnbSQiNp0rEv403FMBscbKMjIx3m0dwhBt2keD2/OKw2LOtqMFKP
         2GYe/nw03tC56cIZ1kKx+RpY/nXybQUUSMgfnvLV8tTRkKwaKeaJ4UwXlrBAIMFsl6Ls
         lcag==
X-Forwarded-Encrypted: i=1; AJvYcCVptRmxFw7dWvoJDJbqZU9fHogQzx2havsc8nVZ/LdohXlKiGH+keMs4wwXl/ZJTPwcJyvheDfvDcuw9dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyft75h7Im2lrBBFECVnfIaxOKts3C9QufdmxMEWJK8Fn6QGZ49
	dD5L83Y6aYpaeEhskTTsLOENIggC3iuFsne39DG5R4wuCHMf7FgTkvcI2ObkUUc+bAIvZGhH5VT
	IeCKDZg==
X-Google-Smtp-Source: AGHT+IG72ARVITn+XFUy06KgP+q9VT998Vyg3Uz5YpPfwfFPJEDA3O0h8jeEEUJ27BPYGYeWtQnQwOoic1M=
X-Received: from plbmt13.prod.google.com ([2002:a17:903:b0d:b0:292:fd54:e3d8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c6:b0:24c:7bc6:7ac7
 with SMTP id d9443c01a7336-294dee20a01mr754165ad.18.1761674202408; Tue, 28
 Oct 2025 10:56:42 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:56:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028175639.2567832-1-kuniyu@google.com>
Subject: [PATCH v2] epoll: Use user_write_access_begin() and unsafe_put_user()
 in epoll_put_uevent().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <david.laight.linux@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

epoll_put_uevent() calls __put_user() twice, which are inlined
to two calls of out-of-line functions, __put_user_nocheck_4()
and __put_user_nocheck_8().

Both functions wrap mov with a stac/clac pair, which is expensive
on the AMD EPYC 7B12 (Zen 2) 64-Core Processor platform.

  __put_user_nocheck_4  /proc/kcore [Percent: local period]
  Percent =E2=94=82
    89.91 =E2=94=82      stac
     0.19 =E2=94=82      mov  %eax,(%rcx)
     0.15 =E2=94=82      xor  %ecx,%ecx
     9.69 =E2=94=82      clac
     0.06 =E2=94=82    =E2=86=90 retq

This was remarkable while testing neper/udp_rr with 1000 flows per
thread.

  Overhead  Shared O  Symbol
    10.08%  [kernel]  [k] _copy_to_iter
     7.12%  [kernel]  [k] ip6_output
     6.40%  [kernel]  [k] sock_poll
     5.71%  [kernel]  [k] move_addr_to_user
     4.39%  [kernel]  [k] __put_user_nocheck_4
     ...
     1.06%  [kernel]  [k] ep_try_send_events
     ...                  ^- epoll_put_uevent() was inlined
     0.78%  [kernel]  [k] __put_user_nocheck_8

Let's use user_write_access_begin() and unsafe_put_user() in
epoll_put_uevent().

We saw 2% more pps with udp_rr by saving a stac/clac pair.

Before:

  # nstat > /dev/null; sleep 10; nstat | grep -i udp
  Udp6InDatagrams                 2184011            0.0

  @ep_try_send_events_ns:
  [256, 512)       2796601 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
  [512, 1K)         627863 |@@@@@@@@@@@                                    =
     |
  [1K, 2K)          166403 |@@@                                            =
     |
  [2K, 4K)           10437 |                                               =
     |
  [4K, 8K)            1396 |                                               =
     |
  [8K, 16K)            116 |                                               =
     |

After:

  # nstat > /dev/null; sleep 10; nstat | grep -i udp
  Udp6InDatagrams                 2232730            0.0

  @ep_try_send_events_ns:
  [256, 512)       2900655 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
  [512, 1K)         622045 |@@@@@@@@@@@                                    =
     |
  [1K, 2K)          172831 |@@@                                            =
     |
  [2K, 4K)           17687 |                                               =
     |
  [4K, 8K)            1103 |                                               =
     |
  [8K, 16K)            174 |                                               =
     |

Another option would be to use can_do_masked_user_access()
and masked_user_access_begin(), but we saw 3% regression. (See Link)

Link: https://lore.kernel.org/lkml/20251028053330.2391078-1-kuniyu@google.c=
om/
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Drop patch 1
  * Use user_write_access_begin() instead of a bare stac (Dave Hansen)

v1: https://lore.kernel.org/lkml/20251023000535.2897002-1-kuniyu@google.com=
/
---
 include/linux/eventpoll.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index ccb478eb174b..31a1b11e4ddf 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -82,11 +82,15 @@ static inline struct epoll_event __user *
 epoll_put_uevent(__poll_t revents, __u64 data,
 		 struct epoll_event __user *uevent)
 {
-	if (__put_user(revents, &uevent->events) ||
-	    __put_user(data, &uevent->data))
+	if (!user_write_access_begin(uevent, sizeof(*uevent)))
 		return NULL;
-
-	return uevent+1;
+	unsafe_put_user(revents, &uevent->events, efault);
+	unsafe_put_user(data, &uevent->data, efault);
+	user_access_end();
+	return uevent + 1;
+efault:
+	user_access_end();
+	return NULL;
 }
 #endif
=20
--=20
2.51.1.851.g4ebd6896fd-goog


