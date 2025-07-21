Return-Path: <linux-kernel+bounces-738833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC43B0BDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907E316E8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EE283145;
	Mon, 21 Jul 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="No/uCqOq"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA9190072
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083561; cv=none; b=XpPSxpYZ9JGHfaFUnMx+LNbb5rT4K0lwaR7jvCNggaJgq2wBDhTc+9bJP+SaDNN+SgGEb0sJZBCxjtWhpiu6MLalGMsflFQfo/glqPCUoDEu7BCM4jELc74mrq5fX8+4z6D1dqqImbYzGdPGK32i0vhh3H13+TpNBzvTnTNEkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083561; c=relaxed/simple;
	bh=HyeZ0t+fUqp6DmpAcnD/0zYxHWS0N7PStqbBaC7Ddu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOpj9iBZJwa9DrV4yLMu0w5spLSoCUvmwEHYiRbmBXRMrk+fnwmpNsh2GV39eTx3JW8GybfAobdE3msfNSM71wOYEtj8kKLdLs1mt6U1rzOi+Q16LQAeBC2rg34oVXIC8htEVyNKn8iaTHPJ5KKQuyGMQC6YQ3kw2L9vFR47vRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=No/uCqOq; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753083551;
	bh=U6gS8wW1N1rmmAIeiXQDq86Bkvz0ze841MMdJQPGudQ=;
	h=From:Subject:Date:Message-ID;
	b=No/uCqOqkAGN9kzNas5QauyXWVX1pes2pLk3n4y+SqCW56zE90wmYvhIahdqcm7sQ
	 70RIaYzzib+peE5aaockNMfeSxEwzo1lIi4KIHDCfZWyZ++oAUqIx3V8Dt4/OSmNmP
	 MR/JJVfBdYiph3G/HcTwNyFFoD4NygMBwRZX4ixE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 687DEE710000095A; Mon, 21 Jul 2025 15:38:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3940056685215
X-SMAIL-UIID: AC622C729A984C6B8A683DC717B364D0-20250721-153827-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5583f599fe40b819b3e7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in devtmpfsd (3)
Date: Mon, 21 Jul 2025 15:38:14 +0800
Message-ID: <20250721073815.2673-1-hdanton@sina.com>
In-Reply-To: <687cfb6d.a70a0220.693ce.00c6.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 20 Jul 2025 07:21:33 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d3658c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=5583f599fe40b819b3e7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096f58c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1686a382580000

#syz test upstream  master

--- x/kernel/time/hrtimer.c
+++ y/kernel/time/hrtimer.c
@@ -1942,7 +1942,7 @@ retry:
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+	WARN(1, "hrtimer: interrupt took %llu ns on cpu%u\n", ktime_to_ns(delta), cpu_base->cpu);
 }
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 
--

