Return-Path: <linux-kernel+bounces-878832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344FAC218F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B538D3BAD83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEAF36C247;
	Thu, 30 Oct 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDY3O/nn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256625BEE8;
	Thu, 30 Oct 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846758; cv=none; b=csXYEecUR+wMatTbrqQywEGZjnAARZQfxuiB2ZQuIQkl2HhIK6xDubtKDK72nN11PwWgiA0b9Ah8wAoIp5u/RtOfZOYhkr6PuNfQJulvbmG8yxCqE6WDZ7rYfNMDbDEs7c9yBIw1a2IuGFwYtdLW26GZAHcB2SmhWQtwZupbMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846758; c=relaxed/simple;
	bh=3zwAt7XYFwZCJPb9tDXyVj/uZNMzwGy9KliijbwRvrA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=A8gr1qMF0eeNFUpu82mskVs/xekOcnkEaKmvmG5ou23KVKpR7iX7bbEx93VDcJcg+gVrAYS4TsBB74EoEZAWqv7gijadrwYDvSlT6b2k+QIWw3kqO6OJC0KG+pn7o85qwso4kg/KdFj5pvWR1NUp1fxrpUOVCLHuJSLebW3F8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDY3O/nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CB8C4CEF1;
	Thu, 30 Oct 2025 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761846757;
	bh=3zwAt7XYFwZCJPb9tDXyVj/uZNMzwGy9KliijbwRvrA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jDY3O/nndAhOkNHElVrUiTB/KmyV9YLWkK0QGcaisJspNmZR96ONA22nIx4TtKdgC
	 G5uVk13kyKIN/2aWW8dOgJ4yWeIe4yCZpT+5PttGjEs/mSSa35bVZgT0z49E5V+Ltx
	 LOmII52BArDktg/RP9HfIPnjDmpEW1kH3lxkhNHZSr+foPwOuQHbw+Xpxhb7rsloJ+
	 BcjyNmbKAa8GRTEGS/knynYL8Jt083EgMT4IZ+LH5gJJVadXwYE8RH9LunWopnzewm
	 hq9XOEOO/5airbVikux/rdG6jui0gySqE9fq3PgZAddY0C7CC8g11kqxHc0+b1Vxds
	 5WnR54NuTfwhg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 18:52:31 +0100
Message-Id: <DDVUJRUAMI4T.1OLCH55GSGYCM@kernel.org>
Subject: Re: [RFC 0/2] rust: introduce abstractions for fwctl
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org"
 <kwilczynski@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
 "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "boqun.feng@gmail.com"
 <boqun.feng@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "lossin@kernel.org"
 <lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, "tmgross@umich.edu"
 <tmgross@umich.edu>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Neo Jia" <cjia@nvidia.com>, "Surath Mitra"
 <smitra@nvidia.com>, "Ankit Agrawal" <ankita@nvidia.com>, "Aniket Agashe"
 <aniketa@nvidia.com>, "Kirti Wankhede" <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>,
 "Alex Williamson" <alwilliamson@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <8e0209de-5be3-4d41-807f-1b7e73aa3d1d@nvidia.com>
In-Reply-To: <8e0209de-5be3-4d41-807f-1b7e73aa3d1d@nvidia.com>

On Thu Oct 30, 2025 at 6:29 PM CET, Zhi Wang wrote:
> On 30.10.2025 18.03, Zhi Wang wrote:
>> In the NVIDIA vGPU RFC [1], the vGPU type blobs must be provided to the =
GSP
>> before userspace can enumerate available vGPU types and create vGPU
>> instances. The original design relied on the firmware loading interface,
>> but fwctl is a more natural fit for this use case, as it is designed for
>> uploading configuration or firmware data required before the device beco=
mes
>> operational.
>>=20
>
> Hi Jason and Danilo:
>
> Thanks for the comments. I had one more open to discuss, handling the buf=
fer
> allocation/free between rust and C world.
>
> Two fwctl ioctls:
>
> FWCTL_CMD_INFO: The driver allocates the info memory (kmalloc) and the fw=
ctl
> subsystem frees it.
>
> FWCTL_RPC:
>
> Case 1: The driver can choose to re-use the input buffer and write the *o=
ut_len
> for actual length of data.
>
> Case 2: The driver can allocate a new buffer (kmalloc) and the fwctl subs=
ystem
> frees it.
>
> ----
> Now with the Rust driver:
>
> FWCTL_CMD_INFO: The rust side returns a new KVec, the rust fwctl abstract=
ion
> consumes it, get void *buf and pass it to fwctl subsystem (C). The memory
> will be freed by C side.
>
> FWCTL_RPC:
>
> The input buffer will be wrapped in a mutable slice.
>
> Case 1: Re-use the input buffer. The rust side writes the mut slice and t=
he
> * mut out_len.
>
> Case 2: Allocate the new output buffer. The same approach as FWCTL_CMD_IN=
FO.
>
> ----
>
> We know KVec is backed by kmalloc. If C side changes the requirements of
> the driver memory allocation someday, E.g. from kfree() to kvfree() or vf=
ree().
>
> Drivers in C will be updated surely at that time.
>
> Is possible that we can have some approaches to catch that change from th=
e rust
> side via rust compiler for rust drivers?

I don't think we have the possibility of doing any compile time check here,
since on the C side the type is always void * for any memory allocation.

However, I think the only broken case would be if C switches to vmalloc() (=
and
hence vfree()), but the Rust code doesn't. That sounds unlikely to me for t=
hree
reasons.

  (1) I think if there'd be a change it would be to kvmalloc() and calling
      kvfree() on a kmalloc() buffer should be fine.

  (2) A breaking change would also affect all C drivers, so it'd not only b=
e the
      Rust code being affected.

