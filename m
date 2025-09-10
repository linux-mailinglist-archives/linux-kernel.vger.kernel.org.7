Return-Path: <linux-kernel+bounces-810426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D36B51A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2AF1C234B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8C33471C;
	Wed, 10 Sep 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QNC2m2O5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CE324B30;
	Wed, 10 Sep 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515497; cv=pass; b=r0KNdPOMsLdP3QhfXgax9CHA5TyUZw0f9eYldXo1wdAS/kri7ApASD1/6ccA/bfQ5Kk3kx/oImrTkumYK70JwQJoNJiTGzAfa5gwUj1b2vYQHawiRr2JkesOyihYqq2wUGCGWBzrvd0nKU+LQ95JSmPQQXtQ/xAItZHKeqgyWoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515497; c=relaxed/simple;
	bh=yfat/hsWQpQt73KBdoAVhzviMu83bF6w1BxcucoVsnQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E88W3kZE9Jf57wCGEHW6Z4TGWlkcr5aO45Td9UzEpVukwyPJqY8BTcEEUoSRmJ9HxjzFywynDq/wkhwchrDsb6cl0e6wWJ8JKVbt91LjixTxJ0wVXGskvG6Y8PYEQx8pnLVvCl2hJK1lZh/j6t1Lpw49/3UhoEpL0QpOWeqxBgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QNC2m2O5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757515455; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vk0qSPHXJTZ3e1anRNtFlkJqS3Eb2Ala0y23F5r4QV86JxgaWO4NiNf4l12zDRkDm22qdO6/Vp73h1kp3NxcIW31lhHANqppt3kUlUNH4mY/XLh/nfWDDFI1bl38gKwTZYTdHil1CodlrLDHidOa7oPDGxMG8eO73KNY6Jk/DYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757515455; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4LvNay1MaDoZ6Gogn7GwBVUYhRPt65Jqq565M4URM5Y=; 
	b=eQyh8I9sifWTQTKvebidXfZyagRC2Nt5UGXwhQTz6mHaf8cZaTSm3asmbzqYO7wI36xiHSvqLmCGfZ0OUQtellWRARLX8OJa6OHLdcaiVDHq66DNy+X0A/nShidoEq2U5s4RltefDfp96KKnmoFwD0KFDkDu5RDm/fxCohYqWB0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757515455;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=4LvNay1MaDoZ6Gogn7GwBVUYhRPt65Jqq565M4URM5Y=;
	b=QNC2m2O5vYh5n3d03rStRzkuLr8zj2KI1zMVPeHGEZca4+nBCPTKSOhmEDUs4D7p
	50ICYbwWvGK5Lo6daw91x4hr2YZ9qtOnz/dXsz5YKfN0U7jNHQ2SQt2TqbdKVcXTVpj
	/oF2d2LDjfNA6vkwdAbD7k3VuI3UB+N1/cIbN9Lw=
Received: by mx.zohomail.com with SMTPS id 1757515451932963.2816933090961;
	Wed, 10 Sep 2025 07:44:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] rust: drm: Introduce the Tyr driver for Arm Mali GPUs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <b44ca395-102e-4780-949d-9d656ba18ec0@kernel.org>
Date: Wed, 10 Sep 2025 11:43:54 -0300
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Stone <daniels@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Beata Michalska <beata.michalska@arm.com>,
 Carsten Haitzler <carsten.haitzler@foss.arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Ashley Smith <ashley.smith@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 kernel@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <50CC05D3-CCF5-44AA-9E8A-71DA8733B78E@collabora.com>
References: <20250910-tyr-v3-1-dba3bc2ae623@collabora.com>
 <b44ca395-102e-4780-949d-9d656ba18ec0@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 10 Sep 2025, at 11:04, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On 9/10/25 3:51 PM, Daniel Almeida wrote:
>> diff --git a/drivers/gpu/drm/tyr/Kconfig =
b/drivers/gpu/drm/tyr/Kconfig
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..de910b2cba3a48e0b238eb0f66279758=
c02dfb6f
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tyr/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0 or MIT
>> +
>> +config DRM_TYR
>> + tristate "Tyr (Rust DRM support for ARM Mali CSF-based GPUs)"
>> + depends on DRM=3Dy
>> + depends on RUST
>> + depends on ARM || ARM64 || COMPILE_TEST
>> + depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
>=20
> For the Nova drivers I did add
>=20
> default n
>=20
> as long as the driver is work in progress.
>=20
>> + help
>> +  Rust DRM driver for ARM Mali CSF-based GPUs.
>> +
>> +  This driver is for Mali (or Immortalis) Valhall Gxxx GPUs.
>> +
>> +  Note that the Mali-G68 and Mali-G78, while Valhall architecture, =
will
>> +  be supported with the panfrost driver as they are not CSF GPUs.
>> +
>> +  if M is selected, the module will be called tyr.
>=20
> I also did add
>=20
> This driver is work in progress and may not be functional.
>=20
> to make it clear what people will get.


Fair enough, perhaps a quick v4 then?

=E2=80=94 Daniel=

