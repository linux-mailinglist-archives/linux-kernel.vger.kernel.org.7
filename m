Return-Path: <linux-kernel+bounces-764152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73130B21EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854E31AA2BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11C29BDA0;
	Tue, 12 Aug 2025 06:57:17 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF229A30D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981837; cv=none; b=t10P7htNLjBWUV2l0mrvkRMB8fD5ji/mtPqj/GWYiK505vlhECmbWzGEasHEQ41OvBCwfBASfibYLvDD0gUHoj+0/sn7Vbh0BG4ecTHW39rzNj8C2Nu6F5l52fGEKUyTcKmq1bfSnQQlntCLXnz+ZPbZb8OQU1zvouj4TpKd6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981837; c=relaxed/simple;
	bh=Zqj3rfGFk2cIji8pWhQUoFLjx5k6yHtxC9iWrwTB0h0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aVTrfGFrJ6HUzQfE4jqfNavvIwvgKmOyqN2kWwRo50s6I68na2roJOq8dEDdPVdLc2GHKUnekzA/wnjYSvhgJJt45SmXEUeiln8iOiPMAoAQJnrp2T3nirtkxrHOY1TJGY0rSlD8YmmTXIR616FcUvmN2fmkAUgJNUGijtjaETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 71B812CFC9E;
	Tue, 12 Aug 2025 08:57:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DZXKfu6zHe_N; Tue, 12 Aug 2025 08:57:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2FC222CFCA2;
	Tue, 12 Aug 2025 08:57:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UyyYftYaZDx0; Tue, 12 Aug 2025 08:57:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E9B322CFC9E;
	Tue, 12 Aug 2025 08:57:08 +0200 (CEST)
Date: Tue, 12 Aug 2025 08:57:08 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Message-ID: <152133202.103367.1754981828821.JavaMail.zimbra@nod.at>
In-Reply-To: <20250812051949.983040-1-linchengming884@gmail.com>
References: <20250812051949.983040-1-linchengming884@gmail.com>
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
Thread-Index: VhBWjQYhkWEhcaAAxAB74s5JC7o1Cw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Cheng Ming Lin" <linchengming884@gmail.com>
> An: "richard" <richard@nod.at>, "chengzhihao1" <chengzhihao1@huawei.com>,=
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
> "Vignesh Raghavendra" <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.inf=
radead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "Alvin Zhou" <alvinzhou@mxic.com.tw>, leoyu@mxic.com.tw, "Cheng Ming =
Lin" <chengminglin@mxic.com.tw>
> Gesendet: Dienstag, 12. August 2025 07:19:49
> Betreff: [RFC] mtd: ubi: skip programming unused bits in ubi headers

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> This patch prevents unnecessary programming of bits in ec_hdr and
> vid_hdr that are not used or read during normal UBI operation. These
> unused bits are typically already set to 1 in erased flash and do not
> need to be explicitly programmed to 0 if they are not used.
>=20
> Programming such unused areas offers no functional benefit and may
> result in unnecessary flash wear, reducing the overall lifetime of the
> device. By skipping these writes, we preserve the flash state as much
> as possible and minimize wear caused by redundant operations.

We talk about programming a single (sub)page, right?

> This change ensures that only necessary fields are written when
> preparing UBI headers, improving flash efficiency without affecting
> functionality.

I have been told that writing 0xFF bytes to NAND should be avoided.
This is also why UBI initializes them to 0x00.

Do you have data which proves the opposite?

Thanks,
//richard

