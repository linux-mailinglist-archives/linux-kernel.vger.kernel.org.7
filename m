Return-Path: <linux-kernel+bounces-794516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2292B3E2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873B3177166
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163F338F4F;
	Mon,  1 Sep 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U+LMqe9i"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED6335BD5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729575; cv=none; b=Sh59gsAR9J7ZyFl0LO/eY3Fu3LrB0i2RZCp2mw2lFttIX0DJPTK/vnE8xwEsmaxauS0TzfPnV89+5b8vzvBn4RKmXCxJQnmiGcmhzfWvAvt6szsConKLPsQKQlhhkLc2s6s64MoKCd+CMAE6Bf0j9kZYCs6KBrCbSy+Qo11zsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729575; c=relaxed/simple;
	bh=hLjJGmG6MrPn/CYDlKFXDmYflhqZFNetvMfN1FLlxjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=txvRy+XF2WCd/qivgrKg2iOgWTjCCt0dx+KkjNkRvvwE1nE9QVdcud+bdtvIkr2OCZw5trQ7lM1ura6y8QMXTGH8c/9VDk3OndG+mPy3bgo9G/IAYAtQ2/Vs2xy2ETvWJwze9FrwImZ3LdbWqKX6hNtd9tv7FBQzAdRGkOLAEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U+LMqe9i; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2EB244E40C64;
	Mon,  1 Sep 2025 12:26:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 044AD60699;
	Mon,  1 Sep 2025 12:26:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6D601C22DA15;
	Mon,  1 Sep 2025 14:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YCqaE2ySIm63FisMTJw+SXZ6ZQeQnKmc9VEQeBOhYn0=;
	b=U+LMqe9iV+Swgehee0pXcKAhLo0/LDdrz1Ai5aPoKhYqOroiF2TWliFgjrp26Ht9lomvJT
	hwss5BxWG1+miMipU3yEWy9H7QbaMG//0xxedQ5AJbsVzl+Lxz/HYXc4vLx5gbhAgweuGu
	YxFA59FUOIB47sxOqKaQhs05cRqnn8ZH8qA1y2qrpJOGBRGVs4koV42imwxQmIiSBDool3
	0MjNgHxADWyLSpvVQPviodq7pTETuyYX7vfTN28+T4sVOW/t9H9NfBQx8CN/QzjsMBv0lA
	12PzWREHJWSLnv9raIOvD1iErCrWX0urZXxWTolgapgCfFZH5abDQ86SHur1UQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tomas Winkler <tomasw@gmail.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>, 
 Raag Jadav <raag.jadav@intel.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mtd@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <def775b1d7afe43720d2a1778735e764a01cb017.1753950712.git.geert+renesas@glider.be>
References: <def775b1d7afe43720d2a1778735e764a01cb017.1753950712.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2] mtd: MTD_INTEL_DG should depend on DRM_I915 or
 DRM_XE
Message-Id: <175672956260.48300.15057365027365895620.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:26:02 +0200
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

On Thu, 31 Jul 2025 10:35:14 +0200, Geert Uytterhoeven wrote:
> Intel Discrete Graphics non-volatile memory is only present on Intel
> discrete graphics devices, and its auxiliary device is instantiated by
> the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
> and DRM_XE, to prevent asking the user about this driver when
> configuring a kernel without Intel graphics support.
> 
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
      commit: f544bf03a771ee746b908e9a08ecb97c65a35055

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


