Return-Path: <linux-kernel+bounces-794540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2FB3E2FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11BD1882D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109F340DA0;
	Mon,  1 Sep 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kkklwgM/"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287433CE9A;
	Mon,  1 Sep 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729789; cv=none; b=dfDO0/H10e8TTS29hk2IG6GquVCwqWo6CKeUrDCgcHsGmjsgLjlfmwL+5GIHPsdjAyRcQvBN1h0o5nwz1S7RhH+EvCZfyOcwk0bpVTfZWVIAgWbA0kyeEY30in+GQA5s5Fsu/Luv18c2wF8m3WfTYCbwJhla5uuOQKkkB6pxlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729789; c=relaxed/simple;
	bh=Ui0crk2z395Wl8PRVFvyq6K/NBRQL8Z5I+rhn4suff8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tworuriLcHD2n1K2P+qy4X3TacmVF5OMROiBB6eFpfwmjfV6Olls7y89pAWn+eZj+3tC7evvf2l9VEHUZXKCf09GVkVnCjcLaFJI9FxpW7PXoB30M/vC0U9kZwNhql3RXA25XvqpwLPQWl4Qu7nR078Y+vsxCRTorhWqWS8QnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kkklwgM/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 948E54E40C65;
	Mon,  1 Sep 2025 12:29:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DEBA60699;
	Mon,  1 Sep 2025 12:29:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 675AC1C22D5F0;
	Mon,  1 Sep 2025 14:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EOpDKz6P/sDOp2AbrMdlL77ikcy1M92sguX8hf0Bttw=;
	b=kkklwgM/rzi6uKPzHuuQkfZAdR4YO4NnicnrtHnvzT0Sk1MtC28c5O+wQiMgGDIueRlJsl
	/hZByz561jF6Uvd5hvi1LckrzwJ1mAPijo3XQOPDIqgtWuw60H06AY2hodRLI1p/FVSoxf
	ol6nU1kuiG+dB3NfjQ00jOk9jM/jx/nF8C4/gyl7FMU/ytalbwWWS3V6ku7PkVJQ0pMglR
	+ghTr5EopxLr4uinCMLDts5A7sCbVYsQPkDcjYdb0zh4mvlYp0lQvSuTcpEueasw+ncOpK
	2iI01ClItWiE9j92+2crX5V528j4fem9NUqvjzuzO1iipbCDMPWuWy3nRjQvjw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250731095247.2165158-1-colin.i.king@gmail.com>
References: <20250731095247.2165158-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] mtd: lpddr: Remove space before newline
Message-Id: <175672978422.48892.3067345209625386625.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:29:44 +0200
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

On Thu, 31 Jul 2025 10:52:47 +0100, Colin Ian King wrote:
> There is an extraneous space before a newline in a handful of printk
> messages. Remove the spaces.
> 
> 

Applied to mtd/next, thanks!

[1/1] mtd: lpddr: Remove space before newline
      commit: 4b7ea37ebb6ea59724f69e3888e7b276014e17e8

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


