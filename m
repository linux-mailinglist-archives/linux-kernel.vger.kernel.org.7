Return-Path: <linux-kernel+bounces-626220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CCAA400C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 03:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C071A8737F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 01:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC01A01C6;
	Wed, 30 Apr 2025 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYnxc77K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E8746E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975127; cv=none; b=LnizA6pWzRxsu+Q8BaIbokK0EraZTxUgmCSiuZkLRfBkAWZLJbpPze1IwTpj/8SVx9nPRBF73w/G7z6HhB9hXn/IF1LX5b8PToSmmqpWZJF3m3JeY14umrLZ1QWWE0avYNqGTvBOB5TviBmAbpcCPYC6Kg3Vhvz4+2Fp1/w9Zes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975127; c=relaxed/simple;
	bh=oqGQLaAZjOiJlIyJmpFkRKe1yhFE6Ac++q3VgQmENoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw+6ro3HemTLGksF7XOzN1UFlC2UoG+Z5vNGz9rbLBy/lr2/vw1XWyqCW8+8+EcwnC35QFlR0daaLqlpG4+7FKVbBA6eJmjcZWgzd7Of/r/iHqJdR47H1iY4w1Lgp/g/lUHxstOb8aBfeLc3NNIl6wnt8Uqz8Xa8/O4sjsnVKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYnxc77K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC6C4CEF3;
	Wed, 30 Apr 2025 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745975126;
	bh=oqGQLaAZjOiJlIyJmpFkRKe1yhFE6Ac++q3VgQmENoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYnxc77KczXhWfNJw8sUDsIgf+ncwZf8BjD0MBgZ3Xnv+79uLjeTCCapab/0X30At
	 rcWRHPo/6zUTibl2ipykQ6Uf6tm++qhDCUgbT8dqXEnT627gnCD6qlGQOxsvIESaH0
	 UMC95LPNEf4xSFm04WKLXog+sCnUo6VG6Oog40eB5jp1GoqJJ2SHo1+AvnozsC1Hy4
	 TZid0RmWLjILBcjcAqLcZJoq//McVJ0KkynGU/sUhUYQ7hICE1IVzXXTPwDeNohcNa
	 vNgdErBNmZwYyUUySoE7fHLcV39kF8Ofswfp70nCsv65y1I3wMBmQCcKoxcBNLtDrJ
	 PBBRLWjdgCAXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FA2CCE0E5C; Tue, 29 Apr 2025 18:05:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 06/20] ratelimit: Convert the ->missed field to atomic_t
Date: Tue, 29 Apr 2025 18:05:10 -0700
Message-Id: <20250430010524.3614408-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop>
References: <b0883f20-c337-40bb-b564-c535a162bf54@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ratelimit_state structure's ->missed field is sometimes incremented
locklessly, and it would be good to avoid lost counts.  This is also
needed to count the number of misses due to trylock failure.  Therefore,
convert the ratelimit_state structure's ->missed field to atomic_t.

Link: https://lore.kernel.org/all/fbe93a52-365e-47fe-93a4-44a44547d601@paulmck-laptop/
Link: https://lore.kernel.org/all/20250423115409.3425-1-spasswolf@web.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/ratelimit.h       | 9 +++------
 include/linux/ratelimit_types.h | 2 +-
 lib/ratelimit.c                 | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 8400c5356c187..c78b92b3e5cd8 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -24,20 +24,17 @@ static inline void ratelimit_default_init(struct ratelimit_state *rs)
 
 static inline void ratelimit_state_inc_miss(struct ratelimit_state *rs)
 {
-	rs->missed++;
+	atomic_inc(&rs->missed);
 }
 
 static inline int ratelimit_state_get_miss(struct ratelimit_state *rs)
 {
-	return rs->missed;
+	return atomic_read(&rs->missed);
 }
 
 static inline int ratelimit_state_reset_miss(struct ratelimit_state *rs)
 {
-	int ret = rs->missed;
-
-	rs->missed = 0;
-	return ret;
+	return atomic_xchg_relaxed(&rs->missed, 0);
 }
 
 static inline void ratelimit_state_reset_interval(struct ratelimit_state *rs, int interval_init)
diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
index 765232ce0b5e9..d21fe82b67f67 100644
--- a/include/linux/ratelimit_types.h
+++ b/include/linux/ratelimit_types.h
@@ -18,7 +18,7 @@ struct ratelimit_state {
 	int		interval;
 	int		burst;
 	int		printed;
-	int		missed;
+	atomic_t	missed;
 	unsigned int	flags;
 	unsigned long	begin;
 };
diff --git a/lib/ratelimit.c b/lib/ratelimit.c
index 85e22f00180c5..18703f92d73e7 100644
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -66,7 +66,7 @@ int ___ratelimit(struct ratelimit_state *rs, const char *func)
 		rs->printed++;
 		ret = 1;
 	} else {
-		rs->missed++;
+		ratelimit_state_inc_miss(rs);
 		ret = 0;
 	}
 	raw_spin_unlock_irqrestore(&rs->lock, flags);
-- 
2.40.1


