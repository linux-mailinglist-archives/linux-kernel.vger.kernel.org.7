Return-Path: <linux-kernel+bounces-791371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB25B3B60D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C74360454
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3625287511;
	Fri, 29 Aug 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGYoVGdV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48427283FE6;
	Fri, 29 Aug 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456366; cv=none; b=Onpmx8RwSzQnwO21k2u88pwZzLbpTGHDN5YxvHZAXqvR7vLYuffQB7VKfx+h/ZbZw5h2jKPHWtM6pMU3wWG1pnRTmAohxbxDim7tX1la8fLsQ6YPH421K0hFUwABdmYBx1h431XbqEkxAaVENa07dF5JN1bku4LbnihXZMRGd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456366; c=relaxed/simple;
	bh=4PcuuFzK9AF3nGXEXNZUTLYmHDYdlG+s/DZVUaLCjE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB3kxgVTOFLQldw4IAhWzJsvJS/xZh3oS1pchplPGubc+hfoewrSOE4iRZAPnzZLAFxSui/6IWtAXM1HsksPutQjOe0VKCbaplOeQOPb9NS4Pp8esypYVZbsyN4RDb8UJcFQwjk5X3Mp17yZtYXXYEFXk2EA0Ice5jYa9wXQR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGYoVGdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68007C4CEF0;
	Fri, 29 Aug 2025 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756456365;
	bh=4PcuuFzK9AF3nGXEXNZUTLYmHDYdlG+s/DZVUaLCjE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGYoVGdVvApDzyfQdRBwK6YgNiHg6tX1DvpjGxy3zV1fWayhe0yyg5JyblcFxET4b
	 dBWKHpykb/vtmTKtQVjQvWoIEgb21Aq/S7s1EHSoN0lnNmemPdrHtUMNfYtkK9+1Nd
	 7baXoF9pAEzQAiZp0z93M4iaMM36fpNQOn5Jxbdc=
Date: Fri, 29 Aug 2025 10:32:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: storage: realtek_cr: Simplify residue
 calculation in rts51x_bulk_transport()
Message-ID: <2025082913-expire-crazed-bee1@gregkh>
References: <20250828162623.4840-3-thorsten.blum@linux.dev>
 <2025082922-almanac-derby-632d@gregkh>
 <7B58E620-723A-41D3-9EA2-81159009A818@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B58E620-723A-41D3-9EA2-81159009A818@linux.dev>

On Fri, Aug 29, 2025 at 09:10:00AM +0200, Thorsten Blum wrote:
> On 29. Aug 2025, at 06:34, Greg Kroah-Hartman wrote:
> > On Thu, Aug 28, 2025 at 06:26:24PM +0200, Thorsten Blum wrote:
> >> Simplify the calculation of 'residue' in rts51x_bulk_transport() and
> >> avoid unnecessarily reassigning 'residue' to itself.
> >> 
> >> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> > Why is this a RESEND?  What happened to the first one?
> 
> This was patch 2/3 of a patch series that doesn't apply anymore because
> you asked me to submit the bugfix in patch 3/3 separately [1].
> 
> Since the series doesn't apply anymore and patch 1/3 didn't get any
> support [2], I figured it's best to resend this one as a separate patch.
> 
> Thanks,
> Thorsten
> 
> [1] https://lore.kernel.org/lkml/2025081358-posted-ritzy-bd3f@gregkh/
> [2] https://lore.kernel.org/lkml/20250813101249.158270-2-thorsten.blum@linux.dev/
> 

Ah, that's better, you should have put that below the --- line to make
it more obvious as I didn't remember that at all :)

thanks,

greg k-h

