Return-Path: <linux-kernel+bounces-862378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078DBF51FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E154D3B5319
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D1283C82;
	Tue, 21 Oct 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IZJ66e39"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBF26C384
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033455; cv=none; b=Nix0pFi8845UcuG9tjnDqCCJRITSBCju/mQLZyEPvDgKNd7KvLaIR0mHFAmJBXyt73GD16PMeq/68SMn/1rs9X2+b4n3NzTBBgV68uMC61ktAMP5sXj+kU/S5SMC8LhAQXTz/8w/UMkEfN77PwDjxJ7tSMxl40eucOMXe9PKHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033455; c=relaxed/simple;
	bh=P3qR+t/tTh6PuTIAQwldgAAcW/75ffdD1HUgcaDxE1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qQvnfVNGm7OUdIh7ubAqt6NhnRm2UH5fra9z1IwE4BrPscP3XubofTuHW2Y1SS2XJS7s2C9AJoIMv2pEVQrbFg88OYULOGu7vKcSBYCE3EfQG/hwvvfMlqHDFxC+LY+niVvylrwod23VwuaD5SkjDfEIlJZaMaS8gSNwfRzK/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IZJ66e39; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2697899a202so40017935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761033453; x=1761638253; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/8SKTykForFBaFYsYGEE5YmDtkAZloMApvI3AJh6uk=;
        b=IZJ66e39sfrpfwnLHcSFALBC1FBM8Mme2r6Pz2ebvJBvy0UwiRP27dHOhMuNIXKpWN
         YVHc15erP4mxqtJ0RfVr9LXWACiNd0bOoIyZOA4rGah+ayJYX94v7K6pXFEGpEWDjRw7
         VvSNorSm/AThtA0Tkbx95fb3umcDyKZsbvaMmSFTAb0geIA2VgQACvNuo7bEO1ZOTmPh
         mahGCv+BJg08O3+2vy45JtKjkSFQLzqpKFwNU5PI0nnwNe//Bz1ARLIgIx518IKnS384
         FoCf/5M4NVO9d3YsH6746VGVIQrJ1OMYqcYgksl/SlM2EX6yLOwqixVziwPChLLxHazl
         1LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033453; x=1761638253;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/8SKTykForFBaFYsYGEE5YmDtkAZloMApvI3AJh6uk=;
        b=DevM/rZMiV9fPFdzjw8kEFmW9fE4MpUft5V1wrd1/mLiTdFepnhRGEZ66Q1/ZJ9qdm
         PIfab72xnV0vZ7AK8CpZjR1UHlbIvBnLS11ro69D9VUzoAiZrmBhI2XGPNDezJxQ593I
         +yB2t2aMZNvTk30+biouFqvPG8aZtzPwLrAdmrzxhW9fng0DT75+RFDk5ke1tlxjGiV4
         9MBr0HudFKkkMweNhjGoYGffU+vqpVWk25NLozy5Q00Z050gFq5+hT9q4aCrQ9UJgcyf
         nLum4UqFHyzjIIvO9F+fQh0YgLhuO7IdOk02WOblTF19I/u9GOyIwmUT+2PxbByxl3NR
         zDGg==
X-Forwarded-Encrypted: i=1; AJvYcCU85eiPW5/lbY59fXNZi8U64uOmVXH8RLEL1L0blIU5ARJCp0VXvl10USrD37PHs0n0X8I+CtLlg9Y1rlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkVhHwFdrsOCrx7YUAluCF9g1xp3k/IiS1OLW+BxSbd0TuMDu
	dvnJqfWG43Hf4V5nlS9gfTrveem9nB1e4Kb59g94zLwAs8m15s1E5BYcNnlWXBw9N3A=
X-Gm-Gg: ASbGncsLhbPfN93hT6coZzA3BHcrWFaNS4pnlBOZxFtiVHdaHCeyCDXstJTLQxlrGyE
	811HoaazYL1x6NW5aF7f45WnUUPCWIo9be8OXMz3DBrYkEC2BKkr217ENnkDWiRx4tpoTQWgbqX
	2HGNTIksikXctq3vx7WUFUr3XTAOmUgUnK+r66yy0XbgveIWaCrjmAsim56nJbksFJ7rq8oawM0
	fbjb7zpbWIMZBOcVRZuAK6U7sqyrNgJIuOSePDfjyC4hS2dXXjBG6jZPXyIhRjeaqm2VEXZcykj
	OwlIJPhAu7nAgUus5suUGC4dE4EWva9tzrYNzsroKTRflu0tt9S4R952sd7JkRL89Pa04INM4FJ
	ZPhvmbAJFXllTh+Yuj3Rca96zdwCRKNEZjQSK4Z0GINTnxQ6DPkSUNhGRl8QkO97CjYYVYzUaD2
	AOF6UvinixW0Mfh67SXtcBhrmLrkOcZJi8Vi+OD80egX4=
X-Google-Smtp-Source: AGHT+IG/nVTMVnkhbwsdclkwA3L+8Ny3RGAmSEl1hR8wYqLDKSXk9+6PDcXVh3sMkjUsx87QqUNoMw==
X-Received: by 2002:a17:903:234d:b0:267:44e6:11d6 with SMTP id d9443c01a7336-290c66d9d55mr194364985ad.6.1761033453473;
        Tue, 21 Oct 2025 00:57:33 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm102083085ad.57.2025.10.21.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:57:32 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org
Cc: guojinhui.liam@bytedance.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware
Date: Tue, 21 Oct 2025 15:57:14 +0800
Message-Id: <20251021075714.3712-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251021075714.3712-1-guojinhui.liam@bytedance.com>
References: <20251021075714.3712-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When probing the I2C master, disable SMBus interrupts to prevent
storms caused by broken firmware mis-configuring IC_SMBUS=1; the
handler never services them and a mis-configured SMBUS Master
extend-clock timeout or SMBUS Slave extend-clock timeout can
flood the CPU.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 drivers/i2c/busses/i2c-designware-master.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 347843b4f5dd..436555543c79 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -78,6 +78,7 @@
 #define DW_IC_TX_ABRT_SOURCE			0x80
 #define DW_IC_ENABLE_STATUS			0x9c
 #define DW_IC_CLR_RESTART_DET			0xa8
+#define DW_IC_SMBUS_INTR_MASK			0xcc
 #define DW_IC_COMP_PARAM_1			0xf4
 #define DW_IC_COMP_VERSION			0xf8
 #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 41e9b5ecad20..45bfca05bb30 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -220,6 +220,13 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_disable(dev);
 
+	/*
+	 * Mask SMBus interrupts to block storms from broken
+	 * firmware that leaves IC_SMBUS=1; the handler never
+	 * services them.
+	 */
+	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+
 	/* Write standard speed timing parameters */
 	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
 	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
-- 
2.20.1


