Return-Path: <linux-kernel+bounces-764002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765FB21CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE3B4624C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510B278E42;
	Tue, 12 Aug 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0VJ9jWkB"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F02DA753
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975334; cv=none; b=AKex4hx7Rw2wHo1fd5P/JAD2U/lhTmGIIo2fdcX7fqqD1cGjd3ZCdKqD5BoJ3aYlMbu4DtcO3p/Vp+O03uCTVsBA4xO1BrmlxxCYnnwBr/Rz8Tm9N62mmCV1wLGFicKRVLYXGbFIYiN7zGYNOoXc/sZbEEmM4v+SFQ1SzJj20kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975334; c=relaxed/simple;
	bh=9wACFQiWipmWL5hA/kmTFydarLJvopTIwZfPF0+NXzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKWK6u/8B7ZsoeG6DVvjNfeTQ3I4Lwv4CJJQynYdDqr2da8w3k5O6TS3OfU43MwgYwk1EpGc8dv8Jx80TJUKauh90XzDGx4hXsiMVjsaGI3/pkYDuH6COdJUrwgCAoPfQzxL20wdMxVbQ8CxhkZYUAoqOgx+LDLLRcWajJ82MkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0VJ9jWkB; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754975330;
	bh=FDAPsDrgUHseysR1e6DL2m0o9uwTF51+dWthgHYpK60=;
	h=From:Subject:Date:Message-ID;
	b=0VJ9jWkB4m0gOTdoRfTI8TXQmudAnzJ2+tGhj+GP+zk4z6hK7tKMBu7PYAWgoci6G
	 ft3DLPBi4e51q1H4ur1Fd82Qi8A3gk1vqUb4T55uAkAc30nR8KyxvPJSAEapd3NaFo
	 qOZg63y5xbEhhnHr8EOoRULk8oBi8SFlZd+42kqM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 689ACC5600000837; Tue, 12 Aug 2025 13:08:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7798456816299
X-SMAIL-UIID: 3C8ED88EF69A4466A8D3EE3D84CE195F-20250812-130840-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
Date: Tue, 12 Aug 2025 13:08:28 +0800
Message-ID: <20250812050829.4213-1-hdanton@sina.com>
In-Reply-To: <689a3d93.050a0220.7f033.0100.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 11 Aug 2025 11:59:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c30a13538d9f Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17840842580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
> dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1766fea2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e709a2580000

#syz test

--- x/net/wireless/scan.c
+++ y/net/wireless/scan.c
@@ -1904,19 +1904,6 @@ cfg80211_update_known_bss(struct cfg8021
 
 		if (known->pub.hidden_beacon_bss &&
 		    !list_empty(&known->hidden_list)) {
-			const struct cfg80211_bss_ies *f;
-
-			/* The known BSS struct is one of the probe
-			 * response members of a group, but we're
-			 * receiving a beacon (beacon_ies in the new
-			 * bss is used). This can only mean that the
-			 * AP changed its beacon from not having an
-			 * SSID to showing it, which is confusing so
-			 * drop this information.
-			 */
-
-			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
--

