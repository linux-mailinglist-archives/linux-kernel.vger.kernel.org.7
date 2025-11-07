Return-Path: <linux-kernel+bounces-890001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CCC3F0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE7594E74C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CE2FF64A;
	Fri,  7 Nov 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eVG8t/d0"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCA2FE57B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505686; cv=none; b=BVGlO/pb8NOphxm9e+n+AzDnb5kKsr7HZFkbfMkSHkT5YII4kR2ImZAfsYETwaqUPm8/ERhPdSGz3hLKQAPj8IbDVGGhOAYx9RDiA0MmLUYpA1e6YYtepmAEsnwJteLM4I7YTh7A3emTuKAscZehSiqntJgtIw2311S4OIrLzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505686; c=relaxed/simple;
	bh=FgB7xQrrip0UmPtbkZTEGBDT+lI6ArYz4H5RqY06tow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVF+W6VpcMRc1Wvcj9ZBbzhhBnFScfUDVJp1xs3k1au7CdEJ+Z6dahaJlTnu/TOYIknWdSLWA1WGTXcUO4T1LEYFgCaTXHTAkG0TUfssyupyxmTkTYP1fmmztMXOQfC8EiqKppamFOQ6nA9+eYkrWNrbknjTt1h5+oxbNeBs25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eVG8t/d0; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762505679;
	bh=DLx9MQIirPEPLM8OfADF/je8IuPf2VO0TJMFJ6QaqJQ=;
	h=From:Subject:Date:Message-ID;
	b=eVG8t/d0mB7H+asqXfClOS+dCN7YHb3AwLjdup2LqiNAtC55vWVr69OPN4duVmLL9
	 9j/ZeSiueo1uUZzytFvUIP9lOxv3ObR3t43tI58ktXKdu4Y9ZLBZrSP/C7nnBklWAp
	 SJWSbioolvDjdBX9Q5fxc4uLyA8urd4WlAEHgEas=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.34) with ESMTP
	id 690DB3C9000076D4; Fri, 7 Nov 2025 16:54:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1583146292076
X-SMAIL-UIID: 0D28CBA4A6D84489B711A2E74DB45FAA-20251107-165435-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
Date: Fri,  7 Nov 2025 16:54:21 +0800
Message-ID: <20251107085422.8964-1-hdanton@sina.com>
In-Reply-To: <690da04f.a70a0220.22f260.0027.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 06 Nov 2025 23:31:27 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    982312090977 Add linux-next specific files for 20251103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b2932f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
> dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1347817c580000

#syz test

--- x/kernel/nscommon.c
+++ y/kernel/nscommon.c
@@ -117,9 +117,7 @@ struct ns_common *__must_check ns_owner(
 
 void __ns_ref_active_get_owner(struct ns_common *ns)
 {
-	ns = ns_owner(ns);
-	if (ns)
-		WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
+	__ns_ref_active_resurrect(ns);
 }
 
 /*
--

