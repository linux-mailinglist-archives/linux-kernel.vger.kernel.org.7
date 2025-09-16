Return-Path: <linux-kernel+bounces-819485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E14B5A184
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F89488120
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22727EFE3;
	Tue, 16 Sep 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf+xkC50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A527A907;
	Tue, 16 Sep 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051365; cv=none; b=nLgCCH6y1z0mx33XTNDeDzy7emRUdFfW1Z/PFYJ292FFe7tbvKmYPVxnwthui6d5U23kZIrtylSSYXxjG3PKBpqub0Tk3eDXJ8kArpjxgA873H2PRr0FuRTcl0+juUwXkzs+9zTTpULhz436r7j2jCOKiDB5FSNjwlEfY3CfCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051365; c=relaxed/simple;
	bh=ghR7W+6OUpqFqZvySPtXRRnnWTRyswPrma1f/7NfxfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1jkG5OJ+WhoaRc0mea8BY9nBp+QeMi91aJkCIqo4gCAy+OrLlDd1BhxOS63yJYv30HMS+OTOiWFk/EjAEn6yGGNPw7UEC0f1V3x7DZWe/vh+de9GUvAPT0OpN/Bj7pNHhR37uxKi/sv3XZaiRFri1xQ0/XeXZDS9ntqRv8OLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf+xkC50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08295C4CEEB;
	Tue, 16 Sep 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758051365;
	bh=ghR7W+6OUpqFqZvySPtXRRnnWTRyswPrma1f/7NfxfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pf+xkC50Z8w4iBf8i4FVLF3nUB0UJUEQdWf/4ouPzp5iPOPJmQ8V2v8/3+Y7IuYeO
	 DWSsLPh1zYyuWBHoIMNsuqCOBgsVxJQieY/qdXr42pPNBNzLCbJiSiM2kJdtn9LKie
	 OX2/rNKyQyUfaY4IXH4k14gM0jHh5tsRRZNR2IhnG515xl74jO1xeJl+9usTADlKF8
	 FZ6PBCfXVx6y5enFbWzuP58bJ+Qe0bI1SI6VnKDx8HZ1xeppFpIqaHXOBVo/JjNHtq
	 XB7vNgIQUNr8/+sYMv2Nju/IwTa1CJa9ZZR1P17hgLSXSId13VXNiItS2qruv53nJm
	 xKibcABpOHQAA==
From: Conor Dooley <conor@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v3 0/5] riscv: dts: starfive: Add Milk-V Mars CM (Lite) SoM
Date: Tue, 16 Sep 2025 20:35:56 +0100
Message-ID: <20250916-evacuee-postbox-8b576a82e868@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905144011.928332-1-e@freeshell.de>
References: <20250905144011.928332-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jlPwUGixLoNmykuR6H7mnfwCfEkNvHVsl2XHNQnmeWE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBkn98jUzrz69YiyxrTMLXtOXtDxWOLScl7m/6tpqSETB Apf1/1/2lHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJdO1lZGhcxRnjWLt+J882 Nr97R+3f2a74fdv8gtBDmW+NRimb0+czMmxffeaU9ePLAgbc9w5l9eZeiyxhOn3Uhm3b7gQHx52 r+tkB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 05 Sep 2025 07:39:38 -0700, E Shattow wrote:
> Milk-V Mars CM and Mars CM Lite System-on-Module both are based on the
> StarFive JH7110 SoC and compatible with the Raspberry Pi CM4IO Classic IO
> Board carrier. Mars CM Lite is Mars CM without the eMMC storage component
> on mmc0 and the mmc0 interface configured instead for SD Card use. The
> optional WiFi+BT chipset is connected via SDIO on the mmc1 interface that
> would otherwise be connected to an SD Card slot on the StarFive
> VisionFive2 reference design.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/5] riscv: dts: starfive: add common board dtsi for Milk-V Mars CM variants
      https://git.kernel.org/conor/c/651b30c58775
[2/5] dt-bindings: riscv: starfive: add milkv,marscm-emmc
      https://git.kernel.org/conor/c/d1829e0b2f06
[3/5] riscv: dts: starfive: add Milk-V Mars CM system-on-module
      https://git.kernel.org/conor/c/8d193bc0aa2e
[4/5] dt-bindings: riscv: starfive: add milkv,marscm-lite
      https://git.kernel.org/conor/c/12a29108384c
[5/5] riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
      https://git.kernel.org/conor/c/4cce8b2503ab

Thanks,
Conor.

