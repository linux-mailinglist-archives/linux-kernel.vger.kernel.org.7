Return-Path: <linux-kernel+bounces-887676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07EC38DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1391A25251
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F717C21E;
	Thu,  6 Nov 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwakF7d3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0623D7C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395869; cv=none; b=QaiVzO5VclVOdMKVJrXyIiosPqSekdQKBTBx5Nau5oND+ZU08qQP2RJMpUM3d1RAWGlSbq+kY1AFp+elrXYoXjDz7IMeu7vuOpfJkK2c3zFPSLj6T02+tPgkCi+17cqUCkoXm52QPwKnByCer0BrPJU++PXaFAaloOadFbfTv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395869; c=relaxed/simple;
	bh=GWioAa/HgKfztWuwH96e7QbbpPMk5PfvPdRvxZmAORI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvwZNt0L1bbGhbQmM9YZt5go88gDSeuihpuHGHGUpOwyv46MIMbO3Z/QRfMNmc6BzucWmndagEb3eu1m7DU3jJ+k5Y3A592nUFRKt5vJGZKrWUlxxGEUedmrzx/1NH2FQyYFSePSGCFkbpvxCDWJV7q0N2XWAXCcxTwFYNnj99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwakF7d3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28a5b8b12a1so5249285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395865; x=1763000665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMEWMetexcI+STkq+hwuSVo2b3x2WsR206J4SHSMQSs=;
        b=bwakF7d3zZVzwO6AEzbOsdGdnS9CaPkOowGUVJ0hQYeKIGKY3xkY0DeIA9zjR1tko2
         +Yaw6z+6WDTgQXJCC38mCgwvSXGFkMx9pydKBOkIyvC67p2CBjZSK9Rocwzk34c2CEL8
         XLRSR0FGbWVKrtZs+WWY/CS45JiQAkxFC6VoccrwoEZQQEUWN4jBZetJza3sP359lNMz
         vaLZIoVOaIij3tlyMAF29KSezhKeeyvnmia8pw7PUDXdWtH4tXrU+Zyn8PIBij794HU4
         0wxQhWF598olfRC3IA1AyGDr8u33x+bMAOJLfsgJSARVGJ+ShEkPRvtkMaqsPi7Vg89K
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395865; x=1763000665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMEWMetexcI+STkq+hwuSVo2b3x2WsR206J4SHSMQSs=;
        b=oNEOUsiarIZEXJc5eWxPd99L3q3+YDki0WF3oVgu5YbEgAMMFrR/L0bSAv0h4JQwxI
         nq7bpRytcgHer0f01zw/Fz0QVvkfbYL0J7K/bzkDJ5aoTWXuaQtyX2a6PThO/uEx2bO4
         3ntsAwXa0mhD+r2HQyFFrcIc2mxbzswVi7u3HmGHexT1qPUcCTx8JZ3r3//YMfqM8i6g
         H97yKcnSme8lDuNWDUXMj6PgT+JRbUb72sYWkAlgcHPTfbdZ4f45X9RiXt6pD4Ncblye
         CmOhbpM/BmXXTClDW4tvq30hl6SDrRF7gtoPkGSz+EzhOeBBmAelKJwqPC/vggNoZr34
         7a0g==
X-Forwarded-Encrypted: i=1; AJvYcCVh5EY779UihRMQtPRrafiMknadKGsQ61Kx4KXahIrEy+saNvPIe4F0LPFkjqtTNIgTH29Nxmo9OhY8/gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyIY5CV3y3YNKSYXvJAt9daibw890LpxfRuN9Zvf+dd6JSYZO
	AloJYmyswJanfTuLveI0OTOcfQnAjTlkXVsOe1qqwdM0z6B/QY2nNild
X-Gm-Gg: ASbGncum3va9YOdcIo9g6DL3PcTno2sCDBoGXp8fa0eIjWQgzJsPYvZmRSXPfpCxiHk
	8Pq130RldrNqir27ua9kFCXnplEi4CBQ5THG/BT/dJGi3AJH8n36gt4lAZEZVluqHpJxgv4rF+a
	4gEo6E2I60l/ZbL9ZB+EhqAcdHv76Z/sF/6OHAAd7prIjQgiaXLGKcHIVyTm8Y1CfsQWaRHDD0I
	88SuaxtFxAlegwwhNUCwL3sxvKIXnuKTed8kGnuk7ILfLLkF+R586X3nbc67g6KVY9joUsEdp50
	xiouxBU3MQ3us0VIIDF5QIkW8v7j2Z7QoseEYiU8oefM0Dx0x7rNycoRDvWXlVD9mjD31aqhl1j
	rUpinQki0JBZzFjCwm8wfq7qW/bV2ZqKI3Uxu6OWGJaRLg+o=
X-Google-Smtp-Source: AGHT+IENNM4E7OUgvdk01D8ULNDZQyF8NWNscTrYBkmBG5cFCwDSrn2aDfQaeI7APGPNpdLQZG7HDw==
X-Received: by 2002:a17:903:1447:b0:295:4d97:8503 with SMTP id d9443c01a7336-2962ada67bcmr70131855ad.30.1762395864661;
        Wed, 05 Nov 2025 18:24:24 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 1/2] dmaengine: at_hdmac: fix formats under 64-bit
Date: Wed,  5 Nov 2025 18:24:04 -0800
Message-ID: <20251106022405.85604-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022405.85604-1-rosenp@gmail.com>
References: <20251106022405.85604-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

size_t formats under 32-bit evaluate to the same thing and GCC does not
warn against it. Not the case with 64-bit.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 2d147712cbc6..7d226453961f 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -887,7 +887,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 	first = xt->sgl;
 
 	dev_info(chan2dev(chan),
-		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
+		 "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
 		xt->frame_size, flags);
 
@@ -1174,7 +1174,7 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 	int			i;
 	int			ret;
 
-	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
+	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%x f0x%lx\n", __func__,
 		 value, sg_len, flags);
 
 	if (unlikely(!sgl || !sg_len)) {
@@ -1503,7 +1503,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		i;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
+	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
 			&buf_addr,
 			periods, buf_len, period_len);
-- 
2.51.2


