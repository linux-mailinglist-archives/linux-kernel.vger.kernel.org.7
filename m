Return-Path: <linux-kernel+bounces-772299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D0B290FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722591C203FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7D246BC5;
	Sat, 16 Aug 2025 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlOSUaad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98692192F2;
	Sat, 16 Aug 2025 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755387888; cv=none; b=cG4nRZsGnIZaBx2V00yt1BFkmiYS3Hdq4yPmrgNnh+AdBiy8TrF9CPVu7It4nq9g8NJlQhsk1OKe76OHRm5iuZ0TSugx8wTIqz00pJNijrMo5hAy2l5csHHDNvH8YVQiH5Eveq9O4KgOw2Dv//jgBDfBFV8cL8MQzIW9eoFYPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755387888; c=relaxed/simple;
	bh=Y2IR6l2xgHEwLKnQTmYLs6uvEGbn+JQI/rGwjQ/51pw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=V8X/DW2QLzOHfBKnNtyeIFEbFJOURL/tsszxhREVcd073OK/556ABiFPz52naLHH5HPoZBToaKVWVShHUbVvl6ie87eEYkOUQ0ONeLYz1rUg5s4YUqBHUXh5Bu+LsFCxiXzyLNZX15Uzhd1LzZnauLAGo+mkdX944UM0PqLpnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlOSUaad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F91C4CEEF;
	Sat, 16 Aug 2025 23:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755387887;
	bh=Y2IR6l2xgHEwLKnQTmYLs6uvEGbn+JQI/rGwjQ/51pw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=QlOSUaadKyFgKRVb2Cn92dQSeIR2FylNjXVpuV2hE1jnFOW0kDWQVOFWhhWJvkGsZ
	 R8tQBGcrSZnsPNquiolfAslZiVBgKAbgIhFtt13sfsi4nwpT2WkpTC9NTNlBHRu1jo
	 mEfCMqg/OmVMInxSFUV3DEgRTfe890VrWs8JPRC3ptYUsOT8i1QmDF3+IpvsEbWnB+
	 a3s7F/vHEBz+u025pi+Mnsa2s+Croe+50shAWTIOpl9K665tkp0j2kUklxr2XJ3tCA
	 4f8oEE1j6AqHqfxlPjIGZVC5mnEq2kaHEDFaAxCoKk7BJQ7ptNCZVRte+hXxeRPbZX
	 v6ATu4mbrtvPw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 17 Aug 2025 01:44:41 +0200
Message-Id: <DC492K7AA12K.2K9H9SPMPI2Y8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with
 Kmalloc::aligned_layout()
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
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-2-dakr@kernel.org>
 <CANiq72mUXy6AYkwCW_kO3ikjNBc5pLzXw0+fXFGmYum0tGmw1g@mail.gmail.com>
In-Reply-To: <CANiq72mUXy6AYkwCW_kO3ikjNBc5pLzXw0+fXFGmYum0tGmw1g@mail.gmail.com>

On Sat Aug 16, 2025 at 10:40 PM CEST, Miguel Ojeda wrote:
> On Thu, Jul 31, 2025 at 5:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> +impl Kmalloc {
>> +    /// Returns a [`Layout`] that makes [`Kmalloc`] fulfill the request=
ed size and alignment of
>> +    /// `layout`.
>> +    pub const fn aligned_layout(layout: Layout) -> Layout {
>
> I think this `const fn` here was removed when applying to make it work
> with older compilers, right?

Yes, that's correct.

> I was fixing another `rusttest` thing and noticed while applying
> these. I had a patch to fix it, since we can actually just use the
> feature, and then I noticed it wasn't in the tree. Since I have it, I
> am attaching it for reference in case the now-stable feature is
> needed, e.g. if you want to make that `const fn` again.

I think it doesn't add much value for this to be a const function anyways, =
but
maybe it is more useful elsewhere? In that case, I think it also doesn't hu=
rt
to Kmalloc::aligned_layout() const again.

