Return-Path: <linux-kernel+bounces-834432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E269BA4ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7444F626241
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53F2FC039;
	Fri, 26 Sep 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YUmd4+fr"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECA26B2DA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904652; cv=none; b=PeBjtnP+V/YHNWsLtuiG4FVFQvyphdRsLHHeKVcgLDhxQ1oaEsc/dVvu3siswtOeygPqYIPoU1p7Jtohx3g/T5oUtpD8WicuYGoIxr4VeWi7DWpm8HsKjadGMeO30Bkn/YsoDhtYEQWcVRntq1TM3sILsNAEMYcautvm7bx9SLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904652; c=relaxed/simple;
	bh=K/hxZiNPV/mcPTPv3DWebolJWqa3PcxbFTDwaJ59lm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoUisrXVitTXwslg3gqofAA38cnGBzo8WELhW4PJXwFHd8V9y44E+5h3l1OWp7OvsSdyf+VwtrEum6ZRglCpVaIVz7c/0OzsGuVUUobNGG3y6l5SWxJ/yeCACV8J34gOLnl8kCH3e/ab5awqDrAa7Fqm+C/Xqz00t1BjRXSmmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YUmd4+fr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9BC584E40E10;
	Fri, 26 Sep 2025 16:37:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BEB2606B5;
	Fri, 26 Sep 2025 16:37:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B7C7102F1829;
	Fri, 26 Sep 2025 18:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758904647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T1eiJCTJ6hVPTGuj8KbihOiPvUVNoT41QjPfSexdEuU=;
	b=YUmd4+frzkFLYYweqAUp2rj0oGFqAqrP8nWBzvm27hW7BqWCWt+iOFK2tV/G6RUgx08OKK
	7BAOPGoAgleRRoRfLEk2wtw7lGTsm7UMjBJXcIkddxIZcylMThwhFGYak0OvEhUdBzXBtI
	xaftiTFrwD2CeJJbtR+FUdX7knjxHIiMVST0PEhsJiVAsKqhu4pWChqCZZ5EmTuk75A0XA
	cHFJ6713SmhoUOzsT17ZRlUrtfpT0xB16M+A+b9JRskpll2wvI7ela5hB8vQF4AlHymeGE
	wf7Q3b/AQGXb+8jaUtypT9NDvQYFmClTzCFDCL4qbjAzahvxruzHytFeDbE0sw==
Date: Fri, 26 Sep 2025 18:37:22 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
Message-ID: <20250926183722.0f449251@booty>
In-Reply-To: <20250915165156.35378299@booty>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
	<20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
	<l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
	<20250820131302.6a2da5ef@booty>
	<20250827-charming-arcane-stingray-cfb8b6@houat>
	<20250908154906.16693078@booty>
	<20250910-glittering-serval-of-piety-b32844@houat>
	<20250910184752.6c42f004@booty>
	<20250915-benign-rare-marmot-9fbb96@penduick>
	<20250915165156.35378299@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

On Mon, 15 Sep 2025 16:51:56 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> I'm going to send soon a v2 with my devres changes so we can continue
> this discussion on actual code.

v2 sent, with the devres changes. Discussion con continue there.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

