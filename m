Return-Path: <linux-kernel+bounces-840246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F7BB3EED
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB163AAE32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547431076C;
	Thu,  2 Oct 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8dLD5dw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D230DED4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409264; cv=none; b=RCJ/KRHopilTYp+w2EF7dz1mxfVAvHidoFuB56TjieXs4z6E2a+DQM5Fhy1VpeMQMaxgP8RFTtuVb55RkB1bRJnJYLVkk+6Bl2+6q2SL9eF9GGCM5yRRkAZix+/8AZ6pfGJvrZOB0Y4gn/10ZVFnhwwFTBmO4alysTkDyDh/n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409264; c=relaxed/simple;
	bh=hyCU+EM5MVqp2Ncmpf7/x1Fq6EYDnoCdRL4dsEkWNw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qp7TbcWIcg6qAfP9hpxrqJuJ+iW5hGtPwPjk9BuigM7AbTG/KmZ4lFPvA9iyrhqWAaVQnQyz3eRcF0Mr8hAPI4a5IoHwc2UNTuzm6r9EbjLItxE2eVeINhoMnVadooQ6ieBOA2e4sWjSSfoQIbofslrQFLB5Xl12I/p7GvW+5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8dLD5dw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e5980471eso5047995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409261; x=1760014061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET4ihU5LqsfIrlbYUc19Lai41MLJqMKOlTXkrUOUnQU=;
        b=i8dLD5dwe8nGG09ze/WTvKMjI872cwhtOzII5+iJ0WGFP835a339ZhY16vJlcN1Uka
         CmuD7KGrOF0VLOEaLakxYahtl8rxCyF9DS83WSxaaqcr6q23YzuDdNWPbCILkFsMsz1u
         Fblm6DJHKQAzIaszN5CS4oKjI7YR+fZa7p3DczDTXRKh4uRfa3ZXQb5dkNfpgE2mWCTa
         sbO1AqTSO7rtZS4N0hPq8yahRC9frX+SlhK9WDjGKDJto/+8X6mmTgTwuWzAeafC4A8D
         bRM5sJ3yxrC3uATMo/l/y1DAvTNV7z/yJQN1IQKDEUJCvC7FzJ2f1WBIoX06v43Ny5bo
         w13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409261; x=1760014061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET4ihU5LqsfIrlbYUc19Lai41MLJqMKOlTXkrUOUnQU=;
        b=iLBdtc8y9KagfJD8so6KwB4BYnK/+M2bjzlNfcJ2sCjCBmGe7p+GUoEyPF0Wo992dW
         1p6G5mof3FL+pJmlZwVFi5UTlWc+WbRDbb/TC+uoc4dkGl6NbAArTXRi715yMpCIChpX
         TZRClWcE84+RxAjs6AtEHZQzUrE2BkheaOfGFLHMuS56DsysO5oOFaRibQQWp/afVrGL
         9egkjCc1+65bbNzFgspoyhmryDq+7PK3iPnH6z0RFHusHdX1+CRwwp48HP+xCGh5zr0I
         VulizuJMXrrBq4pAWxeDnu5l+0ikDx3O53hXkBpg3PZ93fuzEnGK4dned6kofLV/hpzO
         onMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+mvVd8eYYxuojSBs5w1dVSJGSAl1f5aKa37LF6VivFjJQjHitdGcjl4mKX8yTor4t8H2oXUuWVbpT2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKa4wc94zxyfOnZLzMXe5oziYMBifScWescGYxeUO+atAXU0o
	qP4P5pYc1F+fEgogwR8cLrYg5eirJSROWB1jreIvFvbPSsQEDzO7x9s9
X-Gm-Gg: ASbGncvYN+mNZ8KM1/cp7J1ybozHGN/dQxinvMsCmlpYrUqi3LQaojhcLxEBuNXg/0J
	OM+p6+il2JI5ZMqmXDtyB3oRP7O72muM7f1ZBfV7tCRa8iovxkebAxvxTG09B9rVbjyVdMaclRu
	mMEScyt0bx2UduRB8Z0KIEZqQjGy1AQkmFASV4N12lhIoH9qr+22BovPgay0qj6B+33o1B5b/3P
	0EZDctEv991lX2tI/RbFoVhy0Of1qu31hSgQmlDtww6fh/UoinJYVHFB1bO44SLZ8WxSlC7yf1j
	qft74UFzUU9r+Y9en/3Gg/9YAvPNRrcTlXfnSRnXUL6jjwxrFIShJgOUgCZGfTGVAzK9ndnSaxL
	681x4fIEpZQ8aovM5WDz/02SzYoZanCB9CBIWdkyWEaOTuOwzoxvYmE9I0kb69IOZwirGodU/1p
	xYvGZiaZPerLWkspA=
X-Google-Smtp-Source: AGHT+IG14FNYlyj1SOve2+lpdu6yCG10mUv6KZ7dieXzI0BdMzJSkDE4fwEUuAUNod2k7Ird6LY+WA==
X-Received: by 2002:a05:600c:314a:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46e61285328mr58217715e9.25.1759409261152;
        Thu, 02 Oct 2025 05:47:41 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:607d:d8e6:591c:c858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6917a731sm34541085e9.3.2025.10.02.05.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:47:40 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L dependency
Date: Thu,  2 Oct 2025 13:47:35 +0100
Message-ID: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ DMA controller is used across multiple Renesas SoCs, not only
RZ/A1 (R7S72100) and RZ/G2L. Limiting the build to these SoCs prevents
enabling the driver on newer platforms such as RZ/V2H(P) and RZ/V2N.

Replace the ARCH_R7S72100 || ARCH_RZG2L dependency with ARCH_RENESAS so
the driver can be built for all Renesas SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8184d475a49a..a16c7e83bd14 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -50,7 +50,7 @@ config RENESAS_USB_DMAC
 
 config RZ_DMAC
 	tristate "Renesas RZ DMA Controller"
-	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.51.0


