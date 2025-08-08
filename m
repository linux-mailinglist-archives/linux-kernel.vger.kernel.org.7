Return-Path: <linux-kernel+bounces-760333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC31B1E9AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D87B203E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77977274B5A;
	Fri,  8 Aug 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="i8tB3+w2"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAB81732
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661406; cv=none; b=WkjfEMOUtsLlT6f2b/jys92nSrEjE+dmompIuFqbxYF+dB70FOpkXyy/SVDhCDcU97vl8K/S/bAl+SmN+JX8xghcsOXSvTv4lVRqqUXnijhgcZlbIeKt/L29KeOq8ga6IL/jMqDGkDhkrvA7BM9SF5md4wLYESQLXizh2D9KwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661406; c=relaxed/simple;
	bh=VGW3iwhs06TlX3mCL5Fz16GN2dRR+QXkmPM+0ULka0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OASOh5kfcqVa/mhB5CRFJ6MT5ip/mzB1cCcYGHcwkuE25Si0/4hW2DzM3vs1fRF7u/8AGdk3p7xILiw4oNqyq8IiEjYo2amOok1NDh1hXm/gxcTMr85hkNE5SdI0nv3MCOqc9buT/4qbqL7/5Ndq/rb0o0oGb1zLH4lhdpYAlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=i8tB3+w2; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754661396;
	bh=7zg0rcr7ymUsDvF/YkFKUV212hpUZmwQfk5lRWpk9lA=;
	h=From:Subject:Date:Message-ID;
	b=i8tB3+w2S4ikrxGOXi6yCk23jYRbZNXPibCHl0O4p+xXqw/4mdT8izR7vlwtw1yJV
	 nueSPvHkzD+paTcaJHalhb7CjscJ9jD6fSoQTf0Ogc9MrupiJqUXyst1bzNXH8Waa+
	 bLmWt1QPhRbwwdLuuh2S22mrs5TZGGva2+Ws13eQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68960207000013ED; Fri, 8 Aug 2025 21:56:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6798736291755
X-SMAIL-UIID: 1BB8CF37F45442A88123F99ED246849F-20250808-215625-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
Date: Fri,  8 Aug 2025 21:56:11 +0800
Message-ID: <20250808135614.4022-1-hdanton@sina.com>
In-Reply-To: <6895de6e.050a0220.7f033.005d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 08 Aug 2025 04:24:30 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7abc678e3084 Merge tag 'pmdomain-v6.16-rc2' of git://git.k..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b0a4f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12b5044868deb866
> dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a20f22580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af2f22580000

#syz test upstream master

--- x/net/kcm/kcmsock.c
+++ y/net/kcm/kcmsock.c
@@ -1714,7 +1714,7 @@ static int kcm_release(struct socket *so
 	/* Cancel work. After this point there should be no outside references
 	 * to the kcm socket.
 	 */
-	cancel_work_sync(&kcm->tx_work);
+	flush_work(&kcm->tx_work);
 
 	lock_sock(sk);
 	psock = kcm->tx_psock;
--

