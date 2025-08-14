Return-Path: <linux-kernel+bounces-768697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF22B26448
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A691F5813E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293E2D8767;
	Thu, 14 Aug 2025 11:30:27 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11215DBC1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171026; cv=none; b=Nr128JwZdLq9DikVarVB8jkM1ZMd0MC6SCbJn4SRd9KJjoh3mQLLE1bhwhHajtGizk+4j3EcXch5E0SqYqoMP+WB0nE1y65WUPNnV4YEYKbVYsVEKhDnkeleycMWHPz+7npDa+++gXewOH8aFz6xNH9cNtcZOni/3p7WrVyqJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171026; c=relaxed/simple;
	bh=nBdT1pcEgLIrsOU0sL7E2tMUtUwI2vNgiHfyZmMtLOs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MvatgU7m22idiwtSLvpWK4iVcc4Lh6tzmF1E+qfhsndj7od7PoBsapFS17BitAub0kjVTjC1Jf+H0ZvJ4BffgxyvyjSZ2RYnqHW5+F4YzWUn50SMTz9U5ddMs/gYSViFpv2/TUD1ujUK9lLQkaYo/xTvI9TmGfP07xuJo6AocuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C38D32FFDA5;
	Thu, 14 Aug 2025 13:30:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XP9eaYOi19Kn; Thu, 14 Aug 2025 13:30:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33BBC2FFDA9;
	Thu, 14 Aug 2025 13:30:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OGe52fzWuMNR; Thu, 14 Aug 2025 13:30:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E51A62FFDA5;
	Thu, 14 Aug 2025 13:30:13 +0200 (CEST)
Date: Thu, 14 Aug 2025 13:30:13 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu <leoyu@mxic.com.tw>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Message-ID: <608935583.115196.1755171013804.JavaMail.zimbra@nod.at>
In-Reply-To: <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
References: <20250812051949.983040-1-linchengming884@gmail.com> <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
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
Thread-Index: 63S535GLvQTJB7IX1iFPElc1JTBAaQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Cheng Ming Lin" <linchengming884@gmail.com>
>> I have been told that writing 0xFF bytes to NAND should be avoided.
>> This is also why UBI initializes them to 0x00.
>=20
> Normally, after a NAND flash block is erased, all bits are in the 0xFF
> state. Programming 0xFF in this case will not actually change the NAND
> cells, as the device can inhibit programming=E2=80=94either by raising th=
e
> bitline voltage or using a self-boosted program inhibit mechanism.
> Therefore, programming 0xFF is a normal and harmless operation for NAND
> flash.

That's the crucial question. Is this true for all NAND chips?
Do avoid larger writes of 0xFF patterns file systems such as UBIFS
also use compression a lot.
At least that's what I have been told when I asked 10+ years ago
how UBI works.

Thanks,
//richard


