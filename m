Return-Path: <linux-kernel+bounces-737680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605FDB0AF4C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BB97B0E66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE41231C91;
	Sat, 19 Jul 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/dqqiMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35B33EC;
	Sat, 19 Jul 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752920212; cv=none; b=Lh4KpnsyMepb2d8c+7HfX01DHpc+PSNFGWqEDAvrzKS3YdW8uLIbFssnITbyOSkPhd2qDyqIgTP9RYahXS2h6AScDE84u+A+7JZaAEkwUr62ogIE8aMXVtdDtcBMTMaQcLJeBpiLnP1XSti7Q0K6SsjlFoWVDYetLJ7+xlc0dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752920212; c=relaxed/simple;
	bh=vMoSrYVq4474NS5oIs+mL25YlinUcBS1j/TwVMEVjqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KMJ3qwpFX697N9s7zrM6SA+WWwSULt42eE5ANu5qJB0curcGi9U0ix4uFZGyXMVrcEdNwUjDVQQoifbrls2zMU1jI9jkh2Rk94/5x/zRp43whKoEo9IPqS7E3hZclNI32WfubRQAQkIZnwrtB1Dl75M5A5++R/OQfA+kLMVy/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/dqqiMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA1C4CEE3;
	Sat, 19 Jul 2025 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752920211;
	bh=vMoSrYVq4474NS5oIs+mL25YlinUcBS1j/TwVMEVjqk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=R/dqqiMG2isc+jC4APHU3eeNpLn6X2GXuduDU11+G2e2UpcM1UC9HR4gRlL9bYaiO
	 c+zFZOG8cs/Gf56QMROYtO715oaOxeibEXW3MuFAZ6yuR9PIGKVXYzankaGpFDiywh
	 KPJh/n08FpmQBKubqKucrYxYwnrjQrlYwBDGPg3HTBvXrQFcWBvXnAVzr3E9WiKnKq
	 YLs0/moCT2p6Zbs+I0loAZhb2DEvuFWwGwRdZbHeOaruuZjnJv6SG6sAxXY9ICqfvJ
	 OANcvo0tSe117M7MhBUMqjZsxZVKcjv+ancdGF8Hw36ZGVxGvnkB5EWyIO4DaZ+6XT
	 rygXkG2KoDuFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Jul 2025 12:16:46 +0200
Message-Id: <DBFYCPVN29BQ.ODOJGUI54LV9@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v15 0/3] rust: platform: add Io support
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Rafael
 J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com> <2025071913-coach-prior-d71e@gregkh>
In-Reply-To: <2025071913-coach-prior-d71e@gregkh>

On Sat Jul 19, 2025 at 10:01 AM CEST, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 12:55:21PM -0300, Daniel Almeida wrote:
>> ---
>> Daniel Almeida (3):
>>       rust: io: add resource abstraction
>>       rust: io: mem: add a generic iomem abstraction
>>       rust: platform: add resource accessors
>>=20
>>  rust/bindings/bindings_helper.h |   1 +
>>  rust/helpers/io.c               |  41 ++++++
>>  rust/kernel/io.rs               |   5 +
>>  rust/kernel/io/mem.rs           | 283 +++++++++++++++++++++++++++++++++=
+++++++
>>  rust/kernel/io/resource.rs      | 229 ++++++++++++++++++++++++++++++++
>>  rust/kernel/platform.rs         |  60 ++++++++-
>>  6 files changed, 618 insertions(+), 1 deletion(-)
>
> Who is going to be responsible for the new files you have added?

I'm going to take care of the Rust I/O stuff. We'll add an entry for this s=
oon.
Until then, it automatically defaults to the RUST entry, like the existing =
I/O
stuff.

