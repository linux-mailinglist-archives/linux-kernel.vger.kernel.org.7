Return-Path: <linux-kernel+bounces-726493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7CBB00DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCEC1CA49EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DB302CA7;
	Thu, 10 Jul 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHptntDJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFD2FEE02
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181934; cv=none; b=bXfcADiml84fSLbe+WX9X+4JwDBs19Mtbk63wGGHsEqvg+W190A029swsATsOFhE5sORQK+v96kTfAN4f/mrhg/Rw64hBgnNQb4zMSLEI0uiXz/pujeMtVyaHdJPjwOadQCSgdOrikRAINijGA+HN+HJL627QCorsEIrqcpBaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181934; c=relaxed/simple;
	bh=v3hdhBOHK0qUhvNSpx+BtyoEKUPgUNG99ieRMqbb8UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGxfAY1DsdUBZ5G5qjedSN/bV28IDJmzsu5I/eIWbOGBZxBvgW27vOcJnTGgRQ2y+zSXISG6VJGP5FmtI/06P6AckukN1t7U1UIzhVHoEBLnwvVObcqBgtj0h09JshkxMh5yZvj1LrLhAU3sexM/YVQTmbLmAeQSn33r5wxSg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHptntDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtfKlLhcG/kkS8hkYuoUj/IIA4KAh790Vr1OByvwXU8=;
	b=GHptntDJX6gB+32f2FdFp2NXEGIKigJSEBHRkWUTrfzLWAYs3yLnTupOLptTWVGmSekfqF
	s23nW2avELyVuT/NSy4kfG/xmzmnbO+Piq5QUTXIo0RL+5SeFSCFduVT7Wehy0ckAV3PLD
	isjp7DSxbqI7U3KozIXV1HUt4z07VKs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-cbKdIV8hNP-AwaTGOEet7A-1; Thu, 10 Jul 2025 17:12:09 -0400
X-MC-Unique: cbKdIV8hNP-AwaTGOEet7A-1
X-Mimecast-MFC-AGG-ID: cbKdIV8hNP-AwaTGOEet7A_1752181928
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234a102faa3so10457815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181928; x=1752786728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtfKlLhcG/kkS8hkYuoUj/IIA4KAh790Vr1OByvwXU8=;
        b=RGNNNb93rZUl7d6gisIW/Tv48WoMBVBvOhI7qnqVChs0sIrJo1/SigaN2wjsGTPlJi
         Gnt3ItSoLDmoj+54ypjUK1CQeG97sLz3B3bn6Q/tyhK6+yjfTyA1DUykKn6YKtbw/62Z
         LDNPvEOLFigFCPItHOz5uE3fUPM9eaLzUjoeJvVEFk2I4k+Etj3uttrJv6IXIB8pAe18
         ba8nu/4sZBpL8BmW/Q2MyF7BcKIhxzBvvnZdIkcAW9GwcoAtyUtIZmiTkToH7dtaOw9K
         PbUsXe9DiUehYHdGrVJrnP18zPUBzhrnyoZcB3heBQO6oGllLmtXvIyCK8FzmHLJfsre
         JwlA==
X-Forwarded-Encrypted: i=1; AJvYcCW0EBE9poOixZfQ47OMI7kusJjonIjthKolIN6Do4VSyFeHP9D/Syx2+RiPXyS5sbIsz5DZaGWvo5KrH7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD6p0BnhIXPMWx58LrDYHbw2ktB5oyoJFL7j4CUVvmN5qDXB9
	Hi4lq1EZ6WSSAQlRAzP7whYxNxPdDa4EHiDZZ97KTkaepeWsNq6y2OmMaawMcQIpwFwZILTAf+6
	DwVTHu7IJYdC4R8zbqceLTRP/LQBGNBCi/G8MMREAn2+yvJDkIXxGSrmvLVszgCxw2g==
X-Gm-Gg: ASbGnctM2uy4avRGVUJulnn8rBcztoAWyHeyXzmPfp/eeD3/Z4j4VFzVKhQirdMfe3v
	5nfeZOEcdsrAX9UNj/M6bM/ZLXH0XgKeJxj3TmsyA1rZrbxxSYa4BubJ0lqc0/o13735sJ3Gpk8
	99fJjznrBLCeur0yDE1a0h1n+zzxOH3cb1qqro57hzTB478ZpZpBf7uKYSp288xXwXgJstYUr58
	5sl75lPVxGFQtvprMPnGxiLLEFAGbaOQVBvJ4vRHzh6iPx1gRDum2MZHGOiL6K3uEHlWUwpglke
	40TXUegwY0WFKbkJh34v+9Yb97kjsuF0Ls2m/4G92IrgPQ==
X-Received: by 2002:a17:903:4b24:b0:23c:7c3b:4c61 with SMTP id d9443c01a7336-23dede2d292mr8885955ad.8.1752181928462;
        Thu, 10 Jul 2025 14:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfqFdZB30s9Ns2OTuViOndMsHrV92VUKAaa3t7UGJI0pLP81WIaExo2hP4WyXbE/2+Ovdog==
X-Received: by 2002:a17:903:4b24:b0:23c:7c3b:4c61 with SMTP id d9443c01a7336-23dede2d292mr8885575ad.8.1752181928069;
        Thu, 10 Jul 2025 14:12:08 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:12:07 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:45 -0400
Subject: [PATCH 13/13] clk: imx: scu: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-13-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=3280;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=v3hdhBOHK0qUhvNSpx+BtyoEKUPgUNG99ieRMqbb8UE=;
 b=8ZgfFYF2KZsuweqpz1xsyECauFflmi/TsZyTLp4K/6NlZj8L/AQUvX4HpvZ6yVLmtnZpaXBYR
 CufxM/OrxNxAF1m7eYGGkqwIl0G3siaDy/4VyAsIls9Ss5jZ6J2R9M9
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

This driver also implements both the determine_rate() and round_rate()
clk ops, and the round_rate() clk ops is deprecated. When both are
defined, clk_core_determine_round_nolock() from the clk core will only
use the determine_rate() clk ops, so let's remove the round_rate() clk
ops since it's unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-scu.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b27186aaf2a15628910ea6a3d4aaa5320ec4295a..77c4cde8a72bd71653bbd2e95148bc1357ec1aae 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -269,24 +269,6 @@ static int clk_scu_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
-/*
- * clk_scu_round_rate - Round clock rate for a SCU clock
- * @hw: clock to round rate for
- * @rate: rate to round
- * @parent_rate: parent rate provided by common clock framework, not used
- *
- * Returns the current clock rate, or zero in failure.
- */
-static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
-{
-	/*
-	 * Assume we support all the requested rate and let the SCU firmware
-	 * to handle the left work
-	 */
-	return rate;
-}
-
 static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate)
 {
@@ -454,7 +436,7 @@ static const struct clk_ops clk_scu_ops = {
 
 static const struct clk_ops clk_scu_cpu_ops = {
 	.recalc_rate = clk_scu_recalc_rate,
-	.round_rate = clk_scu_round_rate,
+	.determine_rate = clk_scu_determine_rate,
 	.set_rate = clk_scu_atf_set_cpu_rate,
 	.prepare = clk_scu_prepare,
 	.unprepare = clk_scu_unprepare,
@@ -462,7 +444,7 @@ static const struct clk_ops clk_scu_cpu_ops = {
 
 static const struct clk_ops clk_scu_pi_ops = {
 	.recalc_rate = clk_scu_recalc_rate,
-	.round_rate  = clk_scu_round_rate,
+	.determine_rate = clk_scu_determine_rate,
 	.set_rate    = clk_scu_set_rate,
 };
 
@@ -766,15 +748,15 @@ static unsigned long clk_gpr_div_scu_recalc_rate(struct clk_hw *hw,
 	return err ? 0 : rate;
 }
 
-static long clk_gpr_div_scu_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_gpr_div_scu_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	if (rate < *prate)
-		rate = *prate / 2;
+	if (req->rate < req->best_parent_rate)
+		req->rate = req->best_parent_rate / 2;
 	else
-		rate = *prate;
+		req->rate = req->best_parent_rate;
 
-	return rate;
+	return 0;
 }
 
 static int clk_gpr_div_scu_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -793,7 +775,7 @@ static int clk_gpr_div_scu_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_gpr_div_scu_ops = {
 	.recalc_rate = clk_gpr_div_scu_recalc_rate,
-	.round_rate = clk_gpr_div_scu_round_rate,
+	.determine_rate = clk_gpr_div_scu_determine_rate,
 	.set_rate = clk_gpr_div_scu_set_rate,
 };
 

-- 
2.50.0


