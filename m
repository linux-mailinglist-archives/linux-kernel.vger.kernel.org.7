Return-Path: <linux-kernel+bounces-680369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBFAD4465
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 23:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7C3A5DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32C2676C2;
	Tue, 10 Jun 2025 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jiixBKlK"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3F12D758;
	Tue, 10 Jun 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589559; cv=pass; b=JaLVBk9Ln/BvzBurRR6hboKWMw4mifrqT6XXoSa4Oqt+22aDgOBd+WwKRalNLVvzdlHfoR4nwfHUJFQkq85Ubh1pjT9qO3mNA9+V0SkI3UPtjqM5KXHiYmIa/0O6mg3EfEY3pEi+AgIW8edukOnPu4Q5cdFAMAlGyZYyFWORE4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589559; c=relaxed/simple;
	bh=C60YJLduDuc01tBceJmWT3yEUtG8WGPsNw6ujSLEUCY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CDBqndi/onh31AGaY8JguT4pCoktPAc6R96eDHBY+wobOZ1IlL+vlBYKneE/WOYVo1+nBVq9B4YFuNEM45KyRyXSCouqPPZp1pPgQQxvX3UqGbTXNeHCL4GI3ypoYshm3zhh2Dt9xhBMztGGMl5pInJQeJTj+ESpiFmvcsRVnUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jiixBKlK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749589487; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C9EUicvI7hg3PnYyeqe81d1BAthSGjVJF9hYZaZ1C4voWLpsGrX+2SpLmnAE46kvBOBC6f8LSJ1oMohTvhfwyMNN1BKUT3WVMZ3nicq1OtrHEG6UrbOmoDhJfTT3R9fg9xCJnfR1yYOJX5RS8yo3LgExmdUUuHihHe1EoNHoEwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749589487; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C60YJLduDuc01tBceJmWT3yEUtG8WGPsNw6ujSLEUCY=; 
	b=N1L+sFiSHN6NSLlM4Zy8nO7qV+KICpm3Ko0zuCW4v5bi7Fc9coFrTsYQQqt8p9lrlhBUmAgMpZaVkd0A0PKRV2cXltbKZFHxzV7o18uQzoO/5bYjnsTsE/VZXwb8ZU6L1sqdw6VPvHsVEetNYugGUpOSDVATbZB+Q4JPv6RdHz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749589487;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=C60YJLduDuc01tBceJmWT3yEUtG8WGPsNw6ujSLEUCY=;
	b=jiixBKlKyR5C9o8SSpwuoWU40JTQoxDG1mlDTxvBUL/g/+on87nvqkZoe0GrUw3y
	PkSYGrnYuCQJfpsbj2Bfgz92ifS7e/Tku3Ds8kxfKeBPuQIYU8ROXbTeVdHLMRw2m4m
	flnwBJh6Ua4H8SAk4yaTXkTGi6He4bME40AXHYdE=
Received: by mx.zohomail.com with SMTPS id 1749589485855606.0438954014338;
	Tue, 10 Jun 2025 14:04:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 2/2] rust: drm: Add GPUVM abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aAj7gAzFVRX3dN7L@pollux>
Date: Tue, 10 Jun 2025 18:04:29 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Asahi Lina <lina@asahilina.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DADCFE7-B292-4387-A91D-B9CFD062942A@collabora.com>
References: <20250422-gpuvm-v2-0-44d4fc25e411@collabora.com>
 <20250422-gpuvm-v2-2-44d4fc25e411@collabora.com>
 <aAgHGuzCZzh7YPz2@cassiopeiae>
 <DBB3E8CE-19AA-437D-AF54-BF23763B254F@collabora.com>
 <aAj7gAzFVRX3dN7L@pollux>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> The lock might be held already by the driver or by TTM when things are =
called
> from TTM callbacks.
>=20
> This is why GPUVM never takes locks by itself, but asserts that the =
correct lock
> is held.
>=20
> I think we really want to get proof by the driver by providing lock =
guard
> references.

Can=E2=80=99t we add a lock to our Rust GpuVmBo type?

This is already supported by the C code, since it asks driver to either =
provide
a custom lock _or_ use the bo's resv. So what I am suggesting here is =
the
former, except that said lock would be transparently managed by our Rust =
GPUVM
abstraction.

By using our own lock, we forbid drivers from introducing races.

Another option is to also require a(nother) Guard when mutating the BO's =
VA
list, but I find this a bit cumbersome for a couple of reasons:

a) It's proving a bit difficult to provide said Guard for the interval =
tree
itself,

b) This will appear in all functions where the lock should be taken, =
which
pollutes the API quite a bit.

c) Having "either a custom lock or the resv lock" sounds a bit =
confusing.
Handling this transparently in Rust makes the API easier to use (and =
harder to
misuse)

=E2=80=94 Daniel




