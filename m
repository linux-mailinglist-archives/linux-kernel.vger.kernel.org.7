Return-Path: <linux-kernel+bounces-805732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568BB48CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925261899634
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520B21B9FD;
	Mon,  8 Sep 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puHaqcH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E027235BE8;
	Mon,  8 Sep 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332963; cv=none; b=EiFS7dgrM2OJizw/DGFY9krms5Dw7CeRGBJioE5Zn04Wej6tpoygOa1bhueG0UsOmTIj6OyaJzoLQr2Y7Goa7SO7Vb3gL5qBAQMcPO8FTgjL0hR9OZV3WOo3NxnchQg82HFQ7npRrrmVChFId0IpJB4mXp/rgUEWZ9ifUKEJ+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332963; c=relaxed/simple;
	bh=t11HIASYESpCmn8VJ3JPqOjRu5Sy8u7S1Z5peCBguj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1YsYjA6XywnArOdVwVcYr922CEaW/Ny7RIr0Yxgwnbk4hxSPto60poGT6qz52uULQRQgbcKu75eLtnYEfptjI8ouWOMW2G2x1+GUp0C5Z9w1SoixEdURm66au+ub7GVtzYrqMo/l4zTk9Wowo2kCfL3/csFub2pdYvsRzgKyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puHaqcH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C712C4CEF1;
	Mon,  8 Sep 2025 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757332963;
	bh=t11HIASYESpCmn8VJ3JPqOjRu5Sy8u7S1Z5peCBguj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=puHaqcH0d6MVZCTWRU3QsJC6pmfMfMFLXdD+GCFwT/jPOm3+AN2voetfv+SiTRsOA
	 1aBv0AqH1mDkJi8UcsxbAEk3j+bIkR+N1hy86Yw3h+sEOzWgICvutIpwkUDCw5IPIa
	 77etmOXjQz0KEY3/18az6ZVkDdpVVoodinj9KUr7bGy8z9xU9xTKu5+xiTHe1s6hKs
	 9tivJvDpCRTruX+UjE7Uq66WeasApBOQ0CF6rePFeESFrkKk1Eto3a6sNKLCUiNnas
	 8WcvdBaMxHZSSQF7+Ut67rxPMdmJamPZfQYdFzJ+UW66Mupwx+hqKFDYOXe6JwkgZg
	 22dd4CLDc1fag==
Message-ID: <c3e8e0fc-5582-49ce-99fe-6dea37c39ddb@kernel.org>
Date: Mon, 8 Sep 2025 14:02:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20250821-num-v4-0-1f3a425d7244@nvidia.com>
 <20250821-num-v4-1-1f3a425d7244@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250821-num-v4-1-1f3a425d7244@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 2:42 PM, Alexandre Courbot wrote:
> +    /// Validates that `align` is a power of two at build-time, and returns an [`Alignment`] of the
> +    /// same value.
> +    ///
> +    /// A build error is triggered if `align` cannot be asserted to be a power of two.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::ptr::Alignment;
> +    ///
> +    /// let v = Alignment::new(16);
> +    /// assert_eq!(v.as_usize(), 16);
> +    /// ```
> +    #[inline(always)]
> +    pub const fn new(align: usize) -> Self {
> +        build_assert!(align.is_power_of_two());
> +
> +        // INVARIANT: `align` is a power of two.
> +        // SAFETY: `align` is a power of two, and thus non-zero.
> +        Self(unsafe { NonZero::new_unchecked(align) })
> +    }

For DmaMask::new() we used a const generic instead, which makes it more obvious
to the caller that the argument must be known at compile time. So, I'd prefer
this here as well.

Either way,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

