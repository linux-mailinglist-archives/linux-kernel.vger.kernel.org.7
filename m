Return-Path: <linux-kernel+bounces-778906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73AB2EC92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729AA0104C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AA275B17;
	Thu, 21 Aug 2025 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bUsKTurX"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC74242D78
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749056; cv=none; b=E9v7rv49plzCCjw2nkfqukEeKqma7XVktscgfqYK43cA2LsO6x4SB2XYyuhfT2sDHcXMW0gCCHOIlpnF+9uJnZ/rikJtBEZ+xDOE1fk4Lpsl2dfS1ggg5CbNdcGT1n15T1p60MxwHpQ6djYwbBufNvWFoXT599C0nj9p4NXPVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749056; c=relaxed/simple;
	bh=zBQRPfsVS5B3BNl2UHRe10vG+whiglbv4Ci7X7F+878=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghciXY2dWbU2yiBS1wsx5XFLKKLI1vShQ9Zgqehhq6WaPEQz48IPCb4TnYHnv6cqEIZZKrC0/971DnCN8dR9/3YgWALZlgnaFYQbJ2m//OBptB6BnL3fDyU/qR++HWtRXUK5HnL9KAlRd4z8afhPUs6oMYi/LRJc5fAjvrYVuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bUsKTurX; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755749050;
	bh=4CGIDFXTccjUGO8hGRMDT2IYWwaKky6JequXto2IdCA=;
	h=From:Subject:Date:Message-ID;
	b=bUsKTurX4pWsT96cK3tm/vP3uuc6VqUbZBi3nyM7d4KSUbXoG9N2/DrvytVddK11i
	 oPSNOBclWssvBd5FCZyYmYCiaqwSV8KZiVVoL1cYl8mZHr5NdWO48bVtNqJ18dzoab
	 mTCGS6B2HxDGxNRB04OMH0AsvD4XQwpugDUZCwKo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A69AB00000141E; Thu, 21 Aug 2025 12:04:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1001474456813
X-SMAIL-UIID: 6A2E0F9D7D6644B0A3967CE276EC1BC9-20250821-120402-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [atm?] general protection fault in atmtcp_c_send
Date: Thu, 21 Aug 2025 12:03:49 +0800
Message-ID: <20250821040350.5170-1-hdanton@sina.com>
In-Reply-To: <68a6767c.050a0220.3d78fd.0011.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 20 Aug 2025 18:29:32 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bab3ce404553 Merge branch '100GbE' of git://git.kernel.org..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=164893a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
> dashboard link: https://syzkaller.appspot.com/bug?extid=1741b56d54536f4ec349
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1769faf0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100eaba2580000

#syz test

--- x/drivers/atm/atmtcp.c
+++ y/drivers/atm/atmtcp.c
@@ -294,6 +294,8 @@ static int atmtcp_c_send(struct atm_vcc
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
+		if (skb->len < sizeof(struct atmtcp_control))
+			goto done;
 		result = atmtcp_recv_control(
 		    (struct atmtcp_control *) skb->data);
 		goto done;
--

