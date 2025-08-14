Return-Path: <linux-kernel+bounces-768381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756FB26089
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DA1C8604D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A062EB5C7;
	Thu, 14 Aug 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIJrJcgz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0422EAB90;
	Thu, 14 Aug 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162577; cv=none; b=bCy3UNyn/6IfsRx7TZMK+3qdzInfrVctj8lZIneEYjTmz0MJQJI/lKkP0rUNL0YsuARG3mdkwytqC1dct/a7KzRa2tqF3iB/Ll43xmoW9MJM5QIqVYIYYUInO4i6bqBFdHP5iLbglaoZzb0e/f/agPNi7Bgp0Ka7MV3baDiewTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162577; c=relaxed/simple;
	bh=dreDucqT4dEwFzw6JVDel4la7nqdTW1U39TroTgdP+Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MsRFOHDD2u4hCLW9nXq9lZWd2V5MF4rW71mCJwMh492UZMZ8YDtO/vv+oLRxUk57973jqHUuunlmah01Ak4dStl9bvssh0g4J51hgyoORXZMthRrGQWw00IOMiUCjGoFfbYTtTzUNZBSXixYOiRtggoWN4nJHBYUnXqQ9T13AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIJrJcgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EE7C4CEED;
	Thu, 14 Aug 2025 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162577;
	bh=dreDucqT4dEwFzw6JVDel4la7nqdTW1U39TroTgdP+Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UIJrJcgzc0u9OjPbU9hjdZLcpqTlKBuDVEAY8XjE2GGarE98yvA11lWUisbtFSIEU
	 o0vNpmaCIPU8V8r8Oi69gX1xvw/w6afzpIa3dG5JbHhpCZwN6g3nT8HTQfm9sqo87R
	 o9FcrEfgy4EarFY40rJ2XZPVcQTEQVxDo4ZJ8Nu7V4h//njR1v+pPpmTrgfMSoCjtO
	 /tFpconJvEmr0VUlSnwcinn/mM0ody+Lad3XtIGDvaMaWwVKipbOZvHnPrgf+2Url0
	 ud7RtUQcszCUldasw6JVFMDsT9QzClHJNTAzM3eJ0p2eoU8rL/0W/nrAR+NQUQ2Tkd
	 SRi6rRFIsj7XQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 11:09:32 +0200
Message-Id: <DC217EL7VQVH.S8MMZF1LP13N@kernel.org>
Cc: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] rust: pin-init: add `zeroed()` &
 `Zeroable::zeroed()` functions
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>, "Christian
 Schrefl" <chrisi.schrefl@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250523145125.523275-1-lossin@kernel.org>
 <YQB28aSuStBXa5rR42ragT81sJsdvHv1g7oHQlBw4amdaPtRIczi3CYqYY6E1tumr63Ell5XB371DiuTZ6sU_w==@protonmail.internalid> <20250523145125.523275-4-lossin@kernel.org> <87pld65fcr.fsf@kernel.org>
In-Reply-To: <87pld65fcr.fsf@kernel.org>

On Fri Aug 8, 2025 at 11:31 AM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> `zeroed()` returns a zeroed out value of a sized type implementing
>> `Zeroable`.
>>
>> The function is added as a free standing function, in addition to an
>> associated function on `Zeroable`, because then it can be marked `const`
>> (functions in traits can't be const at the moment).
>
> Do you want to add a note on this in the code, so we can const the trait
> function and let go of the other one if it becomes possible in the
> future?

I'll create an issue instead (the commit is already merged).

---
Cheers,
Benno

