Return-Path: <linux-kernel+bounces-836511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A936BA9E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9241921C80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862EC30C34D;
	Mon, 29 Sep 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y6CEjFdy"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E230C0E9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161361; cv=none; b=Y3t/WAa/h20QqOfULJit6Lp84KTuobDMF49ouHU8ttftQM0HsNLDTEDQRzAlXFPlVnslZUmqFoZVJ9Nfr87CD01SZktS8cDgJaHbMDxiwo4bhTtpSf+3daGe1zMvSOdaU0pVj+r4AheOoGaVs7RwQNe7AX/dH2CWavYRcuw14G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161361; c=relaxed/simple;
	bh=KQ7QzfhN7Op6kQ/F8I35pq49o6a7+xA6FC60H6s9vEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kxq9nKigAi4Opf6GUTyALu6OZoxEas5ZjldOlY6UaIaybKrzecbajERL/w2x4U7XNuMHqbiXBm3EjUO4J2+cy9fGtj47BcMKrsVLefviX63XexS7vXGWRENGRUYmxQpCnGaTpB/TJYxFA/DxK4zglPpjIez0r8deNdNjntPIdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y6CEjFdy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AD19C4E40DB2;
	Mon, 29 Sep 2025 15:55:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E336606AE;
	Mon, 29 Sep 2025 15:55:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D9C8102F1A13;
	Mon, 29 Sep 2025 17:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TPvcvLYB4WgLJY8jyEyevyM09bFYh3JtKjYAaSTCRMo=;
	b=y6CEjFdyA/ikNLoNAf7CXLZj1qhtht00PsZKe9zH2hGrZ22UjlkS9kQHZGh0T/LnxFHo3d
	6dYsM5oypCVEZ1x/r8DYdCfsHZMaILDiQ/3HEkk4XOUKZPy2teckxBY6d4/iNRAQlO416S
	MlAxmBkIxmFSQ5S9nFQq5JQvdzXkOaWtyxhiPBiNY0X2BGFZsceZulBqKVYKcYe2WK5KM4
	MgrlVFxi80Pb7OU+gjYmkHecZDM6kyYJHDkZp6YnasLooK9essHRcuuaWZkRg/OO9MjeRs
	Y2Pxynq1Jz9P7rJVcjqz3MeYEkADLIFu92GC/D6QzWgGqtaPjSB4ZwTaf8eHAw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250922152204.15702-1-johan@kernel.org>
References: <20250922152204.15702-1-johan@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: omap2: fix device leak on probe failure
Message-Id: <175916135511.50416.11507699706726091640.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 17:55:55 +0200
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

On Mon, 22 Sep 2025 17:22:04 +0200, Johan Hovold wrote:
> Make sure to drop the reference to the elm device taken by
> of_find_device_by_node() during probe on errors and on driver unload.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: omap2: fix device leak on probe failure
      commit: fa1f26b48fe43195aa0ac4badf5651063590326f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


