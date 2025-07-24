Return-Path: <linux-kernel+bounces-743936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C3B105B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6AFAC46BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96790259CA7;
	Thu, 24 Jul 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pxOvWTjg"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1618786A;
	Thu, 24 Jul 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349061; cv=none; b=CeQwgk5BinAtqx/occ8yDMUA2iios2WiRGLBoMjGZD556MMAGebuoG1zZApfrPHKsOwmb2lfFb3s3DfgNexCDEhvDgactzcQLY7yiLVGxN5Gu7O0irhhCip5rwu0ITwkYNuj7+ioRL/ENt3ObUQCGOHGrbnQESYnq4vmrpVC4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349061; c=relaxed/simple;
	bh=5GR6nq99t2pzxzQeEtmg++ObKutiNmHLSCEKZLI4ZEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkMMufF4bK5J2vb4SelvvS9P0PZWeOWfq9ntDeGYWej+CQK0l6VQIBixaC1zVb22lk272lDtALc93gNwhe8gXeY4UhoGRI2UFAjWxLBS5ZyS4IHwU8fom4GxxJvgYKyCXY8v/fq1H5SoIX4PityRJzblKYEjpA9lGne+7RkM2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pxOvWTjg; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XS
	GF/gdJ6rqQR5DxJWjPjjHoQzfiByFGT+DrtnM8K80=; b=pxOvWTjgxwVy5Rfr0w
	+i6orTTmdtTDswJZ8loTXHNKBtnO6zzTSj2F+DWAsaC14CZB5inah1ChafJs4k+0
	dZb1G4DNscP5ds9+5FTD9n3pPxp9S7oRy5LwKjkpnPWhMKBEJHybjjxHtltgh7qK
	1Qnf37hJGzjRJq3EWOgwvnCFg=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnP9wl+YFoFbVMAQ--.36169S2;
	Thu, 24 Jul 2025 17:13:09 +0800 (CST)
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
Subject: [PATCH v4 1/4] dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612 and mp29816 series
Date: Thu, 24 Jul 2025 17:13:03 +0800
Message-Id: <20250724091306.551131-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724091011.550761-1-wenswang@yeah.net>
References: <20250724091011.550761-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDnP9wl+YFoFbVMAQ--.36169S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1rKF4kZF45JrWUJw4xWFg_yoW8ArW7pF
	Wvkr4IyF4FqF47Ca12g3WkGF45XFsrC3ykJa98Aw17KrnI9rWkWrWa93sYqws8Crs3AF4U
	JrsFya409a4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqiifUUUUU=
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiCwSUpGiBt9Xp1QAAsI

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a and
mp29816/mp29816a/mp29816b/mp29816c controller

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V3 -> V4:
    1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
    2. add description for vender specific registers

V2 -> V3:
    merge patches for MP2869,mp29608,mp29612,mp29816,mp29502

V1 -> V2:
    add Rob's Acked-by

 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 27930708ccd5..493e7232f09f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -285,10 +285,18 @@ properties:
           - mps,mp2856
             # Monolithic Power Systems Inc. multi-phase controller mp2857
           - mps,mp2857
+            # Monolithic Power Systems Inc. multi-phase controller mp2869
+          - mps,mp2869
             # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
+            # Monolithic Power Systems Inc. multi-phase controller mp29608
+          - mps,mp29608
+            # Monolithic Power Systems Inc. multi-phase controller mp29612
+          - mps,mp29612
+            # Monolithic Power Systems Inc. multi-phase controller mp29816
+          - mps,mp29816
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5920
-- 
2.25.1


