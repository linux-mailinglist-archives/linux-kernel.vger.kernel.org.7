Return-Path: <linux-kernel+bounces-890035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A21C3F1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62E7A4E2320
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F968246BD8;
	Fri,  7 Nov 2025 09:18:15 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30D1E51E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507094; cv=none; b=HWTPX5/KQH9cEpV+I27I7y4TuDN+2JY7aYC6XvZL1Qim8V4gDc7zoYchC+OdK8ID8PjVbUqwwnJ0108WuqhZhfSJdUu59CaLzwyI62YUiVtJED55Qc9x/+P8RV7u8pzwsaWxh0t+a78cjxXOUVXeDZKu46ke5t7NLDHLY1qcFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507094; c=relaxed/simple;
	bh=aK2iF/kixl2XHyP1F25TOCOaMu8zFPcKDptWcTJ5dDc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=knKTTn33lnv9lqUvvpk1sIuy23SbLuetREr7SB9czLQLBQLlA1bM/BmDG/QfnCkQ86OJOdQRxx0CVxw+GGWZFVvfpP6bUL9ataA3imqC2zD6PmD12Uw9RgRC/Ovmtbg3fut6KBaxZjuUd6a4ZHARIY6+Ce2qcl3EmCB1htv8IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B4DFE2CFC87;
	Fri,  7 Nov 2025 10:12:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8ebayicaHm3t; Fri,  7 Nov 2025 10:12:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4C6CB2CFC9B;
	Fri,  7 Nov 2025 10:12:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2zSpx9lpBYSw; Fri,  7 Nov 2025 10:12:36 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B2CD2CFC87;
	Fri,  7 Nov 2025 10:12:36 +0100 (CET)
Date: Fri, 7 Nov 2025 10:12:35 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, leoyu <leoyu@mxic.com.tw>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Message-ID: <954318808.156230.1762506755899.JavaMail.zimbra@nod.at>
In-Reply-To: <CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com>
References: <20251106054940.2728641-1-linchengming884@gmail.com> <20251106054940.2728641-2-linchengming884@gmail.com> <87o6pf8r24.fsf@bootlin.com> <CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi
 headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF143 (Linux)/8.8.12_GA_3809)
Thread-Topic: skip programming unused bits in ubi headers
Thread-Index: e7dABj2Yaus8tdMWVqv/NCXl+sHf6A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Cheng Ming Lin" <linchengming884@gmail.com>
>> Here I am reaching the limits of my UBI knowledge, so I would prefer
>> Richard to (in)validate what I am saying, but AFAIU, the VID header can
>> be literally anywhere in the page, not just at the start or end of a
>> subpage, so in the vid_hdr_shift I would expect some extra maths to
>> happen, no?

Good catch!
I had to read the code change twice to see the problem, though. :-S

> I understand your point now. If the VID header is not guaranteed to be
> at the start or end of a subpage, then yes, my current logic needs to be
> reworked to cover that case.

Yes. This can be configured using ubiattach --vid-hdr-offset ...
With nandsim you can test all kind of combinations.

Thanks,
//richard

