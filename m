Return-Path: <linux-kernel+bounces-721054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E966AFC420
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BE33A1C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD8298CA7;
	Tue,  8 Jul 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1UKY1my"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B98220F38;
	Tue,  8 Jul 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960002; cv=none; b=NbjHe5d4UA8GLc7kb9Jo1rlbJwH2XhKTYTZoby4wwadso4/VbM9YPOOMV8/MIYZEABSPfQY1nbdbxmEipFgphGxgPwrcGUfuD4uw5qfUNE4E6q2PLKuthXWjteyRx00HdSNqObYdq+t/fOBsAQ8g4bruAjkckxyOJX9/Kn7Ww5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960002; c=relaxed/simple;
	bh=aKRhOcZ8Qjp0Em2Ph5UFHo25AahL0FqSJQPHHtZj0g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIM2q416SeRnVIE/Utln7X6MGZhKHdUOcHzdGR6tZchTzer8QapULmn303+cwXxDDYhB1QhtNAB6YFsIRskSjwRxaHnM0GQ9eNz3Q5lWDBej+adUL3/cZr0xJOxeVRlVfB0b73dHluiQF1Ua5uTe0ItTsLx6QjrrTWc1zup9ASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1UKY1my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADF4C4CEF1;
	Tue,  8 Jul 2025 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751960001;
	bh=aKRhOcZ8Qjp0Em2Ph5UFHo25AahL0FqSJQPHHtZj0g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x1UKY1myZUr+KAU6chYYab3h3jg6fIL2z8tX/L2pCGMOTnEyMP0gt27vi+vueZnoh
	 1T3Ok8kB6kvtxvFdo8kVt6m49zuWbdIfgwP66GhChNO1zgpu6RP6v1UYeL2fLqLXtw
	 IO2YIOK0zi4xN5KHoiGu8ck8YqslapQKnuEri3Rk=
Date: Tue, 8 Jul 2025 09:33:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jie Deng <dengjie03@kylinos.cn>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2] usb: storage: Ignore UAS driver for SanDisk Extreme
 Pro 55AF storage device
Message-ID: <2025070810-nintendo-congenial-95d4@gregkh>
References: <2025070422-punctured-opal-f51e@gregkh>
 <20250707062507.39531-1-dengjie03@kylinos.cn>
 <2025070702-unsigned-runny-62c6@gregkh>
 <4bac2d53-0e5b-437e-92bc-12921a8efd8d@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bac2d53-0e5b-437e-92bc-12921a8efd8d@kylinos.cn>

On Tue, Jul 08, 2025 at 01:55:47PM +0800, Jie Deng wrote:
> 2. Regarding your question, before submitting the patch,
> I conducted the following tests:
> 1) linux + x86: The SanDisk Extreme Pro 55AF device can be recognized
> normally when using the uas driver. USB controller model (VendorID:
> 1D94, DeviceID: 145F,Chengdu Haiguang IC Design Co., Ltd.USB 3.0 Host
> controller)

So it all works, great!

> 2) linux + arm64: The SanDisk Extreme Pro 55AF device will report an error
> when
> using the uas driver and the driver cannot be loaded. USB Controller model
> (Vendor ID: 1912, Device ID: 0014,uPD720201 USB 3.0 Host Controller).

Ok, that sounds like an arm64 issue we should resolve.  Why can the
driver not be loaded at all?  What happens?

> 3) linux + arm64: Add the parameter "USB-storage.quirks =0781:55af:u" in
> grub.
> The SanDisk Extreme Pro 55AF device runs the usb storage driver without any
> error
> and can be recognized normally.

Let's track down and fix the arm64 issue here please, and not paper over
it by saying that this whole device will not work well on all arches.

thakns,

greg k-h

