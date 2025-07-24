Return-Path: <linux-kernel+bounces-745026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3468B113D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E271CE4359
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434B23BD05;
	Thu, 24 Jul 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/8eTaLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FB230BE4;
	Thu, 24 Jul 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396053; cv=none; b=LW8nyv7jiN8+/oIK0VwJZxHYb8lVOuBUz1aaunaCCdt34Fhfl9YdHiJcereApNfmE55OxpfJybtunwOFwGFn+uSSU/bszxIrtDLabjhWhUZkuJMJ12uOlrjWEbvaK+FL5yvGjcswh9rRFhb/Ml4eAvbnJJ+wtndnvXuBz3+RZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396053; c=relaxed/simple;
	bh=zDBfkniel8YE1EvR07CT7m8wF9mkrhDRPaV4U3vQ8/w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jBdyiBodWCKOUp5xxHxtXY1o10lkkkIP+kGVvVOdSwgTTZH8oGyncIHbVIL1UHSq6+elPi2MFBHXvFlFvh29x6IbpN+D59ERr0DF5T9FYXaGio8b6qbLPuAxo3vJ6n/qWkLzvikr45RSOW/j1Zfo7o3DXTLAllwvcjDdXvr1wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/8eTaLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B6AC4CEED;
	Thu, 24 Jul 2025 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396052;
	bh=zDBfkniel8YE1EvR07CT7m8wF9mkrhDRPaV4U3vQ8/w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N/8eTaLh4yXMe8AdptiqwYYUXbH9EnZrtrTvCVaylb4T4UYVDjCuYLg0/lvN100y9
	 0UgOnDlekbLDkMSb3QhOxFOiyNa40lsqyqgzBd1N/RdU+rpuMk1qizFW1WsNG1ImLd
	 Nc9VKhMbctvoRB3BTg7T7FQlDTBbxvpkp99dx2H8aZ2XqdGAbY7N3xCXJeYeV+X3mC
	 aa8ze0RWEdaYx7LHaWZgqNh7iqSOOSC9myxwFiM1bbZnaAmJS7O2v3Cbwj9h+yRaPW
	 sfH/Fc1LCv2h2ULEZpA3qMIErGp/FMuOUGOlJ5pbMYvcczCndCnqIb+BJWB1G+QL/W
	 VSwud1LTuZ5Vw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 00:27:26 +0200
Message-Id: <DBKN0VSJH3TX.2FYLW17KL0SWW@kernel.org>
Subject: Re: [PATCH] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi
 Lina" <lina+kernel@asahilina.net>, "Alyssa Rosenzweig"
 <alyssa@rosenzweig.io>, "open list" <linux-kernel@vger.kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250724191523.561314-1-lyude@redhat.com>
 <DBKJYLF9E3TY.IM6UZFA0BW9I@kernel.org>
 <e7a4cb0cc55a2d19e6eb9bf5280c68c0dd04d61d.camel@redhat.com>
In-Reply-To: <e7a4cb0cc55a2d19e6eb9bf5280c68c0dd04d61d.camel@redhat.com>

On Thu Jul 24, 2025 at 11:06 PM CEST, Lyude Paul wrote:
> On Thu, 2025-07-24 at 22:03 +0200, Danilo Krummrich wrote:
>> On Thu Jul 24, 2025 at 9:15 PM CEST, Lyude Paul wrote:
>> > -// SAFETY: All gem objects are refcounted.
>> > -unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
>> > -    fn inc_ref(&self) {
>> > -        // SAFETY: The existence of a shared reference guarantees tha=
t the refcount is non-zero.
>> > -        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
>> > -    }
>> > -
>> > -    unsafe fn dec_ref(obj: NonNull<Self>) {
>> > -        // SAFETY: We either hold the only refcount on `obj`, or one =
of many - meaning that no one
>> > -        // else could possibly hold a mutable reference to `obj` and =
thus this immutable reference
>> > -        // is safe.
>> > -        let obj =3D unsafe { obj.as_ref() }.as_raw();
>> > -
>> > -        // SAFETY:
>> > -        // - The safety requirements guarantee that the refcount is n=
on-zero.
>> > -        // - We hold no references to `obj` now, making it safe for u=
s to potentially deallocate it.
>> > -        unsafe { bindings::drm_gem_object_put(obj) };
>> > -    }
>> > -}
>>=20
>> IIUC, you'll add rust/kernel/drm/gem/shmem.rs with a new type shmem::Obj=
ect that
>> implements IntoGEMObject, right?
>>=20
>> If this is correct, I think that should work.
>
> Do you mean you think the blanket implementation that we had would work, =
or
> that getting rid of it would work?

The former.

> Since the blanket implementation we have
> definitely doesn't compile on my machine once we add more then one
> IntoGEMObject impl. (before adding it, it works just fine)

Do you have a branch somewhere, where it doesn't compile?

