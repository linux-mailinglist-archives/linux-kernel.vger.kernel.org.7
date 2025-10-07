Return-Path: <linux-kernel+bounces-844122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD64BC10E7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 543D34F4BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A62D94BB;
	Tue,  7 Oct 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sR15f379"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF42D949E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834621; cv=none; b=qadpbKqJIN8BHyDOYZxGh9kPGPP1g+DkglRLAtqTjXujM/s4+hSvpmEClETX96XIy2nuPL20yHHdSDi/7aL8YxHF4sjFSHSGT1I3w2fB2zEzPfeVxMi92NsIGwhI3Ld52AbIiEvbsa4zaLiCurKb+zykapYJSCFWz9QJy2d3/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834621; c=relaxed/simple;
	bh=vUkY0LBxAjC+01n8OpO7QSDbN37dvum9xul2QzmKHpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvzxzbfYFpzdIircDS2D2WSGuoVwr/OQfbSuxQnU5a1xNGv06C7rLaPHO5TJw+K8DzFWRnofuB4Xfg04accoEGKW+rKHH0RkySHFFbYik+/pLBr/FhwHEtb5OAhGTr5OAiGirVB1O0N4Ni+isfIT1SWSusLTzNPmwtF1GBxR264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sR15f379; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso32759465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759834618; x=1760439418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQQAIlxYbdWuvuYTPGUIT4drPlYe0TwcyAZ7bEOHsPc=;
        b=sR15f37995rv7vXZavVI9s6XLhUo+Suau2wUL5oW6vm2NQgmgvOgRZWMNNs9i1FHoP
         Po0/CiyVufDWMB9eqWuwPz6i66bisCis+rXysh0unre4nOkq2QHj9bMagRuSre+QEOre
         +uQVhHmhUhaCLVIRVR+ASjmF/+lcgmsWAXJN3x+8Iq237oXFWtf58YGBK1YZp21NCOKy
         3vx4iLPT2up5tYnyhGg4pBeHKeVenYsOSmCi1VQOuOkvCoRimhqjIq3MmFjwWuyb67it
         8Mg9xgQNr6XBwE8qfizomyQTx4+SWkZXh0sQ52nPl4qgo0jgRUaxnGu1ZmzqUvYIg1Lo
         6vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759834618; x=1760439418;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQQAIlxYbdWuvuYTPGUIT4drPlYe0TwcyAZ7bEOHsPc=;
        b=LzYTNhRXzTieiGTPtEP0jI4aamMLkQUgXP948oCnBRrUqKWXrczx4+Q6Y1AYpJnFbz
         SCKGrnOPkJlfOzD3xgbM/PHdRpO6kv4sajlfPKUKgSQavHHOAOPVeO6RkGOagWHB4lj7
         +K6hS7WCOo0w6OO0q5n0VHKlURjh7RJFL9GjolpnCsSmF2l8P044PVzi13pv5DvEV+lJ
         +Mm1Bc7kOML/XUvq87Xr5hXn4W9QjeLmYeC6Sj/njtTMDXn6FHQ1HukYQ1pI3A/+bgb0
         7CksISuRz7UgYmlVFZI3U1GKryd1dg4iVppf3Hfws3j7ZUU5h6VvQHWqm4xCrtzLHk1I
         Z8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU0Kh7lux3XlXqtY6AeprN5Tnchlf7mhZQrbtL1nmD29hGtBgiwyA7N1GcMaNPE/RuuiOSR1YYS2Imguz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0saR3icIPBYlMELeN90ujDM/WziTOQ8tvW3CTlIMNwg/DRX/K
	iNQ5KkJOHOk22UbFRqncHTj14rrXI2Cf2ZwQuyRFCHCtZ2Il/HGaWANzZJQWRAe5cJPRJ+8XE9k
	fOGbQY/Bj0ImbBWuasA==
X-Google-Smtp-Source: AGHT+IElIwg1aSS1OnCndwEEVrqrYBTpVUjbbOKp+wuEHxYn6Q0yHYCleycgScMtGRMAnWQ4U5k/Dz3Y9aV1s5w=
X-Received: from wmoh10.prod.google.com ([2002:a05:600c:314a:b0:45f:28dd:87d9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:4392:b0:46e:74bb:6bc with SMTP id 5b1f17b1804b1-46e74bb07ecmr73042095e9.5.1759834618591;
 Tue, 07 Oct 2025 03:56:58 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:56:56 +0000
In-Reply-To: <20251006163024.18473-3-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006163024.18473-1-work@onurozkan.dev> <20251006163024.18473-3-work@onurozkan.dev>
Message-ID: <aOTx-Oj_VN6fVV_s@google.com>
Subject: Re: [PATCH 2/3] rust: xarray: abstract `xa_alloc_cyclic`
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 07:30:23PM +0300, Onur =C3=96zkan wrote:
> Implements `alloc_cyclic` function to `XArray<T>` that
> wraps `xa_alloc_cyclic` safely.
>=20
> Resolves a task from the nova/core task list under the "XArray
> bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> file.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/xarray.rs | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index 1b882cd2f58b..4c2fdf53c7af 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
> @@ -305,6 +305,49 @@ pub fn alloc(
>=20
>          Ok(id)
>      }
> +
> +    /// Allocates an empty slot within the given `limit`, storing `value=
` and cycling from `*next`.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacqui=
re it afterwards.
> +    ///
> +    /// On success, returns the allocated id.
> +    ///
> +    /// On failure, returns the element which was attempted to be stored=
.
> +    pub fn alloc_cyclic(
> +        &mut self,
> +        limit: bindings::xa_limit,

Could we use a Range<u32> type or similar here? I don't think we want a
bindings type.

> +        next: &mut u32,

So this is a mutable reference because it writes `*id + 1` to next,
taking wrap-around into account? The docs should probably explain that.

> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<u32, StoreError<T>> {
> +        build_assert!(
> +            T::FOREIGN_ALIGN >=3D 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );

It should be enough to have this in the constructor. I don't think it's
needed here.

Alice

