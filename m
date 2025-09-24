Return-Path: <linux-kernel+bounces-830858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B6B9ABA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5612188F61A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98102313D72;
	Wed, 24 Sep 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="FIBZ7e5c"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B14311C21;
	Wed, 24 Sep 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728281; cv=none; b=cmW+Y/l4V2cUlDhVxrmN3z/mzb9Xk0ZztCKIvuYsy0yDlTe2oucR1xRh0Nuc6ksg8FApsFteCowsm7DU4X+RfQQw5A/4jqQXiQPGj32sWNm46ZnSuBrR94bbZ2mY6VzKcgkNdSHVvEDWp9LNcUSf6KEsJuKbFz8DoTMSsw5a1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728281; c=relaxed/simple;
	bh=YOxbARnHKi+YR7TPmZakIQ7broJCGgGzgpN+9ltjhnI=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=BWO/7CwhftvT8x/FSmhqWVOzmI8L5yMlJzUdt/Nt/mOyJZMangMcv6xRgCriw+AXIRp6hzKUZfT7cAHT8WgTe5hLu2ccQhD8l/A7ZbsjGPiW6VeCp/yJ9USBMoRhyxoJJyNFvKg2x87QhJCzbtsERb359eN6aOFaZUwMUcZ3qE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=FIBZ7e5c; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=xjNEZuUrgC4c7iseOVbtKtXxfPTu9XyKtO4Uq7U9UnY=; b=FIBZ7e5c7IB9BJaInOHCrt/7my
	vbKiH1SBSOUXFic7KeTPty/2yquK2JChmE4CdMue0X+kKtBVemnfmvI5V3HSN+6ErDHJuMVfpvu8x
	93DFUHTnGyCSSDGqaWK2Eo4F886aSzjE4wIIa8A2/QY2Z2fjb0vWS/GkzFw7qVsbOX4s=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ7-0000RT-Qw; Wed, 24 Sep 2025 11:37:58 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:36 -0400
Message-Id: <20250924153740.806444-12-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 11/15] serial: sc16is7xx: remove empty line
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Remove empty line inavertently added in commit d5078509c8b0
("serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()").

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index d1a9fa26e9bdb..a05be92f7e776 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -834,7 +834,6 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
 	bool keep_polling;
-
 	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
 
 	do {
-- 
2.39.5


