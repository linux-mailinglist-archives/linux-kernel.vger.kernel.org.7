Return-Path: <linux-kernel+bounces-731375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86923B0535D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203F0189FA32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7C1EEE0;
	Tue, 15 Jul 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxJTX6cn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2125CC64;
	Tue, 15 Jul 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564880; cv=none; b=uKEL5qprynujc4mP0MB8CTA3HZjZDWwzLPyOV9LHXDATHfwTmLqMJQrCgPdBqyTAlUn13Azo1unrmKMqOIfW03Pfo3dTcrRwFn3ByqxzaGdEYYk8ePqEIiuLiRu2TbRIN02Oi/o6j8metFh1KH6Vjd+uwwzHG3agmYA1s65CScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564880; c=relaxed/simple;
	bh=4CL6/hyrXntz5Jzf6q4KYnN4WXadq+OD4RoZk4/8EVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVhALUmWxGraYa6Lbxl34FAf7sVgEqPMQag960RT2S/AYkBScxjsKNJ1Nv0xepnaAc5FrgmWCFXbHobe6X0rmDgGeNxkqjDgoMn1RuMZ0O7lbfoXYZn5bGg4NzEf/aXXOCY8lcSiKdRga5muwd+FdqykazDw5br8292NoJxxUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxJTX6cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7D7C4CEE3;
	Tue, 15 Jul 2025 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752564878;
	bh=4CL6/hyrXntz5Jzf6q4KYnN4WXadq+OD4RoZk4/8EVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QxJTX6cn9ikSbIL+Mbheq/UHXcecoYI7JnYpd6bLAxFnhA9ycbbcpbLefRiHGecX2
	 lalzHadVfbsb2W6mwhjfXT8enIcbpM/DznclNr7PfXPy6QwfrI3crLj7uVJmOXSlf4
	 4+3qxcCaigdsjBL8b70q5s5/85ckxuNSjzWNT47FnjxCihe1kn8/eDOeUXaQeGYubl
	 V9xsKBHF03TUYtHIqxA6j23+QOSkG6ld9jdFOYMJBSaQh176oSq3Gw97eQv9DTPMAD
	 g8AwFRmdXs4aF7TVnaeFLoVtzWV7+T0YPownhQ86oKevGdSe2UMUx9gpgBBKPP/2Uc
	 qnMfLuJfOM9dg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime
 Ripard" <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,
  "David Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Danilo Krummrich" <dakr@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <lossin@kernel.org>,  "Trevor Gross" <tmgross@umich.edu>,
  <dri-devel@lists.freedesktop.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add Opaque::cast_from
In-Reply-To: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com> (Alice
	Ryhl's message of "Tue, 24 Jun 2025 15:27:54 +0000")
References: <OeCi_sbX1kfHFfD5rJSghX6nJ6nZA25Ak9sBH6PvR8BqWfBDlxdB0ejBjYgqbzD_m18QNDU4BdjsKdtdSq4lrA==@protonmail.internalid>
	<20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 15 Jul 2025 09:34:27 +0200
Message-ID: <8734axj4ak.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

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

I think your search/replace was a bit too general in hrtimer.rs. When
you fix that:

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




