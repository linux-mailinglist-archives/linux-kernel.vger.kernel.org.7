Return-Path: <linux-kernel+bounces-885456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D67C32F23
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4753B3A35EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9142EDD70;
	Tue,  4 Nov 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BET+yYbf"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8601E89C;
	Tue,  4 Nov 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288911; cv=pass; b=cI8ifsqRjKEqsTkYcdgO7gBIsYR+gA8fzUC4GBzchi+4B4XyZTCraTtjiTMbQn7StXFXdECYXX50gBSKTcWLkDJqt5nAIJiGcitMjJaVBr272Av3etp3PYrpplPtjM4q3UfIE9qjYYJMJLHINCw+1cC4/lEUd36maIm027z9G6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288911; c=relaxed/simple;
	bh=lvYLBKKn3EDcuMJT5hqfVUFM11YGIUbnO2tmMmYiafc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpSCEn8OGvJbDixiFoYuXXtPU9g4dER5XEU3vc1pvENo9s/gcBZy5wrcQMeJLZr+3fwk9mzj14CFkYmx0NiL1VPQ7ZLQbRJmuY08Shz9kcPlSRp4+Jyj1hFpsd8qhE+vRcNW85ppE4mVn8gt7q93EmwWBSbqiQTSUkgjJ03EQKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=BET+yYbf; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762288891; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ipq8PWB3GgNQMZAmxyUQBtCYrvC1OR4VmMKYFK5oVoZV5sYq9uUjVb5Bj4UK/4XSi526AZrP97T6GXg0Qi3ivK68/0ySblWOgBoO4k8mxhptLw+lxKJUlnEVz+Aiy++TLmNJbjGmcbp92YEwpo7hAWzshNbX5jOeXT5k8kiVG5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762288891; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UdNE52py5w5GbF1Vmt3kzvD/+HZJJNr5pY7ZeT6RQeo=; 
	b=CwmkK1TbEtK1poXQs7bT07nCJQX8GvIx6hj5BD7v/5zemhHs/QTcjTYJP379NX9W79FN4iVMYX5qfY91R3PMv55Kor6o1RUGMybyjvtaTMhi461NGeFNNEk00LaH6vOO9TJpLC7mf90MGwCgkfMhQDEMFyCOn6mAn7ZKId5TvXg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762288891;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=UdNE52py5w5GbF1Vmt3kzvD/+HZJJNr5pY7ZeT6RQeo=;
	b=BET+yYbfWgo+EJbuuxNlMXMu8LGS3T8Zg8XnTuqdbu8XK9qRRUfNrTc1hmAeE+kT
	l1BSocmWMSf69v1Bu6cn+7l4cKf8zhvpsxDrzNprpRbuwJP8Ef8hU8CzlRr58ZMXx4c
	zmmqqymtTPmzY764nZ3ZVQ4/GtAWueYJo/4s1Ewk=
Received: by mx.zohomail.com with SMTPS id 1762288888762838.1883086250991;
	Tue, 4 Nov 2025 12:41:28 -0800 (PST)
Date: Tue, 4 Nov 2025 12:41:27 -0800
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	"open list:DRM DRIVER FOR NVIDIA GPUS [RUST]" <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v5 4/8] rust: gem: Introduce DriverObject::Args
Message-ID: <aQpk98pvsZUdk3xa@um790>
References: <20251023212540.1141999-1-lyude@redhat.com>
 <20251023212540.1141999-5-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023212540.1141999-5-lyude@redhat.com>

On Thu, Oct 23, 2025 at 05:22:06PM -0400, Lyude Paul wrote:
> This is an associated type that may be used in order to specify a data-type
> to pass to gem objects when construction them, allowing for drivers to more
> easily initialize their private-data for gem objects.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> ---
> V3:
> * s/BaseDriverObject/DriverObject/
> V4:
> * Fix leftover reference to BaseObjectDriver in rustdoc for
>   DriverObject::Args
> 
>  drivers/gpu/drm/nova/gem.rs |  5 +++--
>  rust/kernel/drm/gem/mod.rs  | 13 ++++++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
> index 2760ba4f3450b..173077eeb2def 100644
> --- a/drivers/gpu/drm/nova/gem.rs
> +++ b/drivers/gpu/drm/nova/gem.rs
> @@ -18,8 +18,9 @@ pub(crate) struct NovaObject {}
>  
>  impl gem::DriverObject for NovaObject {
>      type Driver = NovaDriver;
> +    type Args = ();
>  
> -    fn new(_dev: &NovaDevice, _size: usize) -> impl PinInit<Self, Error> {
> +    fn new(_dev: &NovaDevice, _size: usize, _args: Self::Args) -> impl PinInit<Self, Error> {
>          try_pin_init!(NovaObject {})
>      }
>  }

Hi Lyude - could you please add the same changes for Tyr so it will
compile too

> @@ -33,7 +34,7 @@ pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self
>              return Err(EINVAL);
>          }
>  
> -        gem::Object::new(dev, aligned_size)
> +        gem::Object::new(dev, aligned_size, ())
>      }
>  
>      /// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 67813cfb0db42..d448c65fe5e13 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -65,8 +65,15 @@ pub trait DriverObject: Sync + Send + Sized {
>      /// Parent `Driver` for this object.
>      type Driver: drm::Driver;
>  
> +    /// The data type to use for passing arguments to [`DriverObject::new`].
> +    type Args;
> +
>      /// Create a new driver data object for a GEM object of a given size.
> -    fn new(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
> +    fn new(
> +        dev: &drm::Device<Self::Driver>,
> +        size: usize,
> +        args: Self::Args,
> +    ) -> impl PinInit<Self, Error>;
>  
>      /// Open a new handle to an existing object, associated with a File.
>      fn open(_obj: &<Self::Driver as drm::Driver>::Object, _file: &DriverFile<Self>) -> Result {
> @@ -247,11 +254,11 @@ impl<T: DriverObject> Object<T> {
>      };
>  
>      /// Create a new GEM object.
> -    pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
> +    pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<ARef<Self>> {
>          let obj: Pin<KBox<Self>> = KBox::pin_init(
>              try_pin_init!(Self {
>                  obj: Opaque::new(bindings::drm_gem_object::default()),
> -                data <- T::new(dev, size),
> +                data <- T::new(dev, size, args),
>                  // INVARIANT: The drm subsystem guarantees that the `struct drm_device` will live
>                  // as long as the GEM object lives.
>                  dev: dev.into(),
> -- 
> 2.51.0
> 

