Return-Path: <linux-kernel+bounces-841045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FE4BB616C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E1F19C6279
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E192248A8;
	Fri,  3 Oct 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FLZDeuZr"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7E1DDA18
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475012; cv=none; b=g2sBKJ9upgg6rgaNDRdeZ5x6d3PLp+hoX0dF1sAcVhsdmvNw2vLWMZtmmNQHkE/Kafrmt4AHxtHWrl1N+aXBOvgc4b+0Hqy8+hszsVUzv3cvv3pgiMTMRw8pqT1oQmCzBtk92SInf8eaFnfMWXSdynQ/nH5+M+ZCHNSXGrY/0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475012; c=relaxed/simple;
	bh=ONvPkekoLQ7JZ4mjnmibSrto9ZO3I/neg3PRwTM/4K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WagBHSA/4oUptNKLKwk8FWqUPe+tlIkdsgdPJM1z7JxM1elOaVEwb/gEba3dZZKCLQ1wwyxyToAJHjehFL1MyNntzVwZdEr2biPocfTodT5841zzAoXrHzx+crxV7jkhkuFvOe+s7PIPi/Q2CF6JJHKl71n6YZ1hGxNTmvjg/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FLZDeuZr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BEDBB1A10A2;
	Fri,  3 Oct 2025 07:03:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F47E606EB;
	Fri,  3 Oct 2025 07:03:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 587A2102F1C21;
	Fri,  3 Oct 2025 09:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759474998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vh6CT0iScwUmc4jIsyFUPA4yrvhCBOQ2xae+8uqnwZ8=;
	b=FLZDeuZrbiKk047v6a3B8s/r4E+39AqQTO+heJ0JsNjgaj1LBLWoEkdvyR4rdgNydHlhui
	yN0vGudvW1/rSTv6OYL0Tub3FG/7Nw/BDk+F+8atPN+wPUp3F7J4O4RvWXAFpiwB8e3X8f
	uIKmWQNB/xv0853xP1D5kH43OaLl1evKrbRSZSbiakxCeXZKZR3o1sYk7zriEZED4dNVzs
	OH9u7PoQpOIOc4u8WlGCnqHKd8E4Wrkazvh7BKOxpUzuwMrcmH+Ch9rvIxbm/86U7iBeZ8
	N13AQ1uNOXmfBqsx8Egq6hFGEGKB8nfZWOgbFcd7BnRA7jyOzwr8LErtuuXgsQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
References: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
Subject: Re: [PATCH v2] drm/display: bridge_connector: get/put the stored
 bridges
Message-Id: <175947498405.453288.14017869194720551047.b4-ty@bootlin.com>
Date: Fri, 03 Oct 2025 09:03:04 +0200
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


On Fri, 26 Sep 2025 16:59:40 +0200, Luca Ceresoli wrote:
> drm_bridge_connector_init() takes eight pointers to various bridges, some
> of which can be identical, and stores them in pointers inside struct
> drm_bridge_connector. Get a reference to each of the taken bridges and put
> it on cleanup.
> 
> This is tricky because the pointers are currently stored directly in the
> drm_bridge_connector in the loop, but there is no nice and clean way to put
> those pointers on error return paths. To overcome this, store all pointers
> in temporary local variables with a cleanup action, and only on success
> copy them into struct drm_bridge_connector (getting another ref while
> copying).
> 
> [...]

Applied, thanks!

[1/1] drm/display: bridge_connector: get/put the stored bridges
      commit: 2be300f9a0b6f6b0ae2a90be97e558ec0535be54

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


