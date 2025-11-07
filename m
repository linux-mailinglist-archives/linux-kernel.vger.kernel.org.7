Return-Path: <linux-kernel+bounces-890213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCEC3F836
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179B43B5131
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791E30597E;
	Fri,  7 Nov 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="o+r77pLJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFF1F3B85
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511485; cv=none; b=L5meJp06bkKUE0KYmQ74iRO/s/hlT4bEwvkMXXEz3oHKzTzh8pTYibb12MCQ/r+QLTsx02qE70ohs6WdIi58d3qjLd56OfqzVex9UL7JAI/Ovc0KAe+/HA09Tu9UUmHJwn/J+Ah65MLAPZUbogQa/ZLdgjMnoUXt6R+IXpIj9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511485; c=relaxed/simple;
	bh=wFPClCyB81hUhTdScwcNpQMnKZd+4jjbswENFhMPyrI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMqMwCLUzPOY/im96g8pEyS54H7Z2nY7OSxRQHYrhbdLpyLNYdIV+SdXIy0VV61zl6HGEkH9OpFh8LTqoRM4BMEOyBMLZkesofIVNHuAchgcDTPKdsWRvgkuC+LNKcOkA9GFFLRM7qDj0CQrfLNpxbqufFYdLcBi7CBTb7nLznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=o+r77pLJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762511479; x=1763116279;
	i=markus.stockhausen@gmx.de;
	bh=W8F0VjW8lRYxO1OG7WuWmkYThR7Kpeatr10h6A93E6s=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o+r77pLJPlhJo9YR1YoKissc6m8wOLhGUpafsPQF1znqGJATa5susEQz6j6ln6hq
	 /mhHkl4GDA5bVAyyRrVujkmrNM8Uu8KkoYShvHazORGAUPMlF/6Lbe5nOw5Xiqgpq
	 k2UgjAQ7VmS1J6nmBUuJH1j0CFwOyT6n1u1VYMvJiwAiuaK9+urMemtBY8EIQzKn9
	 Ro1jzsv3H0Dr0EaGG/IAMkuiKAq12AynYkgsNO7oFF6fVG+eCYkwrRNvPpV19J6A5
	 LKXHQxBlsACyYEtlJxPt5soAN46mrEpWxKWkaehspnGFOB35cjlrPo5eREmhSTUdv
	 des/ZYHzZfwanIL1zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1vhgHu3kRs-00NwKJ; Fri, 07
 Nov 2025 11:31:18 +0100
From: <markus.stockhausen@gmx.de>
To: "'Miquel Raynal'" <miquel.raynal@bootlin.com>
Cc: <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>,
	"'kernel test robot'" <lkp@intel.com>
References: <202511071114.8WeW2GZK-lkp@intel.com>
In-Reply-To: <202511071114.8WeW2GZK-lkp@intel.com>
Subject: AW: drivers/mtd/nand/ecc-realtek.c:443:undefined reference to `dma_free_pages'
Date: Fri, 7 Nov 2025 11:31:18 +0100
Message-ID: <003801dc4fd1$a76efc20$f64cf460$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLieNS3s8KtD1Ya0AXI/nJ6xtI95LLasT/w
Content-Language: de
X-Provags-ID: V03:K1:OX/azINIbOB9/vDcgE7SpUu96QuARoodd0UwUkPihPYEgqfFCZ4
 gxdMwzf8Eyp3z1i2unJCxpuab7mSUWtEq7oLPQm/PQMR7nnjssDesJVQ5TVcuB2xj0y8Lbh
 O83U58HSNMt92w7SSbudj6Z6nlzlyl95UJN7TUlpSp+UelJgZ6hPtonpEnPnUYZq/e2dOGq
 PSg4dAUgYXj7jYhyQCiHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zpc67cd0NJ0=;2Vx4Ox8rZReRyhHgZmhUtpmQGAj
 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

> Von: kernel test robot <lkp@intel.com>=20
> Gesendet: Freitag, 7. November 2025 04:39
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Miquel
Raynal <miquel.raynal@bootlin.com>
> Betreff: drivers/mtd/nand/ecc-realtek.c:443:undefined reference to
`dma_free_pages'
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it
master
> head:   4a0c9b3391999818e2c5b93719699b255be1f682
> commit: 3148d0e5b1c5733d69ec51b70c8280e46488750a mtd: nand: realtek-ecc:
Add Realtek external ECC engine support
> date:   6 weeks ago
> config: sh-randconfig-r121-20251107
(https://download.01.org/0day-ci/archive/20251107/202511071114.8WeW2GZK-lk=
p@
intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build):
(https://download.01.org/0day-ci/archive/20251107/202511071114.8WeW2GZK-lk=
p@
intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:=20
> | https://lore.kernel.org/oe-kbuild-all/202511071114.8WeW2GZK-lkp@intel.
> | com/
>
> All errors (new ones prefixed by >>):
>
>    sh4-linux-ld: drivers/mtd/nand/ecc-realtek.o: in function
`rtl_ecc_remove':
> >> drivers/mtd/nand/ecc-realtek.c:443:(.text+0x1f8): undefined reference
to `dma_free_pages'
>    sh4-linux-ld: drivers/mtd/nand/ecc-realtek.o: in function
`rtl_ecc_probe':
> >> drivers/mtd/nand/ecc-realtek.c:434:(.text+0x2e8): undefined reference
to `dma_alloc_pages'
>    sh4-linux-ld: drivers/media/i2c/tc358746.o: in function
`tc358746_probe':
>    drivers/media/i2c/tc358746.c:1585:(.text+0x15cc): undefined reference
to `devm_clk_hw_register'
>    sh4-linux-ld: drivers/media/i2c/tc358746.c:1610:(.text+0x163c):
undefined reference to `devm_of_clk_add_hw_provider'
>    sh4-linux-ld: drivers/media/i2c/tc358746.c:1610:(.text+0x1640):
undefined reference to `of_clk_hw_simple_get'

Hi Miquel,

help. What needs to be done here?

Markus


