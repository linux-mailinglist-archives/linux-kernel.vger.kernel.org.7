Return-Path: <linux-kernel+bounces-778359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A8B2E49C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574F8A257E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182B274661;
	Wed, 20 Aug 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhBuQ2jM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA42475E3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713053; cv=none; b=XAATB7cNW/3WbMfcKh26L4xB5DR18BzDBXkTArXf/VwK8uZC7KdQTGY6QaNTyuxFH/61LA02j/ad2HOq/CsEfzkXJx9HIlNGrBN+BiVSi0KrLdt4bTh6K0UpoEuz4VBIE7fpW0131/gGITlzyFIoiGIKC1UhNwcbEFyB7jw2fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713053; c=relaxed/simple;
	bh=mlAmTZB4J4eFaTmxwa9T60gRLD2R2gtwas8Lu1fiFbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG9WgJHl8eCeiImYPEKGJ3aNEcRCj0F65CiXeA9l3HG9+Y9OzM6VxEA0wB72Vt8bMMedYUfshcYrSiCUGqWBuv6N1/jyrdqHzX+HxGTSltQowQwARfoQyEMMHfCD5JUSFqjHef+yGXJcRBU+YBzHruQBXgWeaYKk/wIWYl/533g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhBuQ2jM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755713050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeLiiBFCMgKQsLacMLVBhE65F6ijEZfsV3QkmwGfTs0=;
	b=RhBuQ2jMi7WXZWc4sddX5WfIJPZOIE4nbfZ5pYq+CDQdcWvc5BrUixuPYcENa7J70hLDgh
	UTh6uMmpHSPxcY6q2hO1n6QdaXFf7kWTnJcJNadDdvQj+Omb5ZCZ4vhOO4z6/JKJFRYPGH
	OsqLJiMJNq84S/6p9ivqjq4VPYFYUgo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-2aywcqUrOwOsyxk8F8ZeyA-1; Wed, 20 Aug 2025 14:04:09 -0400
X-MC-Unique: 2aywcqUrOwOsyxk8F8ZeyA-1
X-Mimecast-MFC-AGG-ID: 2aywcqUrOwOsyxk8F8ZeyA_1755713048
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-245fc7df071so764105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713048; x=1756317848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeLiiBFCMgKQsLacMLVBhE65F6ijEZfsV3QkmwGfTs0=;
        b=SF3dT7HaSMlbLWOV9PQp8dFVSTtsVsJFXBel4+eFsvUXzysCrcIP4D9DWQWpj7xU54
         /uCg1O7btEGR3BgogBbmTD31Xay1mS6wQkhBWC9ZtY6HVqwELv+0zieBglCwLIzgBCYG
         bzPCOm1e/5Z+iVGNvYWbiHJ1L/ozxtF/WfwJ7Xmfeo0lLBXrdy+BjTc26EWs2A7toJVP
         oD0On9KfgXnSmFe6U1pm5GFa97mlVxMdL4sa6J4Fhc/7R7P3/tbiTFVWYlkQjBVK7N3G
         vm8K1v74XqUBEwm1kXo+FKNrep3PFrAgvdipr1ZpyHFkuyknRrtCrAGKi02P+9eBVGYX
         fy3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBNdgj7x6adAqKL2J1H+SQZjEDWbMYdw5lws0L1zKSuYOj1giSipElGPYnrMoZiEPy//K2NBFu9sX/Io8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxu0cYRwTDNrqoYuOEI7WXn7fc54sTyYE5NYvHxww4BY49jSA
	nb1WLeqY3WZA1881NvHlQuX/FU9+tfPy+ZK9cbFkoUIKtYwxqzFLwpTNhlw8NRvpKb3ubpUmp5e
	Gm3Qqls5UtKNK19DJJCNiwC4hHKcvH9VT8LiNF0HKJRGSpDnghRLRX7ews2uYRQZw7w==
X-Gm-Gg: ASbGnct62oOmR0HR+H67ZivcqAA3TpiEgXlNibBCJSho5KU9rQuy0pkfPosPX/hDbD+
	2G3QUbTtYOEDTTEYvvYSTACMi5skUGwAjXP/oV28pWtd0aPf9iDSFzT0cS2E4vA6kP4ndKToQQt
	2ICOTeF5JTcBIub9ZWWw4PZDGweZyHTZonUTS/7Wtp5buwiKezrLAUygnpT0tsvg8h7XOLm9gtR
	U0hCo57NM1Z+2osDZyRSmPd79mUFpbLKIfj4fam2wzHLugYt1Udl8Inha/KzO27TPMR3Qdk5tqM
	ay40+jQr4ts+DeXGaYYB9k5ln4ufHvUUgKke2fI3
X-Received: by 2002:a17:902:cec3:b0:240:70d4:85d9 with SMTP id d9443c01a7336-245eee3fd84mr42238015ad.0.1755713047784;
        Wed, 20 Aug 2025 11:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeww1NAvh4/NyhufoiKDyWk9lGBXliPK3456q7VVImqohgGb8IuZFpaqWk/h+JjPKAhXNAIw==
X-Received: by 2002:a17:902:cec3:b0:240:70d4:85d9 with SMTP id d9443c01a7336-245eee3fd84mr42237675ad.0.1755713047393;
        Wed, 20 Aug 2025 11:04:07 -0700 (PDT)
Received: from kernel-devel ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed379dcfsm32729565ad.68.2025.08.20.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:04:06 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: george.mccollister@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Subject: [PATCH net] hsr: add length check before setting network header
Date: Thu, 21 Aug 2025 03:03:25 +0900
Message-ID: <20250820180325.580882-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported an uninitialized value issue in hsr_get_node() [1].
If the packet length is insufficient, it can lead to the issue when
accessing HSR header.

Add validation to ensure sufficient packet length before setting
network header in HSR frame handling to prevent the issue.

[1]
BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/hsr/hsr_slave.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index b87b6a6fe070..979fe4084f86 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	skb_push(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
-	    protocol == htons(ETH_P_HSR))
+	    protocol == htons(ETH_P_HSR)) {
+		if (skb->len < ETH_HLEN + HSR_HLEN)
+			goto finish_pass;
+
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	}
 	skb_reset_mac_len(skb);
 
 	/* Only the frames received over the interlink port will assign a
-- 
2.50.1


