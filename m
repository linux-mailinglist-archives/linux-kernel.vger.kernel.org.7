Return-Path: <linux-kernel+bounces-878787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9AC2177D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBE1C4F0130
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D13678BB;
	Thu, 30 Oct 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkosZtNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15F264F96;
	Thu, 30 Oct 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844874; cv=none; b=N2GFiXLbG8OomUTFd9azN7wIrdVRHcHzxxYaNA1yS8VH90iPG/Yh1xDju63DZL4sipvFN/kpFNePUnORUxlEIMx2Szcuh1FEBCQEeAhafVzqqQcn7f/Yv00b9EA4minqogGIp3sUd+76Plw6PQrfLj4HMyq2rcsYosno2t3OEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844874; c=relaxed/simple;
	bh=JCo5HIQRDgriwfHeMxFo07QUdYzeoGeZvmZg3jK3Ktg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qFbKVSr31rfqPffi0akDUnI+T4kY+LvPJZbUQA+0lJcQjD/jiPSaumcsIU9tWQXt4mz56RCupahjMMCXXzMFMpXKUrNHEsxe/MOh117T8/xpT/l4Poc18UtKTdJ45hEnQsYO+P7GKXPdOSii4VLtwi9xP4iOeSQMB7fmzSus1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkosZtNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FFDC4CEF8;
	Thu, 30 Oct 2025 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844873;
	bh=JCo5HIQRDgriwfHeMxFo07QUdYzeoGeZvmZg3jK3Ktg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RkosZtNOsm+vtoYvhZKOlYIMuXQi5jZj8S1y8yOPpfZLQBPtieRRq5wpIbSjc671s
	 VSHS3aTFj0Fv6amYPZqUbrZzSg1xzQfPZIZ1J3vk1o8nnFo9tag/NNnGW8ccgZkvnK
	 TIrqyrhtZljFBJyDwAl9RCFBjxKlQd711ofIBrJ5FT/Rkv+yhvZaSEtlRMxhN16D8X
	 qfgpdTyxWx0Sbi3a8ZfRO5QeGLX7sumxLs8n7LLDFpQDT808OWkwDTPTWkE1hC7Tj0
	 Ze5caPGHJEMqRytOgBCWpXtVsvIuaefKYz1nmRtghCH7yc/+Epl28ZWhy8hKQ6MmZl
	 qsbGvxJ39H5/Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 18:21:06 +0100
Message-Id: <DDVTVQ54W7FM.1XS6MIH4ALW8U@kernel.org>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <alwilliamson@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <20251030162207.GS1018328@nvidia.com>
In-Reply-To: <20251030162207.GS1018328@nvidia.com>

On Thu Oct 30, 2025 at 5:22 PM CET, Jason Gunthorpe wrote:
> On Thu, Oct 30, 2025 at 04:03:12PM +0000, Zhi Wang wrote:
>> +impl<T: FwCtlOps> Registration<T> {
>> +    /// Allocate and register a new fwctl device under the given parent=
 device.
>> +    pub fn new(parent: &device::Device) -> Result<Self> {
>> +        let ops =3D &FwCtlVTable::<T>::VTABLE as *const _ as *mut _;
>> +
>> +        // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_devic=
e`
>> +        // and initializes its embedded `struct device`.
>> +        let dev =3D unsafe {
>> +            bindings::_fwctl_alloc_device(
>> +                parent.as_raw(),
>> +                ops,
>> +                core::mem::size_of::<bindings::fwctl_device>(),
>> +            )
>> +        };
>> +
>> +        let dev =3D NonNull::new(dev).ok_or(ENOMEM)?;
>> +
>> +        // SAFETY: `fwctl_register()` expects a valid device from `_fwc=
tl_alloc_device()`.
>> +        let ret =3D unsafe { bindings::fwctl_register(dev.as_ptr()) };
>
> This is a Bound device, not just any device.

Indeed, the safety comment should mention this. And if it would it could no=
t
justify it with the current code, since the function takes a &Device instea=
d of
the required &Device<Bound> argument.

>> +        if ret !=3D 0 {
>> +            // SAFETY: If registration fails, release the allocated fwc=
tl_device().
>> +            unsafe {
>> +                bindings::put_device(core::ptr::addr_of_mut!((*dev.as_p=
tr()).dev));
>
> ?? Don't open code fwctl_put() - it should be called directly?
>
>> +            }
>> +            return Err(Error::from_errno(ret));
>> +        }
>> +
>> +        Ok(Self {
>> +            fwctl_dev: dev,
>> +            _marker: PhantomData,
>> +        })
>> +    }
>> +
>> +    fn as_raw(&self) -> *mut bindings::fwctl_device {
>> +        self.fwctl_dev.as_ptr()
>> +    }
>> +}
>> +
>> +impl<T: FwCtlOps> Drop for Registration<T> {
>> +    fn drop(&mut self) {
>> +        // SAFETY: `fwctl_unregister()` expects a valid device from `_f=
wctl_alloc_device()`.
>
> Incomplete safety statement, the device passed to fwctl_alloc_device must
> still be bound prior to calling fwctl_unregister
>
>> +        unsafe {
>> +            bindings::fwctl_unregister(self.as_raw());
>> +            bindings::put_device(core::ptr::addr_of_mut!((*self.as_raw(=
)).dev));
>
> There for Drop can only do fwctl_put() since otherwise there is no way
> to guarantee a Bound device.
>
> unregister has to happen before remove() completes, Danilo had some
> approach to this I think he told me?

Yeah, such Registration structures of (class) devices should be wrapped int=
o a
Devres container (i.e. Devres<fwctl::Registration>)to be able to provide th=
is
guarantee. See also my other reply to this patch [1].

While not a class device, the auxiliary bus with its auxiliary::Registratio=
n
[2], is a good example.

Alternatively (or additionally), it can also be implemented in a way that t=
he
driver does not get control over a Registration object at all, but once cre=
ated
it is not accessible anymore and automatically dropped on parent device unb=
ind.
This approach is used by cpufreq [3].

It always depends on whether a driver might want to drop the Registration
manually before device unbind.

[1] https://lore.kernel.org/lkml/DDVT5YA564C6.3HN9WCMQX49PC@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/tree/rust/kernel/auxiliary.rs?id=3Db0b7301b004301afe920b3d08caa6171dd3=
f4011#n304
[3] https://rust.docs.kernel.org/kernel/cpufreq/struct.Registration.html#me=
thod.new_foreign_owned

