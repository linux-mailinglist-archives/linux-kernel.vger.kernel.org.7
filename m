Return-Path: <linux-kernel+bounces-773535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5076B2A15F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335EC4E19B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38E31AF22;
	Mon, 18 Aug 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFzotM/c"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC9326D40
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519729; cv=none; b=cXoagFOOP/1vVzPBG6fnvnqfAwjaJ4DrTM2QzEeKfMy21jmzS4dMGVH0G5GspUoBTWppExcsHf8dGIRlP/bmwxihspN4L4dATY36kpbKvNTQEDv4Uo54ijr0i7u6jDdrspvm9zHdJA07S5gZdE9yWH82BI9Onbo8q0SkccFmLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519729; c=relaxed/simple;
	bh=cqTl4aplCZAhfvMTAYxQgWLX24+AY2DS3jkPSxYCh0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvNp7l0hceUpBocdbCDsW0glFxxuI1klgRGp6WFCnaUPC1xrEn+oTJwkXGkvZSPWIG30tc7ji1OCXvemgxFphY7BUSWP7mBzh/p1Lx0U5l6i64Cfa2Qkt8vrZwKcKxmBygaU2VGXq6ztVMIspyXEwvJW25n44Z2TWMP8E4U/JS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFzotM/c; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0060bfso20165975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755519726; x=1756124526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KPyv2P753aHaPOHsRGn7JU6dQ9BmzZp68I4rfEsvYs=;
        b=PFzotM/cx0eTtWn4fXo0ATgX2g2Lzzb+V1OCQC0+d4iUAwxy8wvBEzxcvR9aFt9k7Z
         VCQBEpg0RQFrH3bEfP358KSUGRpjNMyAjUtrbbMd1RqTJmGzVPCf/4+O4KntAwvhHLpV
         jZUemWyw8QV0c5n9Zqhd/jwTt4fJlzFbBdSuBlI7kGPhIAtv19W3s1/IPw3f+A3h+B9k
         Ua+IzhaN6ytIfqcDOl3JKtvlVBOZJmO1xSqRwXYveiI0PBwDPHXUT/ZxxHaEuCPwEdnC
         mbUIPCnt+wVJtjSfuATZdyS+5Kna1ZdZmotaGe275tyt/qowFNS0A6sCAz4Hzaqo9yCR
         0fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519726; x=1756124526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KPyv2P753aHaPOHsRGn7JU6dQ9BmzZp68I4rfEsvYs=;
        b=ZcldKeQ2o0vyW1MeAc5bfoahNdwnzo0cCDB7uYZsnIeojVz43Ridesr8NN9EBwd9kh
         von+Ucs0lBjaYDl51Tk9iHp/jpZBJfwrt6q8WKghYBA+wDeF51aXz4Zl8y543qUBk84z
         NozWjlnfYZC4cZhCzePkYgrU/Yugzkx6g0ze6qCM0FJyTrVPqO5Wzw7wnWLGcnDrf2o5
         TJsctpK4jN9YXM+7/jzIfunvjNUgob84Eoa310mSqa8+wfnH5bOPmGmNazs6IVyLPR22
         zBS9CrJ1NiRC1wuQgjVVTzcwv2ASo4bcMe6jtf7qFO+Wi/Exv0YHmIUbbkjtWOyOTb0M
         d7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2z7eJqam9atNkvZXYf1FXAnfDzMrfBa1niyUtq/J2vD9EWJPWKrpvEjCh6/1zTKIN3jKQsNu8pd7raQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+lEbhJsKskauWwbJDZH0QLHQ2QFpUxgIyT5KECGS6DFCCqy8
	XLE5vAqRy9F+ed+Ar9GPbn1vWfIPkB1+JCmchWm8FdVau3nskEvOCwEDiWemJwjKq5kkSwI/PRZ
	d8PFNB6Njr6URfvwL8A==
X-Google-Smtp-Source: AGHT+IG4FM5397nDPhVjvIlRnJqZUgtPPoauT5mGaElZpqnYjrLK7NJ+UmVfyO2OrX8B9zOJOjZZf21CiPTRiww=
X-Received: from wmqb7.prod.google.com ([2002:a05:600c:4e07:b0:458:ba61:fc2e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354a:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-45a21844ba9mr9931235e9.21.1755519725846;
 Mon, 18 Aug 2025 05:22:05 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:22:05 +0000
In-Reply-To: <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
 <aKLzrp0m00J6CCYz@google.com> <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
Message-ID: <aKMa7YzO-PwEv9AT@google.com>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 18, 2025 at 01:27:44PM +0200, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 11:34 AM CEST, Alice Ryhl wrote:
> > On Fri, Aug 15, 2025 at 07:10:02PM +0200, Danilo Krummrich wrote:
> >> Add the `DataDirection` struct, a newtype wrapper around the C
> >> `enum dma_data_direction`.
> >> 
> >> This provides a type-safe Rust interface for specifying the direction of
> >> DMA transfers.
> >> 
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> >> +/// DMA data direction.
> >> +///
> >> +/// Corresponds to the C [`enum dma_data_direction`].
> >> +///
> >> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> >> +#[derive(Copy, Clone, PartialEq, Eq)]
> >> +pub struct DataDirection(bindings::dma_data_direction);
> >
> > Perhaps this should be a real Rust enum so that you can do an exhaustive
> > match?
> 
> 	/// DMA data direction.
> 	///
> 	/// Corresponds to the C [`enum dma_data_direction`].
> 	///
> 	/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> 	#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> 	#[repr(i32)]
> 
> Does bindgen ever pick another type than i32 for C enums? If so, it'd be a
> downside that we'd have to mess with the type either in the `repr` or by casting
> the variants.
> 
> 	pub enum DataDirection {
> 	    /// The DMA mapping is for bidirectional data transfer.
> 	    ///
> 	    /// This is used when the buffer can be both read from and written to by the device.
> 	    /// The cache for the corresponding memory region is both flushed and invalidated.
> 	    Bidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL,
> 	
> 	    /// The DMA mapping is for data transfer from memory to the device (write).
> 	    ///
> 	    /// The CPU has prepared data in the buffer, and the device will read it.
> 	    /// The cache for the corresponding memory region is flushed.
> 	    ToDevice = bindings::dma_data_direction_DMA_TO_DEVICE,
> 	
> 	    /// The DMA mapping is for data transfer from the device to memory (read).
> 	    ///
> 	    /// The device will write data into the buffer for the CPU to read.
> 	    /// The cache for the corresponding memory region is invalidated before CPU access.
> 	    FromDevice = bindings::dma_data_direction_DMA_FROM_DEVICE,
> 	
> 	    /// The DMA mapping is not for data transfer.
> 	    ///
> 	    /// This is primarily for debugging purposes. With this direction, the DMA mapping API
> 	    /// will not perform any cache coherency operations.
> 	    None = bindings::dma_data_direction_DMA_NONE,
> 	}
> 	
> 	impl From<DataDirection> for bindings::dma_data_direction {
> 	    /// Returns the raw representation of [`enum dma_data_direction`].
> 	    fn from(direction: DataDirection) -> Self {
> 	        direction as Self
> 	    }
> 	}

My suggestion is to cast on the Rust-side.

#[repr(whateveryouwant)]
enum DataDirection {
    Bidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL as _,
}

