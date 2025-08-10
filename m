Return-Path: <linux-kernel+bounces-761293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F9EB1F7F5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 03:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC03C189AFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC81459FA;
	Sun, 10 Aug 2025 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="qFL1qI64"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56128DB3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754789784; cv=none; b=oaYMLE9+KLTQruznsfG1NWkZX3UI66oQnMQB9tDFlrMH1VS1OTVD65IuR9GOC8Yssr3VY/WmplM/NWsrY1M2fbX1Z9nMyt4Mao1ugPL9ZANX9c5Vrb1VChJ9EiIPy4DqkhZoCJ9XJqBYS/xsmho7K/BmoeTz5nJVeNd9F+K0j+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754789784; c=relaxed/simple;
	bh=Knjpq0a+UMDsXXR/up1CLZNHEPBq0LgtOklP/Cy0XQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/LCMV42Ae+QQgwB+BYrWA1sokC4aLUY5E1zBmmpOzh6KjLLGxq3SrhM5Fm0TPS46D+TN/T4/ZxYwelws+8ttXoMFRPb4S6YjOSMRk07L2HQFgJHrbj29wz1EHQoSb93uzeu/tA4t/+lNsAg6Bg/FNFG34bEDh3LhoyVHs495Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=qFL1qI64; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754789779;
	bh=kbOGWtlKRbiYSgddT0QqVfyof5p+SHev96QEjhh+3k8=;
	h=From:Subject:Date:Message-ID;
	b=qFL1qI64eQ6wavTu1j6rtQ0aW0k5s3tVlR4b8ftCEYOIYfo1jNHyrzwcpY7c0EII6
	 CPBu/VKEi9LtXwibzDSS5EXCXCNyxd+dV6WYPjHQy+TvwmIEOs1uT6Y2zgNbW0vYqb
	 CB/sfd6MJixEjo4mMGAKvwYkHKi/NSR/40I5AdTY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6897F78700003B26; Sun, 10 Aug 2025 09:36:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 081934457075
X-SMAIL-UIID: 91BB145C0EB04AD891A39FAD80409E59-20250810-093609-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
Date: Sun, 10 Aug 2025 09:35:56 +0800
Message-ID: <20250810013557.4116-1-hdanton@sina.com>
In-Reply-To: <6897b156.050a0220.51d73.0082.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 09 Aug 2025 13:36:38 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1422d434580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
> dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

#syz test

--- x/mm/rmap.c
+++ y/mm/rmap.c
@@ -2366,6 +2366,7 @@ static bool try_to_migrate_one(struct fo
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
+				 pfn == folio_pfn(folio) &&
 				 PageAnonExclusive(subpage);
 
 		if (folio_test_hugetlb(folio)) {
--

