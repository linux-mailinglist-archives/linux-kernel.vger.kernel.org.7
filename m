Return-Path: <linux-kernel+bounces-822941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B18B85222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB34560440
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6812236F0;
	Thu, 18 Sep 2025 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6mf/cKh"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE38318157
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204401; cv=none; b=eXUzbBL4K+w9cm2LjDwIsxsar65HQevkWUmZUJ2Kt7XA6FqtnrIqONBWeK54vqEiJ3pz7kylgmRn1k5ADh9fLApHy3MwM2aeNI2HAWeKbzMCVjraSSjqnOBzsaaKGYQLxFz4O4eebpXp9RSGWdgWJfL0ziLFqhKIsU6LAB7k2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204401; c=relaxed/simple;
	bh=dlga7YnphSnOGIQrIQaBJBfVrzl27d5Bc0V7ZNGYDq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfM3RfxeWReOYYMw9dt49JFoefwPkGgl2TSNeH9XLGwdsfiXzLu5G3Ys7kzdRE4khYbiUbGKTQoF6vyKAM6NgauySK4TjouPQ3OBsUZzqOt/ZaPOoPyICbIboWptrs0NzjgRJwgqTpylcCbFbk2sIaOUVLayBUbPYBu5uhM5CHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6mf/cKh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso5840175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204397; x=1758809197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhic53vYgugE24TxlxF+xx8w5glItenUyktwwUAacwI=;
        b=e6mf/cKh23OtOLaa85mS/JtKU2kqvrYVFiAanqZ/8YAS6U1D6Xt0XqD5ThnU8uMT9t
         AcWsQ8KiUXmovzqPiSL+AHPyL56ckk7WgWCOAdAi3gNkDHTUd0W9cinYfjkqwH8pc2p/
         a1owrBxFfeTl4M9tJT8bWhopr2SoFw9WRXLfSl6QZjG2ErdXiE5ksrs7g3OrI8wANrf2
         RLh1m3JDnSn6EVsebG8TGvDRdWUR44DmPK1THCP8KDwmR1RTph+3O7xib67D6xlIaTL4
         sSn0Xkqe+OzxUNxLqxvIV86VJtM/eWxPLnxyz/2LTV2dUm5vXNwKqvWWy71yiWE2RwKS
         CDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204397; x=1758809197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhic53vYgugE24TxlxF+xx8w5glItenUyktwwUAacwI=;
        b=YA/+Psyw8vPsN4pAqxrcoXvHO5MRPa8ujvY3llGPQ44LBLUGfDlR3RS7Z/v5nxflwm
         Hzile2lD2Q4WYY/9NxNhjgEBciwrymymh+vbdeV9lQucg5GJl3QcGnMEcBfK4jnVt5ed
         XS77yqvDrKdewHcXgNsa3LELxATBacZ0kHe1ys+uk+xlot5WucQnzyvdkupr691w2bJL
         EYjvQatsiH7TRNRw9IZRLyNdCOswoTHglDdbIraaks8SIvfzFSEBLF1d6JIK5k++7MoU
         F1H8SR7Nhq26wMce0vJhKGKQPnUf0xpUeHWJle3WH5K4zg2RBQroFzA+uriKA64teUIY
         vsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa9i98GAUri+JM02jXF8zqdM9Hz45hR0h8+SkRNzyb0C4D75pQzaJrjy73j9Bn8jE5rgmORcYP3NdftPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlQiShFuPBi4oeMjDoGlTp83+fWt8RlCVWHL+cHoBJPCcNGQh
	yMnnC82mHA0nsT2zEIgVV+d553CSYQ0rU+ODZ4i8avayirsU4Z+KSgQ70lKjlFrR5UEhmnmCjpl
	mnA==
X-Google-Smtp-Source: AGHT+IHZwXc50wF1UKzRkCSl9Zlzv0YXfIKjEUT7w3tckKijx1tkK0IOXg5OQwciPpS047ZOEU7YpUJVKQ==
X-Received: from wmqb11.prod.google.com ([2002:a05:600c:4e0b:b0:45f:2306:167])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a
 with SMTP id 5b1f17b1804b1-46201f8b09fmr54309365e9.7.1758204397465; Thu, 18
 Sep 2025 07:06:37 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:37 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-27-elver@google.com>
Subject: [PATCH v3 26/35] MAINTAINERS: Add entry for Capability Analysis
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

Add entry for all new files added for Clang's capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..da4c8196c1b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5951,6 +5951,17 @@ M:	Nelson Escobar <neescoba@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
+CLANG CAPABILITY ANALYSIS
+M:	Marco Elver <elver@google.com>
+R:	Bart Van Assche <bvanassche@acm.org>
+L:	llvm@lists.linux.dev
+S:	Maintained
+F:	Documentation/dev-tools/capability-analysis.rst
+F:	include/linux/compiler-capability-analysis.h
+F:	lib/test_capability-analysis.c
+F:	scripts/Makefile.capability-analysis
+F:	scripts/capability-analysis-suppression.txt
+
 CLANG CONTROL FLOW INTEGRITY SUPPORT
 M:	Sami Tolvanen <samitolvanen@google.com>
 M:	Kees Cook <kees@kernel.org>
-- 
2.51.0.384.g4c02a37b29-goog


