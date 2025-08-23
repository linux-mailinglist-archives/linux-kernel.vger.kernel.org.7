Return-Path: <linux-kernel+bounces-783251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B293B32AFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC7F5C119B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5432F1FE3;
	Sat, 23 Aug 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYiTH1CB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4ZSn6v+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E222F0C6D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967203; cv=none; b=hRiBKHM5j3j8bxlFaVzgUyuyy/jyOjKOFT66SXPSjSyUodyETFYkfh36UKI2OY4lQN7EC0wVkhU95RbGerUMx1NhgWfoXBZI+1QkhHmnT0x2f6q/GiXTkslmbFL5+2RGSesUJp9XzR+oevtr8dAbmdngUaGyz+Kx8A8jOFQGqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967203; c=relaxed/simple;
	bh=nMlNVmuLCaPER50+OebglV5Z2zMqBLfEuJ8hNIcC/7A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=grcDEe4WUthphARII0ZfMqBR6BFdeOR5o3e0qvBxug7+DOSFn1EngR2GNSr4h+bOGGWysj7ix7r92AYh5n6r03F092tkWkz7lq04sH3V/FaJoZKw/4fLjddbvus4aco3iYGTlu3ajtlaxWhBDr84OI+Woo/z3Kgyj33G5pcg8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYiTH1CB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4ZSn6v+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.612526581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IvFox5Rkn87y9XhjhzrcVRW95fbzbaB+KfxmN/l1TiU=;
	b=OYiTH1CBWadZF4m3+aVx96g2mTd2YCh1ZsGFpMhhDGVRJltlmKH+fwCQyPH/gBdxEAtao9
	/7HPrcqqwJ9jgksK4fYriCJO9dcgu5wViLwrXaVVP4ecBHpk40M4i3dXr5Gvj/Dv3lW5X4
	kSv7MLAprYjff66AMgsV5CjprkV5U+yBB3DC12qarWj+314STBBtn0sWJGRUiaOa7UnK7E
	9sYborRyif+4NJS0mN5oMThs/GCsWmgr/O4i4niNXhaxXZSwpIzPrJ+R2QanWsTnHgF6zA
	tc+gHZOowCdkPu5EhILMy/oV7AU89iHbeO6CaK51J5pNG15WUVNVbh2iaTb30A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IvFox5Rkn87y9XhjhzrcVRW95fbzbaB+KfxmN/l1TiU=;
	b=h4ZSn6v+IvTOeIPBx/cyKAF0E1AVkgzKVpgXLSiWvvvaVCMKPuEMXqnpCarENc9RT6S8OY
	stKLgXl1X/F8KqDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V2 21/37] rseq: Make exit debugging static branch based
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:59 +0200 (CEST)

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_entry.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -275,7 +275,7 @@ static __always_inline void rseq_exit_to
 
 	rseq_stat_inc(rseq_stats.exit);
 
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
 
 	/*


