Return-Path: <linux-kernel+bounces-804239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD3B46E05
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A517CD10
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BE2F0C6E;
	Sat,  6 Sep 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icNF3Rmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CE2EDD7D;
	Sat,  6 Sep 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164987; cv=none; b=sk5nKm3q6NdnNHqpIkWXHM97gT6nveNONPTpLnvLwZMJArWsUD5FKCXWUaYcxFDDGL8klkHuVMlOLianW3XvIlV2zSnOlhd4XHmy63QCDzg/dP9wQy86QQCJ3ebMMF8UzrZZ898weteSfzE6RBLy9W2ajKRZG1K4F9OiqYBRhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164987; c=relaxed/simple;
	bh=sYB5IWtfYTmTQeQ4X93FIP5aR5W4PpyksSFlqOXcQxU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GYeJrEYj702Ck8wN9rmA3ZacT3hBdwzLwS7qRAlxSbF+Y80bxpSXJfLHGIA0x0g2Y3L+xWKUhopYK1Nt7thPR/Ej7uC4Ki3/sJEFWR7sllp/wtBRX37ZG/c0J3BFLX/joOwXWMRle8T6A5HaMwHxFKuIoFZaNeR9QWncYyR8zUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icNF3Rmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F87C4CEE7;
	Sat,  6 Sep 2025 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164986;
	bh=sYB5IWtfYTmTQeQ4X93FIP5aR5W4PpyksSFlqOXcQxU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=icNF3Rmw9uebeAPQGmvzwDSNbzo/ccCYh7lWmqxBTGSdNySNlJJLl6pjyCvVjMR7F
	 PcSqLvjAqTZf/86so+7WIhgYnMfvWDIZRkTEBLJqxshTCZ3QtZxDV5NO+Y5VhRK8xi
	 w5BFwMZRRqvfLWkdUzhm6a46jYhxWP5wRT6kg2jFh3Mz3yaak1dRBtebkXybA/G0RL
	 1GMnVSmtNlv+DSQsPU1Kcro783kUrVTtj3IneahIx4pSVSK80tvuv8SGSsMCQHFR6n
	 vRqc62cyTOjEMKDeNQbhkjKeao4TD+nkpgiiB1vWlujZ1bN7m4uffbQsDFCeOBPb+1
	 KENCKRzxJ0VxQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 15:22:59 +0200
Message-Id: <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
In-Reply-To: <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>

On Sat Sep 6, 2025 at 2:41 PM CEST, Daniel Almeida wrote:
>>>=20
>>> I thought that an iterative approach would work here, i.e.: merge this,=
 then
>>> URBs, then more stuff, etc.
>>=20
>> Ah, that makes sense, I didn't realize you want that here.  What USB
>> device do you want to write a rust driver for?  Are you going to need
>> bindings to the usb major number, or is it going to talk to some other
>> subsystem instead?
>>=20
>> Right now, these bindings don't really do anything USB specific at all
>> except allow a driver to bind to a device.
>>=20
>> thanks,
>>=20
>> greg k-h
>
> To be honest, I'm trying to pave the way for others.
>
> I often hear people saying that they would look into Rust drivers if only=
 they
> did not have to write all the surrounding infrastructure themselves. On t=
he
> other hand, there is no infrastructure because there are no drivers.

I think saying that there is no infrastructure for writing Rust drivers is =
not
accurate:

We already have lots of infrastructure in place, such as device / driver co=
re
infrastructure, PCI, platform (with OF and ACPI), faux and auxilirary bus
infrastructure, I/O, workqueues, timekeeping, cpufreq, firmware, DMA and a =
lot
more.

Not to forget the absolute core primitives, such as kernel allocators, xarr=
ay,
locking infrastructure or very recently maple tree and LKMM atomics.

Besides that we also have a lot of infrastructure that we do not have in C
because it's simply not possible or applicable.

However, it is in fact true that there is no USB infrastructure yet.

> It's a chicken and egg problem that I am trying to solve.

This is exactly why we develop Nova in-tree, such that we have a justificat=
ion
for adding all this infrastructure.

Lot's of the stuff I listed above originates from that and I think the Nova
project has proven that we can break this chicken and egg problem. I think
one proof for that is that Tyr follows the approach.

However, I agree that it still remains that someone (i.e. some driver) has =
to
take the burden of doing the "heavy lifting" for a particular subsystem.

