Return-Path: <linux-kernel+bounces-768649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4CB263B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C573B9C67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF292FB97B;
	Thu, 14 Aug 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQz9SC6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C1318123;
	Thu, 14 Aug 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168959; cv=none; b=M+IHrcAbz3wd3x/HWg4ZqBLIs/Ia6DGsY5AgbGSWFkFCuE6PhPzdI1mrL6CwPRiufef7jIVvwR4iwVCtq2dsb0Bz2UMfXa2Sm6yJItBLiFVN+cTYpGxO4Mti923hmugBVu7HT7NuG2r3ViETRAr3+bmiFfF+/FC/rUoWEGivKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168959; c=relaxed/simple;
	bh=OEIR6o3ChxKvnRJSRPXYFNUGeRIDtYaQdUPWwcQIsVA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CupXLk150QKBYWZx65xODG21ehGmrcVsJBeiPfzZbVtLMAji3lfAHMSrgbGaDWPYywtLSS+ojV7XTDNxI9+ChWT5kcleACJHAAklJ6/HKaiKFp0I0OLM12VU1VnAU2CQFrYB67+5+6Iw9ZMhehRA5OqRmzvaO1cRYf9vmtv3unI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQz9SC6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6998EC4CEED;
	Thu, 14 Aug 2025 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755168958;
	bh=OEIR6o3ChxKvnRJSRPXYFNUGeRIDtYaQdUPWwcQIsVA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pQz9SC6kOjWd7DBR/js5i8ADSB6ioVxpqKdE7jctE57CBWt+3pbh6c0jgT0LUSu+o
	 uiH/LAwN2eQLpWMzLEFfE8SEOecKOw019//1xZ3EC9gUFHb3+uuj66K85BFsbucYnI
	 /4nA8pe7HcAIK81DnEzAO7qk0YtAc8PeyK+Aq0DDYtjD/ckyMbJlmdhsp5mR9SKk+v
	 zREmtGo50O3/wiiB4KBRy3mRhVolropRpr0f1lPnm2uQWt2mVCu6+aDHALdCLJwgys
	 OuGp+PIFYi0em1FD+kI9i0/44YrPYkClEOmedTTvWNPnIgnfuJ1sdr8CwxHyKQAKWl
	 aM7dx86IL3V+g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 12:55:55 +0200
Message-Id: <DC23GUWD2MYC.1RXVDA2RN7WH3@kernel.org>
Subject: Re: [PATCH 1/3] lib: Add ref_proxy module
Cc: <bleung@chromium.org>, <dawidn@google.com>,
 <chrome-platform@lists.linux.dev>, <akpm@linux-foundation.org>,
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
 <20250814091020.1302888-2-tzungbi@kernel.org>
In-Reply-To: <20250814091020.1302888-2-tzungbi@kernel.org>

On Thu Aug 14, 2025 at 11:10 AM CEST, Tzung-Bi Shih wrote:
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

As mentioned in a sub-thread [1], this is pretty much what we already do in=
 Rust
with Revocable [2].

The Rust struct Devres [3] is built on Revocable, such that a device resour=
ce is
only accessible for drivers as long as the device is actually bound to the
driver. Once the device is unbound the resource is "revoked" and drivers ar=
e
prevented from subsequent accesses.

I think it's be good to have a common naming scheme for this, hence I propo=
se to
name this struct revocable instead.

Besides that, I'm not exactly sure I understand why we need two structs for=
 this.
struct ref_proxy seems unnecessary. I think we should remove it and rename
struct ref_proxy_provider to struct revocable. Or do I miss anything?

I think it would also be nice to have some more high level documentation on=
 how
it works and how it interacts with devres in the source file, which should =
be
referenced in Documentation/.

[1] https://lore.kernel.org/lkml/DC22V4IMAJ1Q.3HJUK21LRN5D5@kernel.org/
[2] https://rust.docs.kernel.org/kernel/revocable/struct.Revocable.html
[3] https://rust.docs.kernel.org/kernel/devres/struct.Devres.html

> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  include/linux/ref_proxy.h |  37 ++++++++
>  lib/Kconfig               |   3 +
>  lib/Makefile              |   1 +
>  lib/ref_proxy.c           | 184 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 225 insertions(+)
>  create mode 100644 include/linux/ref_proxy.h
>  create mode 100644 lib/ref_proxy.c

I think we should name this revocable and move it to drivers/base/.

> diff --git a/lib/ref_proxy.c b/lib/ref_proxy.c
> new file mode 100644
> index 000000000000..49940bea651c
> --- /dev/null
> +++ b/lib/ref_proxy.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>
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

We should call the pointer res if it's the pointer to the resource.

> + *
> + * This holds an initial refcount to the struct.
> + *
> + * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
> + */
> +struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref)

The ref_proxy_provider owns the resource now, so when the ref_proxy_provide=
r
gets revoked (through the devres callback) the resource must be released, r=
ight?
Where is this done? Who is responsible to do so? Shouldn't this function ta=
ke a
release callback that is called once the ref_proxy_provider is revoked?

> +{
> +	struct ref_proxy_provider *rpp;
> +
> +	rpp =3D kzalloc(sizeof(*rpp), GFP_KERNEL);
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
> +
> +static void ref_proxy_provider_release(struct kref *kref)
> +{
> +	struct ref_proxy_provider *rpp =3D container_of(kref,
> +			struct ref_proxy_provider, kref);
> +
> +	cleanup_srcu_struct(&rpp->srcu);

As mentioned above, why aren't we releasing the resource here?

> +	kfree(rpp);
> +}
> +
> +/**
> + * ref_proxy_provider_free() - Free struct ref_proxy_provider.
> + * @rpp: The pointer of resource provider.
> + *
> + * This sets the resource `(struct ref_proxy_provider *)->ref` to NULL t=
o
> + * indicate the resource has gone.
> + *
> + * This drops the refcount to the resource provider.  If it is the final
> + * reference, ref_proxy_provider_release() will be called to free the st=
ruct.
> + */
> +void ref_proxy_provider_free(struct ref_proxy_provider *rpp)
> +{
> +	rcu_assign_pointer(rpp->ref, NULL);
> +	synchronize_srcu(&rpp->srcu);

This is called for *every* resource that has been registered with the
ref_proxy_provider for a certain device when it is unbound.

We have the same problem in Rust, and I have a task on my list to address t=
his.
Please see my reply in the sub-thread.

> +	kref_put(&rpp->kref, ref_proxy_provider_release);
> +}
> +EXPORT_SYMBOL(ref_proxy_provider_free);

<snip>

> +/**
> + * ref_proxy_get() - Get the resource.
> + * @proxy: The pointer of struct ref_proxy.
> + *
> + * This tries to de-reference to the resource and enters a RCU critical
> + * section.
> + *
> + * Return: The pointer to the resource.  NULL if the resource has gone.
> + */
> +void __rcu *ref_proxy_get(struct ref_proxy *proxy)

We should call this try_access() rather than get().

> +{
> +	struct ref_proxy_provider *rpp =3D proxy->rpp;
> +
> +	proxy->idx =3D srcu_read_lock(&rpp->srcu);
> +	return rcu_dereference(rpp->ref);
> +}
> +EXPORT_SYMBOL(ref_proxy_get);
> +
> +/**
> + * ref_proxy_put() - Put the resource.
> + * @proxy: The pointer of struct ref_proxy.
> + *
> + * Call this function to indicate the resource is no longer used.  It ex=
its
> + * the RCU critical section.
> + */
> +void ref_proxy_put(struct ref_proxy *proxy)

I think this should rather be something like release() instead. We're not
dropping a reference count, but releasing a lock.

> +{
> +	struct ref_proxy_provider *rpp =3D proxy->rpp;
> +
> +	srcu_read_unlock(&rpp->srcu, proxy->idx);
> +}
> +EXPORT_SYMBOL(ref_proxy_put);
> --=20
> 2.51.0.rc1.163.g2494970778-goog


