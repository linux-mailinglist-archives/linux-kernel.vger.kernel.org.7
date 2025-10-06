Return-Path: <linux-kernel+bounces-843395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C00BBF19F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D463AD0BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB422128A;
	Mon,  6 Oct 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L96d9IEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7711D514E;
	Mon,  6 Oct 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779109; cv=none; b=HN9rihmIId1izWBUjejz/OHMMS/aIjjKxhaaTBqlTA2RrF1ykDK2yC15innPwXlsBEoL4+mGzH5lf0GqAMUohiqoAbC4sMqcp2GQ2g5kkiiojLeU7rDWE+r02y5F6CQySQmYQGFhvZFzxssvkuYblLTji2jbB3k7ke+uZunp6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779109; c=relaxed/simple;
	bh=Ji52xsF15/vHiCy4wnHNwH55SFB6VzbKxJ6VsGQkCXE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YWOj31muYmu2dLQZDTWNRGsUo541IXzxE6kvP5O+/GY76CGuZiANjS+vpQMHn6yquwz6qAlS/SUwG76L2epl45dpI9/4y0YAvih5se8A1rVy1iYmKs0cN7fCFMAKRTfIrjmYypoAYeJQElBMQsbJ6YuQQNuiGLungIxr4eYfpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L96d9IEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E020DC4CEF5;
	Mon,  6 Oct 2025 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759779108;
	bh=Ji52xsF15/vHiCy4wnHNwH55SFB6VzbKxJ6VsGQkCXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L96d9IEeiMsFIYVG5seTMT7oh167tKdn6ccb/8I4UuOSLcz6FvWLk5Fvl49c5HxW3
	 RSBBR2u0shiYY4YvCZIQXb+bd8kbB5d4bMLM2HH10kRnCYqguwi89+yltyyPXZrGJq
	 B2IdCjaACy8K/DV0wjpW9PeUBBeINzA+cqP6AYVgKs8UHrb+E/IJpW454hg6g/dDQy
	 3OuaZDcKHM45pIABvMRrk2+0yJ0BVt7UjNvPOk8JcwpMqJeRQ5VSAwUR0iMg3QcXqu
	 +DF01xglIgfKwMTkP5fxqumDkfu8pL3PlD7rHIpltFGfi8lGR0v5bYjt091ILN0WHA
	 SyUUbb7eCc6bA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 21:31:43 +0200
Message-Id: <DDBHMNEIU9HJ.68MGF28IF58I@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <linux-kernel@vger.kernel.org>,
 <acourbot@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <corbet@lwn.net>, <lyude@redhat.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
X-Mailer: aerc 0.21.0
References: <20251006163024.18473-1-work@onurozkan.dev>
 <20251006163024.18473-2-work@onurozkan.dev>
In-Reply-To: <20251006163024.18473-2-work@onurozkan.dev>

On Mon Oct 6, 2025 at 6:30 PM CEST, Onur =C3=96zkan wrote:
> Implements `alloc` function to `XArray<T>` that wraps
> `xa_alloc` safely.
>
> Resolves a task from the nova/core task list under the "XArray
> bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> file.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index a49d6db28845..1b882cd2f58b 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
> @@ -266,6 +266,45 @@ pub fn store(
>              Ok(unsafe { T::try_from_foreign(old) })
>          }
>      }
> +
> +    /// Allocates an empty slot within the given limit range and stores =
`value` there.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacqui=
re it afterwards.
> +    ///
> +    /// On success, returns the allocated id.
> +    ///
> +    /// On failure, returns the element which was attempted to be stored=
.
> +    pub fn alloc(
> +        &mut self,
> +        limit: bindings::xa_limit,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<u32, StoreError<T>> {

I think it would be a good idea to make the id a newtype wrapper around
u32. Maybe not even allow users to manually construct it or even inspect
it if possible.

---
Cheers,
Benno

> +        build_assert!(
> +            T::FOREIGN_ALIGN >=3D 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );

