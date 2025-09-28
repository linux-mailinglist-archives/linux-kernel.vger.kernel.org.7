Return-Path: <linux-kernel+bounces-835299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFDBA6AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816914E0191
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550B2BDC02;
	Sun, 28 Sep 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ysx6zz4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48904221FB6;
	Sun, 28 Sep 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047007; cv=none; b=WChhz9Im+PFVKEpcc5dva5wJp201YKYMTNWIyY+lJKL2b9oFHHD2BQ6SL/QCx3UrB/8lCxhRguIsfiaHFtLFwyBui777D5ysNa5BuuC7RDgDWZKjUyLHBHc248wKTS0xHwS3G1D0SrR4kbG1rwoS8rP7TxZRyCUnshIo6cey+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047007; c=relaxed/simple;
	bh=5JwN0OipIq/oVISAgikYjXkvIr3FrhH6YQ2SFIfzfJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO+goJYkpU6zQokHGZpsdm6G3TnK5bDGhgiZCmOTS5dZGQ9LCot5tqocA+yD090xam0+IUVGR5ysnteay0d+jjW8dCm/dKxkBpMZLAfRt89rg1TFuLTVGhjMO979d3AZBAPMYVP1b9+0qlJmMFEZWVyPorfSwCTC+LPdotS3dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ysx6zz4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6913CC4CEF0;
	Sun, 28 Sep 2025 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759047006;
	bh=5JwN0OipIq/oVISAgikYjXkvIr3FrhH6YQ2SFIfzfJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ysx6zz4yed22urmrqO8XM1P9o6/EuPXMnd84sj+dOi0SKbpW6u+vk7GFvimIUdqTz
	 CS5GsrWfrXx3AgAbk+92w9zesjjCRRAavok1tl/7P0cnnQsRaGOnwP31u8O7ujW/Rm
	 Z+Hoq5Yc7SakBckQfpiCegKw3crFk8r5V0jCoDEs=
Date: Sun, 28 Sep 2025 10:10:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update the USB serial option driver support for the
 Rolling RW101R-GL LTE modules. - VID:PID 33f8:0301, RW101R-GL for laptop
 debug M.2 cards(with MBIM interface for /Linux/Chrome OS) 0x0301: mbim, pipe
 Here are the outputs of usb-devices: T:  Bus=04 Lev=01 Prnt=01 Port=02
 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0 D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00
 MxPS= 9 #Cfgs=  1 P:  Vendor=33f8 ProdID=0301 Rev=05.04 S:
 Manufacturer=Rolling Wireless S.a.r.l. S:  Product=Rolling RW101R-GL Module
 S:  SerialNumber=3ec4efdf C:  #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA I:  If#= 0
 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim E:  Ad=81(I)
 Atr=03(Int.) MxPS=  64 Ivl=32ms I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data )
 Sub=00 Prot=02 Driver=cdc_mbim E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
 E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms I:  If#= 2 Alt= 0 #EPs= 3
 Cls=ff(vend.) Sub=00 Prot=40 Driver=option E:  Ad=01(O) Atr=02(Bulk)
 MxPS=1024 Ivl=0ms E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms E:  Ad=83(I)
 Atr=03(Int.) MxPS=  10 Ivl=32ms
Message-ID: <2025092838-abroad-recycler-cb66@gregkh>
References: <20250928080219.30078-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928080219.30078-1-vanillanwang@163.com>

On Sun, Sep 28, 2025 at 04:02:19PM +0800, Vanillan Wang wrote:
> - VID:PID 33f8:01a8, RW101R-GL for laptop debug M.2 cards(with MBIM

<snip>

You might want to resend, the subject line needs to only be one line
long :)

thanks,

greg k-h

