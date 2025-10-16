Return-Path: <linux-kernel+bounces-856403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7DBE4122
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE5BD358F64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308262E2EF9;
	Thu, 16 Oct 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioBINfQ3"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63A2E172D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626889; cv=none; b=kt4/M+lzZFUOtNQSohxwdBhKBMznoF+sJWppaHdQVPbG/QTXJ9uM0DkQXJdYJd14gBMZfXZI2hj/RE0OejKgeQuq4ezBbUMvmBb8YwyI+DjyGQfu0nR6J0QDCNVM0+kmYFMlYAg9CjESQ5KteTaerMdO9UH+C5nAvk5csjfJGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626889; c=relaxed/simple;
	bh=5xa681f2Wy7I1+GCjfTAXTfl0IqG1LYTDdggpyeF6Xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqlHOOASkb4QEr/+MnmQcSY2nSqLIwQ8rXa/Ik6K9r8fLDuRuXNfInTgn4TmiOogQ0sCB25LU6X/CsZkqsWt4sGqQNHsgqmnpHFPpSoasID4mddM+gsEhzvL9uRTFVurn04nnAAXTpd1Cg2A+6EBvZh9BGv38NTQim023GW5ayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ioBINfQ3; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso584653f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760626886; x=1761231686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EttKU3B9Wqu5R2WSYHFS6Mo9lEK4v9PvPliANhh8ahA=;
        b=ioBINfQ3sEjfR21NZtFF0zSOp2ND+1ysNux1pyZ++lkiqg7E0SG/dOD/H45JH9Vupy
         Xx5W0iQH1CGV1qjLyy9XwCX7yeZpBj0e+3yf1sQC+hVvFfqE6uhFRq7gPwBcNNN/K/W3
         E58uppNWUFRruQcFNanN/X5sRg969t1EsrBxHfoENv/CXeCGKYQ6BzoVeN8gNyUuSx6N
         8+Cag6dDUyyyMyWHKNnySD4h8uhj1fwpe3fDF5lz+U8/7tEKCCpo6xhJm8fYoABkVgjE
         pl4vLvphgBz93O2oDPeELq98s6tSlXXB2VHmGIfM78KH3d6uAxHOfE1iVrbpLK8TsptF
         vB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626886; x=1761231686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EttKU3B9Wqu5R2WSYHFS6Mo9lEK4v9PvPliANhh8ahA=;
        b=wOjQbtCyN4uccr0gUyl/jw8xibqBcB7t4fIeFqp7mzSR0wnlK7gIjfhEBPmFGXkkWG
         SRUTJcwIOxgygaFtgfdb+k5yzepw2ThUuoEbh/vtf/FCx258OIPozDKv2WrxfjLYYj1K
         KIq4goK7SCSAqZx3raGZAOCzTmqKcxrUP4Fi9yVO3YBkoM+0MQHtzLZ6yctKR8oR2Vqb
         GoL3hAFwUijSNw7fwbtp/zZ11fRHbVX641EqSLuqesD0hNh4EqH2IBTvQ3wybCuSLbHP
         I1Q3+sx4GmziD0bqyvmO9j/5x/rK76NeFotBi58LfKhBXzRhBtz+DCf53qNwuO8feQsL
         4sGA==
X-Forwarded-Encrypted: i=1; AJvYcCXaPnL77zLe4HdvkcsXfs72efKgyKDHUyHqqTDds2u6d2/8FuKcmagmS1DUvO3ArF8XFuG+Sx4oflFj1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBiKNetTHvlyOe5RRSP8ypx8rKfp8BF5DYHUJ7Ya59yCiBbFv
	31sDXePBC4UfEoBpUcA+AvOjQ4c8u/yMHj18oDMEbgUSnCeozPT1EzNfGe7CyADputb5RHzACWZ
	tFJiipoh7oE9J9kG5CQ==
X-Google-Smtp-Source: AGHT+IHurrt5tf8cx12gEfNHRF260x4BHSkP0VT8R37ilUuWpW5OS1X89vvCHVuaNuNe6MMS4xP/qSvWBLAU6Us=
X-Received: from wrnx18.prod.google.com ([2002:adf:ec12:0:b0:426:db53:5260])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2287:b0:3ea:80ec:8552 with SMTP id ffacd0b85a97d-42704e0eda4mr264130f8f.57.1760626886194;
 Thu, 16 Oct 2025 08:01:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:01:25 +0000
In-Reply-To: <20251015182118.106604-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015182118.106604-1-dakr@kernel.org> <20251015182118.106604-2-dakr@kernel.org>
Message-ID: <aPEIxYlh98exA2vn@google.com>
Subject: Re: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for IrqVector<'a>
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 08:14:29PM +0200, Danilo Krummrich wrote:
> Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert
> a pci::IrqVector into a generic IrqRequest, instead of taking the
> indirection via an unrelated pci::Device method.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index d91ec9f008ae..c6b750047b2e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -596,6 +596,20 @@ fn index(&self) -> u32 {
>      }
>  }
>  
> +impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
> +    type Error = Error;
> +
> +    fn try_into(self) -> Result<IrqRequest<'a>> {
> +        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
> +        if irq < 0 {
> +            return Err(crate::error::Error::from_errno(irq));
> +        }
> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
> +        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
> +    }
> +}
> +
>  /// Represents an IRQ vector allocation for a PCI device.
>  ///
>  /// This type ensures that IRQ vectors are properly allocated and freed by
> @@ -675,31 +689,15 @@ pub fn iomap_region<'a>(
>          self.iomap_region_sized::<0>(bar, name)
>      }
>  
> -    /// Returns an [`IrqRequest`] for the given IRQ vector.
> -    pub fn irq_vector(&self, vector: IrqVector<'_>) -> Result<IrqRequest<'_>> {
> -        // Verify that the vector belongs to this device.
> -        if !core::ptr::eq(vector.dev.as_raw(), self.as_raw()) {
> -            return Err(EINVAL);
> -        }
> -
> -        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> -        let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), vector.index()) };
> -        if irq < 0 {
> -            return Err(crate::error::Error::from_errno(irq));
> -        }
> -        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
> -        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
> -    }
> -
>      /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
>      pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
>          &'a self,
> -        vector: IrqVector<'_>,
> +        vector: IrqVector<'a>,
>          flags: irq::Flags,
>          name: &'static CStr,
>          handler: impl PinInit<T, Error> + 'a,
>      ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
> -        let request = self.irq_vector(vector)?;
> +        let request = vector.try_into()?;
>  
>          Ok(irq::Registration::<T>::new(request, flags, name, handler))
>      }
> @@ -707,12 +705,12 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
>      /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
>      pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
>          &'a self,
> -        vector: IrqVector<'_>,
> +        vector: IrqVector<'a>,
>          flags: irq::Flags,
>          name: &'static CStr,
>          handler: impl PinInit<T, Error> + 'a,
>      ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
> -        let request = self.irq_vector(vector)?;
> +        let request = vector.try_into()?;

The resulting change to the lifetime semantics is curious, but seems
right.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

