Return-Path: <linux-kernel+bounces-584541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E2A7886C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 08:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331EB1890B27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F749233155;
	Wed,  2 Apr 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="LVLl5SSr"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527123315D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577036; cv=none; b=bsdHdBvYwDJVFjrhffcaCfe+n9SUvmWWHdszUmrtN+KnFt9oUq3bmW8Uw6npgQGBYg3pxaV2DitDUXh+jWDl3MSGXqtK6z8zlDJwMfbXkuJ6F9D9uBbSMH2DFTLAtQNtY2rYsovRRU17PlvwGZNfv/Fn7WyC0wg8lUg/vb16jJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577036; c=relaxed/simple;
	bh=9Sg9kuz2fH5uYTxXhqiNtv3/pgMGEMN7thju5HQChF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBud4XAF7/tLqM+BgUJHzBG1gYaTkhs7kMnYglGCv+3GO+vpX1EeIDfSWYjc52tJ/bsa63jwI9bFn44TzouG/UW/IeP19KOeAf6rOJEBNGdipYNzwHg8CjzC1cTO3p9chZaVdzJLDjxbgDzkGkSiVooJ2qVmz5whDf9TTPyvCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=LVLl5SSr; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 29CE41E000B;
	Wed,  2 Apr 2025 09:57:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 29CE41E000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743577030; bh=IT24407Rzy1YEgYhJgFPnlXxzb5aG8VqRI9H2OroBug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LVLl5SSrof5Apz8FUtb5xh7GC07vKuGPQuiudckdOmYulUqiGXmu1G/FrNgpl1zBi
	 Mn3P/4HwQOwv9kMNatOPaTqfD5PCpIMo2GLtIYwW2rLiC+WaX56JGcSKbjKsbN987r
	 spREII8n4U8S8BTBVO64rGQVelcWKktUGkATkBS74yXOUxdd7MXHTFQ0U7yOt89jPb
	 y6CEWG3KbGf3y/G7mavMwV6qro+NpBK92MBLknUxjcEukWmAv7lVU03oP516jArHfX
	 ojYHCHdfa4ppmC4Ez9/GXVlIVmpgHjc8ivau6jq30ODfU+sV3x5HF0Sj+Ns8VKYl0E
	 ixl3YsfOKrfTQ==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Wed,  2 Apr 2025 09:57:10 +0300 (MSK)
Received: from deb16-01-masimov-t-build.mti-lab.com (172.25.20.25) by
 mmail-p-exch02.mt.ru (81.200.124.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Apr 2025 09:57:08 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Mark Fasheh <mark@fasheh.com>
CC: Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>, <ocfs2-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Murad Masimov
	<m.masimov@mt-integration.ru>
Subject: [PATCH 1/2] ocfs2: Fix possible memory leak in ocfs2_finish_quota_recovery
Date: Wed, 2 Apr 2025 09:56:27 +0300
Message-ID: <20250402065628.706359-2-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402065628.706359-1-m.masimov@mt-integration.ru>
References: <20250402065628.706359-1-m.masimov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch01.mt.ru (81.200.124.61) To
 mmail-p-exch02.mt.ru (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 53 0.3.53 da91f386ac5d59a1df8d7a7d55ad5b472b5df140, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;81.200.124.62:7.1.2;127.0.0.199:7.1.2;ksmg02.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192297 [Apr 02 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/02 03:33:00 #27848807
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

If ocfs2_finish_quota_recovery() exits due to an error before passing all
rc_list elements to ocfs2_recover_local_quota_file() then it can lead to
a memory leak as rc_list may still contain elements that have to be freed.

Release all memory allocated by ocfs2_add_recovery_chunk() using
ocfs2_free_quota_recovery() instead of kfree().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 2205363dce74 ("ocfs2: Implement quota recovery")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 fs/ocfs2/quota_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..e60383d6ecc1 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -678,7 +678,7 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 	}
 out:
 	up_read(&sb->s_umount);
-	kfree(rec);
+	ocfs2_free_quota_recovery(rec);
 	return status;
 }

--
2.39.2


