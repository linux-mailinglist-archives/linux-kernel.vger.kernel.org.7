Return-Path: <linux-kernel+bounces-725742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856CB00327
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5902116A4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561C2253F2;
	Thu, 10 Jul 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZaJHaMbr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69237221F29;
	Thu, 10 Jul 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153433; cv=pass; b=H81ag8SA/qPtFc+wqj+cpgQE0hymp7FpNZhF/ldUEnumk4EtuLMtzCW5GfOs9/itagO6DUZQ/8wV5kHtUXe2dy2odiIflETVvdhtQVU1E+nUcKGdnudCYxnjG30Y4R8Pu0uM6Lb5XaZJKhBRRQqAxK/5FYdA6Sdn2u+f7KBHF+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153433; c=relaxed/simple;
	bh=lMlH0CkVmMtMpfmR+DhnUvRnkI8F6sCWPShVUe4gBQU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T2s83KhAm0IEXiV3XL43UjoXWOi0iHrXwZ5wd55KC0PGSfnKAv+IkLEzkCwVZvMfoxd4HCPpsLB5N2DdRbrQdFbKnKMhvZHb+yo1wNhAjEY8YEu/qZeb2GVcfpdnKVevdKqzSqcWoVEf8DRNZxJkfdDa8uRseydKutC49oS1D4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZaJHaMbr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752153402; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kuq6Ieb/UfY2uh+Sg5DtsPMvV1wK9CtE+b5zxph8TQEk3DMWGpT56wJI9d61oYQ+GrLL1XERSJq1KTktzH98ywha1g2/VN6Sr3RM8bhceU1KUM+xS53cr2O6xXD9nytkH+G4zCcW7SSIJ2Z5ecmeFkfL+H4WDmi4/e0LHLFqYHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752153402; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SFPxdbWPvOwzpJJw2wS8FEYjCUqBehpDqU3KFQNmQW8=; 
	b=lKtmVToCftGtCk6UTR+1GRvy9S+kvyfStKznX8akbv8X0MuwDQgMsreNjhyVTtKdCyOMCSWPefS5dKeyJ7Pd0XGkxU+6mScgvdbO5KmrXSx3Ou/2Gx2yvjN9/MZIdJjYMGHKbY4UPNvTqk945QNHIC0HiI1W9/YLDjSaVRJzRTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752153402;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=SFPxdbWPvOwzpJJw2wS8FEYjCUqBehpDqU3KFQNmQW8=;
	b=ZaJHaMbrWeE7xZw8FwFQpE/sp86nHH4GlI0N69B6tNtPFG//QB4I1Xavk4JCdD/+
	BcOBVMnuL+KBSj2n4d6+tL3GjuA4NAVYyMAzfpIKUaWvQv0A+SQsRT1G5NIAIqfUigZ
	dL3n6AX/WOURnsa8A1nDA9e3kTWuMEvt/+ValCc8=
Received: by mx.zohomail.com with SMTPS id 1752153398901356.9197818711657;
	Thu, 10 Jul 2025 06:16:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 1/3] rust: io: add resource abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aGt6CZAUeuK0XnmP@google.com>
Date: Thu, 10 Jul 2025 10:16:21 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A2EA665-F738-4C5D-914E-11380422038A@collabora.com>
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

> Is this name used for a lookup or stored? If just a lookup, then it
> doesn't need to be 'static.
>=20
>> +        flags: Flags,
>> +    ) -> Option<Region> {
>> +        // SAFETY: Safe as per the invariant of `Resource`.
>> +        let region =3D unsafe {
>> +            bindings::__request_region(
>> +                self.0.get(),
>> +                start,
>> +                size,
>> +                name.as_char_ptr(),
>> +                flags.0 as i32,
>=20

JFYI, this is stored:

static int __request_region_locked(struct resource *res, struct resource =
*parent,
				   resource_size_t start, =
resource_size_t n,
				   const char *name, int flags)
{
	DECLARE_WAITQUEUE(wait, current);

	res->name =3D name;


=E2=80=94 Daniel=

