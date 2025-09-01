Return-Path: <linux-kernel+bounces-794604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D23B3E3D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71F91A837F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE034142E83;
	Mon,  1 Sep 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RO+fFFwj"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA134A23
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731767; cv=none; b=ixTkBm463cTShGDp0FUCAXGAPEq5UAxoXSQ3NVIrdiyEaEY9Ep/sQ7qrt6x7UraZl4fL+UJnSq7pSTMj0i+B0F1cWZMZapDR48fvfxdl3ukBA85miUR1vFST6y9P/UEsEydnWvrXBiF5ypHiYS+aVg7idQtUC03tO8LXf1ak/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731767; c=relaxed/simple;
	bh=s/OGq76iO6Q3jCMQ8BjSgUHAVJZk5oASAjGKdkrTBvQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gw55OOoCJOZKId2dxYMyuKgo9PBxA5qJ2pfG5nfbq4zfyT6gQnNTKUFZHBEnY7PSCAj9HWrv0M8QF6HlnUGMWB2nDZQffHZowFYXvHK7mcFqg2FGx5eC7zNCB8ThL7NFbhZM2tbrSDccz3OnbScY6rublS8bbyIRbJgmWtFsLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RO+fFFwj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D6A174E40C64;
	Mon,  1 Sep 2025 13:02:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE40060699;
	Mon,  1 Sep 2025 13:02:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8046D1C22D736;
	Mon,  1 Sep 2025 15:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756731761; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=stw2sU2uMpeiDADUvOE5aA2pc/ewBdvRgUY7Re+j3kU=;
	b=RO+fFFwjn3Td3VlLsYNaOwXRszWa/IIL/dZDFZ0xJ1oAPXnAwx7hLdIYfc2jSG+Z6u5ksI
	pQFaj3MIHFM4AqjhXjc/LGi/zuBmp48ZGFTMuz/+4O92vkk8bYTPNVeJ1t0DHIeOguf/zU
	M/F2Vxxtxay+O7EzCtLPse2OTunBy1aYGEJwSwGF0SoM8LK8QEg3ku8KBQJ2TRqHcex3v2
	fv8u3x0QyjdiQuE8yleNaMXX//8OaJxnMHJ9pDQa7ey3dV14BBV7mdd2P6UvM7G2vWy+64
	o9TyOeELkAnXmoBbf4evxue67DF36hEtTixyTTW3w5iskv4R4RaipO/ljrvVFg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250830100637.14756-1-rongqianfeng@vivo.com>
References: <20250830100637.14756-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] mtd: rawnand: pl353: Use int type to store negative
 error codes
Message-Id: <175673175662.52409.8678310323858548486.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 15:02:36 +0200
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

On Sat, 30 Aug 2025 18:06:37 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int in pl35x_nand_probe() to store
> negative error codes or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: pl353: Use int type to store negative error codes
      commit: 8a9e097def55391273d3042b32350ded1ec83e04

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


