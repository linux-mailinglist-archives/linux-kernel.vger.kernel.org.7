Return-Path: <linux-kernel+bounces-849045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CBBCF12A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A595401A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B669225A34;
	Sat, 11 Oct 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P37NdUa/"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254220B21E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167894; cv=none; b=n9RJMI4Uo1MeS1H0CXwhL+44jQI5eMFZwLxXAD8UYRT9dT6MDCVfMBhyUiz+s3aveCJLiOq6WNNoHtdaZqHQKTL30TmudmKXDjeKIPP9ovVgaXuvS++wJ4L4PhPpcVrtqU+abvxCom05e7CyDykxovaBynimXrWHHDI6xSZ6tXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167894; c=relaxed/simple;
	bh=t10ZSanIx3llENM7HSeecEJVpDcZYb6Uf+MM/xzfZ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W7CM4DkY7EgV3mxubbI5671sXM4XrPzqCgs+V7qaT5iCWFIt2toQ425EuAkiKD6vfIAY4vLJWl1t1qwXK9sAgxj9gGbRg/NjIRMxPWnRHhYzwyaYAtxOkJq/YVqwcJLDnvMXJpjVp8AiLhpLVg+BfZZ+XUi2ERagRuDicx27Bog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P37NdUa/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5579235200so1800330a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760167892; x=1760772692; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5u349rpF9gPPQypTYTXfVoHAsG0CPWqoBlop1wLg5P0=;
        b=P37NdUa/loubMzF8wZvumPKtHv5RWWdbyrb3aOY1pXoyCEDkf/O0qB7vibivrzKjqh
         XMxHs5+j3shY1hBRa/4IoeiPpXnrvcv7eQ7WXxHgwFpMhY6Qm2+S6xpbxJ62BCqp9SYx
         wFIfgKKXzlI9t6OcbrPYgGq3uwyXYdrSK6CFYXDHQ3EO0V/sWEdZ5Cx3bopb8TmCt3gr
         XEQ/5YCOPrt7iEsTeVgJJEobFgv+on/XnlbbnfJi4HxYC2ucH+eoGK0NoHS8HcnUYzPu
         Ixg8KiTAWhHHCmXCafYLnFbs169Xso4YRRRKNfi1DbFrfBmI3C8AzlflruMmIcdadqcm
         NSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760167892; x=1760772692;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5u349rpF9gPPQypTYTXfVoHAsG0CPWqoBlop1wLg5P0=;
        b=JIepDGASlGK9MjZ/iyaed/a+nZIvEWCdtwmxDertaz/mqwymLDMzT3wMDLglVS2C9c
         jv3jCST8Pgm0NmP4Rvy7H03TCoXzY2fjMWt58/EA75y0dS0jZLvqmx6Xe9B3zXDOJgeq
         romGQn0AQq8QgKKbVUL0DACJ0uZcnm6oSOvbzzG16DOihKw9DnzaP4Ux8vLgBdFsO3/8
         QZw1ZbciJHMxOVpSDYrZGrTtCZiM/Vm2lXOql2oWzLq6oei2G6ZpRSkOxvSl1vmZHJ61
         tm0567+a5u05qZWu/psBwW4yiMYSo6598WPwnc+cTg1zUykHBTFGuB2yLcAjkr0BRY3J
         Li/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9REpN26I38AsVvBb4FfVC1Q6Kj9MITFCCAxIgoHrDoId+l2u/lQu2MgpYhYEKh74Bple2g/5rkB057Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWEg3qbaxySxBtM/YnZkKMBQy1OEQxhwChkOw4kmilbN42aP9
	hlj3iE/sAI/ci58rCgIme5nhK9qn+Lj/CNHtsrPZa3WH2RtcXOYlJhTMceGBmzhuZSyTJbyTirP
	JxgvJ
X-Gm-Gg: ASbGncs6Sc2C4vn/rJg+WwH6k64oYUijLSVTDKOEe6csSjYbuMSY7ZEEZcnYZLvu1xK
	v22gXRKM4wCx0IP2lOlg0/PhYHXitw5CEEW6IeDedbviwmJordTihXUBqwLaQyBWnis9Pa/3Kpe
	MT1yfj2Q4H7q0aUFEbWC9HuwIPWssJjCf9d1v6O/cR3jmrNrhlYdXkCfrmLA+fSOHNmDvrvG6lZ
	kVMG90Y2huy5QyYlPOCsFGGtCFOPOVRGjsXYmwOAw3+1llmUv72nX9YSD8IboobdPpeRRG7rU0e
	CFaJYXVjM21Ef6I8Cuj68TmOPKQKwq854/YItlAXA8sHKNPGprc6C4MGpK+6JZVG/AfDetiXRA3
	EPYgj+x7+Aelag78kXNzX19thrabxoZLpfZcV+L+FmKzZnOwhQxvLPWHHPR9Z+4ZElmvke6J/X9
	TEHG7Uads=
X-Google-Smtp-Source: AGHT+IGK/z3Cbwim35BFhBeNnScGxMkgIhE0uJYbIf9/Fg/K7JQibWEf0vK/ujTiUCQI3LxmFDXXYA==
X-Received: by 2002:a17:902:ce81:b0:288:ea7a:56b5 with SMTP id d9443c01a7336-2902723b882mr207754975ad.15.1760167891936;
        Sat, 11 Oct 2025 00:31:31 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm77020515ad.49.2025.10.11.00.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 00:31:31 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org
Cc: guojinhui.liam@bytedance.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] i2c: designware: Disable SMBus interrupts to prevent storms from mis-configured firmware
Date: Sat, 11 Oct 2025 15:30:57 +0800
Message-Id: <20251011073057.2959-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011073057.2959-1-guojinhui.liam@bytedance.com>
References: <20251011073057.2959-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When probing the I2C master, disable SMBus interrupts to prevent
storms caused by broken firmware mis-configuring IC_SMBUS=1; the
handler never services them and a mis-configured SMBUS Master
extend-clock timeout can flood the CPU.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 drivers/i2c/busses/i2c-designware-master.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 347843b4f5dd..d1122ff0a1b7 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -78,6 +78,7 @@
 #define DW_IC_TX_ABRT_SOURCE			0x80
 #define DW_IC_ENABLE_STATUS			0x9c
 #define DW_IC_CLR_RESTART_DET			0xa8
+#define DW_IC_SMBUS_INTR_MASK		0xcc
 #define DW_IC_COMP_PARAM_1			0xf4
 #define DW_IC_COMP_VERSION			0xf8
 #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index c7a72c28786c..eeb60536da32 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -997,6 +997,11 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	return 0;
 }
 
+static inline void i2c_dw_disable_smbus_intr(struct dw_i2c_dev *dev)
+{
+	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+}
+
 int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
@@ -1063,6 +1068,12 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 		return ret;
 
 	__i2c_dw_write_intr_mask(dev, 0);
+	/*
+	 * Mask SMBus interrupts to block storms from broken
+	 * firmware that leaves IC_SMBUS=1; the handler never
+	 * services them.
+	 */
+	i2c_dw_disable_smbus_intr(dev);
 	i2c_dw_release_lock(dev);
 
 	if (!(dev->flags & ACCESS_POLLING)) {
-- 
2.20.1


