Return-Path: <linux-kernel+bounces-634851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA814AAB4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672B0462F49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0F345459;
	Tue,  6 May 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hznrb6GK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B652F3A8F;
	Mon,  5 May 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486891; cv=none; b=FueWDv6YdKqXJzySPv1sITqyzoDnxcCY58deojLDcjlBQEIqGzUqnvKn+HXMxbbaTt9qDk+uBpDgUaE3z6WI6ZKOAa99FdUONBBPJdOoI7s+ZH/vPWgM4IgAwZXuwehwlJpWtetvLvLULEqdZWt6z9BH4h8bKxsQThtJDmdP6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486891; c=relaxed/simple;
	bh=8ONW94dM+NZTcEz/+rs4aAEOz/0Y7F+L1BCO5cWJ4U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aa0H3klfq5aWcaoMxVisA/diA2rd4kRWmB6aNkFGi5QNR2DSZs2OOm90+oZco3Mf+oOZGwhKw0K6tmJ7iZka4TQMxO+8xeCdsQ/Q7enMDs3jRZF8pP/yM86/nzFtF0nirUijBhXCVuChVAtjYY7kUshZblBilT0CRF/G3e6AO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hznrb6GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADB5C4CEF1;
	Mon,  5 May 2025 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486890;
	bh=8ONW94dM+NZTcEz/+rs4aAEOz/0Y7F+L1BCO5cWJ4U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hznrb6GKyQPyGbiWaY4gXCB7M/jZiuCJ7MDsf/etMk7aPl3qr2vbhml+YLtL/pWEt
	 LZOEeAGWgHDzzt7AYzI/X478lJA96b3BBCEvB3qIREvCP/q9ePL1rLksq9HtHGJYtx
	 4wL4QGt+9OG+iNj6lB2+zKqHrl/cN4QIbHxRBrzQYmGhpojWQRfSJ9GtrbmqYB/A95
	 o78g+VaONToaLXZtuGABTJRPAaiwgo959d3j4mpN6XGXV3LkFH+wGPvB7iju/7rwfU
	 geWXyrd4aETThPJjWU0pUKxYXFAyGJ/dwOsJEzYI5TfmB7MSFY30Nj6dzoPRR0E5E+
	 4NS00pFmFNXSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 5.15 046/153] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 19:11:33 -0400
Message-Id: <20250505231320.2695319-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5f2909c6cd13564a07ae692a95457f52295c4f22 ]

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155623.635612865@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d6cf93ca370a..fc08d4ccdeeb9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -161,6 +161,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
-- 
2.39.5


