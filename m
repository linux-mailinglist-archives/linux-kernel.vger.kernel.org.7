Return-Path: <linux-kernel+bounces-745963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A43B120FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0616D1892A16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA5823ABBB;
	Fri, 25 Jul 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9jQvFoY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D477111;
	Fri, 25 Jul 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457606; cv=none; b=H0cXgA978ePlY+7FFTVnXT1PypmrrJWRSs+1m1rXwwjjwB0r2UZyNF0m8xyD30eJ3+ItLl03Rla5w/AP5bYgy6a0yna0B4H7wwVhGZpXGxBAAd2n72OZSG9fxxG746mIE4XVHvvzZkp2KTOTRpBfcj46LC7AmSSImIMKAC0kaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457606; c=relaxed/simple;
	bh=PzGhuHMIemw+/ZtykxyaEwXt+cBO0RrlcZCozw3CTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIqL1BjQlwp7886gW8w1ShuB4AcV12wT284qff2Ea+wjDHm924sXu5p0QOJbQs+hDKfKuTJf2hzgW4YhC0bN9C5Ouhlqxcb+2TL8lanLgln0SB/vV4zsk18QKFGtPLvmL2XNG/81TZhBcXuaikOKoe268VXieJRKsHYeqr6/Ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9jQvFoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38ECC4CEE7;
	Fri, 25 Jul 2025 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753457606;
	bh=PzGhuHMIemw+/ZtykxyaEwXt+cBO0RrlcZCozw3CTDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9jQvFoYUHKmR27RqhkCNyk7YGmPu1hzAtWS9kgdazW1siD7dSgmpMDMqCq5hDwbY
	 ue2gMEcDhTqldYGmF5NTWqcluzt/onPDsOvqxDCN/sfSd/ba1xlwHOwpliznmrl0WY
	 9wQYqMwaDPiRXxOsADZ/YDh/OvlSn4JcNAlIwobA=
Date: Fri, 25 Jul 2025 17:33:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Olivier Tuchon <tcn@google.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Add gadgetmon traffic monitor
Message-ID: <2025072527-entrust-childless-3ae9@gregkh>
References: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>

Cool, but:

On Fri, Jul 25, 2025 at 05:25:49PM +0200, Olivier Tuchon wrote:
> Signed-off-by: Oliv <tcn@google.com>

Doesn't match the From: line :(

> +config GADGETMON_BUFFER_SIZE_MB
> + int "Buffer size for gadget monitor (in MiB)"
> + depends on USB_GADGET_MON
> + default 4
> + help
> +   Sets the size of the ring buffer used to transfer event data
> +   from the kernel to userspace. A larger buffer reduces the risk
> +   of dropping events during high-speed traffic bursts but uses
> +   more kernel memory. Value is in Megabytes (MiB).

<snip>

Patch is totally corrupted with whitespace issues everywhere, making it
impossible to apply or even review :(

thanks,

greg k-h

