Return-Path: <linux-kernel+bounces-897104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A3C5203F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB8501C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD93054E1;
	Wed, 12 Nov 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="L1xarU7v"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3542FE06F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946857; cv=none; b=fUgyXoWEuhNvyOa5nafeDFZs6VikLuCaTNnF/hLJqulkbXF6XmOIvF2XwRl5egnWtjpbJ1qTrQNVXJHdbPb0wUlc+Jh/VShmJtwh9Z+eDXfYcU8oHhr+hBQokhwjQf/8Ap+8cD9dk1BTW05qtbGKNf4qq/3TmKbxDKoV2FTtuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946857; c=relaxed/simple;
	bh=IkKSbfptNiW91BM06OUzO8qEvxk/nZ+6XUKwR6Zmh24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxh+VQYdiVw+gWKTo3655Z3RrS0oelJpw3nR63FQSP4gGFAUeamUxUNzRWpJaeAsQfDzqXa32A+/hMWeuhiQrSRLm4dkXwXVa5RTHuckRELxFYdc9yvHwNHVGCz+S78WTV1XOaBgUyQf+aW1lrM2IDgrm/q3G8eKD/4yhHYIV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=L1xarU7v; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762946852;
	bh=YWmos0LZaJQaafwZrux+ArhwVZRFdJfSccimLc6KMBQ=;
	h=From:Subject:Date:Message-ID;
	b=L1xarU7vbj89S9NlTaHiYQIeTENuAZsh3+hzbjcsol9cVws+LgNLdlZaU/aqSfZub
	 icy8FfXurXY/YKC6oFT2NpwAZljxpQZrPmKtJH4j0MlhA5MoCAOXfxngyP+GTNvEbm
	 YiluNcw9T/YRRo2wbgHLVAUIT7JvqjzvhnxgjDNs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.32) with ESMTP
	id 69146F1800003F18; Wed, 12 Nov 2025 19:27:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 777804456607
X-SMAIL-UIID: C5777E0D146946EAABCBC88C9E9EE198-20251112-192723-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] WARNING: ODEBUG bug in handle_softirqs
Date: Wed, 12 Nov 2025 19:27:05 +0800
Message-ID: <20251112112714.9203-1-hdanton@sina.com>
In-Reply-To: <6914128b.050a0220.417c2.0004.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 11 Nov 2025 20:52:27 -0800	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2666975a8905 Add linux-next specific files for 20251111
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13748212580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e82ba9dc816af74c
> dashboard link: https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10646b42580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133eec12580000

#syz test

--- x/net/rose/rose_timer.c
+++ y/net/rose/rose_timer.c
@@ -180,6 +180,7 @@ static void rose_timer_expiry(struct tim
 		break;
 
 	case ROSE_STATE_2:	/* T3 */
+		timer_shutdown_sync(&rose->neighbour->t0timer);
 		rose_neigh_put(rose->neighbour);
 		rose_disconnect(sk, ETIMEDOUT, -1, -1);
 		break;
--

