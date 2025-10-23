Return-Path: <linux-kernel+bounces-866029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A191EBFEAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825FB1A063CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E6EACD;
	Thu, 23 Oct 2025 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXyi3Rr6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F641CD2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177940; cv=none; b=b7Yz3rvJamJl21nv+5Lij12ulFzdwhb2W1l70CZlfnaID+O/mmNqxdIMfhUUIBOD772FHOZdsAycc7qL5/R7TbJc8Df0mjGfX5fG1j8eBe3gNuT+0hNM2dXo6ZRW6Gy4sKQ8Y54x0H1QGWjgvztVyF5dy7px8P+6ucosSgExdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177940; c=relaxed/simple;
	bh=0QGcDs2w9mWdku6jI/buJ2GeYMtrDgFtosGeYLQ0kWw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YHNr4DcihB5tVigcr3lmCI/nICgggrLZOnvtZZ2JvWJotR+eVTpVqWKVRyimYyAwOs20l8R8XyLDT21kyiXfV/J9g2byZ5Rai79jDFFwdecIu1Dd1dYvEzL9/n1JQ9sqmuowdUCPzpg2NZoOjzuIKdGqbplvzoZ6EQd48qxkJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXyi3Rr6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so400628a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177938; x=1761782738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMUWYl+RTsVCov/vsPtkBuHUA9Ssu9g/aMZ+rIBItRU=;
        b=hXyi3Rr61Jfo17pAhwuPYV0+QUFqcY/QTxQ/h1VgWyrfLSfNUgm4vWTMOSoRXmZXtx
         HdCt/O+OOjG2V01UFItFmiCA+kufCoXMnc4L7t9uVSP2JNDf7GFZ5OX7QoYXs1IKNCVU
         ogaTx6jYj9MC2BadK5hZqSjgYPPxbEjotQhXcuC7jf2ZmhQu7kfKUoYeJbwgccjfWPup
         DcjqSYCTCJ2YmkSgTinE9a1qhsoyKe75Kf2Jiyj32I3X6I6mVZro0lf1kmO5pm4xmfKD
         xAH8VWj6aZA+24+S9HnlRfzop0uiERXchsFmYweg1YISSZHdSfvp5JBZeKSBpwIUh6Nk
         Q1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177938; x=1761782738;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMUWYl+RTsVCov/vsPtkBuHUA9Ssu9g/aMZ+rIBItRU=;
        b=w6YDqFJeVZxauvYDKKLj0ymnEghZkdEp7zRsxqRfDfpKzJ2iMGQbjJsGYjUk8TVP4N
         V3zlDJmqmoRRBB59wSHojAroTMhKElrxCPAWVpFUGfXSuaWn6cQZvJa9GV7H1o5ieNA5
         ZoumXJ+W5zssy+z83pQrvLLza6/QH2FuFIWYclldUtoVot2PGUvrFJ+TUEspKTMtjLBJ
         v/9qylnKsu2BSp2I7FEQv7JIUxVT5h1n64gPig6CTa5oGVqXB2ShcXCyl4EcGgniHVnc
         LbzQfWnT8d1ItsfgzeAqBG10QrWJuWLKletaW7mKZtzJqkVWmz1tqE7XrT6QF840aCIX
         qfbg==
X-Forwarded-Encrypted: i=1; AJvYcCWgDUrKFv+9EWZIIaIrbu3fkR+ScbQvWAdITlCEPXYYXhkl/xy8e5z2gyxOfjy3IdKvcsrByIhtJJ0Vtsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFapdBh+m5J7CVUAp/nngf4zjKxJihHwwSIiY2LG5IZnCxTj0
	2wP68YFPrl3/IpTJcVuIQPrwWrlkiPHCJbeaX0dhUsSBZY8eGSzC9DNfcRohEF0k5bveNA4ohgO
	V1FIU5w==
X-Google-Smtp-Source: AGHT+IF6lSdbdtyS+/t/fGvEsbBKEiGOc0L8/NdAr9Cp2dQPW0iljcBuf5Kq/IEP9uj1boUHsE/v/xDHW1g=
X-Received: from pjih1.prod.google.com ([2002:a17:90a:5801:b0:33e:28eb:7df2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cb:b0:339:9f7d:92d4
 with SMTP id 98e67ed59e1d1-33bcf87b8a5mr30997233a91.9.1761177937783; Wed, 22
 Oct 2025 17:05:37 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:04:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251023000535.2897002-1-kuniyu@google.com>
Subject: [PATCH v1 0/2] epoll: Save one stac/clac pair in epoll_put_uevent().
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

Patch 1 adds a new uaccess helper that is inlined to a bare stac
without address masking or uaccess_ok(), which is already checked
in ep_check_params().

Patch 2 uses the helper and unsafe_put_user() in epoll_put_uevent().


Kuniyuki Iwashima (2):
  uaccess: Add __user_write_access_begin().
  epoll: Use __user_write_access_begin() and unsafe_put_user() in
    epoll_put_uevent().

 arch/arm64/include/asm/uaccess.h   |  1 +
 arch/powerpc/include/asm/uaccess.h | 13 ++++++++++---
 arch/riscv/include/asm/uaccess.h   |  1 +
 arch/x86/include/asm/uaccess.h     |  1 +
 include/linux/eventpoll.h          | 13 ++++++++-----
 include/linux/uaccess.h            |  1 +
 6 files changed, 22 insertions(+), 8 deletions(-)

--=20
2.51.1.814.gb8fa24458f-goog


