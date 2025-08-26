Return-Path: <linux-kernel+bounces-786218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0936B356B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E6E3AF074
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D952EA47E;
	Tue, 26 Aug 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="nVDDm+aU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9519066B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196649; cv=none; b=DfazCa0W79ofYrMmKeK3MPvawTv/sUX3k5O4tUcA2dANMgZDcd7kweaSKiwpQn3jDYuMxoy3GX1sRp0vD4oRxEjlm3fz4t6Aly6OCOSgAqZqQ3Bczs7aEJJ1W6tAyZyLwVIMRaFStQgmySQCG7ui9JSV9eQclq5WXerJFgEZZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196649; c=relaxed/simple;
	bh=wy6nl9eoLABwjkpO5WUfxhI/dcfce6kETblXZeeWkQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EYViVO3vpCckeRabXUK0QDfAmMQAsuxHk75fGFNrwPX6SlqKm3GNDHauu9D0QAxZsMG6CfT30WBcHCONT7O5fTZxgB/7OBo3yoETG9dky/5xENtqYBNPJj7yguf8TUPpLM571Mg7usGPIwTJaXyf+UldTHWuWlP3ipg8IeOxQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=nVDDm+aU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756196643; x=1756801443; i=efault@gmx.de;
	bh=AxYQppCcGWsRGrgVd+4ICU+J/wg/sEIau6SSvx5A47g=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nVDDm+aURO3OFiLgssdzQaqib8jv3PzLf2NLt9gnqR0/2BVq3HAY5XyP8QExE9uS
	 VMnBsL2iQlxQG4fN8KbFn1/QnNQvkk4DnslH8t4V7EM68MVRlCAK6ZZ6ebi8bzbRK
	 b6qiWJcxbOJ6+Tn8uXd8ct6wAum6WHTUhcOoh6PB/HjP8dyeaGLSlRWUJdQRwuxWA
	 5fwy9ZRSH/CajitoA1MagQny90jgAArZlJnP5SkX6I0ErE6S3/IPdRfYt2yGv8Gua
	 1EKX5iBWjHOpe7G/mNicSxRV6C79TV59cxw32EYN4ypsocxOkHEsQXvXKjrM3tHSH
	 HcBa56Lk8EfLT7Feew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1uL4f12x2y-00qPiU; Tue, 26
 Aug 2025 10:24:03 +0200
Message-ID: <bfb21521a33b8335216ec2523bc461583ea6f7a7.camel@gmx.de>
Subject: [patch] net, bcmgenet: Fix locking of netpoll facing functions
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
	 <florian.fainelli@broadcom.com>, Breno Leitao <leitao@debian.org>
Date: Tue, 26 Aug 2025 10:24:03 +0200
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:IeBA9UDoTzYcZK3+fA743Lxv29v3XqxB12WNamUioV5BYrqKzX7
 NrNaJ0+tL7ngXUIuFVcXqSuH3QFn/S/j+H++RRK8Z6VTkvhzYFOLOj4R9anvtaC7zgX4mUc
 c/gGEw40GCZgiktL+hx4Rnzq9IPhSMgK5H2qh6x6Dju+wHL52hhte3fqfGWIUmpmCBUsEeT
 VZPEbKQL2XQWwnwJ3gfMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BUajzWucaE8=;m81qzo8Lla85M/Tp2GEzjxtaJ61
 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
 H/Bn8mHjOQM6xVbVZixK/e6mALCvctiyx0UrF

Lockdep reports ring->lock to not be irq safe during netpoll/netconsole
session, resulting in a potential deadlock scenario.

 Chain exists of:
   &host->lock --> target_list_lock --> &ring->lock
  Possible interrupt unsafe locking scenario:
        CPU0                    CPU1
        ----                    ----
   lock(&ring->lock);
                                local_irq_disable();
                                lock(&host->lock);
                                lock(target_list_lock);
   <Interrupt>
     lock(&host->lock);
  *** DEADLOCK ***

Prevent that via use of irqsave/restore spinlock variant when polling.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2022,14 +2022,15 @@ static int bcmgenet_tx_poll(struct napi_
 		container_of(napi, struct bcmgenet_tx_ring, napi);
 	unsigned int work_done =3D 0;
 	struct netdev_queue *txq;
+	unsigned long flags;
=20
-	spin_lock(&ring->lock);
+	spin_lock_irqsave(&ring->lock, flags);
 	work_done =3D __bcmgenet_tx_reclaim(ring->priv->dev, ring);
 	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
 		txq =3D netdev_get_tx_queue(ring->priv->dev, ring->index);
 		netif_tx_wake_queue(txq);
 	}
-	spin_unlock(&ring->lock);
+	spin_unlock_irqrestore(&ring->lock, flags);
=20
 	if (work_done =3D=3D 0) {
 		napi_complete(napi);
@@ -2128,6 +2129,7 @@ static netdev_tx_t bcmgenet_xmit(struct
 	struct bcmgenet_tx_ring *ring =3D NULL;
 	struct enet_cb *tx_cb_ptr;
 	struct netdev_queue *txq;
+	unsigned long flags;
 	int nr_frags, index;
 	dma_addr_t mapping;
 	unsigned int size;
@@ -2149,7 +2151,7 @@ static netdev_tx_t bcmgenet_xmit(struct
=20
 	nr_frags =3D skb_shinfo(skb)->nr_frags;
=20
-	spin_lock(&ring->lock);
+	spin_lock_irqsave(&ring->lock, flags);
 	if (ring->free_bds <=3D (nr_frags + 1)) {
 		if (!netif_tx_queue_stopped(txq))
 			netif_tx_stop_queue(txq);
@@ -2239,7 +2241,7 @@ static netdev_tx_t bcmgenet_xmit(struct
 		bcmgenet_tdma_ring_writel(priv, ring->index,
 					  ring->prod_index, TDMA_PROD_INDEX);
 out:
-	spin_unlock(&ring->lock);
+	spin_unlock_irqrestore(&ring->lock, flags);
=20
 	return ret;
=20


