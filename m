Return-Path: <linux-kernel+bounces-581746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF9A7647C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DC93A7FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB30B1DF977;
	Mon, 31 Mar 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FKfovWl3"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943811D5173
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418038; cv=none; b=PuRbw9YabiNiQ59WGGeUoxfO0/qc5vCJiHR6TydOkP8yqEIR3onj3sN080RK5zol4npq41v0JMYrW3Tb8wC8Czfb15OPCaQiiBPpaCuJMB4z5XRx3bXmr1Vsn5Qtw3wMFTi/78OataiCs7ElFOBXz49RAX4hkxvX8K5pacWNT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418038; c=relaxed/simple;
	bh=NIK8HcY+gTICfzosHx6U7V268zslfI1gw5SJt6kSV5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt7ks/B6HZfa50oeczbBmuNE3VOyBA/TM+h6LwflisYNKbgMf6zAmXgCWu71gr7JAeK5yuJFcieX7or/YVAqBzXtY4SKVx4pZaoCRavkWbW4/bg7sYZHFRzcPCLmM/+QtqoRqIXFASSfgVl7k4lEpGxxWxxzv3ifJYT49DjO0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FKfovWl3; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZR79s5z8Rzs8j;
	Mon, 31 Mar 2025 12:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743418033;
	bh=eRy0I8DOnQ5/p28NM9gKVlG+Ob81WFeDjytw+o7qVGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKfovWl3mVgnHd2abcQQUi7o7vQNqywJWxZTM89V2iloLAanLPgog2xI5kS1fw4Rz
	 2DQFoHFNK6/6DFNsvVLeb44FEYVoGAaFgRDDR9Qh/9yN7BWSH5zu4lTTevdL13JlDS
	 g8bTkwbGBVPL19Jqo4eKGh9lWyM6M9snPwDpQQIQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZR79s1wM1z1Dq;
	Mon, 31 Mar 2025 12:47:13 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Paul Moore <paul@paul-moore.com>,
	syzbot+8bca99e91de7e060e4ea@syzkaller.appspotmail.com
Subject: [PATCH v1] landlock: Remove incorrect warning
Date: Mon, 31 Mar 2025 12:47:07 +0200
Message-ID: <20250331104709.897062-1-mic@digikod.net>
In-Reply-To: <67e919bf.050a0220.1547ec.00a0.GAE@google.com>
References: <67e919bf.050a0220.1547ec.00a0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

landlock_put_hierarchy() can be called when an error occurs in
landlock_merge_ruleset() due to insufficient memory.  In this case, the
domain's audit details might not have been allocated yet, which would
cause landlock_free_hierarchy_details() to print a warning (but still
safely handle this case).

We could keep the WARN_ON_ONCE(!hierarchy) but it's not worth it for
this kind of function, so let's remove it entirely.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Reported-by: syzbot+8bca99e91de7e060e4ea@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/67e919bf.050a0220.1547ec.00a0.GAE@google.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index ed0d348e214c..7fb70b25f85a 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -130,7 +130,7 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 static inline void
 landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
 {
-	if (WARN_ON_ONCE(!hierarchy || !hierarchy->details))
+	if (!hierarchy || !hierarchy->details)
 		return;
 
 	put_pid(hierarchy->details->pid);
-- 
2.49.0


