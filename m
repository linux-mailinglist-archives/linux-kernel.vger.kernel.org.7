Return-Path: <linux-kernel+bounces-822926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8572B850D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9F7173E37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35351311C3C;
	Thu, 18 Sep 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fu5tYxIF"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169D31065B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204363; cv=none; b=jqiO+T5F0XdPKcUPJVP9PMm397gSdmwaE+yapnWMdR8+rAGWi3Wq7jJ+Yv6GLn+0+h/5pvBHU73ER9xvxWJuqYRgKVMnivwb/aZA13/RxICrKXEizc8/3hh/DY6t6ayGyOTiBv/EpjmAdFuLGFHA24y5f6bVZiDt5YvKSZEbJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204363; c=relaxed/simple;
	bh=/5HhdQcxMvAGlf0Tsk8GdQh2Mls549x0+PiJde1VHsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZfaLH7evEKpQCXT16sqkAY9O2844TyCVJ8Rmy+6t1Yg6S8sex0PDf9TGUWJhcE4MuLlfM+xl2QRxjutoayvLSgibcCyE6xmjk+GJxVfMxdxeY8kvABN610XF4jJYzU3eJdF/zO8tOFAbrEZ8BkW47nIYG7GIOdPq2FXVhjwTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fu5tYxIF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso765601f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204360; x=1758809160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=fu5tYxIFzwau3Xm1wdr0WGRp5ptZCJAJQVTlKpZwqrCtlICyGAjF7UzjqvBwHsdaLP
         Kc3cVxXFggh+BePUS4Ya+lROGTLBQ6uyBkKGG+4EWlFeP2lofLzLWDKWA0jKO5AtbPXi
         3u/TZxquGICV5ffmgTzU+LnepwblIAkqXL31s1cPxdRG3ZlbplVqrdQMmsYdwxbe/eRE
         3cm8wba1+q5PPQCOx2c4EjO2s7G+czYPBxoGtfo7AWsyyqa8ExPzkUPHiCOz9+i/IuZ9
         /T7ktlHM7wqGFqSJFOi4rQ+tq0TaDFEy9v4kN+4f34aMiRrUv+fOXeM98MD7hHAyrqWz
         Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204360; x=1758809160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lBqaGhUvOv+7EeFvUiY/U7KvKRahgMMUHhFj4QhTCc=;
        b=OkHaMgTbih/u23yn2FTzMvtBFTG6Qd/FrhH7ALCeWROqqmPBSTGmbxFSQBCvoVQ0IF
         EEjYeU7O1yVTdaGl5DNSgrniMW10SmtvafGPgRJUU4lYUhKF8ewJhJRCcr2WiiczVeW/
         cpcTdzp2btFO2uOu1JIU8AJr+c0y4xE3q4phSuLCIHJELjnqHt9q4f2P7uwhig4Krths
         s0pnuuWpVNFvVoG6pvWjifXwlXu5uV30wpVixh86eN8GDV0B99u0GaW1JlOV6MLzSnKm
         yC7TPvgtUXXEuMZJnHXk3pLZloXy7ukrg59Mc6/W6WBaHkckF6G4ez0WE+oNS6XM+7f+
         ICnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfYhk67VW5WV1RjyAPckUHUI1IKYaFb2AoPHR0Kcy+rTnAyAKhJcRv9HtxYNohz1DandBBy5LlThfXUXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6huRRwoEqrv0awzKlZRy9a3HJfJq2v4KS7NF0P59HYxj+Q8PH
	ja9qynxqfwJKTvFbhicNn6dCt7GI+OSw7ZQe+E1Va4APm2VFlCsQ4N5Eb1sUG9TH8lwqok7N1Bt
	MjQ==
X-Google-Smtp-Source: AGHT+IHiULKUOB+EsrBDrVl5HZcjneDq5C1ugpdpG+JWPfxVb71lR0xGZgLTOsEBDQp8WA+TeuGcjvm7Gw==
X-Received: from wruk7.prod.google.com ([2002:a5d:6287:0:b0:3ec:da84:10a4])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40cb:b0:3ee:1461:1659
 with SMTP id ffacd0b85a97d-3ee146119c6mr1267126f8f.31.1758204359630; Thu, 18
 Sep 2025 07:05:59 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:23 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-13-elver@google.com>
Subject: [PATCH v3 12/35] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5b0407..59e345f74b0e 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.51.0.384.g4c02a37b29-goog


