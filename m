Return-Path: <linux-kernel+bounces-867480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF971C02C03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847823A2C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080634A766;
	Thu, 23 Oct 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoq81g00"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD434A3CE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241029; cv=none; b=Fn4CP51Q4pFD50808M6/IwUTlggj0HhVFngISseagEoRp9oPg69+zZABPBOpAf6H3zmUCi20tA9BfYKc5BLj45wJKebbd+rJKPR+zfsYyMm1a6jIpUPrbyjIC+6seZThsPG+ovgfek9aaFBslL7NcdZV6iMs/FSKynoqniucWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241029; c=relaxed/simple;
	bh=06HirvpsHA5H88Oq8EDHNR5z5ZUq/iRoinMQ2IvxnIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcROqkm8WZASkpxBiulaAzHsq/N9JpLTHzwSqgHhWQwa8LCN21YQ0tH117lQLioBbs3kQ/36hkBsGpvVBjurh2G34WeslDOgGeh72GPOhBO9fj2ucUCXT/k3Q79KDl30v4hleXDE5VKmv33usOiKWgf9otDdit7M46FTx6efNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoq81g00; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78e4056623fso11024316d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241027; x=1761845827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjYGgrMz5T0b5VMHHukppf7f8eh1tUQ0s02E0HEP3gQ=;
        b=hoq81g00yPo/qkg8hcNs4fqB7icCRXh+JMft1ovNKc5W0iK4zEUw746giIUkLOPk+i
         JhD9JZepO7qWzPtNyjX8kUPVvThfM/sp129R/yhTesQW6Ihq3MKF5xg20avTjWK/8gtU
         D5Fa65TBBq8+Qx70DochSrbCI6fNF5ebXSJ2uPMY3ZcEn4IYNaUnWuzMF7SS4uyUBzlG
         2hUWf4zAPi4+LISPlr8QWbsD/ruSKx4dpxdxj1/Gi2F2n3Z+bVnKoaD9HJz1hB6nFiiC
         ChtjjlywiWlnvsAU/L+J1hsia2t7hqS/gO82v6ugVTzUgGnVXtzUkFxCUvYy9VBpVOI2
         wWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241027; x=1761845827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjYGgrMz5T0b5VMHHukppf7f8eh1tUQ0s02E0HEP3gQ=;
        b=vQZjUFPkrrGQR5Ytn7Fs/IXdeZ4EWi106J2H29kA7uV6HDWjsIyREq5SH+9Hu2Z928
         Vc3pVTD7bZIQyExTZgLxvOE0ALLsDhq3S9T5pvTkDxVMV6UJXb0JX/rwkHvgzJ+cQGME
         gYD4SrmdBWLWqHvVq5MMq5ySveamQEtv/4be6QDJaLWKF3AZJ5lYFKsAIL1DiotiuxI+
         fjTLMEDMplel+3aJPr+GsxSRhCJ/1pfkC1Aoxcc4OoduSbBTd0EYrrIHTeXaQVBw28Y1
         abtSTXL/lDtl2yYhCGvvpB6+QbUPagNLWGh/7MOXBZ6RngBw5sZbndTFZRUcIi6wqFTI
         ix6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXByCMmH6wnb0S+gDs9DHd8Of9B8ZmQ+mDqy7SnENIp33EbROcFQseYb2motwKNAMvr2XArL3wWqS3Bwrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEZccRYdMzih3+2cofK49dDRowSoTIKErYp3AJ5PczR38EUCp
	/vwr1wjoMM59CSFEKiTV4kQurZ19dSIkUe1m/xFvRmZyeaa5WfZGFUIH
X-Gm-Gg: ASbGncujwbs0qSfVd/vvkGPpqzxB+Z4NHyqv6Y4wpp9sLfo2p4C0mngzfOhm5TXVvw7
	9RYgVcjEiW7R9EbO627LxUhGR17S5YA+xzhWJRFZW9TMVQlxHpFngwp7KLayObWFmFhVbzDGAnZ
	k0riAXYbVsuijo+VpWHTHtPP+ZwHLintxMBHUanKxDzpybyVwunm4UDuEzWuYxsqz5leNu3z2AI
	SiLjwZaxi79k/RYZyfqh0FKoHQDbWuTlTCwzxqtUC9WcrSwzjLvSTvWojPmX3K2TBwWx3TMpqJE
	RbCNAjEFFYnv1kIZn8szDCycZBkHMJoYQWLkT7tC1tpu1I2WPYxRvH6+/RmQGHELWuCwZQUh5jn
	rDxGtZDV48+Q8hHKt2+s3sCKRUuaigSSGlYCP4lhO8SykrF0CrmQrsz9kH3tiqCf2QlNi8Vav
X-Google-Smtp-Source: AGHT+IFAGIHHoYhhCFsRnrO4Ko8G5PM5fRjatDHknRXVMiCASWYuq5FB5OcIT9AF7oflvkgJXcABAg==
X-Received: by 2002:a05:6214:4e01:b0:87c:21db:cbbe with SMTP id 6a1803df08f44-87c21dbcdfamr282156576d6.26.1761241027082;
        Thu, 23 Oct 2025 10:37:07 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7d254csm19085796d6.32.2025.10.23.10.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:37:06 -0700 (PDT)
Date: Thu, 23 Oct 2025 13:37:05 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] rust: id_pool: do not supply starting capacity
Message-ID: <aPpnwXGo4P4-WI6v@yury>
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
 <20251021-binder-bitmap-v2-3-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-binder-bitmap-v2-3-e652d172c62b@google.com>

On Tue, Oct 21, 2025 at 01:32:45PM +0000, Alice Ryhl wrote:
> When creating the initial IdPool, Rust Binder simply wants the largest
> value that does not allocate. Having to handle allocating error failures

That "value that does not allocate" wording is pretty confusing.
Maybe:
        Rust binder is initially created with an arbitrary capacity
        such that the underlying bitmap is held inplace.

Regardless:

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> that cannot happen is inconvenient, so make the constructor infallible
> by removing the size argument.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/id_pool.rs | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index a41a3404213ca92d53b14c80101afff6ac8c416e..126e57f34c3407cb1dab3169417f01917e172dee 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -96,16 +96,11 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
>  
>  impl IdPool {
>      /// Constructs a new [`IdPool`].
> -    ///
> -    /// A capacity below [`BITS_PER_LONG`] is adjusted to
> -    /// [`BITS_PER_LONG`].
> -    ///
> -    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
>      #[inline]
> -    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
> -        let num_ids = core::cmp::max(num_ids, BITS_PER_LONG);
> -        let map = BitmapVec::new(num_ids, flags)?;
> -        Ok(Self { map })
> +    pub fn new() -> Self {
> +        Self {
> +            map: BitmapVec::new_small(),
> +        }
>      }
>  
>      /// Returns how many IDs this pool can currently have.
> @@ -224,3 +219,10 @@ pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
>  }
> +
> +impl Default for IdPool {
> +    #[inline]
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> 
> -- 
> 2.51.0.869.ge66316f041-goog

