Return-Path: <linux-kernel+bounces-721619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E79AFCBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DBE1649CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255D2DCF42;
	Tue,  8 Jul 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="G3ONoygU"
Received: from smtp105.iad3a.emailsrvr.com (smtp105.iad3a.emailsrvr.com [173.203.187.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8824188006
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980708; cv=none; b=GYyPL12pnSIcLU2UxFu5286Z13Eqm1TJE89VbZeZsNqmf1uxEJI66WVt7fJw4Ah6FpgApAOMgbI2JcFwsm6u1GnvcCCbkC36kiLwcLCtXw1fulhCE5zjTo+5xVY5m+a6kPiZnl+k+Er7VniQy2KCJAI2HZpMjK5X3256Amsv3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980708; c=relaxed/simple;
	bh=ES+Zw35sE9jJSNZmgrktV1PA8OXQ6YDKbBiUODf8+2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8w10Nlzl0xBwwts9+mKb1jgmdKg6O5kLQzIYx71xxy5WUWngPtibdIwVxMp98PsmaNtpKcvcvTPzoDmoQaqhsEb78sA8UAcL3TqlWkyapUTuGWT9XqrlIlotVK2fK8vNbcxLdeXDn1ew63jYsLDC5BM9wGRuF6mbSFH8zrnK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=G3ONoygU; arc=none smtp.client-ip=173.203.187.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1751980700;
	bh=ES+Zw35sE9jJSNZmgrktV1PA8OXQ6YDKbBiUODf8+2s=;
	h=Date:Subject:To:From:From;
	b=G3ONoygUk5ZZh9t4UPGNzK4T7KO08JIYezvHAhB6mPJCY/cyBijlsXdIu7OXQFE1B
	 +i1Cr4rtvoMqKpPFu290kYtV9JzivK+K6QH/Vch8wsAyL2UccGfhotEOwTwICbSJGy
	 FzlYcWq6/GckiNvy1SaSdsmg4FdPAHLlpUI7p9ic=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp30.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7B2F552FF;
	Tue,  8 Jul 2025 09:18:19 -0400 (EDT)
Message-ID: <2f17944c-80ff-49a7-97ef-275f5e247e8f@mev.co.uk>
Date: Tue, 8 Jul 2025 14:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: aio_iiro_16: Prevent invlaid irq number
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Cc: hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
 <tencent_B0B82F456DC094ECE982EF1ECCEC7AEA6D0A@qq.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <tencent_B0B82F456DC094ECE982EF1ECCEC7AEA6D0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 548f3443-46cc-497c-9b50-256e9de4d6d4-1-1

On 08/07/2025 13:37, Edward Adam Davis wrote:
> The irq number 0x2166 passed by the reproducer is too large and is not
> within the supported range [2-7, 10-12, 14, or 15], which triggers the oob.
> 
> Fixes: ad7a370c8be4 ("staging: comedi: aio_iiro_16: add command support for change of state detection")
> Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   drivers/comedi/drivers/aio_iiro_16.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
> index b00fab0b89d4..e43730f00c8b 100644
> --- a/drivers/comedi/drivers/aio_iiro_16.c
> +++ b/drivers/comedi/drivers/aio_iiro_16.c
> @@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
>   	 * Digital input change of state interrupts are optionally supported
>   	 * using IRQ 2-7, 10-12, 14, or 15.
>   	 */
> -	if ((1 << it->options[1]) & 0xdcfc) {
> +	if (it->options[1] > 1 && it->options[1] < 16 &&
> +	    (1 << it->options[1]) & 0xdcfc) {
>   		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
>   				  dev->board_name, dev);
>   		if (ret == 0)

The patch is fine apart from the misspelling of "invalid" in the subject 
line, but I'd already submitted a patch for this before syzbot detected it:

https://lore.kernel.org/lkml/20250707134622.75403-1-abbotti@mev.co.uk/

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

