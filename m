Return-Path: <linux-kernel+bounces-879790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8389C240A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2FC44F5010
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ADC32ED26;
	Fri, 31 Oct 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQiY8rpk"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF432E6AD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901629; cv=none; b=Eo711rAxYuTdzlxl5w68UoTEvl0iqOJnqNKMdoICQGf4lz5PbZdh0h8FEte5BL+iIGRZ+8u/mZJv3UPZK/+iqbn/l19tPvZ/Ja4fl9HEr3ER70cAl4V+Ki1mDMyCmXp2mFPUcuE8ITgcURnIOioE80dYe8AmOA2eIBOeo8cxKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901629; c=relaxed/simple;
	bh=rQJ6m5izqAPGX/XkFvXmv2Y6nNiOodtTyPT9ISPslA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VxDkUE9IZN/wc8jTaDgrkzyquex99UU7cG0k/HIMSBEkE77K7c6Czm8XfKHRELdL+hpb49BF0xHAwK4A35Ma9gjEngq7umRQvPpNc0MOflWYP3TUmo3VB2ButnPUPvKAOFfdSTOJHAJsHvfl53AsTdnZpw/STHFV5lMA1Diz+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQiY8rpk; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b7043504650so332104166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761901625; x=1762506425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29d2Teid1vY8nWEM/2hMCD7Hus+R2bdLREzpsdHxTuA=;
        b=DQiY8rpkm4eZ9wBhwjojXGGYeoXR1WqMsoways3QfhHrzqoEVzOpE2FB7QGDWPY3Tp
         ej/ct9i+6NMreNT3e1WnM2CQ8eMlRHfq6tXE0Fv7gPr950gu5I98clrkUsIlbmFqPxU1
         Naibh7DukVK7aEmTM74JH28GgURJ+SGcv45ONNXr82qR0AEvG1sSIc8NNIrJmqpt5wcX
         HKAvLjSvK4G74eCS88rC+3AesK5dvcLOsLyqwVCf1yWaz/YzmSvunbqDy8ZtMqvEkd8b
         GwaKBiYq3BFrhl31pogaMjxm6FQkGLATtU/CKTsQcmb+SoqER+YK/kYzf7CNNG2XuJ0N
         DL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901625; x=1762506425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29d2Teid1vY8nWEM/2hMCD7Hus+R2bdLREzpsdHxTuA=;
        b=VFGq1FB2/OARSxEjt3VVOBoQ8+/aNULIlkFQj874lJjNIwTWo2XMny1Gq+iO+ApImu
         wIrrSDSA4ya1cuPubtIRsrQP0Rb/S9Zya2iN/G3cRLbAF0uV0bTwukR36QJx4huW6qsf
         Y4ZUn1ZPD26ukaJroyxjuzJNpvFTOUjUOlvC6sJoTVtdZwYu2F9O430Q5/JhKhy2Hyia
         W4QFIpep8Hch6mW81lLOqkmrCjAfW/QE48iPyG/lDZBtMJJD+WYzBPCr7wQubz80DX7Y
         saeRRuhStbimcddbNlFu0xtnC/mi3N684xa14DiWMRVvy74+V6HeKtILMOpQNrfWdVxk
         4DXA==
X-Forwarded-Encrypted: i=1; AJvYcCX11DnALfXQKnXvYhVr55c3hIdHg7slmC1rL2Ib3FPLn9nUpvs3npLTRmyy4tNvoODRHN9PDvAYlzO88Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsglnwV78JH2LnNffGs4iZnrW1skbdG66pZrsIT4Oj8FShPaDz
	O4YbV7+rxUhXH/wwBDSBgjvRFw8TnFtyfEY0PsSG3Xc2LZBEK1eBPEtJdnzH8cwdpm0TAuh2hp8
	7skQ8Uswi1sq9yYukkw==
X-Google-Smtp-Source: AGHT+IHQfde77LTsYs+H7ayeimd+wwm/8KMTrV3Sd6Adno8GuLpiuQxfMBuEYeebpFBJheF7ldHY2iKlk8Y3ghY=
X-Received: from ejac23.prod.google.com ([2002:a17:906:3d7:b0:b6d:6aad:e8ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a0c8:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b706e54f35cmr331607566b.16.1761901624817;
 Fri, 31 Oct 2025 02:07:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:07:04 +0000
In-Reply-To: <20251030154842.450518-2-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030154842.450518-1-zhiw@nvidia.com> <20251030154842.450518-2-zhiw@nvidia.com>
Message-ID: <aQR8OPVnU_fPJTCI@google.com>
Subject: Re: [PATCH v3 1/5] rust: io: factor common I/O helpers into Io trait
From: Alice Ryhl <aliceryhl@google.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org, 
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com, 
	markus.probst@posteo.de, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 30, 2025 at 03:48:38PM +0000, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
> 
> To establish a cleaner layering between the I/O interface and its concrete
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
> 
> Factor the common helpers into a new Io trait, and move the MMIO-specific
> logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
> IoRaw to MmioRaw and update the bus MMIO implementations to use MmioRaw.
> 
> No functional change intended.
> 
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.
> +///
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> +/// regions) can share the same accessors.
> +pub trait Io<const SIZE: usize> {

I would consider moving SIZE to an associated constant.

	pub trait Io {
	    const MIN_SIZE: usize;
	
	    ...
	}

If it's a generic parameter, then the same type can implement both Io<5>
and Io<7> at the same time, but I don't think it makes sense for a
single type to implement Io with different minimum sizes.

>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
>  
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> -
> -    #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -        let type_size = core::mem::size_of::<U>();
> -        if let Some(end) = offset.checked_add(type_size) {
> -            end <= size && offset % type_size == 0
> -        } else {
> -            false
> -        }
> -    }
> +    fn maxsize(&self) -> usize;
>  
> +    /// Returns the absolute I/O address for a given `offset`.
> +    /// Performs runtime bounds checks using [`offset_valid`]
>      #[inline]
>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(offset, self.maxsize()) {
>              return Err(EINVAL);
>          }
>  
> @@ -217,50 +215,197 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
>  
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
>      #[inline]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +        build_assert!(offset_valid::<U>(offset, SIZE));
>  
>          self.addr() + offset
>      }
>  
> -    define_read!(read8, try_read8, readb -> u8);
> -    define_read!(read16, try_read16, readw -> u16);
> -    define_read!(read32, try_read32, readl -> u32);
> +    /// Infallible 8-bit read with compile-time bounds check.
> +    fn read8(&self, _offset: usize) -> u8 {
> +        !0
> +    }
> +
> +    /// Infallible 16-bit read with compile-time bounds check.
> +    fn read16(&self, _offset: usize) -> u16 {
> +        !0
> +    }
> +
> +    /// Infallible 32-bit read with compile-time bounds check.
> +    fn read32(&self, _offset: usize) -> u32 {
> +        !0
> +    }
> +
> +    /// Infallible 64-bit read with compile-time bounds check (64-bit only).
> +    #[cfg(CONFIG_64BIT)]
> +    fn read64(&self, _offset: usize) -> u64 {
> +        !0
> +    }
> +
> +    /// Fallible 8-bit read with runtime bounds check.
> +    fn try_read8(&self, _offset: usize) -> Result<u8> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Fallible 16-bit read with runtime bounds check.
> +    fn try_read16(&self, _offset: usize) -> Result<u16> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Fallible 32-bit read with runtime bounds check.
> +    fn try_read32(&self, _offset: usize) -> Result<u32> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Fallible 64-bit read with runtime bounds check (64-bit only).
> +    #[cfg(CONFIG_64BIT)]
> +    fn try_read64(&self, _offset: usize) -> Result<u64> {
> +        Err(ENOTSUPP)
> +    }
> +
> +    /// Infallible 8-bit write with compile-time bounds check.
> +    fn write8(&self, _value: u8, _offset: usize) {
> +        ()
> +    }
> +
> +    /// Infallible 16-bit write with compile-time bounds check.
> +    fn write16(&self, _value: u16, _offset: usize) {
> +        ()
> +    }
> +
> +    /// Infallible 32-bit write with compile-time bounds check.
> +    fn write32(&self, _value: u32, _offset: usize) {
> +        ()
> +    }
> +
> +    /// Infallible 64-bit write with compile-time bounds check (64-bit only).
> +    #[cfg(CONFIG_64BIT)]
> +    fn write64(&self, _value: u64, _offset: usize) {
> +        ()
> +    }
> +
> +    /// Fallible 8-bit write with runtime bounds check.
> +    fn try_write8(&self, value: u8, offset: usize) -> Result;
> +
> +    /// Fallible 16-bit write with runtime bounds check.
> +    fn try_write16(&self, value: u16, offset: usize) -> Result;
> +
> +    /// Fallible 32-bit write with runtime bounds check.
> +    fn try_write32(&self, value: u32, offset: usize) -> Result;
> +
> +    /// Fallible 64-bit write with runtime bounds check (64-bit only).
> +    #[cfg(CONFIG_64BIT)]
> +    fn try_write64(&self, _value: u64, _offset: usize) -> Result {
> +        Err(ENOTSUPP)
> +    }

Why are there default implementations for all of these trait methods? I
would suggest not providing any default implementations at all.

Alice

