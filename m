Return-Path: <linux-kernel+bounces-768516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDDCB261DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA093B53BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237592F7461;
	Thu, 14 Aug 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ylhMlRm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644832E8885;
	Thu, 14 Aug 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165938; cv=none; b=WdIXTS/YDfS90nfx5hLe0YHGONOp+sJTj77PzbcGOCBEUEgTb3wA8NRUKek+6sYX14JD7CxsrGp7KLWdxxbsWEbbQ1f7A2O9hNdH845D+87VzBcIsk7yDPaLsWGtlmZqn0+csueO1fFRZmV/1ZBIddF+FniPVaVreC9tsJe47Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165938; c=relaxed/simple;
	bh=+eyfGjmkdthPdkmZF3lw8nM7Kgf8w5vEKUJs/7iEZMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd7wPz2MM2kFIZA2IUkX2eUl0kYsxm7ezb1J68Ug1hOkpM/pBtfSXYPfXhzo43ZLkwMkwYEE4hApbLzS/Hnz1CvGtneCZL6FntRBp6n1vG/IgOUMMRyZWtIovr4mtPPcLD31+rbqu47zZNzAihtkNakIQ1wv5BXWz179hXtMFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ylhMlRm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAB1C4CEED;
	Thu, 14 Aug 2025 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755165935;
	bh=+eyfGjmkdthPdkmZF3lw8nM7Kgf8w5vEKUJs/7iEZMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ylhMlRm7pzaB8mHfXezd2MOr+cWLjE9h8aqcj/iNewoQc+hXGSbjVc6c9Y1Rv627n
	 C2+JtYNkBG1kBEeQpALdyVmNwPUkF9kknvaFoXpebQNHT+HCAGVS4NpvYLp0KNwOkJ
	 /3DDAqotRkNuTVSOxCrohDQCqOCr2FzH1uEyCLg0=
Date: Thu, 14 Aug 2025 12:05:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: bleung@chromium.org, dawidn@google.com, chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Message-ID: <2025081410-salsa-alabaster-9294@gregkh>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
 <20250814091020.1302888-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814091020.1302888-2-tzungbi@kernel.org>

On Thu, Aug 14, 2025 at 09:10:18AM +0000, Tzung-Bi Shih wrote:
> Some resources can be removed asynchronously, for example, resources
> provided by a hot-pluggable device like USB.  When holding a reference
> to such a resource, it's possible for the resource to be removed and
> its memory freed, leading to use-after-free errors on subsequent access.
> 
> Introduce the ref_proxy library to establish weak references to such
> resources.  It allows a resource consumer to safely attempt to access a
> resource that might be freed at any time by the resource provider.
> 
> The implementation uses a provider/consumer model built on Sleepable
> RCU (SRCU) to guarantee safe memory access:
> 
>  - A resource provider allocates a struct ref_proxy_provider and
>    initializes it with a pointer to the resource.
> 
>  - A resource consumer that wants to access the resource allocates a
>    struct ref_proxy handle which holds a reference to the provider.
> 
>  - To access the resource, the consumer uses ref_proxy_get().  This
>    function enters an SRCU read-side critical section and returns the
>    pointer to the resource.  If the provider has already freed the
>    resource, it returns NULL.  After use, the consumer calls
>    ref_proxy_put() to exit the SRCU critical section.  The
>    REF_PROXY_GET() is a convenient helper for doing that.
> 
>  - When the provider needs to remove the resource, it calls
>    ref_proxy_provider_free().  This function sets the internal resource
>    pointer to NULL and then calls synchronize_srcu() to wait for all
>    current readers to finish before the resource can be completely torn
>    down.

I've added Danilo here, as hopefully this is doing much the same thing
that his rust code does, but I think it's using different names?
Danilo, any ideas if this matches up with what we have in the driver
core rust code now, and would it help out with the drm drivers as well?

thanks,

greg k-h

