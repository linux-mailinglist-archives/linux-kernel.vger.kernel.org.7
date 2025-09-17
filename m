Return-Path: <linux-kernel+bounces-820191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDCB7E69C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372634627D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145A302CD6;
	Wed, 17 Sep 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="15MDKaUm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3B1F5820;
	Wed, 17 Sep 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095943; cv=none; b=dBl5MD9jELgYYPk8Wf1wLgN3RtBxrZbfhoRiblWwyP6ggsNjGkdNQkxJWUFjbFs/whZ4nw2U8Ej/9tK7K4A06OVxuk/CsQdyogfXsnxZDKaJke+18yqYdDNT9oobVLeBK0yYdHrzs3ck1rxITLKsR9tCtecvh9C3aDyZgaiH0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095943; c=relaxed/simple;
	bh=xPlj9hKZKNnsY6fR6/EPwxV8vPWiC/geMmQfF3953+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwENoh9yVuIfkxf/nQZnAl6fwQbfgFFksx2cruS05vGw7qnoDjfJm2wmdU7GHGz6rVYZrsWnBFbjVlrXYv+MGRwl++sLVtkhLfnqdt5pEJ04L8WH+bZHyqt6Y4RkJ9HpNS9Ilmmu6lpdrkCWoyX0vlQ6OecVhOCBRXPs0iR4ZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=15MDKaUm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=svTYNtVQsiCri3uBTHAaw+1TBg/7Z71XpCGcz6mZpPg=; t=1758095941;
	x=1758527941; b=15MDKaUmpVlzmOiDvprkXW5wTjaHUiPQ4Hk3DknJqNGpJwNbKVUJrrTG+Rcnc
	F/J93+9whZ1xRdwUgosQSnu/HzvZvFyjMeaUcF26EzDUCrJCFaj6r/CahMQyJtZ2f5WiAPwr0j7v9
	Aei3WPPH+wwjidsi+qnhby1H7AJGfqD//ZQuASsvxELVPR+q01A6lI6tbjXyUenC3YX5fTpiRFOY1
	9dVJEbif18jTtcs4i0MEcuXop3577GExij4xAy/4XOFdBhWmYf5uoDwc02EjxeFVokGaC+yl6fgi5
	QFUMrRLSxbAQ7Qa3oBsDlzssblU5lMgRfr7825TB5rYXY2Y9WQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uyn43-005P7w-2O;
	Wed, 17 Sep 2025 09:58:55 +0200
Message-ID: <228245d0-4620-48c7-b4bd-532bb873bdf2@leemhuis.info>
Date: Wed, 17 Sep 2025 09:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Heusel <christian@heusel.eu>, Mark Brown <broonie@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
 Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>,
 Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
 <27366f94-67d4-4b73-b420-cacdbe9d603f@heusel.eu>
 <aMpma-2UokTo0u9j@stanley.mountain>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <aMpma-2UokTo0u9j@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1758095941;957203a3;
X-HE-SMSGID: 1uyn43-005P7w-2O

On 17.09.25 09:42, Dan Carpenter wrote:
> On Tue, Sep 16, 2025 at 06:46:06PM +0200, Christian Heusel wrote:
>> On 25/09/16 09:56PM, Naresh Kamboju wrote:
>>> On Tue, 16 Sept 2025 at 11:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>
>>>> The following build warnings / errors noticed on the arm arm64 and x86_64
>>>> with rust config build on the Linux next-20250915 tag.
>>>>
>>>> First seen on next-20250915
>>>> Good: next-20250912
>>>> Bad: next-20250915
> [...]
>>>> Build regression: next-20250915: error[E0425]: cannot find function
>>>> `atomic_read_acquire` in crate `bindings`
>>>
>>> Anders bisected this build regressions and found,
>>>
>>> # first bad commit:
>>>  [eb57133305f61b612252382d0c1478bba7f57b67]
>>>  rust: sync: Add basic atomic operation mapping framework
>>
>> Is this still an issue on next-20250916?

FWIW, I ran into this on next-20250915 and it afaics was fixed for
next-20250916.

>> As far as I can tell this has
>> been fixed, but now there is another rust build issue, see
>> https://lore.kernel.org/regressions/0fee48bb-7411-4414-b4e7-395a8c3d0f6c@heusel.eu/
>> for more information.
> 
> next-20250916 still fails but with a different Rust issue.

Ran into that that merge mistake, too, but that can be fixed by the
patch Christian linked to above  -- and I expect Mark (now CCed) has
seen it and will resolve this with today's -next.

> [...]

Ciao, Thorsten

