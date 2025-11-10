Return-Path: <linux-kernel+bounces-893126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2935DC46937
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16B284EA9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A103090FB;
	Mon, 10 Nov 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UxiUbwSm"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B42727FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777478; cv=none; b=GUf2SxOoMgJp5j4awbjNzVOXQipXIup4gUzdzdl1xVIh1awy3+H+ku8xnckqnsbfzF065KJds34rD/gw5L4XRPW7UzJay7o01jq94hfdYMilBRl8NYNa6BBS06CwdzCGgu+/Y4QsTX/nqz4AQW+TK3alFmuVWGYGuu+SQ0mXv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777478; c=relaxed/simple;
	bh=oGFQZPdjMWEEkYjcJMFGZQ12pTd1LDpD/uKIjtmrTxM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lRHkV2E/29zgYs3RABH2D4WsX43FYtu9b+8DBcQ2Cs8/V9QugeHfy00QW+Jpd2oGIgn0goqJrwT7tZe3ZaFFTS3H2dGO3lO4n0y35YFPJS2Yiq0Sx+POIc9M6pfMxAe4EbQOMDClQ6hsped0Y7D/OH24/3wrc1HJfQ7xQ26kYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UxiUbwSm; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762777165; bh=fJ8cv+qgHC0I+pj+mwJgNpvZ9ifVcUeX2LiLdP1IvwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UxiUbwSmWXf9WvChWtV5onlIBVjpipPRQ3pCPTOXdvQGD6iYdJq6p09zJLP2pe6SB
	 RRn4a/Il+tJ5a8ARpVUesLKE7ME/qgmdTqxwzwrQMeIHQj4NkCyj9qHFv6CARZM2Jb
	 bfOF3KYHQTUNJXwguFWj58fCFhIzW+Kvw52xdMGs=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 34FAE0EE; Mon, 10 Nov 2025 20:13:15 +0800
X-QQ-mid: xmsmtpt1762776795tmqiw9ev9
Message-ID: <tencent_3C191ECFCB8DE725968D8112075DCF5D9507@qq.com>
X-QQ-XMAILINFO: NWEwCzsFJJ7KyhOOseDAEiHQi/vLBgTbCPJ4zVFQLeWgEIbe4RheNK/VoovxHR
	 H4An36uIp97i9tTBORw71/E4c0+kRvVOH7/aJtjIqawTLhVC/dwrAApgaYLfay3gFfvPFQSVYLyl
	 3jeMBbnEWJ1Wrw1Kb2lwLFbVctRu+Ze8iXwdoLnmm9sWhUaE/2gu0uRoa3v+zDN9AEtfopttoal2
	 kHfTaP8blLssMc65JssilxFH2dx816Fa2eghXxfGpI15VK72t3Sepy742D+s3vuMHFIV9aV+7mhy
	 aaFKHpONMMtL1dCAQn+FrTRlJTDlO/DbvfPQDgj4v0kzGIBcGs0P8tamCUCYXApvaMaQdL6HNo54
	 +D1Bac+TLJJU5Aj46Fa9GZMO9HVMOvSQLblJc7RSGv48Vqr5ZehdKtt7g5YzaKrQc7B/rCDvi/r/
	 xkV508NwyYDNGNZdGKjpDNR4BDigHkeTlQ2YYgOYkJKRl6LYXAM6r8/owYYHgAKCkBuHxmNUzArT
	 cvs5NkDn2ZjqJjFlAz3RV8XI4D7RewHOl0p/HHhSvX0ifKL0N7uj01OL4gS01FWOIyqxdgR4Etg3
	 vPbFAZVkR4kZdM8TXUzyevQoEwM8IGpp/Cpppq107wKPyucpEz/AdXdgk2nzRYh/dqpgZe7x1aq2
	 uNnYPohIu5vS4kD5nSBQVCckUYYfbA816eDWEp7jILwocqJIGz3Jb+tr/tp0n8QsNSEWIPPvRfT3
	 DRkUK8RKeArGQox9wi2FlwvXMDoqbDmpKOqkL+LDB+ZpjKmmnXl51T12fV1VzcItqBI4pLkDLtWZ
	 wfLakC1pi7HAr1M+AuQFwNuY6z/kFdj7+lxZCfC3Po/zX1pQDqdmceSz6DCQ4XrzhhVpdjIzRL5h
	 SahzMhhNNEj1YnsDULgA0HSGgk9HfHnPiYmJE3r0/uPFdZXnwtJ4z3bYCfK9tussxSn6ozG13Ptn
	 Iv75vFhw1p51rQ9swIoHc8Ux2zItP5
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
Date: Mon, 10 Nov 2025 20:13:16 +0800
X-OQ-MSGID: <20251110121315.1430620-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <690ec096.a70a0220.22f260.0070.GAE@google.com>
References: <690ec096.a70a0220.22f260.0070.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..ee6e9ed5e3af 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1860,6 +1860,7 @@ static void lbmLogShutdown(struct jfs_log * log)
 	lbuf = log->lbuf_free;
 	while (lbuf) {
 		struct lbuf *next = lbuf->l_freelist;
+		lbmIOWait(lbuf, 0);
 		__free_page(lbuf->l_page);
 		kfree(lbuf);
 		lbuf = next;


