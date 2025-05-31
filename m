Return-Path: <linux-kernel+bounces-669010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78EAC9A12
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E321701D5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FA2376E1;
	Sat, 31 May 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2JfGT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182F22D9F8;
	Sat, 31 May 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748680070; cv=none; b=GWxlZI7Ylg58pTMGEny7xKyzRgmnOgtANny62g9H+PD6vy4NKM29q9SAnY76Nc5+FPK7d4Da1iLSG2UNzUHu43PcvDSCoIJD1HmHJBQMUU7VlqXaCqHv50Goug+3WN5+BExRQzfY4t87iEGUCyG9ZV0tfFVgM/UN+JZ0PwxWOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748680070; c=relaxed/simple;
	bh=YV7jAOWu5f2uMd0mrJSv6w/Tw0RCII65EBVJz164jz8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=A1Mq6eHRzoYN+KfDqzzQ6Xl4zLcGrua2N/QHlqIg0tPlMvlPo6aGYzLkVLaTl+XoHeRc6mMJd7IcAWC3rf4QVVirJAseLV8BhC4K9cgb98U5wwEiTRs7BsTbj91liq67V606JjDczzBhSpWR1/YQ2VrLFGRZ0OMF0wAH3zbGeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ2JfGT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E941C4CEE3;
	Sat, 31 May 2025 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748680069;
	bh=YV7jAOWu5f2uMd0mrJSv6w/Tw0RCII65EBVJz164jz8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iJ2JfGT4BkPHgrhmvWfX1d06XnMTYiysW/CRPYMsQ6BDq37xVznYfbiPttwY0cgdO
	 DelfKC2Moizs2E5EgdMBzPHCT0/H8O5j4AQFtr3HC4aO7XvC9MIyZ2MhnAdYQCd+dd
	 i/JZ5LzMXAxzHaey9rQIPa1EONP69dPf2dPPQ6a+dkt3cDQzhpynuVqvUWbeCmFfVS
	 44b+rMK4JMCEebVGZcyPJ0OMGDZxizsBHsieCIKJVoPq+enLW9tUB2uQQxppQ9/bQx
	 0WFmwNbh2F2EM6QOia9jIk0B/yFRN4su8oxsH+dyHgrblGyanP+vxkQl32Ir+z5bKt
	 C7Ka0pPOHjrjg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 May 2025 10:27:44 +0200
Message-Id: <DAA7CJOUJPNL.F7UH9KD8JANF@kernel.org>
Subject: Re: [PATCH 6/7] rust: miscdevice: expose the parent device as
 &Device<Bound>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <chrisi.schrefl@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250530142447.166524-1-dakr@kernel.org>
 <20250530142447.166524-7-dakr@kernel.org>
In-Reply-To: <20250530142447.166524-7-dakr@kernel.org>

On Fri May 30, 2025 at 4:24 PM CEST, Danilo Krummrich wrote:
> @@ -227,11 +229,21 @@ fn drop(self: Pin<&mut Self>) {
>      }
>  }
> =20
> +/// The arguments passed to the file operation callbacks of a [`MiscDevi=
ceRegistration`].
> +pub struct MiscArgs<'a, T: MiscDevice> {
> +    /// The [`Device`] representation of the `struct miscdevice`.
> +    pub device: &'a Device,
> +    /// The parent [`Device`] of [`Self::device`].
> +    pub parent: Option<&'a Device<Bound>>,
> +    /// The `RegistrationData` passed to [`MiscDeviceRegistration::regis=
ter`].
> +    pub data: &'a T::RegistrationData,

Here I would also just use `T`, remove the `MiscDevice` bound and then
use `MiscArgs<'_, Self::RegistrationData>` below.

> +}
> +
>  /// Trait implemented by the private data of an open misc device.
>  #[vtable]
>  pub trait MiscDevice: Sized {
>      /// What kind of pointer should `Self` be wrapped in.
> -    type Ptr: ForeignOwnable + Send + Sync;
> +    type Ptr: Send + Sync;

There is no info about this change in the commit message. Why are we
changing this? This seems a bit orthogonal to the other change, maybe do
it in a separate patch?

Also `Ptr` doesn't make much sense for the name, since now that the
`ForeignOwnable` bound is gone, I could set this to `Self` and then have
access to `&Self` in the callbacks.

Would that also make sense to use as a general change? So don't store
`Self::Ptr`, but `Self` directly?

---
Cheers,
Benno

