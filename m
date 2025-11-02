Return-Path: <linux-kernel+bounces-881775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77EC28E54
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6CB3A6F28
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600272D8768;
	Sun,  2 Nov 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UclykNDV"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FA2D839D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083724; cv=none; b=KIhhZikkFQ8pniFtPaAjgk+OGs2JOC2B4zPI/695W4EzHb66Q5500WPA4PjiutRlOjp9Oma74OFy7NWA+3QgwDULW1Z5pAeTaWE/PTQV6WOTE6XSSA51sG1r8Md1iX+VUmqInAkICF2b8s7FkpK4m85YzDyuAqD8iopCvxfajz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083724; c=relaxed/simple;
	bh=nlZFXH31G46OMgkFai5nO/GmjX3QkicYJ1jxaD0fX2I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=imPchvTp0ocmgULj+Q/jnXUTkIQSvbXl9klgL2hr/zI+3pnVGo60I3XXFeoi2TDmRCQOFti6yC9ULe4pig0wCIfXdYz00Zv6GvmZXvRSSPLWk6+32DeUr6mtf3FySEp7pw14K05WkXnN57ypKCgH8c5l5Elsft2zypr6cQ01xcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UclykNDV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762083721;
	bh=nlZFXH31G46OMgkFai5nO/GmjX3QkicYJ1jxaD0fX2I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UclykNDVQJgK/YUhBbnQTk5PwAQlBKo8YEvluUM9pTG4irQPn8HJHfMmChVFa+xGO
	 iU0j9wWKSXEi5hEEuviZ4jLd0Z1xDnSJxa6IvQZUKfrB+wAuUgaWu/DaaPInz1fAU7
	 4KphVro5cmH4IOIchVokOC4+4kK854aYPW5vIGwI=
Date: Sun, 2 Nov 2025 12:41:57 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <58e535bd-6125-4f18-9a0d-7ce1cdd3f478@weissschuh.net>
In-Reply-To: <20251102111855.GA24871@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu> <20251102104611.24454-3-w@1wt.eu> <cc94509b-a87b-410e-a601-6381c2a2e6e1@t-8ch.de> <20251102111855.GA24871@1wt.eu>
Subject: Re: [PATCH v2 2/4] tools/nolibc: add the more portable inttypes.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <58e535bd-6125-4f18-9a0d-7ce1cdd3f478@weissschuh.net>

Nov 2, 2025 12:18:57 Willy Tarreau <w@1wt.eu>:

> On Sun, Nov 02, 2025 at 12:04:01PM +0100, Thomas Wei=C3=9Fschuh wrote:
>> On 2025-11-02 11:46:09+0100, Willy Tarreau wrote:
>>> It's often recommended to only use inttypes.h instead of stdint.h for
>>> portability reasons since the former is always present when the latter
>>> is present, but not conversely, and the former includes the latter. Due
>>> to this some simple programs fail to build when including inttypes.h.
>>> Let's add one that simply includes stdint.h to better support these
>>> programs.
>>>
>>> Signed-off-by: Willy Tarreau <w@1wt.eu>
>>> ---
>>> tools/include/nolibc/Makefile=C2=A0=C2=A0 | 1 +
>>> tools/include/nolibc/inttypes.h | 8 ++++++++
>>> 2 files changed, 9 insertions(+)
>>> create mode 100644 tools/include/nolibc/inttypes.h
>>
>> I think this should also interact with the big nolibc.h.
>> Both being included from it and including it itself, to follow the
>> generally used pattern.
>>
>
> You mean you'd prefer "include nolibc.h" from inttypes and
> "include inttypes" from nolibc, that's it ?

Yep.


Thomas

