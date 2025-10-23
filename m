Return-Path: <linux-kernel+bounces-866031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52990BFEAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68564FA9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09735948;
	Thu, 23 Oct 2025 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipTQjsg0"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AA8821
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177943; cv=none; b=VxQH+5qAapGJ6aOCSFby5Zmp7tYMbKjlbtz2A6img1Sz44WmTdvXOu/HgosRFjxrrXufZk/LPa3IiYRRtx5hLIudmOHFq4nR43/jzSc/o+YhuLJ5GkyndDUItcHOyTygdNnbhQ8Mtt/RDRM4mVoxLdrXXUdpELkJ1O6nPhH37ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177943; c=relaxed/simple;
	bh=C4HeaFoy/zWqeitmnTq8NmrMLvX9vxqSLhnk+TPRUks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGJMvc83jLJ21LWqekZY2II+iyVnRJeXhtQQ9RIw5+gxUQ+uTZdRse142ffuQ35ZurNqjTumuvNMwAqU+b1EWQR1TMMA5faS9z1cheOxMib4lenF6dStO/0Vziyk6Cg4y3zqhD4tfgWp2k6pATfvg08vP6PIl3thi8qKdkGm29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipTQjsg0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso454363a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177941; x=1761782741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzZENSWUwrBhAA1CxL4i/AxbZEWI19mQXc700MJvOfI=;
        b=ipTQjsg048qQbI7ojyGnqCzOf7V/VflbcNa7rLwUWS+kOwI21mNcT25TefzQ4oIb2g
         HKA/+koDwMuystaNgDMw2G3jrSajey4wXDrlaukjB6LqtStH7nLTLPVtj7kZH4T7pMxB
         IPaMbCR2rZpl14Ll9C7Of5M3K6Exav9v2GDeilIJ+MA+N7ifAxLFAbK11R7KoBfmRm6h
         30ZdY9fWxRW2OtTjiTQeYXtn3SgAjcxdjjDrjpgK+p+CwWvy6ExFqs7yEqoJSjOgBUi6
         i92inEQaeYQLK/rKvLL9MoYgfM0gsJk9XSBMufWK2j9hh3nJhq3gafhWimYkW/JTYln3
         M5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177941; x=1761782741;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lzZENSWUwrBhAA1CxL4i/AxbZEWI19mQXc700MJvOfI=;
        b=uxl6/qtriOYg3gV+c/6Iwitd5T5z0Mtakq+Tu/2o0MoLf3RRkas/OSx8JNKY+ZQkOQ
         eq93d3b3Owso8M0+NekJUtf+9tl71+onx6/lRBwlfKv6a+k6qMJWHLsDb2mMcLfeGJaA
         yokcbV0FTyYqIVFY+9PkJsCq0V/7bgbDLoR3YHJah7aOSiQmHN5PVWjm56/GX0gcK4YG
         wm1sCnPRF54xbnZJHlP5C+0izdRe1+sltUEYAPwrWeljACIIY4fKPeFp/FCs9NnXw6gU
         +2dGzyCG3gfvWPfjiFODa2MIYrbt+a6LOlfYYQbWMn95gy/Oa+0MZfY5lUsAWhJPo2XC
         8rHw==
X-Forwarded-Encrypted: i=1; AJvYcCVOn5+H7qJqK+x8ovuqxzgsl5rvlYq9xlE2C0tlzM8kHFfmnsFJcQnV36Dh76QUlcKqAVIw+CwrcdsKGLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLs1XkVttFaFKmqKlnSKZ7yHDGW2blE9pGC217A7kSh3JQB1a
	Wouv3Tealytg9CW21v4IsKmvWif+JdkF8g59CgASltJq272qOjnVxjjinOx+RXeOsOshCxySURr
	BVB+tPw==
X-Google-Smtp-Source: AGHT+IGd6U9IlxxZkQUE9in6Tsw30xR2bnzy7O0+0w49jme5smP7pCaW5imecIRz7OgZNwNV7y77C8X4JZs=
X-Received: from pjbco18.prod.google.com ([2002:a17:90a:fe92:b0:33b:51fe:1a83])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c05:b0:339:ec9c:b275
 with SMTP id 98e67ed59e1d1-33bcf84e181mr33310671a91.6.1761177941265; Wed, 22
 Oct 2025 17:05:41 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:04:44 +0000
In-Reply-To: <20251023000535.2897002-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023000535.2897002-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251023000535.2897002-3-kuniyu@google.com>
Subject: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

epoll_put_uevent() calls __put_user() twice, which are inlined
to two calls of out-of-line functions, __put_user_nocheck_4()
and __put_user_nocheck_8().

Both functions wrap mov with a stac/clac pair, which is expensive
on an AMD EPYC 7B12 64-Core Processor platform.

  __put_user_nocheck_4  /proc/kcore [Percent: local period]
  Percent =E2=94=82
    89.91 =E2=94=82      stac
     0.19 =E2=94=82      mov  %eax,(%rcx)
     0.15 =E2=94=82      xor  %ecx,%ecx
     9.69 =E2=94=82      clac
     0.06 =E2=94=82    =E2=86=90 retq

This was remarkable while testing neper/tcp_rr with 1000 flows per
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

Use __user_write_access_begin() and unsafe_put_user() in
epoll_put_uevent().

We see 1% improvement on tcp_rr throughput by just saving a single
stac/clac pair.

Another option would be to use can_do_masked_user_access()
and masked_user_access_begin(), but we saw ~5% regression with
unnecessary 3 operations for address masking, which is already
checked by ep_check_params().

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/eventpoll.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index ccb478eb174b..efc0aa2d496f 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -82,11 +82,14 @@ static inline struct epoll_event __user *
 epoll_put_uevent(__poll_t revents, __u64 data,
 		 struct epoll_event __user *uevent)
 {
-	if (__put_user(revents, &uevent->events) ||
-	    __put_user(data, &uevent->data))
-		return NULL;
-
-	return uevent+1;
+	__user_write_access_begin(uevent, sizeof(*uevent));
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
2.51.1.814.gb8fa24458f-goog


