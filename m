Return-Path: <linux-kernel+bounces-892821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A62C45E62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017133A4ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB6305066;
	Mon, 10 Nov 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="f1X7CXII"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E992F3601;
	Mon, 10 Nov 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770199; cv=none; b=Dxy+HlQSyfEMnv2yZNBAmLWXzNLPYcvUQb2D6Vm1PMLyOZ36/Um6wcWbt1l3gdSoASXKnkR43G/HnWaDOC1Xh6aqH/zeadXRNdGGREBV6TfQTW6ZQEUg8fNC4PQYc4UG1J9L8XOynn7hkEQ1hLvnFYdgOM/TemnJwtkNBw4xhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770199; c=relaxed/simple;
	bh=RWEP0R0pTG321z+Z6PZ8q34MUxzyv7FTabwu8ryr9mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phwxKpIksePhfMM3cYZCuMcvusS44nWTdQ2CC2L1sd44497y4VuSk5RuqOvOd+dMUKnHeBji/5NbCGPpbgz8LK1klTROWb/xqu46LWHi5W6tVbLnOD/FiTAM08AT1ucolyzVho29MeiNLImsW+OpGN3f1HxkPLRfC45mwu172MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=f1X7CXII; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762770193; x=1763374993; i=deller@gmx.de;
	bh=n+WLv0qum0TyySWOTqWqs5Hc6wLEkONWzjrPnoWRkmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f1X7CXIISQq1mBetU474pR3T28jltwCFwAda72Z0pnoj4riAD0nE8TckpXcFaw/r
	 /5uULLlEz6W30foUkTJ6/Lp7EGXZBFQy2icIobqj+g024uioxYJlx5eOqah9nrELK
	 WoObhmNMc2BOHPXj7VFAV41liB92b0sTbV76dopWNV4q40FDHAThGg9hglY8w/E5+
	 v6ZPyN0TSs3i/gNnHgGJywzdpQofny5mkYkHEBAK2XEAVpI9sg80IfcUGQOQdGp6N
	 f8Ffr3jRKagEBjOUalRRNjXM+hoYyLxI2HAgAAeu1BrBxvVIR/0Fdw2jJ9C+W751S
	 TvnWsdQYagR+R2119w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1vMF4h3BKY-00FmWL; Mon, 10
 Nov 2025 11:23:13 +0100
Message-ID: <7efd11f2-aa31-4ad5-bd07-18df750f53cf@gmx.de>
Date: Mon, 10 Nov 2025 11:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Drop linux/kernel.h include from asm/bug.h header
To: Finn Thain <fthain@linux-m68k.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3d812c89ecbc6028e3c550c484201f33d763b885.1762735489.git.fthain@linux-m68k.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3d812c89ecbc6028e3c550c484201f33d763b885.1762735489.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:je9qkIqOx+Jy2gU0PJrbWRRilWQAna1QWy/EFqifb1otMweBCA7
 1kqold9fBcciRle02ZhS7/TO/5ntoXIBTfSLWuIkh5W3dhnAIxHx1Wm20cNXMv6iptSIaDI
 zbJU2tGUx5ywG+nimh707vLEByqpew/9KhekuPHWsveWGFz61mIbQpXVZZij8pBapn+2bac
 WfluziGch0eXfArdQ5wMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ek8+xcQ8Z9I=;nnN9gobHbs9oSB9XYqXFfImETJo
 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

On 11/10/25 01:44, Finn Thain wrote:
> While working on an unrelated patch series, I needed to include
> linux/bug.h from linux/instrumented.h, in order to call WARN_ON_ONCE().
>=20
> Doing so resulted in the following compiler error on parisc:
>=20
> In file included from ./include/linux/atomic/atomic-instrumented.h:17,
>                   from ./include/linux/atomic.h:82,
>                   from ./arch/parisc/include/asm/bitops.h:13,
>                   from ./include/linux/bitops.h:67,
>                   from ./include/linux/kernel.h:23,
>                   from ./arch/parisc/include/asm/bug.h:5,
>                   from ./include/linux/bug.h:5,
>                   from ./include/linux/page-flags.h:10,
>                   from kernel/bounds.c:10:
> ./include/linux/instrumented.h: In function 'instrument_atomic_alignment=
_check':
> ./include/linux/instrumented.h:69:9: error: implicit declaration of func=
tion 'WARN_ON_ONCE' [-Werror=3Dimplicit-function-declaration]
>     69 |         WARN_ON_ONCE((unsigned long)v & (size - 1));
>        |         ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1
>=20
> The problem is, asm/bug.h indirectly includes atomic-instrumented.h,
> which means a new cycle appeared in the graph of #includes. And because
> some headers in the cycle can't see all definitions, my new WARN_ON_ONCE=
()
> call appears to be an undeclared function.
>=20
> This only happens on parisc and it's easy to fix. In the error
> message above, linux/kernel.h is included by asm/bug.h, but it's no
> longer needed there, so just remove that include.
>=20
> The comment about needing BUGFLAG_TAINT seems to be incorrect as of
> commit 19d436268dde ("debug: Add _ONCE() logic to report_bug()"). Also,
> there's a comment in linux/kernel.h which strongly discourages use of
> that header.
>=20
> Compile-tested only.
>=20
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   arch/parisc/include/asm/bug.h | 2 --
>   1 file changed, 2 deletions(-)

applied to parisc for-next git tree.

Thanks!
Helge

