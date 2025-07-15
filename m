Return-Path: <linux-kernel+bounces-731471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE7B054DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F25B17ADD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9F274FDB;
	Tue, 15 Jul 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGWM78GN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D332253FE;
	Tue, 15 Jul 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568071; cv=none; b=fpBCR0pGmw1STEwNN+BpwemAZgUP/e9T6d40p4Z9wX4VsRiojXQwl1yYpoSaysIehVE9j3Y31tHlNFanUTumIqe2QZW9UkXTlEOV8OVDuwQ97EBPExPItt56JySzavUdVuwosZ//VeBDDSqFJdlLN7pLSpB5FBCm6hcNW7ImE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568071; c=relaxed/simple;
	bh=y3xFDIGFBDQ7/2ZnpboVuHHoy99yqCXaJ44aZphq0Jw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SGUUcg5qGfqetZLE4xnD4+Pr1wLP5A2hlOSBNsh7Xqoa+CI9A+DidZ40dwOmO3q0+MUUPrHWKuyTORPzGq1D5ONAHOs8daOUD4u672uDdhUYRLfaoPWSeff8pMappUMANBDLN28N+67qsNFljHHUzODDbVHtuh9RA2NWOXq7QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGWM78GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BADC4CEE3;
	Tue, 15 Jul 2025 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752568070;
	bh=y3xFDIGFBDQ7/2ZnpboVuHHoy99yqCXaJ44aZphq0Jw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eGWM78GNXV7hk+5EcCroUVyNEdLqVqqYOj5L/Q0Wlw/lPp/gVYhpXOmbo1JakPY4G
	 kCvv5s6BIEriJWxl+r8WuFvGfeI9/ZxWss3qzTNV3aA7ODM4jsq8u0sC9QNv39vwwY
	 dDk7mTXRbNrM5egbBIK0JK+4WZg0xB+GTj9a1Q5mvvYrCJL5nCfQ81N2Wi2Sdd23Oz
	 EbeGa/RdI8CMzmHQp6BbvUSRbm9inhtJ0g3gOAMJNXwlc92HcB0zYikZN/Qv6BjXs2
	 cXXwH45Cm2Q/88kIVyq+KIcnAQST7Uj+2YgLtRonc/mXofzgphPemqkQTBxjRhxAeT
	 Fe0WazcCb+5uw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:27:45 +0200
Message-Id: <DBCHJ2HTJMQS.175D313DV5Q7Q@kernel.org>
Subject: Re: [PATCH v2 0/2] Add Opaque::cast_from
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
In-Reply-To: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>

On Tue Jun 24, 2025 at 5:27 PM CEST, Alice Ryhl wrote:
> Since commit b20fbbc08a36 ("rust: check type of `$ptr` in
> `container_of!`") we have enforced that the field pointer passed to
> container_of! must match the declared field. This caused mismatches when
> using a pointer to bindings::x for fields of type Opaque<bindings::x>.
>
> This situation encourages the user to simply pass field.cast() to the
> container_of! macro, but this is not great because you might
> accidentally pass a *mut bindings::y when the field type is
> Opaque<bindings::x>, which would be wrong.
>
> To help catch this kind of mistake, add a new Opaque::cast_from that
> wraps a raw pointer in Opaque without changing the inner type. Also
> rename raw_get() to cast_into() for naming consistency.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

For the series,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

For the DRM parts,

Acked-by: Danilo Krummrich <dakr@kernel.org>

