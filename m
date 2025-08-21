Return-Path: <linux-kernel+bounces-779213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E638B2F081
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E436EA01937
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238E12EA168;
	Thu, 21 Aug 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ue0uQc6g"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC72E9ED7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763435; cv=none; b=k43wDyVvFNHzvxHL65CpGg8bk9dwif04T3GagPIEYMXOwCERJ/x3tXRGrw9iP0re2uo/UZdVIZUQ8JD3r9m0oKHt1prQdh2dys/kG7izW6YS4Bd9d8+ruhhza8DY/BqAKzuIyz/ZN4KgDgKSCZtkvaX5q0GdawdIg4KIV4aNdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763435; c=relaxed/simple;
	bh=UgZqJPI03azHfavD3Y+z6reHEnmYzpFLbpmicXpKdUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoqZZxC6/wm1vfl1yW/5szsK+w8eC/oU4m6r1bNwHecgqTHjXNPH1kvHD2l9qhFmhwANGLA2SzBXR4hgrEXmdNXMFa+c4sQMJB8O0qe3kPbzFTwlJpa1dl1o2yugbbBAEPRKYXRnnm0P0S7/RgUE0n/kiKnA1DN+1231aZ4GQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ue0uQc6g; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c44dfa7739so177395f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755763432; x=1756368232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XjehKGt2s9Iw0S60/WJtSyoiI8bGy2dbzPpshFFO9Q=;
        b=Ue0uQc6gMYDbCbCxfNRlT8vnqxxtmV2bCMvUb1Fh3Q+BHQf2uZg4axVRjvTQdmxYTH
         EP1T+6Cbd65juppz89cycqCVXYglTsV7cA88xU1zsy9ABai90IKkN0ryuZixMrlhYB+H
         qd9NRG0FN8bb0lRHd5Xr6zY2BsI/4iV95sSsLPhKl8wUTxZ+9Kq3u8YQ6me4+LVRfvtm
         GmO9kuZb1a3qT5GY1ZhUAdtzqbwQaS00nFmxtDZK5HP9cDuM/gkzqjq5iab059oKIH8J
         3ShP7oMDmusYkSmcP3jc+bfWLUMd2UzK0McpWpvQo4r8ojkfbw8iPitsxEJMD/MyWvmv
         2J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763432; x=1756368232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XjehKGt2s9Iw0S60/WJtSyoiI8bGy2dbzPpshFFO9Q=;
        b=EUtFlPOJabEecsXHCgn+0b3PIKtXikonHgr/7lFSXuxFO2m8yhCmex+VWSATycshOC
         vOYsyAs3xxRSukY/A8x+E2RQdJRBr+BYIdFZRZnAbNs+d5Vo92YnUcYSPhLt6hLny5jm
         b0lrlW4b9rm7vVoVv4NEM5vkWKAd4CIOkoXAbaWHNXMhP2hxYq6T0nia5gdN0roatRX9
         Ozr1tUVy/Kg02HttirMctW8p7btIqrcmSob+TQmMNhvKczKLmTEMH7hdVUX489u+LOFS
         1fcfr/s3+tDe6QpdQVjnN0Zxfl4m1N98o3arHF3u0DXDn+BryoVINmXjnTRI89IrfyZn
         zO3A==
X-Forwarded-Encrypted: i=1; AJvYcCWIPy8vwzRdSqhT6xckwUBJ5o2Ai24F3zqL1qTzWWLSNZr8ImdLVvrNO7l0FOPaDanzFxUV92G1gkPTp1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDyKJwdv4Ipgef2WSU3vn06WEnF/XvzODv2U5Xi54rgs0M3zg
	/sD1LXsYh5gxM/RncuWL+TVs8QW+TQS29iA6xeSzcYztZ07uTup7HcMECvsTnNVs6Pg=
X-Gm-Gg: ASbGnct2omY4ioVjU6uhlsnO+WfoEa1cbfk5TF0s66yJU8ehev8dOc3UMV7QUtRPVOH
	71tfO8SHR9Qzhk10I55HN3PQvYUfOXzFjiQXhd/sSmYxU1jQqQpeAoMTjY6mK6e8Y7ohfZOF7Z5
	4Ymn7PbGuxzcRrJrecEHe9ocA2PKan/FRk5ov0poHwmR1pOd80mjqe1KRVpLaTzn+5K39oparlA
	yv9C62kunsoGoGUmNGI5UcS+jZw9g7n4bdb3tBulSJXbNK1iB42hHTi5mLe2i6w8L0OmzvuYZ2m
	x4lEodlAtMAJ+HGXoMdv767iWYo47FMbC6JQw0JKNMHTDuOrHFsng5sdtRvzuoB2Imkkbtmrf34
	4bwrZsPlbDzL1pB+Fm0qhoG7auUclYCX7OCev422U+IkAIVGkG3w=
X-Google-Smtp-Source: AGHT+IHc431XLCYaF8pLi9lptfBNKV1wKndQFd3h8KySRGUYBaDuLZGptDhbLDqZIqPusEPqY1JIQg==
X-Received: by 2002:a5d:5f56:0:b0:3c4:9c59:52e2 with SMTP id ffacd0b85a97d-3c4aec25ae2mr1116773f8f.7.1755763431534;
        Thu, 21 Aug 2025 01:03:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4dc155b8sm17356225e9.19.2025.08.21.01.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:03:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	linux@armlinux.org.uk
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] clk: Export clk_disable_unused()
Date: Thu, 21 Aug 2025 11:03:31 +0300
Message-ID: <20250821080333.27049-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC has a suspend mode where power to most components is
turned off and RAM is switched to self-refresh. Resuming from this
low-power mode is done with the help of the bootloader. During resume, the
bootloader re-enables the clocks for the modules needed in the resume
process (e.g. SDHI or serial). After that, control is passed to Linux.

If Linux has not probed a driver for one of the modules enabled by the
bootloader, or if the module was previously in a runtime-suspended state,
the corresponding clocks remain enabled after resume, even though they have
no consumers or they were previously disabled.

To avoid keeping these clocks enabled unnecessarily, make the
clk_disable_unused() function available to other drivers. Drivers can then
call it during resume to disable any unused clocks.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk.c   |  9 +++++----
 include/linux/clk.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155..5278030b0ad8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1460,7 +1460,7 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static void clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
@@ -1485,7 +1485,7 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	}
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static void clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
@@ -1526,7 +1526,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 		clk_core_disable_unprepare(core->parent);
 }
 
-static bool clk_ignore_unused __initdata;
+static bool clk_ignore_unused;
 static int __init clk_ignore_unused_setup(char *__unused)
 {
 	clk_ignore_unused = true;
@@ -1534,7 +1534,7 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int __init clk_disable_unused(void)
+int clk_disable_unused(void)
 {
 	struct clk_core *core;
 	int ret;
@@ -1574,6 +1574,7 @@ static int __init clk_disable_unused(void)
 	return 0;
 }
 late_initcall_sync(clk_disable_unused);
+EXPORT_SYMBOL_GPL(clk_disable_unused);
 
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b607482ca77e..7eb0e5eb9aba 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -950,6 +950,13 @@ int clk_save_context(void);
  */
 void clk_restore_context(void);
 
+/**
+ * clk_disable_unused - disable unused clocks
+ *
+ * Disable unused clocks at boot or resume time.
+ */
+int clk_disable_unused(void);
+
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -1136,6 +1143,11 @@ static inline int clk_save_context(void)
 
 static inline void clk_restore_context(void) {}
 
+static inline int clk_disbale_unused(void)
+{
+	return 0;
+}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
2.43.0


