Return-Path: <linux-kernel+bounces-865195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6250BFC704
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCE4E6AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08534C139;
	Wed, 22 Oct 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mzlx6EvE"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470C30170C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142815; cv=none; b=nnKvlGpnidl0hUuiOuFixi5pghREX23bOT01joz7YPKlr012uhx829y3iqPMfhhcu8onO771UiwMil0klnZro1MQw4DO2ZJtl8EhzYMlkmaJ5gOTSC+8xsrlIVkBV534Hhek1iow/fDU3cnofQBM/TceRF8oo/J50oNGS1j1u/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142815; c=relaxed/simple;
	bh=YDrPkEB0fB9w+iRkPNkPwaIYR4vCHUz/cyHracxKgT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1xifCaZt6XWtcrhsWVVQ3QoszzGA//zImV7IYKNXzuXZ3MK7jL0xa08jffRmy/IJjlRbNsgKPu0cTEmumbSMLveWNT6X4Ly4hiSoJGGfRXmb+QvM7iAWb6rQtubuz4tUR10Zo5xIUMyj+yA3T5qoZeLKTw4VSZDVw6gfBruqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mzlx6EvE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A57AF4E4127A;
	Wed, 22 Oct 2025 14:20:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 749B8606DC;
	Wed, 22 Oct 2025 14:20:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87394102F2439;
	Wed, 22 Oct 2025 16:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761142808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YDrPkEB0fB9w+iRkPNkPwaIYR4vCHUz/cyHracxKgT4=;
	b=mzlx6EvEVaWafTpIjOYi/NVNX3P/BanSYBrvHxYuPvzxJfpqFMMZpck8YmaC5HTw1C3XLs
	B09tuEu/mUSZx/H86vZJpl18EpTIAwivq/TpGE1SHJdAjKoBnWEobjMETxCTz+5WEoXQjD
	H9BePMHaOakTqANK9rRsLGeknzf9hrL3P3/nOQIFJroEGB41OoWlszg8YlECWqGktUEDyH
	k5+bbVjWgADdchtjufx+oRkXPTvn18MX5wKx8OT51gzPHeWoqtHW3IxEum+/sonku+aPZx
	icOUzmmRgbPSPOYwddb6J2cWz41f3XxYHXhugOsUQs6/RYjN8t/SaPQn0YQ4ZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: jayxu1990@gmail.com
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  avnerkhan@utexas.edu,
  rdlee.upstream@gmail.com,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] mtd: core: Add nand_id sysfs attribute for NAND devices
In-Reply-To: <20251014192455.4007534-1-jayxu1990@gmail.com> (jayxu's message
	of "Wed, 15 Oct 2025 03:24:55 +0800")
References: <20251007224049.2798233-1-jayxu1990@gmail.com>
	<20251014192455.4007534-1-jayxu1990@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 16:19:54 +0200
Message-ID: <874irrrpbp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 15/10/2025 at 03:24:55 +08, jayxu1990@gmail.com wrote:

> From: Jay Xu <jayxu1990@gmail.com>
>
> [Problem]
> Currently, NAND devices do not expose their NAND ID through sysfs,
> making it difficult for userspace applications to identify the specific
> NAND flash chip in use. For supply management reasons, electronics
> products are typically manufactured with multiple storage device
> suppliers, creating a need to identify which storage device is used
> on a particular product. The NAND ID is a semi-unique identifier that can
> be used to determine chip-specific characteristics such as maximum P/E
> cycles, which is essential for NAND health monitoring and wear leveling
> algorithms.
>
> [Solution]
> This patch adds a new 'nand_id' sysfs attribute that:
>
> 1. Exposes the full NAND ID (typically 5-8 bytes) in hexadecimal format
> 2. Only appears on physical NAND devices (MTD_NANDFLASH/MTD_MLCNANDFLASH)
> 3. Is hidden on virtual MTD devices
> 4. Reads from the master device to ensure consistent ID across partitions
> 5. Handles on-demand ID reading if not already populated during probe
>
> The implementation uses a separate attribute group with visibility control
> to avoid affecting existing MTD sysfs attributes. All NAND partitions
> from the same physical chip will show the same ID, as expected.
>
> The NAND-specific code is conditionally compiled with CONFIG_MTD_RAW_NAND
> to ensure clean builds when raw NAND support is not enabled.
>
> This enables userspace tools to reliably identify NAND chips for
> health monitoring, bad block management, and device-specific
> optimizations.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510120356.STGKDkA5-lkp@i=
ntel.com/
> Signed-off-by: Jay Xu <jayxu1990@gmail.com>
> ---

I haven't reviewed the code yet, but at a first glance I would not be
opposed to it. I remember though we already had some kind of similar
discussion and IIRC we declined (I cannot remember why nor find any
relevant link).

Richard, does that ring a bell?

If we go the route of printing an ID, maybe we should make sure the ID
is always populated (we always read it at probe time) so we do not need
to re-read it later. Also, we should probably store it somewhere in the
NAND core and not make it raw NAND specific as SPI NANDs will likely
suffer from the same issue at some point.

Thanks,
Miqu=C3=A8l

