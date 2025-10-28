Return-Path: <linux-kernel+bounces-874584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B898BC169F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 714493568F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BF34F481;
	Tue, 28 Oct 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/AJOvJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37525784E;
	Tue, 28 Oct 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680014; cv=none; b=bwhMLbSVPJot7qwi/C/6667fMdzavYt/HksKTALT6PH0CGi1RmGRi54y7A1Myyu7HZCPL3aFmsH2hSsURNmNxoA3XTyeXI9GJ6Qbv8/XK5BJEVT8JHLIT/JPQDvqnTZovysGwAWH5KyA7xzL6vojRvVoSodrEqFQNQtIrhRCVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680014; c=relaxed/simple;
	bh=/aaILh4Sb4dqcUqp6HGcNIrngphl1Uu0/ZivAdehfH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiuG8rMOS+11PK+GsOKKOsTP5Rb9uoCdk0yLMubj3hqk+vqiwbjq+f3BocKuJPcvRAC8TI2KzI9EufhjMeY91Oz7i3uHETQghCWXT5deqTMVrs5Mpa9evF9woE+aFoyR2TJ/w3ziIshe0e6naMev4tD6zX1PVHTqbAiTnEJgi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/AJOvJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2C4C4CEE7;
	Tue, 28 Oct 2025 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761680013;
	bh=/aaILh4Sb4dqcUqp6HGcNIrngphl1Uu0/ZivAdehfH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f/AJOvJyoe4eD9ZjS71zbvG32E4Nnwbvgbpd3LwmI0SZ7fJ/Ot5VbfI33Co5NJmUO
	 43PbDLJQjAKJcaeTD2/I8YtP8I+qa4LM3bEYQJrKy5rhnblF3tTrVsnZfcfUd7bfdk
	 eaaROZrXu1g1ZtiSTgU7d2bgUu/F7Opbw2SB4Rtm52vUayN7VEssFwvZAkGtTDt/8i
	 Nrl2EpRYR1nOCLvYCKvNPi54/A5J0QGSWmGvQQmPk1R21HpGK856JYVorXsJvRWIfR
	 1vtCoZarVhrbX7d/38U/dAPPBbHVGViEK9Fs65StZUG1VHlSQVYNuUikuIXRDkrxN4
	 FiQ1SISXaPhCQ==
Message-ID: <e0a78e58-1b83-47f2-b030-52539cf63ff8@kernel.org>
Date: Tue, 28 Oct 2025 20:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new ids
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yury Norov <yury.norov@gmail.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 11:55 AM, Alice Ryhl wrote:
> +/// Represents an unused id in an [`IdPool`].
> +pub struct UnusedId<'pool> {
> +    id: usize,
> +    pool: &'pool mut IdPool,
> +}
> +
> +impl<'pool> UnusedId<'pool> {
> +    /// Get the unused id as an usize.
> +    ///
> +    /// Be aware that the id has not yet been acquired in the pool. The
> +    /// [`acquire`] method must be called to prevent others from taking the id.
> +    #[inline]
> +    #[must_use]
> +    pub fn as_usize(&self) -> usize {
> +        self.id
> +    }
> +
> +    /// Get the unused id as an u32.
> +    ///
> +    /// Be aware that the id has not yet been acquired in the pool. The
> +    /// [`acquire`] method must be called to prevent others from taking the id.
> +    #[inline]
> +    #[must_use]
> +    pub fn as_u32(&self) -> u32 {
> +        // CAST: The maximum possible value in an IdPool is i32::MAX.

I think this should rather be an invariant of `UnusedId`.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> +        self.id as u32
> +    }

