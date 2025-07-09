Return-Path: <linux-kernel+bounces-724545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B601AFF41C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E189617482D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356172367CD;
	Wed,  9 Jul 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbtvDU3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC761EA73;
	Wed,  9 Jul 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097664; cv=none; b=l02qan7t3EoY9zpFqI/nF4D/fyJX6nIn7kSChklEUv/8CEdivY2M6M0nDwIJwtZWInCxKebfkar8hiTEvb3MVPpO6eePvBtok78uBY5M8BI7qF5F4cuNQitmeZOn9kbUX3JIvg5Ny/BXs6Kr+korsupNA6vu8kpMLzuwI2o/e5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097664; c=relaxed/simple;
	bh=IbA3Pii61RHcLCia1EpBU/W1NkH4aFkru3V4REAFztA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=S+jRqgcD5Fp4/BuRfrxIPrCK5wlMnLNf3y2iSmT1NOm3XjgruvSM3ukzIJfBTx4JCzfmSAzZvZ6JGqcfNkyR5lyag5vTVXhFggSJWoOIAy/KihpivyNd6FwVwH4gIbHXjLX5HVAM9A+hG5Zepg3hSvvgi6miKzVSNwdBcUmvmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbtvDU3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244CFC4CEEF;
	Wed,  9 Jul 2025 21:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752097663;
	bh=IbA3Pii61RHcLCia1EpBU/W1NkH4aFkru3V4REAFztA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=rbtvDU3Jp488JI58Ft2PDPetWQ8lJzO0MthbwzXyB23KAFY2gTLfYnrRuWAsK6Fhb
	 zNDnwm5GdK13gdMWoQE7SWXBw25+/P3u/gFdffDREZH/BclVw7firoKhmPM5lhe21p
	 ApHxucgPcZXa/1eoH2hoWqLKCRiLwDu46Cob+f5y3XfZzjyYORHZR95uPcKAcGFICA
	 EwidMs1vA6D+m1tkjCyr8lg6ksBgLX0/Hoj7lTIUifZk/ljPuUbMP5qd2cJT4Z7QcW
	 HdIOYM5tSu1rT1Tuy1IexaiimAvMApiu2aYXd/qU8tKVXIOK7Uh1IFBBqfE4iDFbyc
	 e5tyxD2aUY/XA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 23:47:38 +0200
Message-Id: <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>

On Wed Jul 9, 2025 at 9:09 PM CEST, Matthew Maurer wrote:
> This series provides safe DebugFS bindings for Rust, with a sample
> module using them.
>
> Example interaction with the sample driver:

I understand what you're trying to do here, i.e. showcase that values expor=
ted
via debugfs can be altered.

The problem is that the current abstractions only implement read(), but not
write().

So, to work around this you create multiple files for a single value: one t=
hat
only prints the value on read() and one that modifies the value on read().

For instance, you have a value counter (AtomicUsize), which is exported as:

	$(DEBUGFS_ROOT)/counter
	$(DEBUGFS_ROOT)/inc_counter

where=20

	$ cat $(DEBUGFS_ROOT)/counter

prints the value and

	$ cat $(DEBUGFS_ROOT)/inc_counter

increments the counter.

While this is technically not wrong it's providing bad guidance to people.

Instead this should be something along the lines of:

	$ cat $(DEBUGFS_ROOT)/counter
	0

	$ echo "++" > $(DEBUGFS_ROOT)/counter
	$ cat $(DEBUGFS_ROOT)/counter
	1

	$ echo "42" > $(DEBUGFS_ROOT)/counter
	$ cat $(DEBUGFS_ROOT)/counter
	42

Given that the abstraction doesn't support write() yet, just don't try to w=
ork
around it.

If you really want to showcase changing values, you can, for instance, crea=
te a
workqueue inside the sample driver and modify the counter periodically.

We really should not teach people to modify values by read() instead of wri=
te().
Also, without this workaround there shouldn't be a reason to export the exa=
ct
same value twice, i.e. no need for File<File<AtomicUsize>>.

- Danilo

