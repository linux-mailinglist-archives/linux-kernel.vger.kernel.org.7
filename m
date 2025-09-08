Return-Path: <linux-kernel+bounces-805398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82980B4880B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2998416AFF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16642EFD9E;
	Mon,  8 Sep 2025 09:14:29 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FD224247
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322869; cv=none; b=QoW6uuKvl+3eEan+knUarCUY/x7VXkfqEFNRqgSs40FHMAJNsTevwfbG4Pxv5dUjtEot86g4VNiSb8Y1U0tB/GPO5VEm8a8klP1zhTPArSoM3Ilr97hUbN1SVJcwVARABHrDP5p/rAk7+x+k3mXvpiMk4uK/5bPucdF0OU8CIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322869; c=relaxed/simple;
	bh=CaDDMraZohZs4is23yr42VC1gN+kt3a2iJx3H30zs2g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jg8wH4BW/DYSj2hMnnmKE0lr10f0poKi6L2n3Abl8PZbBmKNPn6+GM8OKrxVo8S7NxP2fPBmeOTAJdc7v+7qHe1y8fbBeGtcaXsFB0rk6OVk+6PZnle8JeYWClHzlkL8LucELR8hoPUv5B6hPzfbaEaTkVZD7FzcfR8nwV4U/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2FEEE2E52E1;
	Mon,  8 Sep 2025 11:04:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wCoe0__baTRa; Mon,  8 Sep 2025 11:04:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C41712E52E3;
	Mon,  8 Sep 2025 11:04:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PWcVxOwn-xIb; Mon,  8 Sep 2025 11:04:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 936312CE379;
	Mon,  8 Sep 2025 11:04:20 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:04:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rahul Kumar <rk0006818@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-kernel-mentees@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	pratyush <pratyush@kernel.org>
Message-ID: <93578759.11447.1757322260340.JavaMail.zimbra@nod.at>
In-Reply-To: <87tt1djtot.fsf@bootlin.com>
References: <20250908070124.2647038-1-rk0006818@gmail.com> <87tt1djtot.fsf@bootlin.com>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: sm_ftl: replace strncpy with memcpy
Thread-Index: hoN3+Lz+G6z5Lodbq+9CIhidly68CQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "Rahul Kumar" <rk0006818@gmail.com>
>> -=09strncpy(buf, sm_attr->data, sm_attr->len);
>> -=09return sm_attr->len;
>> +=09memcpy(buf, sm_attr->data, sm_attr->len);
>> +=09buf[sm_attr->len] =3D '\0';
>> +=09return sm_attr->len + 1;
>=20
> Are we sure the buffer is always sm_attr->len + 1 long?

Can we please just stop messing with perfectly fine code?
I'm sick of the war on string functions.
First we had to replace everything with strncpy(), then strlcpy(),
then strscpy(), ...

Don't get me wrong, I'm all for hardening code paths where
strings are arbitrary input, but in many of these cases all strings
are no input or already sanitized.

Thanks,
//richard

