Return-Path: <linux-kernel+bounces-852381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F5BD8D20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3A6F351B02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678182FBDE0;
	Tue, 14 Oct 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8IiQ3HP"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A532E0939
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439246; cv=none; b=pfOAlJoW/6/yMYhGooo8LJe0e6r7U+2O28sXmyZkQiWrD+btR9gLGBkeyQH9YUdr/YxLbAF/wSgV0499ZT1dD+rer27Dt+HQSxarXCQ+KiEgUnwgpSu9WVh3glNEoO2y2u8wO6sgAbOlS0Of9Ltlulxcng362BiNqaoxwPEENAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439246; c=relaxed/simple;
	bh=Mr8tfZLBlB8aFgod6sfW7x6gPlPlXWbUdZCIVbKO4Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnCdrDVWDNzKx8A3jFc6BWy7bOD8GrtcWxR9sXZMoS2rj8gg+ooRrCz/W4gcnuyWgSC4BmmTPQvAnVn4YWh4Aif9S8HIDg1N/KlxwdlZNtHnRjCNdWbXRu9ksWNP/uKS0f0EaVHhpvg4By/DvquBtLWXEKEO/jmpZptLw3kk5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8IiQ3HP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7841da939deso4539042b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760439244; x=1761044044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCcGuEZSgrij4aPzZeBxOmzwZd89EZQp1SLrIiFb3XQ=;
        b=Y8IiQ3HPqfjjAltwdpksk+eCEN5E5X+Pw5iGK5HtG5Vp/kFbruXuX13ckEwFr8ppPt
         5JI3EoclvQOis2eaRwMsrsXGcnyfVdQRtyY1hvEmzI6eLTNp3TzwHPOCehDj5Lac2z6N
         T0bZa0nT4g68RLttEKDdBbgXo6KFCUiSKTIpEqONiaI398l088N728hhCUvnThd/jiqf
         DE0ZmtrUW+TjNGmgYVOzXKXljuKxINEgxaBC4LHHnA+r/Olm42vesorlz9hqBLqwWfqC
         DlOsZWB+trXc6FCwNoYEc3nV81mi9nWIfdhbmIKDWdCT8mNv3lwFQsFfvoZhBoFMTKDr
         cRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439244; x=1761044044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCcGuEZSgrij4aPzZeBxOmzwZd89EZQp1SLrIiFb3XQ=;
        b=J8s0noNSS74tNW/wIZPjxAg5/qfhdx4SDubeZxkiaLIDra0bUc4wwEOioCLXN7USuh
         How9u1wcPMZJ/yak71XamGqZLpBkSYlQkuKIybKZ4FBlCvd+Tbza3HJK5XRPPBhxvc0V
         tlSESfdtKT8/lRhvDH8XQoV78zYn0xSexfwcGaQ/pQvJeSSUkJyIpu6NeEcNB3FaluaN
         LijO8EE1a896dBGGpcvtrKHgIPRGKu6ZL9170zJ7dCfZFfmR97FJz0YvYepLo+bqmetr
         AsBw4DSvHOvjlv10oF6LmbT3frJt9zMIPk/2jBHEogRPMz7lqzpNicVZMTnHk7l8yJcE
         toEA==
X-Forwarded-Encrypted: i=1; AJvYcCXT94GpQI4OOWeJ7yLC4jyHjIEMNzCrIxLA7u4tPN1P+v/oOxjQDa3G4JAusUTKtGwU0R72xwFnawpIt8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Gjs65/uyndsPSDifcq0cYEZM4/RTWf2Z3IdlsNrS8whPrwBe
	M++f6TBasKQrsSqYUZEYqF/syrtFfGMslgyRpEDgg76vgb6lQslI9CD1ivjLUQ==
X-Gm-Gg: ASbGncturUJ9G2T7/617aIMKWi878kMtyf2APny0e6DmNxczz7rs5k5o4fsWWWcwdBB
	bA1wKx3M5oAnJriihHlZGTjAEyrZ1VD1Zq1gIYIYt6IQhiFKh0/XtlAEjzG0qbd40e6fbWH1ri4
	uY6IDy/0H6YoSWc99pbaY7TgXyrA0d+Z8taZwBRRMBIGdrzKvgTsZ604f2oByc++kIkF99ZErtI
	/jRGgI7XWmWA6+yJT2t4rLtRHj66cpSPfmTOpNpcYPsrh7MkJIluQavl08ugqh0ZpagdpPbhsTi
	Y0kkzA5gPfsCO9mP2kf6uzCfzUHnFlz2SwFedGcuxwG9Cv+8g08XO3VF78m9Oei/6+T3bdlr0hQ
	fXP5LDt1m8CE/XokXJUqQL8ess+U7DCFr1iVHVIzepQt30GTJZDASRfHj8iEg0uOVJm5Kg0nlJw
	==
X-Google-Smtp-Source: AGHT+IHul9FYXPgeY0MtOe+ORzdsrXCIGeWmnOQdSxYt0ZHodvYGCUDDVSFP9FvoFR1UMaj3nEkjBg==
X-Received: by 2002:a05:6a20:7351:b0:2ff:1132:8c48 with SMTP id adf61e73a8af0-32da8164167mr34514969637.24.1760439244522;
        Tue, 14 Oct 2025 03:54:04 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:6d70:9e09:769b:2b4f:71ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060962sm14901724b3a.1.2025.10.14.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:54:03 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: cpg-mssr: Add read-back and delay handling for RZ/T2H MSTP
Date: Tue, 14 Oct 2025 11:53:48 +0100
Message-ID: <20251014105348.93705-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the RZ/T2H SoC, a specific sequence is required when releasing a
module from the module stop state (i.e. when clearing the corresponding
bit in the MSTPCRm register to '0'). After writing to the MSTPCRm
register, a read-back of the same register must be performed, followed
by at least seven dummy reads of any register within the IP block that
is being released.

To avoid mapping device registers for this purpose, a short delay is
introduced after the read-back to ensure proper hardware stabilization
before the module becomes accessible.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Geert,

I made use of the timed_read_poll_timeout_atomic() macro to print the
delay after the read operation. With first case I printed the value read
from the register and in the second case I just printed the number of
loops and time taken. So to be on the safe side I have added a udelay(10)
after the read operation. Please find below the output from both the cases.

#1 With value printed
[    1.468936] read_7times_init: poll OK after 0 loops 223 ticks, 10000 ns left of 10 us
[    1.477719] read_7times: read 0: ff002104
[    1.482358] read_7times_init: poll OK after 0 loops 126 ticks, 10000 ns left of 10 us
[    1.491331] read_7times: read 1: ff002104
[    1.495901] read_7times_init: poll OK after 0 loops 100 ticks, 10000 ns left of 10 us
[    1.504692] read_7times: read 2: ff002104
[    1.509261] read_7times_init: poll OK after 0 loops 103 ticks, 10000 ns left of 10 us
[    1.518052] read_7times: read 3: ff002104
[    1.522692] read_7times_init: poll OK after 0 loops 100 ticks, 10000 ns left of 10 us
[    1.531665] read_7times: read 4: ff002104
[    1.536209] read_7times_init: poll OK after 0 loops 102 ticks, 10000 ns left of 10 us
[    1.545183] read_7times: read 5: ff002104
[    1.549726] read_7times_init: poll OK after 0 loops 84 ticks, 10000 ns left of 10 us
[    1.558456] read_7times: read 6: ff002104

#2 Without values being printed
[    1.469581] read_7times_init: poll OK after 0 loops 255 ticks, 10000 ns left of 10 us
[    1.478668] read_7times_init: poll OK after 0 loops 130 ticks, 10000 ns left of 10 us
[    1.487650] read_7times_init: poll OK after 0 loops 101 ticks, 10000 ns left of 10 us
[    1.496527] read_7times_init: poll OK after 0 loops 99 ticks, 10000 ns left of 10 us
[    1.505231] read_7times_init: poll OK after 0 loops 96 ticks, 10000 ns left of 10 us
[    1.514109] read_7times_init: poll OK after 0 loops 97 ticks, 10000 ns left of 10 us
[    1.522883] read_7times_init: poll OK after 0 loops 99 ticks, 10000 ns left of 10 us

Cheers, Prabhakar
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index c9598fd1f8cd..4e9c1bcaf968 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -308,10 +308,21 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 
 	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
 
-	if (!enable || priv->reg_layout == CLK_REG_LAYOUT_RZ_A ||
-	    priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H)
+	if (!enable || priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 		return 0;
 
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
+		/*
+		 * For the RZ/T2H case, it is necessary to perform a read-back after
+		 * accessing the MSTPCRm register and to dummy-read any register of
+		 * the IP at least seven times. Instead of memory-mapping the IP
+		 * register, we simply add a delay after the read operation.
+		 */
+		cpg_rzt2h_mstp_read(hw, priv->control_regs[reg]);
+		udelay(10);
+		return 0;
+	}
+
 	error = readl_poll_timeout_atomic(priv->pub.base0 + priv->status_regs[reg],
 					  value, !(value & bitmask), 0, 10);
 	if (error)
-- 
2.43.0


