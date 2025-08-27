Return-Path: <linux-kernel+bounces-787795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90243B37B26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D47164818
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7A2C0F65;
	Wed, 27 Aug 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DT8RWJYe"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5A27991C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278142; cv=none; b=GCVDXnSfI99KFS5JGrbwIwTq09FHoUM4kDU6O1zoJBihZk0GFfYTt6G8gbB+m46Wt8fZcoOkLQk8PlQEbM8F7ojJ/7nP7P2bas4EyO48oLNolTLGademw4SJgHsOf2LkltJBS9N00ToualLnu1sYPz9aDzcTu6o90drD2TMu7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278142; c=relaxed/simple;
	bh=3YssVqZo60fDCXIBFtae0GGeja1/8Ni+sb8tmS/5Clw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tcGVSBOmVtZSxdMmQ21ZTYpuwN6bbKzXWrDEiMSHZOE0SUuNa2UuveF2WnJsELaM0xXN5WDv1R1V+zNyHRPBIbMRoP6esp1W6oKXwZPxfPdcCjp4bgonDRWsREgra+Sg5eeQ5qNjp7xEu+RYjfn1MjIbzInlsQwb1cKgtA/gGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DT8RWJYe; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756278130; bh=t/6vuWArrNqbfGW419Zomoj8KyqMALN7HsrmAc7JMNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DT8RWJYel5ZrpULt5jg9fxTVW8lmyJcXlw0A6l7uaW5ETXkmPjzGNR2USEw0DPMvZ
	 fdREVTkFrHNh9Q6pxAmxY+Who+YTgSgpom/4seV5myRnCfrLX4MGOnSaVQZVeNZeJs
	 tfhSmyXu9K4p/YJ7cvx7td8lqzY7QKS0Jjyrnn64=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id E030D8FB; Wed, 27 Aug 2025 14:56:03 +0800
X-QQ-mid: xmsmtpt1756277763tyl112amf
Message-ID: <tencent_1D289EA31B164B411B652567BA75BB2D3308@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeASlhnljvTBqljUq8bIlomkqMiEAdp9GyQquzl1jzEdoFx/jhMH
	 RKFDTvMIQAhlLg3c4L0iwQ5CUV88heFPGvZa1qUxG/2dLOROhMDJV1zh2m0tMn9J8Ab7f/JSWrAL
	 AlMoOg5OQ/Fy8atNd2IuhAwHDePGJs8/CQrnHJY4MlXqQ2DEa8A2n+xG8vOlipBS9lvCC0/icVZw
	 4RtT4fNO4cMpJjhSKPQwRBKNpIIBClaDApnVvcU1+lBnBh9cG7+Sqm6TZzTcsmXlGM7n/TJ9yQyU
	 HY7e/5sZeWgjY3HLvQy30W1iWjVG/fALhm7IruZL8bw04nJH15JeQ2Go1CZnXkdUDhmpmbJG9i4v
	 po4sHIyoSP1No7ZOg18w8WDh40gzs4sCTPXQ8rt+y02onUXZRBrL+QySNQzCQBUZOzDHrmYhnjUc
	 wk7R3YaclXfZBLTyu8r+60CXDCEXaEk58eum8xUz4lRpxFuNeRb4X6VBsQeVt7G3UUQof7fcBDMG
	 xYseSPMCr/dL5GQL7RlxESt44GzjTm5JjeTWA28p53eZX6Eal5uTRk//AssC3Rmw4ztuXg1/0fLj
	 hoNIKenpErmYMCvXAh9X84AWMFO0jUkwLGq0h3STO/djcaBD8/mmLfIpeBZvxS1ZXGLagFz0bYJI
	 QtlbLZQe87HDc7Rf38UWXgTH/ZLoSMKNcttNJtRk/kOTdyZLq9XhKx/WZPIt0PSj6BPN/2/eZjkN
	 GmeToZbs22F9puEUxEqI7YK/kvILFOsG5A/7DJBMvMATOEhpEBZ5pMYhQEGyVIbPYHpsugFnmpAY
	 s+Cn//aI1cPjMVz6OVt1gybbjhz3NrzWeKcMAEDbGrnR8yP9CYv1xcu9sFc6U5CVEL+G8kjdz0/U
	 iRbq6jBUXuRM6YBs3y2YcjODqpzz0s/5fLnheDO52l9K1QqVBkmIg5iYzx/PoBlROM9Xx3zqaTjm
	 izwkNGNKwkDKfRnqsezeUjWkG+2zyPzmrZU8/Ub97Um2yNKJaM9vw9i35yOcx9MYPPD2djPe79nl
	 WnfI6iULk0Sef9SlejXMI9F2ZSTss=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 14:56:03 +0800
X-OQ-MSGID: <20250827065603.596070-2-eadavis@qq.com>
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

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf3..3de1ac70019 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -929,10 +929,10 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
-restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			if (!xfrm_state_kern(x) &&
-			    xfrm_id_proto_match(x->id.proto, proto)) {
+			    xfrm_id_proto_match(x->id.proto, proto) &&
+			    x->km.state != XFRM_STATE_DEAD) {
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
@@ -940,11 +940,9 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
-				if (!err)
-					cnt++;
+				cnt++;
 
 				spin_lock_bh(&net->xfrm.xfrm_state_lock);
-				goto restart;
 			}
 		}
 	}
@@ -1557,6 +1555,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 #endif
 		if (km_query(x, tmpl, pol) == 0) {
 			spin_lock_bh(&net->xfrm.xfrm_state_lock);
+			BUG_ON(x->km.state == XFRM_STATE_DEAD);
 			x->km.state = XFRM_STATE_ACQ;
 			x->dir = XFRM_SA_DIR_OUT;
 			list_add(&x->km.all, &net->xfrm.state_all);
@@ -1722,6 +1721,7 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 	struct net *net = xs_net(x);
 	unsigned int h;
 
+	BUG_ON(x->km.state == XFRM_STATE_DEAD);
 	list_add(&x->km.all, &net->xfrm.state_all);
 
 	/* Sanitize mark before store */


