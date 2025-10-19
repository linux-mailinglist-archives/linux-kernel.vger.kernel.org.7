Return-Path: <linux-kernel+bounces-859681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FA6BEE442
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 162174E42F3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB82727ED;
	Sun, 19 Oct 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZawG/+Ue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4D366;
	Sun, 19 Oct 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875269; cv=none; b=eix0MTV8GnCJZ01pjpL3UoNoB83Fd4Nskndqv274FIOwQJtwASDugWlZJsrT+Zn3ksp6bv7m4bnb1wloX+0Xlxy3b2fYfwrhWrqlFGzhzSeEYArimB666FBNndFSphPxVu4jyJtgZZs7gLhEtTi9SG+MqyDEsc6WWf5vr6f1A3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875269; c=relaxed/simple;
	bh=wLrFfQpwX5AUQ4Kj9Hwv9ZUGP6NnwzbpnRrBBpfemSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=oX2/yHb57hnbw/7LS/QNQrhDh2D99fL1F+Nwh8YfvcvaVXLUXdeLr3OjvLYjTRQMoy71V4Ueu+ZDIXD2XsWXVzjNlu8UflzHjLVTjVNgjzCqOGbX23t6TlaUgOdQN5E/fBzjdbbsZ5Pi1eX4p3WtyqqT8pk/K9k+XoT23/bp4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZawG/+Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5288FC4CEE7;
	Sun, 19 Oct 2025 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760875268;
	bh=wLrFfQpwX5AUQ4Kj9Hwv9ZUGP6NnwzbpnRrBBpfemSg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ZawG/+UeDCjvxPz3IEiLT2VWNi/cjkgmnXahV+otzDknn6x9tOZLVvidi9fOq2gmz
	 fEPLc6j5nVSYJF8W0FIKM2NnwSc8V+O80LChD5RbOpfF8slDA5t1et3G553I3RSqes
	 93/xNBk1/i4VhCzLAwmV6QjsPzW3gpAyVYRFchq62kEcnZvD4cAgPlKbDYaHEpXQ38
	 ZqRuD1UfpolvZ+vXbTcm0Ab/GGuZZK/2juma2tSNxPyRwkZ0J5hgFe+S8EzyDfwsuR
	 QovunS3QcRU9vMrz4BuS8Dw6B6zC6TwCLPB+lAqo5Zmdur2Jvw/sViqGG7rlcUHyq9
	 LVNdyBefpdX9Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Oct 2025 14:01:03 +0200
Message-Id: <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <DDKOLD1897SY.84W93E6L8ITR@kernel.org> <aPSzE7DpA7DxTHmm@google.com>
In-Reply-To: <aPSzE7DpA7DxTHmm@google.com>

On Sun Oct 19, 2025 at 11:44 AM CEST, Alice Ryhl wrote:
> On Fri, Oct 17, 2025 at 04:53:09PM +0200, Danilo Krummrich wrote:
>> On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
>> > The reason I went with a trait is because that's consistent within the=
 file.
>> >
>> > Otherwise, I don't mind one or the other. If we always want to use a s=
truct, I'm
>> > fine with that. :)
>>=20
>> Actually, there's another reason I forgot about since I sent the series.=
 :)
>>=20
>> We need it because we derive it from blanket implementations:
>>=20
>> 	impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
>> 	impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
>> 	impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for =
T
>
> You can still use a struct:
>
> struct BinaryWriterVtable<T: BinaryWriter + Sync>;
>
> impl<T: BinaryWriter + Sync> BinaryWriterVtable<T> {
>     const VTABLE: bindings::foo =3D ...;
> }

Yeah, but do we get something for adding yet another type in this case?

Another point to consider is if we want a more generic fops abstraction typ=
e.

In any case, I'd like to add this as good first issue for the whole file to=
 be
changed accordingly.

