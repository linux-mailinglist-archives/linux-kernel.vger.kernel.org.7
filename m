Return-Path: <linux-kernel+bounces-723396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DDAFE668
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2CB3A9C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C52D6618;
	Wed,  9 Jul 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuZWXVsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE60295525;
	Wed,  9 Jul 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057887; cv=none; b=OjGALVdMUjBrzu+PB58HZNBOA+Wm7ca0QQZNs2XImdAkShkoRw2aJnjaDbpSyOgopIJEZxEmZYnrsXpPTWArzHW1YfoDXn1cVd8fZgSPzTXkHSxEHAMhQmtq1USlo6d7enpdmbCJKB0CFBhpGjY3U0Bql8cp8pw7ffT9tHqLw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057887; c=relaxed/simple;
	bh=VnCHMy4SVOJ//aF+dQrI1zkwjND2s8/53ZppDcbJ8vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1hz5PYV8O4poFYNaddjhqAl6LoIXDxW1KmwlcNC8Fkrv8hRpk/WtaTdWJ7uVPKcsvx2ynXBj4c4zf/0Lc7BCpMGFcQ5YqBi1ddV7kqPOXWg1xk6ELh7xO+E9EvDLfeKsCOS+w2ARrY9+JO7p78BRWfY7kZEX/ItcIGa756UX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuZWXVsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD25C4CEEF;
	Wed,  9 Jul 2025 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057886;
	bh=VnCHMy4SVOJ//aF+dQrI1zkwjND2s8/53ZppDcbJ8vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuZWXVsacd/3WRJGbjupW9yWvpGwZ59GDM5yslDFivUwLNi/hG8HJyT8diFgOL3bS
	 Fnliyh9KzvRVnTKX7rdoFj0MMpHFOGg+X2x8U32983bzPnJ/LdAhQE9+Fdp8AEjOGI
	 ao/3TR4Rdm5cHXgnkDuArespwT/b5UfclLFPX7vJtlpDqyaNEZG1aBHIAEXuDQUKR8
	 lJdazJdUfag2d0JnfgiFmbeGxnpPWSRIOl9mStAjOixJCJrdI8x1eRnwztfVamn8PI
	 Hk52fC988OUcYai4v3MSxIp2jkr+l3s2S7pmhAnAICBOEXJi/u0eHi2ASXVyYqLIvN
	 I3R4TylnHqlvA==
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
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 03/13] torture: Make torture.sh KCSAN runs set CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y
Date: Wed,  9 Jul 2025 16:14:04 +0530
Message-Id: <20250709104414.15618-4-neeraj.upadhyay@kernel.org>
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

The RCU_TORTURE_TEST_CHK_RDR_STATE Kconfig option is used for low-level
debugging of rcutorture's generation of overlapping and nested RCU
readers.  It incurs significant overhead, and is thus not to be used
lightly.  But if it is not tested regularly, it won't be there when it
is needed, for example, it would have found an rcutorture bug in the
testing of srcu_up_read().

This commit therefore uses CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y when
building KCSAN kernels, but only for the --do-rcutorture case.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index c518de296871..53f61f278fd7 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -378,7 +378,12 @@ function torture_set {
 			kcsan_kmake_tag="--kmake-args"
 			cur_kcsan_kmake_args="$kcsan_kmake_args"
 		fi
-		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
+		chk_rdr_state=
+		if test "${flavor}" = rcutorture
+		then
+			chk_rdr_state="CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y"
+		fi
+		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y ${chk_rdr_state}" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 		mv $T/last-resdir $T/last-resdir-kcsan || :
 	fi
 }
-- 
2.40.1


