Return-Path: <linux-kernel+bounces-883033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2673C2C51C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1004F72DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C8275864;
	Mon,  3 Nov 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffDjxGdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FC274646;
	Mon,  3 Nov 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178493; cv=none; b=V/Glk/pR2oCnIFCHb6Ma2fFWKsWRfG+611FMG8cc2/jIXHkJrJd3gphMaX0Nu3G7aSUBALJ87H4iVsWh50+rPeJQXlQdwtUFzICF8wxR1wFyoVx5pdpowwQnLbrrtliX69qiaGwP8ObL91rO1C+3anxaJGkU0Px/wDq1efr4uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178493; c=relaxed/simple;
	bh=9i56/G1cBFWeHj/jlFaJn9+jDjNoi25S+6FGz2cT5rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVIYQ6qMoWiiQkBtJfNUrrFMMR7N//padi3Kw8JiyCLyb6bOGJqi19NryuJlpcWRgLoI8x9MJz3iZLvCDvP9MfvTFvzEmyrylxkhQhZvebIke+arMI39Cjf/ScL+KLD726t2B/HWh5PeJGjub+ii3Gi+hqUAxgazRZcPJW5fedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffDjxGdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9095AC4CEE7;
	Mon,  3 Nov 2025 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178492;
	bh=9i56/G1cBFWeHj/jlFaJn9+jDjNoi25S+6FGz2cT5rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ffDjxGdhXNB79Vv/mrgJez1dU7L3Gma19SsI8nIf7gLZD9p2efUQSM/rGjuBy40j/
	 oSsySfEbtU9HSONfE0SDXSWy3/RQRYNXAMovlYjldk+yIL2cSE6mPi6Ds3yxpJjvJG
	 E+s+fYm6RG9yICD55w2bJCPxqlySveUXVWClThqYqub5VWqqUKwKRQWHUgfmsTfOAh
	 TtgHQGwvCTK1VTZ1zbkinao3NrN9UXrpI2HhiNh2hURxPcB0AqDuJu3ETtEqxe2jgE
	 6Giy/STsRtsq/U4Veos69Wy7jg9lYEHgOCj4iRfBr6fXY+g29Ew7xBfW/UZejna1SZ
	 dc1Fwvh/+g/Ug==
Message-ID: <5912e3be-f877-43c5-9912-f9702f15d8b3@kernel.org>
Date: Mon, 3 Nov 2025 15:01:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com> <aQgQv6F0Ao4DH6U0@yury>
 <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com> <DDZ41ZUCG09M.KYZOZGQ2TRGT@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDZ41ZUCG09M.KYZOZGQ2TRGT@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 2:57 PM, Alexandre Courbot wrote:
> Actually - the core library names similar wrapping types `NonZero` or
> `Wrapping` - not `NonZeroInt` or `WrappingInt`. So this type could just
> be called `Bounded`, as its generic parameter makes it clear what it
> sets the bounds of anyway.

+1

