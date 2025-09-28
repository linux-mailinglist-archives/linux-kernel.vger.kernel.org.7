Return-Path: <linux-kernel+bounces-835353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D19BA6D87
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2236A176CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159A2D879B;
	Sun, 28 Sep 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="aDsiLk77"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE1261B65;
	Sun, 28 Sep 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051815; cv=none; b=TSBRHY/Aa2b4yJfXNyJOBx7L67/C1pcoNlb6pBBTsHZ6DHYgcc15AIcecE0qdapIb/bAd5Ki+Gg982qGR86XJo7Opr+Gfum76lO7W1BrbmkgzTZm9eztPeKr56cVf+2CzbS7253tnaJlvoh9ScnYgo5c0iXTChUXg8kTLoP7GcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051815; c=relaxed/simple;
	bh=ClFvh0a6XVFxTs3aTf7ZnAV6BT767LS9PZiwjdEuS+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZvCAQNlv9PWjzX/vLn8rMslLCG2wJJ+quRg3rSl2nK65IQEi8Zr+au6AI6bYU22C7SG6/PuWKk9GwGl2WN6ZFTVj/yTIkIEn3lc256bNNymwoBoTSiF3nx0atPiEclPSJs1meUf/J4c79MrMlsusBXmO0c1jpqSYa+PK8YSmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=aDsiLk77; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8d
	AwrvZ0ngReEO9LbXxo4sA0RRfzQcPeOQ4JXyrALtQ=; b=aDsiLk77uX0uXHagWb
	tip05W5u7rgNgwngHxDZ68IXeaS7tSm45JQoi+fQFbIQPWhhbTVdIwhp53SFfA6l
	1QRrbSSdLyrhbsGI4AgyZYy9hJafw79dUklWlStAlUA0Jsp6vTLay1ucCyDLEK/U
	3Z2ZAIdFrTFeoG7gWQ5xt69hQ=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgA3ZdnP_9hobNCIBQ--.38595S2;
	Sun, 28 Sep 2025 17:28:48 +0800 (CST)
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
	Wensheng Wang <wenswang@yeah.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Date: Sun, 28 Sep 2025 17:28:44 +0800
Message-Id: <20250928092845.1394718-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250928092655.1394429-1-wenswang@yeah.net>
References: <20250928092655.1394429-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgA3ZdnP_9hobNCIBQ--.38595S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrXrW7CFWUZF1UGr4UJwb_yoWkWwc_uw
	4xZ3WDCr4kAFySkan5AF48Jry5Gw17KrWUu34xtF4kXFnIgrWrCF9aq34a9ryxGay5ur15
	urnaqrZ3ZrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbeMKJUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiNhCEKWjY-9CKfAAA3i

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2925 and mp2929 controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V1 -> V2:
    add Krzysztof's Acked-by

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


