Return-Path: <linux-kernel+bounces-826750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C325B8F401
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE111889C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4C2ED17A;
	Mon, 22 Sep 2025 07:15:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A921C163
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525307; cv=none; b=O7/S3jEGiKQvne9sCQpvNMTdIKHZ7NbBr9579di67R4nJ1fDCrREKT46LtnHQTE8iWP0yiPQ9l8bJYtNHR7+BEXWk2JXtNzPkFfctZbK2fPXRCZ6dg/Xde7ESAvo63fwfvHbZ05Ue2PC2SauS6jtRTxR43IJBvPevRESsjWZHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525307; c=relaxed/simple;
	bh=y6PAtcZhvndTv1R6x5d7YE6Yed9I8C4KiguHQRYoShk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8AKUoP2G9nxSrRjNUTYIQcZSooIAOaNmQaeV3cp6B374psZ/5fM9it/LHCl3YqbBmJII3Qt8e73OJkzfGGTKVfwInMqvjSt+eaKNdOoTT6eK7GVWbYolD0TzG5nnLBCDy+13xAvK2vNDLcQ2oDtLI4LAXlARP0ojCdMzg3liCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1v0alE-0000j7-AD; Mon, 22 Sep 2025 09:14:56 +0200
Message-ID: <9cafbc70-7235-4e49-928c-4d68a57b7d46@pengutronix.de>
Date: Mon, 22 Sep 2025 09:14:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/make_fit: Support an initial ramdisk
To: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?=
 <j.ne@posteo.net>, Masahiro Yamada <masahiroy@kernel.org>,
 Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20250919211000.1045267-1-sjg@chromium.org>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250919211000.1045267-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Simon,

On 19.09.25 23:09, Simon Glass wrote:
> FIT (Flat Image Tree) allows an ramdisk to be included in each
> configuration. Add support for this to the script.
> 
> This feature is not available via 'make image.fit' since the ramdisk
> likely needs to be built separately anyway, e.g. using modules from
> the kernel build.

AFAIK the kernel supports multiple concatenated separately compressed
initramfs just fine, so it may still be useful to add a target which
builds a cpio with all modules inside and the rest can be then
concatenated.

What do you think?

> +        fsw.property_string('compression', args.compress)

compression should be none as the kernel would take of decompression.

Both U-Boot and barebox should warn about ramdisk compression property
that is != "none".

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

