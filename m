Return-Path: <linux-kernel+bounces-755585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3129B1A8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA63A91C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4510214209;
	Mon,  4 Aug 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozMIoOBI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB51CDFAC;
	Mon,  4 Aug 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329991; cv=none; b=ivS8S1JvsTrsPkHA+Wn/NY8WL9CB1lwi02lv/C5Z8ywyq53XWDsudIuQvv0VYRyDdkq/yzlx+kPuw0tOo6AyJx1YoQOdxfOFf06gal5LbQiuJlFqV/JPzrWSaMxXwm4/oKMD5z4UNQuE7igiGcSsMABANKoNXNmC55sY4pZUtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329991; c=relaxed/simple;
	bh=4ZUewZb/IJjlaLFe+A4oMDhAWXkvNOXghdEp4eD0OD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlOosR3K5sYfT8Pd2KnuVGjS/ZZvUgfdNaIcgKCiOSTZv5xTZCYN4KGZPB1cy6NOFWMU66gBRf2csosKLf1pDiDhTDB8P2btq8zvFFlCjzrNnsk9gZc4QEXyd5cqXOinquWY9KVx3vV7OLCWsM8rvtSKBMR2qe5vBBYovo1U5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozMIoOBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923A6C4CEF0;
	Mon,  4 Aug 2025 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754329990;
	bh=4ZUewZb/IJjlaLFe+A4oMDhAWXkvNOXghdEp4eD0OD0=;
	h=From:To:Cc:Subject:Date:From;
	b=ozMIoOBISKwr2JV3D/sMGQTxDbcQn5xF/tQlODetA23NvpZGP8LMuvLc+cEeJRc28
	 ACgeI93TefDs4JXwcrBOc0k9igzee94mxxiEhrj+K8q6b6NDgmQTVdHxVCc6LOUlMJ
	 HHDUVvHJG7p1HIWcvClKESErC6Py2lgoAL91eNyG0SEKlsDptM1ly3CJXHZR0XwcKf
	 bDp7kXbB6nfShwQoeUx6vk4rwsoI97CNw6sLdoQyVh/Il5xdtDXfDcSfy6UVvgNLI1
	 kHmwRrSr5MSmyqnSgnLfl9jLx5sqTcw/G20oVt3yRFw4dM8QMGzYmf9FDu7E33/+QH
	 MI0iLW/kbmnEQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Remove unused fujitsu,mb86s70-crg11 binding
Date: Mon,  4 Aug 2025 12:53:03 -0500
Message-ID: <20250804175304.3423965-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fujitsu,mb86s70-crg11 binding is unused. The driver for it was removed
in 2017. It's not used for Synquacer DT either like some other mb86s70
bindings are.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/fujitsu,mb86s70-crg11.txt  | 26 -------------------
 1 file changed, 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt

diff --git a/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt b/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
deleted file mode 100644
index 332396265689..000000000000
--- a/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Fujitsu CRG11 clock driver bindings
------------------------------------
-
-Required properties :
-- compatible : Shall contain "fujitsu,mb86s70-crg11"
-- #clock-cells : Shall be 3 {cntrlr domain port}
-
-The consumer specifies the desired clock pointing to its phandle.
-
-Example:
-
-	clock: crg11 {
-		compatible = "fujitsu,mb86s70-crg11";
-		#clock-cells = <3>;
-	};
-
-	mhu: mhu0@2b1f0000 {
-		#mbox-cells = <1>;
-		compatible = "arm,mhu";
-		reg = <0 0x2B1F0000 0x1000>;
-		interrupts = <0 36 4>, /* LP Non-Sec */
-			     <0 35 4>, /* HP Non-Sec */
-			     <0 37 4>; /* Secure */
-		clocks = <&clock 0 2 1>; /* Cntrlr:0 Domain:2 Port:1 */
-		clock-names = "clk";
-	};
-- 
2.47.2


