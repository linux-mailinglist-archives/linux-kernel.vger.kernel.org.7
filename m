Return-Path: <linux-kernel+bounces-768512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A44B261D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA30A3A3893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E52F60AE;
	Thu, 14 Aug 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Es76mv7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F012264B9;
	Thu, 14 Aug 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165796; cv=none; b=gQAusLmuwcq4xb3rblXC5yyikligvm7gw34V5ogP6zCz9LdFgwujmooHG8QtbBok9tx5NfL8t0e+Z0w8ZocBmW38NHiPaBbNepE74FYbQ3ac5+Df0G2xHuwdIgo0XH8K5KDXVo3nkg3Tr0Am6Jf8ftl+fUVX/IY8tmgSfTbSwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165796; c=relaxed/simple;
	bh=cWCINpggdInFkeAbQHD8L1+lQHe/iNIGyiLz2YXXj8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce82h8wiWp9TG3IHq69yvaveF6lDUTc2EafiIna+lnCXMfI5f9IuwH6XpC2pm9HsxS6RSYAplAlJ/FwbsHRLsE6RNA2KpGSuy0ydKD9LwSyUY4oYgisvi80Jm+qwmvdWg+LW0AD9ccI8dn7AErLstnfYBRyTYUL8QvQM6UeNhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Es76mv7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DFC4CEED;
	Thu, 14 Aug 2025 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755165795;
	bh=cWCINpggdInFkeAbQHD8L1+lQHe/iNIGyiLz2YXXj8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es76mv7en8GltZvEaPeCEcgBt52xAYO5ov4BGgC7Am2kcUh6+lhBD3mgPCxZrtNIH
	 wYBeny8gQSha0hEMbGTCDKbPoJ+F0AwA4NxPWMHXkqPLyyvFGUf5NUb8I3HLIqhtfZ
	 EtJjqQmgcPy9bOu0D60O30i+sEWxWBfuFSZL+q60=
Date: Thu, 14 Aug 2025 12:03:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, dawidn@google.com, chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Message-ID: <2025081408-fracture-happening-dda6@gregkh>
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

Shouldn't this documentation go into the code files as well?  Ideally in
kernel doc format so that everyone can read it in the kernel
documentation output?


> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  include/linux/ref_proxy.h |  37 ++++++++
>  lib/Kconfig               |   3 +
>  lib/Makefile              |   1 +
>  lib/ref_proxy.c           | 184 ++++++++++++++++++++++++++++++++++++++

Who is going to be the maintainer of these new files?

>  4 files changed, 225 insertions(+)
>  create mode 100644 include/linux/ref_proxy.h
>  create mode 100644 lib/ref_proxy.c
> 
> diff --git a/include/linux/ref_proxy.h b/include/linux/ref_proxy.h
> new file mode 100644
> index 000000000000..16ff29169272
> --- /dev/null
> +++ b/include/linux/ref_proxy.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

No copyright line?  That's bold, given your employer's normal rules :)

> +
> +#ifndef __LINUX_REF_PROXY_H
> +#define __LINUX_REF_PROXY_H
> +
> +#include <linux/cleanup.h>
> +
> +struct device;
> +struct ref_proxy;
> +struct ref_proxy_provider;
> +
> +struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref);
> +void ref_proxy_provider_free(struct ref_proxy_provider *rpp);
> +struct ref_proxy_provider *devm_ref_proxy_provider_alloc(struct device *dev,
> +							 void *ref);
> +
> +struct ref_proxy *ref_proxy_alloc(struct ref_proxy_provider *rpp);
> +void ref_proxy_free(struct ref_proxy *proxy);
> +void __rcu *ref_proxy_get(struct ref_proxy *proxy);
> +void ref_proxy_put(struct ref_proxy *proxy);
> +
> +DEFINE_FREE(ref_proxy, struct ref_proxy *, if (_T) ref_proxy_put(_T))
> +
> +#define _REF_PROXY_GET(_proxy, _name, _label, _ref) \
> +	for (struct ref_proxy *_name __free(ref_proxy) = _proxy;	\
> +	     (_ref = ref_proxy_get(_name)) || true; ({ goto _label; }))	\
> +		if (0) {						\
> +_label:									\
> +			break;						\
> +		} else
> +
> +#define REF_PROXY_GET(_proxy, _ref)					\
> +	_REF_PROXY_GET(_proxy, __UNIQUE_ID(proxy_name),			\
> +		       __UNIQUE_ID(label), _ref)
> +
> +#endif /* __LINUX_REF_PROXY_H */
> +
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c483951b624f..18237a766606 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -583,6 +583,9 @@ config STACKDEPOT_MAX_FRAMES
>  	default 64
>  	depends on STACKDEPOT
>  
> +config REF_PROXY
> +	bool
> +
>  config REF_TRACKER
>  	bool
>  	depends on STACKTRACE_SUPPORT
> diff --git a/lib/Makefile b/lib/Makefile
> index 392ff808c9b9..e8ad6f67cee9 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -258,6 +258,7 @@ KASAN_SANITIZE_stackdepot.o := n
>  KMSAN_SANITIZE_stackdepot.o := n
>  KCOV_INSTRUMENT_stackdepot.o := n
>  
> +obj-$(CONFIG_REF_PROXY) += ref_proxy.o
>  obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
>  
>  libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
> diff --git a/lib/ref_proxy.c b/lib/ref_proxy.c
> new file mode 100644
> index 000000000000..49940bea651c
> --- /dev/null
> +++ b/lib/ref_proxy.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>

As this deals with struct device, shouldn't it go into drivers/base/ ?

> +#include <linux/kref.h>
> +#include <linux/ref_proxy.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +
> +/**
> + * struct ref_proxy_provider - A handle for resource provider.
> + * @srcu: The SRCU to protect the resource.
> + * @ref:  The pointer of resource.  It can point to anything.
> + * @kref: The refcount for this handle.
> + */
> +struct ref_proxy_provider {
> +	struct srcu_struct srcu;
> +	void __rcu *ref;
> +	struct kref kref;
> +};
> +
> +/**
> + * struct ref_proxy - A handle for resource consumer.
> + * @rpp: The pointer of resource provider.
> + * @idx: The index for the RCU critical section.
> + */
> +struct ref_proxy {
> +	struct ref_proxy_provider *rpp;
> +	int idx;
> +};
> +
> +/**
> + * ref_proxy_provider_alloc() - Allocate struct ref_proxy_provider.
> + * @ref: The pointer of resource.
> + *
> + * This holds an initial refcount to the struct.
> + *
> + * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
> + */
> +struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref)
> +{
> +	struct ref_proxy_provider *rpp;
> +
> +	rpp = kzalloc(sizeof(*rpp), GFP_KERNEL);
> +	if (!rpp)
> +		return NULL;
> +
> +	init_srcu_struct(&rpp->srcu);
> +	rcu_assign_pointer(rpp->ref, ref);
> +	synchronize_srcu(&rpp->srcu);
> +	kref_init(&rpp->kref);
> +
> +	return rpp;
> +}
> +EXPORT_SYMBOL(ref_proxy_provider_alloc);

EXPORT_SYMBOL_GPL()?  I have to ask.

> +
> +static void ref_proxy_provider_release(struct kref *kref)
> +{
> +	struct ref_proxy_provider *rpp = container_of(kref,
> +			struct ref_proxy_provider, kref);
> +
> +	cleanup_srcu_struct(&rpp->srcu);
> +	kfree(rpp);
> +}
> +
> +/**
> + * ref_proxy_provider_free() - Free struct ref_proxy_provider.
> + * @rpp: The pointer of resource provider.
> + *
> + * This sets the resource `(struct ref_proxy_provider *)->ref` to NULL to
> + * indicate the resource has gone.
> + *
> + * This drops the refcount to the resource provider.  If it is the final
> + * reference, ref_proxy_provider_release() will be called to free the struct.
> + */
> +void ref_proxy_provider_free(struct ref_proxy_provider *rpp)
> +{
> +	rcu_assign_pointer(rpp->ref, NULL);
> +	synchronize_srcu(&rpp->srcu);
> +	kref_put(&rpp->kref, ref_proxy_provider_release);
> +}
> +EXPORT_SYMBOL(ref_proxy_provider_free);
> +
> +static void devm_ref_proxy_provider_free(void *data)
> +{
> +	struct ref_proxy_provider *rpp = data;
> +
> +	ref_proxy_provider_free(rpp);
> +}
> +
> +/**
> + * devm_ref_proxy_provider_alloc() - Dev-managed ref_proxy_provider_alloc().
> + * @dev: The device.
> + * @ref: The pointer of resource.
> + *
> + * This holds an initial refcount to the struct.
> + *
> + * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
> + */
> +struct ref_proxy_provider *devm_ref_proxy_provider_alloc(struct device *dev,
> +							 void *ref)
> +{
> +	struct ref_proxy_provider *rpp;
> +
> +	rpp = ref_proxy_provider_alloc(ref);
> +	if (rpp)
> +		if (devm_add_action_or_reset(dev, devm_ref_proxy_provider_free,
> +					     rpp))
> +			return NULL;
> +
> +	return rpp;
> +}
> +EXPORT_SYMBOL(devm_ref_proxy_provider_alloc);

Do we really need a devm version?  That feels odd as this should be
doing almost the same thing that devm does, right?  How do they interact
properly?

And do you have a selftest for this thing anywhere?

thanks,

greg k-h

