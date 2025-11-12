Return-Path: <linux-kernel+bounces-898257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B999BC54B39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D037B4E1B27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DB2EB873;
	Wed, 12 Nov 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPV+HWXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D729AB1D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=tJK/6lc3GIdzecTLlniWUrEzB2gFTldTGGJqbM5t0Ozh8zUYW52esOXIjDCChKsNVU+YFmJiR5vUqPZnhO/xtKOSe4pVQQq93Bi54XrHbc4OwiaOjkbg86TOW3nLAOs7YFyDcwzpX4yGZ8Fg3dXzvR1Ka2uD2msD5SSzZpoiB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=wLQokJFz1wJt7wW+XrZdqXT92F4SQ3D4BM/d3+RYbOM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iAy6bxk3p/Mv15s3WnDJp406xf42xxeY66ypNXzDhg+9K46wSjg519pcoVOa9DBq0NxEGXJiOBIaIWA2FX/AVkK4zEBtdVchlOVjWgHYKEiFqaKjl11Mh/OHJpL+09bWkfaP80wpTK+gj4ejXcQAF/jd6vGbm45wcztL8lpJmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPV+HWXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E1C4CEF1;
	Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985993;
	bh=wLQokJFz1wJt7wW+XrZdqXT92F4SQ3D4BM/d3+RYbOM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SPV+HWXmrFaqCS7V3tDDaSxP2iIA5+3r1I2WLsa7qbwHQ6Bt5/ZnwGGaSvw4dfYeT
	 w1OkO6W3m1jL2JPHq5nCo4UGmgewrMI59m4RVRpQz1tVDwsuiPJHBoX9dwJ/kDNWoM
	 QGmjUTlZEPKJREAgcNWXZ0jsy6ESNHivz/5tGYG3UgLCABQcap2cCVv8/XJe5yyD26
	 ZQdwfeacnyn44S0RhKUI7DJ9tDV6TOH1NZMHPL8FbRylc8FGWHFHcupgq4gT3cXa1Y
	 07nWTBTI5RkTu22SHZgovDrsnsrJcasNoaqMgjoXYWKv8aWu6+BafoS78JLNJtq3Dl
	 jDmf6N8+mLN3g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCB-00000001EXL-13nG;
	Wed, 12 Nov 2025 17:20:07 -0500
Message-ID: <20251112222007.106173327@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:50 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 4/5] rv: Make rv_reacting_on() static
References: <20251112221946.389142361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>

There are no external users left.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://lore.kernel.org/r/20251014-rv-lockdep-v1-2-0b9e51919ea8@linutronix.de
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h            | 6 ------
 kernel/trace/rv/rv_reactors.c | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index b567b0191e67..92fd467547e7 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -116,17 +116,11 @@ int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
 #ifdef CONFIG_RV_REACTORS
-bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
 __printf(2, 3)
 void rv_react(struct rv_monitor *monitor, const char *msg, ...);
 #else
-static inline bool rv_reacting_on(void)
-{
-	return false;
-}
-
 __printf(2, 3)
 static inline void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index cb1a5968055a..8c02426bc3bd 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -347,7 +347,7 @@ static bool __read_mostly reacting_on;
  *
  * Returns 1 if on, 0 otherwise.
  */
-bool rv_reacting_on(void)
+static bool rv_reacting_on(void)
 {
 	/* Ensures that concurrent monitors read consistent reacting_on */
 	smp_rmb();
-- 
2.51.0



