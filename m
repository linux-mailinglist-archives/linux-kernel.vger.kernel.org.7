Return-Path: <linux-kernel+bounces-720416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE468AFBB74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433041692C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE526560A;
	Mon,  7 Jul 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4NObD3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2419755B;
	Mon,  7 Jul 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915216; cv=none; b=Hf/K3hlOQDLe+n/HTlgVENij/AdJwqp/Ixi33A+r8Y/hwLbjWyUYl+Ay06EsOaiPHmtvPJFkR29wT6CdAD3o3B585C+wXBxOCrtUQHuvxOspoBOW/Pgai85NYwogQ9yV/KTOVt8+n1e39SMlx7QRyAtbm5CH+F8KRyyWx4rsk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915216; c=relaxed/simple;
	bh=c5ydvdpNmmS/uIC1z+YD+lCe1xruHbZRmDzLrfPGm0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aZhjlQ1qz3mMAJGXf9NpWf1LxFN/Ysx9N/x3QGxgq1kaPdKLDREF5DzhYb8jiuNCOUVCEDHjYhJeVrWELpyqAQW7PqdTt7O7aFtzmXP6Cm2IfD2klUZktH2VK1mBEkrF9NTxFElpXbbVtNTDsqWvCxfBv7VDjj2t1L4aILwr7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4NObD3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0534EC4CEE3;
	Mon,  7 Jul 2025 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915216;
	bh=c5ydvdpNmmS/uIC1z+YD+lCe1xruHbZRmDzLrfPGm0c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=t4NObD3OZGoVszdgOqabwHh/3ZRSpEnEwPQB5i2yPvXaF9MquceFGRrwSndhrFRY/
	 yC5qZ9v+8Baqe0UlV3Fvw6SgduxU9a4TdShe+5kM8saS2ROuq/H0UPsFHBdPjn96qn
	 GAojgpAce0Maty1SmSNtZV87nW/hzM504udrdUYXNJ0cMQv/OK5xxHzJr2OdXDPGdk
	 NI1SKviU0dMSsN+MD8qnjOcUSFn3YYxWqEngtv6WdKTHb/ZhkrT3NzPIfCdBpkwiAL
	 RkXZ61Y0DFU2NJYk5I275h2SihKv+qgeqDZ9HTT+pO1u2FzMQdOGdqUgzu7tEOoS7L
	 YZjDVYfj9APxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 21:06:50 +0200
Message-Id: <DB6240Y4VP7Y.2U5ERJO5J7F2W@kernel.org>
Subject: Re: [PATCH v4 4/7] drm/gpuvm: Add a helper to check if two VA can
 be merged
Cc: "Caterina Shablia" <caterina.shablia@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Binns"
 <frank.binns@imgtec.com>, "Matt Coster" <matt.coster@imgtec.com>, "Karol
 Herbst" <kherbst@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Steven Price"
 <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>, "Lucas De
 Marchi" <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <asahi@lists.linux.dev>, "Asahi Lina"
 <lina@asahilina.net>
To: "Danilo Krummrich" <dakr@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
 <20250707170442.1437009-5-caterina.shablia@collabora.com>
 <DB61ZHDINPNE.1VFXNF2XXSJPA@kernel.org>
In-Reply-To: <DB61ZHDINPNE.1VFXNF2XXSJPA@kernel.org>

On Mon Jul 7, 2025 at 9:00 PM CEST, Danilo Krummrich wrote:
> On Mon Jul 7, 2025 at 7:04 PM CEST, Caterina Shablia wrote:
>> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
>> index 05978c5c38b1..dc3c2f906400 100644
>> --- a/drivers/gpu/drm/drm_gpuvm.c
>> +++ b/drivers/gpu/drm/drm_gpuvm.c
>> @@ -2098,12 +2098,48 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void=
 *priv,
>>  	return fn->sm_step_unmap(&op, priv);
>>  }
>> =20
>> +static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *=
a,
>> +		      const struct drm_gpuva *b)
>> +{
>> +	/* Only GEM-based mappings can be merged, and they must point to
>> +	 * the same GEM object.
>> +	 */
>> +	if (a->gem.obj !=3D b->gem.obj || !a->gem.obj)
>> +		return false;
>> +
>> +	/* Let's keep things simple for now and force all flags to match. */
>> +	if (a->flags !=3D b->flags)
>> +		return false;

Forgot to mention, this can include driver specific flags. How do we know f=
rom
the generic code whether this condition makes sense? *At least* it would ne=
ed to
be documented.

However, I think it would be better to provide an optional callback for dri=
vers
to check whether merge makes sense or not. This doesn't mean we need driver=
s to
do those common checks, this can remain here in the common code.

>> +
>> +	/* Order VAs for the rest of the checks. */
>> +	if (a->va.addr > b->va.addr)
>> +		swap(a, b);
>> +
>> +	/* We assume the caller already checked that VAs overlap or are
>> +	 * contiguous.
>> +	 */
>> +	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
>> +		return false;
>> +
>> +	/* We intentionally ignore u64 underflows because all we care about
>> +	 * here is whether the VA diff matches the GEM offset diff.
>> +	 */
>> +	return b->va.addr - a->va.addr =3D=3D b->gem.offset - a->gem.offset;
>> +}
>> +
>>  static int
>>  __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>>  		   const struct drm_gpuvm_ops *ops, void *priv,
>>  		   const struct drm_gpuvm_map_req *req)
>>  {
>>  	struct drm_gpuva *va, *next;
>> +	struct drm_gpuva reqva =3D {
>> +		.va.addr =3D req->va.addr,
>> +		.va.range =3D req->va.range,
>> +		.gem.offset =3D req->gem.offset,
>> +		.gem.obj =3D req->gem.obj,
>> +		.flags =3D req->flags,
>
> Huh? Where does req->flags come from? I don't remember that this flag exi=
sts in
> struct drm_gpuvm_map_req in the preceding patch?
>
>> +	};
>>  	u64 req_end =3D req->va.addr + req->va.range;
>>  	int ret;
>> =20
>> @@ -2116,12 +2152,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>>  		u64 addr =3D va->va.addr;
>>  		u64 range =3D va->va.range;
>>  		u64 end =3D addr + range;
>> -		bool merge =3D !!va->gem.obj;
>> +		bool merge =3D can_merge(gpuvm, va, &reqva);
>
> I know you want to do the swap() trick above, but I don't like creating a
> temporary struct drm_gpuva with all the other uninitialized fields.
>
> If you really want this, can we please limit the scope? Maybe the followi=
ng
> helper:
>
> 	static bool can_merge(struct drm_gpuvm *gpuvm,
> 			      const struct drm_gpuva *va,
> 			      struct drm_gpuvm_map_req *req)
> 	{
> 		struct drm_gpuva reqva =3D { ... };
> 		return __can_merge(gpuvm, va, reqva);
> 	}


