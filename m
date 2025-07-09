Return-Path: <linux-kernel+bounces-722636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613FAFDD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788763ACA6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D219F137;
	Wed,  9 Jul 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="eeSxVgUN"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1719C560
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026803; cv=none; b=jN/NdNTBAHWsQpKCasnSxSrabj4yMrV+MNfRcwS7A7Gii517xsBEJWqoQWoZX+JNK6NVZ+lKAQB6LaramV/1fnPIotMmISaEFbfhOaL6sy6/zoYC6E4cCLCnjrwMRc4wHMMmtworSOWU5+by5fZ5rKYLcPiCVlV1/h4hWhdMJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026803; c=relaxed/simple;
	bh=kDdYw77r/uIiKD/nXNxhTHE5jcC0PtGTfuJevgoXW3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymvrvk6vtzvCpY0MzL8GDcw+o6ABCHnpWTIz+6nEwo14LdX+XyOCM1//Vp1AFn6NKnpZ4n9lMP2/MPv8dQinmZuKrK3tRwwNg8KE+mENxxn1L2iwKL9Js2nEtwR9Fn4qkXNs+VJUu1IObbhRb5Ho5VOUa1PhbUF3U/XdgtAOjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=eeSxVgUN; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752026793;
	bh=atvrqqBqqrBVMKZGaWS3Nsayq+A6SaHf5BUA9SnAAaU=;
	h=From:Subject:Date:Message-ID;
	b=eeSxVgUNZA26g2RCHjnD5OWEwZ1+Dwtd1ojddSbx34XueIwqhb5N3An5incl76sab
	 Nz+C+i5V4KUnS0tQr7LJbVH5cD/O0B3LDrbJpuWw3qO8iHdrDv6ggkqwGbftoaR0Hz
	 T9B6PanEFnNNpO6Tdj7QVroYljcr8dJR6qib34Yo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 686DCE9D00001E8F; Wed, 9 Jul 2025 10:06:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7759946291945
X-SMAIL-UIID: 5C8745707A56449CA9D2DFA5F152F22A-20250709-100622-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
Date: Wed,  9 Jul 2025 10:06:09 +0800
Message-ID: <20250709020610.3080-1-hdanton@sina.com>
In-Reply-To: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 17:12:26 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e4bf70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8fa6c6703a4b2315
> dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4bf70580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f6ca8c580000

#syz test

--- x/drivers/infiniband/core/ucma.c
+++ y/drivers/infiniband/core/ucma.c
@@ -272,8 +272,24 @@ static struct ucma_event *ucma_create_ue
 	case RDMA_CM_EVENT_MULTICAST_ERROR:
 		uevent->mc = (struct ucma_multicast *)
 			     event->param.ud.private_data;
-		uevent->resp.uid = uevent->mc->uid;
-		uevent->resp.id = uevent->mc->id;
+		do {
+			struct ucma_multicast *mc;
+			int err = 1;
+
+			xa_lock(&multicast_table);
+			list_for_each_entry(mc, &ctx->mc_list, list)
+				if (mc == uevent->mc) {
+					uevent->resp.uid = uevent->mc->uid;
+					uevent->resp.id = uevent->mc->id;
+					err = 0;
+					break;
+				}
+			xa_unlock(&multicast_table);
+			if (err) {
+				kfree(uevent);
+				return NULL;
+			}
+		} while (0);
 		break;
 	default:
 		uevent->resp.uid = ctx->uid;
--

