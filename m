Return-Path: <linux-kernel+bounces-864644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A762BFB3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 464114EFF09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE653168E8;
	Wed, 22 Oct 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eP5M5GGL"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243E31AF22
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127025; cv=none; b=R5pZXsqHl51aWy91ZGw6FcE0AHtoT1mhxjC5HpD+E55l/qmYJhBCNiu/XtxLbZI3HpH0oPAWdArJNolS/Asquu5eG8R5Ky+p1UnP7H4M6zC77o7E7r2u8kaxzlNAlxkMbcZF6XvrHvIgiA0boENbvXKrRpoZ6IEbmq5YzxMb4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127025; c=relaxed/simple;
	bh=nt6rFu34cFP6DmABVZH+KQ7Lp53oOTkmxKitlAEptWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W9y91TZRpNQdY1SBiaLK/lpKgq2bFaZdg8cM9OQ2WmWZSLEgtgKBN8rX2aIEquebkGjJ3YRhO6P3sNnAs/HsDZDAKSsbL/48vmgsZKVIIJfiDduztmmX3/isXVjo6TvIrQRtyibDRwdluqVlNlTgAFHSDl7UpqVqDQE1c/VCFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eP5M5GGL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2C9CB4E41272
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:57:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01742606DC;
	Wed, 22 Oct 2025 09:57:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA887102F2393;
	Wed, 22 Oct 2025 11:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761127020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=py/joS4ENFAHsqOoPu+WZNHWvYMaLEPvguSi1YRJFBc=;
	b=eP5M5GGLDw4sy4SguHUspO5TJPrnKONLGwVSsYggCa/sFPBpbM/Zk3AjLZu4ZOfmdCepxx
	SSLSocst/EnqArvXljkzoIqHZFM3T1kn1E4SbQNHAHhKDiSMIOHRVaME1vyo/IwQhds+C/
	7qGbEpXtTIUfzxABEbpB+5+MJQoV0A9mkjaCxvlli0nxzomA9suYLEPhKjNlKlICvKSXix
	LFnWleMbAogkiWJpm1MAgu+ByEn5WITFHld6jHP1wbyVWwTPEGRmtvW1AxfeDrrRIdlyXo
	4qCup8lriEZXlKgjlohIYFmEjOv74CC40nkOQF+zbEkHkUDiDM2ZdcTmYSV/Yg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, Li Qiang <liqiang01@kylinos.cn>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020125333.3400488-1-liqiang01@kylinos.cn>
References: <20251020125333.3400488-1-liqiang01@kylinos.cn>
Subject: Re: [PATCH] mtd: rawnand: realtek: Make rtl_ecc_engine_ops const
Message-Id: <176112701869.140484.14078085027048590161.b4-ty@bootlin.com>
Date: Wed, 22 Oct 2025 11:56:58 +0200
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

On Mon, 20 Oct 2025 20:53:33 +0800, Li Qiang wrote:
> The rtl_ecc_engine_ops structure is only used to provide a set of
> callback functions and is never modified after initialization.
> Mark it as const so it can be placed in the read-only section, which
> improves safety and allows better compiler optimization.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: realtek: Make rtl_ecc_engine_ops const
      commit: 9631350885929819d4e46c6521df35960b472ef3

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


