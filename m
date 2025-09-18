Return-Path: <linux-kernel+bounces-783713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66037B3318F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95CF202A81
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F971F4C83;
	Sun, 24 Aug 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2QYZ761s"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E527472
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054998; cv=none; b=PxQQRy6FsAcNUyiVjVR6k4mTVU8+UeUFdjpGcJjuH6tjnyXXYScYzWlwH6krsGeOdJ+jKjwoFufdFgVcqdSwhCd6gWexer9A/gad5ZLhW9zDn3JWQJllYdQ01F/i2M5TsZCJOWnaeCd8+rCWl+PVWTX74Ae2F0tW0RnbR7sAVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054998; c=relaxed/simple;
	bh=xNPtHqPQ8EbTfGPaocAYn2ghUhDePyzcdAsyJIsfodQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eo9OCE6HacteR3GJWAMcjTAC0atj2vBEDPmW8RduHQS3KYfpeholeLUQimdl17MQajHK3E9BQZCfjCzO3wkpBoXM/j05SSfIRxVfTRUwZRf2x+3rUArIOvymFkWMEMXxXbdGv15gC9pFJRQ4N/ucUXrPx3+JGFB2LpZmQTzVaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2QYZ761s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8B2E01A0DA4;
	Sun, 24 Aug 2025 17:03:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 558BB605F1;
	Sun, 24 Aug 2025 17:03:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9145F1C228A5B;
	Sun, 24 Aug 2025 19:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756054990; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HzrQ8UsauV0uUlBYYQNKljD4+gLMnEGKsLGyhjx5bAE=;
	b=2QYZ761sM6UEzTwDs7IDwJ1Mhr0mMkKFYPkGknyM6LPizE1YHI2TEhcVYBPBlHRTbwspo5
	j0ypVgVv0Jv974DCPhBwnI337qtdAFX/8FvCZWCYRy+AKPVoMdAmrxxTwHSPTI7TfucYGi
	oMx5z/qpOCYEXcWSNO5CLDufO36f6MCz5JZvgtTIkuoxhqNoZNOqFBZLhrd9XIEz6rC6oL
	fFuNyF3jm7jitetwI+KSz4Xb3lYvjk4KtJz6J3ERyswHNkTpe2KhEULFRwcCxMCe5Fuhv3
	HlMCJzMOG40NdhBM6H+RIxCxVrDrc5X3CagXUQXyEOQm3I8gaM+uU5bZJkqX6Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>,  richard@nod.at,  vigneshr@ti.com,
  tudor.ambarus@linaro.org,  pratyush@kernel.org,  mwalle@kernel.org,
  p-mantena@ti.com,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  a-dutta@ti.com,  u-kumar1@ti.com,  praneeth@ti.com
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk> (Mark
	Brown's message of "Wed, 13 Aug 2025 21:26:06 +0100")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com>
	<6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 19:02:56 +0200
Message-ID: <87cy8khcu7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 13/08/2025 at 21:26:06 +01, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Aug 12, 2025 at 01:02:10AM +0530, Santhosh Kumar K wrote:
>> From: Pratyush Yadav <pratyush@kernel.org>
>>=20
>> Some controllers like the Cadence OSPI controller need to perform a
>> tuning sequence to operate at high data rates. Tuning is needs to happen
>> once the device is switched to appropriate mode (say 8S-8S-8S or
>> 8D-8D-8D). Add a hook that spi-mem client devices can call in order to t=
une
>> the controller to operate in a given mode and data rate.
>>=20
>> This is somewhat similar to eMMC/SD tuning for higher speed modes like
>> HS200, but there isn't a standard specification around the same though.
>
> Should we have something that blocks these tuning required modes without
> the appropriate tuning, and/or allows discovery of which modes require
> this tuning?  This all feels very landmineish - client drivers just have
> to know when tuning is required.

The maximum bus frequency will tell whether tuning is relevant or not I
guess.

In the case of the Cadence controller, the bus speed is key to determine
whether calibration should happen or not because when PHY calibration is
enabled, the SPI bus frequency is equal to the controller clock rate
(pre-scalers are bypassed).

So the criteria for enabling calibration is:

   max SPI bus freq >=3D  min controller clock rate

Thanks,
Miqu=C3=A8l

