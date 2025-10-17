Return-Path: <linux-kernel+bounces-858422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68BBEAB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772075A7B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C042BE64A;
	Fri, 17 Oct 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IwxTMPHP"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A72BE043
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717876; cv=none; b=lO2uQKw1sa71rJ7xRgQQNsUBaWJPlNEj6JWUcb9WzW2I5dLytNRqT4yUANep8tNMv47ZtKX3jN/v8JbOSRyoJ52R+8ZRAhKAY3xzxS6Z4pdWFcMmF1/2/ujlAgAJ6QivxkAfBpnzLbYX7wS4JNsk7aCF2IvwuZe1agLO2VmQKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717876; c=relaxed/simple;
	bh=1P1bwBTWzLOJltHycHFOccxdgbEub2QWko/CziZANik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=thrqsYGwlsrhXidYV9LUV80OTE6Nusbsysi4Bs345lFwcYLbn1w1n4UXfmyL0KghZtAOZfGSAco6UiMK1TIBQ6wqnMAk/mEJJ6+vex9Co6RGkgZCFOpzKGW1mTvpg8FZa4LPDfMoLVXWENhx7aCiOc0bANbarAGRVIkWNfJA0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IwxTMPHP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56DB71A1483;
	Fri, 17 Oct 2025 16:17:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2646B606DB;
	Fri, 17 Oct 2025 16:17:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC7E4102F235B;
	Fri, 17 Oct 2025 18:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717872; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1P1bwBTWzLOJltHycHFOccxdgbEub2QWko/CziZANik=;
	b=IwxTMPHPI3n3K92jlFcSRgmV1VK3liXEyKuYGmdF0ACyvkl7bxD1ytXgfgRfPDxTRm4mml
	Pwk7ZNXgWtBe190lFcEmo74e1VwNhD1SGFM8GVpZOuQhcmomxhNsSbJwi+HlsCkWqrnD6Y
	TXsoo5R1DXCmw3PRMuOON0AQ7G0iUzYcG5nL0pkmNZVjJTCPN0a5OaYU8nIuN+a8EO4Wo1
	N+0g7Ldh6iwZFjheo/xftDr4cRsB61nvbO8/4mF08pO3098Y1nJsEuanYU6M661SV/dmpt
	uwt8Tk7npYIV9KVv0gj19Q9L3kdaolfM5YEhMSA9g+ym28E/aLpHIK5JIiyvaw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 18:17:45 +0200
Message-Id: <DDKQE4TIEXYJ.12G2WBT0R8UE4@bootlin.com>
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "drm/display: bridge_connector: get/put the
 stored bridges"
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1
References: <20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com>
In-Reply-To: <20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Thu Oct 16, 2025 at 4:53 PM CEST, Luca Ceresoli wrote:
> This reverts commit 2be300f9a0b6f6b0ae2a90be97e558ec0535be54.
>
> The commit being reverted moved all the bridge_connector->bridge_*
> assignments to just before the final successful return in order to handle
> the bridge refcounting in a clean way.
>
> This introduced a bug, because a bit before the successful return
> drmm_connector_hdmi_cec_register() is called, which calls funcs->init()
> which is drm_bridge_connector_hdmi_cec_init() which needs
> bridge_connector->bridge_hdmi_cec to be set.
>
> The reported bug may be fixed in a relatively simple way, but other simil=
ar
> patterns are potentially present, so just revert the offending commit. A
> different approach will be implemented.
>
> Fixes: 2be300f9a0b6 ("drm/display: bridge_connector: get/put the stored b=
ridges")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/336fbfdd-c424-490e-b5d1-8ee84043dc80@=
samsung.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=3DAe5pCW=
+eU41Bu=3DD7th2g@mail.gmail.com
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Please ignore this series. I have sent v2 with this exact same patch, plus
two patches re-adding the reverted feature without the same bug:

https://lore.kernel.org/lkml/20251017-drm-bridge-alloc-getput-bridge-connec=
tor-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

