Return-Path: <linux-kernel+bounces-845289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA8BC4485
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A37AB4ECE72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54992F5A20;
	Wed,  8 Oct 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNIFBteU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383F2E8B80;
	Wed,  8 Oct 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918711; cv=none; b=qIY67VmKCMJatqMumPf2rM8VtJVbCrXJFdzgfDHgCxFDX3narCAwcA/HkN6eZdUhLPzK91vPWFpHwSl/If7ly0EE8KiludDqUD6EcnvG70Idi+bUmJwVfvspPe8KND9gKvaBL4FOFFyst92wns0BBtjjmBDemxFUOJrhrEjQRVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918711; c=relaxed/simple;
	bh=b/FTtui6gRJ0e8SceFeHMggEt9pTm3eBkrK95al13n4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=noDzglgPftmCrq8mdm3P6BONYjd27vefncrzaeGKvgX1L26ZWiJT9+FB6Tna7fgYcIfQZeEPcGAU9qdZvRjqmcmhvAKhPK38ITmmWeW/7Mt1P9S0Fjt1Ul2n2RYe7HhXYQFbNj1vu1e7t5tsQ3cJxhn1CC3sJVmz0/3SkbiQmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNIFBteU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A85C116C6;
	Wed,  8 Oct 2025 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759918710;
	bh=b/FTtui6gRJ0e8SceFeHMggEt9pTm3eBkrK95al13n4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fNIFBteU5oXqlXy5snUMg4wnv4ymZxQNvlmghhT3xY3rBznehwKbSRFDnStR9p4s6
	 r48i2oLx463jKd4eYL6LBAJ25yLSDXfiJBiFNknLJUmOVYvDcSW+sjp1CCnZfkKLb/
	 rH+rM75edc1xTbEDnAJb6uS5iZLCp92bV/nSrDo7bhiYEeXwwgyXH0dhkJznNGQi39
	 JDmF1yRptuK0FKjfZEXbn2f0pD8ngnETbmCoPbATpRnBbjw6l2ecFN7E46RZty2j9+
	 jBjyHPTkReCELApres82FOslhT8aapoU+cbWDq90GSGhtYEWJZcxumKi3+7WLIKRBZ
	 j3YMjO8sVWLJg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 12:18:24 +0200
Message-Id: <DDCV43KW9OGL.27I8HP4TSTQ6N@kernel.org>
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <linux-kernel@vger.kernel.org>, <acourbot@nvidia.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <corbet@lwn.net>,
 <lyude@redhat.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20251006163024.18473-1-work@onurozkan.dev>
 <20251006163024.18473-2-work@onurozkan.dev>
 <DDBHMNEIU9HJ.68MGF28IF58I@kernel.org> <aOTyVzpJNDOaxxs6@google.com>
In-Reply-To: <aOTyVzpJNDOaxxs6@google.com>

On Tue Oct 7, 2025 at 12:58 PM CEST, Alice Ryhl wrote:
> On Mon, Oct 06, 2025 at 09:31:43PM +0200, Benno Lossin wrote:
>> On Mon Oct 6, 2025 at 6:30 PM CEST, Onur =C3=96zkan wrote:
>> > Implements `alloc` function to `XArray<T>` that wraps
>> > `xa_alloc` safely.
>> >
>> > Resolves a task from the nova/core task list under the "XArray
>> > bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
>> > file.
>> >
>> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>> > ---
>> >  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 39 insertions(+)
>> >
>> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
>> > index a49d6db28845..1b882cd2f58b 100644
>> > --- a/rust/kernel/xarray.rs
>> > +++ b/rust/kernel/xarray.rs
>> > @@ -266,6 +266,45 @@ pub fn store(
>> >              Ok(unsafe { T::try_from_foreign(old) })
>> >          }
>> >      }
>> > +
>> > +    /// Allocates an empty slot within the given limit range and stor=
es `value` there.
>> > +    ///
>> > +    /// May drop the lock if needed to allocate memory, and then reac=
quire it afterwards.
>> > +    ///
>> > +    /// On success, returns the allocated id.
>> > +    ///
>> > +    /// On failure, returns the element which was attempted to be sto=
red.
>> > +    pub fn alloc(
>> > +        &mut self,
>> > +        limit: bindings::xa_limit,
>> > +        value: T,
>> > +        gfp: alloc::Flags,
>> > +    ) -> Result<u32, StoreError<T>> {
>>=20
>> I think it would be a good idea to make the id a newtype wrapper around
>> u32. Maybe not even allow users to manually construct it or even inspect
>> it if possible.
>
> What? People need to know what the assigned index is.

The documentation says "allocated id", so I assumed that it was some
internal, implementation-dependent thing, not an index. In that case we
should change the docs instead.

---
Cheers,
Benno

