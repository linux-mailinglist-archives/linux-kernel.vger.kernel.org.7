Return-Path: <linux-kernel+bounces-733457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B54B074E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E623BDDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40E2F3C20;
	Wed, 16 Jul 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbxrXZop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FD3C33;
	Wed, 16 Jul 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665916; cv=none; b=WyeTkzlpuRdK1XSNlHl3etWN1GbveKCMldab6dnOHjlZjjqKdah6tv2VOmY3M26tHy9Je6EMt6FhcGGX5Cf7F9iZWEnrw/sc8LbioBbmHBofC23lhPri+1/Efo8oopEwYs4jOQIUN8Mp2iU2rhPLKUwZ07Ypu4DQ8PeOlT4ThIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665916; c=relaxed/simple;
	bh=aYdt8vGzptRRAO8yvatFkySIBrpm7hzEWvJLVWm7IhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXAinxRr76E7jwFdF7TPibI9kTSYt6+PuWO1G5tUMTr2yeOcH2ym60xplvtBWctyYTdynzvPDwo8pbOTqzNVY/S1in6IJ0JUWqDFzVCrR0YcSYVlH343hE9yv4AlGQSM4+hQzS/ogPaZ0fnTKZikFSzyoLYB1AEv5ZPzcYmF9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vbxrXZop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704F6C4CEF0;
	Wed, 16 Jul 2025 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752665914;
	bh=aYdt8vGzptRRAO8yvatFkySIBrpm7hzEWvJLVWm7IhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vbxrXZop0xLAJnO+POp93AJjjCLGckg43qzRwBuOgK5TI/GOUm0mt2og3RPqZwAmq
	 qGmei+mYeJ1n7jRAQqULbWadMpOAWC1P7Ibymc/yysUU3n0UR2baCoX1vQLxBKwgvy
	 BmNCXaMc+OtCinQDdoNTXJIWXGNvcfl3YeZN6ELU=
Date: Wed, 16 Jul 2025 13:38:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-spdx@vger.kernel.org
Subject: Re: [PATCH] LICENSES: Replace the obsolete address of the FSF
Message-ID: <2025071620-economy-unifier-b5aa@gregkh>
References: <20250711054548.195276-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711054548.195276-1-thuth@redhat.com>

On Fri, Jul 11, 2025 at 07:45:48AM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The FSF does not reside in the Franklin street anymore. Let's update
> the address with the link to their website, as suggested in the latest
> revisions of their licenses.
> (See https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for example)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  LICENSES/deprecated/GPL-1.0 |  6 +++---
>  LICENSES/preferred/GPL-2.0  | 10 ++++------
>  LICENSES/preferred/LGPL-2.0 |  5 ++---
>  LICENSES/preferred/LGPL-2.1 |  8 ++++----
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/LICENSES/deprecated/GPL-1.0 b/LICENSES/deprecated/GPL-1.0
> index 3a4fa969e4c29..8d0a75431f06d 100644
> --- a/LICENSES/deprecated/GPL-1.0
> +++ b/LICENSES/deprecated/GPL-1.0
> @@ -14,7 +14,8 @@ License-Text:
>  	     Version 1, February 1989
>  
>   Copyright (C) 1989 Free Software Foundation, Inc.
> -                    675 Mass Ave, Cambridge, MA 02139, USA
> +                    <https://fsf.org/>
> +

Nit, this change, differs from this one:

> --- a/LICENSES/preferred/GPL-2.0
> +++ b/LICENSES/preferred/GPL-2.0
> @@ -20,8 +20,8 @@ License-Text:
>  		    GNU GENERAL PUBLIC LICENSE
>  		       Version 2, June 1991
>  
> - Copyright (C) 1989, 1991 Free Software Foundation, Inc.
> -                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
> + <https://fsf.org/>
>   Everyone is permitted to copy and distribute verbatim copies
>   of this license document, but changing it is not allowed.
>  

Ah, wait, that's what the FSF did on their site, ugh.

How about make this 4 patches, one for each file, include a link to
where each of the changes came from (you only have one link in the
changelog.)

Just to be explicit here.

thanks,

greg k-h

