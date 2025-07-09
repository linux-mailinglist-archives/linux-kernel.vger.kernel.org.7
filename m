Return-Path: <linux-kernel+bounces-723879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA3AFEBED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21A41888661
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F92E427B;
	Wed,  9 Jul 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Can1a5AL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176E17A586;
	Wed,  9 Jul 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071191; cv=none; b=qduOsGqk59wgrNhIeQ0GAHnT0p9IoznhYgWuljdjWpqT6opmxotb6FV5Bw39f3nV9IS8XpS+TPj+EV86RrWOsIh6CnaXQVhEbDBoZIsfqUip0VQ0f6p1+ZE8vG/aPaMJ8HroaLbEQeYCnYmAdlxgJKmJbhQNexU9y+Q1FkvE63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071191; c=relaxed/simple;
	bh=IJln6G3ZCu9vYhzKziG/cL2PCmTeVmdoUdECABOym3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGAWlf9PtrX68pOBpFk+q7IigE97ctcX+2WS0+WDtBv42LfqJdKX2X0WtJfpMzlyrfp96uTvLwsdUWIzqf3ny9obO4agNZbhqRYNf20JfYFwsZ/ePpz4oNgaQ3g5NBs+psEv1MVTNZdW5X+fON1IECOUcIdzeJ7+04FC+dmtT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Can1a5AL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb79177so31878255e9.0;
        Wed, 09 Jul 2025 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071188; x=1752675988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtytgNItlJgFy4oYQcn83LUARt7I0zsU6TFkZ3Z41Jc=;
        b=Can1a5ALBnQJLaWpRt/XroWTUuCO7IdJ09DHEH93hnzgLO2xKVsKgecvGpxdyZQMg7
         rSi20CWqj//ii03UWpVV1/DKzNK+NN+LZ/z1O1pgqGSI3y+QTr4kCPOOFdqWzyz3mf2v
         zgVJosoGcw0jbISzwhBGChUT/i6TFoFdMhsyCHbhuyczoemlP7eT3J3/wqZN+uZ3dbo+
         ckl1kYKL2AFmH7CA6taFk32vuYpD1pXcqQBEuBJ7lv6gLq3nVQHE6wGW0WmI/w8PaCZx
         mUGrjZJBeCrh7zlVXuFSNKT3utnhpzTgVo4MfBOFVWbH9J/7ba2EG5WH0ccXa/RIMn5U
         GCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071188; x=1752675988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtytgNItlJgFy4oYQcn83LUARt7I0zsU6TFkZ3Z41Jc=;
        b=wXXyORTix98EpPG4tdCaxP5vi8MDYEbpjUuiMHoy/TATIu14FTpnqkSsMam8J31fWT
         6Wy3DnRJC32Jwi3+ifWNYuuP0WQgtMoE+My95g5c1aAGgCwfcM9derFDG6QcYT3Zqe/Y
         tc5UVrCqeJGx5sL8a5uEFSaogs2mZKdSpVGjJgEOx/2WqawvvevfNzXU9LKqWpgBgcZP
         986j6ac4VVqupspIxESB+VWAw2CxC80qwNEJNk0lrHsYcZQMeSCSfGCzWNP7dbTIzWrR
         pbxosBFmjErymYDWIh17EUBuHNp9yPk1w2R522a5FCHK5uxboJEJSKNTCuFK34WFuhRo
         Wj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWx7qrO5l1OKwd8a0MHTo0szR+hQhm8/G8BeDG4usFcMl9tNnZ7aX/UYHFIDYEHieZWb/8pDeaVJH3KGsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXjPuqMr0VcpkQ/LQBnjf+KSfZ6+Baw6CnDlDa2aVTsyVMLnd
	XvqJvN+O6KokFKEFpQ9/GE5yPcpuqHFVu8LmCl+k0wNYlVDnr9O2kzpM
X-Gm-Gg: ASbGncs8hF6bZCGbFC+OxA28MkGoWkaHqKg+vTTaNOTrS9a8KeeLTmFPf2NjaZ6DzwG
	RDr+mEkzBzDe8EHPR8Taj7yZ0w0GXtYGFAWhqhak6BLUuz8O5WYygrjgDF/Ya4jvgSUE8FHqXfM
	ccQL28jNI/e23PX3U3uaYWlpU+qSD5G5Z9BpNqXb+n+IJQkP8s3UFrXOfwWVugZWMf/aX3ZrL0m
	UwxFdWTxU94qfDcRKs+RHMpXhv/mbMmFcqvkWZkNP05HF5TQy3pnfWKTMz3OE43cB6JjQ0ax0Bl
	98/yDn9u452B9Oy/7gU1IjRF90a8so34DMTmrWz4MnVQnEZ0HTBOQFG7ki6D
X-Google-Smtp-Source: AGHT+IFKMjL8yZjoTHKhlMwGjBnA9oWE7US7cP8cCvq33CCZA8+5Z7xIu2VBWIJ+Dut2TX5qYxxQ5A==
X-Received: by 2002:a05:600c:4f11:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-454d522d0d0mr29893125e9.0.1752071187906;
        Wed, 09 Jul 2025 07:26:27 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cdb31d21sm46723505e9.1.2025.07.09.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:26:27 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] irqchip/gic-v5: Fix spelling mistake "ouside" -> "outside"
Date: Wed,  9 Jul 2025 15:25:59 +0100
Message-ID: <20250709142559.2154255-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 340640fdbdf6..fd93796f1fce 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -902,7 +902,7 @@ static int gicv5_its_alloc_eventid(struct gicv5_its_dev *its_dev, msi_alloc_info
 		event_id_base = info->hwirq;
 
 		if (event_id_base >= its_dev->num_events) {
-			pr_err("EventID ouside of ITT range; cannot allocate an ITT entry!\n");
+			pr_err("EventID outside of ITT range; cannot allocate an ITT entry!\n");
 
 			return -EINVAL;
 		}
-- 
2.50.0


