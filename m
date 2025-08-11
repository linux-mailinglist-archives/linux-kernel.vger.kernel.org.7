Return-Path: <linux-kernel+bounces-762202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818EB20359
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5973A16E2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9452DCF79;
	Mon, 11 Aug 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Z3MPyC/y"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A092DCF74
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904458; cv=none; b=Rvnsj5WXmKOexHxi8hJBdcSk2k5rqLcmWnKhQ8QsgWP7FLccxCpvrY6t+2us42O708bi0/bmwVihb7fPxerWumcWvlN6/sF+VZOw0gSNZ6anBftEyvc5rIZSzU5E6CDkHnH3SYS9sEhlRtXvMWDGoJTIXGl7QPfzndfB56q6BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904458; c=relaxed/simple;
	bh=B6OgfGWrJTmOPWVma9W95ySOuNbVX75iwTf6/mPCbQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhwUaOYvtguU62+kOzBj+gDNW3Va/jboKGQlxjMFQk7Hni/OHkbJiuTnyv7sN8ySGXYrWMDw2StEamslPOzL3enRXOaV6yak9RQTqWduOwqtHyFPwC+wfGbEQFJQEDUOorQUv+LViu+BtqjANgqOXds/pmBWwxxAE+3IXY1fJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Z3MPyC/y; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36672 invoked from network); 11 Aug 2025 11:20:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1754904053; bh=3umHQDcb0zjHfkJbR08wpJ0dPt9WRkjKc/Qo2lTT0iA=;
          h=From:To:Cc:Subject;
          b=Z3MPyC/y3Fqc1WPlf/+le4mK0yu3Etq/U9OFZZfT6GVqk2vgmiOprsdeaPVjVpySJ
           ml11s/0l90KsBK4TFZD1VIDw7ijqLclFkJyahC7rR0F83ogZoQuBl9aM5gRFT6dQT+
           M6UE7lzO9Iw9N74yzSjAsZYXZ8adW8CLRJAS6KGNWfuxG9Z2bwz0UMC7gGB4i0LoMI
           N0O37HdhpgEwClHk11iGQpZaiQwuG/ypc/2lt/TF8cqm6FyNjObv2cZjhQD1EvjnkS
           myTKjTCUk05rpddlIKqyOjCSCVjO9GrZrxXQYm5mnt4F1NEGGeiCDOiGJDXsTT4oxZ
           FXCkHc/9Xwh9w==
Received: from 83.24.148.125.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.125])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 11 Aug 2025 11:20:53 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	zhouyanjie@wanyeetech.com,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] dt-bindings: mips: cpu: Add MIPS 34Kc Core
Date: Mon, 11 Aug 2025 11:20:36 +0200
Message-ID: <20250811092048.497087-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: c31b38db7f8f9720d512873d28b9fe54
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [0WME]                               

Document MIPS 34Kc device tree bindings. It is used in the Realtek
RTL930x SoC.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index 471373ad0cfb..d3677f53f142 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -33,6 +33,7 @@ properties:
       - mips,mips1004Kc
       - mips,mips24KEc
       - mips,mips24Kc
+      - mips,mips34Kc
       - mips,mips4KEc
       - mips,mips4Kc
       - mips,mips74Kc
-- 
2.47.2


