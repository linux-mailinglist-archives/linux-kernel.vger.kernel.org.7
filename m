Return-Path: <linux-kernel+bounces-853518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1EFBDBE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD70B189C3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29021E51EB;
	Wed, 15 Oct 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="F7A5E9bw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA614F125
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487065; cv=pass; b=V9dNyx9XCqzsilmOtYwQQoPXncty9N/H4Gz+CVtnU3HPLQgJmND6lkecmtSSDZydMZsrBtqu7N9ju4hxgudg73f27LxKSzFErJkPkIox7vhMimB5BBCxjy5dI8wRk/B1X8j8MZzFHZTKWQKD6JpDuFzD4y97CVA5Twz9E1QcZ5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487065; c=relaxed/simple;
	bh=Um/mh3m65U8LMJMFC4tdJWXaZ3DyXX+Q+hkbFqw5S/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEZPQdy3doRTmoKnFmvRYNROHuhbt52N4jy79Lle7puoZMGSjb+jMqdAwnIfzAv02FMhuJpGHHXxVII5y8FMQbb9dFgXl+qGyTlAG3UuQrAyBpHgyvGSCIPjf6R8Qm7b/BBLGMCdFivJvtUQFagKjpZ0CzbR49Y+EzYp+fqhv0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=F7A5E9bw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QJhxPP6q8ZuOoSArUQzvAgg/NXVLBSCxzo/c4Dh629U4Dbf9paoiBUsxbWdpl1jqh4bOhCTwjeSTfTQxMNCV+lPhEkC7s9UqRjDx0YKJtAKstTaEZHfpBsSfeu9KxUjKTHLoeO5zA4An1305xKHX1hFmI2kMoHNRgiAxBar0lDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487053; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UZ+A9WMJwgRfHDkTOF9I+28XT7q9CSJ9rtZIwAZGtvE=; 
	b=Iixk9HCSfHj7EgI6FoloYywDc+Pg2UEdhYseAnZEAUa6BxqjvQ79kNm8qgzk0+p4sAj+oNf44ANnnWoqFZR2KqC7b+bK86nWcSitUSD5VMZdn/U5BsqIFWpYQsDIh4zPyCYpGy95gJLQfYT5uKjZvBcX/aR8nXOkHy3/VNl7moc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487053;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UZ+A9WMJwgRfHDkTOF9I+28XT7q9CSJ9rtZIwAZGtvE=;
	b=F7A5E9bwXt+gwhS4lAYvcqrt19tH264pJ2uVpFuQ9Olbl1DPywXsM9nmoCJf4XHA
	EDb25J7S/OYyUJwfVUUAEYLRjHmf8/ueZq99uZ0qb0Dm/TZ8DyVdSt8O8TGb7uszEJG
	yPMtNhJwXFNZCJ6ap7UaWWHMognkQQVcmc34wpBg=
Received: by mx.zohomail.com with SMTPS id 1760487052275419.86855804746517;
	Tue, 14 Oct 2025 17:10:52 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v6 12/12] MAINTAINERS: Panfrost: Add Steven Price and Adrian Larumbe
Date: Wed, 15 Oct 2025 01:09:18 +0100
Message-ID: <20251015000930.356073-13-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Recast Steven Price as Panfrost driver maintainer.
Also add Adrian Larumbe in the same role.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88e7672c1d41..b04f7191164a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2092,7 +2092,8 @@ F:	drivers/gpu/drm/arm/display/komeda/
 ARM MALI PANFROST DRM DRIVER
 M:	Boris Brezillon <boris.brezillon@collabora.com>
 M:	Rob Herring <robh@kernel.org>
-R:	Steven Price <steven.price@arm.com>
+M:	Steven Price <steven.price@arm.com>
+M:	Adrián Larumbe <adrian.larumbe@collabora.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.51.0


