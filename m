Return-Path: <linux-kernel+bounces-857310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A5BE67BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 102ED4FA7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10F30BB84;
	Fri, 17 Oct 2025 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLc++Wc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FB19DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680265; cv=none; b=BwbYmlEVwNDOG8gagsjwesbRhL1wbbJEjXaLsliyWzWCsJ9L0cV/f7vcHAxFAev6ydoNMNX0R9TJYOctDKhF4XK9f2zaXhPmQN83A64m1ne1gLA8utSFJ29Xa0IvVEc+qPIALq2pUKca9Ol2WFr0PUTwWHoM7dj5bs21y9+6ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680265; c=relaxed/simple;
	bh=KXf/o/WY+JxyoW9ztre88CsY2H7CHSjx2eANrNZV/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqbW3k6PFz373FFjVrNjzdT45ag1mPl6AC8oylq6ICZHFRPEH1n6Gf+3kcnDeHTTXwIQEyimb4peMR4G1TGnhvLL343uVKAHL+sQpeSiQ/N/xxIqr528UbiJbBmlRKOsNn9tJjR9hAvoz7Ay3vJRVOnqVpiVelLw0DDmMEk/6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLc++Wc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33557C4CEE7;
	Fri, 17 Oct 2025 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760680261;
	bh=KXf/o/WY+JxyoW9ztre88CsY2H7CHSjx2eANrNZV/T0=;
	h=From:To:Cc:Subject:Date:From;
	b=RLc++Wc840D2Z6BoA5hCibzKQw2W5VzvOiEx0kOdwxhEte1SVJ1SfOTXjA0qSU2LM
	 JFbANXA5mgRuT2VNpavC5C1URdWs+k56bjpa+s9LJCLb7O+bdRJ4WylwZq+iKtJmex
	 NFWXO6lmD/fDhmURD2J97I7EpiquA5cCIBWmCjVDbm8QLHGO85r4hklIfyJL2Qc3Oj
	 GIjiwOFUpKmhk+IsP4Ilk5YihzHAA0fPlzlFyKo/IiHNir1lSJ1UXXGHIJ6c0NdTat
	 w2EApqPBlcZZ4YA+kSWB1LAaAn5RknfCRRxE1Q5Xcmjd51Fi66LOawLdiX22Qdl4ln
	 163pXVcWKPQpA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9dMl-000000001uO-3x6R;
	Fri, 17 Oct 2025 07:51:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] clocksource/drivers/stm: Fix double deregistration on probe failure
Date: Fri, 17 Oct 2025 07:50:39 +0200
Message-ID: <20251017055039.7307-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the devm_add_action_or_reset() helper is to call the
action function in case adding an action ever fails so drop the clock
source deregistration from the error path to avoid deregistering twice.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/timer-nxp-stm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ce10bdcfc76b..c320d764b12e 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -208,10 +208,8 @@ static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_ti
 		return ret;
 
 	ret = devm_add_action_or_reset(dev, devm_clocksource_unregister, stm_timer);
-	if (ret) {
-		clocksource_unregister(&stm_timer->cs);
+	if (ret)
 		return ret;
-	}
 
 	stm_sched_clock = stm_timer;
 
-- 
2.49.1


