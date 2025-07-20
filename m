Return-Path: <linux-kernel+bounces-738359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35520B0B777
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A90A178A31
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FCF21D3EC;
	Sun, 20 Jul 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E32Y1i4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BE1CA81;
	Sun, 20 Jul 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753033611; cv=none; b=bF75Gv1VO9czqO1742l2dtmlxzJyNC5qEaZWjxE8XgMaL9gVVja6hru6IrxvNXxmvDsfPyWGJMuobwsXkMxE96v+T0tTG3npw9lop+j+I+4m5AR5FuAZPUhHwP//aE1hgd1dz4zJ3qgSwlkHxmhWbCo2gRW4qweHuQE/JhGq8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753033611; c=relaxed/simple;
	bh=dp2xImQurPv33Lbp+SnyauhdvmFkzI/ddZ5fBBCqTXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ru2ln8HmtFLjVwHJT9MZqy/Hw7uN1Uahg0OI68QNabyZz5q5l45QbT//FhM+ZH8930mbXAPV1YENu6E5k61yhtM+h9xFazMeaUnA89rXHY5mwt33Kr3cDgAcSLB2dCSi82FevupcjFa/l5UCV4rmfP+/kxIXlZvYijoYqkgsshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E32Y1i4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B0BC4CEE7;
	Sun, 20 Jul 2025 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753033610;
	bh=dp2xImQurPv33Lbp+SnyauhdvmFkzI/ddZ5fBBCqTXk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=E32Y1i4IktIUM9WaEM7t91YVd3YiDTrZGnu7BwDqKPXV+KGldIIe3Dijl4FJmxjeI
	 y0SJUwJxA7ItqSUpyVUIdOAf3nyemsPJP0u17fXNjso3epp396z0txDe4QMwEiaeQs
	 Lp67q1vULwzKZMeswUZnKHRoSexOmSyhmDQdZwIzX2VDKWjUbtMWLAeRYAAITKmgl1
	 t2vGkvAtUiTsNE2bUGZx7Ag4+NSL9vtFUUV7z+A4m8iYFtpG3PPSgMOB8BllQuLv3g
	 MihSrs+R54pcDli2mAbwQjk1JNQQrdMY2ldKbUcjlN1PPGdPTN5YAYtV9r2rjCCsMd
	 4OnxzGaK/7wDQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jul 2025 19:46:46 +0200
Message-Id: <DBH2JSV0SKWO.3FE776WW2O2D5@kernel.org>
Subject: Re: [PATCH v15 0/3] rust: platform: add Io support
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Fiona
 Behrens" <me@kloenk.dev>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>

On Thu Jul 17, 2025 at 5:55 PM CEST, Daniel Almeida wrote:
> Daniel Almeida (3):
>       rust: io: add resource abstraction

    [ Capitalize safety comments and end it with a period. - Danilo ]

>       rust: io: mem: add a generic iomem abstraction

    [ Add #[expect(dead_code)] to avoid a temporary warning, remove
      unnecessary OF_ID_TABLE constants in doc-tests and ignore doc-tests
      for now to avoid a temporary build failure. - Danilo ]

>       rust: platform: add resource accessors

    [ Remove #[expect(dead_code)] from IoRequest::new() and move SAFETY
      comments right on top of unsafe blocks to avoid clippy warnings for
      some (older) clippy versions. - Danilo ]

Applied to driver-core-testing, thanks!

