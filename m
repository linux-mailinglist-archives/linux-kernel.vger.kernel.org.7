Return-Path: <linux-kernel+bounces-835870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3ABA83C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5D3C2645
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4F2C0298;
	Mon, 29 Sep 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwgzNJRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C92BEC42;
	Mon, 29 Sep 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130667; cv=none; b=qzaQR2BRYfEXAEzJwpOZdDMPkQ/yRQLuItREzkjg/usIDwcn0T2dV57/pzvpnCHy49D49r8m4QLuXeFp85kmcfF80lg8Yfi8cPnj66x3YA9smjKZ4pUNY8u+QlyJkcLVNw/oIHJA+EAHp4qNdjojG1eNNk0vdwNT7lfcNavIjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130667; c=relaxed/simple;
	bh=1qzNnpu3NUoqi58w/V80ugREMmoNYeEvOtzP7t+zvkI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=U2zcMS1CXpFKIPEh1co7y8hQ4oktgSKhukbmgyE0U2tQQo0sMqTYoEBTHxB/1RLlfspNaggnPthUFCV6fI5oQsoz04JhPWe1jgB+cDm/FmmzVpvsEsufSNHa0TCnHBVpcdv+vrOWFzpAD4d7xU6sGHmxvVhkuIybBgNk53SuXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwgzNJRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C08C4CEF4;
	Mon, 29 Sep 2025 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759130666;
	bh=1qzNnpu3NUoqi58w/V80ugREMmoNYeEvOtzP7t+zvkI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AwgzNJRuocgjAGZ1GURK4UCtFvmTUaMRB+hol6d5Rk+/bvyCaocUKVrJF3iQ0UWLd
	 3Qc6mE5XX+a/dsG1lBnayQyoJuooAqF7qQfSLq/VfolhbDVh4DokgIMIwNU6hFdWe2
	 QqVn2li1Pox+IYgNPjwxGnkERpplwjciHOTFUto93ULc6qNb5ZE2JDtvsMTorjUDBF
	 ZI1Bkk2BEW7PVGHpTuq0tG3bMJFwjBIQjHxLMAIruWYvk0TAZ2Tv6W6qg0vlONCTBe
	 tsxJUnslbgBZCCJy+WtpXjvguHBMappH5ZE8nDsKgnCerpI3y+N3TY4nx5BR1Ukyn/
	 MCAbmC8FRzHVg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 09:24:19 +0200
Message-Id: <DD53RWODAWPS.3MBKE59UU905Q@kernel.org>
Subject: Re: [PATCH v2 05/10] gpu: nova-core: gsp: Add GSP command queue
 handling
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Lyude Paul"
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-6-apopple@nvidia.com>
 <e95c59cc72145c05380d0d81d767c6ce97fbbf0a.camel@redhat.com>
 <fiwv6movnoliptvjdlxzx4rggv5a7mid4zyvmqowvw6kt5auhh@r4dmizzmykwv>
 <DD2DFKZTFIGS.2HDVZRV6WGXHG@nvidia.com>
 <mkecw5p2eb6bsl54ccpxrdezeatr4sxjtkvsteu4klx6u3ldka@p42jqjvoi275>
In-Reply-To: <mkecw5p2eb6bsl54ccpxrdezeatr4sxjtkvsteu4klx6u3ldka@p42jqjvoi275>

On Mon Sep 29, 2025 at 3:06 AM CEST, Alistair Popple wrote:
> On 2025-09-26 at 12:20 +1000, Alexandre Courbot <acourbot@nvidia.com> wro=
te...
>> On Thu Sep 25, 2025 at 3:32 PM JST, Alistair Popple wrote:
>> <snip>
>> >> > +    #[expect(unused)]
>> >> > +    pub(crate) fn receive_msg_from_gsp<M: GspMessageFromGsp, R>(
>> >> > +        &mut self,
>> >> > +        timeout: Delta,
>> >> > +        init: impl FnOnce(&M, SBuffer<core::array::IntoIter<&[u8],=
 2>>) -> Result<R>,
>> >> > +    ) -> Result<R> {
>> >> > +        let (driver_area, msg_header, slice_1) =3D wait_on(timeout=
, || {
>> >> > +            let driver_area =3D self.gsp_mem.driver_read_area();
>> >> > +            // TODO: find an alternative to as_flattened()
>> >> > +            #[allow(clippy::incompatible_msrv)]
>> >> > +            let (msg_header_slice, slice_1) =3D driver_area
>> >> > +                .0
>> >> > +                .as_flattened()
>> >> > +                .split_at(size_of::<GspMsgElement>());
>> >> > +
>> >> > +            // Can't fail because msg_slice will always be
>> >> > +            // size_of::<GspMsgElement>() bytes long by the above =
split.
>> >> > +            let msg_header =3D GspMsgElement::from_bytes(msg_heade=
r_slice).unwrap();
>> >>=20
>> >> Any reason we're not just using unwrap_unchecked() here then?
>> >
>> > Because whilst my assertions about the code are currently correct if i=
t ever
>> > changes I figured it would be better to explicitly panic than end up w=
ith
>> > undefined behaviour. Is there some other advantage to using unwrap_unc=
hecked()?
>> > I can't imagine there'd be much of a performance difference.
>>=20
>> Here I think we should just use the `?` operator. The function already
>> returns a `Result` so it would fit.
>
> Actually note quite true - this is in a closure that must return `Option<=
_>`
> so returning `Result` doesn't fit. However it still fits because I just n=
oticed
> `::from_bytes()` returns an `Option` so `?` will still work.

More in general, as by now, unwrap() panics the kernel, which is an absolut=
e
last resort, that should only be considered if there's really no other opti=
on.
Please also see [1] and [2].

[1] https://docs.kernel.org/process/coding-style.html#do-not-crash-the-kern=
el
[2] https://github.com/Rust-for-Linux/linux/issues/1191

