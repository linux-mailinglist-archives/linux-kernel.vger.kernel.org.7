Return-Path: <linux-kernel+bounces-722855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FACAFDFE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F43AB76E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC926B756;
	Wed,  9 Jul 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ow5NB9n0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9F1EA73;
	Wed,  9 Jul 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042095; cv=none; b=cE+XTo5HkcHWavp7qp6WXaZXGaW6engTlgD6RCThV7+A0uA75/T4x9seRir9RKTEx49o6G1IGRp8CPrlcynU8KYgJ4rRCMxUlI3Dz5JNs8EIYHO9pOU4bcCYCpz3uI2PV8vWdyauxb+uTzHizkh1TxNqZN+1qWEN+ZFrhSZHsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042095; c=relaxed/simple;
	bh=rBT8nQwnTJbIzPnPrYk673iTg2Po1ieQLy8RmzfbFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY6GQKXxK/3zExGF/MmSdFoBPBqx0Q/VSYJuOTC2CwWwU8YCzf9a0/Y5ngpUo0aPf+UTn4Hn4JHlOtik89E4u2TWnxkUoG7f15GYhZa8ZNFfIzXesGgdFu2VEAUu5wQoZor37sVxa5LWGVbhU6rTIMgV1kyrd4qE26q7s/zNuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ow5NB9n0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C31C4CEF5;
	Wed,  9 Jul 2025 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752042094;
	bh=rBT8nQwnTJbIzPnPrYk673iTg2Po1ieQLy8RmzfbFRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ow5NB9n0SuZbRtv/8/LLwHicv6twv7RoCNUIs8zI0JIBYG53ciXI8gCQAsDBDydU5
	 LhmzFmyAIph31FSBZEJ2OiEXdQvBMVgTwlYW4yJV405ogxUX1RooDZaNhIj3MxdWWD
	 v9FeKwjqWuD2ky1n+i9oDqw51MEzSIyI3NGR2Wk4=
Date: Wed, 9 Jul 2025 08:21:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jie Deng <dengjie03@kylinos.cn>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH v2] usb: storage: Ignore UAS driver for SanDisk Extreme
 Pro 55AF storage device
Message-ID: <2025070902-service-foam-1da5@gregkh>
References: <2025070422-punctured-opal-f51e@gregkh>
 <20250707062507.39531-1-dengjie03@kylinos.cn>
 <2025070702-unsigned-runny-62c6@gregkh>
 <4bac2d53-0e5b-437e-92bc-12921a8efd8d@kylinos.cn>
 <2025070810-nintendo-congenial-95d4@gregkh>
 <92f1e73f-5814-4e01-98b6-1c9c0b87f903@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f1e73f-5814-4e01-98b6-1c9c0b87f903@kylinos.cn>

On Wed, Jul 09, 2025 at 11:40:03AM +0800, Jie Deng wrote:
> 
> 在 2025/7/8 15:33, Greg KH 写道:
> > > 2) linux + arm64: The SanDisk Extreme Pro 55AF device will report an error
> > > when
> > > using the uas driver and the driver cannot be loaded. USB Controller model
> > > (Vendor ID: 1912, Device ID: 0014,uPD720201 USB 3.0 Host Controller).
> > Ok, that sounds like an arm64 issue we should resolve.  Why can the
> > driver not be loaded at all?  What happens?
> 1. During the process of loading the uas driver, the following error message
> will occur,
> resulting in the failure of driver loading:
> scsi 3:0:0:1: Failed to get diagnostic page 0x1
> scsi 3:0:0:1: Failed to bind enclosure -19
> ses 3:0:0:1: Attached Enclosure device
> sd 3:0:0:0: [sda] tag#10 data cmplt err -75 uas-tag 1 inflight: CMD
> sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00
> sd 3:0:0:0: [sda] tag#10 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> sd 3:0:0:0: [sda] tag#10 CDB: Read(10) 28 00 74 6f 6d 00 00 00 08 00

Any chance you can use usbmon to try to figure out why the arm64 system
is sending different commands or failures than x86 is?

thanks,

greg k-h

