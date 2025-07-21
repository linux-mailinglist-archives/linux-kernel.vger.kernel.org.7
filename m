Return-Path: <linux-kernel+bounces-738595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B78B0BAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6749F3AFBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5601A3160;
	Mon, 21 Jul 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dpHAaSxd"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371252E36EE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065090; cv=none; b=b00lQ+dJC5yAXaG9FwCplhRLuAA/zNyNHPvvP/5wRNZi4GqjoeWgxVFbJgnCc9bE6/uLjLVFgs8WhRibmrdIY+E8QV8Vlc8DpJL35sf2CqY+MKKCgcj3Xs7ijsfzdP6ltzdc2s3/uaYDewTvBeNEWPcg8EAx8V2edvhiYqMFNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065090; c=relaxed/simple;
	bh=PbxKyzCvh9XkIkVj/R9SeI+BPkdXODPEV4EK21pRl6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1B4iNUCriQ7b9JOSiJwwKJtOiSrqis1E4lIEfuogyCMJ9IJFW/IC/Zfly58Ejwdq51H3Tw6iR/VaIU0oaijztE0vUR6CkPRuyfVXwvpZzzRSb4sW80O3iqmYQ/pBg0Kmepn6Hj1jxMqC2q7Ya5dTyxG0D6p58TjaHaF34EY6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dpHAaSxd; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753065084;
	bh=iFHBpB575Sc/tp2bC2Omi8vSgQO4G074rzM3pc9IjkQ=;
	h=From:Subject:Date:Message-ID;
	b=dpHAaSxdqmXc8941P34ZXpJKBJ4MEQzTS0oQeB1KPM5ci3LxKJrEm4ymaxbvxAtNT
	 8/oUclMXJpOlYN8V0wS+AmYWCYI278fhuaHgNSCCpIH9TH5VXHx4GHiFhKYMTnXmzR
	 nv4KUv5JZf54rlQeLiceWiR4a5bLcC832rjKfQRU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 687DA67100001B37; Mon, 21 Jul 2025 10:31:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9668266685502
X-SMAIL-UIID: 26BB6F31953C4818B9028EE5A89C95EB-20250721-103114-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5583f599fe40b819b3e7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in devtmpfsd (3)
Date: Mon, 21 Jul 2025 10:31:02 +0800
Message-ID: <20250721023103.2628-1-hdanton@sina.com>
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

