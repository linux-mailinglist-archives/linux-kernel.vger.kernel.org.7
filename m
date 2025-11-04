Return-Path: <linux-kernel+bounces-884618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B34C30977
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF93F18C1851
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68A2D9499;
	Tue,  4 Nov 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yhd1zxS+"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55C2D3221
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253361; cv=none; b=dJU+htzYX3eAAvFG4Seh53TN4gSA2XZn3YORVVftFkOZlc2T1RDG6DbIPFwnzQNc7XVjZm/VoY0SD17JgAb9pmEZT1LUShH/ejOXk+B1f3Ih89tnFdFwEK45mm59yYQXx/vYGwQRMFgk4YScAQO3DVJD4f5uNocx/Ok4dxp0bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253361; c=relaxed/simple;
	bh=b0BzzEG91TswTEXmzbYZVFA9oLh7/AzirHzn30K/PzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A8AoXKM/vl24YNJUIceRau2KoQrW+6kdA8WlkyiWChgN6XGv9A8KP0wKr5b5YakKjs3ey7cmIhb4EjHV04ZPB3kakNq6tTMVoT9hICDrTB17Yfi5vQHzbG3z8oej4j5usGP4V//lcwWw3R1txgq1lKjuPXq2yiM0y0IV6UZqTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yhd1zxS+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E3972C0E608;
	Tue,  4 Nov 2025 10:48:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5127606EF;
	Tue,  4 Nov 2025 10:49:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D477D10B50BDE;
	Tue,  4 Nov 2025 11:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762253357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9I3vy0iA37ZZNq9rWs96vtcIs4h7b1D8KsBmAVcjis4=;
	b=Yhd1zxS+6ZDfh4/Tb+QML8+c9q8VCHLOLBGY6ShFepYAhmIdF+arb/sK2tWC9H755aMImn
	oHVrAYxAjDEw+/KyvRGEcgw1wuIsDy+QciFyw5fpQvS0yzxhV24ItMfLNjNOrJLYcJjtsd
	+P1zo5wKjmZPiULRG74V6vYT2g8z26QOYkyqJD4eNgkWNdSSdnLWlQgfD8wx734R9cVgYd
	fawujTKNzYYdvrgkI1dWiwfuVFHlPQKCYwVvXJ3rHurYu3c5rDZ+sfVmcHPPNow3aPsfT+
	j0p1AIUvY4ihpgW9WK43d+nY1oJ8u1ik6tYqApMKFRMwvHNRieSiIuhjMxY7BQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aPtfy2jCI_kb3Df7@stanley.mountain>
References: <aPtfy2jCI_kb3Df7@stanley.mountain>
Subject: Re: [PATCH next] drm/vkms: Fix use after frees on error paths
Message-Id: <176225335371.410618.7512653404131520222.b4-ty@bootlin.com>
Date: Tue, 04 Nov 2025 11:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 24 Oct 2025 14:15:23 +0300, Dan Carpenter wrote:
> These error paths free a pointer and then dereference it on the next line
> to get the error code.  Save the error code first and then free the
> memory.
> 
> 

Applied, thanks!

[1/1] drm/vkms: Fix use after frees on error paths
      commit: f9e46acc172138a472ffb3bf0270a0b156a77411

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


