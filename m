Return-Path: <linux-kernel+bounces-845476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F44BC51AB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34764F90C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D61F03DE;
	Wed,  8 Oct 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfzrqvhN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF951FAC4B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928500; cv=none; b=Lba8KYHef23PuN9QAYadVntR5RUsqXO0U1pG7FyByFbgWtFnlO73QudPWgjQSBJpISb76y60Ddj57ABioBrB/EDzsZwkNlYW85TMXZXWgS0T3rPlTElVZ5KjwcBNzT4HqL7IHdqiGGbe26drHSLeH0e1GMmiv/vCPIFafUzU4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928500; c=relaxed/simple;
	bh=U8gluw6AjhGk5C4G3GGmOk26ZsDpNCj6rdIo4rIN0as=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiG4hIb4GRbDezv9gNFazl4y5BPCqZXG/eqQPWmBWJEIbsgCxUFJNzPYB8cQ4ZdYDqVSrrrKHvUOr7H38fNr6YuCyeGJX670XSGHpnZe3t8CC+L230Yv979eMhq3034d2xAtQcIHGI3RZtlxyBahjUWn4foWEX6XPfRyDy0AdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfzrqvhN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so29222225e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759928495; x=1760533295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GegBdW6/vqVWwJUxJt/HTrMkbdqIQ76CzJgwPMuKcI0=;
        b=IfzrqvhN3k8D6tCmwFAOMXIZ3zUH1wfHtLoqS5Ycotmv2wVVC1liSJSKg6UcjPYrGk
         GejJ65Z1FTci3WtVkyIrzK7OOmACpsz+CIPDL8GrRTnnDVO5aS5eyMCtAGk12IMXaIg2
         k7SdSY2Ew0qmYJlwMlsh/YmVMQyHWh0fJaWOGFZSwvy97t+JLrkxkQeQMXl/0PhhiaD6
         6+xnH36AJHw/6QP4e9rv/A9Oz4JlOLuhSQRwPOeepWURUkr0dYYhLDIiElpwwd6GwIG6
         yf9YfcQ1uxC7AlSrybO/tGi+KlkWfhor0JePVMW7vSUNLFmfKCA2+X2K2fQMvo02JpjW
         wbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928495; x=1760533295;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GegBdW6/vqVWwJUxJt/HTrMkbdqIQ76CzJgwPMuKcI0=;
        b=nJVMKIZCpOt/yMrU72f+1SpAak67f6O8l77Ao4EvVVDnK+hMW+wlHrhIPIMz0SEh4c
         9x7g0zKTPFhGFGxiEbiP0VwTLpZI1sxpEDQhkzEuYoyf6GjWq+dsSxg8gDIDs3Pg/A1e
         iujQg7i8zKDca+SDzv9bjKeqcGUEYOKHchVHDzMsreGc9JNjePF8lYatWXEsH2famKLr
         5VVU05AxXsmkb72nCVA63+Fkzea1on+NZZo9aPF0Gz5ci3Y5fimZk2nSxZhLTt+Hh8m4
         xmNZ7ISdNdd6m/n3Id6cjpAsuqO16tAmHnCMKJhCvRXOChSnwi7tSKEElWwNvnBQzadp
         VWcg==
X-Forwarded-Encrypted: i=1; AJvYcCUBw8bhViApSlniMMBBVDBmGa05rONdVhv9reEJpGSVHsu7USZZaUYB1V7n0QlNQ4h2GyCG5TCeJWSDxrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz553kmfxmDMGmmyz8PgY6rT73DXP6as/Udo04FYBfkWXd6lMnz
	vsFx4abXCUmFWJI3qU37RL/lfBGEVNBvXr3agCoWanIhXMUMq5e88CkmFvqXjibV6r9eDDcEzh4
	ivQB5FWYnzmQ8NtDBrg==
X-Google-Smtp-Source: AGHT+IFOSiOdV5yhuZ0ZB6MFGcVW4EY/P9vvGB1lbHla91Nrf6b7CfBCTOLrpELNIGe52y3C6X6BGL/q+rKkFJc=
X-Received: from wmpu15.prod.google.com ([2002:a05:600c:4d0f:b0:46f:aa50:d6ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3546:b0:46e:33a6:46b2 with SMTP id 5b1f17b1804b1-46fa9a96a70mr22790175e9.12.1759928495174;
 Wed, 08 Oct 2025 06:01:35 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:01:34 +0000
In-Reply-To: <DDCV43KW9OGL.27I8HP4TSTQ6N@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006163024.18473-1-work@onurozkan.dev> <20251006163024.18473-2-work@onurozkan.dev>
 <DDBHMNEIU9HJ.68MGF28IF58I@kernel.org> <aOTyVzpJNDOaxxs6@google.com> <DDCV43KW9OGL.27I8HP4TSTQ6N@kernel.org>
Message-ID: <aOZgrhsNrKpxM_PW@google.com>
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:18:24PM +0200, Benno Lossin wrote:
> On Tue Oct 7, 2025 at 12:58 PM CEST, Alice Ryhl wrote:
> > On Mon, Oct 06, 2025 at 09:31:43PM +0200, Benno Lossin wrote:
> >> On Mon Oct 6, 2025 at 6:30 PM CEST, Onur =C3=96zkan wrote:
> >> > Implements `alloc` function to `XArray<T>` that wraps
> >> > `xa_alloc` safely.
> >> >
> >> > Resolves a task from the nova/core task list under the "XArray
> >> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> >> > file.
> >> >
> >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> >> > ---
> >> >  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 39 insertions(+)
> >> >
> >> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> >> > index a49d6db28845..1b882cd2f58b 100644
> >> > --- a/rust/kernel/xarray.rs
> >> > +++ b/rust/kernel/xarray.rs
> >> > @@ -266,6 +266,45 @@ pub fn store(
> >> >              Ok(unsafe { T::try_from_foreign(old) })
> >> >          }
> >> >      }
> >> > +
> >> > +    /// Allocates an empty slot within the given limit range and st=
ores `value` there.
> >> > +    ///
> >> > +    /// May drop the lock if needed to allocate memory, and then re=
acquire it afterwards.
> >> > +    ///
> >> > +    /// On success, returns the allocated id.
> >> > +    ///
> >> > +    /// On failure, returns the element which was attempted to be s=
tored.
> >> > +    pub fn alloc(
> >> > +        &mut self,
> >> > +        limit: bindings::xa_limit,
> >> > +        value: T,
> >> > +        gfp: alloc::Flags,
> >> > +    ) -> Result<u32, StoreError<T>> {
> >>=20
> >> I think it would be a good idea to make the id a newtype wrapper aroun=
d
> >> u32. Maybe not even allow users to manually construct it or even inspe=
ct
> >> it if possible.
> >
> > What? People need to know what the assigned index is.
>=20
> The documentation says "allocated id", so I assumed that it was some
> internal, implementation-dependent thing, not an index. In that case we
> should change the docs instead.

An xarray is a map from integer to pointer. The allocated id the key in
this map. The alloc method picks the smallest unused key in a given
range.

Alice

