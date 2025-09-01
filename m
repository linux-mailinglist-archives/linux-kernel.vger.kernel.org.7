Return-Path: <linux-kernel+bounces-794532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8215B3E2F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84A7174599
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE503375C0;
	Mon,  1 Sep 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Iq7ocEMg"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0F26D4C1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729703; cv=none; b=mxX1lsz3Ci+7A7IjhdDW7jumZBkOOBzdq6GiL9V9Y7Kak00lY6EV8Zap/s9Tl32F40zSpRy8vdu8VFa9a7Ik6HtDi9wIq6xC5QHgQMXVeYHMdVCuxJadAcufNShAhAa2Zzdl0vGSyjRwB0Nbl7dHQuyfF0rVwKeTmY4L4gbQzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729703; c=relaxed/simple;
	bh=ceFZSQYBHVSI1dj1l2ydtV69IZUePm5nSFGIM8xofls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sN50s30INr9HxOaaQDvIu/TZGbxtxvL5X13dfXYtbCB5Av7bnoSWz+vsHnFlKc8KAVHG9TPFh8kYVvkTanpv0R7BFCxtUCSiZ9/LR6A9w9OlizHcdcnqBa+b7szhnQeFcwVlvaP+zoWyxqEU3uG+l8rxAtgKxyjU9m9DlwQYWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Iq7ocEMg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 27BC41A0D65;
	Mon,  1 Sep 2025 12:28:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0066C60699;
	Mon,  1 Sep 2025 12:28:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89A1C1C22D920;
	Mon,  1 Sep 2025 14:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U+SK2AVsSCug5ZsR90vfSD8eIzRNACmLyPgSVFEpsHQ=;
	b=Iq7ocEMg6qMkfq/ptkMDQ6tN3xj9mQSYc2CoNH+QClpeqzZ6T8LdOWqcBPiJzV9AelFhCs
	pJ5hBTp2NKb1jP+WkQddpUyOkJYBwjBqwJV9RAWQEDUZX2Dzh2MgJUUs0v6atrl7I9TGtg
	SKUSQ4qOrxNSeqNnIVGiWFtvoNnAgRWWUeFq/oxrX9B23dCM3MioDGWPH3qdRabgSzFei8
	OZGawBuvhPO3cpawZfA1ZcSRO/9gkk3fcXp4XNBJ6syRDLhM2GlHaoKdMWNz63+n/DCrrY
	hCNjWNB0KV05rOfYSc2XJOk9a5CuastfO6ejk0LXhS8ZoAQxm+McHj9ALlNtTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>, 
 Tianling Shen <cnsztl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20250824170013.3328777-1-cnsztl@gmail.com>
References: <20250824170013.3328777-1-cnsztl@gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for FudanMicro FM25S01A
Message-Id: <175672969741.48694.14164729625728644164.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:28:17 +0200
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

On Mon, 25 Aug 2025 01:00:13 +0800, Tianling Shen wrote:
> Add support for FudanMicro FM25S01A SPI NAND.
> Datasheet: http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: spinand: add support for FudanMicro FM25S01A
      commit: 5f284dc15ca8695d0394414045ac64616a3b0e69

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


