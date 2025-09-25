Return-Path: <linux-kernel+bounces-832671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC9BA0102
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2621E1623DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103A2E093E;
	Thu, 25 Sep 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pg+eEulf"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE222E091D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811589; cv=none; b=l1brigbet2Zt2RGwhe8WcmUlWnhiQ3j4VeQudONrDBg+wspFR9Gu78ZcNJEzKLRa6gGi0tpz63dd9PmM5Fbf1HYgETzl6ifoqsqLqwY4J6zcHUydZx8mqnODbZ2Ser+F+6cbXgdeAuENN1XJ5KJiuH43qgUKxWB47o6cXF0dXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811589; c=relaxed/simple;
	bh=wktM1dTWTrCxGle6ruvKhZB2oi5edgmFflZWH1WP+fA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AmB9rocHWWvl7awhuqoltjchk5If8lSvAeMW4gDGteQIzrqsVrHFZR7xEmrSnZf2iRuN64GknoS0XmsOPQRbZmZmeLdrDbZLivwz+Kj9nuRqoZBsvmfw0WQ2RENNIXS9jAEVHZHqddGS1zzwvkFMP15vWbNaOR9noIrGkGOoQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pg+eEulf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758811577;
	bh=wktM1dTWTrCxGle6ruvKhZB2oi5edgmFflZWH1WP+fA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pg+eEulfU9uj+kAaSV1P2Je33EFQ8ig4r56MLDMxtRs9RBpTvT0yx78n2myI8bPHU
	 +NzmkFZQo66agzfWy/EqaQixLb+nlcMpbJagL1JVU/h78C5/inlgpc1ijKUnrM1OYV
	 dSceTFE25efiWXntjyz1PRk4GW8GtPdLRmJIvFuo=
Date: Thu, 25 Sep 2025 16:46:11 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <871aa6e4-21ef-493c-9eac-df9b8069afab@weissschuh.net>
In-Reply-To: <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk> <20250925141423.504427-1-andrealmeid@igalia.com> <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk> <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <871aa6e4-21ef-493c-9eac-df9b8069afab@weissschuh.net>

Sep 25, 2025 16:37:45 Andr=C3=A9 Almeida <andrealmeid@igalia.com>:

> Hi Mark,
>
> Em 25/09/2025 11:24, Mark Brown escreveu:
>> On Thu, Sep 25, 2025 at 11:14:23AM -0300, Andr=C3=A9 Almeida wrote:
>>> Add stdbool.h to the list of nolibc.h includes, otherwise tests compile=
d
>>> with -nostdlib will fail with "error: unknown type name 'bool'", even i=
f
>>> a nolibc stdbool implementation is available at tools/include/nolibc/.
>>>
>>> Reported-by: Mark Brown <broonie@kernel.org>
>>> Closes: https://lore.kernel.org/lkml/833f5ae5-190e-47ec-9ad9-127ad166c8=
0c@sirena.org.uk/
>>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>> Fixes: f2662ec26b26 ("selftests: kselftest: Create ksft_print_dbg_msg()"=
)
>> ---
>>> =C2=A0 tools/include/nolibc/nolibc.h | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>> --- a/tools/include/nolibc/nolibc.h
>>> +++ b/tools/include/nolibc/nolibc.h
>>> @@ -116,6 +116,7 @@
>>> =C2=A0 #include "sched.h"
>>> =C2=A0 #include "signal.h"
>>> =C2=A0 #include "unistd.h"
>>> +#include "stdbool.h"
>>> =C2=A0 #include "stdio.h"
>>> =C2=A0 #include "stdlib.h"
>>> =C2=A0 #include "string.h"
>> It's not 100% clear to me that we should add this to the nolibc
>> includes given that nolibc itself does not rely on or offer stdbool -
>> I was going to send something out adjusting kselftest.h to unguard the
>> include there.
>
> If we don't include stdbool.h here, it looks like tools/include/nolibc/st=
dbool.h cannot be used by any test, and unguarding <stdbool.h> would defeat=
 the purpose of using -nolibc?

It can still be used through '#include <stdbool.h>'.
But we support both ways of using nolibc, so this is a valid bugfix and I w=
ill apply it.

On the other hand removing the guard in kselftest.h would be nice too,
the code will look idiomatic.
It could trigger issues for programs that do not have tools/include/nolibc/=
 in their include path.
But Mark should be able to fund those.
I removed the guards in kselftest_harness.h before and that didn't lead to =
issues.

> I'm also not 100% sure as well, lets see if Thomas or Willy can shine a l=
ight here.


