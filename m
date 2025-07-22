Return-Path: <linux-kernel+bounces-741565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A6B0E5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F1AA1726
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99608285CA6;
	Tue, 22 Jul 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR4gYkQG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154428725F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221485; cv=none; b=JHzGsYhgaGsMWnv7kOtG4T6dk5LkTkrio13/kaeST71OwI4agauKOLp3+g5nvlcqv/lcjpjwqFkNef2/XPohjHKjbKzONVy025f3GoCutM9mXqle9cafXlkg3IlTZh8FpBrhsJGrKtZ48peh77VN9rRtKhXTjli9UnsbPHeqrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221485; c=relaxed/simple;
	bh=pcTWWP7f1AU8R3VFM9VVdlFpzwo4+eUtvrncEqTQt94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cObqN0N6P0mdCfx/tXlno+ULke0wLWbefKNGZVkegGaVqA5rX2jdqvY+M5xd4awmlPnVx7mmzng/oMqc2jQ97LaQ5yue9KKKurGhcUUpjs+SVesg+FsgIFCCL51gdpMIBkhyWdMqBhaD9HoRonTd1ZYpIMrMOecr/jFYOYWYH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NR4gYkQG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso352062a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221483; x=1753826283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UMMrfhAvddPcgmIthUfqUnXElNibxM0FzGKBaSfgO/w=;
        b=NR4gYkQG9LnfDRcYSfqcKnaapFH/dAutugHDzZf88JN3+LEcvllMubEuz2aUlfCvfu
         tHsMzgcrgD5JXOSUF8qM1QPuDPLjl5xmtR+AYwsbcZUVs7GQP3+VwFdlcgZy2PYNpykm
         pY3wNyYDqRr6OZpfY71UlMWbrWPI3khxaaogQ9IXvRvEkOzNQF2gRMXClaSGbOSA3qgZ
         1wsoGC/4QhE3GCsVuTDc91XGtrKnFBsP+GeMwKmARJ4oqYbcREPEgnl7QlTeVv3aS9OE
         ibdhH+VX+xTrwXTlcCb2gHXRm470RbUieHn0aYubH9P6DuVMgjHnO/6gl62DZ6vovabQ
         4LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221483; x=1753826283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMMrfhAvddPcgmIthUfqUnXElNibxM0FzGKBaSfgO/w=;
        b=DC3ecwHU4tuVDD5fh1i3OxbMlx+iluLGabmI0vmPhcoEjI+GRzOv7BQ0i9pa+5QWrK
         d7pn5AeakKOUvOTV4EOqQQP5f88wEvjIr/kLO0K2ADBtkqWHYxUzV8/4hbcVtc0xpkxA
         LofZr6OkMYx6pBeakzZu1vS1ASAj4xvlE4hkiSfpYcMmP5iIVuhqPwhugcFhpgHzWFzb
         rZ6cn2LYdjReTizxLvLOFUNyoh59JUhGkoeTjaAydGSCbWW47hplEgT405nSt4oAYfFm
         D/Rvociz0q4qEF2qSMq4qKtbr0rBOhFfJ80jpUo/bnVJrchnU2XbtxrLhvdGpbv4EPVF
         XfIw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqmjB5/Z7xaVZr17lT/tja5Yd3gnX3YFuB4i9rQQkF4m7eEdjnyUqffOEIeuDq8NPBmWiWp7HgA2klK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGyUjQ+n5yRgvzq5KZPkIFufpkrodXaxS4pEINRhEyxeCwDhk
	HLt83n9w5GLRTqTgdEEmnoOux+rZVgii8qBYtYYsycbbakwVxxq3l9erYrgO+cidCuC/dMd332n
	n5aJzIwNK7Q==
X-Google-Smtp-Source: AGHT+IGwRcKLI+pxpkINDYm2hADm8gklgQ0v6xlkirlNb8ZsSQ2kH/SX2dFbjNUPcqk2XWYiHvvkl8Ocn/CP
X-Received: from pjee6.prod.google.com ([2002:a17:90b:5786:b0:312:18d4:6d5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc6:b0:313:d361:73d7
 with SMTP id 98e67ed59e1d1-31e513c2f2amr709495a91.13.1753221483628; Tue, 22
 Jul 2025 14:58:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-1-irogers@google.com>
Subject: [PATCH v4 0/3] Switch get/put unaligned to use memcpy
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing type punning approach with packed structs requires
 -fno-strict-aliasing to be passed to the compiler for
correctness. This is true in the kernel tree but not in the tools
directory resulting in this suggested patch from Eric Biggers
 <ebiggers@google.com>:
https://lore.kernel.org/lkml/20250625202311.23244-2-ebiggers@kernel.org/

Requiring -fno-strict-aliasing seems unfortunate and so this patch
makes the unaligned code work via memcpy for type punning rather than
the packed attribute.

v4: switch the type/expression variable __get_unaligned_ctrl_type that
    is used by _Generic to be a pointer to avoid 0 vs NULL usage
    warnings - always use NULL and dereference the type. This should
    also hopefully address analysis bots complaints.

v3: switch to __unqual_scalar_typeof, reducing the code, and use an
    uninitialized variable rather than a cast of 0 to try to avoid a
    sparse warning about not using NULL. The code is trying to
    navigate a minefield of uninitialized and casting warnings,
    hopefully the best balance has been struck, but the code will fail
    for cases like:
    const void *val = get_unaligned((const void * const *)ptr);
    due to __unqual_scalar_typeof leaving the 2nd const of the cast in
    place. Thankfully no code does this - tested with an
    allyesconfig. Support would be achievable by using void* as a
    default case in __unqual_scalar_typeof, it just doesn't seem worth
    it for a fairly unusual const case.

v2: switch memcpy to __builtin_memcpy to avoid potential/disallowed
    memcpy calls in vdso caused by -fno-builtin. Reported by
    Christophe Leroy <christophe.leroy@csgroup.eu>:
    https://lore.kernel.org/lkml/c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu/

Ian Rogers (3):
  vdso: Switch get/put unaligned from packed struct to memcpy
  tools headers: Update the linux/unaligned.h copy with the kernel
    sources
  tools headers: Remove unneeded ignoring of warnings in unaligned.h

 include/vdso/unaligned.h             | 41 ++++++++++++++++++++++++----
 tools/include/linux/compiler_types.h | 22 +++++++++++++++
 tools/include/linux/unaligned.h      |  4 ---
 tools/include/vdso/unaligned.h       | 41 ++++++++++++++++++++++++----
 4 files changed, 92 insertions(+), 16 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


