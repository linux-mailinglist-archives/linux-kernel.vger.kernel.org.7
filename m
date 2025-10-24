Return-Path: <linux-kernel+bounces-868616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22FC05A19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D70254FFE69
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF23115BC;
	Fri, 24 Oct 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLESs5Xv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232112FE041
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302354; cv=none; b=FgiNlc8YVp4/UIjaPkfndO8S+9W5FihIt9HtTQylI/SqdGCFFITJyZNBJRK4O3xuIuklQzrmTy1Vy8DpNODV2psGv2tapee4HsaI5N/hfRttuw2iRX48mzlZUcmf/+IT/tDfqjGfn2RBj0E3jjXTn22aZneA548d7bbxUsQedvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302354; c=relaxed/simple;
	bh=hLqLEQW//H7SR70Dq2KNBUCQqAo7BcQp3/CyUvMooiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kqrj5oaHp2adCkpI0NPeebexuShKNsKdz/ROoxFtKYspsUvtIAJyhVlJlQZV+Ej9hmAa8AmXIb8qI0+37mkZBcfZKTL91Dv0EEctw3Ts9PmXP4+gn/KKjZN6BrCTvr/6/m07sZHHAe6A8mdoMqDfh3Ue2rAL71br7Az0mOuxAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLESs5Xv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471168953bdso19646555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761302351; x=1761907151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPF1f85/FJM+wJtbt8GtXxyRXGLXZOfe4gspjYrW5Wc=;
        b=vLESs5Xvgn7efmeOlvp6xX9blc8ilJaQ9lJdvkq5HWqacHjOosORm+SSGVgmGH8RZa
         TRADfzW4mWJPKxmCJ+VwVQwNYyBSKnN/vhjNiyziagbkfPNiU9bH+jwOAVxyKP9Zs/Kj
         RaREpeNgLHzMyILrC3BxndzX03slLFdvNi9eXCGvR3QzZy9qwXZzRHxSwnD0BG2AQoo4
         LuzCmnnH1YhvwMBg7HtusMgYwb/eRRJf/TJTLrzLnaN1dA0J9JNZ4tajR7e33ssHQhmG
         WBfr5dflYR0o0ArgLufYrd6L+fFQuP/wh/0WMeYvg30B877F/x/Zg+00xFbA9eVmFfqj
         P+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302351; x=1761907151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPF1f85/FJM+wJtbt8GtXxyRXGLXZOfe4gspjYrW5Wc=;
        b=GVVQcte6o6J4NkCCMNvINWd22iU4+Yd9mK4PZzz1OPAzeq3hj3I4SgrzL0Jm0zjjLd
         jxnGXkap3AaSmt+ddXecU8TziOUtrkJvEW+6H04MVJwQ9JOabsW5tdi5/gRNHThAaNqe
         wfPkBMRHxBwlqBT+PweB+PiMtt0dt7w6+O9kOOw+xJMOaOysAwY0amvj1g2COHvbOL4/
         VfFiM+TDFcu2LMrsejbb5tqpH3JVdojjDfzTp2P1NbY/lc6//PxqlqrQufts5nOHc5I1
         s4N9jwDRM7BDOTLJ6l/weY7ZtgjP560csHy94GShyHkM4mjaqfUEh1lT646VIa8g3cZb
         rT+A==
X-Forwarded-Encrypted: i=1; AJvYcCWULAMkaFy2ykpLqj6NBfyUmSrhcS/ngb17vJDFkDSZKWwEbne4+HYFWEqdF1tt82FT6hEjPkqVplcrwd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCVoJfnHC1yGFeuc7emYHcWjv+5D07C75LjrHCA8AG2oeROSd
	sBkLpRC7HZBPaDFw4wP2IPgVJfI8iQlDlAcHAObpRpN/iKv6Gf/NQOWsoXAl6kesv2oDIRPs5v/
	pT8Hipf+z0z78D2GmPA==
X-Google-Smtp-Source: AGHT+IEjUBMQGoVxUfyDuWsIaZh++ce8Z93gQtTGPdxEJaJNt3LFU5j/zdaAt8Gsv0XYS4ZhQjjGAb/v4s3GhzQ=
X-Received: from wmgg22.prod.google.com ([2002:a05:600d:16:b0:46f:c7ab:c8ce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:295:b0:46f:b42e:e362 with SMTP id 5b1f17b1804b1-475d244d6f1mr13867525e9.19.1761302351572;
 Fri, 24 Oct 2025 03:39:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:39:10 +0000
In-Reply-To: <20251022143158.64475-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-3-dakr@kernel.org>
Message-ID: <aPtXTsbU07VSGDDT@google.com>
Subject: Re: [PATCH v3 02/10] rust: uaccess: add UserSliceReader::read_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:36PM +0200, Danilo Krummrich wrote:
> The existing read_slice() method is a wrapper around copy_from_user()
> and expects the user buffer to be larger than the destination buffer.
> 
> However, userspace may split up writes in multiple partial operations
> providing an offset into the destination buffer and a smaller user
> buffer.
> 
> In order to support this common case, provide a helper for partial
> reads.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index a8fb4764185a..c1cd3a76cff8 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -287,6 +287,22 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>          self.read_raw(out)
>      }
>  
> +    /// Reads raw data from the user slice into a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::read_slice`] but considers the given `offset` into `out` and
> +    /// truncates the read to the boundaries of `self` and `out`.
> +    ///
> +    /// On success, returns the number of bytes read.
> +    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) -> Result<usize> {
> +        let end = offset
> +            .checked_add(self.len())
> +            .unwrap_or(out.len())
> +            .min(out.len());
> +
> +        out.get_mut(offset..end)
> +            .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()))

Same comment applies as write_slice_partial().

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

