Return-Path: <linux-kernel+bounces-830479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF3B99C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A6D167E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C43002C9;
	Wed, 24 Sep 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b0L4EgwL"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D14437A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715898; cv=none; b=IdE9YS52TajGz4YsSztq/MnGu9ONo6hyeTbHvUm3gTSyoApB0W2OdoHYS2rVIBRUc9gr2jfD82yoiVIlgGmUor8EJxGpp0H0XIPWY8Nz7p59H9WRg+dlP/L8XEzVDkrr4Gw9Zu6l5zyQ+9yZeRj7G8VwxWY1BBe1o18e2dvfiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715898; c=relaxed/simple;
	bh=/IbWT+MMRGmXjrle/er25bxqI3caVdeVIh6J5q07kxE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=f9Lg5EpA0nlQvcO2CmwD47+q88wEh9bcsmM2IWfJSAEdRC9FahEL336JVLlTEphX9NCig1zaghQrUDP5QjSM2xjVD5YB5Tllk2wSoS1TC1N3+grtuL4DAbq6wy0rNg1AACZhrKYoymDxv6cIsOjOi08QgQxK6K7QxGozCEruFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b0L4EgwL; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758715590; bh=feSX1GmfgWpjZ5g0928zTjhvLUF3waPxTkQ36vSbBh8=;
	h=From:To:Cc:Subject:Date;
	b=b0L4EgwL7H9xDyUYJb0Cv1yCKY0AZ8sX9IqpW37Nu3mzOr8fs7avgcDAj/w4q0NyR
	 juRDPNntauXmb5WOiNLuG/P7pFzP2BpVhDzHP3Q7z28x6uO+jwX2CmTirvHPvtDlNU
	 3or9ZwH9XpbzBjoMPRZuhFw2T1gWdLN7gGVT3U1k=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 19702281; Wed, 24 Sep 2025 20:06:23 +0800
X-QQ-mid: xmsmtpt1758715583tar97unnj
Message-ID: <tencent_5E4F978D9525A58D97925ADDBADDB2193107@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqc9qgiDPH1QBNhznzV02Eh9A0l1mcgOUBEbUc6QOOrzi24Ck/Wx9
	 u8xOGkme/bELRJogUOQWCnaOsfJCybyamjZwxspyoLY/95ZFndBgxIePQHoOk8GaJfg97I98edmW
	 CuYkTGeN/e31AU1C7HGonj5P6nvJzpMkaIPi9is6L0IUcy1NAgvEDISpRlT3UYOqijhqUyG6leH/
	 HZZGMYcmUo+ynT5B6ELJP8+UCZuvoXatEwIFbrXIQTl5pblJ96oYGExYA8RtpOpQaye/Z6+vBi+u
	 bu7YDK8kkkbf4eDLZw2oV0WC7ksWiG2hG3iwBGBOsGrDEwCrBiDBnFMF6U9HBpSEZ6ncNJuWFZBA
	 vmToKSOJVf9p/3mmr61R/pWrb0ZDSETfzH8r3qRm9wYvL7W/B1G+MtEbYUpWp1Buo6SthkU2pB59
	 tIXCWjAsnM0emyv6BI9duffvFWJGlwlYrHM+RCZ6U/efMoJUk8FnreIhhT0NjPvQHEvsyrGSL93a
	 RAjsvNGffGRXh9v15Xvyf8dApbp0qfI5zsk+LoPUeISmbchQVCV6ky5Sj9A2o6AWse2ucxvAbbjP
	 zN3llmV2ilpyOVJsPt80os9Tq4+AhI1iy4ji7llcmmdAzGI9XvpSHHAE766CDJXAUGBAoBSYleyg
	 jJWbt0sKzslBTX6vcKXpu88IoODnyUCQZBLo2zIRrFcNHZRd9nr6fPlDNozY7tvUOHkv2YS5rvPb
	 nTnVLSmo+LumGvN8RUUZ8J64dlHdR0yev3pY225i4lXGLOwJm6VS22TP2qiOHYpNBJ3LNnfHtUoc
	 khUX16oXRN6rLBWHdcXn6L20zXNkaa3+W0pTvEkhKqCOqI5e9Q8GzilnqIvE3aVp1MbOt6Q0JtRl
	 bpZTrTw7yoJK+9fFynedNWIozSHLTgktOM6SBgCsndTKGhBwf88s/7PaQtHQKhN2NLjqoIhCbVee
	 vqHIEAdFjbrhMNtqIvHpP/zGl7YtefHNF550qrk2E=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: kees@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH Next] copy_process(): Fixed jump logic error
Date: Wed, 24 Sep 2025 20:06:21 +0800
X-OQ-MSGID: <20250924120620.1577525-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After futex_hash_allocate_default() fails, the logic should jump to
bad_fork_cancel_cgroup, not bad_fork_core_free.

Jumping to bad_fork_core_free would cause a siglock imbalance.

Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index e9a7fb5c3e49..a0b8eeeb1d27 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2349,7 +2349,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval = futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created
-- 
2.43.0



