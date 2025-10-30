Return-Path: <linux-kernel+bounces-878796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87573C217F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08A83A30E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89048368F3F;
	Thu, 30 Oct 2025 17:25:26 +0000 (UTC)
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A00368F35
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845126; cv=none; b=FuhDm1foBbTLZiGohnc6Kgny9RY16acjnLHyxYdlJ5LaT0LZB06QydplaOKI9vxdq0uIptI0bh1hhvMSMUUM1ub9cXhzELHT59ueSPd4aM83Ay+9GjI3jIJCJ0a5cE2j1Ucb68uOf4e5tqJyVnDcmIEvPM7PoOxi+Lu/3YWV5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845126; c=relaxed/simple;
	bh=4gXBl7ggeS2tO+hOz+hW/BOTu6sNJgsc+PUpg4CLIHU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZbIJlmwNXYYoSrX85BebsNzDGAlr/ZAYBpzZLaXVsGUtMRjTySTorW9D3xovoM/mcBYSpQCUOJ/GZqcKhDo12hu/M9XyL3YM+nfLZCHmoXEkvoiLgnifGz5Zq/9ZG1bqL2Ljxeq+MJnDXJT1EnGGxPRe2Gt0TTFgqdTzWOz/Qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 87E425F95F;
	Thu, 30 Oct 2025 18:25:21 +0100 (CET)
Date: Thu, 30 Oct 2025 18:25:21 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: David Laight <david.laight.linux@gmail.com>
cc: linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
In-Reply-To: <aee90be9-4816-592e-632b-21cbea4bb3dd@nerdbynature.de>
Message-ID: <34a85c92-7355-1330-3eb4-ad2cec737764@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de> <20251030143400.09fc0a89@pumpkin> <bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de> <20251030165137.56eb618f@pumpkin> <aee90be9-4816-592e-632b-21cbea4bb3dd@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Oct 2025, Christian Kujau wrote:
> > Oh, and the WARN_ON_ONCE() in there is all wrong.
> > A WARN_ON_ONCE(type != wr_split_store) after the call to mas_rebalance()
> > might make sense.
> 
> I'll leave that for someone else to fix :-)

OK, something like this maybe, but I don't understand this, so it doesn't 
feel right to propose this myself.

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 949fd2a0554b..6158933cfd01 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3062,11 +3062,11 @@ static noinline_for_kasan void mas_commit_b_node(struct ma_wr_state *wr_mas,
 {
 	enum store_type type = wr_mas->mas->store_type;
 
-	WARN_ON_ONCE(type != wr_rebalance && type != wr_split_store);
-
 	if (type == wr_rebalance)
 		return mas_rebalance(wr_mas->mas, b_node);
 
+	WARN_ON_ONCE(type != wr_split_store);
+
 	return mas_split(wr_mas->mas, b_node);
 }

Christian.
-- 
BOFH excuse #135:

You put the disk in upside down.

