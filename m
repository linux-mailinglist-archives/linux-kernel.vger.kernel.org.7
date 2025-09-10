Return-Path: <linux-kernel+bounces-810501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD60CB51B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE123AB266
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E653322A0C;
	Wed, 10 Sep 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYt+EmN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109731D386;
	Wed, 10 Sep 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517811; cv=none; b=GcHxzjjE+N4PYUg28RlCgxnywxsp3Jo3FAs3bIj+6DCS+9gdAScSUDZEZZS3NvaqUfbBRho5wIMi8dIpml7OxGskGz864kH7y8B/kDLnkjZQfjMnek12wofiLUbu3/vYGGuBS+CzMZSkkJWzVaRC1h/yt0xTFzkKYaJ/fQXJFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517811; c=relaxed/simple;
	bh=wUL5u5usQUeXwabjs2k/TuZOJ9eyTeEdrA8209/TZe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwA7tATLwRqVbBINCeSI/tZ67YAJz9CjHS5dM7VIJxTkgqUIskctRtLOSB3cErVF/czkYRJUOw0O9tifpzB1r9aGFLREXokgqNKITy3ymyVixHHxP7/Ru+cfetBqSVon5vWz/VeU2DxcE5Zt3gtbKbgcx4+RoonVurhELw47u8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYt+EmN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37A2C4CEF0;
	Wed, 10 Sep 2025 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757517811;
	bh=wUL5u5usQUeXwabjs2k/TuZOJ9eyTeEdrA8209/TZe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYt+EmN3Sk84qBJwscnHfelSri86lTAKJGie/OEAobSXz2iiYK+i5Pld8Ujm2Y9Y0
	 wK94iFcoj8SJR7d1MchhACDMe/noRT1iPmrqE/1F5Yo4UJtBGNYGAxvPVQoNLdfaBH
	 HsJLtTPdjVFY6XpfUKR09wV7lGqJ+aFlJB2XMVL+WltLMajv3m1sV32pbgJ/LUKHb3
	 a4Hf0PR+OfWpeCl4vWi9rSxrBY46aIR46NUROYhgSvII+d8uf9MYG+uVQc9+GnvVql
	 apCc5I9aLabKhGJV3TevIOYMAEWjOkIjIA5h9XOse4ofSHFS8luWW5B0Cqo++kyWIX
	 9Xt+uS7mFkHcw==
Message-ID: <ef5c0c7b-3fb3-4099-966c-62cf08d9b2b4@kernel.org>
Date: Wed, 10 Sep 2025 17:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Matthew Maurer
 <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
 <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
 <2025091014-explicit-grafted-e849@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025091014-explicit-grafted-e849@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 5:22 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 09, 2025 at 10:29:13AM +0200, Danilo Krummrich wrote:
>> On Tue Sep 9, 2025 at 9:29 AM CEST, Dirk Behme wrote:
>>> On 04/09/2025 23:13, Matthew Maurer wrote:
>>>> +#[cfg(not(CONFIG_DEBUG_FS))]
>>>> +impl<'b, T: 'b> Scope<T> {
>>>> +    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
>>>> +    where
>>>> +        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>>>
>>> Inspired by Greg's & Danilo's discussion I tried building with
>>> CONFIG_DEBUG_FS disabled. And get
>>>
>>> error[E0412]: cannot find type `Entry` in this scope
>>>    --> rust/kernel/debugfs.rs:351:37
>>>     |
>>> 351 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>>>     |                                     ^^^^^ not found in this scope
>>>
>>> And giving it some Entry (for my 1.81.0)
>>>
>>> error: hidden lifetime parameters in types are deprecated
>>>    --> rust/kernel/debugfs.rs:352:37
>>>     |
>>> 352 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>>>     |                                     ^^^^^ expected lifetime parameter
>>
>> Yeah, I caught this as well and fixed it up on my end with the following diff:
>>
>> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
>> index ecfcce845d3f..1f25777743db 100644
>> --- a/rust/kernel/debugfs.rs
>> +++ b/rust/kernel/debugfs.rs
>> @@ -348,7 +348,7 @@ pub struct File<T> {
>>  impl<'b, T: 'b> Scope<T> {
>>      fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
>>      where
>> -        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
>> +        F: for<'a> FnOnce(&'a T) + 'b,
>>      {
>>          try_pin_init! {
>>              Self {
>>
> 
> Can you send this as a fix-up patch?

If you don't mind I would fix this (and one other nit) up on apply. :)

