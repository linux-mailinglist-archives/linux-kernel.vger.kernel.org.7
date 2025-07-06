Return-Path: <linux-kernel+bounces-711845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C6FAF0098
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A961C21EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FD27F018;
	Tue,  1 Jul 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wzp5qGce"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11B27EFE1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388310; cv=none; b=Oz+WGDjEYOkT77h2L6DSOLsVTi6kQ1Jhj+33aW5JdTeB+k/H6m423SMWoIdocwoGI57aY/qEGWSmq/GC+73Z5YGHycgeZ1gY0LL/82dr8nvpjmguKHd8fclhnUx43Tr5W0PioFnf5EMKhhzunJqTsGt8yPmPcatKnz40Byd28fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388310; c=relaxed/simple;
	bh=GSh1yLctr/h7mt17iCABMV7donflOQ990q9vmjYKMeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0k7vuf63VxATJraNBHv5uaK+PhNSh8ZhLVB9GtjZqRXbQOXdU3KwudOj2ljy3qUU/gJnZZlkSiQNLC4vigytLTfcryLX5lzQ4wnUDxYBnHmYho4Xw1XaE6e0xIF88bdQIVmNq3h7uDE0f25hEGLzoJKEQmtBzkjjfnU16J6uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wzp5qGce; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34647b2e-3d9d-42db-9851-34ad8621af02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751388303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdTOqogTp5JqM4b0+vAKcrKmgEFcq8WvFyC5EnR/3bg=;
	b=Wzp5qGceGGl95r7D/0lKItVPsPO6qNrVY7lEmWjLAGnLkqaIy2i+/rkJvKWAmC7S0fs0w0
	yTIWAk7S2uKU5znFYHxgjaUy2KY+6aBQepouQEfpE4CtempkqY8gkBezWqdM0GPVlkJYWK
	sD7ARAAqL74oHVw5FGR3QlI77hxl8ig=
Date: Tue, 1 Jul 2025 12:44:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 13/18] net: macb: avoid double endianness swap
 in macb_set_hwaddr()
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Harini Katakam <harini.katakam@xilinx.com>,
 Rafal Ozieblo <rafalo@cadence.com>,
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250627-macb-v2-0-ff8207d0bb77@bootlin.com>
 <20250627-macb-v2-13-ff8207d0bb77@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250627-macb-v2-13-ff8207d0bb77@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/27/25 05:08, Théo Lebrun wrote:
> writel() does a CPU->LE conversion. Drop manual cpu_to_le*() calls.
> 
> On little-endian system:
>  - cpu_to_le32() is a no-op (LE->LE),
>  - writel() is a no-op (LE->LE),
>  - dev_addr will therefore not be swapped and written as-is.
> 
> On big-endian system:
>  - cpu_to_le32() is a swap (BE->LE),
>  - writel() is a swap (BE->LE),
>  - dev_addr will therefore be swapped twice and written as a BE value.
> 
> This was found using sparse:
>    ⟩ make C=2 drivers/net/ethernet/cadence/macb_main.o
>    warning: incorrect type in assignment (different base types)
>       expected unsigned int [usertype] bottom
>       got restricted __le32 [usertype]
>    warning: incorrect type in assignment (different base types)
>       expected unsigned short [usertype] top
>       got restricted __le16 [usertype]
>    ...
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 578e72c7727d4f578478ff2b3d0a6316327271b1..34223dad2d01ae4bcefc0823c868a67f59435638 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -265,9 +265,9 @@ static void macb_set_hwaddr(struct macb *bp)
>  	u32 bottom;
>  	u16 top;
>  
> -	bottom = cpu_to_le32(*((u32 *)bp->dev->dev_addr));
> +	bottom = *((u32 *)bp->dev->dev_addr);
>  	macb_or_gem_writel(bp, SA1B, bottom);
> -	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
> +	top = *((u16 *)(bp->dev->dev_addr + 4));>  	macb_or_gem_writel(bp, SA1T, top);
>  
>  	if (gem_has_ptp(bp)) {
> 

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

