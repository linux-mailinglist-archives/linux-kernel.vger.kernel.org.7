Return-Path: <linux-kernel+bounces-894795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A7C4C177
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1C91343C32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10383148C5;
	Tue, 11 Nov 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIJ4uGrG"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A3258ECC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845727; cv=none; b=lxNE9IvHapuon1M1dFx6WS2HiY1Q++7k2d4l596fSU34+mFegoetMlsopu7JF2wm7V/qdU7daokcQjPTLRcQpRpjMTa6+iQOTpybcqDXca44FM298mSTYsaAzsuBUZOjpbfawnTLIXtP5zYc/KXpvmAMr80zl3lZtLQFDMWJgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845727; c=relaxed/simple;
	bh=Zf9WEFXfE6bq+Hc2EstDsmaBak2mnzhvUiacR4bC4/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2Y2z9xsrbn74LXEhjfYigGZyywytjJO60+eCEFD+XE43b3fw2YDrfVGr+upyyYpJz7bVWPM2q0CghGD5tw+cgGLmF5B/3LcJIcH9i0rDD66HvZhTXYQZclYOvxFK1AXTMDw/AQehsOpEYkSWxhk9NaMJNJxH91MTbXwYHzsLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIJ4uGrG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3292676b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762845724; x=1763450524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z3L1kNsgL26Ld1VFBvRuQTF0eVIZpSLBAGlIIman4Q=;
        b=lIJ4uGrGfFSz+tm04eVOHv04YheMMgQiJ6Scf/6sM1qMD1q+IRAX11JMmDJMe7069q
         iKhcct61hZPT4L5YmlxR2KWQk3YLRWaBaaOAGueLwQ8WFhoU6O6AqPOXcGn17aA0S9vK
         8XvdNW8q5A9qifoxsoOMGpExMaQGVFfHDRw2Ayrw7d3r4esAf0epCwKhRSOvnb2a/Uhd
         ca9Gd8Ypga6FL4M0FviitGaYQYe5T/RbHMDzxMsdAw3h9YVzEm8FUFnJ6ymVIFWuvsZU
         OHyzicaSxzMn3bnvf76l8T/FTuXBIqoT1nSzD9Kw6Chz9fVGfIWtpbRr76W4K3XjnBpc
         6BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845724; x=1763450524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z3L1kNsgL26Ld1VFBvRuQTF0eVIZpSLBAGlIIman4Q=;
        b=lIBS7staQsVBTcMciUNzXCvEbl0NtdqJ7kRvp2KE/0htFcLTp/QWcKWIE/HLlpm056
         BMfvlCz7ciVfoqFXBsnhVGjrnIMOiARo0T1rglrmBaFTzyzseJF25qrr/kqi5353Gche
         xblqoLyweppH4EMBoFoRO06JQMoeoSybfYQBBYbNPh74sJl9VUbtgmWWo77RoOtvxlDE
         LGjrRs/pMMnSRufTsKR0WxfCN/ifjOkdpqj45bGLKHnW1ND/xf3Ql+Ld3HiVt/DLI7ZQ
         tDaetjX3xj+FwYqO1wdjAbae92Y1YGTvDS5Ol/Y2fKX1Rq+2EXwEC4v9/pMVjvYvR7ke
         v/pw==
X-Forwarded-Encrypted: i=1; AJvYcCVtPVAfd70aT24tQ1k0aMl+YNuUg+i79kyfjORmp5yfRqi9asy5/Ci0co+uMvocqRJuYlohPkTLNkL2phc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFM1ha9eVmwT9UkXK6rth7Mz+t2640fMcKFgKSavqMSy4GX4Cs
	MEXLtsQewolRNNWpi6Xy287rpnfqQC2fGPWalbSKaJtqBKK8CC1EKrNX
X-Gm-Gg: ASbGnctNfV9d9cTYQpTD0jol5AoNzmdeW4yDxBsCoJXu3JDA9iixp4K4RnyxJ4/Zsz0
	Bs5iu/JXARDSNkJvE/1LHXaigFSfUav0GSY6Piy1Eb4WyD1gw+2kl3xf+brtJ3Kw0nHI3QWOrgg
	jKAZ6FMnUFXtaAiWNcjFUHln3MoKG6zc9WgbO791MTlApewPLdu4hlFqxFWBvY8o7Ufyxd3yHIW
	4UpgzTy+xeVcDz2w2KpXMkc+DPYC57cOum0S4B2cc9yRjqUoE4M+HmeHW+rMKqUKL+zPU+ekKf4
	Wue1L1NEMR+/GbYdM8A+Cckj0dyV/WWWOlt52/TsqrVa446K1yr7xUrqr0cjPYzFiBKExWu1qx0
	4X7fk9wZICBCaKX2unZW3gOxxMn+4z9gYE0gz3KUuOx7oYfwolU9uF4lL2eeOAcW8hi7SNHwMlJ
	bMtjZViZIE
X-Google-Smtp-Source: AGHT+IGpsEiuiMerwOIwaAE+LQq6f13VAWzZ3g9VwGRVGMuJ4FNKoN7VNGnAwDPV3OPkWgBhWnKfHQ==
X-Received: by 2002:a05:6a20:2450:b0:342:5ba7:dfa1 with SMTP id adf61e73a8af0-353a3859cecmr14895533637.42.1762845723981;
        Mon, 10 Nov 2025 23:22:03 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe33a75sm15466106a12.24.2025.11.10.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:22:03 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org (open list:SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI...),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC in HS400 for Rockchip
Date: Tue, 11 Nov 2025 12:51:57 +0530
Message-ID: <20251111072158.6686-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
enhanced strobe mode, set the card type to eMMC in HS400 during clock
configuration. This bit instructs Host to sample the CMD line using data
strobe for HS400 mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd453899566..3edde4532b13c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -77,6 +77,10 @@
 #define CV18XX_RETRY_TUNING_MAX			50
 
 /* Rockchip specific Registers */
+#define DWCMSHC_EMMC_CTRL		0x52c
+#define  EMMC_CTRL_CARD_IS_EMMC		BIT(0)
+#define  EMMC_CTRL_ENH_STROBE_ENABLE	BIT(8)
+
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
 #define DWCMSHC_EMMC_DLL_TXCLK		0x808
@@ -660,6 +664,14 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 			DLL_CMDOUT_TAPNUM_90_DEGREES |
 			DLL_CMDOUT_TAPNUM_FROM_SW;
 		sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
+
+		extra = sdhci_readl(host, DWCMSHC_EMMC_CTRL);
+		if (extra & EMMC_CTRL_CARD_IS_EMMC) {
+			extra |= EMMC_CTRL_ENH_STROBE_ENABLE;
+			sdhci_writel(host, extra, DWCMSHC_EMMC_CTRL);
+		} else {
+			dev_info(mmc_dev(host->mmc), "strobe mode not enabled!\n");
+		}
 	}
 
 	extra = DWCMSHC_EMMC_DLL_DLYENA |

base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
-- 
2.50.1


