Return-Path: <linux-kernel+bounces-685679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E8AD8D20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DED97A9C12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4015B0EF;
	Fri, 13 Jun 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/VPNTzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088A4409;
	Fri, 13 Jun 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821507; cv=none; b=QpwcGIKa8tqamKZB1NQyLNQoqAjegJBYtfPvHnqtvKTx5fFbzc0UxFddE67gZnOnvCk//XcZCE/kzX08hGz0ClqGjXiPBtMu+T/FRYRMSCJCN5eq6aaipgFmaZjz1sOBUHPRw5KgGOU/v+isCpOI1XknbO9+y+rWTP36q49o37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821507; c=relaxed/simple;
	bh=MkEOfV0i8W8Lzd3l73+lQlM1om1xg080yIUMBBKWzQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+qwTDDwbdx1cLSvQEJAtbgiIodaHNpJEtbmEUpGYfm+VLRfXDTqeTUmcAw5lXu+aWIOU/LlyTCGZJmnzSrvOTsPqzdoMhxaatLIWS3OG8nsCi5o2JtVqn7tPEOznHDZIo1U1OC8Et+vZ1ZbvZ7LCv8nbdQFEviFjo7kMpULsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/VPNTzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D37C4CEE3;
	Fri, 13 Jun 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749821506;
	bh=MkEOfV0i8W8Lzd3l73+lQlM1om1xg080yIUMBBKWzQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/VPNTzUz05NC3yjAiux2hvUTE/Ka6AwFOVYrWp6ZFWiu4VJ+IgLHUlOBs4Jl0OKl
	 MNDujlBTFjcz2gII6bn14jE28wbxEB/BDoHFBRXPLTH/TlkClG4dV/0IZRs3DO7uT2
	 xp17cInINFkYJ+Ied5DPAOnBnOOr4x129XlGI/S1dyQEaKdwFa4z5XRdYA+MVJWdVK
	 UJAJJ90dwdseQJ9jytb5XAypir0dPpjXGMPLwsjQtLbFAPudlFXY1/hmAaYJoCooP4
	 ULDcQEeOBWLKVKx8lESCsQtDCdNEfaBm6oQd0VFH5ZDOJkWO8+HwuXNWYGeu5i99TM
	 9i5tmtAqtt4cQ==
Date: Fri, 13 Jun 2025 06:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan
 <dlan@gentoo.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, Vivian Wang
 <uwu@dram.page>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250613063145.62871999@kernel.org>
In-Reply-To: <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
	<20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 10:15:08 +0800 Vivian Wang wrote:
> +	rx_ring->desc_addr = dma_alloc_coherent(&pdev->dev, rx_ring->total_size,
> +						&rx_ring->desc_dma_addr,
> +						GFP_KERNEL);
> +	if (!rx_ring->desc_addr) {
> +		kfree(rx_ring->rx_desc_buf);
> +		return -ENOMEM;
> +	}
> +
> +	memset(rx_ring->desc_addr, 0, rx_ring->total_size);

dma_alloc_coherent() already clears memory.
-- 
pw-bot: cr

