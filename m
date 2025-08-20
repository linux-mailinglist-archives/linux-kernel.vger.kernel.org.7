Return-Path: <linux-kernel+bounces-777322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E99B2D821
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6053A178DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C034D2E3398;
	Wed, 20 Aug 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoTUgo5w"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF520DD72
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681477; cv=none; b=rsEAY9XqkXD0/GcBJTUElRBjn6IQD+iNW6S7xAySrBfDbputoAadv2JIDB2ObMwqXsU4zKRBIVXJIy7xFgpPvLoH/za8WN8k0ffGT0R/vJPHZ10SH9D/iwLpdh6VDHD+iBwmKdD6vnvtjcXEUTCJ02ywBk9M0MjTpceI5Kp4bfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681477; c=relaxed/simple;
	bh=+tB4d5fGLkP9g785WDsSKgQcYGqFp2KAd1Bg3gafh4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kohHMF/pP2aYS4M/gg0Toq/wNVO6LQU5thN3VD3dz9d3TxouR0pdK5+19XANFh1Du80PP71oc/5zDpcn55j7CkTPYhFeiNffZ+R9LulanyM1W2PZr2MtQqCoch0dB9ca9fns2IFG1EeyJXqQQt7QzIFXv9tEoYNFPCzXozbvbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoTUgo5w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e614b84so5934289b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681475; x=1756286275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G00NT5pas9FVxfpi/YHK4+QU1mZOvDUuJ8JX4w/lRcs=;
        b=DoTUgo5w/aSPO41X5TYdjSUm2BL+l246v98PmtphKjejEC4XcTJWoQ8AsobLTZ+bgl
         rlIsHuQXpeeAmmrUhPHYENe2wiDXuEvxDRWPWVCqYHcwWkTLHlDXBprEaLyHA64Ci2fe
         JePKA1XfLaynayBnok0K7AC0aud8sRz6SE9H17J6BNbNR/b+UNv3m7A/Y5/DpYTgCIXF
         ACZzPPSjUEEc4TV32rugK0dEy06eQBfiXiCxsZY9Eacxnbj+EQ7abv5FkEidEaaBJs67
         sQ2t3tu8GF1wQHE/P89ygZF879xCbkJ26ItdbMVUp+DwLpIsrc8xlJ58JhO8EZsG1kTe
         oUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681475; x=1756286275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G00NT5pas9FVxfpi/YHK4+QU1mZOvDUuJ8JX4w/lRcs=;
        b=FSae+rZJhggU2HEs23RR8D784mbBHjuO8zMS0mREs5SB+p8hz7p2KldcWkfvCKhwQH
         dC5MIE/+2AeWkz98GXItMpwiV+4wJjSbfosKoX4nbcOBKM9lJp36fNq/UF66OjdQmeox
         hZ7HCCFjS2OHI87FXKoShczG2vgE+ckThwnwKqRp7Te5cN0KCqpsFQ9+oEbFfPPJZLCR
         mpeJH2zMrKR/loF7cl9TWv0E+ukr5Q8NAKWnw+5VoyRIrN9eCERxo91MXlTL8fNvq7gk
         vxEXWpL03EmwyS8vtrxA52vMxlOckaDoMhLIhS8ytAJoGej7L9u39cpCEskuTkgOYODX
         R3LA==
X-Gm-Message-State: AOJu0YxcpVRRVjhCRaQw9BZjxBdxbrg6NdU5tdOrRQfG7J6XnsA7bu1u
	uzZ+beV3slfpYe2/N1r0J4H8re+pZFN1O2V4WAGnxqMDIpUU0RYDTAAX
X-Gm-Gg: ASbGncu3YN5zQ5R+aMtjAzJ4cw8llcITofyhXx6PUPf8vY8iXYoxwJ6P8SH7y0rNDOw
	GFxxMY66iszS67bQC+/g3T+xFR6rkw4BHzuh7sgqCHBDGywI+qOEnG3VvAUWvaYBhIi2G8SViQp
	0v/y8mAFM+zve4is79r9xmOVz/vbTk7XNlXVwIsLaNVpRtqb/Je6Eu/fogMJEEGaYACkzLOWLO1
	3MyT4XypmEbQHJkx2KtrfwDjveZjtOn2JlrOGstuRgbAiDTnqsk0o7TlaFIk8oA4FxKEbs4MRmQ
	xopl7ZpOx0N9n8ImUVbhk/ckQxzPCQ4PrWWH843Qr7jDqsDli7MJgFgGVCGG6sdEjlyYPBqY0RY
	cZjFdUHZOevBOwU3hyb6SBXtMlu1FJ4q7hJQ413s8KssHt/QHfai7o3QpjYiB1Qd1ct9iMly0lw
	mEBh4c
X-Google-Smtp-Source: AGHT+IGOR5Vu8SFDfzs4mluiIbxSZrocnw8V5a3HX19eJmEhZo3vU0L/czN9icYY3dyCTFpVJe2OsA==
X-Received: by 2002:aa7:8893:0:b0:76e:885a:c343 with SMTP id d2e1a72fcca58-76e8dd2579dmr2679388b3a.25.1755681475040;
        Wed, 20 Aug 2025 02:17:55 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:54 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	wangjinchao600@gmail.com,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com
Subject: [PATCH 6/9] printk/nbcon: use panic_on_this_cpu() helper
Date: Wed, 20 Aug 2025 17:14:51 +0800
Message-ID: <20250820091702.512524-7-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-6-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nbcon_context_try_acquire() compared
panic_cpu directly with smp_processor_id().
This open-coded check is now provided by
panic_on_this_cpu().

Switch to panic_on_this_cpu() to simplify
the code and improve readability.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/nbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..7490865e2f44 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
+#include "linux/panic.h"
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/console.h>
@@ -589,7 +590,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  */
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacquire)
 {
-	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state cur;
 	int err;
@@ -614,7 +614,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacqu
 	/* Acquire succeeded. */
 
 	/* Assign the appropriate buffer for this context. */
-	if (atomic_read(&panic_cpu) == cpu)
+	if (panic_on_this_cpu())
 		ctxt->pbufs = &panic_nbcon_pbufs;
 	else
 		ctxt->pbufs = con->pbufs;
-- 
2.43.0


