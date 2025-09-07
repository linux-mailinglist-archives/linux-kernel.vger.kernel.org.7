Return-Path: <linux-kernel+bounces-804558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37260B47992
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14C4A4E05EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9320CCE4;
	Sun,  7 Sep 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ykGAA5n3"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403A4A06
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233209; cv=none; b=LVh/Op0g1A04aZo3HY6Tf0IuI0mlPbs3BJUHBAPAk95isWS18WxaEsag/WNT9RzKUwwGDdN3+d6h2PFUDtFfb2RzNwJJBiu1PuYTCnOcr58m2fVuKSMo/dVcMohNqQjwgHLOu4Y1iGcySPVw6uWLf6/TFibHRcUEqT7fG+vCO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233209; c=relaxed/simple;
	bh=V96olQLv/535ofNWAFuxNVmILjmmH4lrIWSeji5gY4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZGmEYEedFgp1wBcFwnFT2kA1OQl4vW8Shr1fYRdSmO5C8s12l9Ezhy+XQsLHMBiJxXTbcNnbXKf+QUGBAE9BwbCZ6ZZ0k/MqcjkfRabkDW466WmxcFLH23AawZekk2+dB/fRFZ+Qdk8K09zpxfUBh8rCMgAqem3NeBe6uGVpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ykGAA5n3; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757233199;
	bh=n8vKqjFQuknmoEO1oFEDcCTzvjF6WGIiOaE+9yTEBtE=;
	h=From:Subject:Date:Message-ID;
	b=ykGAA5n3oY99Zmtfqx8EAJ1cn31daZEZv3s6gEs0NkoQRy8tgPRQ1d94y3rp2RQpc
	 cWzOwxJlzPf0haO6OBCyJFwFuddEp1fXh00fx+WGmj479uFagr0PsCafGPtChYHI/e
	 5W1xJIkMqe4YVu8el43RtflBezC0Erx5XzlSnHpU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68BD402300007646; Sun, 7 Sep 2025 16:19:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5451956292061
X-SMAIL-UIID: 179DE4EA08734E75B9EC59BE00C9F239-20250907-161949-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_iov_iter_get_pages
Date: Sun,  7 Sep 2025 16:19:36 +0800
Message-ID: <20250907081937.6583-1-hdanton@sina.com>
In-Reply-To: <68bd3027.050a0220.192772.01cc.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 07 Sep 2025 00:11:35 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    be5d4872e528 Add linux-next specific files for 20250905
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17896962580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a726684450a7d788
> dashboard link: https://syzkaller.appspot.com/bug?extid=b253ade8e1751d90a7a9
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10496962580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a98962580000

#syz test

--- x/mm/gup.c
+++ y/mm/gup.c
@@ -2981,6 +2981,7 @@ static int gup_fast_pmd_leaf(pmd_t orig,
 		return 0;
 	}
 
+	pages += *nr;
 	*nr += refs;
 	for (; refs; refs--)
 		*(pages++) = page++;
@@ -3024,6 +3025,7 @@ static int gup_fast_pud_leaf(pud_t orig,
 		return 0;
 	}
 
+	pages += *nr;
 	*nr += refs;
 	for (; refs; refs--)
 		*(pages++) = page++;
--

