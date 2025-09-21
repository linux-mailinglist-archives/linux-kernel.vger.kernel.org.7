Return-Path: <linux-kernel+bounces-826407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243AB8E70A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71EFA4E19C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B32D595D;
	Sun, 21 Sep 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="ahA6ZYhy"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004752D63F7;
	Sun, 21 Sep 2025 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491152; cv=none; b=LhkYaPAQT9Mkz/7u0v5a4YrUS/h4mkfX+9PCOmSJHpP5jGem0lBFVNfxtKvadCQhYqZSWgDqEMs3NF15RmibDieF/lNerJ3MNt6biuTez6PZuh+ZGeGmekJeOuRIrdvrYugnpV25EJzjp/qzNqQ1/2r1kVwz4rffyIzGmz33Pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491152; c=relaxed/simple;
	bh=o7eB8nx62ruqkZ1cisxZnkESzSSW5nwWcjDXVrj0fTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXXLE77LRprS94vIhK61nHyoRN7N5/rhXaxsmiI3WRZD6/jy+2lutohnx2ork5It2CcTJFBnuqvNI9SFLUA4DpW+1Z/H9BU3oztFy8N9X/y3XRlWTet+/4VH981S2fNfYVdhDBkgpVdh7SUL6gRI2WAUMrZzb+y/xJIM1oqSIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=ahA6ZYhy; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=J6mm7ThCUa+BZCqJW1oZ8znjpYf3rY1SySZcweF1uO0=; b=ahA6ZYhyoOv7CDJB2kGvlQgCoY
	ifBRiDbpnK4t32Lx3+hn4chHV6m2q9ebDtstjuJabtvzeD6Q2vDZ6FT3fGvQtVIQKCSD31G7nW/m/
	VbipN5TMw0eYmwTo1/qIQ1AWI4JCP3KbN5esjArjqO3ZAkWqUcdqCjv9XrROLHQnMs+Jv096CnitS
	nh1egHEpqtb4rJig94Nqsm7AhOx9RXmZ+KHz0YoHkhglFTPGGSWUTQqX5ErPaQZpd9Ii3N3HWbtFH
	+Ecwyqka6P27poKzrxVFPlco/QRmjgiirsk9chRmJnz6cTj2X5fu6dk4LC0Xr7d1Rpm/WGz6Y8KRX
	GR450Yyg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v0RCr-009Lbu-1A;
	Sun, 21 Sep 2025 23:02:49 +0200
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
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 3/3] riscv: dts: spacemit: add i2c aliases on BPI-F3
Date: Sun, 21 Sep 2025 23:01:43 +0200
Message-ID: <20250921210237.943370-4-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250921210237.943370-1-aurelien@aurel32.net>
References: <20250921210237.943370-1-aurelien@aurel32.net>
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
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 574d10fdf9b82..a71eaf1c65deb 100644
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


