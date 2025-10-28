Return-Path: <linux-kernel+bounces-874790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68948C1717B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C75021CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC72EC096;
	Tue, 28 Oct 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVtfuX2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEB2EB5CE;
	Tue, 28 Oct 2025 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688001; cv=none; b=V75Wq9nP95HrXzjT2wpe4ilU0fXzKzdW/hnhrYgHG9DOOjPp9ryw9aOdsX3bKxd4KnEHIGUMo9YS90o6Qcb2eirtpG7egGEqdVcxUvcRbBltfERMjzAP82ALrNRf0uOaEHfEqbjzop24CX2nBop6/4mts6pvNOeHE7KOCOiiSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688001; c=relaxed/simple;
	bh=98qCRZHWGnqg7xDIKMCuNXdBxkmWnC/wKM3LJ+sRPFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=HKgKSUDWATb4RW9wIydMBvDz9PgMhqjet9sDYlQK8TXz6k6ojKBFIxU4CkEf/VhXlYqX4vp1Lek7M5kWUnElrvfG3b/lyor918pG/8a5QUOduCWP0vdi3gPZqojqRmS3EnCfpEnkVSM6dgSLelm390TNdRtMZuqeCUH5yVTE048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVtfuX2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64041C4CEE7;
	Tue, 28 Oct 2025 21:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761688000;
	bh=98qCRZHWGnqg7xDIKMCuNXdBxkmWnC/wKM3LJ+sRPFg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=sVtfuX2mfhe82Bqy0W5riLNw1p7s7ncgziLHl3CfjgIBjfGYXCbdX5nBw9KftTIOr
	 WwR4CE6Yf9D3erkZwldSmaF045xibBCcag/QJxUm1betWBzX26jCe571MV+KkQgPSQ
	 dzzFx9h2I3bqy18Fl5eKKvXmQJaUmVpXQ9Cs+81GlyMyX88srQ+sO0sdEi4D9hiFzg
	 DeaPlqBklU1zibVdTw+n6E6ySliU8+hOEoh3zCRDSGo+dVVtCfcEgLizGZ3TUKCf7Q
	 ddMYgw0jhXtrygJK3X/POWEKM3crI1411K/IIfDEwMZNjRRmK94Q4G7H6bEU9viO6H
	 MdTP4OtWIR6kg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 22:46:35 +0100
Message-Id: <DDUA9WI1KASO.ECSJNA3RRQEI@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust/dma: Take &mut self in
 CoherentAllocation::field_write()
References: <20251028211801.85215-1-lyude@redhat.com>
In-Reply-To: <20251028211801.85215-1-lyude@redhat.com>

On Tue Oct 28, 2025 at 10:18 PM CET, Lyude Paul wrote:
> At the moment - CoherentAllocation::field_write() only takes an immutable
> reference to self. This means it's possible for a user to mistakenly call
> field_write() while Rust still has a slice taken out for the coherent
> allocation:
>
>   let alloc: CoherentAllocation<CoolStruct> =3D /* =E2=80=A6 */;
>
>   let evil_slice =3D unsafe { alloc.as_slice(/* =E2=80=A6 */)? };
>   dma_write!(alloc[1].cool_field =3D 42); /* UB! */
>
> Keep in mind: the above example is technically a violation of the safety
> contract of as_slice(), so luckily this detail shouldn't currently be
> causing any UB in the kernel. But, there's no reason we should be solely
> relying on the safety contract for enforcing this when we can just use a
> mutable reference and already do so in other parts of the API.

While I generally agree with this, the catch is that it would also enforce =
that
you would need a lock for calling dma_write!() in a concurrent context.

I.e. if your CoherentAllocation is shared between tasks we can currently ha=
ve
the tasks calling dma_write!() and dma_read!() concurrently without requiri=
ng a
lock for the CoherentAllocation.

Requiring a spinlock for such a case wouldn't be the end of the world of co=
urse,
but it would still be unnecessary.

