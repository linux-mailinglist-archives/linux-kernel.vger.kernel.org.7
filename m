Return-Path: <linux-kernel+bounces-787943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447FB37DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EFA460F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D633A01A;
	Wed, 27 Aug 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KuIIjGjL"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765C2773C3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283499; cv=none; b=AdXieZJgCMVZETGTsYb4V+Z+zX8MoqMSPRaZsy2vOzUlZNoVXFZNU2cIA58OR75crs+ZF2HXAiKYilaAfXtmMCjiI664Wj+IJxyVFELx+t1nC9l0sBSfw3eCisNGbi4kY8p9+6kDkV/zEODY2G9+yeE61V7EZIftavYaa0/qsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283499; c=relaxed/simple;
	bh=5KMB8Ae1XhAqhV90CeLl8aZxM2RgOuhx2AYeegn9toA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kI0NnmSjUQp6bl7rd8qwzb72wIbcHr8LS3O9rV9vxm1Jx3V0If4hSrMu+wC20QQDfMAnOCuuFSr5PLgpv9Ye3DJr+w6m7n9HtX1AhBpIWlbL96t1S6NU6l96KrCIDLqiRuNWczLeTTCR/61ZNEmEXKlSHi29FtnsTYNMGlPOmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KuIIjGjL; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756283486; bh=uxGlfm28oCal3Wjjr2FjMrBnYDX4ivF732oR0a82qYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuIIjGjL5GQ9cGQGOVpNZL6oJKnKS2ygUtmwuWNJ9wsVj0+OuAvyDzc7bHwT7ZHcJ
	 PYVX2hCXdr0YM5TrHwxv4tuODVIRaAT0k6FdZd8T24QgjiqxeYFwW1+qENDm0I1s3K
	 nb987eqnzsjrCnoeX6eWuPzFLmmNPN4i8Pn4gcnI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 2AF99A74; Wed, 27 Aug 2025 16:10:47 +0800
X-QQ-mid: xmsmtpt1756282247tsga5dny8
Message-ID: <tencent_D22CE56CB09408EBB2ED76CC3479F66C980A@qq.com>
X-QQ-XMAILINFO: MgWJKXkE5JIqHw6tBH4x7JBbpTk2eeD6WXBF3YE9aNn67Y3RwtXvut7nsLMHzf
	 OQ4PFGuWMR8Ua6f7bkuwjKNDeBDrcDC2bTC1S5Bjvlo07j9Mjoh6Etbu8v812H54gpxsTUUQxBsi
	 MbpmePQIGqD47iG+kQXmJLHTzR5PJHk2sUreEjLIkw5FxcpoCBipyJHoLOBe3kIe6WUSE1/oH6nm
	 wNmXg+R65kaEI4mzo+WIjMHfqPa7H1dhq71+2SH12btBGuM+BeAYweGRkxXFm5OHEhTN2lyuJUKh
	 mVtcJGLL4nfR1E2Yi7iaIfIFKzdqdXSgdfBbLu/Yn6JGIJU/krY94aNAhb/VXQLVaKsENmRZD1Gi
	 znf6ykwLvSUjlz4kdqjPStrCZev0O0wcGb5tVeT/O3XW0DWREH/R14fr5NHWhiUy25oAN9pv8ZpI
	 PGSj9Wrd3EjZgj5tK8eaklSHPXN6n1BtCmz1EvroCT6L87bV5WvrL2yUuzEmTE0Sq9PJLfBM2AfO
	 9IN0cVeIpaFmfE9A0m4qSsYQsZ9gpBYDPuwiqVcQqyKxt+Ccjzj6BUbmihdMacQS0aspEW9NXUPn
	 jBopC3qASI61RwSDHLQdAUnNvVG/aNV+gMw8PMtlFTUFK8OAVNdC7WduP7gk9g95mUqHmd246FD/
	 px8aUOHE/tz1vSGD1pyTSS4HvKvzI0tndvrzajxW3WHaTEmhFO+yRYiUB0GD4qKWmRS3UK8BPOU8
	 hJOydlLD8RwpKjjYfAGKo1gv8wnEy4DO2YPfaYFmhQ5a7qwXdJWeiVRLtw880iLJcGM6TQU09dM7
	 8B7hYbQ/GgXo9k46PMDFYyexoHHOcReISSNzXKvty9xvoj7wj5f7d01nobnTtnCvAKhClj5vvyV+
	 gDXJBK7OwOslu4ZE2eX+yAAwGJpnxb9vkhGsLVcmBQk/2nbOxTtPhCo7KK6yCb4R+dqV82KN9lAG
	 /NnFij4sX5DkLznaxHf9tZezntFnSeZkgcm6PbcbNjK4hB9c20Fo1lh1N4p5X/
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 16:10:48 +0800
X-OQ-MSGID: <20250827081047.665663-2-eadavis@qq.com>
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

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 0a0eeaed0591..5120a763da0d 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, 0, false);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..77db3b5fe4ac 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3297,7 +3297,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, 0, false);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));


