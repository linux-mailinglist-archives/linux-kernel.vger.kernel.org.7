Return-Path: <linux-kernel+bounces-745592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB9B11BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C144177F14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F812DCF50;
	Fri, 25 Jul 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtpcPhjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE992D4B57;
	Fri, 25 Jul 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438257; cv=none; b=L6b7ngzM45/cVj30f8jazSLDJNMCWuso0AEBSpO9QrzGKQD4LaaDWHC498ccElvo1pX5bJrhD7vCxCRXaXcnVszYngHHvHqd5BRjBLOEtmO1zSn/JGjEaAfa+Cn1BTl4pVi/jfR2wjdn50meHKlUpE2Ww4CZCfOYFuPSCyom8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438257; c=relaxed/simple;
	bh=w/kRruVhK9RSEzYfppk9up+qBuWCPFlU/lKHshBF79g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eky6YybPgzFGDuTqXgMxqgZzwnqPqCFLOLmfBOd2RBIwCAn5694E1+qBTapZXmkySJgkFVAdvIbvwNdVc/JkeViOc1l5GY4LtUSB1dm0EtRIh9biWDKIv9PtEBQ040BKcdTi5drlPJU0wYrvGA6uKVYhc2WntZJbl8M3R8ILpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtpcPhjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E9C4CEE7;
	Fri, 25 Jul 2025 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438257;
	bh=w/kRruVhK9RSEzYfppk9up+qBuWCPFlU/lKHshBF79g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UtpcPhjIbcTnlS1etmvJ/1RTZWoOiLQdxYlUPXqlD4V8Jfr6+UA2GS0neiBQ1+1X/
	 hnXAxu4oi4QNl4SMqd1T0bXMU2XfeuXdNmKR3Cw21ItGlKri4WbMrOHCmRK8zcmws6
	 yQt/Svg+8/asO19ShIbMftrRz/fJE/6ZJmCfpOofTzM5gEDx04EBmeTvXOl1Bnu8gr
	 yMHXVk4CucXhdX8clxxEwHpPwUMMwwsLbGjozicy2U8VOEGWuOBmoD4GnC9HMQH2fq
	 2tKWnarDoPpug1+VINaK7BIAdadi4TctaoF0RUi2emunwHcU53FukF0a0b/5/kCuMH
	 sQE24ABlqyTtA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 12:10:52 +0200
Message-Id: <DBL1ZGZCSJF3.29HNS9BSN89C6@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] rust: add `num` module with `PowerOfTwo` type
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250620-num-v1-0-7ec3d3fb06c9@nvidia.com>
 <20250620-num-v1-1-7ec3d3fb06c9@nvidia.com>
 <DASWS1A63LYM.399CKUDL4Z7UC@kernel.org>
 <DBKTNE4OF0IB.3C32NVHQ9UKQ3@nvidia.com>
In-Reply-To: <DBKTNE4OF0IB.3C32NVHQ9UKQ3@nvidia.com>

On Fri Jul 25, 2025 at 5:38 AM CEST, Alexandre Courbot wrote:
> Hi Benno,
>
> Sorry, took some time to come back to this!

No worries!

> On Sun Jun 22, 2025 at 5:11 PM JST, Benno Lossin wrote:
>> On Fri Jun 20, 2025 at 3:14 PM CEST, Alexandre Courbot wrote:
>>> +                /// Returns the value of this instance.
>>> +                ///
>>> +                /// It is guaranteed to be a power of two.
>>> +                ///
>>> +                /// # Examples
>>> +                ///
>>> +                /// ```
>>> +                /// use kernel::num::PowerOfTwo;
>>> +                ///
>>> +                #[doc =3D concat!("let v =3D PowerOfTwo::<", stringify=
!($t), ">::new(16);")]
>>> +                /// assert_eq!(v.value(), 16);
>>> +                /// ```
>>> +                #[inline(always)]
>>> +                pub const fn value(self) -> $t {
>>> +                    self.0
>>
>> Let's add:
>>
>>     if !self.0.is_power_of_two() {
>>         core::hint::unreachable_unchecked()
>>     }
>>     self.0
>
> Sure. Is it to enable compiler optimizations by making assumptions about
> the returned value?

Exactly, it will for example turn dividing by it into a right shift and
prevent a branch for the zero check.

---
Cheers,
Benno

