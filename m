Return-Path: <linux-kernel+bounces-832674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6295BA011D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A028F3A8955
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE32E0922;
	Thu, 25 Sep 2025 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GM2zZdqE"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A62DCF77
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811741; cv=none; b=XPKQQZ28TTlHVmdILNWjt2oGwyKKwTOAUwn6De86/UsQyrU8icAWXFu64ZLDLaiZBg1rk5cNC13r0mLY0ifIcfjxJgBCIW5pKrXRkSmHDeWel/N+yzPymOkxm1BSZQlrnFh0Cq+Yyi2CANgLPInia+HWp1jFEiFY2cKcCPB6twc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811741; c=relaxed/simple;
	bh=hBqumAyAnwsi866YmiRcYaY7KqwFc8IQTSzt2UsyAvg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Gz+6+MOwNos9jRlMQ0sESgqPzfYp1EsU9UGGf3qMm8ClmJCOiLjp07KjnYTeH2B4WNHvkQvZ9PBOL8nvX4PxsfPQQnyYR0ircxYhOmF4QT9wUinpubZlOefuzE79nK3tY+6cOlFSHdatd090j+GCy03fOyxxkaP5wcSWpxN8knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GM2zZdqE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758811736;
	bh=hBqumAyAnwsi866YmiRcYaY7KqwFc8IQTSzt2UsyAvg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GM2zZdqE7UdjBCwmqJvKGc6lptmXr6upUnH6CwQQLhemssEcXjDtsXScdlrcZ5aZk
	 Z8gatgHT4yOgsuNDgxyVwOw8Czb84Jn56cONdy5EnS4Zf/BNa6r2JV0Ty9k6Ych4vM
	 njtFf2Rj9JAjxskry3/jtcCHRT5r21Rm1+yU9VVo=
Date: Thu, 25 Sep 2025 16:48:50 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <7f2d214d-ebc3-4c9d-b2bd-4ad94719e6f6@weissschuh.net>
In-Reply-To: <5e85074a-16c0-46da-952f-6218b687e5a2@sirena.org.uk>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk> <20250925141423.504427-1-andrealmeid@igalia.com> <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk> <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com> <5e85074a-16c0-46da-952f-6218b687e5a2@sirena.org.uk>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <7f2d214d-ebc3-4c9d-b2bd-4ad94719e6f6@weissschuh.net>

Sep 25, 2025 16:45:19 Mark Brown <broonie@kernel.org>:

> On Thu, Sep 25, 2025 at 11:37:39AM -0300, Andr=C3=A9 Almeida wrote:
>> Em 25/09/2025 11:24, Mark Brown escreveu:
>
>>> It's not 100% clear to me that we should add this to the nolibc
>>> includes given that nolibc itself does not rely on or offer stdbool -
>>> I was going to send something out adjusting kselftest.h to unguard the
>>> include there.
>>
>> If we don't include stdbool.h here, it looks like
>> tools/include/nolibc/stdbool.h cannot be used by any test, and unguardin=
g
>> <stdbool.h> would defeat the purpose of using -nolibc?
>
> Huh, I'd not seen that - generally stdbool.h comes from the compiler
> rather than libc so it didn't occur to me that nolibc would provide one.
> Looking at the compilers I have installed they all seem to be doing
> essentially the same thing (with some C++ handling).

-nostdinc also prevents the compiler from using its own headers, so we deci=
ded to have our own variant in nolibc.

(The same holds true for stdarg.h IIRC)

>> I'm also not 100% sure as well, lets see if Thomas or Willy can shine a
>> light here.
>
> Yeah, if we've got the nolibc one I guess we should use it in which case
> your patch is I guess what's expected.=C2=A0 I'll send out my version onc=
e my
> tests finish just in case.

Thanks!

