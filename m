Return-Path: <linux-kernel+bounces-765571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D89DB23A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4602516E464
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A092D062F;
	Tue, 12 Aug 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc8mOwnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00392F0679;
	Tue, 12 Aug 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030958; cv=none; b=HyeSY4IDdJiCRt4Ecu56SaM/YX8GlHNnx7FiMifcN7lEJxEoV2SMo/5hIRSVQf1wzqROZr2Bk6YJizB2p2UqZ1EEP0/nGJQhPgnZ1q7i66i0mwUD5E822Tu+V1YGIe4l0HhF3CpFSgfTYZiik7AJVp8v7ZqSxchqMBXj1qS6SsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030958; c=relaxed/simple;
	bh=+StpLUbIz4Cn8lrRgBX1tOfusvqJ9s3Ec800QrIyjPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=K6sPRYK6HecKQC2sjKjocuhapqSt2ZosFCTwarRNFHD67QxSe+TWPIZLlPau9cekhFX6GFeJxsdBgOXMiihdRu8k84rURHnvkc+N4hCxXIvEJLzc3NnJq5bF7OSvpnEuV410kL2IA39/3tl1Yt3UFiYqUAVVSysOXSYtIGlIq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc8mOwnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2625AC4CEF0;
	Tue, 12 Aug 2025 20:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755030958;
	bh=+StpLUbIz4Cn8lrRgBX1tOfusvqJ9s3Ec800QrIyjPA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=cc8mOwnQMZouqZAXTEyb1qgwlK4LxASLn1WbYrTamO5NeyoXsjkgs45NM5Ncb6WeX
	 lfrGeYSoJyYaUu/mwqNs4aR/NSPzwj/E20p6IlE4JbfJNUgnneyAPDcBuctVUNO/Ci
	 zBjbIwiEwiuAnUOPIfRZ4Bmrk/Ay921LRP8MnzaYyx9tmeg/gqA7fMzyVWQICn+6D1
	 L8HGJLEpqgdHcDZIUrsq+IidnYyDtSaa2AEd5sNgWED626W6EsGp6f62fb1l8IDodX
	 H9awiY1T72RF14BTyzbL1DxAJBwy3wM1jGHCRtUxIitVHNvFxKZkDLkJ4lB9W4sVmB
	 3kgHgKcu0V+aw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 22:35:52 +0200
Message-Id: <DC0QJT650CI5.268HLIHWB4L8I@kernel.org>
Cc: <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
 <Liam.Howlett@oracle.com>, <urezki@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with
 Kmalloc::aligned_layout()
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-2-dakr@kernel.org>
 <CANiq72mWVmso1yMYGYih-NDwjB9E1iVE=_oSpPiSvqTu5mkE0g@mail.gmail.com>
 <DC0PSDBCPGVO.38EGYXRFQVM8N@kernel.org>
 <CANiq72nfpecn3qQqNJiXGDX_Veg1Q9yQF0BZzCk68Ue_i3qtVg@mail.gmail.com>
In-Reply-To: <CANiq72nfpecn3qQqNJiXGDX_Veg1Q9yQF0BZzCk68Ue_i3qtVg@mail.gmail.com>

On Tue Aug 12, 2025 at 10:12 PM CEST, Miguel Ojeda wrote:
> On Tue, Aug 12, 2025 at 10:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> I don't think so, it just lead to pad to the alignment for Vmalloc too.
>>
>> Technically, this makes no difference, since Vmalloc is always PAGE_SIZE=
 aligned
>> and the size always a multiple of PAGE_SIZE.
>
> Got it, thanks for the quick reply! Then I guess we could have skipped
> the Fixes in this one, but it is not a big deal and as usual it
> depends on how one defines "fix".

Yeah, in the past I was more on the "'Fixes:' for actual bugs only" side of
things, but I changed my mind a bit; I find it useful to have this as a
reference even for minor issues that might not be actual bugs, such as this
one.

