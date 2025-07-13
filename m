Return-Path: <linux-kernel+bounces-729171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61AB032BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60573B66C1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E105288CAF;
	Sun, 13 Jul 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0a/Tz8p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7C101DE;
	Sun, 13 Jul 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752435573; cv=none; b=hdHwoGLuIbC4DlQEDvEcap9rSVLeh1qHjNwYpsSxk1IeRixxNbnENR1rhsecP1yndxw8eREl7au86B1Rk/vVCCY2JvyVM+AAqS2Jxa47tMxjiu9HJhzCiFAGZpycLf+Jlyyc0j//HP5tgAykssm4yqkqNcePu1ryySDrTXxuD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752435573; c=relaxed/simple;
	bh=sfEn1I5i+QUg/l/2uInTia98GmnhXDmt3cOxD3uvwIU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qnfa40o/WNJT6ceL3Y/owb9adaRuznhb35Aao80bwI3gaZ9UJ0kr6FyuyEF2Blfro3toSO+OGVOexWUMj17GafnChhbOCLqLTHtCzZFrcfcTFqH81NZoKqYAkmptvgNnoucCWXpk/Wxufp2fFNzPJJ3VvIoIjVAnMmkzmKrBvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0a/Tz8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA50C4CEE3;
	Sun, 13 Jul 2025 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752435573;
	bh=sfEn1I5i+QUg/l/2uInTia98GmnhXDmt3cOxD3uvwIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0a/Tz8pxoB3Xpxt8M5GrnaZKujHjjGGJL25sunD1cwoWHzwdQ+JDST9UtYrIW2Wg
	 T45oxqhuA8+HOZlHPitj/xxO7O/dqLoAN7ibDSywkjwYZhthRAgNZdMzhnhN5UQbvh
	 hS4xfBsdzYN07GaF6GxPS5/1Pc6V9S7P7rFs9wan/6wVySSYleF6DXo5I1wCC845D8
	 cHwpMgrdlphjfHeyDU3MzToJEJf4+rgySj4Ygs9kwKuiblO++FLRkvzk5UXsC1mp9O
	 GYDn7HgeL3j23Vyut5kDRLNAzqb9gdW1/h8CcKK+Qgx6dIzY6Y/pMBE1qTqpYdTO+n
	 A+BNxOIq8phjQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 21:39:28 +0200
Message-Id: <DBB6KA2H1RSC.1V4D292UTIB09@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
X-Mailer: aerc 0.20.1
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
In-Reply-To: <20250713182737.64448-2-dakr@kernel.org>

On Sun Jul 13, 2025 at 8:26 PM CEST, Danilo Krummrich wrote:
> Provide an unsafe functions for abstractions to convert a regular
> &Device to a &Device<Bound>.
>
> This is useful for registrations that provide certain guarantees for the
> scope of their callbacks, such as IRQs or certain class device
> registrations (e.g. PWM, miscdevice).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/device.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

