Return-Path: <linux-kernel+bounces-852889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C86BDA292
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0962F4F305A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E62FF673;
	Tue, 14 Oct 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWND95o5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275D26560A;
	Tue, 14 Oct 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453637; cv=none; b=WYXgLsCMhGqhFFYy5xvB9ZbgEfsCRBLmICzSwX5CTL7x1lLUTnKA45mPgIKsey5UY2lVYfaC08JseAPclCkXN/JDXOSer93HYlvS5yRCrADh6g673jOWZm0M3l/u5pt5uU1+b6rWhWT6Q8fdp6eG5VTVpveltM6GzOBaTO9OoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453637; c=relaxed/simple;
	bh=t55w1mcoaaGAMC5XxQnXSI+Z5BnivzmiFCBAuKu0hyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB3cBneXFoDimiQ1qsYwMuTZSBzSDho9uZV2b+rJS3K2FiFtu2x3/HW4Waz/ugQI4+2bx914aeBrCQcqQUmDNmWi1CCaTvA2VpIRssn+X1HVifR50zwLu3MW2TVraDl8QDU/b5TtPaDjmeQPhzHWpIkWbYJ31UtDr1huCkJm5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWND95o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E3C4CEE7;
	Tue, 14 Oct 2025 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760453637;
	bh=t55w1mcoaaGAMC5XxQnXSI+Z5BnivzmiFCBAuKu0hyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWND95o5fT67auIvjppHdA+vqXT1+rEl9L8fvOBRmSAh648FeDgX8frpLlriHsLWU
	 C6+pmrRpzggc9+z/KPdme9qRyUi6S0OsMyUWiJlAMFATrkGV4vR9z5oVdPrrOnhwS7
	 bOHB335vK0qTvCce1U1e1JtpMnC38Nue0FYe9nufFoHAY45WeUbXT6wr/UWPoT+dpe
	 eVD/F2UxWyXApL7XI/bCEIpw9uxyiALzlV4p0er+DK2qUu9q7TTHNinXAuPMs7YWTD
	 DNxkZG6GvDtb2KYUp0GgBmqwKemiyN9evrML6iXtQBapNcN+FyhviFYEdaNNUPnNR/
	 /0ghvlq+HnRMw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8gPU-000000004Hk-2UTP;
	Tue, 14 Oct 2025 16:53:56 +0200
Date: Tue, 14 Oct 2025 16:53:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add device ID for U-Blox EVK-M101
Message-ID: <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
References: <20250926060235.3442748-1-cryosay@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926060235.3442748-1-cryosay@gmail.com>

On Fri, Sep 26, 2025 at 09:02:35AM +0300, Oleksandr Suvorov wrote:
> The U-Blox 

Missing product name?

> has a USB Type-C port that presents itself as a USB device
> (1546:0506) [1] with four attached FTDI serial ports, connected to:
> - EVK-M101 current sensors
> - EVK-M101 I2C
> - EVK-M101 UART
> - EVK-M101 port D
> 
> This commit registers U-Blox's VID/PID of this device so that FTDI SIO driver
> successfully registers these 4 serial ports.

Are you sure you should not just register the UART port? Some FTDI chips
support I2C but you'd need a different driver for that.

> [1]
> usb 5-1.3: new high-speed USB device number 11 using xhci_hcd
> usb 5-1.3: New USB device found, idVendor=1546, idProduct=0506, bcdDevice= 8.00
> usb 5-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 5-1.3: Product: EVK-M101
> usb 5-1.3: Manufacturer: u-blox AG
> 
> Datasheet: https://content.u-blox.com/sites/default/files/documents/EVK-M10_UserGuide_UBX-21003949.pdf

The user guide also says "Do not use this COM port" for all ports but
the UART port.

Johan

