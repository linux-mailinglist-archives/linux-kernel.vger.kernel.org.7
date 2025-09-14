Return-Path: <linux-kernel+bounces-815703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FEB56A08
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B3E1725AA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BF2C327D;
	Sun, 14 Sep 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqXld1dp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145C29CE1;
	Sun, 14 Sep 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862551; cv=none; b=tJfFI41Y13LkWCg8N8lZe1t0tqOkhdTya9ip2eolqMb9swzYaGUcrtdxCBxlUZwUJ671JCIT+Ypk/9wTz/QzIdZidHL91/U7vMfl9JoWVLE6d77LnQftmXWgE0u3+ogVlnVvF1YCZWKmMPycq3YX+6UHTtcPCKt+SqW5z+R8Yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862551; c=relaxed/simple;
	bh=b7XeC1cMpBks3HlDxqDTcUhiVwQftxcOd/FabFBh73w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux40pX/M3Qm8V7MAjy6ZC1+q7ecYy50wGiNP3r/6Tr9LXfwuWYJOQhEfR1WqV3og5tFnYbuF6Z/h9HOddEeLm4RQFU32PeFvHvgxS/8uLN8jbe+DULUfag8oKwGu+IyWzTpNWTgsvn5/IrAhaOpcUWjO5GGlcm6tDK3WITmqYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqXld1dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF5C4CEF0;
	Sun, 14 Sep 2025 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757862550;
	bh=b7XeC1cMpBks3HlDxqDTcUhiVwQftxcOd/FabFBh73w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqXld1dpD9yvrn19KwFz8UWaFIsq7BEU7YBFm0cO8ulmLP1MF+RX3w2aXqriSSmxa
	 mpVf3265XSDxz2YEfEaRhyIU7WbaxjBZAq1sxpjuhCfMj2EUJOQIWyWwYQEhAh+iNS
	 GDAk2aqGTVNqzhlfafDauH5SPXUU1r5uUmdgeGvs=
Date: Sun, 14 Sep 2025 17:09:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: rtw_efuse.h: Fix prototype whitespace
Message-ID: <2025091454-popular-overall-9864@gregkh>
References: <20250913112458.910059-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913112458.910059-1-weibu@redadmin.org>

On Sat, Sep 13, 2025 at 08:24:58PM +0900, Akiyoshi Kurita wrote:
> Several function prototypes in rtw_efuse.h contained extra spaces
> between the type and variable name of the last argument.
> 
> Remove these spaces to conform to the kernel coding style.
> No functional change is intended.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This does not apply to my current tree, what did you make it against?

thanks,

greg k-h

