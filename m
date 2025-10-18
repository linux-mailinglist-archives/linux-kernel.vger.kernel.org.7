Return-Path: <linux-kernel+bounces-859490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F001BEDD0E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB923AEF80
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 23:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E708285CA4;
	Sat, 18 Oct 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJyIEacn"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16A354AD4
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760831609; cv=none; b=ayz/6yyYdJn6q5rdH2ayIAHxhdGHmapygnZdznWe8zYoogEZP6Pzo5eoM3U0OLE+ETluHGHBHNcjQJlkJAHHeGhXbSLdrJa1wTFlcNEicKuHDdq2KfUr52/SH+wYaVwuDos5oN+S7m456W0ekxru0N91iCudKPPQBWPLcuEbsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760831609; c=relaxed/simple;
	bh=Mp5Qs1WJZk/fz4fCF8P+WEjlqKYNJKxBOxCXXRwerYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCTG8Nq4WQ40q4IuOkiCwprJhIy7htTOiCeo62UQVtW2cSqMsR2umb3KulAt+68ISK4Dkr1F/540ZO+Ou/I+F2axLAxLYpy1V2Lf0Wt0WRhTJs3EWWI0owbHhFfLHcpLUdbF9zRiDkspLge9OpPzVLxwmmOJU2g/F1x4qhslAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJyIEacn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f610f7325so2655525b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760831607; x=1761436407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4szyYoYVgpWU77uX1juA5PmUyOEtSANi3FHfzaWJW/M=;
        b=uJyIEacnndnNmIOjX9XzYy8JOmYiWVSR9bvIKwBJwfsbYjbl3Nr6xMt/rRHDYzkxoF
         LRSDBqFsGHl4YZsJbtLOZwZIUuFzVeqoYxAAhoga6rlte/rZfjmXdeh6CJZ7bm/uERtr
         Ek8SFaiRiZdR2o3TZNNUTS2lJugt/xSqjvEuG/GUtN6axB0+BSNMZtmjJBzjhlY93YYv
         V1FAAqzzOVok9buHxc6jDZuGLd8vu6yDtmLGCX8N+9wzy2EEw5FBk17TW6Qko8DDQHZ/
         rVQdm65ZRgOr0veTz177LdbQAj28w6gogcKCvd/ru6BqUEEDfnDUCVJo3mKthqLjKzn+
         T12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760831607; x=1761436407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4szyYoYVgpWU77uX1juA5PmUyOEtSANi3FHfzaWJW/M=;
        b=CWB4MQPgmC9rdljfWAQl89VO8YXl9BVXIv/FeimDkZlqf+2Ehswk3DnvmGO3H9vQO5
         aTvvgQ9QtGlFg3E0rDJUvLrjK5DsCGEwGDUIv5sFeOnSUNk7FpSK0WhL0Lrtv4WOd/tL
         8T4bQ0MMFqfWSkT9rq1/5BPATXfBG87jBMDJJf9aJR8tvuf35JwgNoak+20fFezxlzqD
         OdeaQivRscCDgFdyhafX6dbV9btFohdtX3857/CktoG5y04aNKYVzzAFQ/nxdByV/Mru
         Wm25o3sr+ly3zbFE/ipnQ1cxfuTsyxlw1/NUBAWP6mVaGuhIYcm7oqkcerrfWxmUYENk
         VtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgaMcDRyiHjQr3ih/ar7gRsNUJ4GX3WgRAD/HVCZscaNYVQrMmNA+SN1g5Itf8bUYd/z5yF9Xa4iJJz48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLofjRZ1A+MD1GgSbEALoBxeclI1D1tMcsOxmWjXGlJqofzwG
	i1N45f0fs22gFvtS5TqmtiKGCMxogTl8qHX/F3GA/56PlP4nGG4FMuyniYNCs5h47MVguYEvzFC
	+4pEMAA==
X-Google-Smtp-Source: AGHT+IGMdQ8eSehfN6h45bcGsn/5+rO+6te+2SFJyuw3zDzZjFMzzOL9V9cfBn9BZlUAPniCNKelmGSbuD4=
X-Received: from pfug7.prod.google.com ([2002:a05:6a00:787:b0:781:1659:e630])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:99d:b0:78c:9b1b:e0e3
 with SMTP id d2e1a72fcca58-7a220a08d8bmr8216516b3a.7.1760831607138; Sat, 18
 Oct 2025 16:53:27 -0700 (PDT)
Date: Sat, 18 Oct 2025 23:52:02 +0000
In-Reply-To: <20251017-fix-fix-me-v1-1-8c509d7122ed@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017-fix-fix-me-v1-1-8c509d7122ed@yahoo.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018235325.897059-1-kuniyu@google.com>
Subject: Re: [PATCH] net: unix: clarify BSD behavior comment in unix_release_sock()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: adelodunolaoluwa@yahoo.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Date: Fri, 17 Oct 2025 14:30:45 +0100
> The long-standing comment in unix_release_sock() mentioned a "FIXME" about
> BSD sending ECONNRESET to connected sockets upon closure, while Linux waits
> for the last reference. This behavior has existed since early UNIX socket
> implementations and is intentional.
> 
> Update the comment to clarify that this is a deliberate design difference,
> not a pending fix, and remove the outdated FIXME marker.
> 
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
>  net/unix/af_unix.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 768098dec231..c21230a69f42 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -734,14 +734,13 @@ static void unix_release_sock(struct sock *sk, int embrion)
>  	/* ---- Socket is dead now and most probably destroyed ---- */
>  
>  	/*
> -	 * Fixme: BSD difference: In BSD all sockets connected to us get
> -	 *	  ECONNRESET and we die on the spot. In Linux we behave
> -	 *	  like files and pipes do and wait for the last
> -	 *	  dereference.
> +	 * Note: BSD sends ECONNREST to all sockets connected to a closing peer
> +	 * and terminates immediately.

I ran a script below on Mac (I hope the behvaviour does
not differ from FreeBSD), and I only see ECONNRESET on
SOCK_DGRAM test case.

Even after close()ing a SOCK_STREAM socket, its peer can
read 0, not ECONNRESET.

So, the comment looks outdated.

---8<---
$ python3 a.py
test 1
b'hello'
b''
test 2
b''
b''
test 3
[Errno 54] Connection reset by peer
---8<---


> Linux, however, intentionally behaves more
> +	 * like pipes - waiting for the final dereference before destruction.

Note that Linux also sets ECONNRESET if the close()d socket
has unread data or is not yet accept()ed.  You can find this
a few lines above of the diff.

---8<---
$ python3 a.py
test 1
b'hello'
b''
test 2
[Errno 104] Connection reset by peer
test 3
[Errno 11] Resource temporarily unavailable
---8<---


>  	 *
> -	 * Can't we simply set sock->err?
> -	 *
> -	 *	  What the above comment does talk about? --ANK(980817)
> +	 * This behaviour is by design and aligns with Linux's file semantics.
> +	 * Historical note: this difference from BSD has been present since the
> +	 * early UNIX socket implementation and is not considered a bug.
>  	 */

So, I'd remove the entire comment, and if needed, add a
selftest and update man page.

Thanks!


---8<---
import os
from socket import *


def test1():
    print("test 1")
    server = socket(AF_UNIX, SOCK_STREAM)
    server.bind(b'test')
    server.listen()

    client = socket(AF_UNIX, SOCK_STREAM)
    client.connect(server.getsockname())

    child, _ = server.accept()

    child.send(b'hello')
    child.close()

    try:
        client.setblocking(False)
        print(client.recv(20))
        print(client.recv(20))
    except Exception as e:
        print(e)

    client.close()
    server.close()
    os.remove('test')


def test2():
    print("test 2")
    server = socket(AF_UNIX, SOCK_STREAM)
    server.bind(b'test')
    server.listen()

    client = socket(AF_UNIX, SOCK_STREAM)
    client.connect(server.getsockname())

    child, _ = server.accept()

    client.send(b'hello')
    child.close()

    try:
        client.setblocking(False)
        print(client.recv(20))
        print(client.recv(20))
    except Exception as e:
        print(e)

    client.close()
    server.close()
    os.remove('test')


def test3():
    print("test 3")
    server = socket(AF_UNIX, SOCK_DGRAM)
    server.bind(b'test')

    client = socket(AF_UNIX, SOCK_DGRAM)
    client.connect(server.getsockname())

    client.send(b'hello')
    server.close()

    try:
        client.setblocking(False)
        print(client.recv(20))
        print(client.recv(20))
    except Exception as e:
        print(e)

    client.close()
    os.remove('test')


test1()
test2()
test3()
---8<---

