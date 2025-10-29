Return-Path: <linux-kernel+bounces-875378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC43C18DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9703B260A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7D3126C0;
	Wed, 29 Oct 2025 08:02:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D420C037
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724939; cv=none; b=VRSiHY9MkztaOp/z5UVVU2E8o9k/mbxnGT5i7h9IKkAbe8CMTMVrJE3ngcriTn7JSQ4jnbxRnkFkLrUilP5tTnbpjH1CuklsWb9/DtuAuc9Fp5JtTiEHGRxB5ndThnkNgOeZwizYr2PWFj9GQvxRzJNkk9+IfsQMKnNTYRPG1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724939; c=relaxed/simple;
	bh=zGUy6hqxcL5f9M8JFmyZUwsjQ5k/RnOvGiYJQhndEsw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I/YgSGIvcPuS0g93XYFqxlZs4YaE0SmPHGqsa1Kk14jm8EuTZcVQhpms7qDKWtY3MN0FnQ5otSUTuREH1Z3h0dIJW4zLZtFZ2LnnOFG3jJVYO6qHHkWsEgB0rbp41lnD86UgTMYt77bFa3WAtE2anBg9IUg/JRnmUPbCaVEfmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d3a4db56so297097945ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724936; x=1762329736;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E52llTg5hG4h7f2w5EXV6ipfF9ukal88Q5zlnLcQ3lA=;
        b=TUBrvp3uOlrFdTkpNRWWAhygDpicTdV1tXeZa7P9ebx9k1bbsBz46EmH5lg+7wlZA/
         selh4Sku2a26bBEd1nghUQHXBpXPuSP3Zz1/QMrFL62sVCqzRjxwU4DWnNd4ViHZbGnp
         p6yc+7k9rf1i8fHy1nt3tWr7yxSayo+Rl8/uNBM89wd1DeNIYqnmv02l8JkOhayWjREQ
         hGJssL9Z3TUn36necnbMPaHfOV+iAGJPQu32OkXd1iRpHMD4kZMKlAUIfKhIwtBjH284
         y9Po5ewnsaTCH5nuh6dgs6XTu4rh1uWYiDFzOO+MkBsAHWXdXOmwAJwe1Cdn26rb9DjT
         zHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOuovg4aor0LTd98vjIK7OPqfL5lBHnSV4Ork2j15ntf8mpuWnPs/wn3Hm0JVbGcRfy+lhbCvLOPm8o0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCWwsPt045c3U/AqTd5V3UZkv/kSeB7idQmL66GpcbkLIP7iP
	fmUjbR3wCpGraVdhoETqxMcQJ1+RHZfCLa/zg6TRson+LCB7uL+nA4EEL8H25UX9Ub3CZFOmMoC
	2k1YxnbEr9cX7wbNOKm7KShE8lwqfcQErXLCj17SdJFWpES3DMEHftbkVS/k=
X-Google-Smtp-Source: AGHT+IGuAkS+kBelZkgkYBXnh8Ydxok/gFhSI2sRqKyODADqLmrDS4C+0roN4qO08yaVySmm4LkK2EX8UKQnx0QMJzBGmtLJJ7Rf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:431:da08:d652 with SMTP id
 e9e14a558f8ab-432f8e5dfb9mr29694955ab.0.1761724936071; Wed, 29 Oct 2025
 01:02:16 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:02:03 -0700
In-Reply-To: <20251029062151.Gq0gL%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901c9fb.050a0220.3344a1.0414.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: signed-integer-overflow in ip_idents_reserve

IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
================================================================================
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
360654889 + 1871359415 cannot be represented in type 'int'
CPU: 1 PID: 128 Comm: kworker/u4:3 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x465/0x840 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1b7/0x280 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85b/0xfe0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x384/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 128 Comm: kworker/u4:3 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 panic+0x2f0/0x9c0 kernel/panic.c:308
 check_panic_on_warn+0x95/0xe0 kernel/panic.c:228
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x465/0x840 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1b7/0x280 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:51
 process_one_work+0x85b/0xfe0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x384/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10759f34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf23b541eb2e03cb
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12983e7c580000


