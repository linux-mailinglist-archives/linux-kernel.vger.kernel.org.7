Return-Path: <linux-kernel+bounces-809715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C4B51113
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87C41C22214
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5730E0DB;
	Wed, 10 Sep 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AnGEIp5s"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA930EF8B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492585; cv=none; b=STY3ysj7FFwffL9gZAqte4ZoZTzWoO9jd3/JZvaXBl09nSrm7tILaIWsawrhNFuEpi6X+mxV5vSImyv1gNUgPyB9Yec6gMAyhAI7XSFp93kZdLxfvHo8fe2VZzmgXczq7PtX/xOIdXG3+aB82flhGMAcLcZwMdoG0cz19uuKlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492585; c=relaxed/simple;
	bh=T0yNhc18zYNuNulOcICqSWpaAIz3X2aSm9T5lCLhhLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/jzFKxaHvW2ZfCUMgqMSJxtu6IrsNpAYQ/4dEcgoAofwi0k2CzPUSRtQ63I0OopZXJZfbZRWtKQ4/RY/CEf56iXrW+wtLyhVWzVLKmk4hxMLRFlfatA4KsfMa//LWBrQUiLMhXLwD37R+FJ9gN114E8GpVc4OGs7Y/z/wks/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AnGEIp5s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9E25F4E40BDB;
	Wed, 10 Sep 2025 08:23:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F800606D4;
	Wed, 10 Sep 2025 08:23:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AC01102F27F8;
	Wed, 10 Sep 2025 10:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757492580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uPtwrxmb+q15X+Rr+SGmHDti4RfzxURNrhT61iklzME=;
	b=AnGEIp5s3yTQrYIX+AsJqyo8xFiXuGzmoM12VMjqzEmGmuuOCUJswNZ5NYMJ5/yUW0wEpv
	ZkTAM2qcwcxeB8rdSNUzMXckkzVPW1PLMGECnW9as7SnUMGMnKCdwiv6W+hFS5cR2GP8I6
	hLKyxdTy/xq+jY7w5C8H27Bpe7JrBrvgGISu9v2+YzBJjSw4KIl0HjsknGWqAPFQbtbjW9
	Yuor8MOVoSbGVEmGDMeZHErJZ+DtaqXnpdIWnpatVWaXqIpddjytr4ZSFDonaTRH6rpsRt
	WsSKyuAyPb783Im8JxYOP5cPtBkFwhVXrHxcdgI1KNYSTNnQDcp2OiiPgzvcPA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: vigneshr@ti.com, Xichao Zhao <zhao.xichao@vivo.com>
Cc: richard@nod.at, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250909020635.381570-1-zhao.xichao@vivo.com>
References: <20250909020635.381570-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] mtd: nand: ecc: fix "writen"->"written"
Message-Id: <175749257495.456366.1102196333138664773.b4-ty@bootlin.com>
Date: Wed, 10 Sep 2025 10:22:54 +0200
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

On Tue, 09 Sep 2025 10:06:35 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: nand: ecc: fix "writen"->"written"
      commit: dfea8f7183c711f2bf6af7aaef2a07e30b36a367

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


