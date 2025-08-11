Return-Path: <linux-kernel+bounces-762631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD0B20920
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C61818A3602
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4BD33D8;
	Mon, 11 Aug 2025 12:46:36 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335C8635B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916396; cv=none; b=KcLhpWzISRXMH0MYvtS6l3enzhtXX9xdFz1x0z6QQMufbFjhOgbeiPSSnjFiOiCooIdMbH5grL3L6dv2VGkalFj12EKJgn/LCE1lNU0CogXxuHT11llAytqgf1nrSBmgMSvoO1IBBFaE6AHtSmdV5dt9yg3c6MfGb8wvu0GqrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916396; c=relaxed/simple;
	bh=etVT89uZ38a7cTbLS6AyJMA4airugHbj+eEGf41ZWXk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uMRV0vTMt3OdLcQImAHaVvVjDfhmjsvKLAUygERjYwrgPBtEIN9PudNgG9BHEBz3jLSGkMjMKB826veSQu48qGZ1zxwQ0rLpCyrzpD+ctm83CI1QnDwnOTi/euMr+nFFa+JBp/2GpSYn/pMX/tePTEws+Yo/B5YU0fAPg2m8tgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6754F2CFCA2;
	Mon, 11 Aug 2025 14:46:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zZlOK5j1gnYO; Mon, 11 Aug 2025 14:46:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 59B212CFCAD;
	Mon, 11 Aug 2025 14:46:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YszAZL2IXWFc; Mon, 11 Aug 2025 14:46:29 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3896A2CFCA2;
	Mon, 11 Aug 2025 14:46:29 +0200 (CEST)
Date: Mon, 11 Aug 2025 14:46:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Miguel =?utf-8?Q?Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1786903963.99788.1754916389068.JavaMail.zimbra@nod.at>
In-Reply-To: <20250811120912.144720-1-miguelgarciaroman8@gmail.com>
References: <20250811120912.144720-1-miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH] mtd: ubi: replace strcpy with strscpy in mtd parameter
 parser
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: replace strcpy with strscpy in mtd parameter parser
Thread-Index: coMJNePqoBbE5DTFLz9HlnrmJEa8+A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miguel Garc=C3=ADa" <miguelgarciaroman8@gmail.com>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.co=
m>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "chengzhihao1" <chengzhihao1@huawei.com>, "linux-mtd" <linux-mtd@list=
s.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,=
 "Miguel Garc=C3=ADa"
> <miguelgarciaroman8@gmail.com>
> Gesendet: Montag, 11. August 2025 14:09:12
> Betreff: [PATCH] mtd: ubi: replace strcpy with strscpy in mtd parameter p=
arser

> Replace the strcpy() calls used to copy the 'mtd=3D' parameter into local
> buffers with strscpy() to avoid potential overflow and guarantee NUL
> termination. Destinations are fixed-size arrays (buf and p->name), so
> use sizeof().
>=20
> While this code is currently safe due to prior length checks
> (strnlen(val, MTD_PARAM_LEN_MAX) and early return on overflow),
> replacing strcpy() with strscpy() follows current kernel best practices
> and makes the code more robust to future changes. The sizeof() calls
> correctly compute the buffer sizes, matching MTD_PARAM_LEN_MAX.

TBH, I'm not convinced. We're talking about kernel module parameters,
not hostile user input, etc...

By adding sizeof() you're replacing one foodgun with another one.
If buf is in future changed to a pointer, sizeof(buf) needs a fixup too.

Thanks,
//richard

