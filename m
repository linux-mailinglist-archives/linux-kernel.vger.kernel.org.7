Return-Path: <linux-kernel+bounces-766565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD1B2485B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498B18806AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA52F2903;
	Wed, 13 Aug 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC/bWgNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69F21256B;
	Wed, 13 Aug 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084020; cv=none; b=iMQybrcAeQEME3Upd0cgiKqPsZZ9dLt0UYorO6ZtuVe05NVVT66ceYmtb9tPvU06XSm2bYib0qTSSjWu5z0mUmJ5mov7RBPlALvzm9RTUBA4RM8JRT1/ehmelhIWcAHmvr1tJFRbIAAxl1txfBzCU1NSXpIml6Mh7rntF2+ILM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084020; c=relaxed/simple;
	bh=d0tzegHRQ43qOylbLXGzZrXq17jhyid9F1c9lV4sjfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YbmczdyzlD1HRUXSXYiT+MYJfqM8jIyVQiyUJmwaxUrUm+T01IqID7H+YOMo2absTCJThVjzvOGmQp8iY0WA99/g6ktXVr038K1IuJwZyzv3PffPWHUhJfgGd/WZ+6/fGsPCdnJKpdM5CS4wjXFWtiQ52drjSZIVOrBgZhqwZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC/bWgNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2286AC4CEEB;
	Wed, 13 Aug 2025 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755084020;
	bh=d0tzegHRQ43qOylbLXGzZrXq17jhyid9F1c9lV4sjfs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bC/bWgNXkuUpButRMvsBLrSDIc2QLKNUGYm1iwQcx8SD18M6E2Bq/d+qbBuGvsqnU
	 i5a+/8yjawu5YV++fIiZVXOI3Hcw8MoPFgxpqAUh8BdgeZYMPNfU8XvN+g4R57DVWQ
	 wjgbMb5CqYY91C6Dw9yIQq+OmiF0lsT0LUWC2crt40by9D2/b68JVtTlv/tOn7lUBo
	 /6RAEmhCTXNrksQdwvacbLI9A+xU45rLvZ578qYI4yRGHCwoZMrPYgqxqg4DdxwkTm
	 X8unZQ6jj8isdfPvwrPTchL05qyKTOKflfSXgb4LfZvGsfhxURpkdgr7Q8ncbW73by
	 HaA95QdEOlA9g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:20:15 +0200
Message-Id: <DC19CXUEORB7.241EQY0IXV7WD@kernel.org>
Subject: Re: [PATCH v4 0/4] Rust support for `struct iov_iter`
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Arnd Bergmann" <arnd@arndb.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Matthew Maurer" <mmaurer@google.com>,
 "Lee Jones" <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
In-Reply-To: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>

On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
>  rust/kernel/iov.rs               | 311 +++++++++++++++++++++++++++++++++=
++++++

Does this need an entry in MAINTAINERS?

