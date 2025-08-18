Return-Path: <linux-kernel+bounces-774290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F42B2B0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A231886A39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1137272E43;
	Mon, 18 Aug 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Yxxn+Ail"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3E1F12E0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543224; cv=none; b=FOpxy+xvYxXHL1TF9U8v7RK5m9VFqJzVzMj0J39nER3aBAF0CFEd/4kHwxYZ3XB9TPUpL+T1NEPhdEC+dex6jA4b6fW/i9IUXM3mhrXTm53Be5NHEoU0tMqs+ugf5zu/N9UZMN0bY+Ko2NM5ULHrlghWaSgXre8WVW0BcqIP3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543224; c=relaxed/simple;
	bh=hfKZTkfnbFzC18am4vGt10nj5Ammqmw/prlcK7meDXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSKTLDT8wSb+DzczHiccfQfjn7Gec6/B5CJHb4NXfSGNNT/TevJJn6OV1+HUej5+osnleAG7gRQNVvXQWrW1sO2H96FK+wk/1sYFD5A1YbtDCOLfPGrBShHfVDcp0slBmzedQ1FahK1SU9d3T3wXZF0Yl44tl2BtuDpTliwDvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Yxxn+Ail; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=v67FTl7/3pAGnT117jwj1Kky+Zn0Dzi8FyiIKcG5uNU=; b=Yxxn+AilLBgCshk+YlYiGfJLN4
	t7GbOGRxzt4fcIGb+pKqyKn9YLzRstci8FqVlkEMv83nJNmgjQIuQBCn6oYkxfR491cpfGypQhUTW
	pXNmCi64Ut1Y831/QZbzdhbYl6yK2cz2WbfAjPutWccMJroFSNu1oyJv7V+9dQX+T0bzYCmHnEWkM
	yKjt42lziFUTd0TjOo9oCl5OIoDMIC9F4d8D8Kva4o8Y77vhwAUCRFyfN+0mTpDb5RozJfX7ifudq
	nzHwM47yiQu3wZuHQ8TJIPmq6dONr6hvnDjB4vQGNmFjT51rjxwhiisQcUDGbQn3cZZnsCA1+Ry/W
	erBEfEEQ==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo4zE-0000jH-Hn; Mon, 18 Aug 2025 20:53:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Describe the nvmem provided by the Qnap MCU
Date: Mon, 18 Aug 2025 20:53:35 +0200
Message-ID: <20250818185337.2584590-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the nvmem-cells found inside the MCU of Qnap RK3568-based NAS
devices. And move the cpu thermal node to its correct position.


Heiko Stuebner (2):
  arm64: dts: rockchip: move cpu_thermal node to the correct position
  arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433

 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 158 ++++++++++++------
 1 file changed, 110 insertions(+), 48 deletions(-)

-- 
2.47.2


