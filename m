Return-Path: <linux-kernel+bounces-724246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E281AFF060
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EF7562B53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EED238178;
	Wed,  9 Jul 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDkFUTKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A881233735
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084218; cv=none; b=bWLeNQOBU3fa2I+wnOP0R+LK1OpmzXI5qX6fJIsXULPA+taWMCHGunFyCHNilqI3lIGYSXajI/SoedW/eBYvlWbTlkvTL3f0oLIvyRRr/YQFADkZFIR2waUdasRFJ05Nxc3ocmdirFoOKL0pkeGKcRCvOT8l1JWSsh0h49NRdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084218; c=relaxed/simple;
	bh=NPA5PmoXyXmbfTpWG4GPEYufU9pz0dSoZa+DAsVxSgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XM+eWS4vxb5tmifzdOL3Ijlam0bEOjcEzGo/UXyxKYX4ACIncVEkzCIS3DXWd/sVXSjRa2hTW7B3clSQ8WXUUrZdqBOVvGiUf/EqCFNjxNnr/0fEv7dZMcYBnpT0rqRr1KFBFcI0Br1R2A+ZS4BcVjiotDovC52bvYUVYx4dpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDkFUTKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA6AC4CEF6;
	Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084217;
	bh=NPA5PmoXyXmbfTpWG4GPEYufU9pz0dSoZa+DAsVxSgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDkFUTKU+pHZdheAHk6Mag9P6EExptkxRNEZgQs0mwuwocmxVE5zA75FqZbMHtrXj
	 kIUIinhe7ePpmroy1FS3YZ9z0GVun6SMQjYsdqJAkAK1GMJxG6r9IbXfsSvkjZaEnp
	 NqhhCmODM6T8JogW+A2Kh+QVKgRrmfdgFkx8gjzINfKsDpDVF1Dgo8oxKdCoYhtHno
	 eeD0PTQNAEP3+DUe8rC9fqND91KBztvtfrvDTY1prti5kuM5/mx2ugbafxHzdOTOyv
	 BMEMFY6rstQEXjGMM9bwVwcpiKcZCqwSDXin0Zgdt89e9VrYhOTx8JsyyN9Wflc1Vq
	 lVVJk3/pwwUOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1C086CE087E; Wed,  9 Jul 2025 11:03:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v6 2/3] lib: Make the ratelimit test more reliable
Date: Wed,  9 Jul 2025 11:03:34 -0700
Message-Id: <20250709180335.1716384-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

The selftest fails most of the times when running in qemu with
a kernel configured with CONFIG_HZ = 250:

>  test_ratelimit_smoke: 1 callbacks suppressed
>  # test_ratelimit_smoke: ASSERTION FAILED at lib/tests/test_ratelimit.c:28
>                    Expected ___ratelimit(&testrl, "test_ratelimit_smoke") == (false), but
>                        ___ratelimit(&testrl, "test_ratelimit_smoke") == 1 (0x1)
>                        (false) == 0 (0x0)

Try to make the test slightly more reliable by calling the problematic
ratelimit in the middle of the interval.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/tests/test_ratelimit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/tests/test_ratelimit.c b/lib/tests/test_ratelimit.c
index 0374107f5ea89..5d6ec88546005 100644
--- a/lib/tests/test_ratelimit.c
+++ b/lib/tests/test_ratelimit.c
@@ -24,19 +24,19 @@ static void test_ratelimit_smoke(struct kunit *test)
 	test_ratelimited(test, true);
 	test_ratelimited(test, false);
 
-	schedule_timeout_idle(TESTRL_INTERVAL - 40);
+	schedule_timeout_idle(TESTRL_INTERVAL / 2);
 	test_ratelimited(test, false);
 
-	schedule_timeout_idle(50);
+	schedule_timeout_idle(TESTRL_INTERVAL * 3 / 4);
 	test_ratelimited(test, true);
 
 	schedule_timeout_idle(2 * TESTRL_INTERVAL);
 	test_ratelimited(test, true);
 	test_ratelimited(test, true);
 
-	schedule_timeout_idle(TESTRL_INTERVAL - 40);
+	schedule_timeout_idle(TESTRL_INTERVAL / 2 );
 	test_ratelimited(test, true);
-	schedule_timeout_idle(50);
+	schedule_timeout_idle(TESTRL_INTERVAL * 3 / 4);
 	test_ratelimited(test, true);
 	test_ratelimited(test, true);
 	test_ratelimited(test, true);
-- 
2.40.1


