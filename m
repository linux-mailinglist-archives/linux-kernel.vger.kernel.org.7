Return-Path: <linux-kernel+bounces-805952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614CB48FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9C345246
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03830BBBA;
	Mon,  8 Sep 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYC8cec+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06F30ACF0;
	Mon,  8 Sep 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338694; cv=none; b=qUuBNW9Ze1nn0KJdwPlBlgXXLh+fmSzOo3HFSX3yAuDN3y2o0MgMXhd+wN+MlQMYEMRHsZ2cmiQQDdVmkTKcKKxzFCyqa/lmKhOtcskGGYSDO9D6amgO/8BpV2LqKkJZFQxnABxzroQYvyrTCGbItK2fMg13O1WkO1YmMT8NhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338694; c=relaxed/simple;
	bh=c88FQ0i5OL/97YDEXu34QlMCovtvSIcJwKO1Me4FgnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ccrfMKGbA/OCPh95Q9G9lnveA/Q4fliDwMUEHzpBjSzZJ+yuVa9lmOC1YRsTjJtb/lJgo0B6lFdTKRDXULjaQ7cJ5//Nbs+mbRSC+GNLglacx4Q6dayzPvaqaBo3Umg7wY2zrXtXGfaPGB3rAOGFD5pjJ6+Yo0vs4dunnAzmdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYC8cec+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132BAC4CEF1;
	Mon,  8 Sep 2025 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338693;
	bh=c88FQ0i5OL/97YDEXu34QlMCovtvSIcJwKO1Me4FgnE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AYC8cec+otm76elhRixcIwpAWzZzbvjDO3dOWcB/sm3xicSiwYK3oK9XET0K9cIqW
	 39eChRgPS0ruhGe5TWSwML/cjW3BicLTy0V9soAl7gxWiKcDp6kNJYuUvVKQloFY/k
	 46UF7KEzOPfQ1sv7s2RCB39/Vg1Gn+OjCjnd6EjRpRtJJNOqVzIFX+K59YzB6rReuW
	 DKCJUaIqUHxLwRDwg0On3rgMTLxBYjp6zC74H1RAtFKN2GwPhTD71SToqf+T94NqH9
	 +uv2UJ8GMxVEnOiwTdcPSF1g4zgS6Mlqntzr1Lkm6eFOZ9wi8bbIm/j3OcmFiYdlPN
	 LQ3OlwgFcESiQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 15:38:08 +0200
Message-Id: <DCNGKO9TN2MI.1VQBWAO7A6U2X@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Matthew Maurer"
 <mmaurer@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <CAH5fLggZ_ELrcLekF5GD5JQAkSz_Ycg7T+fZc7crjFA5jk1y3Q@mail.gmail.com>
In-Reply-To: <CAH5fLggZ_ELrcLekF5GD5JQAkSz_Ycg7T+fZc7crjFA5jk1y3Q@mail.gmail.com>

On Mon Sep 8, 2025 at 3:34 PM CEST, Alice Ryhl wrote:
> All of these things is why I recommended to Matthew that he should add
> back the scoped API, since it doesn't have all these drawbacks.

Yeah, I think it's the correct solution to make those cases nicer.

