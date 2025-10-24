Return-Path: <linux-kernel+bounces-868791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C69EC06246
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7754A3A4827
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6F3126C9;
	Fri, 24 Oct 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NJIP8zMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB963101D3;
	Fri, 24 Oct 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306813; cv=none; b=ts769PjxzctgmB7piuyEtOsN+YcLpayl0Cp3/i8JHfPDBxuyNhs6jBAZTWxP20o6QoPMSf7p2FsY9wAtbLYju/sP1DQBR2F5kIOl6013BInZST9I/+tXBllXo2dUj3z3QUIbjphjmQ3NpNBi9GXTHCGIVKvz7iMyJxFPlf+o6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306813; c=relaxed/simple;
	bh=7q3v4gpVuyUVt1TJyUHsPLzCqtRce5plJUqhiGvEU20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awePozP12nVNn78mtO5+T4bxAwGh7f2PVG8R8TPh6qPSdXh29sdDGjJYxfFM888jzhXPm1UqRo24aXwUPZ89ZDXOsnJU9uv2c64wIxl9bS23KFnBXDuvnVg94YQunJidX3wL4LYUonS9Y+oaX98gABRPI5Jz8ejHZ856aF//fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NJIP8zMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FDBC4AF0B;
	Fri, 24 Oct 2025 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761306813;
	bh=7q3v4gpVuyUVt1TJyUHsPLzCqtRce5plJUqhiGvEU20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJIP8zMye2Pfa+Bo2R/1fPj3hqRykNXECVvQ7RFlHanwfBu1Wlg/SPeJT8PyvL7lU
	 z097kpOphngS+pxW2JCMxKBzd1WP5I8V103hhmwkE+UZvM6B9MHg12afdYbTJfMCib
	 zrayBIxZLvYLZl2RDThTbzm0AGstb9mAPVcxTTT4=
Date: Fri, 24 Oct 2025 13:53:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial device ids for 6.18-rc3
Message-ID: <2025102417-frail-unhidden-df96@gregkh>
References: <aPs4WBYBNtIKi2dz@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPs4WBYBNtIKi2dz@hovoldconsulting.com>

On Fri, Oct 24, 2025 at 10:27:04AM +0200, Johan Hovold wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.18-rc3

Pulled and pushed out.

thanks,

greg k-h

