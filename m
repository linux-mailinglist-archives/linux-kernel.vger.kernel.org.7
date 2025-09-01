Return-Path: <linux-kernel+bounces-794531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAA8B3E2ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7021883B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626E334711;
	Mon,  1 Sep 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SXVpa7ZA"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C2334709
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729701; cv=none; b=HAtZ52mbO5a/ER27Zt1G65/cT7guO6WbspoMtEuYnGD7WeQpqxRQs+Ux/IRBHIKReY5aKc1ttyqR2i97oyHu/VFkMWlW86eEDPOzjaUMIV82r3FTWIGoNyV02+oOIsiB8mPiNRWeoS/2zrUKVnJbksISaZtRGwp/P+B+7KxXP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729701; c=relaxed/simple;
	bh=H1tJS65PmndJkfwsoTp/pcsNN/iJAa1IoEF5B3tj3kI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L0Jo22VFKbjwUeeirdli7zlZjB5VxJIj+kuBilqoqJwY/hFbsnT/gvMmRG8NjdfM2peZ8aiROmkcxrZx/KIJ3hZBTOUPTlyE/0ETvEerqtlDjpYNKy8a32cAzo+RqHJoWptNgJXeB5sJsOftSsF+4k7jsF9fMNZlotRJK53AkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SXVpa7ZA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D1CB64E40C65;
	Mon,  1 Sep 2025 12:28:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A97AA60699;
	Mon,  1 Sep 2025 12:28:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14C491C22D736;
	Mon,  1 Sep 2025 14:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I/laeijb58zrGdzeNLjskuGQXHq+or0fFdQCv8Qbv+o=;
	b=SXVpa7ZA7/pUYzfX/ReMvByFr23qz2R1aRaPOkr+aUwYWow4dICYyAe5B+KUBg9n0md1J8
	/z3Nw18xgUSqxtmwvDvhEycGd7zzOdMfICtewmRQw9Vb/hGj9Xh9XJFE+Jms6B4l1AQjUA
	UxFWwg33It1VY6RRIpdwTzyz3kUTVEvky2bgHFjYJkU4ZU3rnpIQw8hfMYkf1YZmRtn9g3
	Eqf2WvABoUs0ujO3gAuWLhCGSCr0/QU8ohAmfbF5zdjLphWp7Cw3MOHeIdILmHfLhkuyiv
	BaOv+KKLdC0QBeE+wySGltbQksizRQGRQhiALwzeInKDzu2EP2bxagdJQ90HMQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, Teng Wu <gigadevice2025@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 teng.wu@gigadevice.com
In-Reply-To: <20250818135227.2114-1-gigadevice2025@gmail.com>
References: <20250818135227.2114-1-gigadevice2025@gmail.com>
Subject: Re: [PATCH] mtd: spinand: gigadevice: Add continuous read support
Message-Id: <175672969089.48694.8035765334378979816.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:28:10 +0200
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

On Mon, 18 Aug 2025 21:52:27 +0800, Teng Wu wrote:
> GD5F1GM9 supports a high-speed Continuous Read (CR) mode which allows
> the entire memory array to be read out by a single read command
> without re-issuing the 13h “Page Read to Cache” command for every page.
> 
> Datasheet summary
> Feature register B0[3] (NR bit)
> 1 = Normal Read (default)
> 0 = Continuous Read (CR)
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: spinand: gigadevice: Add continuous read support
      commit: 49b9254217048068ae1011619db60a6de5edf7e2

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


