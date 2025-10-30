Return-Path: <linux-kernel+bounces-878472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0235C20BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E011A62125
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E927B34F;
	Thu, 30 Oct 2025 14:48:38 +0000 (UTC)
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE858184
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835717; cv=none; b=LGhJ5FushbxQ4zE4BqProlrQrWL/Crtk9ABLjvY2R1yykIYuSn2mf95PAH1Y0wcrZUoI4Ca2jH3A4l7hN3tsH/SAL4WjT8mq5yuu6FxVDo5NkOB0czR/ItVVxUj3kgEbpUiIL/o7wPrlNUv9FUS7iHmSls20UlMv8WM7MjCasRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835717; c=relaxed/simple;
	bh=vUdXjZ+WuXTPLmKaQ5aYQ50FBnHFtYYxgxtHmPlbr0Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UO+gs3OXTK9kcpYzBuIIxhsI7QJpLBwQXNrcZM8H3t1iZiZbtnExVBqusSpxUcjEpoCuQjeOj/cLccxOOEff8gETxA3d1hcx41qPFaOGiogXVqUn56+y9z39wOpjdVobYlhhJMU3Ej98Di5DTFyvys6JkZ2k2JcS0hn/7r4U+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 78CEC5FE4A;
	Thu, 30 Oct 2025 15:48:30 +0100 (CET)
Date: Thu, 30 Oct 2025 15:48:30 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: David Laight <david.laight.linux@gmail.com>
cc: linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
In-Reply-To: <20251030143400.09fc0a89@pumpkin>
Message-ID: <bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de> <20251030143400.09fc0a89@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Oct 2025, David Laight wrote:
> Does marking mas_wr_bnode() 'noinline' help?
> Some functions are marked noinline for KASAN builds, the comment suggests
> mas_wr_bnode() is one of them - but it isn't marked at all.

Yes, I've seen that too. But adding noinline or noinline_for_kasan did not 
help, compilation stopped with the same erro^W warning.

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 39bb779cb311..90ec87d4d49d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3727,7 +3727,7 @@ static inline void mas_wr_append(struct ma_wr_state 
*wr_mas,
  *
  * This is where split, rebalance end up.
  */
-static void mas_wr_bnode(struct ma_wr_state *wr_mas)
+static noinline_for_kasan void mas_wr_bnode(struct ma_wr_state *wr_mas)
 {
        struct maple_big_node b_node;
 

Thanks,
Christian.
-- 
BOFH excuse #294:

PCMCIA slave driver

