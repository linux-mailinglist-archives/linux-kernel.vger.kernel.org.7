Return-Path: <linux-kernel+bounces-788039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B42B37F01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064BE1886421
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC35343D6C;
	Wed, 27 Aug 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J6xgaME9"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632C3164CE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287616; cv=none; b=a0CzKpo8f/kU7vqUP+QT7SVZr/UD2F4NOTgtCj0r9w9t5WHaOqatqBVxou62DmOGM9YtsvWklfOkwUqxjzbsMOSqrAZOG3n/t/Nzp9lTXRzVDFG4G0R3Y8QE11ulckO529ZFvZhUVUUQD2CVeYbmKAPumr2cBE7d7SMIguMNhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287616; c=relaxed/simple;
	bh=E0lHlLj+DhlGfA90ZhKGNwcpCTS2wVngKZgOPEiLaNo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LraUkU2rhsy0BTbVy79q7PTQ8K1u68ET0XWVQKDPa9Vd2AwzNolmO9yoED9JdW5YmxwzPRePYqX4CGilS+VsWVy9AfM5ALZhRopTnz0U64d8nWeAjVj2Cy8/NkNTir+HqkgALIKVCDoyKOTGGVVfXjNwl4liU9ulTW6eB9/1ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J6xgaME9; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756287309; bh=t/ahCI1NnfZUJ5IWJLp6fGTI/nqAnam87nQs/2FJ5qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J6xgaME9ofqWg0jGkvUcNK9J0E3scKckO4QvFQJl6mCUGDxdcmMmXKaYsTzDWQVQY
	 epSR5sD//Y4a0RXp/r4MwgHHcanGuCvRubm4XLpj9FVbWXtgShDPEVHxL+PUmuNhz0
	 0VDcGoXHMIU/aTIGVUmcvpwOw+/Ysb5lkM6Z1+CE=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 8C81C84B; Wed, 27 Aug 2025 17:35:08 +0800
X-QQ-mid: xmsmtpt1756287308ty73kpi1d
Message-ID: <tencent_85C67489962ECA2EE44C9D67DE46C912F006@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn9JllrR8AbzisFYUw4v643c3onKmpK7ZI25lDBVYZ3n41JDEmEE
	 SNejI5YhwkCEHtU6czxnrqXSSG67mm+Cb0QNyXKDR+28erCKsanYu3iDMKxzo5sBfVkNW9EbBF08
	 B/ENOLwk50Jvnp5MYDRVYTAu00HTcJdbGWR3yKeUyEgKu1jrRqymvpV/jYggJSOxc6rXhC0EMAqX
	 G1XIZG4bIYjcZusxWfeP70e3iuJgItJh1Fy9IOMMrFztqWD6AKbFTUIjSFSLkpy4ITEAUtzKIvWF
	 8NUARIgerlNMSqCLvMh6WKOpxQzLDkqMOdRiAgOTUB7WS5hYhDNh0hi9D6wUxPVdxkZnp4O71rDz
	 esS6syvKGDYX1qixeBELzyWrD9W3lj65op/4Iuili8bzw434BZ8BjYRTcFyw1IVZ0VKIC6PdiV9I
	 BbooxQJb9nDBapYkvXgMjTrzZ8eJo7hYnH5tWbBJv181FZ54KCLeNTGeUm7QvW2lEceGPs7KyXLw
	 HE7rTaMRMz5aVSpKlkFLRMSV7VIJu124fdtar/AolxmwksOzY/lQEbCwcjbK+GYPUNQL+yTGRJRm
	 4qb3/Z41as8D1I343k/LkERr2FglAhZhcCxoVDESzcw8awQOWklDlwTh9d2UnIkUAh8OSP5zkBvQ
	 x4raPISTpQ3yBKdL72EQfuNA3sZKbYrTfRa0yjovmsQPXwBpl3RGgON7WhM+/hkF0PvYYrert8au
	 FSz76B3nfn4oqmQvVOdt2dmNTcPHky+FhNa0RhBbqbXx0G96/vqy1DE3T3TdZsAl+uYuirtVIO8t
	 gHI5kgHEw5EPPeBoGB0fm27EhvMkVU8nrMIX8uFmsoF3RhXIplyChCpFImKCNl2QX+T6ZJFxw1tU
	 ne4WYmvJw2zovKAjKhW8/yzFjWTUzx5Ug9MRsG0yBpKMNbzuEFLbj+u4T53Z/VrtwjD6BvnnIa+Z
	 ygV5ZYCHMaJc0iDmE0XMX1BWBwZK31D62h5qMtoT5764+SY7Qr1/z3u9VQ5MwkPgVLzdjen8g=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 17:35:09 +0800
X-OQ-MSGID: <20250827093508.740191-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>
References: <68ab6633.050a0220.37038e.0079.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f3014e4f54fc..a1d5acd1f2ad 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -229,6 +229,7 @@ struct xfrm_state {
 		int		trailer_len;
 		u32		extra_flags;
 		struct xfrm_mark	smark;
+		u8		alive;
 	} props;
 
 	struct xfrm_lifetime_cfg lft;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..d66adf7ee6a2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -755,6 +755,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->pcpu_num = UINT_MAX;
 		spin_lock_init(&x->lock);
 		x->mode_data = NULL;
+		x->props.alive = 1;
 	}
 	return x;
 }
@@ -830,6 +831,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		xfrm_nat_keepalive_state_updated(x);
+		x->props.alive = 0;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
 		xfrm_dev_state_delete(x);
@@ -932,7 +934,8 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			if (!xfrm_state_kern(x) &&
-			    xfrm_id_proto_match(x->id.proto, proto)) {
+			    xfrm_id_proto_match(x->id.proto, proto) &&
+			    x->props.alive) {
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 


