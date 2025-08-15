Return-Path: <linux-kernel+bounces-770218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B9B27890
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B305A1ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BA287268;
	Fri, 15 Aug 2025 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY7QO2ug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FE26A1D0;
	Fri, 15 Aug 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236180; cv=none; b=deaFZBuA+Wm/UDeBSkqksoVR2VOCjm5nTWTFrt/c2vJhtHtEG3bVJLdXG3paJUk2wvxwepH1114lkdPndGEceD126wxzrCl2b0632Fbsb9yrl/YmUtqs5RLFuO9szPZYDfYu0UkrjBH9Y5EjZ+m2qQZ8dExurqW9t1ij68y5Pjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236180; c=relaxed/simple;
	bh=VczQSDc1Si/YxRFdmkWr80lFlzyH1yI4TPitDkCbbVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdY00Gx90hzuQ5nWR2nlsvVSy8Uw4lgYtqwJztt88ggDWY1wfeEQ6d0FjtwjReu3hErYlD3EGtOohyunYjLpVfpug1aK5nV7X7aLs+VGAjKM8FGWFW7Cjyzyt5eAQmSu/fsuZgpitL4qO6b8dLVjKXgrJaXjecaGci8MEZ+hey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY7QO2ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62702C4CEEB;
	Fri, 15 Aug 2025 05:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755236179;
	bh=VczQSDc1Si/YxRFdmkWr80lFlzyH1yI4TPitDkCbbVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY7QO2ugfCDbIlNQKWJeiDfrdUVEOJh6CYvQQFnIpkM2N085QmZPYtaU7KrWBIPTD
	 3fd8nLIRQAiDo7xD/mTio0M6hTUjyz/VqKdt2EaSPLb2qBYRU82rp5XVzpRc7Tkskz
	 eWJXrrr6fjaGK/PPn5IzbU1SAad2jKMqge4us2KY+DXJFQg9vkO/NMywQn+VpIHq0K
	 6Rq+4Ze6UT5kOklaCd5EiJKeoWa32H9eOvAxD5CUJ0cU9nhQLUImbGJDn1MoPAxRky
	 UKebBogfSmGJUW/6Z67TnCT+WeZOTazWV1/3uJWCSHo8U7baAhmeC/UwRAtlLiRW1J
	 aYpkPpvk0ZxUg==
Date: Fri, 15 Aug 2025 05:36:16 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bleung@chromium.org, dawidn@google.com, chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Message-ID: <aJ7HUJ0boqYndbtD@google.com>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
 <20250814091020.1302888-2-tzungbi@kernel.org>
 <DC23GUWD2MYC.1RXVDA2RN7WH3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC23GUWD2MYC.1RXVDA2RN7WH3@kernel.org>

On Thu, Aug 14, 2025 at 12:55:55PM +0200, Danilo Krummrich wrote:
> On Thu Aug 14, 2025 at 11:10 AM CEST, Tzung-Bi Shih wrote:
> As mentioned in a sub-thread [1], this is pretty much what we already do in Rust
> with Revocable [2].
> 
> The Rust struct Devres [3] is built on Revocable, such that a device resource is
> only accessible for drivers as long as the device is actually bound to the
> driver. Once the device is unbound the resource is "revoked" and drivers are
> prevented from subsequent accesses.
> 
> I think it's be good to have a common naming scheme for this, hence I propose to
> name this struct revocable instead.

Sure, will address all review comments and fix in the next version.

> Besides that, I'm not exactly sure I understand why we need two structs for this.
> struct ref_proxy seems unnecessary. I think we should remove it and rename
> struct ref_proxy_provider to struct revocable. Or do I miss anything?

srcu_read_lock() returns an index [4].  The struct ref_proxy is necessary
for tracking the index for leaving the critical section.

[4] https://elixir.bootlin.com/linux/v6.16/source/kernel/rcu/srcutree.c#L750

> > + *
> > + * This holds an initial refcount to the struct.
> > + *
> > + * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
> > + */
> > +struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref)
> 
> The ref_proxy_provider owns the resource now, so when the ref_proxy_provider
> gets revoked (through the devres callback) the resource must be released, right?
> Where is this done? Who is responsible to do so? Shouldn't this function take a
> release callback that is called once the ref_proxy_provider is revoked?

Thank you, that's a valuable suggestion.  While both approaches are valid,
the current implementation is based on a clear separation of ownership.

The design is that struct ref_proxy_provider doesn't own the resource.
Instead, the resource provider (e.g., cros_ec_spi) is responsible for the
full lifecycle:
* It owns and ultimately releases the resource (e.g., [5]).
* It calls ref_proxy_provider_alloc() to expose the resource.
* It calls ref_proxy_provider_free() to revoke access to the resource.

By doing so, the resource provider doesn't need to create a bunch of
void (*release)(void *) callbacks (if multiple resources are exposing).

[5] https://elixir.bootlin.com/linux/v6.16/source/drivers/platform/chrome/cros_ec_spi.c#L752

