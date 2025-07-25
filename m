Return-Path: <linux-kernel+bounces-745880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0CB11FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68313BD36C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9F25C804;
	Fri, 25 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gLszndTr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22271E86E;
	Fri, 25 Jul 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453013; cv=pass; b=rb0P3uipp7TOTKMIhDjjzNM/oZxheJPk4MT9LF8VquCO/NAWq+YWY0vwZ9DJg279jCU9ngZFVLblZG8crQHOqniAoXXerTKdgvZFHJgm01+BT0tifysBCGZTXbTdzIV2+CZPaOIbHTMp9JxGJHkLhprU9Ci02Wq/XuZdj+D97Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453013; c=relaxed/simple;
	bh=KnfWWrxdkFr01lZpxeJ4tuJauoEGSDa2fhth//QN9+c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=awPaPMrAE5cMl65/e/xdbQlGSyAcDBHgMYYWti5FtwEvQrYpkvo2MkqLJOi2AwF4gyWLEr9+oPOeqUWng6AU4DwhISVMcxe8Ddqvrl7ti7B5vPdWubWTkTkYfRDEFZLKe+rn0M+oJXiBJJhADB+T7KOV9d4JH03XZhyTTco8054=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gLszndTr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753452989; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bHcOJHwZ2XuYgp3rIkJZq4dzewkiFowJpFs76HWkEZCa74T3wIIjbEZOnQekvHTraTDDTYPEXBozue/RXkmEOa1ScFceaFdMVsvH0DEIOEqCyRvfBnb2s7JoDCaAOaTKFeQ5MKgAuWfqzTn6G7cBrW5pTqfBLvGSbTa6z7PDHNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753452989; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UWxWLezBsY4cXQqMdYfPx06eRZqfr604fuIaX3KcaUM=; 
	b=nVPAc13ZoreZdx3EOCdREqzUnG5Fdas4HxnSN94v7Qx+S2QvjnYXL43tjLK71UfLIkeqnZenxgTG2YNFeM4zuAcKuHcLOUnf1Ab6QudBjNZBm3IpvheJn5BhNN/4BLNOAfZVeu/OJfmVPaUwfzNBinge7GTE4a3U6ckSwNn+Kdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753452989;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=UWxWLezBsY4cXQqMdYfPx06eRZqfr604fuIaX3KcaUM=;
	b=gLszndTrdom+J/qq9ssYpEvT71TuA67TPlzUZHfTWmU/32aUoZiKhB8ri6T9Zn6x
	MBU6eVhKoNS8a+Y5wMgHYLVTAJbs72Rb8X4w2Q1zSef/EfWTKbg7GYFheDe/N+hw+pu
	epo9+3BgMJIeksXTkQ+IO8Q4bBiRJCB4kBwHMFiA=
Received: by mx.zohomail.com with SMTPS id 1753452986756519.8609749819647;
	Fri, 25 Jul 2025 07:16:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/7] rust: hrtimer: Add HrTimer::raw_forward() and
 forward()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250724185236.556482-4-lyude@redhat.com>
Date: Fri, 25 Jul 2025 11:16:11 -0300
Cc: rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A89EA6C-7683-42CB-BA0E-0ED538480991@collabora.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <20250724185236.556482-4-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

[=E2=80=A6]


> +
> +    /// Conditionally forward the timer.
> +    ///
> +    /// If the timer expires after `now`, this function does nothing =
and returns 0. If the timer
> +    /// expired at or before `now`, this function forwards the timer =
by `interval` until the timer
> +    /// expires after `now` and then returns the number of times the =
timer was forwarded by
> +    /// `interval`.
> +    ///
> +    /// Returns the number of overruns that occurred as a result of =
the timer expiry change.
> +    pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, =
interval: Delta) -> u64
> +    where
> +        T: HasHrTimer<T>,
> +    {
> +        // SAFETY:
> +        // - `raw_forward` does not move `self`.
> +        // - Self is a mutable reference and thus always points to a =
valid `HrTimer`

I get what you're trying to say, but IMHO using the word "mutable" here =
is
confusing. Mutability has nothing to do on whether something is valid. =
This
should be rephrased, IMHO.

> +        // - The only way that we could hold a mutable reference to =
`HrTimer<T>` is if we have
> +        //   exclusive access to it - fulfilling the requirements of =
the C API.
> +        unsafe { Self::raw_forward(self.get_unchecked_mut(), now, =
interval) }
> +    }
> }
>=20
> /// Implemented by pointer types that point to structs that contain a =
[`HrTimer`].
> --=20
> 2.50.0
>=20
>=20


