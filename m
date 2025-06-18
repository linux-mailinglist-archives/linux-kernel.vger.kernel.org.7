Return-Path: <linux-kernel+bounces-692094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9280ADECA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E1B7AA3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EA2E2651;
	Wed, 18 Jun 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tAhQaCXk"
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7F2DFF10
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250095; cv=none; b=ZKFYDx2Op6ar3D63YikFaJC10aNi3knle1vC9FHqGy0KoQrmOqBWhpc+0bSD4dRmfoArQSFBz1dre3qt+h+GPFhZANWBxt5+vI+3bGo9bZPGoWcOa/yDpLLdOhGAohUvX/o4rVpXvUGJe2/nwWzLxqWlihzn+AKwcGYkzChdnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250095; c=relaxed/simple;
	bh=c/V9qKsWL7LR4TXZlQzm9LYcR7HXbQIfS9FcI7mQezw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFejUw6OrYjWe9/Uv2MrmVwKyh3KzwDb0jcTtxpgRwphpb7zeqHHNx+wYWtY5txKC2NO9UnrBu9R/kydk0PzMZLsFyaWJ/EByqz7cCf9HAlThsJP7cpOV6D8KjNpeoC41BsGaXsh6p7iGwPpsZ9hs7JUFhwQ17BuXHQfR0pSzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tAhQaCXk; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uRs07-00CiFB-PY; Wed, 18 Jun 2025 14:34:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=50l1Jw38RlpNlRT0k2eYWxpZdFo+21V94gLNM82jfXQ=; b=tAhQaCXksEaw6n7FfdY4l1Qxav
	rvwfws3hkimpRSQspPu2rQIrPdbQhQhVVbqLCigWVX8KoehXAXk/VDiaHsSKZTNr2FZwDIm1dKhE1
	OOIbhUJtp59Lfwx/sKrJYfw3rFDFyp4iSbE4mwXsdr34j7U/W9QPuBAOAGu9MJr9fxEg4HD8umB/A
	ntFGj3QE7YkzTC8+88nqqXM7UfEJPWvlRVR9iCt9sgJ1BhmM/egnus3Rcgg/WCnXSp19X3K3+ZreY
	fEcmbB9s4w+s2K/bPaJ2yhb0aXnIHGc71TfOUbGQUE1KOuqsQSDPtR0fbmhZTGQXYz8B+OMmO77zJ
	TqS5rycA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uRs07-0004bn-CZ; Wed, 18 Jun 2025 14:34:47 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uRrzp-00DbRZ-A6; Wed, 18 Jun 2025 14:34:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Jun 2025 14:34:01 +0200
Subject: [PATCH net 2/3] vsock: Fix transport_g2h TOCTOU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-vsock-transports-toctou-v1-2-dd2d2ede9052@rbox.co>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
In-Reply-To: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Function may race with vsock_core_unregister(): transport_g2h may become
NULL after the NULL check. Protect from a potential null-ptr-deref.

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_find_cid+0x47/0x90
Call Trace:
 __vsock_bind+0x4b2/0x720
 vsock_bind+0x90/0xe0
 __sys_bind+0x14d/0x1e0
 __x64_sys_bind+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 047d1bc773fab9c315a6ccd383a451fa11fb703e..337540efc237c8bc482a6730948fc773c00854f1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -533,8 +533,10 @@ EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
-		return true;
+	scoped_guard(mutex, &vsock_register_mutex) {
+		if (transport_g2h && cid == transport_g2h->get_local_cid())
+			return true;
+	}
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
 		return true;

-- 
2.49.0


