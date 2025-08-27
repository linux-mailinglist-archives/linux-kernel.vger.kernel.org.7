Return-Path: <linux-kernel+bounces-787704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE54B37A00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009FA683E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CA30BBA0;
	Wed, 27 Aug 2025 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lspj12IP"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF2264A7F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273787; cv=none; b=IU1MlhaSMWlZ2ZnOavB1XiinbRwB2u7lSvj6Voafpb7kzLnSIEjedyl46zqGi2zSAvyQUnWTknZcHZO8xCMaZUhWe0xR3IBk7rJcKJ+VncYkM7FfkhlFGed3wSzuZqy4SAjiydsdH5nRIImPyp100eJMOxqgOJKn5yWUOmHg+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273787; c=relaxed/simple;
	bh=EN6vFn97gMBQaSq/XCZjfW03wPb2vRMwI0o/Enun2Gw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NJVXF6iljxe1sQt2gv8XzFmqgJtDdeAw8DXtbarEv6CXCvlVAhDltBFbwlLmfUpJE3ZcjGWI9yArjieuClUKjZcCkygq6LtUiEZE7rIJZtVt/Rt+nuL8FSSJ8pbX+s2N9l0FTECtNnDwzCynlPJbFt6wydOxiDdMLlcmIDWX9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Lspj12IP; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756273778; bh=qtd7CtVakKa16So2yrWPPc60aKpdTAyiw5Jrl2jnSTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lspj12IP2cCl3N3v8k/2sf8UHGf0/gOk6ukI8JlVnTI/EsDV9shNa0ufa0lbqM4Br
	 kQXGP346j1qDfzce4iqNRRqDCn26/8+/qkeFZdoL3ZeE81rvQcgBUrTNjMuiMdFwdN
	 HRHrT49ej5UJjViDOl1ndH16lQhW3J+6J4hS4drc=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id C64ABC34; Wed, 27 Aug 2025 13:49:36 +0800
X-QQ-mid: xmsmtpt1756273776tbmr73ubf
Message-ID: <tencent_CFCFAA0DC325818D879200DDE3DD86193E07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+BVhNUr432huIeyXKGtudE9O40iTYbM+NvX8RXbbS/2GVwP+amg
	 3BaSruHqdrIuGJcuNc5cCWNYGSVNornwtE/wdt2Z/3dGna+276+QIzTr0oEF9cQyEPdJjOY0OKd6
	 lZkuqVMTkDuselEc31qEAQoduRaGvjViHuK3Y86C2ARaiSMj2L/HaUfV3cHBk0d2MlAC+Suyj7lv
	 32PW1tzrXSirno0i3bJb2CsLrqcQPe+/WJau31NOGm+d08yNe95g3OTjZmwQFjlnVTYSc1vMppmy
	 lMradtRj7jXnIkW652RDGLwk+PZGe/7rh1eNQ88jUNymCckEwx/URfJ2GKyB54FWTrj53QgI8OIy
	 T9HB/slBLb9C+fADG4q64kHfa2nhRkAdEDS45cEoq7fA9lu1QdDeBgBTP0hrH85Avq0Ve8hGGnxb
	 Nt36WNubZNsiRcOCjrT78jxNaAoSfXSm5JCqNbRX/Y9407+OekaEcels9vi/4xXIRkv7N7o8UszM
	 rh0W5WRju2ID2DhPdxKSQjZn+1VKgvdoWT45O+ZeYIerMlY/1U4QArto49QS4Yq4rUcf6WHshYoR
	 g5wKDbxx70tuzbS7Zn8UsXZH1G6hLxnic4ZCJ4HeTsUNwuxzxD/zCECwvXpcUd9jfGRr3L6LNhKU
	 nzAoam9hNSZvbAQHNqBQOF7IE49RCFRDG2saqsS4P1Fh/zifynQsS19ANJxynddIuohbBrUZJk9x
	 mfLze4pRWUhk1t9HQhiW0aZwCEZTNDD4PpakQg6Gp015RIxjfDFXMgtQxgWq2dpzeB6F4oUoesvX
	 xESZ6+50EodtW1w9fvOSBdkacNfQ+6gd0iEloZaTzCnPcvYUzzInBo7opR/ozcA2HMh9SxyLYE9a
	 9pANzTyLaPvLScJQIDasywkWde+hACcUq7FC9VVVE+TOszoMoCypXg9PCWAdX76R+k2YQlXN0grm
	 VWYdzyNbg2TzN1m6HTqdBxXC2210P42gk26B7GDM5yz/rmW3CFJIC4JXzjXOHu
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 13:49:37 +0800
X-OQ-MSGID: <20250827054936.536874-2-eadavis@qq.com>
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
index 78fcbb89cf32..137b5b660683 100644
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
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..3de1ac70019f 100644
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


