Return-Path: <linux-kernel+bounces-784721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B62B3404A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86BF484C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0E1DF985;
	Mon, 25 Aug 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wC1DMav8"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7115D3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126966; cv=none; b=b88HXWcTRZwgZrby3KZi4Icq6/U8424kkGXLXzHQ27ULuySu8msVSR3XCI2N+Es1md5pXCQaz0CGnoVYYRRICuA7HD+QOiYjLKBW4wxD59hMIsSoCHCgv4JkOxa61YriB2tg1DQb36uDFIYJLyXa0Z5amiEVDlkce5K2TWhJhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126966; c=relaxed/simple;
	bh=kJ4+WrfiTpuX/TbU0q4GBroFiwwGBXMEwWoR5a1yxuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfurCsRLTPK2SKXLkKTRFJrIEgW/ZJxCLJQSyjAWs26u8RPIxxw6Z1NCflRvunXAXGiUkAwKmB8q3zIzi9emB1BI6JF28QjomHk7AcH5tFuuwHRcvsmoPVLkz3sOgoa/FawUIaU89H1HKWFgDi1mgixXLRDZmBsrfLeiXxFTrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wC1DMav8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6620ea89-89c9-4e28-a4be-3f909672a28e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756126952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3xI0UFFB4FGtaw1TyXLzYu7REKh3yP1oz56NbIWht4=;
	b=wC1DMav8UyvDVqJA9vBt/IR1Q3+CxDfA5Bpe0+iGGfde5Jo6VIljuCFqtVoN5fL2Lw2l13
	3YH793IPAg3hLUnZeTYFXHTamyUPz+Ok6aH9P1VIox7pVuPi4GDXl+PSwATEqwKrDHuVnq
	CpbLIFc2O8tXOrEUG/rAWq+q91OLpwQ=
Date: Mon, 25 Aug 2025 14:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] phy: mscc: Fix when PTP clock is register and
 unregister
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
 viro@zeniv.linux.org.uk, atenart@kernel.org, quentin.schulz@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/08/2025 07:55, Horatiu Vultur wrote:
> It looks like that every time when the interface was set down and up the
> driver was creating a new ptp clock. On top of this the function
> ptp_clock_unregister was never called.
> Therefore fix this by calling ptp_clock_register and initialize the
> mii_ts struct inside the probe function and call ptp_clock_unregister when
> driver is removed.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

