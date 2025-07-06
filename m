Return-Path: <linux-kernel+bounces-713364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD7AF58E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B047BB8F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD127EFEF;
	Wed,  2 Jul 2025 13:19:11 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFD275B0A;
	Wed,  2 Jul 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462350; cv=none; b=Es9by2ONvK6GK97FrkMx1lt/4WQiPL7fV4ozjxd6vDO/acWj0hskOEDN1R9ej8OFfoFsnXXKfAiw8NxC8XhYM81inP4Tb/Zo5z8+WMBeLl+Wf0tIcBNSDedoDX0TFxpiF90o4kthBk7BNVaAkz0oR0bTCddtlfV1AYdZWtgKWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462350; c=relaxed/simple;
	bh=6VbctXr1HBmpPa4pxAPQly7LQ9NAwqI/QXAnT6EFxzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfFD7Zq4UGxhPtuZFeYrNcXrLzqEL2E7cvnmMaH9Z65EwNObvi6SWNLUwT05cvr7wSTTTAALj+/pPngpSzx5DxtSqIcV7XYzQlONqClAtX/LtC+lVcJJC+vetDPmCYgKPLtjpq+yDoWKHKvG4EUzS4QOdQl5kWe6nl1JlCqHtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1uWwaa-00058G-00; Wed, 02 Jul 2025 14:29:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 5A574C0B23; Wed,  2 Jul 2025 14:02:30 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:02:30 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	sander@svanheule.net, markus.stockhausen@gmx.de,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mips: dts: Updates for RTL9300
Message-ID: <aGUf1rLBbcuKCHTC@alpha.franken.de>
References: <20250619010754.3760612-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619010754.3760612-1-chris.packham@alliedtelesis.co.nz>

On Thu, Jun 19, 2025 at 01:07:50PM +1200, Chris Packham wrote:
> This is a series of small dts changes for the RTL9300 to enable various
> peripherals.
> 
> Chris Packham (4):
>   mips: dts: cameo-rtl9302c: Add switch block
>   mips: dts: realtek: Add switch interrupts
>   mips: dts: realtek: Add watchdog
>   mips: dts: realtek: Add gpio block
> 
>  .../cameo-rtl9302c-2x-rtl8224-2xge.dts        | 96 +++++++++++++++++++
>  arch/mips/boot/dts/realtek/rtl930x.dtsi       | 31 ++++++
>  2 files changed, 127 insertions(+)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

