Return-Path: <linux-kernel+bounces-725512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224BB00012
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AAA1C82A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2423323DEAD;
	Thu, 10 Jul 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="DF/YWxUc"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922513A3F7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145537; cv=none; b=oD4ue7N7JaatEodhONV2adErJrELDbx0UApoOHoDJ3uadXKDoSKFfrN2Bk4n5hNsSwVcIUup/B8DMxJekqNMSTZpfVLKwfYiTKjgLgHFsQQ/TmzLAkuXwusMdsuBLBu9C7No5+wfWiNGP2TeYg8NU6xr3aB1Tl+nVIx4h/hp4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145537; c=relaxed/simple;
	bh=Dn6jGQZ+6fmRepwPmxCUaGzr2gPQ8oVqlmG8UliK/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFjvfteBwHe5frTL0eE7z2rCcijGvqX9XoA2YqYTEsCufiE4ZI1y8xU/b2imlbyLfkQThW2UrC3N+GENEjpdurqlyC/3Qx+/WqKVHVO/v6ptCQtiJDpKGEq35QneqUVKkWNs1O1fAlaePcyM72TlU/VsZtnK3+J6mw/iICERC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=DF/YWxUc; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752145531;
	bh=70cduV/gqhsIGEEMAWhR2gNKKTxWk8gksdMoFf3bews=;
	h=From:Subject:Date:Message-ID;
	b=DF/YWxUc7xvq/q1/C13L8QvsVm5iFL8EAz3a2835VRA3Kl41yWCn14M9o3b/U2Dn1
	 cwLHOBrR7Xg1KEBkDuw3HDcwrlmRHn9l2eQOBZs+tqkCxxD9BVgo8hTeBeirPeX3a4
	 lTmb1wzfyPBFRJHEgh/4WBMz3O7UcHTS/zDKOdWM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686F9E700000595A; Thu, 10 Jul 2025 19:05:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4812446685140
X-SMAIL-UIID: 447099943A7C4B1BA75B2BABA772A6E8-20250710-190522-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
Date: Thu, 10 Jul 2025 19:05:07 +0800
Message-ID: <20250710110510.3162-1-hdanton@sina.com>
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

