Return-Path: <linux-kernel+bounces-768705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F999B26466
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9B5A73E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E02F39D9;
	Thu, 14 Aug 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rax3Cdkx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBE2BE63A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171336; cv=none; b=cSZz8hBsx5OScyfxw0sp7zDJwuvZ9SRL3ACEOVwLYySmYsHkxjO7urpJ2yP6NgOKYE/0zwqAReTjDuv06Fu0D8G6m+q93K60Ge+uaI95fu4D4YBa1E+LzYSsW+AjK1ZSsFKD78bqkGDRTsiam4qWFKzlL8N+GdhxZHMKXXcPURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171336; c=relaxed/simple;
	bh=oAeS0EJJGwOXrfgbyFuwVTWL5LQPF7lrVpzF2MZIZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyUaugYjXnrJt7C62PxvwTs7xEqOvnzrw5INPD9T/PrzJ199GmGU6lcNO8Fjzad3uk69FMhaZQ8NTYq2DliA589hMLF1jVnHIVGKhoPPubofMMSXKH3nxMuB53Ipq5ghZq50efKSdJ96OBLaaj005yQUrx1vOwJKDEqxUz9XKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rax3Cdkx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=yeZ0QOI7MSkm018DLlLIOpBpxLpIe0Ad2O7gJoYLZVk=; b=rax3CdkxDTNsJWkPrVCDb1v4Hh
	SKbMy9iqy3wjH+tHbDldmOL6N4uKb4qvYQMM2eF5VyKsf/Mrg84Dbl3eP987XtpJ0E49gOo8KWNWr
	oThaUbnA7CJbl5H9X60NVe2vG/LKe4fdNqD3tkExUB6k7JZ69way/P31+ISmbWyKd3OTbW2z2Zosy
	gMJ5jc1wLuWbXdbh4URQzvZmZ14ZZsqHfE3kgr5RVRqPXarJUH3Yu/5GfByjaj3SnMJrP0p2WaNxN
	jmov/P/dNNZJ6jyvS0h0PERmRzcUt8MyaQvnR29Exx14N9zqrkKvszDn2X+X0Xe5BU/lK3rs30z2R
	nk/DGxkg==;
Received: from i53875b38.versanet.de ([83.135.91.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1umWEz-0003Km-1F; Thu, 14 Aug 2025 13:35:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 0/2] Rocket Kconfig fixes
Date: Thu, 14 Aug 2025 13:35:17 +0200
Message-ID: <20250814113519.1551855-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More common indentation and depending on the actual accel framework.

Heiko Stuebner (2):
  accel/rocket: Fix indentation of Kconfig entry
  accel/rocket: Depend on DRM_ACCEL not just DRM

 drivers/accel/rocket/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.47.2


