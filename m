Return-Path: <linux-kernel+bounces-753053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0DB17E2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879CD6232CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729E2147EF;
	Fri,  1 Aug 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ1g6Ukl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5C20B1E8;
	Fri,  1 Aug 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036515; cv=none; b=Hhh2CcVHYhaZmbQcwtpShcYciHu5/ScgxsMmoOCPVEt5qAgdp7pxPKOojxWT2APxlHO49E1BerJoWLrt5soTLokSRJ7Z9NJSf66Ef+dPembhCjyI84zDQme/VoukDi7bWbRhGRJOKbaTXvTpq1Owtjt9Yj0/8nCr99n5ZcFNGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036515; c=relaxed/simple;
	bh=EG1IipNgpyo8fGH1RjMBEme5aivIHxhO25P/hri0Swc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Sarp61voWZ8zyAu7f65c+ilrxyi+iS8W0ebp6kQkS1d/ypQNYOd5AvcrnhPu6VNgpWD9LVkyQsuO2UMg4fPQzSVJNq7mc9YXFRNRi/YpcxCCPnvxn/D6XF/fSB2Jqs2DG6i9KQBqTyqWbfFU0hWHNsB2Slttu4w8buaUB6bhgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ1g6Ukl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D855FC4CEE7;
	Fri,  1 Aug 2025 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754036514;
	bh=EG1IipNgpyo8fGH1RjMBEme5aivIHxhO25P/hri0Swc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aJ1g6Ukl/rIfiZE32tISmRV3Y01llKNJXC3iF62e8/nZCWT3EnYligf3hqKlehipG
	 YgKQK5InWKVZhyZJmCBcCEI6OOGMd9WscJXNsVBwU6GsVDBwhk8R2PHbDYhcQelgUZ
	 mbLuXwmNBjLBYADzUnP9mmFWz18Wb2J5kq2XRjjuSyUfL5APGozxCpci9VffueSItO
	 r7iO3cJe8OAdMl5AREqpCpGBfrvjYjrT2DABwX830dRD/TD2+IFTHI3igqML64+Rpj
	 pYbTpyV2f/ae7BQBiQ5hbLCk5oU9Zr5JwuEA8HD5wjRVVzhL/TgdZnVu57XHRU+TrK
	 z0Pw7CK8/CqGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 10:21:49 +0200
Message-Id: <DBQY1S7V8IIS.3NCGOZ8ALU7QG@kernel.org>
Subject: Re: [PATCH 3/4] rust: drm: remove pin annotations from drm::Device
Cc: <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
 <Liam.Howlett@oracle.com>, <urezki@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-4-dakr@kernel.org>
 <DBQGW0NIQJRX.MU0QD5GMFJYM@kernel.org>
In-Reply-To: <DBQGW0NIQJRX.MU0QD5GMFJYM@kernel.org>

On Thu Jul 31, 2025 at 8:54 PM CEST, Benno Lossin wrote:
> On Thu Jul 31, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
>> The #[pin_data] and #[pin] annotations are not necessary for
>> drm::Device, since we don't use any pin-init macros, but only
>> __pinned_init() on the impl PinInit<T::Data, Error> argument of
>> drm::Device::new().
>
> But you're still pinning `Device`, right?

A drm::Device instance never exists other than as ARef<drm::Device>.

>> Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/drm/device.rs | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
>> index d19410deaf6c..d0a9528121f1 100644
>> --- a/rust/kernel/drm/device.rs
>> +++ b/rust/kernel/drm/device.rs
>> @@ -54,10 +54,8 @@ macro_rules! drm_legacy_fields {
>>  ///
>>  /// `self.dev` is a valid instance of a `struct device`.
>>  #[repr(C)]
>> -#[pin_data]
>>  pub struct Device<T: drm::Driver> {
>>      dev: Opaque<bindings::drm_device>,
>> -    #[pin]
>>      data: T::Data,
>
> Looking at this code again, I also noticed that it was wrong before this
> patch: `Device<T>` implemented `Unpin` if `T::Data` did which is most
> likely wrong (or is `drm_device` not address sensitive?).

It is, but as mentioned above a drm::Device only ever exists as
ARef<drm::Device>.

So, in drm::Device::new() we allocate the drm::Device with __drm_dev_alloc(=
),
initialize data in-place within this allocated memory and create an
ARef<drm::Device> directly from the raw pointer returned by __drm_dev_alloc=
().

> So good to see that fixed, thanks!
>
> ---
> Cheers,
> Benno
>
>>  }
>> =20


