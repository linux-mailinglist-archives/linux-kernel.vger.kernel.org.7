Return-Path: <linux-kernel+bounces-835117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC71BA6512
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2AC17DEC9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82F199934;
	Sun, 28 Sep 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bka9WSVf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163828F5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759019688; cv=none; b=sEjDWJvwvxEUXb/COlQ5VA2jqHB8TJZHSyBHWYq+BKUQeRJXmXR2KAY+tpYmGzuadIyxM8FwBThnLQPc0Izv01pnSlUa+np0dlagYKasK/ShjbC1SPOsDAnIuJhEB0mqOGCRJIc7xRUB5qd6Ar3tvn3IOMYmYFXLDIkBAlHlT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759019688; c=relaxed/simple;
	bh=jKCoSlxik5OsSiTMu1gczcSV+m6raIbTcbI0mrv1YBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jTzZ5JC89CQtjjzuk1cemG7LXaNLFeaRGriulQi7Wfv9pcixC07zg2bZWizKlaLnhOOb0FWc8yZBdtAQf9VXixVbVH7FDh25eFuSBqEQIhMqL9e0xi2S/uTasgQWF1NQAJvyuMQPNaAI0ir2vwrm7kDjyn1u9qWWqcvYmxqrLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bka9WSVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759019685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jDSI/1zqLdM0Wxroix37DD09bywHURo3GxO78hmDEtU=;
	b=bka9WSVfkduZ0DZhJy1InbUfwnS4nAy4C36BiQ2MuQta+HO3Mhc2RBnFXfBozszAfKC/Ja
	FIVq+NlZWpjKwb0K14enpG/+vTlkeijkgp+9Y6T4JI6wanPR3rKpwIV4UFPw8SmS9zMZdZ
	CTXlNzTtZMA78NAMPMR5plKgI1UEc/I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-P1TEzhOXOXyg4AePC-PTqQ-1; Sat, 27 Sep 2025 20:34:43 -0400
X-MC-Unique: P1TEzhOXOXyg4AePC-PTqQ-1
X-Mimecast-MFC-AGG-ID: P1TEzhOXOXyg4AePC-PTqQ_1759019683
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd932741cfso51837741cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759019683; x=1759624483;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDSI/1zqLdM0Wxroix37DD09bywHURo3GxO78hmDEtU=;
        b=k8q2vZ3FoyUYBybZw3f4RpGdSpNFM23pN6JSSw5tHOKj70x2tFv/runrZP0X6OVgXc
         ta+tWXg2h/BGHtaT2hm/8UZI7FBk/xMZCa3METP+6Sqe/x22foFLgTAYpl3KDnyMpHto
         A37gEY2E4cphXtF2DLNFzcdGn9Zi/jANTjBeJe/OnJlVZQQfzWfeydxQQrwHI+Zlop2G
         j0zwUU5QVna7dxnhz51tT2ST2JY5NQtFrfO4tbKXUSk8fkNbyJB+Gees+BgYXbEIZo5W
         cZiP0u2CEjSDhSqwvLXR3rl01B5iec7RH78uu0rrLQsmWZpmxfoqMXC0una24QSXQmE4
         kcVA==
X-Forwarded-Encrypted: i=1; AJvYcCUWY5ybCsxoEpBq2+8QhzbeF0dOzwubxkrntgR/zLdDweE3w6ViwySmry2lY9HZ62IUHNkX4j/tU9JAFp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxznYGMuyjiM5UdElSJE/4jkA951nCxgT8GhWIDGW9lIZ765r
	wmwM0x1mEdU7XbCw32XAsne7klgZ5O3jTp66k/Pp2hDQBonkdMwDDTZnuSCkE35k++ar1GNnW+H
	nA8ithekaA0bN8Sj0rOSfSJFV7KNFXu5ouLFwP+7Ai6NtBTLD6uuA69hiKb0AH7n7vQ==
X-Gm-Gg: ASbGncuNQ8K6evEcVJKqG2tGpywYHIuh1jk4KBybxQN4ByUcUMByhECQsmxUw60mwjR
	1sQ8TDRh38CJHqs1wIXdcW8tErvp10zeUJnoSys3NAkNrt39y1y0CC3jJmHyPSuPB8rjNxNnHaY
	uc/j/VFlLSXQ74EyoErUjRh7/e4kRpC3ovGRPdo4T97gXAjiKCzzxJkmqFRpXLsfifFKgJkMD4n
	a2DTy5wgkL7KCJoMK5p2lhCg7V/rSTQP5Yi4QgmYjnC7f/is1gBob/OdEfGglsH+/ekFfINzHwQ
	hiugLfQeQN42aMBD4570C2aLRU1zVIvCmNAbnsyc3hMEKDUr8KhbFUvUV6sK7RelhME1rv2reHl
	VWC9JMFY+zCB2Z578eAHzkEcjpJtIIVnby2re
X-Received: by 2002:a05:622a:1b2a:b0:4dc:ba40:6959 with SMTP id d75a77b69052e-4de2da0a2eemr75873901cf.20.1759019682939;
        Sat, 27 Sep 2025 17:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfCqXyF7ngzZiwiTE/uCSPZRmfVD1+tJaS+wARjoa8gIIdb93/n2ykPM3lDbrGZqqQo8eZfw==
X-Received: by 2002:a05:622a:1b2a:b0:4dc:ba40:6959 with SMTP id d75a77b69052e-4de2da0a2eemr75873751cf.20.1759019682539;
        Sat, 27 Sep 2025 17:34:42 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c34da236asm516558685a.68.2025.09.27.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 17:34:41 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sat, 27 Sep 2025 20:34:34 -0400
Subject: [PATCH next v2] clk: microchip: core: remove duplicate
 roclk_determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-clk-microchip-core-compile-error-v2-1-3473dbae3625@redhat.com>
X-B4-Tracking: v=1; b=H4sIAJmC2GgC/42NTQqDMBCFryKz7hSNpH+r3qO40MmkGapGJiIW8
 e4NnqCbB++H922QWIUTPIoNlBdJEsdszKkACu34ZhSXPZjS2PJurkj9BwchjRRkQorKWYZJekZ
 WjYqe/Y1Myc56hnwzKXtZD8QLRl5naHIaJM1Rvwd3qY7uf8RSYYVkqe7cpa7Jdk9lF9r5nGfQ7
 Pv+A0CzDd3XAAAA
X-Change-ID: 20250927-clk-microchip-core-compile-error-fef8c20ed5fe
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=jKCoSlxik5OsSiTMu1gczcSV+m6raIbTcbI0mrv1YBo=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJuNC2oMnpuJiUtd8s1XTL0bd/2CSqG7G6nm7u27WXYo
 L3sU8nejlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACYyqZThf+raebpfj2Tt2M3/
 /LbhHtY4yXNrT2+7vqpv24VLlaKHuRcy/M/sVzThjvxyccK/zvCgV6GFfTPn3hDMmi98WrnsF8M
 kfQ4A
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Fix compiler error caused by the round_rate() to determine_rate()
migration.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509280327.jsapR0Ww-lkp@intel.com/
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
I didn't cross compile the original series on MIPS, and this driver
isn't compiled with COMPILE_TEST. I couldn't enable COMPILE_TEST for
this driver because of the asm/mach-pic32/pic32.h include.

I didn't include a Fixes tag since the original commit didn't make it's
way into Linus's tree yet. I'm not sure if you want to squash this, or
include it as a separate commit.

Fixes: e9f039c08cdc ("clk: microchip: core: convert from round_rate() to determine_rate()")

The SHA is from next-20250926.

Changes since v1:
https://lore.kernel.org/linux-clk/20250927-clk-microchip-core-compile-error-v1-1-c5c3bd633c5b@redhat.com/T/#u
- Add Reported-by and Closes tags
---
 drivers/clk/microchip/clk-core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index 3e03e10539c72cc28e53401093e37409c2ea3d08..b34348d491f3e1b576b2b9a8a66bfddd8c2296ea 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -374,20 +374,6 @@ static unsigned long roclk_recalc_rate(struct clk_hw *hw,
 	return roclk_calc_rate(parent_rate, rodiv, rotrim);
 }
 
-static int roclk_determine_rate(struct clk_hw *hw,
-				struct clk_rate_request *req)
-{
-	u32 rotrim, rodiv;
-
-	/* calculate dividers for new rate */
-	roclk_calc_div_trim(req->rate, req->best_parent_rate, &rodiv, &rotrim);
-
-	/* caclulate new rate (rounding) based on new rodiv & rotrim */
-	req->rate = roclk_calc_rate(req->best_parent_rate, rodiv, rotrim);
-
-	return 0;
-}
-
 static int roclk_determine_rate(struct clk_hw *hw,
 				struct clk_rate_request *req)
 {
@@ -398,6 +384,8 @@ static int roclk_determine_rate(struct clk_hw *hw,
 
 	/* find a parent which can generate nearest clkrate >= rate */
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		u32 rotrim, rodiv;
+
 		/* get parent */
 		parent_clk = clk_hw_get_parent_by_index(hw, i);
 		if (!parent_clk)
@@ -408,7 +396,12 @@ static int roclk_determine_rate(struct clk_hw *hw,
 		if (req->rate > parent_rate)
 			continue;
 
-		nearest_rate = roclk_round_rate(hw, req->rate, &parent_rate);
+		/* calculate dividers for new rate */
+		roclk_calc_div_trim(req->rate, req->best_parent_rate, &rodiv, &rotrim);
+
+		/* caclulate new rate (rounding) based on new rodiv & rotrim */
+		nearest_rate = roclk_calc_rate(req->best_parent_rate, rodiv, rotrim);
+
 		delta = abs(nearest_rate - req->rate);
 		if ((nearest_rate >= req->rate) && (delta < best_delta)) {
 			best_parent_clk = parent_clk;

---
base-commit: 262858079afde6d367ce3db183c74d8a43a0e83f
change-id: 20250927-clk-microchip-core-compile-error-fef8c20ed5fe

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


