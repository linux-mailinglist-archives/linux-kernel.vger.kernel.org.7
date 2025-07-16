Return-Path: <linux-kernel+bounces-734096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D7B07D02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21694A1ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD429AAFE;
	Wed, 16 Jul 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUF94rJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B20279DCC;
	Wed, 16 Jul 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691107; cv=none; b=DIm3OYoNZMSHfdZZVQ+/nsP4ANz6q4HQ+BmludChY6+HzwXoAfbZSeio+ddQdXN4I5oaDkAD2Y6q+zNLUzCFNDANiYQwfOB/6NAndbSSeksA83a8OOU+ouYeNBiL6PlQKbCze94TspGil4FC1lW/250G7+XGRsx96WEro8AO4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691107; c=relaxed/simple;
	bh=L1RjigCAcvXw4kytELgCkq+euzJAHmL8+HzNUT2jfSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=AvBW82mIxWcsApQNxg6sH5b/n6IB4glwCLqIbHJBHMlQbrNuWWdEVmmTVcz0QGZFjSixWXbx2A46y/ql3ZHHF0BG623KpvBkzs80BZt+OTLYvUKHNXuxeJ838XHHRhnkj5PypFU7gZLsfSX9GibKVA4QUJ5hIbtXDtWlzeO27tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUF94rJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F901C4CEF1;
	Wed, 16 Jul 2025 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752691106;
	bh=L1RjigCAcvXw4kytELgCkq+euzJAHmL8+HzNUT2jfSs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=CUF94rJoo8yZoTw7ImHOmVQyeH1ISQ2fj5SBQs4VCyuj2EwHYD+3Fm24oxcRdCrNR
	 LVdUA8ve/kZHCf8LQg49yg1BpASY5KmOu5ugwx3iObOQYnxzp3+yeW5NgO6+v0T0aF
	 qJan3sMXCMUyyqGKWb9IXKj7hr7uzuK/6dlo1EPApuSce+O6iuFRAmCq/WNarGCXih
	 0OeRZFT1QXKM5bqdMEo7bE/E4+DiQjeZyltzspU6N24BHXfsiUA3kRYRsdKUJGMGx/
	 +oHku0ePsrdV486iya/Bm7H+vifcg7yzAmP/lQttuZQgBZ/0l44FO76Ote01H5d1K4
	 Bv57m7nbmS1tw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 20:38:22 +0200
Message-Id: <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
In-Reply-To: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>

On Tue Jul 15, 2025 at 1:29 AM CEST, Daniel Almeida wrote:
> +macro_rules! impl_genmask_fn {
> +    (
> +        $ty:ty,
> +        $(#[$genmask_checked_ex:meta])*,
> +        $(#[$genmask_ex:meta])*
> +    ) =3D> {
> +        paste! {
> +            /// Creates a contiguous bitmask for the given range by vali=
dating
> +            /// the range at runtime.
> +            ///
> +            /// Returns [`None`] if the range is invalid, i.e.: if the s=
tart is
> +            /// greater than the end or if the range is outside of the
> +            /// representable range for the type.
> +            $(#[$genmask_checked_ex])*
> +            #[inline]
> +            pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) =
-> Option<$ty> {
> +                let start =3D *range.start();
> +                let end =3D *range.end();
> +
> +                if start > end {
> +                    return None;
> +                }
> +
> +                let high =3D [<checked_bit_ $ty>](end)?;
> +                let low =3D [<checked_bit_ $ty>](start)?;
> +                Some((high | (high - 1)) & !(low - 1))
> +            }
> +
> +            /// Creates a compile-time contiguous bitmask for the given =
range by
> +            /// performing a compile-time assertion that the range is va=
lid.
> +            ///
> +            /// This version is the default and should be used if the ra=
nge is known
> +            /// at compile time.
> +            $(#[$genmask_ex])*
> +            #[inline]
> +            pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) ->=
 $ty {
> +                let start =3D *range.start();
> +                let end =3D *range.end();
> +
> +                build_assert!(start <=3D end);
> +
> +                let high =3D [<bit_ $ty>](end);
> +                let low =3D [<bit_ $ty>](start);
> +                (high | (high - 1)) & !(low - 1)
> +            }
> +        }
> +    };
> +}

Just for reference, I asked some questions regarding this code in [1].

Additional to "Why does genmask_u64(0..=3D100) compile?" I would expect the
corresponding genmask_checked_u64() call to return None.

[1] https://lore.kernel.org/lkml/DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org/

