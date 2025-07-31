Return-Path: <linux-kernel+bounces-752496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B86B17647
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275391C20C43
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472A24EA8D;
	Thu, 31 Jul 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7owTnz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4420CCE3;
	Thu, 31 Jul 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988104; cv=none; b=PY9x3JUMHMYyHCOH71X+XgEvTk23Yq2ODNZ6sTaPSnlNwi/6uKxAstNvJ7Un3zj19SDDJM5VMyRK2+dFODoRl0lyNIj5EhZqnmaJhMRygwXOrwUlEtMbyKF2mNPrbLVwmQndiK9FSJYXfq0ivE9v+AHvasvcYoCvzydjSfjZZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988104; c=relaxed/simple;
	bh=vC0up9mvz0CmJrrIDWMSSAZYXkJKsZyV1kdx/W9KPl0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZCYpoADiQyPbE3+v1GNVGIBspRjE70LDcM226bJhT83UuEZ2fiPGfFe0f8VTLV+NLnhQMUKKqCn5+fx7NOiqHTFhfKpcGa5NmgRt9LCzL5ikB+/qNSsND8Ne3wtVDspBZ731Ti/vxZ2mid3SLUKYeZXjrEN0675MAiFnN5r/8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7owTnz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC9C4CEEF;
	Thu, 31 Jul 2025 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988104;
	bh=vC0up9mvz0CmJrrIDWMSSAZYXkJKsZyV1kdx/W9KPl0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k7owTnz75QduSHc122BpHqgkZ6NhAz/LIbitVyMTJs/uCDk5a4DsvewuJAgai6fSH
	 3pOhA6v5OYoiT832vSh0Z6IiTBtsv+fOLtIfXJv+isBCh5nN8DdcLlGSyDea1i4DHo
	 tOQISqmfqqLormBxCXV7IYtz6Qehd4pX8ADZLAKUT8ibvQpEijPBE4aOQHkMhhSh1O
	 hF0oK2GMf5vErKcFducOA0QslSKlFYf7xsdRahkH/nXkkvW7o2QHwUQwicV+ajzqzD
	 ZvXRCULca4u87GlxxoAJUhtbg8X9/CnqVnergAeExj4d+YZj0KnHDcCrZJ7U8ytHR6
	 971xau/s0ViMw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 20:54:58 +0200
Message-Id: <DBQGW0NIQJRX.MU0QD5GMFJYM@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] rust: drm: remove pin annotations from drm::Device
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <lorenzo.stoakes@oracle.com>,
 <vbabka@suse.cz>, <Liam.Howlett@oracle.com>, <urezki@gmail.com>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-4-dakr@kernel.org>
In-Reply-To: <20250731154919.4132-4-dakr@kernel.org>

On Thu Jul 31, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
> The #[pin_data] and #[pin] annotations are not necessary for
> drm::Device, since we don't use any pin-init macros, but only
> __pinned_init() on the impl PinInit<T::Data, Error> argument of
> drm::Device::new().

But you're still pinning `Device`, right?

> Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/drm/device.rs | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index d19410deaf6c..d0a9528121f1 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -54,10 +54,8 @@ macro_rules! drm_legacy_fields {
>  ///
>  /// `self.dev` is a valid instance of a `struct device`.
>  #[repr(C)]
> -#[pin_data]
>  pub struct Device<T: drm::Driver> {
>      dev: Opaque<bindings::drm_device>,
> -    #[pin]
>      data: T::Data,

Looking at this code again, I also noticed that it was wrong before this
patch: `Device<T>` implemented `Unpin` if `T::Data` did which is most
likely wrong (or is `drm_device` not address sensitive?).

So good to see that fixed, thanks!

---
Cheers,
Benno

>  }
> =20


