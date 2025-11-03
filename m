Return-Path: <linux-kernel+bounces-882679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C45C2B1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059693AF969
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9E2FFDDA;
	Mon,  3 Nov 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zzc8F1lW"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EC2D77F7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166359; cv=none; b=AZ2YdKgCd4EWy64CClecbR/Bz5CwaT84Wq4rjNJ7UEBokPLm9nOcuvwHy2xbAYBisWiQt1Is2gWFTMvPKG8aAh9zPbM7/ZDFmihgX51q6ZPqDecpgA+gvKpmUBgFQghz/eyuYwUmZxL8xA25KQBs4mZPZ7thpGiG+UzgA1fyQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166359; c=relaxed/simple;
	bh=kVaosc87WsSLZslBaRJCS3CJ1mDwMBMH2pbrjJjyE0Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ywz//2Eky5I3/VEsz6dkHiT673IG4+VjTHFuFmgRefTM+er9pMd1Zq9a5RjQnEuGqkkOaQNQK9/aHHRPxHr9Hjdl5Dwz5wI12ubhijmiDU2du1SanfrNS7Fl62ao37L6A5cd4PGex1T+MyesWPevTadRpwO8PdulR3WgyNqm+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zzc8F1lW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DDBD8C0D7A8;
	Mon,  3 Nov 2025 10:38:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A18AF60628;
	Mon,  3 Nov 2025 10:39:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F07B610B5000E;
	Mon,  3 Nov 2025 11:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166353; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+YdwOQIVG/gdlY9V7pUGKmGPH02+CcIrYSL3JTyrz5s=;
	b=zzc8F1lWMP97FvKi59Tymh5cnN7wgqzwX663gDKTIoqR49yHV8LXa2/Is6AEZfKiGSkxy4
	KhwSx3hxeLjZQLhD/Qd0n5tKS9o0cU22zwaI9DoVR5csi+ivm/Pob4MyDCvu721HJ6R9dz
	GNfHLWa0LM9cgQUZjXaFIoz+fK7KTE4V0FBLdUhL1IT2XcJRvyvnP0JcdSBJMkU7K9zPxA
	ws7xgX/sClGkZttstvZ8MrUcdWf4uyvop1q5FpbJYk+f1B1oHORFzzA3UQGJynjiqYyiwa
	0PKcoo43hMZXD8KMwSP8SFPTsOiX7yDg0DhNtSHAqQgF+oZYiImUCsM3+bondQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tianling Shen <cnsztl@gmail.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20251103010148.3855648-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251103010148.3855648-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] mtd: spinand: fmsh: remove QE bit for FM25S01A flash
Message-Id: <176216634975.908445.2776312239779833518.b4-ty@bootlin.com>
Date: Mon, 03 Nov 2025 11:39:09 +0100
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

On Mon, 03 Nov 2025 04:01:48 +0300, Mikhail Kshevetskiy wrote:
> According to datasheet (http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf)
> there is no QE (Quad Enable) bit for FM25S01A flash, so remove it.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: spinand: fmsh: remove QE bit for FM25S01A flash
      commit: a1d3bc606bf5c3b3ea811cc2019df6285d75b00f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


