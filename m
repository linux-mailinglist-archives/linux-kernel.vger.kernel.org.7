Return-Path: <linux-kernel+bounces-828540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D281B94D72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F891903AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF823164A1;
	Tue, 23 Sep 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1EIxkJC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB11ACEDF;
	Tue, 23 Sep 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613443; cv=none; b=tGp/5oFb8EPyWfeyvgQ30+YGwYFGR4kBp/KezVaha+4kVEcKb1ALYsThYgHDzAeaHHSVLIktLjRkGSzYFZZC/IuzJA4o18y4V1MnqBOVmKfRR+alX12oy3waqBukA9ZYhWgkZpLU0m2uAcRUnmpy4rlv3tpGl0Us6IK7HKbWVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613443; c=relaxed/simple;
	bh=dKle1o6bbfcAMAKszGbEL8O+PYLJPoHmt8GU7LeMrhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6eWwbY7QH/+mi2cT9H5oGnArvqTxAw9P6mUCKQNpSvbFsYPcQsqTJBtPxLBWJEIyoffgfB0WwmB6slAGLxVQ+P21Z7r8DmbLziAHFFunhkoPDBiweIXL65aU1uc2snLjnZzsHC0oi+zXXB0hoFCI5Wy2fVMculyzPGXHt56iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1EIxkJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619FCC4CEF5;
	Tue, 23 Sep 2025 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758613442;
	bh=dKle1o6bbfcAMAKszGbEL8O+PYLJPoHmt8GU7LeMrhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1EIxkJCq7n4Z/SKlvcN7jzd45EXiwTv5aRY5b1/mkFi6ZWhHlLXmVeIGZ5jfLMK8
	 ttTWgAxgU4+bnp3p1Ujyqn5IHjBAM7SlPjnNgIXob1o+AqXLn7z4blbOiIf21y8oSp
	 hUqOzctHinLShgfOJKAAqe5oMqhzsjzPWyv9J69xK9/F0NcE8TLSesZjotCZvtzBVZ
	 1dyAHl0+Sc2azELimeXGUp4aGvn+ZWeOx6yV1aB/sCVqf1C8ytRYoqzN7JQmMuwUBY
	 eT3MNxJjM749RBfgq09aRhlt86QAYaWs0QgHSNmM0TI2wAQkav4VyYYhcDknhDTl7E
	 0SCyDv4vKjhAQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0xgp-000000001gL-0Uth;
	Tue, 23 Sep 2025 09:43:55 +0200
Date: Tue, 23 Sep 2025 09:43:55 +0200
From: Johan Hovold <johan@kernel.org>
To: "xiaowei.li" <xiaowei.li@simcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add SIMCom 8230C compositions
Message-ID: <aNJPuwDMsf5Pyepy@hovoldconsulting.com>
References: <20250917105342.2687371-1-xiaowei.li@simcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917105342.2687371-1-xiaowei.li@simcom.com>

On Wed, Sep 17, 2025 at 06:53:42PM +0800, xiaowei.li wrote:

Thanks for the v2.

Checkpatch complains that your From (author) name does not match you
SoB (a period '.' instead of space and no capitalisation). Could you fix
your mailer (or add a From line to the patch) so that the author
information in the logs will look correct?

Please consider adding an introductory sentence here (e.g. "Add the
following compositions for device X:").

> USB Device Listings:

> Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
> ---

And when updating patches you should put a short changelog here under
the --- line.

>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index fc869b7f803f..8eadcfe33ecd 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
>  	  .driver_info = RSVD(7) },
> +	{ USB_DEVICE(0x1e0e, 0x9071),
> +	  .driver_info = RSVD(3) | RSVD(4) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
> +	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
> +	  .driver_info = RSVD(5) },

And please add a comment after these entries with the device and mode
(like the surrounding entries have).

>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>  	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),

Looks all good otherwise.

Johan

