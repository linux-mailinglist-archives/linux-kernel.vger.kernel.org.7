Return-Path: <linux-kernel+bounces-822764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A140DB849DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D1F1C244B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B32F7462;
	Thu, 18 Sep 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sj7Safh4"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919619343B;
	Thu, 18 Sep 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199228; cv=none; b=XvjL0VQ35ofh4OMZqBlYtBCAxYmqzkk6Q4f5unT1Lzq4BjF5bQetg8TTL35yTOw1Zb8xXLS4cQAxMRVw8qrrcLqK1Izt+Wolc4rzU2ALQ9gog1yJJeMznoROjgNh2m+Qqszg8ZLEZxlfV+2wyY00iVM9UCAC9k6y/WV8awSEg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199228; c=relaxed/simple;
	bh=20nPlYPmA0e5EwOTVJ9Q7+tREGdSGGPO/VVimdXrB1U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rEtc8Nls8nVe9Xl75iUKaHWo/LM04CmlGnvSr3v/gmikjN6J6Z5nH7+AjJ/HxVNT8jacHcYpbGjObEbddoUOqNzo/lUsyDqULzXErTmnKdVGPLzY2aYj3ghzhdFkDAXVGxrHZUh3b+RNEMRJOEGXUvnQ3OXC/ZOQ1sTuC4Xyce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sj7Safh4; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758199221; x=1758804021; i=markus.elfring@web.de;
	bh=WnKLRueb1iIcJSVij+hT0JlorqYL70v6D+rxnlzGjZk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sj7Safh4YA2cmIDLPWD4aruhZ7R7yz5iIKWtW+4jJu76CRxlzUsDxIvacgFuLfbB
	 MR39xz9eTgIGbLQnYttGsOsTGnTnKnHJFr2xN3D6px+SK1eFS3XD6sAAkFYQEN+gN
	 c438xBRFBZMGL2Q5AKojgavxosEslWzqiXDu5MFV8/wsfLiJk/n68Lwk46tIllaih
	 XCi5KfEl3m2lrXmbenS4Ip5eloHKvE49WkGcKzU0RJrC0LQ45dRojueR1DcGeoGj+
	 pNTqYIvWrgFTMPQisPIkWuN1wZPjxqBD604bQ6JhLQrpnXkrFeVYQ+JOgIJkAavS8
	 mpyD635TinKtrYz1ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1uwBvq1MiJ-0016Qp; Thu, 18
 Sep 2025 14:40:21 +0200
Message-ID: <681e64d4-4a10-4c7e-9680-97de27ca5482@web.de>
Date: Thu, 18 Sep 2025 14:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <64c3889e132a96853a361791c44fcea1a0aaac8c.camel@gmail.com>
Subject: Re: [RFC] coccinelle script: scope-based resource cleanup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <64c3889e132a96853a361791c44fcea1a0aaac8c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M/Ph8pyryd9dbnbDsDx9cir269Kcqk7y4QnPT63EMqWkqlPCoA/
 +P1y23KO7u3BZx8bFk6oSVYOPFehL0+A9MaVPwtGHPc0kIGP9EENnt3eJoHHmTj7z2Fidln
 sUa9pXpQgPESdpBnPG0wBaEMqs5Rr16Ntmd3cRbl8IA/Lqh+qF8LfQYBL2TpK32OtqzYVTX
 3Z9omelvRnM2BIR/uNkFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZ9dkwuB56g=;IWXynzrCscrrnYd3kTnmoGJALPP
 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

> With the guidance of my mentor Julia Lawall, I have developed a
> Coccinelle script that assists with scope-based cleanup in the Linux
> kernel. The script aims to convert lock/unlock pattern to use guard
> cleanup macro.
> Link: https://github.com/Erickkaranja/scope_based_cleanup.git

Thanks for your growing development interests.

I added some review comments for further development considerations.


> When developing the rule some key consideration was taken to ensure the
> correctness of the transformation. This involved enforcing some strict
> rules and not transforming some patterns at all.
> For instance though, some transformation were correct to use guard,
> CLANG raises some warning and thus required a strict use of
> scoped_guard in this scenario. Refer to this commit
>=20
> https://gbmc.googlesource.com/linux/+/97f4b999e0c894d3e48e318aa113013203=
1815b3

How much will compiler versions matter?


> In cases where no transformation is applied, it is because performing
> one automatically could risk introducing errors or unintentionally
> changing the function=E2=80=99s intended behavior, so such instances hav=
e been
> deliberately left unchanged.

Will transformation requirements push also any improvements for the Coccin=
elle software?


> Examples
> case 1:
> In cases of inversed lock  pattern i.e where unlock happens before the
> lock.

Under which circumstances will =E2=80=9Clock-free=E2=80=9D data processing=
 parts become supported?


> case 2:
> Scoped_guard implementation uses a for loop, transforming code sections
> that braces a break statement within the scoped_guard could lead to
> unintended changed use of the break statement.

Will further collateral evolution become helpful?


> case 3:
> In scenarios of conditional jump, if there is some function call before
> the unlock, there is the danger of moving the function call to the
> critical section and if the function sleeps could lead to deadlocks.

I would appreciate clarifications for such a wording.

Regards,
Markus

