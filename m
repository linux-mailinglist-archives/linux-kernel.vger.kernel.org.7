Return-Path: <linux-kernel+bounces-816616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFFDB5764A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A151A22321
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1F2FCBE5;
	Mon, 15 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jgSUZmYA"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373332FC871
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932224; cv=none; b=Fydi9sAZH5icIofkat0ijz7lGNeXaWFppOR2aKbBGXG2nIJdF+IkxUGvlrctycZWEuoOKddiI8xZ+UV02+2HcwgqH4+WsHOKlLT/HloZDWGq3056kG9YhtWNsmFSfLNZU005L4QgvL+q0qD0+HaVihmgxYM0p5mFDG88IN9OIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932224; c=relaxed/simple;
	bh=VzHikG+F1ByOF4XLAXVXeTGENwr3I2zVnblhDSP1sTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZUynq1MDj73HS3GKMj2lqbDcck69mYtf9djapGfgUOFj0G5d0YulDeuaqsTjd3jml40PeWCVamJl4MmAOanK3f171SBEX3Q2hPuYbDKAR2IiDoLhjkvyjLNLjAjvLhQ7kmlAaDI/g+h13zy124eKmIUn2yzSGeEC48UyS6ijfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jgSUZmYA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9A8571A0E08;
	Mon, 15 Sep 2025 10:30:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B1066063F;
	Mon, 15 Sep 2025 10:30:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D8E5102F2AA2;
	Mon, 15 Sep 2025 12:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757932219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iPMXjGf/3WKBSmAeqhAwH5Gjgp7eQens8v19HHHicY8=;
	b=jgSUZmYAIUpvTa2nKGPW196s058zYfff0lioEFxiPPV+gvCqfvpkvYAKyvt5eCbnHiw7Cj
	J6X5ykpmMRgCeFyER+ZVbRZoyqvjtXJE61BfvjyZqZLYiGFmRMuxIO2It1VTWQK+vSdB5U
	iJsGWAQp5bg8zn15s23efloWV2Wzbx5cKOkAUjWDa+ZoZ81ADLUYHOpMreiDqlAmNRGYhU
	JjgMSdCLzXX0+MqiDnjeKmCijEIs+cyqRhwVyNGXZI6h5+aUctzOOrgSljyH/KvzEQbMOV
	UEm+9qNBprKmOvFFqyXPA9yVikddsA2lRAodwGD15OKqjq4W2oaWsqUm/vstVw==
Date: Mon, 15 Sep 2025 12:30:10 +0200
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
Subject: Re: [PATCH v8 0/3] drm/bridge: debugfs: show refcount and list
 removed bridges
Message-ID: <20250915123010.18fd21f9@booty>
In-Reply-To: <20250915-celadon-dalmatian-of-defense-ca56fb@penduick>
References: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
	<20250915-celadon-dalmatian-of-defense-ca56fb@penduick>
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

On Mon, 15 Sep 2025 10:13:16 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> Once the minor issue I've reported is fixed,
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Ok, thanks!

v9 sent.

Note that this series depends on [0] which is waiting for discussion to
continue, so any feedback on drm_for_each_bridge_in_chain_scoped()
would be very welcome to unlock both this and other series from being
applied/sent.

[0]
https://lore.kernel.org/all/20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

