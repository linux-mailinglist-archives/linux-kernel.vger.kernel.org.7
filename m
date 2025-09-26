Return-Path: <linux-kernel+bounces-834489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA976BA4CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90141B25F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57230CB50;
	Fri, 26 Sep 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="i8h6KWdp"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC3305943;
	Fri, 26 Sep 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909531; cv=none; b=mj9ijD7FaYxWPLnBhN28TDUkzsjnXWkquAlUtfb9GNlxGnBsBGrOnXFwdgNhUfRsHmLVqtqKPSdQKjQhcx+zazgjE2n33eO+fpX6iFJd0+AVRzrBv0Bziizu9xGw2nM7LsWllcISvMx3CEic5R+KQd3Cc21SiFLBbsKjT3QliCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909531; c=relaxed/simple;
	bh=gWHg2lPa9MNLOOb/sYA0T3DgiWQzzoTV4WIi3EQnc5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVtaK7Ip8MgWTenYsjiZy/nOexNo5ndZ2dC8Uj7gberExgUeJG7T0vlaoe6bbnC09kMsfk+myV/wegjMkxDobB2B9cClnUhgwuZSyGPxErrTNJo8kq6FUG+6QLMl/Zhu7xo+wrWsHf6kTtGUbmtQg/VyiTMuu0roplMVvDhMFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=i8h6KWdp; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=ddGZ1/Ar7m3TEGD6GxrlzybOX3lu01Igr3wsVjMtEgI=; b=i8h6KWdpRrYlAfR07pFrcfZ3w5
	W8v3nfjz/DzK3TeGM85vUcjgYHyFQbxE/oGFOl3PpMdB2mRjobdNxV6U4kA3ENxaGl5doBk/YRAng
	aQNq0C+ts7bYTaaMSoC7Ve8wkzo3BMqFyL8RW8D76GY17VSdK1W5qlRlrFwh6eLJArjnEi1uz0vn/
	VY+Y/9RvKtzaWdrpvR+24YMGhveO9mStavfW5xytzy5l3z/0KaiJR9Y28qQTc2V8mdbrvXrMdvqAu
	QtUSIvuNevvSQVsxtcNdG9ij0Un73pojSxx6zsU309SMA1qkjr07xWl/CdAkgJmk9SWM5aONVJa9b
	Jx8oe2hw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2CiP-00GPWH-1C;
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
Subject: [PATCH v3 0/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Fri, 26 Sep 2025 19:54:36 +0200
Message-ID: <20250926175833.3048516-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPI-F3 board has a 24c02 eeprom connected to the i2c bus #2. It
holds board data. This patchset adds support for it.

Changes between version 2 and version 3:
  
- Revert the name change for i2c2-0-cfg and i2c2-0-pins, the second cell
  is not a function number, but an index.

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20250923205028.2355244-1-aurelien@aurel32.net/  

Changes between version 1 and version 2:
 - Rename i2c2-0-cfg and i2c2-0-pins into i2c2-4-cfg and i2c2-4-pins to match
   the naming convention encoding the function number in the second cell.
 - Rename the 24c02 supply name label to buck3_1v8
 - Add a onie,tlv-layout nvmem layout describing the content of the 24c02 eeprom

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250921210237.943370-1-aurelien@aurel32.net/


Aurelien Jarno (3):
  riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
  riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
  riscv: dts: spacemit: add i2c aliases on BPI-F3

 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 33 ++++++++++++++++++-
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  7 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 13 ++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.47.2


