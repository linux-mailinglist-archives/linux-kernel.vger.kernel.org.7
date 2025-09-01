Return-Path: <linux-kernel+bounces-794543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E1B3E308
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A817AA8B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAE33CE86;
	Mon,  1 Sep 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PW81rS0W"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7763340DBA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729791; cv=none; b=YuPTo+5RAakoBomTzY0nv1WFMsOmKQ6kGBfUT6IFfKz6PEmIwRgmyvL97C8B2vG9fkWGncu4zRSdKFPuN+e1UisXYfmTvHlsh5PDapYfgxfGeo334kBVuSiusgsTw2wrbabTPLEWlrv7CUjUcIShGppUa7z7NEAnH5MZgvj9HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729791; c=relaxed/simple;
	bh=L/eWdJkpd6crJ2d6l5tX76Xv+cOM7GAu5vcy3xOcflA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mx4f/JyBkoMffdCRcFw7I4RBnT+oxwOwMOj5/s9PMC+WZR7pG+WrHPilTogKOzfxayf5UEaVbc7M+IUakPASQSdf3Fi9koJ+uxY75ub4XOspMLCbw3gMyPJUILj3d/VzM1Z71mIcDc64x0KcBXBUh5IixgYz41rLO6sO/LZpD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PW81rS0W; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DB585C8F1CA;
	Mon,  1 Sep 2025 12:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B621D60699;
	Mon,  1 Sep 2025 12:29:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18ACA1C22D9EE;
	Mon,  1 Sep 2025 14:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729788; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AeYpbZsIhquiBEK6QCKGdwjwjeTwyh8ByoAGh5hJubI=;
	b=PW81rS0WzD+5BJ0VnKdYe8F8pIYWRTh83LgCyLKNt95t6VjLnVsTV/TqcrvMvpgmSaexrN
	BvABRkonhVBLBqwLYN1dMF4fcQVel1iGO6hZq5qHZQYc+1WPLA2jHJ/L3wwEUkT0DDDbCj
	uvFewSL8k5lw7rsavw01OJr+ajqfrCaCmuRbvhcPFx8EGj2JzXXA6gLu4N4HH4RF/E0vFP
	CMj1X5oThuOZpFG7v/1v6L1ELK3zG26Fop47uBTxAx1e8Szc8Ox1KA6jVZCJ5o2I5G9UsY
	FdVOd9TWgbUOA+RSicC2NZlGVkxpYPBVqEqqX4SCagbHDfbRlrKQYK5hUPkubg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 WangYuli <wangyuli@uniontech.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250812035856.501130-1-rongqianfeng@vivo.com>
References: <20250812035856.501130-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] mtd: use vmalloc_array and vcalloc to simplify code
Message-Id: <175672978602.48892.293348155362794718.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:29:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 12 Aug 2025 11:58:53 +0800, Qianfeng Rong wrote:
> Remove array_size() calls and replace vmalloc(array_size()) with
> vmalloc_array() and vzalloc(array_size()) with vcalloc() to simplify
> the code.
> 
> Compile-tested only.
> 
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: use vmalloc_array and vcalloc to simplify code
      commit: 84908cb0d46a574a404beea5ac899ed949ef4e81

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


