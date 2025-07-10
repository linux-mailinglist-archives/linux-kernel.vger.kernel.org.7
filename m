Return-Path: <linux-kernel+bounces-725709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F22B002BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3817485DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB82676C9;
	Thu, 10 Jul 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cb7lY/YZ"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074AF1E8333
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152370; cv=none; b=PMXZE7OZdSu/yq58cFKhqRjvmh27sltgpFhYurqc/NQ5Q4Ai1haXWg3ZP7oN8NNOgWINcbePMze/aCiKZ1MbvA7d4terJhDUqusYUZC35P8k9vhIjjMJdOyeGVurYCpXkbkErPMJF8cDK5Lq7QwhjMdoSJvS+FiwjB4LRcLpX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152370; c=relaxed/simple;
	bh=XsHWzh739R/0Xp5skEzxxJDKVO8SM2jNBB2lP1jGp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHh8YdVp4OZnTBAqLfHwwTnckJuzTEHVSD3x8obYh0GZKdF2ctfTcmH5h1E/M3538kQ/xdRgkjj2DEDc16lLNduMHf+jQleBJFwlPirV5O8mrLE704InL4Ks8Vib6ly/V+miNxinkL/oIxElvpmffM9iOXYGOklLuAhUSNShRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cb7lY/YZ; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752152364;
	bh=Ab4CDBXxluUdrB2nvGUuJhj2mAWlYx9keOVplqD+MtY=;
	h=From:Subject:Date:Message-ID;
	b=cb7lY/YZmZtptRJLnNZdBEEOtSv1Zi9hDcerCuOoZZfw56pyWaTjEWJiOvlKHbyUd
	 +JdkOdzOO/ZiYVNrzIHEOwSm+ZkO3pFZTEAlkbJpFbewksT6or1BJh9oLLustq/XTE
	 ELZzOKKZvxx8NlOcmjzeT9cjpnVN7RTg2Jg4Exco=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686FB92000006B99; Thu, 10 Jul 2025 20:59:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9454786685134
X-SMAIL-UIID: DAD66BA7CB87410D9FCF97470C1E4A3E-20250710-205914-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
Date: Thu, 10 Jul 2025 20:59:01 +0800
Message-ID: <20250710125902.3195-1-hdanton@sina.com>
In-Reply-To: <6730056d.050a0220.320e73.031c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 09 Nov 2024 16:59:25 -0800	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    226ff2e681d0 usb: typec: ucsi: Convert connector specific ..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=132b5e30580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
> dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144614e8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172b5e30580000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/media/rc/imon.c
+++ y/drivers/media/rc/imon.c
@@ -646,15 +646,15 @@ static int send_packet(struct imon_conte
 		pr_err_ratelimited("error submitting urb(%d)\n", retval);
 	} else {
 		/* Wait for transmission to complete (or abort) */
-		retval = wait_for_completion_interruptible(
-				&ictx->tx.finished);
-		if (retval) {
+		long rc = wait_for_completion_interruptible_timeout(&ictx->tx.finished, 60*HZ);
+		if (rc <= 0) {
 			usb_kill_urb(ictx->tx_urb);
 			pr_err_ratelimited("task interrupted\n");
-		}
+			retval = rc ? -EINTR : -ETIMEDOUT;
+		} else
+			retval = ictx->tx.status;
 
 		ictx->tx.busy = false;
-		retval = ictx->tx.status;
 		if (retval)
 			pr_err_ratelimited("packet tx failed (%d)\n", retval);
 	}
@@ -1765,6 +1765,7 @@ static void usb_rx_callback_intf0(struct
 		break;
 
 	default:
+		return;
 		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
@@ -1806,6 +1807,7 @@ static void usb_rx_callback_intf1(struct
 		break;
 
 	default:
+		return;
 		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
--

