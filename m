Return-Path: <linux-kernel+bounces-770217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B265EB2788D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39A51CE6D96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DC28689A;
	Fri, 15 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT7KRW8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174E1E32D7;
	Fri, 15 Aug 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236150; cv=none; b=WM7W2H4r9DezUPW4cLyofAwmne6BHopWPNdDmAJc9uLl9eP8N68EGPRVHeiGsAiZYXPN66ZpNkA80Z1ouW+4WEEiAUHNigSIAwyQJrZh8fg9HcP/sySz70FUgUPwAeIM5bJCCJJ7VAVzYVjPPldDckaR88G89D6drQJ8Pe2EzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236150; c=relaxed/simple;
	bh=/tVVY8INZaKcMRZMjDZBIuTxOqPqw3SIElaeI18TSE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiPkPj6ZJ6jyTJsxCc3s5OJwfMy5VC+kjhxnesbA/A4Icl52PR6y58/4PqhSYMGhwMjy0s26XYCbQ/Oc57UNaZT+MigZGDhbcLf+Vl1NKy6tBwLYtjaW1y8WdbAZYDytc8E6T9yz3aLYWz+MlUd3fmBf9p+ukrCdDyy3bY3C+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT7KRW8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA5FC4CEEB;
	Fri, 15 Aug 2025 05:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755236150;
	bh=/tVVY8INZaKcMRZMjDZBIuTxOqPqw3SIElaeI18TSE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uT7KRW8kJwR/h7l9A9F9HRqm+9NRAAC3gdRmI6EFXJSM4m2eXjvTNUdhEg0m5Emvp
	 hYylF53I32bE1PYC4+DIyQ9NyUIUWx5QbWF+MzkQNv7bO1CVFxeHuTrRkllL1v31Hg
	 RLrOD/vThlY89VuyQ8SKnNnG+JTKz1GYqXviahAZECjpX8n1t5VsBPrj2hrbPMMTW0
	 SkxrHWG+Qtn0OMnmrFIFQH4+UC+erMVjykxUU/6V7Q3uuCKiRaZXAhqItwk3JL9pR3
	 +dVnbVJp6YUpQQaHdStUVxx3Kc7ApEO6CtwgOiJNcuYd7grGYdfYvbraU88uGHzvFt
	 uWwIRY8n/MJKg==
Date: Fri, 15 Aug 2025 05:35:46 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bleung@chromium.org, dawidn@google.com, chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Message-ID: <aJ7HMvh14kQsHjh-@google.com>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
 <20250814091020.1302888-2-tzungbi@kernel.org>
 <2025081408-fracture-happening-dda6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081408-fracture-happening-dda6@gregkh>

On Thu, Aug 14, 2025 at 12:03:11PM +0200, Greg KH wrote:
> On Thu, Aug 14, 2025 at 09:10:18AM +0000, Tzung-Bi Shih wrote:
> > +/**
> > + * devm_ref_proxy_provider_alloc() - Dev-managed ref_proxy_provider_alloc().
> > + * @dev: The device.
> > + * @ref: The pointer of resource.
> > + *
> > + * This holds an initial refcount to the struct.
> > + *
> > + * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
> > + */
> > +struct ref_proxy_provider *devm_ref_proxy_provider_alloc(struct device *dev,
> > +							 void *ref)
> > +{
> > +	struct ref_proxy_provider *rpp;
> > +
> > +	rpp = ref_proxy_provider_alloc(ref);
> > +	if (rpp)
> > +		if (devm_add_action_or_reset(dev, devm_ref_proxy_provider_free,
> > +					     rpp))
> > +			return NULL;
> > +
> > +	return rpp;
> > +}
> > +EXPORT_SYMBOL(devm_ref_proxy_provider_alloc);
> 
> Do we really need a devm version?  That feels odd as this should be
> doing almost the same thing that devm does, right?  How do they interact
> properly?

ref_proxy is similar to devm.  The key difference is their lifetime: a
devm resource is freed when the device detaches, whereas a
ref_proxy_provider persists as long as it has references from ref_proxy.

Since the resource in my use case is provided by the device, it's more
intuitive to tie the resource's lifetime to the device's.

This devm helper further simplifies the provider code.  Otherwise, the
provider needs to call ref_proxy_provider_free() at its error handling
paths or device .remove() callback.

> And do you have a selftest for this thing anywhere?

Will address all review comments and add tests using kselftest and/or KUnit
in the next version.

