Return-Path: <linux-kernel+bounces-792631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBCB3C6E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817437C50E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C321772A;
	Sat, 30 Aug 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="q2y8t61/"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE779CD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515627; cv=none; b=D7le36mrz3ZSjtf2JLDlsIiQAnzBg3BAgpJOQfjwV4SmUsJvjhJmu58v6UcfPNqnqB3hDuSeqKOlZWRm08w558gPRD40mMKzMGJehFN7iYya709pdycloTAagy3ibFh7hjuGCghuYlMhEbAjZqXpu2yTsXUtSJ0f1YgjMb4A/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515627; c=relaxed/simple;
	bh=FCCUW6Tp1vpxSSxhq25s58vyqtb18y8OiG2eGRPV0dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTjn2YZqjFTXUkfMuC1a0lk6/swDfLODUL0/0ErZdDtaLWCT4UZ2GcdZh8z5Jf2KFNFR0DGTLrpiWooZwBUSshENLs5EOKXpxObe101M8Dceyh3S/oNAQHso15hhQxzQiR6fpUSevg8f+JOK4jo9n6bvUHby8OJOnCK6VxzZ8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=q2y8t61/; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756515622;
	bh=wLhZjOLKWoS7OMBm2ACxQn1eRHsFKZD8VEXouXR/S38=;
	h=From:Subject:Date:Message-ID;
	b=q2y8t61/BNoE9ung2E1rQrTwuuFeX6mpq27FALKmzFKVcHkQ7NLq7ImeZIy7V3Mc1
	 0LTEfNO3SxP7YT6LUu/D2cGD8CsZg6Q9jQlH05K1jgSeIFQr7AxVD8XfY+0SsyplRy
	 VwUG+tM8QjmAAQuXN8sN6anmxk2g8w5gM9bmFUJs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B24CF8000040EE; Sat, 30 Aug 2025 08:59:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9298016685263
X-SMAIL-UIID: 4C644413EA294755AFF258DA2B6EC949-20250830-085937-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in est_timer
Date: Sat, 30 Aug 2025 08:59:25 +0800
Message-ID: <20250830005927.6096-1-hdanton@sina.com>
In-Reply-To: <68b1a996.a70a0220.f8cc2.00ee.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 29 Aug 2025 06:22:30 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d67262580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=72db9ee39db57c3fecc5
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141c262580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f69262580000

#syz test

--- x/net/core/gen_estimator.c
+++ y/net/core/gen_estimator.c
@@ -90,10 +90,12 @@ static void est_timer(struct timer_list
 	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
+	preempt_disable();
 	write_seqcount_begin(&est->seq);
 	est->avbps += brate;
 	est->avpps += rate;
 	write_seqcount_end(&est->seq);
+	preempt_enable();
 
 	est->last_bytes = b_bytes;
 	est->last_packets = b_packets;
--

