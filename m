Return-Path: <linux-kernel+bounces-859663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C25BEE3A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556974E14C5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896612E229A;
	Sun, 19 Oct 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwxuiTqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CEF50F;
	Sun, 19 Oct 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872586; cv=none; b=nQ6/RVK/RvuIj0KsYzyYUol0g7DQlwP6zwnFA7I61m0R+qy31QhRfLXZq2ZnXlHsFQDLFb7HgIx8n54NcV+xxHXSgZflbvrlqUT6UETe7byf7Y3xgrtcqVYsQgfjoFrz3ehqRFUutVfytRFmbxcxPmpen6afN0rBB37WEkoCuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872586; c=relaxed/simple;
	bh=XdXPcMSUq5QRWykCU/2I7UkLH5CcmxUEJk7DDBFEi8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVL4JgonREUgulyJumtNLAgo527GgAAcLdshQ9ktLy3Eqc1HUbWWuIAfPVWrzgjA6EJUquuAfzPHhAyoTEGQwC00U9V9O5+B+NFlDlwzqhoTdzR5/lDDz9JLnHr4EF3s0EfGp1t+ySayTovZ6ZgJ+/AiFMyno4uWYP2Q3KeWKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwxuiTqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC371C4CEE7;
	Sun, 19 Oct 2025 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760872586;
	bh=XdXPcMSUq5QRWykCU/2I7UkLH5CcmxUEJk7DDBFEi8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwxuiTqI/ts5+K2P9Ok8qy5c0HO46aO9DyqW9COeHSQfxQJ6S7RIgvQANX5cQbk25
	 kghMQtpxMBTiWNu6ikk3HssaFVXjDhbHaZEJDLTnfp6CC0/bURHxwNzkVwn0VCjfQ6
	 cSiA5vc7NWKUXoSV9pG09w/JWK+GTL9k+sR3B0yc=
Date: Sun, 19 Oct 2025 13:16:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Renjun Wang <renjunw0@foxmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add UNISOC(Spreadtrum) UIS7720
Message-ID: <2025101907-living-zipping-3894@gregkh>
References: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>

On Sun, Oct 19, 2025 at 06:44:38PM +0800, Renjun Wang wrote:
> Add support for UNISOC(Spreadtrum) UIS7720(A7720) module.
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480 MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1782 ProdID=4064 Rev=04.04
> S:  Manufacturer=Unisoc-phone
> S:  Product=Unisoc-phone
> S:  SerialNumber=0123456789ABCDEF
> C:  #Ifs= 9 Cfg#= 1 Atr=c0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> 0&1: RNDIS, 2: LOG, 3: DIAG, 4&5: AT Ports, 6&7: AT2 Ports, 8: ADB
> 
> Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 62e984d20e59..667de914a5eb 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -619,6 +619,7 @@ static void option_instat_callback(struct urb *urb);
>  #define TOZED_PRODUCT_LT70C			0x4055
>  /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
>  #define LUAT_PRODUCT_AIR720U			0x4e00
> +#define UNISOC_PRODUCT_UIS7720			0x4064

Shouldn't this be in sorted order?

thanks,

greg k-h

