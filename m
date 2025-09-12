Return-Path: <linux-kernel+bounces-813372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B342DB5444A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5283176337
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EF2D46B1;
	Fri, 12 Sep 2025 07:57:40 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513925A2CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663859; cv=none; b=FqOvygy1XzgI6ViSNQVwSgOSBweyi/UUNFvBs6ufLoQqz4Dk1faXdHVDPWix7ApUWQcKJ1OvyV+8EyUh7YJ8zSbeM03zmkRwqsyg1FaOAAhI7AyjkNs8uLfCirvaj5f3iH/Jlsv29WjivIjNK++3X6t6KhQebrdCInfeT/N4UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663859; c=relaxed/simple;
	bh=BbOB0ELHSrzS9qFp4mj021OSKJ3BuFGnG2nPTDvuAGI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fPqayaqcURwE/F9gQDhPTgYPUFj6lXDKV1z1mu3u5/aZp2ehBY7w3lfzxrg0V0XQvce+Mhpgx3J4MiQDLx+4fF8e4Jz7C4qf6e91Qa9I3kJ2GfCrgEP15fdQ/yMaCCkjWqP4Txe3JErM8WvZftJyMlnMH5rhsrpTxlvnFsFAFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 199A02C14AD;
	Fri, 12 Sep 2025 09:57:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id M83sCyoVSc9o; Fri, 12 Sep 2025 09:57:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B59F92C14B1;
	Fri, 12 Sep 2025 09:57:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mvoMTFhVDM1w; Fri, 12 Sep 2025 09:57:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8E2C22C14AD;
	Fri, 12 Sep 2025 09:57:28 +0200 (CEST)
Date: Fri, 12 Sep 2025 09:57:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu <leoyu@mxic.com.tw>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Message-ID: <1899901955.27456.1757663848457.JavaMail.zimbra@nod.at>
In-Reply-To: <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com>
References: <20250812051949.983040-1-linchengming884@gmail.com> <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com> <608935583.115196.1755171013804.JavaMail.zimbra@nod.at> <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: skip programming unused bits in ubi headers
Thread-Index: FR1UTwWJsSzQA+5g+AzaxW1MoRcCZw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Cheng Ming Lin" <linchengming884@gmail.com>
>> That's the crucial question. Is this true for all NAND chips?
>> Do avoid larger writes of 0xFF patterns file systems such as UBIFS
>> also use compression a lot.
>> At least that's what I have been told when I asked 10+ years ago
>> how UBI works.
>=20
> You are correct that there is an issue when blank data pages are repeated=
ly
> erased. This can lead to cells entering a too deep VT state, which may
> cause program failures in subsequent operations.
>=20
> To address this, newer NAND generations typically perform a pre-program
> step before executing the actual erase. This keeps the VT distribution fr=
om
> going too deep, thereby avoiding the blank-page degradation problem.
> Such pre-PGM techniques have been widely adopted for roughly the past
> 10=E2=80=9315 years.
>=20
> Additionally, JESD22-A117E (page 6, section 4.1.2.1) specifies examples o=
f
> acceptable data patterns, including solid-programmed, checkerboard/invers=
e-
> checkerboard, and checkerboard-with-fill patterns. According to
> qualification knowledge bases, using 0x00 can sometimes trigger special
> failure modes, whereas writing 0xFF is more robust.
>=20
> Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
> that continuous program/erase cycling with a high percentage of =E2=80=98=
0'
> bits in the data pattern can accelerate block endurance degradation.
> This further supports avoiding large 0x00 patterns.

Thanks for the detailed answer!
So, yes let's apply this change.

Thanks,
//richard

