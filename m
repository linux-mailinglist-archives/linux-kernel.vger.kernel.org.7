Return-Path: <linux-kernel+bounces-762382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA32B205CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEEB7ACFBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4A2343C2;
	Mon, 11 Aug 2025 10:38:52 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF05224B01
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908732; cv=none; b=LMzHiwLMGqSFnBwHak+N9JdJQz4WS5KrZ0bVnA7A5I8ATrhbX8dHHFiqBWNIye6jOeCNq4GiTWkWzsbXOe/cOxDp7uM4jKJ7AQaVpt3qFdra/dIM8kr8ca9l2SWfzft8A8/BtAkuHstPgCxMO6XCUQpGY4cLRHEGT2tQMf6lojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908732; c=relaxed/simple;
	bh=X8t8hf1KLcD3WH5XNWFbIeyUSqndx1CNN9ATCQHBwo4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GRPWxOK5sQ1+uF0mii/XP8a4yNNH5yVPA8431P7HXSAM4+NJTBL3tnEcBRLitCBBgAySDmKTPr9prXpTIbSwkZqBybF950Wa6WVBMwU36bqe3l0rmag/hHuGsQSI+pLAQMJxwoG4t4nMQRlPNigWtNEEKYcjCzEuR5z+Id5vx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F0F282CFCA2;
	Mon, 11 Aug 2025 12:30:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5BH2MNXWoEOq; Mon, 11 Aug 2025 12:30:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 10A3B2CFCA7;
	Mon, 11 Aug 2025 12:30:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o6PhqYes8Ibu; Mon, 11 Aug 2025 12:30:35 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E04312CFCA2;
	Mon, 11 Aug 2025 12:30:35 +0200 (CEST)
Date: Mon, 11 Aug 2025 12:30:35 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1568241822.99082.1754908235674.JavaMail.zimbra@nod.at>
In-Reply-To: <20250811101529.436635-1-zhao.xichao@vivo.com>
References: <20250811101529.436635-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] ubifs: Simplify the code and remove unnecessary
 parameters.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Simplify the code and remove unnecessary parameters.
Thread-Index: cSlLst+Q8vbSL98lrl9oiwh3IrKzog==

----- Urspr=C3=BCngliche Mail -----
> Von: "Xichao Zhao" <zhao.xichao@vivo.com>
> An: "richard" <richard@nod.at>
> CC: "chengzhihao1" <chengzhihao1@huawei.com>, "linux-mtd" <linux-mtd@list=
s.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Xichao Zhao" <zhao.xichao@vivo.com>
> Gesendet: Montag, 11. August 2025 12:15:29
> Betreff: [PATCH] ubifs: Simplify the code and remove unnecessary paramete=
rs.

> Remove the parameter '*c' from the ubifs_crc_node function,

...because c is not used?

> and replace part of the code using ubifs_crc_node.

This are two things, one logical change per commit, please.

Thanks,
//richard

