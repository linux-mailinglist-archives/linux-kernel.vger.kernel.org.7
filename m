Return-Path: <linux-kernel+bounces-734323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ECDB08002
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85B63AF5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D252ED85C;
	Wed, 16 Jul 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bzH0/Gos"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADD2EBDE6;
	Wed, 16 Jul 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702808; cv=pass; b=p8mbB2h4MyuSmKt/rUvnoX0lJIdPrttFdQiap9hC+pHO32V1SpNedYYAqduLA41YpLpFFKeQUZvF1HsCIzdymvmH28AV5S7cz4v/5LLjf8NhwOPGUPUfeIZiq0EKVNM6QnObYhBHSK9gCimD7tKdFpQYa7liXlEgHRJhG6Jc/DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702808; c=relaxed/simple;
	bh=GNQnRwPcx95lQIt0MriHGW6m7d2msbtdEj9dB/EY+nM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q73CMXeV4rOzUcOa7FxCpk/X4p7X8OmeVhd9fMWb4kkEVEbmjDfDVYZWM7KnnIHU6cSDFjAT2Z2Hiv3Fs0KhzmJ/dZLJd1kk+iAvg5qPXXP4vI7s9hj8nAmvvwbacAz+Yse75/Dsn35plBVWy/Jud1wqPkRbLIQtt7Kp+QpKgsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bzH0/Gos; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752702791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D3YCTKhxF+zDcFbe9AYpnCFj1tGFxqcfrIFV0UcCq+yiUdFMfvG4S2/nHkFJC1njZOX1fDunuO6caDCc7gsqDflzKEdRYB3qykeaMCE2uSOmf3rDokOiwOemXThPiWrWijQjWWXHkRk2PNMVmcWNEmloRlbFp+tKjHGX36HMgzM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752702791; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1oGbxQY8N42L5wcHrgVw0gSBED/ex1+QVLYz5dqAbbg=; 
	b=CIZ2tk5gfjqbkTlcUpD/BFkWJ7OsNyf/b7BTG0m2z7V1tmPGJpAOiimbNZnrS53q5ZoT8XmyXF7Nve1WaiaMGIgU9eqhc8TjOdvrsUEhaoFMf42cPnaHzbkSthA1aUIafAxp5LxYbzmoOM+2mpK+IG1F1r4NKUU6shubxtsLN6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752702791;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1oGbxQY8N42L5wcHrgVw0gSBED/ex1+QVLYz5dqAbbg=;
	b=bzH0/GosaYZEJwtd07pZ38bMVnEoXWDJ2gnlEfsAVS8721HTZsMQUVGd4wL0KZIQ
	QDCm4zDncUoc+V8Zoa80O/lmgVVZvV2oPKLlv8/l0V9nKbMrJCd8/84Jlum7aDdryJF
	bYHAz3s3yxF3Ntex8r0U5mj3Pqcgk9pLjwQa5ab8=
Received: by mx.zohomail.com with SMTPS id 1752702790094617.9265083725234;
	Wed, 16 Jul 2025 14:53:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v14 2/3] rust: io: mem: add a generic iomem abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250716-topics-tyr-platform_iomem-v14-2-2c2709135cb2@collabora.com>
Date: Wed, 16 Jul 2025 18:52:54 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A8152BD-A314-4A23-B104-AD802F7E2DB6@collabora.com>
References: <20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com>
 <20250716-topics-tyr-platform_iomem-v14-2-2c2709135cb2@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi,

[=E2=80=A6]

> +
> +/// An exclusive memory-mapped IO region.
> +///
> +/// # Invariants
> +///
> +/// - [`ExclusiveIoMem`] has exclusive access to the underlying =
[`IoMem`].
> +pub struct ExclusiveIoMem<const SIZE: usize> {
> +    /// The underlying `IoMem` instance.
> +    iomem: IoMem<SIZE>,
> +
> +    /// The region abstraction. This represents exclusive access to =
the
> +    /// range represented by the underlying `iomem`.
> +    ///
> +    /// This field is needed for ownership of the region.
> +    _region: Region,
> +}
> +
> +impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
> +    /// Creates a new `ExclusiveIoMem` instance.
> +    fn ioremap(resource: &Resource) -> Result<Self> {
> +        let start =3D resource.start();
> +        let size =3D resource.size();
> +        let name =3D resource.name().ok_or(EINVAL)?;

Note the change above. If there=E2=80=99s no name, we fail.

I just noticed that this may not be the right approach, but OTOH we =
should note that
=E2=80=9Cnot having a name=E2=80=9D is apparently considered a bug in =
the C code under some
circumstances:

	struct resource *r =3D v, *p;

        [=E2=80=A6]

	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
			depth * 2, "",
			width, start,
			width, end,
			r->name ? r->name : "<BAD>=E2=80=9D); =
<=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94


=E2=80=94 Daniel


