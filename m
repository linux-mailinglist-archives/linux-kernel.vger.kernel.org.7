Return-Path: <linux-kernel+bounces-773453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7BB2A07B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DC42A73F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4B319863;
	Mon, 18 Aug 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdtd+tCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA6318144;
	Mon, 18 Aug 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516470; cv=none; b=N26RoUGummgN6o72FwD3L6pwOgo4YDRb5nCzrBDJ5Ah4CC26ChXWezEm9E6Tx6hTPPtNaYjgBuX8kUeYtwPyVHWUjfWLKAksH8tvkGrYU143fH0n6Afr5Jw8SCykxclqsNienkxbAg2GSfUG3Bi7qqjSws3JeTjdA3LW2xjroKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516470; c=relaxed/simple;
	bh=1fu4UXJCphXsblbUVd77hsc65GaDeA3m1yolgAzFEGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QUHcTP5GPejLR7JyrukNOxtN0Ti2QcELL0b+wZjzgyXzpHuL9hMXiJZgVI2sIVRS8Q/NzG+V5RQ8FVPkpLNTZKufs6Vh3nQJNtP0LI8UJghouZuuWcozFJmh9v5EU508CxF0eeZZQzCdZ2A8gQDSvxcnJigHNxCMFVisdVVvSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdtd+tCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A0C4CEEB;
	Mon, 18 Aug 2025 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516469;
	bh=1fu4UXJCphXsblbUVd77hsc65GaDeA3m1yolgAzFEGw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mdtd+tCzxiWI0xHmUVBYOLe9lPtB1BOLAwvwR1LQL8TgeDTVqfpl6gHSfNQukBAjk
	 g2dBOsACYWz65Eya+ad6iMIvuFFHHQGwy26LPc4EThTacx3LWrdAQaFVD7rEHc0Csv
	 66mxnuw4ykZNA7gp+q49QjX3AUgxusgeSCnpao11OhacY1S3HVzyQzj76gecCnpzQC
	 ksXbC2sXsJ+uaEqvsZcnoDt8j9QuSSwoYt/+uMIw/WlkBWulD45BRs65uRJBhNivzz
	 O1sWxoNhaPXb1nn9Rm1r5Z4oGWlr9u75CEgl5Kul+s8b/ydfEwuWhRHyKJzo1uqWna
	 l/2hZ1CExGqCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 13:27:44 +0200
Message-Id: <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-2-dakr@kernel.org> <aKLzrp0m00J6CCYz@google.com>
In-Reply-To: <aKLzrp0m00J6CCYz@google.com>

On Mon Aug 18, 2025 at 11:34 AM CEST, Alice Ryhl wrote:
> On Fri, Aug 15, 2025 at 07:10:02PM +0200, Danilo Krummrich wrote:
>> Add the `DataDirection` struct, a newtype wrapper around the C
>> `enum dma_data_direction`.
>>=20
>> This provides a type-safe Rust interface for specifying the direction of
>> DMA transfers.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
>> +/// DMA data direction.
>> +///
>> +/// Corresponds to the C [`enum dma_data_direction`].
>> +///
>> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
>> +#[derive(Copy, Clone, PartialEq, Eq)]
>> +pub struct DataDirection(bindings::dma_data_direction);
>
> Perhaps this should be a real Rust enum so that you can do an exhaustive
> match?

	/// DMA data direction.
	///
	/// Corresponds to the C [`enum dma_data_direction`].
	///
	/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
	#[derive(Copy, Clone, PartialEq, Eq, Debug)]
	#[repr(i32)]

Does bindgen ever pick another type than i32 for C enums? If so, it'd be a
downside that we'd have to mess with the type either in the `repr` or by ca=
sting
the variants.

	pub enum DataDirection {
	    /// The DMA mapping is for bidirectional data transfer.
	    ///
	    /// This is used when the buffer can be both read from and written to =
by the device.
	    /// The cache for the corresponding memory region is both flushed and =
invalidated.
	    Bidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL,
=09
	    /// The DMA mapping is for data transfer from memory to the device (wr=
ite).
	    ///
	    /// The CPU has prepared data in the buffer, and the device will read =
it.
	    /// The cache for the corresponding memory region is flushed.
	    ToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE,
=09
	    /// The DMA mapping is for data transfer from the device to memory (re=
ad).
	    ///
	    /// The device will write data into the buffer for the CPU to read.
	    /// The cache for the corresponding memory region is invalidated befor=
e CPU access.
	    FromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE,
=09
	    /// The DMA mapping is not for data transfer.
	    ///
	    /// This is primarily for debugging purposes. With this direction, the=
 DMA mapping API
	    /// will not perform any cache coherency operations.
	    None =3D bindings::dma_data_direction_DMA_NONE,
	}
=09
	impl From<DataDirection> for bindings::dma_data_direction {
	    /// Returns the raw representation of [`enum dma_data_direction`].
	    fn from(direction: DataDirection) -> Self {
	        direction as Self
	    }
	}

