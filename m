Return-Path: <linux-kernel+bounces-768078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A8B25CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29045585ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C552652AF;
	Thu, 14 Aug 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="RnCy3Eia"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C02641D8;
	Thu, 14 Aug 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155329; cv=pass; b=PgUeapQLrS/a58kq7qCruRZ1gXNClu2AdJxBxiyWaHKuiet/KOL0qbkBQUb7yYUdu3tj+2Jz3cLNlhtCAZbnYfk2o7fYCKl3WxSZ4ofm9O+5W4Xvi1+PnvU1FFC4uo2/3ByJy1AAH4Ma3dgURBx2jpycriyPHLgCdy7PGFg/w9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155329; c=relaxed/simple;
	bh=Kz73ZCQJvQhatb7PIU4bLRz7TI8Eyax0kN2pLgETAnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqq1zqccfXo7zjRBBInrCRm7oiC28t77FAEwS/ed/KzhmSW3BkREACttJwvnCESLxYRgLu8XvYK1xJtJKnsn1MdyeVZZSMmiNYjhOY/NaQhkfbw5wZ4Mk5oe1Jzhbo35hGB68GmjUiGvlKwkErbIiaFXRiehMb0VNiJMJiOzEqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=RnCy3Eia; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755155315; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fvq9TWrcRHeCodttT+NthzSiPn/hIusOH+1hA7/XQi+uve44lr7AyNVq7BaKcpopw9suuO15/BVQdhuH6DstlShjVBwzMqlcFh5o2C31Zq58JzvCZGByJqA49vYGgEkPGRFccRbTAhaoxwKHwjjvROFE91e+wZI9Wc0/c1Aiq2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755155315; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tg01N9hAPr7V+WeucZx1wgz88In+H8Gy9RZ3eJJm1U0=; 
	b=mWmNYIhHnzz7XR9Nz2f83Qv4lBE5i78j8ps6exmdmqSUDMDUPOzCuEoYsR/H+dD+YNVGezqyGrod1hBKfWAzyZ027vO23eEdrl6fc5OUuae3oOx/idr86iV/O+u52OEK7XEhcKoqkc3tQMKYy3hhWu3H0/C9eJ7IuJM+E4MYp6s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755155315;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tg01N9hAPr7V+WeucZx1wgz88In+H8Gy9RZ3eJJm1U0=;
	b=RnCy3EiamG2MV5JSUkoSahSdwpH5PRxQtpddyWyTqBTN8y8yZv/EYof4FV6iBu38
	/vFoWQZMq7vjdeB2SJ8TMMbrCyF8FGVaa266SLpgDS1poPAK6C0E+w4w/0ZMB6T7HHa
	OxjPJ6sZ7N8MxvbUQHj9LkzJ07yJP+dcy+HjGlqokUPE7SthlNv7B2L4YV/65tm+d41
	yGKNacis+e3Nb4LNtfkvsm0EjMtYqS9bhv38bBUO5QbJkB4B3W3DmR3TXyX9aawCFKJ
	uX05/3SuxFy2jgb/62LdCNvpeSCXnnM5tBPU/+q1hbDZSIlJ6zKdwyAfoic5QzA4/Kr
	QOEbpJtUeQ==
Received: by mx.zohomail.com with SMTPS id 1755155312649914.2180861068258;
	Thu, 14 Aug 2025 00:08:32 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 2/4] dt-bindings: firmware: thead,th1520-aon: add a mailbox name for SBI
Date: Thu, 14 Aug 2025 15:07:55 +0800
Message-ID: <20250814070757.2267325-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814070757.2267325-1-uwu@icenowy.me>
References: <20250814070757.2267325-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The SBI firmware might want to communicate to the AON firmware too.

Add a mbox-name item to allow to allocate a mailbox for SBI.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../devicetree/bindings/firmware/thead,th1520-aon.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
index 3365124c7fd47..555465f4aab4e 100644
--- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
+++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
@@ -26,11 +26,12 @@ properties:
     const: thead,th1520-aon
 
   mboxes:
-    maxItems: 1
+    maxItems: 2
 
   mbox-names:
     items:
       - const: aon
+      - const: aon-for-sbi
 
   resets:
     maxItems: 1
@@ -54,7 +55,7 @@ examples:
   - |
     aon: aon {
         compatible = "thead,th1520-aon";
-        mboxes = <&mbox_910t 1>;
-        mbox-names = "aon";
+        mboxes = <&mbox_910t 1>, <&mbox_910r 1>;
+        mbox-names = "aon", "aon-for-sbi";
         #power-domain-cells = <1>;
     };
-- 
2.50.1


