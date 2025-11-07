Return-Path: <linux-kernel+bounces-890975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC2C417F1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A5D3B52AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231F2BE632;
	Fri,  7 Nov 2025 20:03:26 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206829A9CD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545806; cv=none; b=SG9b4R3o/5SJrQFtPE/nxdeuQxpY+WEm9QnIy20UjerDnpObglBwJXP1MjKf/fVf2Yxkf3VnlrWplYtdNFNor2zV0v26gaDHMmyanvF9SQ0VHcAwELV1Y23CBq4O5w0R4nPw54qYWTiCuXVI6ODEzBm7fWh5GjnuLziZO5QAP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545806; c=relaxed/simple;
	bh=Q057139mbSLFqM2gjZ2QezG+lPcNonFvnYn2UZm/59Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=soP3jfQSKPGKFiuGpAuKydFiUb8ipMj7FVQYAITX1XL8dmuO46vLnygl3fAB8rl8rQb0gYTJqjkFmigfRkIPgR3IxEUoalfxjk6Msbe8RSun42HSLKtI7+IYJw7rRbz27dESTfGj/038GmaBJe7+LsMxwMor9lfQeV/cugGhmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A8D3F2B03EC;
	Fri,  7 Nov 2025 21:03:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X-nbup-2UNCI; Fri,  7 Nov 2025 21:03:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 553D011C057;
	Fri,  7 Nov 2025 21:03:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 51_Gcrbkj5Yv; Fri,  7 Nov 2025 21:03:20 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2DA3911C056;
	Fri,  7 Nov 2025 21:03:20 +0100 (CET)
Date: Fri, 7 Nov 2025 21:03:19 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	OpenBMC Maillist <openbmc@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, sethjenkins@google.com, 
	adobriyan <adobriyan@gmail.com>
Message-ID: <55378147.159026.1762545799936.JavaMail.zimbra@nod.at>
In-Reply-To: <068ba254-0053-46d5-bff4-74c948d2e8ac@linux.ibm.com>
References: <068ba254-0053-46d5-bff4-74c948d2e8ac@linux.ibm.com>
Subject: Re: UBIFS errors since Linux 5.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF143 (Linux)/8.8.12_GA_3809)
Thread-Topic: UBIFS errors since Linux 5.15
Thread-Index: +EEJ8XwfiheRTquyWgicZAVkYE0nQQ==

Eddie,

----- Urspr=C3=BCngliche Mail -----
> Von: "Eddie James" <eajames@linux.ibm.com>
> An: "linux-mtd" <linux-mtd@lists.infradead.org>, "richard" <richard@nod.a=
t>, "chengzhihao1" <chengzhihao1@huawei.com>,
> "OpenBMC Maillist" <openbmc@lists.ozlabs.org>, "linux-kernel" <linux-kern=
el@vger.kernel.org>, sethjenkins@google.com,
> "adobriyan" <adobriyan@gmail.com>
> Gesendet: Freitag, 7. November 2025 18:38:54
> Betreff: UBIFS errors since Linux 5.15

> Hello,
>=20
> We are updating some BMC (Aspeed AST2600, ARM32) systems that were on
> Linux 5.4 but observe consistent UBIFS errors with Linux 5.15 and later.
> The errors seem to vary; there is a sampling below.
>=20
>=20
> We performed a git bisect and came up with the following commit, which
> of course is completely unrelated to UBIFS. Reverting it does prevent
> the issue... Does anyone have any suggestions?
>=20
> commit 33fc9e26b7cb39f0d4219c875a2451802249c225
> Author: Seth Jenkins <sethjenkins@google.com>
> Date:=C2=A0 =C2=A0Thu Oct 27 11:36:52 2022 -0400

That's indeed strange.
Are you absolutely sure that this commit triggers the issue?
E.g. if you revert it on top of 5.15 the issue vanishes and when you
re-apply it, the issue is back?

Thanks,
//richard

