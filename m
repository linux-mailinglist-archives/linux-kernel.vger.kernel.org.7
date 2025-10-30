Return-Path: <linux-kernel+bounces-878759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E604AC216B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBC484E6D39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4263678BB;
	Thu, 30 Oct 2025 17:13:42 +0000 (UTC)
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256C3678B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844421; cv=none; b=sB8BKzJFQTc8POuaTWsU/lmPur6sDgj8eY99SaoOGtBhbfyFfcuNaER+xNuZ/qROKax7UMraNZlpOf/iVqWe2p5xLH4jc0SGy6OK1wWAhszbRZ6PWv2GMnb6DjSfmnM/yAKi4KsiOGRdg9IZGVt2GTyvww7Rckj0AKxD4YTPrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844421; c=relaxed/simple;
	bh=TJBWMd3b9/ACqchgqVTWy1HQQX8bklc6M+GQDjjC1LA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TJji8exXLU7NATehF57dhL64TQlHn+FaHUvBLyHk2Qv4A0nGd19vEt6wZPR4fbNqk5tyMJoS/FQbrCSnATZSb0C/jLGyzRNNs7ZyOX5rM19IqELuc8DAOG8T7ynAj2oSzKtZ9fZIkZBjz+5HHyfYClYUls3eC8GPZj+j0XccWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 78B195F95F;
	Thu, 30 Oct 2025 18:13:33 +0100 (CET)
Date: Thu, 30 Oct 2025 18:13:33 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: David Laight <david.laight.linux@gmail.com>
cc: linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
In-Reply-To: <20251030165137.56eb618f@pumpkin>
Message-ID: <aee90be9-4816-592e-632b-21cbea4bb3dd@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de> <20251030143400.09fc0a89@pumpkin> <bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de> <20251030165137.56eb618f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Oct 2025, David Laight wrote:
> It is horrendous - best part of 4k code, the stack frame is 0x408.
> Which means I must be building with a larger stack frame limit.
> Is one of your debug options reducing it?

No that I know of. I've attached the config to my initial posting.

> OTOH it looks as though the actual place to force a stack frame 'break' is to
> stop mas_rebalance() and mas_split() being inlined into mas_commit_b_node().
> (Probably instead of all the current noinline_for_kasan.)
> Both those functions are large and don't have many parameters.

Cool, that helped! Leaving mas_wr_bnode() as it was, and only changed:

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 39bb779cb311..949fd2a0554b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2746,7 +2746,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
  * Rebalance two nodes into a single node or two new nodes that are sufficient.
  * Continue upwards until tree is sufficient.
  */
-static inline void mas_rebalance(struct ma_state *mas,
+static noinline void mas_rebalance(struct ma_state *mas,
 				struct maple_big_node *b_node)
 {
 	char empty_count = mas_mt_height(mas);
@@ -2967,7 +2967,7 @@ static inline bool mas_push_data(struct ma_state *mas,
  * @mas: The maple state
  * @b_node: The maple big node
  */
-static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
+static noinline void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
 	struct maple_subtree_state mast;
 	int height = 0;

> Oh, and the WARN_ON_ONCE() in there is all wrong.
> A WARN_ON_ONCE(type != wr_split_store) after the call to mas_rebalance()
> might make sense.

I'll leave that for someone else to fix :-)

Thanks,
Christian.
-- 
BOFH excuse #135:

You put the disk in upside down.

