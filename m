Return-Path: <linux-kernel+bounces-693684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6EAE0244
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 12:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BD616911B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15824221DA6;
	Thu, 19 Jun 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6oZyWiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2D220F4F;
	Thu, 19 Jun 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327395; cv=none; b=QEodHX213aZiLjL+2tBtHB9eqeDkn+3AHZY3yKu/PjYn91bNpGGxpQ7HS/cw2Lh5Mgfs+7guPifH5uD4I5Q/7HizTeYhJ8lu0Byl1eqYalka4AbGu8InrU+Px2W9cJfV/xaVrdkaLiyd6JRmMVNiTgK0OT7Ks2n8p5puJRDjON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327395; c=relaxed/simple;
	bh=+NmzNqs4ioHLre1LisHUVsrMGUyewytWYBtMJl8Nzdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7Pq0Klg9ow2wdOFnKBzyQ/7VcX2DoIHb10M56xkpeNcrth4CK288eCKW4kI6q78ibjDSlCH5eu0vp6+aGG7USfEbg2Ysat9Pm4UD2LC1yx1g6l2qXt5HRXwU1S016qzLk2v+08GxwGd9YsahIhCiFB0SxiQQ1wg1XJ+QEp80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6oZyWiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CE9C4CEEA;
	Thu, 19 Jun 2025 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327395;
	bh=+NmzNqs4ioHLre1LisHUVsrMGUyewytWYBtMJl8Nzdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6oZyWiWcI3x2ARJ2V8VEh9o7zxxRBSP4MYbwjVqFs9axHGNnC0qD+nUO2IMyuOb4
	 diXOATtBrJVhrsWfLdRh5Q1+v18E0G+VgEavr8uOiadAWCp/Dxj/rlHOF2d92JKlG6
	 tzLxVb4jyx0sEQGE5qWR4GJDhRdJocdfnhC6Lj7VMbkQmt7ni3Q7wtWEf+XKCt9ykD
	 MpyQha8f/0Yl5FoDumPUOOLLELlNcA2QC4NrhYvkA9hPfqUSXNNqgLKDBUMGkPB5f6
	 QV48kl2WieXcct/+o58B5UuGos4/FHvFSIpGI58yYm+2NDdIcgfcfVu/sCCKY/lWa/
	 SbF2olp8sJifA==
Date: Thu, 19 Jun 2025 11:03:09 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first IRQ if
 not used
Message-ID: <20250619100309.GC1699@horms.kernel.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618130717.75839-4-linux@fw-web.de>

On Wed, Jun 18, 2025 at 03:07:14PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> On SoCs without MTK_SHARED_INT capability (all except mt7621 and
> mt7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
> but it is never used.
> Skip the first IRQ and reduce the IRQ-count to 2.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v5:
> - change commit title and description
> v4:
> - drop >2 condition as max is already 2 and drop the else continue
> - update comment to explain which IRQs are taken in legacy way

Reviewed-by: Simon Horman <horms@kernel.org>


