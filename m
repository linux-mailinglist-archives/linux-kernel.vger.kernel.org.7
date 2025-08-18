Return-Path: <linux-kernel+bounces-774497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D1B2B32B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25E0189F025
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9D22D9E9;
	Mon, 18 Aug 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeNO3M92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E41E868;
	Mon, 18 Aug 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551039; cv=none; b=Qa8w1Py/wPTgSnjIG/a2R1gO2zCqD0IpF+ZZsFDrdm4SPyWCSQexXhtWzQ4SjZsJxPlvWf5mePKkTIKB3fMo9fO3LHcKXOZpAd3PcwrJodk2tvwtAxtBuWa+gPt0ffhZGawFcbrCBISAmHWbz2WlNe7NPCq/9upt7O37Og0Bb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551039; c=relaxed/simple;
	bh=btvZKybT7d1jpu02lvpOVxHne9dwrDNIeYligAnPnJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JgPU41f6tKK7c73bG8nedsEGuOq5IAJmPqI9tQF0WNQyXnMtYjjDpvJ/xdSGdAYOfjxHT7RouklJ7ddkN9YRW7cDuv38D2iGgezMiuq+wqOGt/FVPwNog5O0iTQUqZZqs4ywn6RfJCidQ4QLGFOuFu1Y1IHPMVWxPbrov8rPWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeNO3M92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D64C4CEEB;
	Mon, 18 Aug 2025 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755551038;
	bh=btvZKybT7d1jpu02lvpOVxHne9dwrDNIeYligAnPnJ8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jeNO3M92hfVWyanIjhNQS9YJ6SXIZ0jeBTUsNv5b+OoN5gFcbndh0231FbcwpzfvY
	 wXraXz3eDLauh0z/wE//yQCqzU9rID3vUk587q3ZT1+7JA5IoimTrEJLqc9hDRUXt4
	 lef2lCV68yg07ZrqB/TzMhhZaE6h+F3QL1b98U7GuB7RW3miceLe9HTswx519dIe/o
	 gJblTlrBfd2+RThfk5d2ffobxSADtT1goSdSDQbDVCQWTKH3DxadRN2lXt3p1/ozHm
	 ndXJ73YR9rJb0g/78fNV8swNCIChnEjADFauj+ARwy6Z3TKuhy7bcZdJBA++RyOFLr
	 +SrUJBNcQ5Nsw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 23:03:53 +0200
Message-Id: <DC5UWIXHVAGI.1TTU2K9WIC1E9@kernel.org>
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
 <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org> <aKMa7YzO-PwEv9AT@google.com>
 <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
 <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com>
 <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
 <CAH5fLgjymw6Mr8qv8NDFA8hz+nfh3-B4XcZ_N-UAmJrc3Ug_QQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjymw6Mr8qv8NDFA8hz+nfh3-B4XcZ_N-UAmJrc3Ug_QQ@mail.gmail.com>

On Mon Aug 18, 2025 at 8:47 PM CEST, Alice Ryhl wrote:
> with no warnings and build-failure if out-of-bounds.

+/// DMA data direction.
+///
+/// Corresponds to the C [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+#[repr(u32)]
+pub enum DataDirection {
+    /// The DMA mapping is for bidirectional data transfer.
+    ///
+    /// This is used when the buffer can be both read from and written to =
by the device.
+    /// The cache for the corresponding memory region is both flushed and =
invalidated.
+    Bidirectional =3D Self::const_cast(bindings::dma_data_direction_DMA_BI=
DIRECTIONAL),
+
+    /// The DMA mapping is for data transfer from memory to the device (wr=
ite).
+    ///
+    /// The CPU has prepared data in the buffer, and the device will read =
it.
+    /// The cache for the corresponding memory region is flushed.
+    ToDevice =3D Self::const_cast(bindings::dma_data_direction_DMA_TO_DEVI=
CE),
+
+    /// The DMA mapping is for data transfer from the device to memory (re=
ad).
+    ///
+    /// The device will write data into the buffer for the CPU to read.
+    /// The cache for the corresponding memory region is invalidated befor=
e CPU access.
+    FromDevice =3D Self::const_cast(bindings::dma_data_direction_DMA_FROM_=
DEVICE),
+
+    /// The DMA mapping is not for data transfer.
+    ///
+    /// This is primarily for debugging purposes. With this direction, the=
 DMA mapping API
+    /// will not perform any cache coherency operations.
+    None =3D Self::const_cast(bindings::dma_data_direction_DMA_NONE),
+}
+
+impl DataDirection {
+    /// Casts the bindgen-generated enum type to a `u32` at compile time.
+    ///
+    /// This function will cause a compile-time error if the underlying va=
lue of the
+    /// C enum is out of bounds for `u32`.
+    const fn const_cast(val: bindings::dma_data_direction) -> u32 {
+        // CAST: The C standard allows compilers to choose different integ=
er types for enums.
+        // To safely check the value, we cast it to a wide signed integer =
type (`i128`)
+        // which can hold any standard C integer enum type without truncat=
ion.
+        let wide_val =3D val as i128;
+
+        // Check if the value is outside the valid range for the target ty=
pe `u32`.
+        // CAST: `u32::MAX` is cast to `i128` to match the type of `wide_v=
al` for the comparison.
+        if wide_val < 0 || wide_val > u32::MAX as i128 {
+            // Trigger a compile-time error in a const context.
+            panic!("C enum value is out of bounds for the target type `u32=
`.");
+        }
+
+        // CAST: This cast is valid because the check above guarantees tha=
t `wide_val`
+        // is within the representable range of `u32`.
+        wide_val as u32
+    }
+}
+
+impl From<DataDirection> for bindings::dma_data_direction {
+    /// Returns the raw representation of [`enum dma_data_direction`].
+    fn from(direction: DataDirection) -> Self {
+        // CAST: `direction as u32` gets the underlying representation of =
our `#[repr(u32)]` enum.
+        // The subsequent cast to `Self` (the bindgen type) assumes the C =
enum is compatible
+        // with the enum variants of `DataDirection`, which is a valid ass=
umption given our
+        // compile-time checks.
+        direction as u32 as Self
+    }
+}

