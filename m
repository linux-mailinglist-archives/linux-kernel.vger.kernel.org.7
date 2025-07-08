Return-Path: <linux-kernel+bounces-721510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BAAFCA28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537351AA8658
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C632DBF45;
	Tue,  8 Jul 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH1/bH1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12C2DAFD5;
	Tue,  8 Jul 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976952; cv=none; b=NP3bjSNZwt/dfcOEvEu2WYFgBXi0DbHU8kRa76jIrBq5LniIDOa1jSvOId0GMv0j9WTO9kmY9QYirEv+Hz/uwv4R8HzGwZ14E/rP42PIx4kybBeyIt9wUIwflvFZytQ8ENFyV+tnLPvz8isb0L8opep6dvWxehj3EzKk7jECEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976952; c=relaxed/simple;
	bh=m8jMT2BEQLMLsLrNG9jsh0N0UL2As4Pb8eDEvx4vGD4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=t78TzTVTOXabnZOdJjgb5mD8wp1tOdi9D2z9ydE28LGsP7wcXA7JSYp9/ROjF/1TUIEwky7IbpOKH+3iPKPs4SbixlH8dFr1/zHAE/FbObtH4Na1gIjLjZAmcQcfBhbBWcUuPXaFbNohpIi9brc/JIeLTq24CD7a9UXCSictrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH1/bH1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4186C4CEED;
	Tue,  8 Jul 2025 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976952;
	bh=m8jMT2BEQLMLsLrNG9jsh0N0UL2As4Pb8eDEvx4vGD4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=mH1/bH1uyhkPjienjN6dRpgS3sSmH+GLONi2pBMMJlyv28uWczofciZYlufjnhLYN
	 /YwzLBDZw/yhGPv21Zy0qk/GJQSYubbZBTD2LlhPv2GbPvLazPwCZnkV1h6khaYh4y
	 sH4WmLYLG1kejyYNDQ62Wdg3Uu24UywXLtrgrKQU3m4oCNk8A2s+ffxgFuFJeI6+qD
	 8WvJ4jJEk7r5L5ZQNVzpMEYv8OV8kgz0ltCLslpT5rgAACskbdGT97JY6LddgHPuVI
	 mlX6q2d4Fc45/ehgY6AJw2uar4aUrSabg0xU/s/g5PtZ+2Ya9QWv8zNhgdxm9NZlVn
	 3eY6y6/o7R7Qg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 14:15:49 +0200
Message-Id: <DB6NZVF1X99Q.FWK3057UYE63@kernel.org>
Cc: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 <rust-for-linux@vger.kernel.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 3/4] rust: add support for NUMA ids in allocations
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <20250707164934.631500-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250707164934.631500-1-vitaly.wool@konsulko.se>

On Mon Jul 7, 2025 at 6:49 PM CEST, Vitaly Wool wrote:
> +/// Specify necessary constant to pass the information to Allocator that=
 the caller doesn't care
> +/// about the NUMA node to allocate memory from.
> +impl NumaNode {
> +    /// No node preference

Please end the comment with a period.

> +    pub const NO_NODE: NumaNode =3D NumaNode(bindings::NUMA_NO_NODE);
> +}
> +
>  /// The kernel's [`Allocator`] trait.
>  ///
>  /// An implementation of [`Allocator`] can allocate, re-allocate and fre=
e memory buffers described
> @@ -137,7 +162,7 @@ pub mod flags {
>  /// - Implementers must ensure that all trait functions abide by the gua=
rantees documented in the
>  ///   `# Guarantees` sections.
>  pub unsafe trait Allocator {
> -    /// Allocate memory based on `layout` and `flags`.
> +    /// Allocate memory based on `layout`, `flags` and `nid`.
>      ///
>      /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
>      /// constraints (i.e. minimum size and alignment as specified by `la=
yout`).
> @@ -153,13 +178,21 @@ pub unsafe trait Allocator {
>      ///
>      /// Additionally, `Flags` are honored as documented in
>      /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
> -    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +    fn alloc(layout: Layout, flags: Flags, nid: NumaNode) -> Result<NonN=
ull<[u8]>, AllocError> {
>          // SAFETY: Passing `None` to `realloc` is valid by its safety re=
quirements and asks for a
>          // new memory allocation.
> -        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags)=
 }
> +        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags,=
 nid) }
>      }
> =20
> -    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`.
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout` and
> +    /// a specific NUMA node request to allocate the memory for.
> +    ///
> +    /// Systems employing a Non Uniform Memory Access (NUMA) architectur=
e contain collections of
> +    /// hardware resources including processors, memory, and I/O buses, =
that comprise what is
> +    /// commonly known as a NUMA node.
> +    ///
> +    /// `nid` stands for NUMA id, i. e. NUMA node identifier, which is a=
 non-negative

s/i. e./i.e./

> +    /// integer if a node needs to be specified, or NO_NODE if the calle=
r doesn't care.

s/NO_NODE/[`NumaNode::NO_NODE`]/

>      ///
>      /// If the requested size is zero, `realloc` behaves equivalent to `=
free`.
>      ///
> @@ -196,6 +229,7 @@ unsafe fn realloc(

<snip>

> @@ -58,18 +58,23 @@ fn aligned_size(new_layout: Layout) -> usize {
>  ///
>  /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.

You have to adjust those as well, given that you refer to this invariant be=
low.

>  struct ReallocFunc(
> -    unsafe extern "C" fn(*const crate::ffi::c_void, usize, u32) -> *mut =
crate::ffi::c_void,
> +    unsafe extern "C" fn(
> +        *const crate::ffi::c_void,
> +        usize,
> +        u32,
> +        crate::ffi::c_int,
> +    ) -> *mut crate::ffi::c_void,
>  );
> =20
>  impl ReallocFunc {
> -    // INVARIANT: `krealloc` satisfies the type invariants.
> -    const KREALLOC: Self =3D Self(bindings::krealloc);
> +    // INVARIANT: `krealloc_node` satisfies the type invariants.
> +    const KREALLOC: Self =3D Self(bindings::krealloc_node);
> =20
> -    // INVARIANT: `vrealloc` satisfies the type invariants.
> -    const VREALLOC: Self =3D Self(bindings::vrealloc);
> +    // INVARIANT: `vrealloc_node` satisfies the type invariants.
> +    const VREALLOC: Self =3D Self(bindings::vrealloc_node);
> =20
> -    // INVARIANT: `kvrealloc` satisfies the type invariants.
> -    const KVREALLOC: Self =3D Self(bindings::kvrealloc);
> +    // INVARIANT: `kvrealloc_node` satisfies the type invariants.
> +    const KVREALLOC: Self =3D Self(bindings::kvrealloc_node);

