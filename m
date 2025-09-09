Return-Path: <linux-kernel+bounces-807503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072CB4A543
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBCE166A55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDA246335;
	Tue,  9 Sep 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URtjggut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1223C8C5;
	Tue,  9 Sep 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406559; cv=none; b=hfniY724hS3rgVGxVOXUw2XdDszo9VgWRICSg3mAFJGySFFcUjyZD9E8C1RQLFzqQJ2f0wnzZKTU0dM6DyqCK3VpngmbLF9zaRVElnTyq537Krqsg6Cw2uHIcRIPSzUDgqSckn1dGdaXzR3FF5ldjBhGnJgoiPcMV92NH8+B2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406559; c=relaxed/simple;
	bh=Yh0QysXYdu44lUy6HVpVPDaMU/piHe2LJbyO836FVh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WMz5fqHwQf1EiXHcBOANjYwlN4oDXYmd8QMrkWUc3f41KN4ZWpzPEw/U3Yi1TPGbHlRhvQTDLKlJ1Amic/8s+pnQoWWXGvpHQhQeQxpXEGD4iTKoXaWJFNId3fARfhcIXAoMpAlenJHZX2H/I0+sQ8j56bxsIAShXRP4XIy7pKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URtjggut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76883C4CEF4;
	Tue,  9 Sep 2025 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757406558;
	bh=Yh0QysXYdu44lUy6HVpVPDaMU/piHe2LJbyO836FVh8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=URtjggutOq+snpRI8DWcj/wT6jEcKVeqIgfJp74GVk38LPmJhACes+TO8VO1/6PYI
	 PGBiYKZSPqZ69ifSkR4HjOrZP5i46DHuvzHSCDV8KRFbxZThlw5Q3riJunIBag+D1P
	 dVC+TVo3fhXrdqroYFHp8Hgs5zbf43wPvHmG7k7xOY0ASiur6/pK4gyriTTDep0NKH
	 2FQcHtPTRo5uf1ucHPNl8OTlqFJqKAQ2RUn+317kSAA7AjrUxpETi9i16+0e9P5ZDc
	 FsJYJaGj2tLjHRk3qGsSqAqqdEdP0bNx119dgNzvQqyOegKE1rxeodU7iPV0mjck0I
	 lW+IaymR/TtLg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 10:29:13 +0200
Message-Id: <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
In-Reply-To: <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>

On Tue Sep 9, 2025 at 9:29 AM CEST, Dirk Behme wrote:
> On 04/09/2025 23:13, Matthew Maurer wrote:
>> +#[cfg(not(CONFIG_DEBUG_FS))]
>> +impl<'b, T: 'b> Scope<T> {
>> +    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl Pi=
nInit<Self, E> + 'b
>> +    where
>> +        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>
> Inspired by Greg's & Danilo's discussion I tried building with
> CONFIG_DEBUG_FS disabled. And get
>
> error[E0412]: cannot find type `Entry` in this scope
>    --> rust/kernel/debugfs.rs:351:37
>     |
> 351 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>     |                                     ^^^^^ not found in this scope
>
> And giving it some Entry (for my 1.81.0)
>
> error: hidden lifetime parameters in types are deprecated
>    --> rust/kernel/debugfs.rs:352:37
>     |
> 352 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>     |                                     ^^^^^ expected lifetime paramet=
er

Yeah, I caught this as well and fixed it up on my end with the following di=
ff:

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index ecfcce845d3f..1f25777743db 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -348,7 +348,7 @@ pub struct File<T> {
 impl<'b, T: 'b> Scope<T> {
     fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinIn=
it<Self, E> + 'b
     where
-        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
+        F: for<'a> FnOnce(&'a T) + 'b,
     {
         try_pin_init! {
             Self {

