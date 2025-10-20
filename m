Return-Path: <linux-kernel+bounces-861220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7DBF21B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2982618C0774
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCB26529B;
	Mon, 20 Oct 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl7xJ8fb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E9264A97
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974032; cv=none; b=bMQgHEJifPRTA4UYe2CvEVVmy3BS+MzuU9OTRwv6nZ2//uzOxTgwO1p8m4g1Mr8lcpMG44ubACpneDXno4V0iNWIRS0OkxmPXaGq4Newmvm9oox05Wg9jziriQ1AYQpHEJNHyt9b+syxxoKSBXBzL1TqE1XTPZWCUaIO/HYRppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974032; c=relaxed/simple;
	bh=GAI+uGC6SFJNIjpzWPIuItSi9xgMU44NMEFN0JoMRC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7rc6Yaa4VYm+hVqY+B695WbTO1Nb8QbDcGFkh/3wG+bFjZ21yr2bWocmJqBw6YOD0LmKxHf7FoGI4n8uhSOWXdT/4j4zDh6nAY1FtE5/U0QERMkyK1Ffu57jte25nrqKSA57LoEmMMtOrV8Zz5tvDCY+KAg/U24tQ3GY8aJWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl7xJ8fb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f755aso47092015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760974029; x=1761578829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EctQdPK7/HV2BlXTQK2FpJXbDTj/G2Ge7tqo6AYQOpk=;
        b=Jl7xJ8fb7m4m4/1y5M+0kTf+XYCwldEF+sCh2/akCOpjfLpEqE+rknx5jkttbA5ssi
         KyKpYihErkpLsPhc1gRweZd3Frb0rk/0va4CHvJ/y5ucOrRI3fswLRJ3kpv6weWFhnxw
         9gphxCqzFmcIpcpgDdE2QdG9s77xmMSplnIE5Doi/nt094TAx2bOGR7VvRprQSfQoge4
         1yfPc7VM3VDT1ZQd0zZJKxBRTZaFrqWXgBSQb5vzDn8HpiDNMFpSLMqi8fyQmyaEVB4F
         VhsQYr2DTeYLCNQR4KiTXexiOZqDR5xIrBVk2ydX3IWAGOD2SY4lbvktKaQEhPUzItI9
         /fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974029; x=1761578829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EctQdPK7/HV2BlXTQK2FpJXbDTj/G2Ge7tqo6AYQOpk=;
        b=mKyKZoEtjUvYk9pcZhvRFIidVptTAp6DyBEjB+xYkAw3wuG+lp8vnBMDzUIyaRp79P
         xGa+rw+szWG5VmrZ1ZWx+H10kkPgOtg6ia7UCCRZ0dwIfXvIF8YC/5f7uiyaGla5AZNM
         h0LuopsTCIf5dRV6lRt6o9KmtRLsLC8lU0zpr69li3jerA+y8Spk5idpWKxhnexfrPSF
         vDFqHJTUCpwlaIkqW0Q5UEY68/i9lZM0feG5coZTOVx6/O7GXsO9v5PvH4mkjrO6wKcV
         vpLZk11wBPuiGXOe/MF17DZfqRSjrAxado0IN2jUbOoDw7pq4YyR0l9Hm9/YIERVPYeq
         BL/A==
X-Forwarded-Encrypted: i=1; AJvYcCW9x3RyDTiszY+I6hacxExWHZKa0zE47xaNTk+ufXhk3SwAl6Em4rlA3Vpzb+pWum5xyQ5gAX2X87xLeZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEh15CYXX6stdrHmCBmXXZ8Pk+CWf6u71SmU19N3CQD8e25+P
	Ci61MeUY2mnCVoJQlg2x7XF1fsZLHWIBtjldWgdpLVIdYBFegcWayMI6VJGR1Q==
X-Gm-Gg: ASbGncsYx4iDFLwGOepmcq+wLSztfJYZKcwOQ6qK1OVSZlYwXWvGV9HKiUOd3JluNJK
	0VyaKYltjfkY0ZxTvsFARnUR3kEDnJkZqxcELNn06DqyTqYPx/BgTCBLx0h9VkCBgN7W/NEG7MN
	ihc2Btc124E/KVCOo32Hgs87dQAJbXMC/L+7jUCRUF6XZZunM8gMxx2rTRK5pjMZRrKoOYkFWx+
	J7WI7CMEOQT8861ACPCaVBCMKa9+1LerRPteBopKAPLVbwbWMWHEerEXK5+uELYRkhjQ8gl07pe
	oigLBi5hyDbx51isB+Wwt5FYWjfZz+GsLmg+8xMCD7JdyCcJzUWYOWxrkgED3p90YbXUwDNbTkS
	xf/ML7p+0WChZ6Vw4U3WwHNuctFRFrdS0n9x5B1sRiX1Dm5j/UmzNhymwbXZ8ECTGXLp4NiHM/j
	Me100YL74254AeWzDKlWChLud3i1E7uE6ai5A3CgKHZH73XUUmuihJWEeqc7tzDey1S5rJW0Q9n
	0rM
X-Google-Smtp-Source: AGHT+IFdnScd3UAa6FYvms7Mk8BD0zHKLaPHlgHblA0Aa/pK4mTEeu3ZIirJn6DvinarmuaN/TRYZA==
X-Received: by 2002:a05:600c:4507:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4711787276dmr102704965e9.4.1760974028776;
        Mon, 20 Oct 2025 08:27:08 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715e4e267fsm64723995e9.12.2025.10.20.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:27:08 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org,
	samuel@sholland.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical
Date: Mon, 20 Oct 2025 17:27:04 +0200
Message-ID: <20251020152704.4804-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bus-r-cpucfg clock is important for peripheral which takes care of
powering CPU cores on and off. Since this operation is done by firmware
(TF-A), mark it as critical. That way Linux won't interfere with that
clock.

Fixes: 8cea339cfb81 ("clk: sunxi-ng: add support for the A523/T527 PRCM CCU")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
Changes from v1:
- fixed typos
- added r-b and t-b tags

 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
index 70ce0ca0cb7d..c5b0d4a2e397 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
@@ -125,7 +125,7 @@ static SUNXI_CCU_GATE_HW(bus_r_dma_clk, "bus-r-dma",
 static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc",
 			 &r_apb0_clk.common.hw, 0x20c, BIT(0), 0);
 static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg",
-			 &r_apb0_clk.common.hw, 0x22c, BIT(0), 0);
+			 &r_apb0_clk.common.hw, 0x22c, BIT(0), CLK_IS_CRITICAL);
 
 static struct ccu_common *sun55i_a523_r_ccu_clks[] = {
 	&r_ahb_clk.common,
-- 
2.51.1


