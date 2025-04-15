Return-Path: <linux-kernel+bounces-605188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E1A89E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48EC3BB982
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114401B0F11;
	Tue, 15 Apr 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Duyp6oy"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519D1F4629;
	Tue, 15 Apr 2025 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719993; cv=none; b=BUfe7sJd5+vacC7vTNFiZiwP7gyXZG7TPIlvtoSggH0m4Lbw2b6Hw7lhlw29jrEBEqcL55wX8wjMi7dqoW61oN8Ad6oeVoAPPkjlI6q+tcptUjH6wbVYFN6NiYYJJLCe6OgP+LlCudyDpzw3fsy0EWKouAMEsFYwWjE6cW1c6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719993; c=relaxed/simple;
	bh=F+opCqQgI1JGWsIbfBiORX7CHVi3oDSVIIuvx+UIiSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXAwf+LTLVRFZJfXoUSXK+Hf5h2u0TIC42af9N8PvLeRM0gG5giJOWlzR3frxb2sLzKPodqxzD5BaDRZdm0cdPI7CQFylmapFVNgjwRFVpCn6Cq3zH61dNGHQTrIxgkznR0IVkyntiqM9Ya8fzNp4TC9COj61K0XoupPQ/Q0WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6Duyp6oy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ii6iuROWqxP8LjrFqncN/4R23My71bKFfMQynX2YE0k=; b=6Duyp6oyGog89h/C4Yf9D6v/2m
	3iguH7jDoLNvuY+PQt8i47MAYEGMDHPUG7dcZrNEns3SPWIDG4BMAa8PIDTj7ueBt81J6dc1evrY2
	vNyKsf+SK6TbYWNncyiVtFTRyIU6hxQYkuFa6KkFVlvCzC3X+eB/zDysDPdz+CHfIl7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4fMn-009Qzq-JI; Tue, 15 Apr 2025 14:26:17 +0200
Date: Tue, 15 Apr 2025 14:26:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: Re: [PATCH net-next 2/3] net: stmmac: dwmac-loongson: Add new
 multi-chan IP core support
Message-ID: <c2ff5661-a972-4cb1-9523-a715acf4bc4e@lunn.ch>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
 <20250415071128.3774235-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415071128.3774235-3-chenhuacai@loongson.cn>

On Tue, Apr 15, 2025 at 03:11:27PM +0800, Huacai Chen wrote:
> Add a new multi-chan IP core (0x12) support which is used in Loongson-
> 2K3000/Loongson-3B6000M. Compared with the 0x10 core, the new 0x12 core
> reduces channel numbers from 8 to 4, but checksum is supported for all
> channels.
> 
> Tested-by: Biao Dong <dongbiao@loongson.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

