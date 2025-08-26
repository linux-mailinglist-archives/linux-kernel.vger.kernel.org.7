Return-Path: <linux-kernel+bounces-786412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C7B3597D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140167AF79B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A69326D43;
	Tue, 26 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGujQhM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCB31987F;
	Tue, 26 Aug 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202029; cv=none; b=J6+sPaFFISVQhopKOMuiXm3gu4UX3VsWkhZYScV9VgoR+Vdat4SSg7lV0hCeaE8G18FCIvT5KaCRilB4j/+0XRpcpTHDY1+haVln5WGVlvkvWy24KLUq6PJK/1cnP5E3trME8Bz51VDMyERUlMKH1YWEnR2Z0ap33MU0T/sR0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202029; c=relaxed/simple;
	bh=JltJi2hR2M3W6bf+Dzf0FehSNnfhv9n51psWbbQCDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJdNxKgK9oYzIm5ThVezxHBGaQrFqGE+wWXKKAARmdPa6MkwSl2J2hbDokP3PB7WB9WetAVj/1h+P3a1s45WkfLFIeZ9ItCartXeqbF7K5yYZrzP0+E9qsoMZe+P9VFatTQki3U2OVbVPEHlw8/I8R7RR3r58Oc5zO16R1Rij/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGujQhM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239CBC4CEF1;
	Tue, 26 Aug 2025 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756202029;
	bh=JltJi2hR2M3W6bf+Dzf0FehSNnfhv9n51psWbbQCDeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGujQhM1hru11D+tP6pZ5ZS+rPUtAFNLcRBovtoVaRDxThmDNt/gwhs0gV2q1Bb4I
	 wkscQyTVPLi0VXtf+LupXL7lU3mV31o7HdTU7jXxtDCPvaoKXiUOjdOuxsApsR+hg+
	 DGq17Iwr7AJ69BlzTAUEby0LQC5KmL5a2tiKuvrBpzVDtEzMME+V9giRdviVeBXEse
	 5gar9XPVh3pujukaj2rQgF8OQvxlg5aYKv7aPHfQjTiHyYJx9EgiIU9TRX8IefGjnk
	 8q1I6/G8FdAnI+xBXnZb5YSxd2zRdxVDRhGVF8E/bjV112AknQ74VhD2xBNFMr38DL
	 BPtiwjWfvpZ6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uqqN0-000000000Gs-01LB;
	Tue, 26 Aug 2025 11:53:38 +0200
Date: Tue, 26 Aug 2025 11:53:37 +0200
From: Johan Hovold <johan@kernel.org>
To: "xiaowei.li@simcom.com" <xiaowei.li@simcom.com>
Cc: Lars Melin <larsm17@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add SIMCom 8230C compositions
Message-ID: <aK2EIRdqgEafWT0a@hovoldconsulting.com>
References: <20250807075215.300961-1-xiaowei.li@simcom.com>
 <58ac9a75-6b0d-4b13-9be4-89a46b8e4136@gmail.com>
 <DDC9EDC62A6DE38C+2d02241f-8f5d-49c8-bdca-53e982d889e3@simcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDC9EDC62A6DE38C+2d02241f-8f5d-49c8-bdca-53e982d889e3@simcom.com>

On Fri, Aug 08, 2025 at 11:03:01AM +0800, xiaowei.li@simcom.com wrote:
> 在 2025/8/8 1:27, Lars Melin 写道:
> > On 2025-08-07 14:52, xiaowei.li wrote:
> >> Add the following SIMCom 8230C compositions:
> >> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet

> >> @@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
> >>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },    /* 
> >> Simcom SIM7500/SIM7600 MBIM mode */
> >>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),    /* Simcom 
> >> SIM7500/SIM7600 RNDIS mode */
> >>         .driver_info = RSVD(7) },
> >> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
> >> +      .driver_info = RSVD(5) },
> >> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
> >> +      .driver_info = RSVD(5) },
> >> +    { USB_DEVICE(0x1e0e, 0x9071),
> >> +      .driver_info = RSVD(3) | RSVD(4) },

Please keep the entries sorted by VID/PID.

> >>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },    /* 
> >> Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
> >>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },    /* 
> >> Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
> >>       { USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),

> > you are blacklisting interfaces 4 and 5 which are not present in your 
> > usb-devices listings and which are also not included in your interface 
> > function description.
> > You need to state the interface function which you can do as  .....tty 
> > (AT) + rmnet + {ADB} and also explain why the interface is hidden in
> > your usb-devices listings.

> Interfaces 4 (for 0x9071) and 5 (for 0x9078 and 0x907b) are reserved in 
> the option.c driver using RSVD() to prevent the option driver from 
> binding to the ADB interface.The ADB function is optional, so it was 
> hidden in the previous usb-devices listings.I have attached the new 
> usb-devices listings.

And please send a v2 with the updated commit message (e.g. usb-devices
output and SoB).

Johan

