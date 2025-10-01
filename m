Return-Path: <linux-kernel+bounces-838304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B7BAEE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C5A17858E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CD1F2BAD;
	Wed,  1 Oct 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="zFAhmJky"
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C41E412A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279455; cv=none; b=iXfLUK9ZzoR8h3N3jb7lJUo+E1L3lPJjywxDJrvw6x2zaR4RVx469ybVi6PYZyR9owu6SBBIIvgGCP1UqUbprL6JnWYgABlIZRvX56KqxfUvk7oSB6h1Hwan8ca/+PWAsPYj8HxRcB2VRsuLF5WRx9OIESx6bQmBDzyyoH0qXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279455; c=relaxed/simple;
	bh=2CcTsZyFkSw6j+pe4Pcmfrnq9B0S86UFInumC/Qx7ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK+Smpuulj8xpnQ+8fhtI8TFRdmykdyfGeOOe9koIj8qbKemyM20dsx4edn/Q9CTcEfL7lE15+/ENZCRZYZBiIZ38Kxeckct47SVvKDh9tcMt0jhNCG3/jgWA6xUVqBljzmnKbDOhYY32YWAFLHmWZAIHbrROtcZWa7Ma0zUvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=zFAhmJky; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759279450;
	bh=XRtG5/YVBNp32G2mvK1c45nIv5xM9N/HaJ0KoSB2J1k=;
	h=From:Subject:Date:Message-ID;
	b=zFAhmJkydNh+lN16qJZG/Y/stDn8H4fsN75fk5m7ry7Qbj60gvdoxRog4torBE+ks
	 yUaDoAkUIZv7gHYthm2lqrVC/W9RAt/XcFcJ4kKpPQCoAlI2YEVJiFSS5cMJI78yge
	 mTJ4D8QzvGP+s4dpH+PVpLMLDYMfbaAADuZgrYec=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68DC792E000041D5; Wed, 1 Oct 2025 08:43:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1939296816213
X-SMAIL-UIID: 9B573E150E1540919CF276CFD19B7A0B-20251001-084329-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
Date: Wed,  1 Oct 2025 08:43:11 +0800
Message-ID: <20251001004317.7786-1-hdanton@sina.com>
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 30 Sep 2025 13:17:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    449c2b302c8e Merge tag 'vfs-6.18-rc1.async' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b43858580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c9ad04580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160bf27c580000

#syz test

--- l/fs/namespace.c
+++ n/fs/namespace.c
@@ -4092,8 +4092,12 @@ static void dec_mnt_namespaces(struct uc
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!is_anon_ns(ns))
-		ns_common_free(ns);
+	if (!is_anon_ns(ns)) {
+		struct ns_common *nsc = to_ns_common(ns);
+
+		if (nsc->inum != MNT_NS_ANON_INO)
+			ns_common_free(ns);
+	}
 	dec_mnt_namespaces(ns->ucounts);
 	mnt_ns_tree_remove(ns);
 }
--

