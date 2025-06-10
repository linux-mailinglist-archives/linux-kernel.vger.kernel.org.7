Return-Path: <linux-kernel+bounces-679273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE6AD340B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC90B1897768
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF9528DB6E;
	Tue, 10 Jun 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m515TzUh"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3618024
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552478; cv=none; b=le2oDIP6V0rYuqIiVr/DNyarn8f+srz7m03fAVkUxtfS2JfWmFK0pQCW8dXvbHZM+1ftsON+5DkRRYAyJrpy5um3IJBw/bfxgO9P7P7KZli9NGL5LmYDTqt1coFu4qt1yIPq5d1DEtWWh5hWy492dMQx88KotO2qnWNh1V+LQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552478; c=relaxed/simple;
	bh=yqBGNHKHylLUbukGQanKBdMRqJDrnziE5o9wNGaF6So=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aP68JcV+9IL4Y+sgHSslfGIXrEkmLFfD2jZ77hAOcrB6C1n9A27MYr6eq9R3oV9yLipPqp/UpO2ad1aTcAIbV7QPCwUHlSGyzSiab8NZa+T4Vv5Gxs6kpyQQ3f0yqpYDPzfdkEG+1NNVnEtiNNlbTWDMAolJMNjdweTtJVQxs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m515TzUh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749552463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqBGNHKHylLUbukGQanKBdMRqJDrnziE5o9wNGaF6So=;
	b=m515TzUhRMnpShWuFOdaQf3kDQRhcxCVgb7v7HNfCsEg7NhHxgEv9lneCdOKPCIS/rx1bn
	A/es2VtwMSzQZ2a72Hdf0037DIbD/d8YHxYxECA3grwetAmM2PuBl6MaaDAeiJbMV1WMP3
	JwaDsoECJuuYyebuviuqIdWuiT3FTCc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] smp: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAEdQ38E4Hks+m=srZsuuu7g8N2z_hJT7oxyF_Nz3MYsm8wx9YQ@mail.gmail.com>
Date: Tue, 10 Jun 2025 12:47:18 +0200
Cc: Kees Cook <kees@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-hardening@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBD9B075-41C1-4447-A432-6A0EED48545C@linux.dev>
References: <20250417192054.69663-2-thorsten.blum@linux.dev>
 <202504181322.5D3B93E93@keescook>
 <ABD8884A-36DF-457C-83D4-49F4F63C339F@linux.dev>
 <CAEdQ38E4Hks+m=srZsuuu7g8N2z_hJT7oxyF_Nz3MYsm8wx9YQ@mail.gmail.com>
To: Matt Turner <mattst88@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Matt,

On 19. Apr 2025, at 01:01, Matt Turner wrote:
> On Fri, Apr 18, 2025 at 5:11=E2=80=AFPM Thorsten Blum wrote:
>>=20
>> On 18. Apr 2025, at 22:23, Kees Cook wrote:
>>> On Thu, Apr 17, 2025 at 09:20:52PM +0200, Thorsten Blum wrote:
>>>> strcpy() is deprecated; use strscpy() instead.
>>>=20
>>> Are there more strcpy() uses in arch/alpha? Maybe do all of them and
>>> give the Subject prefix as "alpha:". If not, the "smp:" prefix is =
likely
>>> to non-specific. Maybe "alpha: smp:".
>>=20
>> There are a handful left, but they're not as straightforward as this
>> one - so I'd prefer to keep them separate.
>>=20
>> Could the committer change the subject to "alpha: smp:" or should I
>> submit a v2 just for the title?
>=20
> I'll fix it up when I add it to my tree.

This one didn't make it into the last merge window, did it?

Should I resend it or can you take care of it?

Thanks,
Thorsten


