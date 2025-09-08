Return-Path: <linux-kernel+bounces-805641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34028B48BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A197A5C49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3833074A0;
	Mon,  8 Sep 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pcKFufOs"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38F307484;
	Mon,  8 Sep 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329978; cv=none; b=DCCcrlxgLdWqVLIa0Dtt4GGaWcCly2P81Eo4FZN+qrXoy0kfLAR8zj/PJHUsthdjCgsDl80T/6xXuYlzve7A/h1LayOfMg4+5S5kxXFYQaHRyOoQB6zPCKGpBu/+iA/Kv1YsWOHKOzuJYftxFuBNwJaEK4/O+BAQqGBDiqRsV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329978; c=relaxed/simple;
	bh=GyObD2013ELlQOtRcm+sEKt8v702ngg3XK5L5afXGlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UK753NnTCaIt+HVs4ynKgZDDUQcBXbZq5Suol2C+zQDHPN2OjDMvPMndZXy8RoTwahu13dikSbD8HiH5A00h0lfNG2UJG7zDxCSl5bWJ9P4v8mkn5P39tkq0j3EvYn7IftQ5dq3BAzxVF4p1856aQBhVsRU1o80/lyeByHS/3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pcKFufOs; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=F6
	6K/bZigkKwjesjWoggrsA3HBERGspKO6WE2pLYiEg=; b=pcKFufOs4Fr1OOFoyS
	SJ19Jp3M39G2r0LmkFpysilh/Z7nXr2hgVWmAOvhC1PrNcemt0MB8vBS5bGNFXma
	XMntpvz0g4eaxYJLJTw6rJIdHmrn4AGwMNYH5aWJ6BFmZwfNReemZyvws3SwKsL2
	02mTo1ahE+ohQ2uSEZRQeLJSc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnDyGQt75oaK06BA--.61995S2;
	Mon, 08 Sep 2025 19:01:37 +0800 (CST)
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
Subject: [PATCH 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Date: Mon,  8 Sep 2025 19:01:27 +0800
Message-Id: <20250908110128.1002655-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250908105951.1002332-1-wenswang@yeah.net>
References: <20250908105951.1002332-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDnDyGQt75oaK06BA--.61995S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrXrWkGryUWFWfWFy7Awb_yoWDCrc_uw
	4xZa1DCrs5AF1fKanayr48tr15Ww17K3yj9wn7tF1kXF9IgFWfWF9av34akryxGay7ur15
	uwnaqrZ3ZFnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbeMKJUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiBBrCpGi+pUA5CAAAs6

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2925 and mp2929 controller.

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..eb617a6c50e5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -297,6 +297,10 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
+            # Monolithic Power Systems Inc. multi-phase controller mp2925
+          - mps,mp2925
+            # Monolithic Power Systems Inc. multi-phase controller mp2929
+          - mps,mp2929
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
             # Monolithic Power Systems Inc. hot-swap protection device
-- 
2.25.1


