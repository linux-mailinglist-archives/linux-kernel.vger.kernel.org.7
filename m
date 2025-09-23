Return-Path: <linux-kernel+bounces-829645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A17B9786B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CDB19C6A78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53A30BF71;
	Tue, 23 Sep 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="rXJ+GSaS"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED5303A1A;
	Tue, 23 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660655; cv=none; b=CAshwVg2p8Cj37Ds3K1FAEe8vlGDn5rm5aSh6ogDaiWKImF9h2srJmIlkZdOZJ01nNaqtX0jr0PGxuo94Dd8hDsu4rC/Z2qKYeiheFWP3uQa1a79NHXe+nunt9tYie7ygNzM3Y03cCHxNb+Kib4qjgw7fC5Ijf4KsDIcoZ/qN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660655; c=relaxed/simple;
	bh=g8TShsqhtnCVLFK3XmVOutswlEcioPko7HqYlJkMYrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXOHtiatWXsCs91HV4iFEd40AYT5261D+BY6M7FPmN8RVGOPZZi84zztAdQ1CXvbPvpZZX7KLSYwJnHC4vp0Tv9vihCqn6uVNh3uGBFHgFhAnVOzZH52rzCpbGTTAf/ySafpO4TumP+jp2/76qea8lT7lMUVTj5RHlSHQZ/cgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=rXJ+GSaS; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=gXFtWOZltPQ79FAzcMiIAfmUK9cn45ibixuAZ79/ZLY=; b=rXJ+GSaSBu8gpPaq78ceWgykof
	yxTcnDd4v/r29b6MA3y5T+c09mv4cIpGVFBvHEBq9eVjfXUurqZ9UHJylIsDct5+dSTn/cX8qXxP8
	T4467Fehao0rcerO7pDuiqkP6uRt2HrQxolLxRfmggg0/HSWo6/29tmmnlhfCrrWPLXj0jEseqHCT
	K/Q5Je1B4+4nslMGpgjdIoTEaDcrOWNEJPRTyXfp4IUnH6/1MUSj3tXOQki5yV0dBix9ShHERjjc4
	l/8DJMC/Xut2wk+O7SEV4aB9/qhkfbDBD1/xx2CDuZkBhCtaXs1/JajciwBKUcpGHCmd4mVLSnM2m
	WLh97BHw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v19yK-00CFVO-2P;
	Tue, 23 Sep 2025 22:50:48 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: [PATCH v2 3/3] riscv: dts: spacemit: add i2c aliases on BPI-F3
Date: Tue, 23 Sep 2025 21:45:43 +0200
Message-ID: <20250923205028.2355244-4-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923205028.2355244-1-aurelien@aurel32.net>
References: <20250923205028.2355244-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add i2c aliases for i2c2 and i2c8 on BPI-F3. This is useful to keep a
stable number for the /dev entries after loading the i2c-dev module.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
v2: no change

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 994bc23cc1023..b2ef0596168cf 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,8 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		i2c2 = &i2c2;
+		i2c8 = &i2c8;
 	};
 
 	chosen {
-- 
2.47.2


