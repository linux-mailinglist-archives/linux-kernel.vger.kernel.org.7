Return-Path: <linux-kernel+bounces-723384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EEAFE651
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73043BD892
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255002D3ECB;
	Wed,  9 Jul 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PWz3Ieph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC47292B2B;
	Wed,  9 Jul 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057818; cv=none; b=G8FR6r5iVQuMcIJ2wXXhAXigvMtwVH6qb4IeQpW3IOED3HlqilPZ69VKEGo2yJ3LD3k/KLCBaPRgISJ5ykR+yvGBT/LFe8w7V+7+JRVxcHCy0Z+iDpKSLyVf24x0QtCuATJ/3nAmpBBtoulBbao2fhRFr3fP5qKckMtjtVE7hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057818; c=relaxed/simple;
	bh=twXd8N8lzYTbIWjcbttCD/aol76Eziq24hCDka0ZwME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv7oKFFY1VbZ2DbnAwtEKStZhZCXMIaIrhB7P2gPkomQkfFdZY4STriiCb3dW/UXol9YOoHsne17TdqhLVNQ4zlQVPKFzz1GDTAubnyafMZXnFiieSzFGeBjgpyVaMO7Vv2Yknp6Lthhv8EpHLegvCpatPWIBQjijYrJCzD/DOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PWz3Ieph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2486C4CEF5;
	Wed,  9 Jul 2025 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752057818;
	bh=twXd8N8lzYTbIWjcbttCD/aol76Eziq24hCDka0ZwME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWz3IephkDj6KNKpqePyn/Z1xlvJu2q2aUDZxLIxrCaaZgqpEIckEFRgIdD7ziB4c
	 3AmPSegzqI6sDFH7YUu7eRnbkd4DL7TpVkG5PeEHmPidSgwq4o2+ltzKUczw5WvuaL
	 MqLM/bxykgfmc8T1fA+sdaeTYFt0ciuhjW9/qdQg=
Date: Wed, 9 Jul 2025 12:43:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial device id for 6.16-rc6
Message-ID: <2025070928-laziness-plenty-2444@gregkh>
References: <aG5Axw9ZRN5_NNDq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG5Axw9ZRN5_NNDq@hovoldconsulting.com>

On Wed, Jul 09, 2025 at 12:13:27PM +0200, Johan Hovold wrote:
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:
> 
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.16-rc6

Pulled and pushed out, thanks.

greg k-h

