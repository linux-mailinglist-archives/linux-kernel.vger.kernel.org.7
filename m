Return-Path: <linux-kernel+bounces-829000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE67B96049
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A6319C3905
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF0327A13;
	Tue, 23 Sep 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aZViUv6j"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8433233FE;
	Tue, 23 Sep 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634324; cv=pass; b=N2YEh31gWtAiR2TLlQz0GhAs9FVaPeTSKe5yFPPARWPm0rXSPpWnz2Jac6sge/Jo5aHxgprrAHat8PKiT/9VA9ctatqgHgrbZ5y7NovWUXjttzlGmJ92GzKz/kIUbr69AUZR1HFWWPPsiYPmgb5pQZod9TIkJ+y4sbWvN/33juc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634324; c=relaxed/simple;
	bh=ayc7LDgpinbNwmiQ1ReylZwhBcwpCvzguEK9YRh99Dc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CPP4wMewlyrI0SXXcW0l6xFBZZeJMWb+NciClGj32HkHranncsd/ytA9NnHVG1pTIvheWVEX8E69j1FIc/uFQpfuR0TnEWgidCvtxJtnYUMGZ6f24WWcoUdNhykBhnMkRdogHKC/gryW3BYUlwMhLt1EODTMgRYt+iMiNRdR6G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aZViUv6j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758634306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DSY/UafVK7otGqfwkFudCbOCR63Ti9t0DC8WxF7EJGUZYbjti4g2WnZxo9hQv3gy1ClB5OVJb6LTZdBy2dkVyUqSbdwnVI0wrEr/JMnzGRv08PfEhaButfMYClcyf9PgD44dnTVrsZiBQjPGnTMkA9/j9/YY+babB8LeCEzuj74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758634306; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XhSfK3m6uQmEJ1qNWt9tVO6bvuYGSVJ4syxk3NSs+eY=; 
	b=Ec+CWSRHFigvzY5OeS3DGP3DpWIvJvsJyrobSJ63vE1CINBKnWT+9KUc/HccZMQm1XeZi/8MpKt0YF+Zao0MEI3XybaoohG7ucI76eFBq/pDeC+sTMdx4f+OlPXGzKuGvoddTyFFRFNwWTF8d7HOHoXNn+SA4oUBAJp0/Ir+deQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758634306;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XhSfK3m6uQmEJ1qNWt9tVO6bvuYGSVJ4syxk3NSs+eY=;
	b=aZViUv6j+PiGcUS77Er8fDMbyyUb0bxTimap10ko28o8lTx08LT6JAGQSay3BXjc
	+tbeB9moeT3vBxYDM+hitQgtuzgPtjGy5e31DzKyD70bNhbpDsGoCYSFKJj8/DTsHfL
	y8M5Picco+nk381Es/BceHBLS8/E0e/i4uJbjfTA=
Received: by mx.zohomail.com with SMTPS id 1758634303654976.8874865886604;
	Tue, 23 Sep 2025 06:31:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
Date: Tue, 23 Sep 2025 15:31:26 +0200
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
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Danilo,


>> +/// A USB device.
>> +///
>> +/// This structure represents the Rust abstraction for a C [`struct =
usb_device`].
>> +/// The implementation abstracts the usage of a C [`struct =
usb_device`] passed in
>> +/// from the C side.
>> +///
>> +/// # Invariants
>> +///
>> +/// A [`Device`] instance represents a valid [`struct usb_device`] =
created by the C portion of the
>> +/// kernel.
>> +///
>> +/// [`struct usb_device`]: =
https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_devic=
e
>> +#[repr(transparent)]
>> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
>> +    Opaque<bindings::usb_device>,
>> +    PhantomData<Ctx>,
>> +);
>=20
> What do you use the struct usb_device abstraction for? I only see the =
sample
> driver probing a USB interface instead.

What I was brainstorming with Greg is to submit this initial support, =
and then
follow up with all the other abstractions needed to implement a Rust =
version of
usb-skeleton.c. IIUC, the plan is to submit any fixes as follow-ups, as =
we're
close to the merge window.

struct usb_device would be used for the skeleton driver, so we should =
keep it if
we're following the plan above, IMHO.

=E2=80=94 Daniel=

