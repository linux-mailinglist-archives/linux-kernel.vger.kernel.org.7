Return-Path: <linux-kernel+bounces-725379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F178DAFFE43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C793A89BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120F2D3ED1;
	Thu, 10 Jul 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2TSpPXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51420B80A;
	Thu, 10 Jul 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140199; cv=none; b=pdoS16I5JKw9KpjYSdyIkvR+OiL4xYpc6X+6UBEwKU4X/RIKjv3raFdZCw3521p2rdjtbwLNwoT8KMEwFJBApFFQgjfMxG3FG/CHywWpSQZMITlCoGco7fR0XTy7G2tdQnnqFcBNOJgfVeGgXdoCoBjxkS/ASGDSBEbuJb6qzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140199; c=relaxed/simple;
	bh=ySXE5TVVhZ8eOfELibVbDSdW7abDUxlv6vdaZRzNTe4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=L47NiQHPd+FzVUmBdBjd9khnU4zQPnWwrUQ87p7fc6WyGXcpriHDGYJtd3FdsYNjJvDjqSeNZroME+WEkRAI3VugCUuLMhevSZIq7YSpPPdcEkbN3iVu3Ru/UdJxojkJdIO9Ou87CNovznL/Oom/w0W4kEEQxheCWOqZBnJnhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2TSpPXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F28C4CEE3;
	Thu, 10 Jul 2025 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752140199;
	bh=ySXE5TVVhZ8eOfELibVbDSdW7abDUxlv6vdaZRzNTe4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=B2TSpPXp+EQ02I4bQ6KzteqI41zNuaGDzzLIfCNPB4LuzSe1XZwzTC0IjandSNqgl
	 MEtdDuxM9/GgyyO2YXWbOvffpp2RyvVJF/u0pnlWiv7Pvq7pqw5tFWDBboyPxA09qY
	 toBRtqMeTPYQ9oPU01n0B+l2jZ67e+ywrtvf1IjIAhGstI731PhPBD4cyWEYB9faKR
	 Aj3YEhiEOvjwJhENcKFgQFPv40P0G/W7Yi+OMDe+8L8H/W+H+RsInKepCe0x5FN+Ww
	 QkcvU4YofZI+IDWnnYc1U0zzN4SonZPwS0a3pbysCSLxao+EU50n95OShsHCGZTBAy
	 YymlZj44tpcUw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 11:36:34 +0200
Message-Id: <DB89V15HIG8C.2HL9JVKFNEDTK@kernel.org>
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
 <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
 <aG7pP1BTLQKInFrl@cassiopeiae> <2025071014-radiantly-dreamland-4017@gregkh>
In-Reply-To: <2025071014-radiantly-dreamland-4017@gregkh>

On Thu Jul 10, 2025 at 7:27 AM CEST, Greg Kroah-Hartman wrote:
> Ugh.
>
> Yes we need write.  And read, and custom file-ops, and the like as
> that's what debugfs is doing today for C code!  We need this to be as
> simple as, or almost as simple as, what we have today in C or no one is
> going to use this stuff and go off and attempt to write their own mess.

I agree, we really want the helpers you're referring to below. I think we
discussed this in previous iterations already.

> While I would love to have something as simple as:
> 	void debugfs_create_u8(const char *name, umode_t mode, struct dentry *pa=
rent, u8 *value);
> like we do today.  I understand that this makes all sorts of
> "assumptions" that Rust really doesn't like (i.e. lifetime of *value and
> the like), BUT we MUST have something like this for Rust users, as
> that's going to ensure that people actually use this api.

I think it can be as simple as

	void debugfs_create_u8(const char *name, umode_t mode, struct dentry *pare=
nt, u8 *value);

in Rust as well. Declaring this in a structure looks like this.

	struct Data {
	   counter: File<u8>,
	}

Given that we have some Dir instance, this can be as simple as:

	dir.create_file_u8(...);

Which uses default callbacks for read(), write(), etc.

> Look at an in-kernel function today, like ath9k_init_debug() that
> creates a metric-ton of debugfs files and binds them to different
> variables that are owned by a structure and more complex data structures
> and memory dumps and other random file interactions.  We need, in Rust,
> a way to do everything that that function can do today, in a SIMPLE
> manner that reads just as easily as ath9k_init_debug() does.

That's possible with the current design and code, it misses the helpers, su=
ch as
create_file_u8() above, to reduce the boilerplate though. With that, it sho=
uld
look pretty similar.

> So no "we will add write support later" stuff, sorry, real drivers
> require write support in debugfs.

Adding the write callback seems rather simple, so it should also be fine to=
 add
it right away.

From a design point of view the things above basically come down to differe=
nt
variants of create_file().

So, it should mostly be sufficient to add subsequent patches to this series
implementing those.

