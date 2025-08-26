Return-Path: <linux-kernel+bounces-787078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5DB3710B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B74B8E43BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B62E7645;
	Tue, 26 Aug 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2s8CHas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8B2E5427;
	Tue, 26 Aug 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228549; cv=none; b=U5wiw/XnD+Yb4d9tSAt4Aban2yuAdyp8UWexqxsUnTwsDfTxm5A43f/cC24P07EYnUDlTiY0+jDdrnHJPFQD+vxCXkB75dYJ2nKTLPtd2oNb1GqiYjqXVlsH8REUYlEb4axr8+9BRiHB2SPmhI2by7cdhAHhyTQ5HuD6kTk832w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228549; c=relaxed/simple;
	bh=+J2sm8Wfnzuu5W2LwGGyp/gjdjZIffji7KNXYV+Y3+4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KOY3/yX3Uc1cErgDRmbiQkpecVKKMEL+TfbH4NwFSWleuHZuC4+88ti8urtiYLPQwkWs3/lUCGksKNLKaAGhQOCTImveFbFX0k2rJVMMY6csLLpts+zgwlY4nOy8S9akRPSz6vkaJtCZfdQTzNygvawOeReR/JRl66XPqxP8tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2s8CHas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB86AC4CEF1;
	Tue, 26 Aug 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756228548;
	bh=+J2sm8Wfnzuu5W2LwGGyp/gjdjZIffji7KNXYV+Y3+4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=R2s8CHas6PRQM6p0vftWzEnynwFtgViezQjZ5P9IBT8L+i1l16qqCax31RmDYOBVc
	 IpYyB13k5JbiEHrQJ46rVocIMT9wIV+ooNIW4GxqSEZcb/SWmNbYMTNNVWDBe7a5Of
	 t5PbAWqNiHJEvM+UHcjfF1Nge2/07UzRv3wov9eucYs/QZsKL6t7jb0SzAcolnQWJv
	 F8wS8JYhaDjEr0KJpKcXrf1itXJm2XBZFLEFiV57fDjNgqP/1Vdvt3hw9mgXL70/I/
	 ErIaU72ex/i0GULUXNfHW2kncS+olY4d8rrMxNTUHi22Ok4FTgyO5/asjvJnv3tG39
	 8sf4tRIfqmWmQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 19:15:42 +0200
Message-Id: <DCCJ26K4TBEG.5HLYXY68Y6QJ@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>, <acourbot@nvidia.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <33725E09-3994-4306-AD4F-4A0253261DE1@collabora.com>
In-Reply-To: <33725E09-3994-4306-AD4F-4A0253261DE1@collabora.com>

On Tue Aug 26, 2025 at 6:59 PM CEST, Daniel Almeida wrote:
>
>
>> On 26 Aug 2025, at 11:12, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Thu Aug 21, 2025 at 5:57 AM CEST, FUJITA Tomonori wrote:
>>> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
>>> +    mut op: Op,
>>> +    mut cond: Cond,
>>> +    delay_delta: Delta,
>>> +    timeout_delta: Delta,
>>> +) -> Result<T>
>>> +where
>>> +    Op: FnMut() -> Result<T>,
>>> +    Cond: FnMut(&T) -> bool,
>>> +{
>>> +    let mut left_ns =3D timeout_delta.as_nanos();
>>> +    let delay_ns =3D delay_delta.as_nanos();
>>> +
>>> +    loop {
>>> +        let val =3D op()?;
>>> +        if cond(&val) {
>>> +            // Unlike the C version, we immediately return.
>>> +            // We know the condition is met so we don't need to check =
again.
>>> +            return Ok(val);
>>> +        }
>>> +
>>> +        if left_ns < 0 {
>>> +            // Unlike the C version, we immediately return.
>>> +            // We have just called `op()` so we don't need to call it =
again.
>>> +            return Err(ETIMEDOUT);
>>> +        }
>>> +
>>> +        if !delay_delta.is_zero() {
>>> +            udelay(delay_delta);
>>> +            left_ns -=3D delay_ns;
>>> +        }
>>> +
>>> +        cpu_relax();
>>> +        left_ns -=3D 1;
>>=20
>> How do we know that each iteration costs 1ns? To make it even more obvio=
us, we
>> don't control the implementation of cond(). Shouldn't we use ktime for t=
his?
>
> I don=E2=80=99t think ktime can be used from an atomic context?

There's no problem calling things like ktime_get() from atomic context.

