Return-Path: <linux-kernel+bounces-890943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D489EC416E0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3C3B3B08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9123009F5;
	Fri,  7 Nov 2025 19:23:21 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6FB1A9F96
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543400; cv=none; b=dd2JxbbJiyQlCBMTIUPznBkh7vP1zXG47Ir/ZwMVvR+y9sfFU1p2sOzLOf3ZIp9IczJYQet1u9O6U3z5w/pyEO6QfzN5NamG9uhp+/UHthxuofam+YrW8J+pf2IcVp4th1n0YxOzKBPqoz7/IfA3LDEtgqexw2tb5t0YrnWtZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543400; c=relaxed/simple;
	bh=eXlCXSwjIH2VjjXEkoOn5qykH1tJrGt4S2/7SveqtKQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jW5wWW6zSUkS10GvR0G8x06ESLMavtKpIvWqdVXPc/TG9dfpiVFkti43LwRZW4EYRbaOAPgMJNvZ+Mb+zO5iZ182t1Yau3iBbgJX1iTaBEY8NGkRqdPP1fX2ajD4mg2DdIgMok8t6G2HDJNRmliTTBuLp4eMsrzl6ZnTJFJiGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EDA862CFC9B;
	Fri,  7 Nov 2025 20:23:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2R6fOeHHtymO; Fri,  7 Nov 2025 20:23:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 813442CFC87;
	Fri,  7 Nov 2025 20:23:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zqOd4E8HCNTp; Fri,  7 Nov 2025 20:23:14 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4A11611C056;
	Fri,  7 Nov 2025 20:23:14 +0100 (CET)
Date: Fri, 7 Nov 2025 20:23:14 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alexandre torgue <alexandre.torgue@foss.st.com>, 
	mcoquelin stm32 <mcoquelin.stm32@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, wanqian10@huawei.com, 
	Yang Liu <young.liuyang@huawei.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	Liyuan Pang <pangliyuan1@huawei.com>
Message-ID: <79797154.158914.1762543394141.JavaMail.zimbra@nod.at>
In-Reply-To: <14f5091f-b647-40c9-9c32-6a705c2d6c37@web.de>
References: <20251107100057.1091153-1-pangliyuan1@huawei.com> <7857ab09-7808-4abe-9df1-66235291436b@web.de> <DF8B15D4-4819-47E6-9BB0-268AD0204C86@nod.at> <14f5091f-b647-40c9-9c32-6a705c2d6c37@web.de>
Subject: Re: [v2] ubi: fastmap: fix ubi->fm memory leak
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF143 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: fix ubi->fm memory leak
Thread-Index: fBqM9AqfBycgbGob73i+cfkQqy6K6g==

----- Urspr=C3=BCngliche Mail -----
> Von: "Markus Elfring" <Markus.Elfring@web.de>
>> > You may occasionally put more than 60 characters into text lines
>> > of such a change description.
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658
>=20
>> Feel free to ignore everything Markus says.
>=20
> Does your feedback indicate then also that Linux development process
> documentation may be overlooked any more?

The only reason why you are not on my kill file is that I can protect newbi=
es from you.

To quote GregKH[0]:
> Markus, you seem to have sent a nonsensical or otherwise pointless
> review comment to a patch submission on a Linux kernel developer mailing
> list.  I strongly suggest that you not do this anymore.  Please do not
> bother developers who are actively working to produce patches and
> features with comments that, in the end, are a waste of time.

> Patch submitter, please ignore Markus's suggestion; you do not need to
> follow it at all.  The person/bot/AI that sent it is being ignored by
> almost all Linux kernel maintainers for having a persistent pattern of
> behavior of producing distracting and pointless commentary, and
> inability to adapt to feedback.  Please feel free to also ignore emails
> from them.

Thanks,
//richard

[0] https://lore.kernel.org/lkml/2025110516-cubical-drowsily-7acd@gregkh/

