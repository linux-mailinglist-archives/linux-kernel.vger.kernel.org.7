Return-Path: <linux-kernel+bounces-743146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A291B0FB29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913749660D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C35230BFF;
	Wed, 23 Jul 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaFF0rHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FD22DF95;
	Wed, 23 Jul 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300390; cv=none; b=JpI1V3YTzo/OKx3AhnKNKlVWKk9slrS4Xnd2966CXPpJf7UjeNzd37CffKudLiJ+3tA8DIlOAzEWU49AarW/4SQ12Pl4NuU242TpAxCcAq6apiwki5KSz7a/FVSL+9ohJO11Cvm2QzwuodrFsmRSKrFjGocdFJ5uF7XraXcZfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300390; c=relaxed/simple;
	bh=bSXqjeidHv3ohMhzJNgbESs/WeET08hNfS1+1fq/Zpc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KOHlSebpNiMqMwAEzakIpPiiaC+ruT/+ySpircdI/XlICflgqERh6BJtlWE2hh3vT/Qazwcrd7YGM+5DqF7ZBGxZvaW1opsaQeku0j6PqyPQU+ERcbrxmNPRFunT8MqFeQV8XQhlGc7FoOlGdOZbkAu06BDWu9tLQ5uQ1pymmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaFF0rHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE073C4CEE7;
	Wed, 23 Jul 2025 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300390;
	bh=bSXqjeidHv3ohMhzJNgbESs/WeET08hNfS1+1fq/Zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaFF0rHKz7F3eFcN09w8G7wJOFOqsrxYtr9sfNPJGq0PpywH/AlwXUhvltvJlShcq
	 yvhFQ7gX0EbIks5kCNecUdy4xYoFH0YCXZTSQtc5lc/09lvLifpRyt9rF1E3+w4mYi
	 Zccl2n7w8HNLcyHBrEN546D7sBCA1ixCNGyX9VcRJcuJv6yl0k67H8XB9LtiLoHMx8
	 KlxuzhRoETRlXuUKTFpbE+Iz0x4M3y8ucjZLM3KKyKJUp6NCXgRLn0SVjt9+6lVwGv
	 B1aCyek1pecndAKRPFGG8klm/lWK6GzuwZcroe/SsDlX1PDbPJC6Mp9WBX2TYX0ROD
	 XEIGz/CEKGDSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 21:53:05 +0200
Message-Id: <DBJP45SOWFQI.3FY7X96EZT2HG@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
X-Mailer: aerc 0.20.1
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com> <CANiq72m=vYbZZPwF9u9PQJ7Jce0KPR7jPybk3AHV50U9fOmEvQ@mail.gmail.com> <CAJ-ks9kuCTnmhJRJyuuyGST-W_9TDQkg8iWm3YoOtP7_d_NR0w@mail.gmail.com>
In-Reply-To: <CAJ-ks9kuCTnmhJRJyuuyGST-W_9TDQkg8iWm3YoOtP7_d_NR0w@mail.gmail.com>

On Wed Jul 23, 2025 at 5:18 PM CEST, Tamir Duberstein wrote:
> On Mon, Jul 21, 2025 at 8:25=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Sun, Jul 20, 2025 at 7:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
>> >
>> > Remove these dependency edges.
>>
>> I should have replied in previous versions: this is wrong -- the 3
>> changes each individually break the build.
>>
>> I guess that you are not cleaning everything in your tests before
>> testing the build.
>
> You're absolutely right, this patch is incorrect. I was indeed not
> blowing away build artifcats.

So is the `compiler_builtins` dependency correct for all crates?

---
Cheers,
Benno

