Return-Path: <linux-kernel+bounces-600268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FEA85DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4D99A2367
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C32BD585;
	Fri, 11 Apr 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Hoonq1a5"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703D221FDB;
	Fri, 11 Apr 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375559; cv=none; b=gGWnRupOklcTOTWr75N+uVu0udd9FlJGrDdq5l+MXwF+lM+4HFa9zm7Cx1uhHBxe146Q8zkwxDuoKV+UFP3QyHQS6aqSy0XLikpxogrUt1sd50peNSibFQhbOW5G1vF48EWml7R0KbjuT2JMMCWnAeBd0GBzpVTHiic4WrdeET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375559; c=relaxed/simple;
	bh=/HNd+QkoMbeAX0KHP75tvcfQbMwYgYkOOj6Tg9PEK+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAV+Ke0CPEKG6gz8sWeB7dEec+3JbZtk9ExsEGUJuptMyolNk7UkPyvFMOvbdqKFfugF7gzC78YkoxrZ+GoKUIUZdm20SvBiXKV5Id9XqRid0vd8S8+BhAd3MiVWvjHeLeEeuXVsZMPeMssnhGs2YvhlwDnipiO/nE/daTE23Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hoonq1a5; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744375555; x=1744634755;
	bh=Fh+FKGX+Y9fOCN69/ljiuvLedUjPMaCkLNhQDgz4a2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Hoonq1a5EgdoisHqgZgwpPaHOb4t1YHkLKLOG+hVYxDrw79mkLxLaf69CU2sTIsR+
	 64E1af/4QFDDQsiRuEwY9sll1WMlATWiYtRnJzHX32ZF2nO4EJhpKoNydG6EFhpB8J
	 ieDLCPnzumwClJHOpzHY2Wa1tUx0fV3ktDaeQZS4CiBUCyQbh79p9GKlcIcOtIeay4
	 0yREd0qIU49xsbyljc/nGPYQwh/3DJUDFDRYtjDg7JPID7mtZqklUasrV+fFKSU9H9
	 plROzvJBg8axrIIYL6puLihDMpkqFAOxLk2xTW+wf9BhfRcnZElGrJgAXRCRnngBu2
	 /w3nBJ5Vtvi2w==
Date: Fri, 11 Apr 2025 12:45:51 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D93TIWHR8EZM.25205EFWBLJLM@proton.me>
In-Reply-To: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3b63c182f67726b2715a931202f2c16430149f9c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 9:14 AM CEST, Christian Schrefl wrote:
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272=
670e5e29b0ff924 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -5,14 +5,18 @@
>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmwar=
e.h)
> =20
>  use crate::{bindings, device::Device, error::Error, error::Result, str::=
CStr};
> -use core::ptr::NonNull;
> +use core::{ffi, ptr::NonNull};

Ah I overlooked this, you should be using `kernel::ffi` (or
`crate::ffi`) instead of `core`. (for `c_char` it doesn't matter, but we
shouldn't be using `core::ffi`, since we have our own mappings).

---
Cheers,
Benno


