Return-Path: <linux-kernel+bounces-794539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10237B3E2FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D483ACBDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271233EAF9;
	Mon,  1 Sep 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s166XnEY"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252D33A033;
	Mon,  1 Sep 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729787; cv=none; b=ouvzxLXivnFHChkg0AiQF1Ql2wYm3TiE0XGWfkL5MjLzTXfsJwwFGI2KU6bUmlgRmvfqU79BcHk4CPvGO7dfEbycCzq5cLcyvOURFXfMdFieSe81x5ET9SJjatqCVOje9leI8Joh6SEQuMxbP9WkOKWH76M3NcllFGA0eR5XR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729787; c=relaxed/simple;
	bh=HNSSy4gLC/9WHWrA6B4/A8MHvyXbz9mhhtWbCBRnPyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q/5p5h85HVgmebjjR2Ax5IjkGmBcORbVmnNt6jsql8imJlOmA2inVz6aI+hIPc69ihdrBxGDb687O1PqfOf8o9YqxFaYx/TaazRnEaURSp/kE26iBXdoI4VeQuLF6mKDX/wIysKbdfYyPe9t+cPR9Ogey7xp6NgW9WB7VxeZZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s166XnEY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7CE54E40C68;
	Mon,  1 Sep 2025 12:29:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8158660699;
	Mon,  1 Sep 2025 12:29:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 729D61C22D87C;
	Mon,  1 Sep 2025 14:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hzPjYWwkBf4kBKB+qdhiUwv4m8+EB5tTZp+VN+Z62n4=;
	b=s166XnEYapxNciGn9V5rIDeHThG8ouyPX9jXbkRG54FjA2+7yjcfuJSiiHxneFGocTw2d9
	UHUsO9Co3DVK/m8BzO4d3Zc62eCActgif96/54bSTGV8r/AWslhKp2TQr6ZWbMWu5X7JBi
	79vZLgIptVKBsUCEz3lVAS9wFRcmLqJiWarzpGwrGiKURZXe9jkH+F+jPwbONl2euXZES3
	n55X6WHANTmdWcGKse/6DCHQgHyyJVaUlpA1fV0lFEFirHUv3akhVDFVF0nXF8xc2An29r
	/kyPqJWMQ+uy5POgd5irVXQzC4Z2l6oTeIfnzy5TpgcuT3wD2GuxBDwRhuQN/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250731094613.2164604-1-colin.i.king@gmail.com>
References: <20250731094613.2164604-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] mtd: jedec_probe: Remove space before newline
Message-Id: <175672978328.48892.14632603085435940884.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:29:43 +0200
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

On Thu, 31 Jul 2025 10:46:13 +0100, Colin Ian King wrote:
> There is a extraneous space before a newline in a pr_debug message.
> Remove the space and remove a space after ( and before literal string
> to clean up checkpatch warning.
> 
> 

Applied to mtd/next, thanks!

[1/1] mtd: jedec_probe: Remove space before newline
      commit: 1371b126ac3d89d911c7b75a753c7d17458a4853

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


