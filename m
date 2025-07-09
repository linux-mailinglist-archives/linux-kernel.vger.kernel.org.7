Return-Path: <linux-kernel+bounces-723399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34581AFE663
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E053D1C43397
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D9C8EB;
	Wed,  9 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4g4NyRe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B673299A82;
	Wed,  9 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057905; cv=none; b=nRpb5qaKlc+q79COc/R9+GnoSKyjjFxR/RLkDpErW6DQN58uIxnxCJKt1/m3xV3Crki4cjH417bi5ke6w1rrSbEpQruwbRMYvlduaIIroN6gQh4z1bqjO5dh4u9h4pOiuhDHKIHDQ2WZngxgWM2v+sVzA3ZiZR3N1au3cDjSJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057905; c=relaxed/simple;
	bh=bx494dg87ZcHtSWenFZRSz/6PX1NsdmicOQArPw1Yf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQqo0qqi87AfQPSAXdROU0n7IOOUuwnPtNGvDqCdAZx55uUfDal6oOzCGYBwGnCPD2MqbwgoU3gfcOK17/Ho64IkdWbCbD849Trc94vm/c19CZz5lQj3d7kF/HWGGLipHuE+gst6rhHoBrKs2zKilUh/tsE8egvtIPcUGF7omSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4g4NyRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A58C4CEEF;
	Wed,  9 Jul 2025 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057905;
	bh=bx494dg87ZcHtSWenFZRSz/6PX1NsdmicOQArPw1Yf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4g4NyReeqVSrXkrgk9w6PhbRT5vzDJ1qGbDjGfEuZmQ9BNT7kmN8QNoZ6n+9YGlq
	 AzkuacTEBBb/J/TnV97zd3clRuhChXB5+PkLgTzKdlDKg2JlevslNCWdlutFS9bLjd
	 YTXBkucW8KjKLMNfZ8F3LDrhiHOgLa4vS7T8yhpODIC6ixYcpoP1LYj2mcbGD6pKRM
	 YelSHGOBurxYrfKTvEWCrkhzeraJOHQEcB2cusjtbPmib1ayQQuRHlN8ikcvhaDJUK
	 tjWAo91XPUix4gRZ33ipgUSzFDixLPhXUe6L2gRs6Yyb1SCC5AwG6rvyA/MuMMnqwU
	 Yqjb1SaJSEAKg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH rcu 06/13] torture: Provide EXPERT Kconfig option for arm64 KCSAN torture.sh runs
Date: Wed,  9 Jul 2025 16:14:07 +0530
Message-Id: <20250709104414.15618-7-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The arm64 architecture requires that KCSAN-enabled kernels be built with
the CONFIG_EXPERT=y Kconfig option.  This commit therefore causes the
torture.sh script to provide this option, but only for --kcsan runs on
arm64 systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: <kasan-dev@googlegroups.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 25847042e30e..420c551b824b 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -313,6 +313,13 @@ then
 	do_scftorture=no
 fi
 
+# CONFIG_EXPERT=y is currently required for arm64 KCSAN runs.
+kcsan_expert=
+if test "${thisarch}" = aarch64
+then
+	kcsan_expert="CONFIG_EXPERT=y"
+fi
+
 touch $T/failures
 touch $T/successes
 
@@ -392,7 +399,7 @@ function torture_set {
 		then
 			chk_rdr_state="CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y"
 		fi
-		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y ${chk_rdr_state}" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
+		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y ${kcsan_expert} ${chk_rdr_state}" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 		mv $T/last-resdir $T/last-resdir-kcsan || :
 	fi
 }
-- 
2.40.1


