Return-Path: <linux-kernel+bounces-808634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E010CB5029E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C3A1BC21E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07D352FDD;
	Tue,  9 Sep 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pATF4K9t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0710E3;
	Tue,  9 Sep 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435395; cv=none; b=bgnUAzzJWklaM/27WDwTUrWFKpkPTVUO0CHBdP5WUm2JC3X43q1UIJby91DBR/zkRzaCsDOdrwgeQk1EGRDBRunoTTeriYiYDvgw+kRbJjx0c+XhZh06OfhX7QxlnVwUPzBd3SEyuZZMpYIyonDfgDqYCJFqxSbqUxeJvylwhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435395; c=relaxed/simple;
	bh=RFUXkjR/+l3yxMFaWzJjdIShtLguQR12lvOYMzRJoHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/tlkprmZYTw4F0801XbSSsQP4PU7ct4beSWVSlNhFb1Vnyzw3vIAqdTwA/BZMB5RRWPYV6gr52drjt26xROPASEdZx6SK/357jAqREMEuvzr56b01liCJfX2HS5pru1suZgAYY4te1YIHYbi9R3GGLCvqkXs9ZyU7KURy1KBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pATF4K9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2270C4CEF4;
	Tue,  9 Sep 2025 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435394;
	bh=RFUXkjR/+l3yxMFaWzJjdIShtLguQR12lvOYMzRJoHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pATF4K9tWq8EsDvRYLWCu8ax4jh8eQTdcVuAz61u+t6otm4vIA8qF/CYheZ6sgee7
	 yznz6KMlm1+li7Z3S9klPS2AMzJR9NgEOuz9R2YYDP5NwZGILTiVUHCJUSf+RXCrZF
	 /RmbWiXwyLsiumjjETKJO+kcpdM2MxePDncchzVMKXDBnVnvOuhZvsONkoVGCtYRhm
	 HBnG3Hu8RyJgLrtzHarPIGnK+J+9e4Z1Dk+mPoeqmRJbt7LnWVW2fDMGAh/cGw0lMT
	 ymtvlZhClmfLzGLa/z1CY21+VWT/sFLhx+FPHdKkYhWyWwZeThDXm16GxyP9ZPfRI3
	 hKchfMeIRYItA==
Message-ID: <871905b9-995b-4b16-97a1-7be580716ce4@kernel.org>
Date: Tue, 9 Sep 2025 18:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
To: Mark Brown <broonie@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <d59eae86-9b8b-4d4d-9a1c-b76ff0f42704@sirena.org.uk>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <d59eae86-9b8b-4d4d-9a1c-b76ff0f42704@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 6:17 PM, Mark Brown wrote:
> On Tue, Sep 09, 2025 at 08:38:27AM -0700, Boqun Feng wrote:
> 
>> Well, then the question is why we want to compiler regulator.rs if
>> CONFIG_REGULATOR=n? Shouldn't we do:
> 
>> #[cfg(CONFIG_REGULATOR)]
>> pub mod regulator
> 
>> in rust/kernel/lib.rs?
> 
> If we do that then every single user needs to also add ifdefs for the
> regulator API which is not exactly wonderful usability.

OOC, I assume users do not just depend on CONFIG_REGULATOR, as it depends on the
actual platform / board whether they require control over a regulator?

