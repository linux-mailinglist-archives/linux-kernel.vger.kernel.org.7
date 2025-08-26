Return-Path: <linux-kernel+bounces-787265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E150B373BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DD2A1D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE92857C7;
	Tue, 26 Aug 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="U8nHMPYh"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F419FA8D;
	Tue, 26 Aug 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239454; cv=pass; b=FgM8vJjLi34TpheJfcrcLklkNBjnMe0w2iYVN/E831179E+cuUUz/0n0RzEjs/bXp9QWsw1z28iEV3Eb2PRqCk2m09ferf+f+GNtKFZvjUyF95ythCObP3WC1HJ1AhvPm6ArCu1xbN22hPCUL3DOAy1IDzJ8C32VLszoKYb58bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239454; c=relaxed/simple;
	bh=jW8LrzyBg/k0qFrop6gT7MK52/NnKrIw90gZXeUxmvM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jNvOoSybpeZVz3nzUWq7n6WwZ5AkAThQTsJhpU1RyA/i0v0ZfKeJVxZ29HzkQ4WLQ0kxj2GNo2zP6RsBA/2/76csaGSDC0MWyT48YmS9N/eW+EwkzpWJouU3Kbf/4B+LWXrLZCuoenb/pIES4OPG+dENp9RiF3DnwoLTaN2imBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=U8nHMPYh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756239434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YugFtM2JJiFzCuIHiQhSgpOSEGM8E1q9IUyMuv5TS2XpDpWWfR4U8xRDGUg2r6VfxzPkwBq9JjvKHsd/Ls6MMjGOPGfYPrqKFuvXByrbtxi7USkW516KHFb+NBoYJqfDe3XPxCSixlEd5azMQ68Azqf6zqgL5s8AUIFNwpMmg4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756239434; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kWFMjU3KD3nyj2cVdJLZORbF6zEso+XDHCk9O/tM7C8=; 
	b=ZAqODN8e8GzKQXZ167VeKE4nne+YVBkfP85ou0c2RC2nDFrb9W6QpG9zp2ZGbASmmzZNp7G9UebpXqqU5wxQA3lBMJoXfbT3VJH43k0QY6kesRwezgPu4Gp9My8oVBQ5VMGP0g6XqE4Al74b0LWaq2qAbRJA2bfwm731bWPkMQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756239434;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kWFMjU3KD3nyj2cVdJLZORbF6zEso+XDHCk9O/tM7C8=;
	b=U8nHMPYhsWFura+Og5fw4lFOtznzCIhUiLQhBmnDR90cVeYMFB7bj8XLFMdDqWBb
	e9ZrKarjfZLuJla3mwdx3DnZuF+Kt0WVfnce3SoXSogHZgIgfOKbN3OPFmnzp04h+ba
	jNc8uQqvH1v0Jpn5aEJaMCQfmYwTOlDBlGhpCEEI=
Received: by mx.zohomail.com with SMTPS id 1756239432857500.3997770708535;
	Tue, 26 Aug 2025 13:17:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCCLKO6HTCM8.YR8VE8PAXQTM@kernel.org>
Date: Tue, 26 Aug 2025 17:16:56 -0300
Cc: akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BD5A415-CD19-4B8E-A2A3-78F60FCC863A@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <6625A8C0-33B2-4AFC-984B-130F8E06113D@collabora.com>
 <DCCLKO6HTCM8.YR8VE8PAXQTM@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 26 Aug 2025, at 16:13, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Tue Aug 26, 2025 at 7:40 PM CEST, Daniel Almeida wrote:
>>> On 25 Aug 2025, at 10:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>> +=09
>>> +unsafe impl Sync for SGEntry {}
>>=20
>> IMHO all safety comments for Sync must mention how it=E2=80=99s ok to =
send &T to
>> another thread for a given T.
>=20
> When we say "`T` can be accessed concurrently." it means that it is =
valid for
> multiple &T to be accessed concurrently from different tasks.
>=20
> I.e. what we care about in this case is interior mutability, where we =
can have
> three cases:
>=20
>  (1) There is no interior mutability, hence the type is Sync.
>=20
>  (2) There is interior mutability, but there's also internal =
mechanisms taking
>      care of data races, hence the type is Sync.
>=20
>  (3) There is interior mutability and nothing prevents data races, =
hence the
>      type is not Sync.
>=20
> I feel like only case (2) really needs justification, because it needs =
to
> explain how those "internal mechanisms" work.
>=20
> Those abstractions do not have any interior mutability, hence I think =
what we
> have is enough. Does that make sense?

I think we're both saying the same thing, but the wording I suggested is =
more
straight-forward IMHO because:

a) Being able to send a &T safely is the definition of Sync,
b) When you say:

> "When we say "`T` can be accessed concurrently." it means that it is =
valid
> for multiple &T to be accessed concurrently from different tasks.

I think it _implies_ that it is valid for multiple &T to be accessed
concurrently from different tasks, and that it's therefore safe to send =
a &T to
another task, but it doesn't spell it out. It's up to readers to then =
make that
logical connection themselves.

While I do agree that only 2) actually demands a more elaborate =
justification,
it's simpler to just rephrase the current safety comment with:

// SAFETY: `SGEntry` has no interior mutability, so it is safe to send a =
shared
// reference to other tasks.

or, more verbosely:

// SAFETY: It is not possible to mutate a `SGEntry` through a shared =
reference,
// so it is safe to send a &SGEntry to another task.

Or any variation of the wording above.

In any case, I agree that this is splitting hairs a bit and I have =
nothing
against keeping it as-is, I just thought it be a tad clearer :)

=E2=80=94 Daniel=

