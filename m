Return-Path: <linux-kernel+bounces-777510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37DBB2DA56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5265E8601
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9F2E2DF2;
	Wed, 20 Aug 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kld6MA05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0E2DCF58;
	Wed, 20 Aug 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686926; cv=none; b=KjZ27eJM74c+sv+v5mV66OzADBhUxl2zlhSXvczrdaPjuOdnFQQ3+pM50obnvtifKq9siuEuYK9Jw3agQSf7H5mSMJhITcp7QfY9+UWbf+lKc7F5KZda7bBEx6KmZtpakFwDmFHqKtI+6eDGYTHnh3xiW5hF3O6l+778jtuWMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686926; c=relaxed/simple;
	bh=Rcrn2zbSfVwJXJIWJFcnkEOKk+hUetdUEnYG0DlQ0Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkAw/A3nZDQCTyzRuJDe2BdNrlZh8I1fCCCIR1iXT7gHfmjgM69xyQdBhHGm8hdeZxHyZRf8NYjJcU1sP46HDnxYXg7yXgvVc9NXIATA5bA5HK0g/TR5rAzf/hCt0yPwSo7sRKOkWAG91wFoFSHwzbPZ1gWddjoYkk+kytJZiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kld6MA05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D420C4CEEB;
	Wed, 20 Aug 2025 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755686926;
	bh=Rcrn2zbSfVwJXJIWJFcnkEOKk+hUetdUEnYG0DlQ0Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kld6MA05Y1qHuF3Pw7CovhV2zk4YXH8pBW3TrLBjspegU21s1Vf9F3MS43+RAOWji
	 qHlH3DDErO4ikztse2VFZe9gUChxr4R3KGN+fMi1TmZXskdIw4ZmgyAaVPZWqeXwbF
	 3wCrz8tA67g2+U7cFVsG5G/BV+2LeNa4V8nvRyq/dW99bkW/fUCb4nSoN9TudNnjqo
	 GVbHTwBHoCAHA3G6DAJCVDzWXZLWm51GkbCo8cYEg0/UZSQlakScg+U9baXtxh9COo
	 Lpq+4DBTFTunoZ+G6GgZYP0Hhw2zgRRJe2fqYduceyAF8uh8BI8kHe4qiOJdJbPro4
	 jgFlton2OdGkQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor
 Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <DC6KO9DJG36S.TQRLQQGJKVON@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
 <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
 <aKQT92ViZSL841rT@mango> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org>
 <7ORM055ehFH_Z124bk1l8YRI5whcremycMy8JsSgzMf4rRdagKSDHSloL8sz3O8FmX3k9cni7TG2_EFLyInWbw==@protonmail.internalid>
 <aKQ5rHqxOBEI2n4w@mango>
 <87h5y3d6u8.fsf@t14s.mail-host-address-is-not-set>
 <oDbuKLDFs6PF4gFrtDc3Oy8hvK-WjTKIDlvLZmEoWGsnhvTlDvBN_D8ml__6pHMkBA4acut9D2evJrRNUqT7HQ==@protonmail.internalid>
 <DC6KO9DJG36S.TQRLQQGJKVON@kernel.org>
Date: Wed, 20 Aug 2025 12:48:38 +0200
Message-ID: <878qjeclq1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Aug 19, 2025 at 11:00 AM CEST, Andreas Hindborg wrote:
>> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>>> You mean of `Ownable`, when `OwnableMut` is removed? Yes. A good question
>>> in that context is, what it actually means to have an `&mut Opaque<T>`
>>> where `T` is `Unpin`. If that implies being allowed to obtain an `&mut T`,
>>> it would we easy, I guess.
>>
>> You should not be able to get a `&mut T` from a `&mut Opaque<T>`.
>> `Opaque` opts out of invariants that normally hold for rust references.
>
> Yes, that function mustn't exist.
>
>>> But what I am wondering is, if we actually want to start using `Pin`
>>> at all. Isn't `Opaque` currently used about everywhere pinning is needed?
>>
>> `Opaque` is `!Unpin`, but pinning guarantees does not come into effect
>> until we produce a `Pin<Opaque<T>>`.
>
> `Pin<Opaque<T>>` isn't really a thing. You still need a pointer
> indirection, so `Pin<P>` where `P: DerefMut<Target = Opaque<T>>` so for
> example `Pin<Box<Opaque<T>>>`.

Right, that is what I meant, but not what I typed. Thanks for pointing
that out :)


Best regards,
Andreas Hindborg




