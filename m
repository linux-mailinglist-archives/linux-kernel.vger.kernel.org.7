Return-Path: <linux-kernel+bounces-834488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23FBA4CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C713E7B163E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2030C622;
	Fri, 26 Sep 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="e7PBS4jK"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C502FFDDC;
	Fri, 26 Sep 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909531; cv=none; b=F9vCU1gSgJ//hrW0j5HzigEPIgrD9NWbBralcQj53yJwLSM3h3L1Dr4NepEcGgCzXi/B3HI8FWqAbNxmKIj66gCXuDe0GBaLgIyEJmNsm4UBeEcHRPL2cGhRg+3+jUtE+L4LCuY4xLEA+uLFKf03Cgh2S5mfaaKoExE3fOoyAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909531; c=relaxed/simple;
	bh=LG69madij41ZMMW1hx8tvlvRGKIWzgQJUyjUCaWOvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKu9gNiRCWXxFIxGe8mxcAi5KNBEz9wdd+WtbmeXCKaklJy9bFZd5o9g4w42mN01jaCnsMQDcMGe4bizLuj8QqLfmFzzKbmK5S3rDz61exDUjD3a1MfiKRUvUdYq8/XkC74/Ovp4SLCyfX2Rkz/BHuP7FgV/IKfYNyspZRNVUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=e7PBS4jK; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=EEu7biapiBdas8cXmb0lL5a6fqTpV61Rsm04KjOmPZ0=; b=e7PBS4jK5y+nVjufE9if/QA2Wl
	WMw/HnzaZ0e4vrH3DYSgD1qwvMv+Zydm9u1ozl0sTDhZezh5VHEKOtoLkRdUTmtm80MNNHAl/DMWU
	uyWznoKgaswHn7B4aa3mOTc52vV+blasH77Bm1H2zr2cTdqEDM50X1QXgZL9QENfgsC7S9jhVMp9Q
	XTMMmyPsmd+4URvm1rHJTIK5di6JP4343DCdels9wKSwi89OCNNc3S6iTyW6fbBjLPqjyPEZP1KxP
	H79Eh8FPaxpEdwq9Skcg+Vui5I5jH8NBc3dGTGxFI+ayufQe5sJK5DGg/cy4KRR6ydO+EMMghNNn5
	D/9PeExA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2CiP-00GPWP-31;
	Fri, 26 Sep 2025 19:58:41 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: [PATCH v3 3/3] riscv: dts: spacemit: add i2c aliases on BPI-F3
Date: Fri, 26 Sep 2025 19:54:39 +0200
Message-ID: <20250926175833.3048516-4-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250926175833.3048516-1-aurelien@aurel32.net>
References: <20250926175833.3048516-1-aurelien@aurel32.net>
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
index de10b1cb00aee..3a01ffe92c0f0 100644
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


