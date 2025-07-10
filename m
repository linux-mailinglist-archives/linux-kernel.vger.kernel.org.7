Return-Path: <linux-kernel+bounces-725521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3164B00031
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553B4165E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9852E0B64;
	Thu, 10 Jul 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR8jxhjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A262877C1;
	Thu, 10 Jul 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145791; cv=none; b=kbDw3HZMJHXnieXYrgMDbNgCxuUFTeaFKb/qhwIa9RSxPFfzCcfjQ4bgy5QkGLwKYGEUHNfnkrB1ayB92f/fwgXoDQd/PgDVRbe4IAFdrEwKmxjiAflOfVvUpSZlhKOwYTfBAV0UyB8bD4BTotKgR1Nuwl4+eyRkpJWaX6ctex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145791; c=relaxed/simple;
	bh=cyo8TvLqzhnMM+YzZI++zzXnIEvpHErhbOfzHNNWuRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=i0mQSqPT0gSjJoAFq/bEIRtdaELI9F10YQDcQe5t38/sExOL3Er6UF1nMnAjJKdH/HNFCgi6VQk8g+mb8ptrMqxaNJAaOh9Bj4u83AK56lMHnDul36+v1RAvaRtNp68iz8iFva8wmi4LU71+avLD7VdVTJoH73IMJmFx3U5+ap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR8jxhjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7E7C4CEE3;
	Thu, 10 Jul 2025 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145790;
	bh=cyo8TvLqzhnMM+YzZI++zzXnIEvpHErhbOfzHNNWuRc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=GR8jxhjS+77T7Tw/3+VKZHxuDGUV9TM886m7kNNd7K+2Ot77ZwLIIVGc4QZCI4ywl
	 qNGJqqqNA6PQl7NEz51DdY/czTLQvp89C2Wxi++dHqDslKhlhSzXhLBLXG9o4b0MpQ
	 5vt2pbzTvtAeAuJspiUfzO9VlSoxpRF17Fh90wKdFvA5QVPUCk3uoqisBqqmo2HIzu
	 oCOxwjupcCSlTBtRKh9BBkiAq9Z0i/Nqqd2CLG8XCzeZzIrlrplyCKz1/rWEUap4Z1
	 OZqLTF5y6LXajm94MYNdCve/NCPA7qluSgRUQ6GuPiNfaNt2DEXYmUYkpI6mcbzplJ
	 RbQGk4M9z3G7Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 13:09:46 +0200
Message-Id: <DB8BUDZQJOM5.2WS6MCW6I0XES@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v9 0/5] rust: DebugFS Bindings
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <DB7US8G7ISG0.20430M3P7I0K0@kernel.org>
 <CAGSQo01hORWAtrGaYp-_xxrAiN47JkJg=jiqnqdpw87QKzt9jg@mail.gmail.com>
 <DB7V19QE6KFB.3MR0BAOWXT7M7@kernel.org>
 <CAGSQo01drZoy1-j-+Y-BHHOX5AzCG4A5KiUOu5TJ40JOdfcB0g@mail.gmail.com>
 <aG7pP1BTLQKInFrl@cassiopeiae> <2025071014-radiantly-dreamland-4017@gregkh>
 <DB89V15HIG8C.2HL9JVKFNEDTK@kernel.org>
In-Reply-To: <DB89V15HIG8C.2HL9JVKFNEDTK@kernel.org>

On Thu Jul 10, 2025 at 11:36 AM CEST, Danilo Krummrich wrote:
> On Thu Jul 10, 2025 at 7:27 AM CEST, Greg Kroah-Hartman wrote:
>> Ugh.
>>
>> Yes we need write.  And read, and custom file-ops, and the like as
>> that's what debugfs is doing today for C code!  We need this to be as
>> simple as, or almost as simple as, what we have today in C or no one is
>> going to use this stuff and go off and attempt to write their own mess.
>
> I agree, we really want the helpers you're referring to below. I think we
> discussed this in previous iterations already.
>
>> While I would love to have something as simple as:
>> 	void debugfs_create_u8(const char *name, umode_t mode, struct dentry *p=
arent, u8 *value);
>> like we do today.  I understand that this makes all sorts of
>> "assumptions" that Rust really doesn't like (i.e. lifetime of *value and
>> the like), BUT we MUST have something like this for Rust users, as
>> that's going to ensure that people actually use this api.
>
> I think it can be as simple as
>
> 	void debugfs_create_u8(const char *name, umode_t mode, struct dentry *pa=
rent, u8 *value);
>
> in Rust as well. Declaring this in a structure looks like this.
>
> 	struct Data {
> 	   counter: File<u8>,
> 	}
>
> Given that we have some Dir instance, this can be as simple as:
>
> 	dir.create_file_u8(...);
>
> Which uses default callbacks for read(), write(), etc.
>
>> Look at an in-kernel function today, like ath9k_init_debug() that
>> creates a metric-ton of debugfs files and binds them to different
>> variables that are owned by a structure and more complex data structures
>> and memory dumps and other random file interactions.  We need, in Rust,
>> a way to do everything that that function can do today, in a SIMPLE
>> manner that reads just as easily as ath9k_init_debug() does.
>
> That's possible with the current design and code, it misses the helpers, =
such as
> create_file_u8() above, to reduce the boilerplate though. With that, it s=
hould
> look pretty similar.

Can't you just implement the traits directly on `u8` and then just call
`create_file`?

---
Cheers,
Benno

