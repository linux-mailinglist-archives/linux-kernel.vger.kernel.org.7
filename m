Return-Path: <linux-kernel+bounces-787802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A8B37B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D237A1B632EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55092314A71;
	Wed, 27 Aug 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtHAkBA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB883EEB3;
	Wed, 27 Aug 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278743; cv=none; b=N23dp6ckPW1qfsaTB0ziYFQhQ+xUEPO3OeeJamSflVDC9IsZBQ3qlyWJ+sn2omi4SZpoH5EImygWJ1kjk+9kQAp8waoli9toF5O1eLcn64uM0syNJ86Mlb2qGdWjW+tbGLNIAWsHYlN0uR10JossW87nCHhyzSJ+c2hbj+hbUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278743; c=relaxed/simple;
	bh=hSQyXH2l/jK1XL9U1NDobErbBuoxjNhahxJ89CbTppo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLTvWnUfCU19VCNlpH8ZbuDFlpQdZ5I4D1ff1YdWx1Kbv9Aw20lEWgE3LgY4pHYDNftBTQfjeMSkz4ljKbOO+h2za4cO95GtlSIVXpiaAZbP/6yiHGQIAEVwMeZj4fmRLb+FTJbWT2Ehv4dFU7iWyo5Hh2/TZhv9/o6V9CQ3F4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtHAkBA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22475C4CEEB;
	Wed, 27 Aug 2025 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756278743;
	bh=hSQyXH2l/jK1XL9U1NDobErbBuoxjNhahxJ89CbTppo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AtHAkBA+cBiIbAftXtXNcGz3FobX/ez2/SMkxg/Ni9QHlu3vWrU9xRluah6c1FK/F
	 qUJPCgvtCDdnETwL64wjVvtsf2TfgTdNmjQqYm9NEQlvUe5t5z9u5vFEYV/n8Z+hLG
	 AK/VZ2HXYgVLNntubI02jl28eOuYwFkTAeLqX2lq9yXT3R3ufhJaewwyEoGHiX6fbx
	 O7OITnY/CCqhcZSqz/FyUVNMblcaQPGJDyvKatOG8fKYzsrT1Ee5ZhnHUn9cxIHHVg
	 jTe7txSmGugAFYbYGNHgXN2Qx8pv21pFolAaY6596iUhr9TZplHP1m8Z9BTGKrjSBw
	 O1ynjX8NKCIqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com,
 daniel.almeida@collabora.com
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
In-Reply-To: <CANiq72n4GKUo3LjNkvBvh0C=20tfz7D_jirZpu+2BogqNuK3KQ@mail.gmail.com>
References: <ub8ohgErgUJB1KWyrSWn18gSQiyiIJ4Py133yi5fMR68ZG2zeWokoP7kULU7voBjry46A7GZUSrHuCQn0C_DZg==@protonmail.internalid>
 <20250821035710.3692455-2-fujita.tomonori@gmail.com>
 <87bjo2witj.fsf@t14s.mail-host-address-is-not-set>
 <20250826.205941.963904478024459782.fujita.tomonori@gmail.com>
 <MXM2tcMcDw96t0MaotkNUv8G6s6LZSMuI9XZppDap5ha8qIbYPjF3P4xl5aRumL8avwdLDL3vBAnnr1acmsYEA==@protonmail.internalid>
 <CANiq72n4GKUo3LjNkvBvh0C=20tfz7D_jirZpu+2BogqNuK3KQ@mail.gmail.com>
Date: Wed, 27 Aug 2025 09:12:14 +0200
Message-ID: <87349dw84x.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Aug 26, 2025 at 1:59=E2=80=AFPM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
>>
>> This can lead to an unexpected delay duration, but it's safe in Rust=E2=
=80=99s
>> sense of safety?
>
> If it is just unexpected behavior, then yeah.
>
> Perhaps Andreas is referring to C overflow UB? If that is the case,
> then in the kernel it is actually defined due to
> `-fno-strict-overflow`.

OK, cool Then I would suggest that we just add a small note in the docs
about the C behavior that even though passing an invalid value is
considered a bug, it will not cause UB or memory unsafety.


Best regards,
Andreas Hindborg




