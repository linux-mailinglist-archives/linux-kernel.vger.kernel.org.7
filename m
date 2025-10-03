Return-Path: <linux-kernel+bounces-841055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A04BB6256
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E471AE055A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179622DFB5;
	Fri,  3 Oct 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pFMvjqIT"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8B1A3165
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475486; cv=none; b=OdsoZBLc6IPJRRUc11b8ZE2PvkXzJFbXop3C6LLP7EJYdxETyKNb+7nGpIlN15AWjccTH3wthnppDHikZAVHUZGbD9uf9i6qiycEmuVgDRc+RZ3yiW3s0FVBsoALAIRKmYpp71zZb8HnN9D8Icatg3W+fsOLU2hefe71fEaUtl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475486; c=relaxed/simple;
	bh=I9yaqZSz6I7o0ASsdM5s2cRjfXDEebFgA2FnWWUXjWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qZ7SvxPDUTIfhdCAd3qNVDDkw65853UGopBCG+/qYVwDMBQUR9EVRZJdidSaeUAmIZZbhht051G2kMlYeUZHF1IiwvKFQxC+0sApJ4Zz6t1riPt75ygZ7gS/u9P4yN3X7VgFWJNXnLg2axvVwqnr25WJZu5DpDv1CMi0vASBOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pFMvjqIT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EF3A71A10A2;
	Fri,  3 Oct 2025 07:11:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C30EA606EB;
	Fri,  3 Oct 2025 07:11:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB78C102F1C04;
	Fri,  3 Oct 2025 09:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759475478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GBWWiR//EQGy7wU3r/D2KO4EkutCKxZsEaDltcQpM4g=;
	b=pFMvjqITUMPW427SBAfWge/eWzYs7aqJJgZBofTJyUd5r+r4JYbTvYNlq05gcaK+2Jktby
	UwAf27c5upeCs+eyQi8Oz8jEionMsV+tAQNpj321jvP7YcZqW403A5NF9uQ3eE6xTTwQy0
	AXSfCTQm97VRW9QJsDGjU0VbunCTHG/lajEZ4kFq7yAH6luhIoKpwpTWdwPGPn3+zWHv4h
	nDra7NgnJu3LEg9rQQMuDOqy4K271eKw+anm/rvKJpDCNX7I0EHUZacsiW41dPbBEMkYJy
	YvKIqHNd5OReDg2mmEWQM5cn9weV/sHmM568shRdg4ixDLlRAzlUHOJJGZD/Lg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-v1-1-f8c2efdb783f@bootlin.com>
References: <20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-v1-1-f8c2efdb783f@bootlin.com>
Subject: Re: [PATCH] drm/bridge: refcount last_bridge in
 drm_atomic_bridge_chain_select_bus_fmts()
Message-Id: <175947547459.489455.4866603213884120000.b4-ty@bootlin.com>
Date: Fri, 03 Oct 2025 09:11:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Wed, 24 Sep 2025 17:11:01 +0200, Luca Ceresoli wrote:
> Get a reference for the last_bridge when it is obtained and release it
> using a cleanup action.
> 
> 

Applied, thanks!

[1/1] drm/bridge: refcount last_bridge in drm_atomic_bridge_chain_select_bus_fmts()
      commit: 0f2efbe6d8305b91c9b2c92ebaf8c24a614bc305

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


