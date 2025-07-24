Return-Path: <linux-kernel+bounces-743919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD6B1056B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466867A7E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A32283CBF;
	Thu, 24 Jul 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RTDUN+6F"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07A27E04F;
	Thu, 24 Jul 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348446; cv=none; b=ZlbaqHDHgIyCI6b5KzvoreMcTKjijqvj+LNy7rm9wSNf1AXDQLBcTpfBEbE7CAhDDjZVAquzpiXrEBry8Cp5m6bZVhUfkqVJ8qsj2zWqikHM5W/POqcXi8rmnCHZmc7MVcVsq2GyEnVICa/OnKLFM0XV9WpsRCBSLvWrz82Vg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348446; c=relaxed/simple;
	bh=TCuSxifzX9CBgsGlRjDPkKP/DAen5me5qQ/q/qMAIZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHkL/WbyCSvtUqZIFczEitiGBqPp8i7XWyiF3o7IIrJyb4k/xTgmXxGlLPYG0DyOLkNNXtaq3Nxun0JyyGCi31XJNE1FPWLK87p0OS4G9qlw2OPU0GuCOEMjVPbi4IR1NYcXmK+xrx5RMDzpzx3hSHCu4NOcI9b1zjrvtArTkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RTDUN+6F; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0W
	mHz61pOuc8mNMwx/wFxfFDW8jE3ZKqr9gWGALrOII=; b=RTDUN+6FvCiN5RnJVM
	JCLg40AbZexLYIPDt2L9lsH/NkgMkZUdPI1NPuis8eTrVSfExxGai5gPqVMap2h3
	Es+gLqphta5ymyvgyLs6KwQ+Z57LVKZgj7R8ksWc3Ky48Ab5UJnMTkwnbsM2lXGL
	1AaYHG3ZuhMqgy5IPHidjulbE=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnP9wl+YFoFbVMAQ--.36169S4;
	Thu, 24 Jul 2025 17:13:14 +0800 (CST)
From: wenswang@yeah.net
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wensheng Wang <wenswang@yeah.net>
Subject: [PATCH v4 3/4] dt-bindings: hwmon: Add MPS mp29502
Date: Thu, 24 Jul 2025 17:13:05 +0800
Message-Id: <20250724091306.551131-3-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724091306.551131-1-wenswang@yeah.net>
References: <20250724091011.550761-1-wenswang@yeah.net>
 <20250724091306.551131-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDnP9wl+YFoFbVMAQ--.36169S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrXrWxGr4rZr48JrW8JFb_yoWftrb_uw
	4xZa1DCrWkJF1fK3Zakr4kAr15Jw17Kr409wn7tF1kXF9agay3KF93t34a9ryxGay7ur15
	Cwn2grZ3XrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbA9N7UUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIAsDp2iB+SsmJAAA32

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp29502 controller

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 493e7232f09f..2066696ecff4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -291,6 +291,8 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
+            # Monolithic Power Systems Inc. multi-phase controller mp29502
+          - mps,mp29502
             # Monolithic Power Systems Inc. multi-phase controller mp29608
           - mps,mp29608
             # Monolithic Power Systems Inc. multi-phase controller mp29612
-- 
2.25.1


