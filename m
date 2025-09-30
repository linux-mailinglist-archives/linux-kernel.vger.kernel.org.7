Return-Path: <linux-kernel+bounces-837479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160DBAC66C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D759C1889330
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092342F747C;
	Tue, 30 Sep 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="p9VxmwBw"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D02F60A6;
	Tue, 30 Sep 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226657; cv=pass; b=lQFJNFu9QPT1OCmKwlu5fvlJfPtky81gwEj5etR4AqyAGsLDPezad4PtxfO1LucJV4K7f2zfDOPULkrQuWZMRWHVZGvWkpe8QHcOy7Ym5DGqt5gwKjvqfcOLhz11H4Q8NEKRYGfmMti6PeuDdYqoVUwhFUoW4oIP3VYfo4i3jhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226657; c=relaxed/simple;
	bh=QTkguglv7p9i6K1aSSZXYz/u77MBFn8qpypGMnmXbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAFx8/zm4sKYYYHzcIFayHNWCYIkCBwmdhFuBttOLyFdUGn0mGtfhARrF2NfCGQ7rwj1qZh7NynFAoqtidvA0yO5j51Wk3u6ugy66VXqD761uwyE2UTBr3QjZwzEmY4DCEUGn2kyVKQPolJGXclbKyMqqY0NfCDBCMLFLipLyG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=p9VxmwBw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1759226622; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFyA5s13TGp4YMP4M/gm0d2i+4oQiLGVPkahAPQhgE2OVdXLvhNYusWZzfFwH8T3XNoZU3wutiasCbIZAtI08Gpl+sL5y6oQVxL6f2yvR+KSyYf+uCGRrqHSbiFkFFSdWXqyIYGsUIs7kZr++iMMXj7Zi3z9XEAUqUjhaNbIIII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759226622; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tl+f+Pgxhudu6lRBZrTcBlIXtgXTfSiaBeAZSwRQqlw=; 
	b=T2iFLgEw5e5KL0hai8TOt9xyPfszNKlneXtT/3L4i/LG88Y7nvZGlTMJbNtpCQbFIcPapRsncizGClTZGG0VUjEgT2Z6ltxoGnzR/cPOmnDcIy3G1uqEwyY8hmSOeXngBH2T6jJQv447erGV7D/Vr68Rd8c+o3/9Bdkd4yr0/oE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759226622;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Tl+f+Pgxhudu6lRBZrTcBlIXtgXTfSiaBeAZSwRQqlw=;
	b=p9VxmwBwBbyjrOuf06SdFrfMNjMgfUqtGRZ4/WKhRCgTvww3DiXvHh0kxi2l4ePU
	Oxiugjd8Vy/s3j6qwmnpbAuj2SlGeJGnjz5NW6SKf81eJ8mgSCmbarEqk/X1JnVPEeY
	ZKlFF0BZIN9j0kM7tm1M7dlsP4Z5tiUDoDyN0T0qLXDH1KBOdPyrxxkuUKKmWqOCxpY
	y+1/NwDtkVDEx+b+ob8QMcblk2JNPZPIKM3Jpy6pHZpkL5q55QPpAOhLT0jMuGMs1yo
	Br60e+cnQhBGQwv9xoEcVlNRpywBPkdgbC2v05gxQHvq17fYd293L499u3s9lMPXWsn
	tnk8e/ZPnA==
Received: by mx.zohomail.com with SMTPS id 1759226619881894.4752828267287;
	Tue, 30 Sep 2025 03:03:39 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Yao Zi <ziyao@disroot.org>,
	E Shattow <e@freeshell.de>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 1/2] dt-bindings: riscv: starfive: add Orange Pi RV board compatible
Date: Tue, 30 Sep 2025 18:03:17 +0800
Message-ID: <20250930100318.2131968-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Orange Pi RV is a newly released JH7110 board by Xunlong.

Add a compatible string to the starfive platform DT binding.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 7ef85174353de..dd5cd51e38797 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -31,6 +31,7 @@ properties:
               - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
+              - xunlong,orangepi-rv
           - const: starfive,jh7110
 
 additionalProperties: true
-- 
2.51.0


