Return-Path: <linux-kernel+bounces-835893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DBBA845F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80643A636D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26B2110E;
	Mon, 29 Sep 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="a1cXoq6Z"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A12BEFF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131625; cv=none; b=B9IBrTDEpVqa1eoEYoej+NDlK0MQAB7zS4KPrpeBDMPoCbwPTK9TXTu2zY68rT5NNnr6w4KxGd6GSSYkourYJU/GQ7oS6tPyax9VHn5+lxQ5LCyzLxbwaICqqAp8fDdZJGZfOi5Xbld4wUT1VDD98UeoSR4q8Cn5zBC+Ir6A4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131625; c=relaxed/simple;
	bh=nTVLu6HRStigDf35mD0TwtdRpuX5zhrpVgWRDpJDcuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljjZ8CWzwj8awZ2+kU1CL44mvcMwi+rTDN1ZtzaqSTsCpXbDdpbRsCs5wCxDw8VC3y+CsjwN+nuukawA25ssSs/4EOoiqYei8eQ6pfRH0E5AxQHOFXs3BcDAb7IggrclnpooqAqkP8IfRyniZLQ0QjBsByJtP9Me1DSxoKzXhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=a1cXoq6Z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eWtjtgE3MNBidfCJnv7Azf6KY0WsY7zw5FAkEO/IemY=; b=a1cXoq6ZvYVxFcexN621PYWVPF
	YInZnzyETfl+yK0b39ClXkmFmx3Ky02juyIJGgMO2UfimNtsAlVcEzrbcX+kic8nAFvTOrm3CQd5Q
	hNkT5Fw+7wKqXUQRLg1MtOoIE++tWUyGZK1idSQvtk04n6ZNfpZVCnzq8pAgn35hh274U9P3knXXB
	oDw/SgomEi+GgQQgxBEGmOEJ9LOrhd7Tm1fd4xUtRdLU/ttGNqLWDa1d7KREAc8ecgBmm8RQ6lD0/
	9cwrzkCSnyMCsldM5pdE/X59wvbzZepEFIf6WT6MhDb71YQpEw5JPIMzmzU1OzbxUNCNVNus6oSqQ
	iji8mTVg==;
Received: from [49.36.69.57] (helo=uajain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v38US-001btd-E5; Mon, 29 Sep 2025 09:40:09 +0200
From: Umang Jain <uajain@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Shannon Nelson <sln@onemain.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Umang Jain <uajain@igalia.com>
Subject: [PATCH] MAINTAINERS, .mailmap: Update Umang's email address
Date: Mon, 29 Sep 2025 13:10:24 +0530
Message-ID: <20250929074025.84407-1-uajain@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Map my new professional email address in .mailmap and also update
the IMX283 driver entry with the same.

At the same time, update my role to a reviewer for the IMX283 driver.

Signed-off-by: Umang Jain <uajain@igalia.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 8db24be50158..de9ba882c5d1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -796,6 +796,7 @@ Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko.ursulin@onelan.co.uk>
 Tvrtko Ursulin <tursulin@ursulin.net> <tvrtko@ursulin.net>
 Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
 Tzung-Bi Shih <tzungbi@kernel.org> <tzungbi@google.com>
+Umang Jain <uajain@igalia.com> <umang.jain@ideasonboard.com>
 Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <u.kleine-koenig@baylibre.com> <ukleinek@baylibre.com>
 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 97d958c945e4..48cceec759b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23497,7 +23497,7 @@ F:	drivers/media/i2c/imx274.c
 
 SONY IMX283 SENSOR DRIVER
 M:	Kieran Bingham <kieran.bingham@ideasonboard.com>
-M:	Umang Jain <umang.jain@ideasonboard.com>
+R:	Umang Jain <uajain@igalia.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media.git
-- 
2.50.1


