Return-Path: <linux-kernel+bounces-786639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8355B35F65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BC1BA38E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE5128816;
	Tue, 26 Aug 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="h85PR4zs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01C393DE4;
	Tue, 26 Aug 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212327; cv=pass; b=KGVFxDGcMzNmKsBWZaRSVwUxVJTHp6kH3P1ThKpw0ZoLiqqU5LIwgix5+fPMyFjcptkvx2/sJUHX3UfAJ/z1RFsGZGkXfYUH5Tm9r/JJkNoYE10VpFk9ZXPeWL1NAlsDUaVLwcVGMVa5JpWMfCpo/Dpjb/9qfS++HWxcnpVM25w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212327; c=relaxed/simple;
	bh=cgXyt5xfXl8QW+Mtjr8ObjvNPMTWMv9d8Y9vFFrlEVU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qa1WQnu8odTbxQLMdu6jPAm8vGgQfbn/mQpJPQToUJJFvxH9caSaGJr6bA6vF+3Ydms32ab53m0ATIpeTj7/ZTLKd0eOa6PY3sNAvl2XjcX8+pUHHsNndoIGr6gQy10M+1Vct7CqJriFPPz8CcDCFfYYJX9xjWVrSZALtVJ+lxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=h85PR4zs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756212289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=faDuxUNFrtHNdCsA5rWdmOrAB5cZFaCeDiDvVWlgpUU7/wLujOdg95JxMvzTWueR5bGzaCEUblVGBPI2Izf5HTUM7gu2ebOIB6CFCYOMPvk4vYkt2kwjiWv5/exN1lTH1J9ybDimu1uRjyD29MM5xvBIxvtE331yujMg2ZzJutU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756212289; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Md+QcIwMiOUfkxOiluRJOn1bJ+/RWxPtO7PViPrVhfc=; 
	b=Yf/xgXxcDKo2nTN4Ak21t4XYKX/vYNP2AW4HsptaeiUm8ZYOVp2CxMXzE6vv7JopdXNe0Xrh857fvWywvuwuF8mtPb2oYAOkJseiURYYVdKtfQwnj4Mi3+bLzba13PE1IYOphFxZQB/l8u1cyZlH4PrygNVOccUbNVvAEctwaWo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756212289;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Md+QcIwMiOUfkxOiluRJOn1bJ+/RWxPtO7PViPrVhfc=;
	b=h85PR4zsNTuWyosBbM2yCk2yIV+WgQERUHyFPfMMZpmriLrOpl6z9qQ5zRcu9l2Z
	FHA0aBLs3AorXdawVveH1X1gAjQF+6zAGvah7gulR0xgISFeQsJDkX848geTnLT/z0a
	DU2h9TmZLRiLP4BoI8EctkcFUFRkjFfYtd596yGk=
Received: by mx.zohomail.com with SMTPS id 1756212285951853.8496760532269;
	Tue, 26 Aug 2025 05:44:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250821035710.3692455-2-fujita.tomonori@gmail.com>
Date: Tue, 26 Aug 2025 09:44:27 -0300
Cc: a.hindborg@kernel.org,
 alex.gaynor@gmail.com,
 ojeda@kernel.org,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com,
 dakr@kernel.org,
 frederic@kernel.org,
 gary@garyguo.net,
 jstultz@google.com,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 rust-for-linux@vger.kernel.org,
 sboyd@kernel.org,
 tglx@linutronix.de,
 tmgross@umich.edu,
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <793E15AB-D69C-49F5-823E-A57F343BA3F4@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-2-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Fujita,

> On 21 Aug 2025, at 00:57, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add udelay() function, inserts a delay based on microseconds with busy
> waiting, in preparation for supporting read_poll_timeout_atomic().
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> rust/helpers/time.c       |  5 +++++
> rust/kernel/time/delay.rs | 34 ++++++++++++++++++++++++++++++++++
> 2 files changed, 39 insertions(+)
>=20
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index a318e9fa4408..67a36ccc3ec4 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
> {
> return ktime_to_ms(kt);
> }
> +
> +void rust_helper_udelay(unsigned long usec)
> +{
> + udelay(usec);
> +}
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> index eb8838da62bc..baae3238d419 100644
> --- a/rust/kernel/time/delay.rs
> +++ b/rust/kernel/time/delay.rs
> @@ -47,3 +47,37 @@ pub fn fsleep(delta: Delta) {
>         bindings::fsleep(delta.as_micros_ceil() as c_ulong)
>     }
> }
> +
> +/// Inserts a delay based on microseconds with busy waiting.
> +///
> +/// Equivalent to the C side [`udelay()`], which delays in =
microseconds.
> +///
> +/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a =
bug to
> +/// call this function with an out-of-range value, in which case the =
function
> +/// will insert a delay for at least the maximum value in the range =
and
> +/// may warn in the future.
> +///
> +/// The behavior above differs from the C side [`udelay()`] for which =
out-of-range
> +/// values could lead to an overflow and unexpected behavior.
> +///
> +/// [`udelay()`]: =
https://docs.kernel.org/timers/delay_sleep_functions.html#c.udelay
> +pub fn udelay(delta: Delta) {
> +    const MAX_UDELAY_DELTA: Delta =3D =
Delta::from_millis(bindings::MAX_UDELAY_MS as i64);

We should perhaps add a build_assert here to make sure this cast is =
always valid?

> +
> +    let delta =3D if =
(Delta::ZERO..=3DMAX_UDELAY_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_UDELAY_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `udelay()` with any =
duration.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to =
preserve
> +        // the guarantee; `udelay()` inserts a delay for at least
> +        // the provided duration, but that it may delay for longer
> +        // under some circumstances.
> +        bindings::udelay(delta.as_micros_ceil() as c_ulong)
> +    }
> +}
> --=20
> 2.43.0
>=20
>=20

With the change you suggested for the safety comment in udelay:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

