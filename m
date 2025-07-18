Return-Path: <linux-kernel+bounces-736854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8FB0A41A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72C75A3F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326822DA77C;
	Fri, 18 Jul 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MSkf02Jt"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF2D9ECE;
	Fri, 18 Jul 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841444; cv=pass; b=X5vynIVBnv6CFZN6/NFbea3FzpGt9U8GgwmmGFKxqAwaw5QoIbUchZ9MYoXQZeSQSdrsirwnk3zZN5hbJBubfN2bTRnfwNvc7hp5xI7jFfQxE/407Oh0h1QPzPT+dKv9Fx87EjugzMi06B5L/q4IOU7ubPpo9Moa8lRCFMqjhmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841444; c=relaxed/simple;
	bh=jrI5AabDOrUuIBCkIvF9I63MFIOO1I7vwZT6CJAMxcg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FhdMotDWTW/mqF3RpV0UGTGnk4kwFpGHBlg2LmoaLscpjL1d71pi8X/lX4czF+Rfzqazp4nTZqQ08k8UxprMCX9H8tdBMEmm2EMh8dzvy245U6ckQy398fsvSS44L5ARwQu7iov0GSIOTSQHL5VMpa/Eujb9/cmHFV2hwFJD5bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MSkf02Jt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752841427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BY918x/nUQ9QPpCREKZRwH9gSAgLS8wkJvSmKQoEyq+FKr/Xtec9BUdvXOsgKHLo1zQPaJUbXN5v4E8JHKsoRNyXgSivlwReSNGt87haKemu72cid/c/GXDDTQtR4QY4UmVOfU855VAwZ/qDocoY0vPFesI942Jgc8WE7R97WGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752841427; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TqZE4bTVyXgmW6oDat3RiWKc61XOjH3Ymaf5axDnYJY=; 
	b=iLaEjbJK/rjDFyL4mgDbe/E61BX9LhJP6F5CaNHxc/NeY2VdPwp1hD2KDcf3cpCFNq+/vlDkbCGOegyY5yBtltBRVphri/pIdJYME/cl+I07ceS1E0m8HWlZmxszPBnfQlB76Xp2H7Mt+gcQeetePI73Uak9ofEkdkK6y4wYe+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752841427;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=TqZE4bTVyXgmW6oDat3RiWKc61XOjH3Ymaf5axDnYJY=;
	b=MSkf02JtC5xUkRHt7ByIk1pcka0ziXcwrzCKaAPXvyQgTpoI2j48HlhWO+PP9IbU
	5uPpYojG8QH18KaPQnDg3wiUZf3lSfU1mZfG1K5sGo6nCafqUPf0kLILB1AASxFTBkw
	S/32yvaSEdKLqdOk9B9b/wG3+q/rc9XntRa58Bk0=
Received: by mx.zohomail.com with SMTPS id 1752841425219204.60076559284892;
	Fri, 18 Jul 2025 05:23:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v15 2/3] rust: io: mem: add a generic iomem abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBEL719XP5CO.FKBDQ4QRZST0@kernel.org>
Date: Fri, 18 Jul 2025 09:23:26 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19218014-4C48-4BE4-AE27-1DD309F8245F@collabora.com>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
 <20250717-topics-tyr-platform_iomem-v15-2-beca780b77e3@collabora.com>
 <DBEL719XP5CO.FKBDQ4QRZST0@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> On 17 Jul 2025, at 16:45, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Thu Jul 17, 2025 at 5:55 PM CEST, Daniel Almeida wrote:
>> +impl<const SIZE: usize> IoMem<SIZE> {
>> +    fn ioremap(resource: &Resource) -> Result<Self> {
>> +        // Note: It looks like there aren't any 32-bit architectures =
that define
>> +        // ioremap_np. This means that sometimes this conversion =
will fail. If
>> +        // we performed a lossy cast, i.e., using `as`, then =
`bindings::ioremap`
>> +        // would return NULL anyway.
>=20
> Why would ioremap() return NULL if you perform a lossy cast?
>=20
> Anyways, I find it a bit difficult to decode the actual problem from =
the above
> description.
>=20
> I feel it would be better to just explain that some ioremap() =
implementations
> use types that depend on the CPU word width rather than the bus =
address width.
>=20
> If you agree, no need to resend though, we can change it when applying =
the
> series.
>=20
>> +        // TODO: Properly address this in the C code to avoid this =
`try_into`.
>> +        let size =3D resource.size().try_into()?;
>> +        if size =3D=3D 0 {
>> +            return Err(EINVAL);
>> +        }
>=20

Ok, I do agree that what you said is better. Feel free to use it then.

=E2=80=94 Daniel=

