Return-Path: <linux-kernel+bounces-781118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CDB30DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CE51CE226C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59E28505F;
	Fri, 22 Aug 2025 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNjVlHSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AA393DE4;
	Fri, 22 Aug 2025 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838258; cv=none; b=g7CdWvBjxQVt2zTnugkbhOEqD/7mvWGLxs50N5LR3LZ9AP9YSit/dCmuECg5j1RiBhaLqlTvP4GcT/F/gB1OHsIttGxrDJKiQKGr6xb3qH7+z1C4dfPgcMY5fLVmpkqzliZTjHVoDee69CUmOzC9HgFI7apJOsyT5EIdW0yfQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838258; c=relaxed/simple;
	bh=i3k/njmSG+CSa2Q1AE8wBP5TuoWTEkfqTVfsA9tza3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B95Gci8HzY2p1ou7lnYQpkzw6Wwy9fQsa9EeGVUqDj7kOkQ6HZV2RZaxSiB0OUt/wXyc3Rrkoik83j2S4EhckxS4z9bXBmvInXso6mynLHSlq3adzgjGCwhOsQScLMEmg4i4polDegpg3Ce8mmo5Z7WdEXHo6uHyuIPQkrhP91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNjVlHSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52639C4CEF1;
	Fri, 22 Aug 2025 04:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755838257;
	bh=i3k/njmSG+CSa2Q1AE8wBP5TuoWTEkfqTVfsA9tza3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNjVlHSKuV8DaeiSf3nNJgBGkGW2z9psrCt2sN2Pg/ZK7ZBGQdZDi6QhK4Lqc3yc9
	 Rb9SFI7bRSCANnkXrY27O3GxfjOt/JcDOZHJz+fOWxcXHZt/miGLPnKPHrX9U+yUYF
	 WkuQJPY/D2Zjgmi+wS9iJrQzvXW9169xZTRkCaWQ=
Date: Fri, 22 Aug 2025 06:50:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Wu <william.wu@rock-chips.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: Re: [PATCH] usb: gadget: configfs: Correctly set use_os_string at
 bind
Message-ID: <2025082244-celery-frenzy-2a70@gregkh>
References: <1755833769-25434-1-git-send-email-william.wu@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755833769-25434-1-git-send-email-william.wu@rock-chips.com>

On Fri, Aug 22, 2025 at 11:36:09AM +0800, William Wu wrote:
> Once the use_os_string flag is set to true for some functions
> (e.g. adb/mtp) which need to response the OS string, and then
> if we re-bind the ConfigFS gadget to use the other functions
> (e.g. hid) which should not to response the OS string, however,
> because the use_os_string flag is still true, so the usb gadget
> response the OS string descriptor incorrectly, this can cause
> the USB device to be unrecognizable on the Windows system.
> 
> An example of this as follows:
> 
> echo 1 > os_desc/use
> ln -s functions/ffs.adb configs/b.1/function0
> start adbd
> echo "<udc device>" > UDC   #succeed
> 
> stop adbd
> rm configs/b.1/function0
> echo 0 > os_desc/use
> ln -s functions/hid.gs0 configs/b.1/function0
> echo "<udc device>" > UDC  #fail to connect on Windows
> 
> This patch sets the use_os_string flag to false at bind if
> the functions not support OS Descriptors.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>

What commit id does this fix?

thanks,

greg k-h

