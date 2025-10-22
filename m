Return-Path: <linux-kernel+bounces-865641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7375BFDA92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0294B4F8596
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD92D7818;
	Wed, 22 Oct 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSn0QDBM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276E2D9487
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154998; cv=none; b=XJoVbAvz9Lpf3TQ9Kqvlynze2G2TRRoJ5siCfqpsYPs88y39gYz/ljvTXqnJm2UEvyWq8xLrfGzOezeeUsA1NtYdbP+agDbG9AAJimcMmNUAw0j91kx/pv8dOnBGSRMi1S59AH9AbD2zz7sDWauxjIfgEoiwdh16LsJqqqEbOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154998; c=relaxed/simple;
	bh=YDmC2z63xnyncBVrO7Ltif8kw4rumvv6Ka6aN/+Z8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWkzE4fLaBfqwWr61/DNUUT5Nw25La95fCHST9dTakV1GTGgy7TqmgMK0AoulQoBFEHox0SagTz5nCgx1g37PYtb9Rru2s1PiLGVEjNiLuFlAM4RVjaTYFOrc7OvUDz26uUeL8augnZ1QWcKw5aktrURtljDGKyL/BFLVDJwVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSn0QDBM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471131d6121so54624605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154995; x=1761759795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=dSn0QDBMpd78CHfafrYHCXypX3+cTcFGcfGWgO26ZPe9FOws69Kg+Sio0Tz+0v60/e
         KkE2O2wZMz52fVMUcPdJG/Akyf8yZ5CmHEw28ydLcjdjJ7YHfbafpvSd3EBi5ziPv4O/
         c4ERXqC8UdbfrsIEpDMBN9d3B6aXpXb2d5zW8fzMrDK4KeC2E0NX52c7f7pJsuQUw7CM
         H0uMxJ+ch/lIscYPa2Q7RNBIuBMcyuzyHkZmiGzdcxkuEIrxOTJ41NWuRamm7hcpBGun
         knZ3oOHFl5dK7w0OeIQSuqid9XNa/xnpizi+YdgD0E/M747TytWNfL5nb2B5yraH6qbP
         nsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154995; x=1761759795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=D83VayuujEYszFzcHNtyI/2Aw3eAgSy63ZOwYkPSq+hMWeRjwHBHvMeaiLwTPGwiX1
         4ucmQQS18Bo2i/+YFOQR/Ay/rCxNWhtnjfQ46+gKNur3mm5rgXxYdVAZ43TN1QqmOoCY
         hgLSmYWw2RxcVTAEX2qVhmT0m8mm0tAvRCMzxGFay0FcwXMpuWRz24U+TPuDnOr0tbuu
         jciaboHY2pCHGHVc6u/vNv9j6Ylk8lb5A+fa2PZIGVebBjQdKVw06rs3F70BR6ccYM22
         wk+GgZ1bTMypC1lsQqhzippwNgLP4zakoUJaDCK/PF+1+L7jZ6ygK2CInUBgDn0ojUha
         kzwg==
X-Forwarded-Encrypted: i=1; AJvYcCWutl3XGud0EtfaSvRHNrnmL8cooyca4cRXHtWW2qm8u2auNJjJ9tLKksnH25cAScd8zvGfBzI6g1NTEq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxVN4dw+NvrC1nY+7OYaV/Jzq+J+OrN4dnuejOTxfdmh29bbg
	qLbqntgPf583hsE+VDzWpG3QRlDOs2LIG56juWl6D9wdt+xNoheYNZ2l91PvMAq1bUo=
X-Gm-Gg: ASbGncux5IszKNZjy4lvpbftiZkyHHbiHQghutuX3mOnwRyJuwtt+y1CwEz1wlXrYwD
	kCb50i7/tjIF7LuXd6KHaZ/qp+rDgyHcSFbHVbovqlRLK9Nght2rkfFkYfeHHYb8SO37P/p3l0r
	wbxwPs7eYowho6BnaCvmRIKyD/HPZjYxMWSdOlSfZASRcyD1Ffl8hgkPTED1Cy4DM5s9BhR9Dgb
	EfE5NICU6VrNez0cL660SyOyIbzSoQgqyRsSUB902ETyiDWIxpaPE9QQ+Vt1E3aI9JQiCVvE5ZA
	CHzigYrNveBch36/FcUdwZVwevtbFxAOiI7+TbJOylj4IPm6O81KYVyFxjmSTNFxBZu+clmzDHo
	TrhyDTPjnm1TU8O0kM5V3SrgFhNwaSXR8bBhIe3ajn8VFlnC+Vwd/RWcGh4lhsjhW46KnT99sVO
	NtvV6eIh0m
X-Google-Smtp-Source: AGHT+IFA9ek93FErYNmJh5LdN2QDJprClDXAFVaAVFgE+OTKe5HXqKKsARiJ6YdVC5ACPC1UbPa9Gg==
X-Received: by 2002:a05:600c:6095:b0:471:95a:60c9 with SMTP id 5b1f17b1804b1-4711786d054mr173817175e9.8.1761154994747;
        Wed, 22 Oct 2025 10:43:14 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:13 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 2/4 v3] PCI: dw: Add more registers and bitfield definition
Date: Wed, 22 Oct 2025 19:43:07 +0200
Message-ID: <20251022174309.1180931-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022174309.1180931-1-vincent.guittot@linaro.org>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new registers and bitfield definition:
- GEN3_RELATED_OFF_EQ_PHASE_2_3 field of GEN3_RELATED_OFF
- 3 Coherency control registers

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..e60b77f1b5e6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -121,6 +121,7 @@
 
 #define GEN3_RELATED_OFF			0x890
 #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
 #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
@@ -138,6 +139,13 @@
 #define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
 #define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
 
+#define COHERENCY_CONTROL_1_OFF			0x8E0
+#define CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK	GENMASK(31, 2)
+#define CFG_MEMTYPE_VALUE			BIT(0)
+
+#define COHERENCY_CONTROL_2_OFF			0x8E4
+#define COHERENCY_CONTROL_3_OFF			0x8E8
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
-- 
2.43.0


