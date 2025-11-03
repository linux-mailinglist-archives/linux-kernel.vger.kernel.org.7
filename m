Return-Path: <linux-kernel+bounces-882684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC6C2B1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B856D348CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03C2FF160;
	Mon,  3 Nov 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PHZ4M4zF"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FC2FE57F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166640; cv=none; b=FNer1c3+/xQkOEmcvVtqPgjTk1/NdlU1aqI0fC6v1crmo8ptoWZBFQQl5tt7/XOTKc5O6IXncyZdKiucDkZ5qVFr9fNPRlD74Owu3cnw9EM4Qbx8/wKQXWCraV26aEm8j4ZsCrjwwbH3o5kXNpICfZvaA30ZQ6Zeo/0aL8KuNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166640; c=relaxed/simple;
	bh=sPpylmkPo1U7is19iqmBPri/UjZeqVdfe9D5ILK8QaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OSVY2OMFOUxszUi/aQZLexS7JVkqOLNeKsxpOETVkCon63qkFHnV6ibuJ61Ue982R+T8elvv80Y/T8oIfnBwqcmu52gkOx2JOjRMkp5W+vm4L3Awt9Pga9Cl+6uiDHzqhwxVEeXxL2J1AIL+Gis6Rq3VQYbWRtXI518IRlh2xLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PHZ4M4zF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C00234E414BD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:43:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D39B60628;
	Mon,  3 Nov 2025 10:43:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F7AB10B50003;
	Mon,  3 Nov 2025 11:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166635; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vIHKi4Zn2T0wcQp28mHyoJxRO/S2syht65h8AwmUtxs=;
	b=PHZ4M4zFXw354dDzIifG05ygoxXArB4D494J2+nZbJiCnEX0X9GixAlTxKdAqceVP6NMdw
	9siYgR/FMT+EU/fop+XL6ychisL8PXdOAo7qrE3LFXSqaDQ9B9rFa+RK5pWCHJhLYv+2Xt
	XjT77E0ez42kyXMujTbncxqowlxDbyiY77f3AF9MsPAs7Xw/s8nNE/Q89MMCh34he3uG37
	M1bYFfrsTDwhv9iSASnxc1NukrsBqqWttgCv1JLRStQZdsiogt155YO+WDEht5D7GUFXrY
	1bY5hrQrA/Nt12/CJ3Wl2l9nbGOS6ponovjNqwbYlUIf8H4K9P0/X1vO8zGvOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org
In-Reply-To: <20251031054118.1402280-1-rdunlap@infradead.org>
References: <20251031054118.1402280-1-rdunlap@infradead.org>
Subject: Re: [PATCH] mtd: spear_smi: fix kernel-doc warnings
 <linux/mtd/spear_smi.h>
Message-Id: <176216663305.908867.6989807234811696368.b4-ty@bootlin.com>
Date: Mon, 03 Nov 2025 11:43:53 +0100
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

On Thu, 30 Oct 2025 22:41:18 -0700, Randy Dunlap wrote:
> Correct most kernel-doc warnings in include/linux/mtd/spear_smi.h
> by adding a leading '@' to the description of struct members.
> Add a new description for the missing @np member.
> 
> Warning: spear_smi.h:48 struct member 'name' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:48 struct member 'mem_base' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:48 struct member 'size' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:48 struct member 'partitions' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:48 struct member 'nr_partitions' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:48 struct member 'fast_mode' not described
>  in 'spear_smi_flash_info'
> Warning: spear_smi.h:62 struct member 'clk_rate' not described
>  in 'spear_smi_plat_data'
> Warning: spear_smi.h:62 struct member 'num_flashes' not described
>  in 'spear_smi_plat_data'
> Warning: spear_smi.h:62 struct member 'board_flash_info' not described
>  in 'spear_smi_plat_data'
> Warning: spear_smi.h:62 struct member 'np' not described
>  in 'spear_smi_plat_data'
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: spear_smi: fix kernel-doc warnings <linux/mtd/spear_smi.h>
      commit: c95de73da12bf4586b7bcd6b23a6968c21991cc7

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


