Return-Path: <linux-kernel+bounces-826408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1DB8E724
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0125B17DC41
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6B2D8DA9;
	Sun, 21 Sep 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="VMJrVDCU"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA92D8790;
	Sun, 21 Sep 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491157; cv=none; b=U0f/uIfaSL0VnqvaY+M40AHHI/313hakXDmKA1Ik5UfKsQ4CoU3W0Cgo6RpjWwW66cHEgFBjZ4gjuZ8bR1dOwH8DNk/wrxYBzRTsHAiK/pP/V2BeiSH/Ht4jlKdNUsznHF8Nff/m/5T/UbRclgSAxrPaIYW3fT0aMRrsk/qiZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491157; c=relaxed/simple;
	bh=h4qJR2pDdTQqvNkvOtZShgDkPta1n+vG/zTi9XLKvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N437pxMINh0LBYZBVnh8tVAegLGCGqSeuyKdamEX4aeRojv9kOuGQAF9yevJzQRlrF0uc1TjjrpZ+JwSqD4jhaQ52+nt8C1lsHhamHftm+o3izppxb1cl7HpAoE+7PQetJ8wVNBrPs3ZD4vBiK4BSrnDaghRzwa9o84KId8qbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=VMJrVDCU; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=cutiYl0wANGDLRaXIM0wgr5qojCK4TIzTyPKOVMBJ20=; b=VMJrVDCUvBS7dnOXzDFDjf+EVg
	cwXqXoaWOgrh/iBe7rJD9MyyqNS26Aypw1zVdQMyAaeMKwxGEdRsUtgriV4X56b4fxsNkLaM3Vwnh
	wv7SgID8k3mvY8Umo++fyHWNbsm0ucad0I3OLnJSGNN197RktI5kOVEajbfy7IVLMzyNgex+iKsr1
	wQ+LGr2Jip+TwgSuLlmDCe+DM68q1Jn6NoUl0mlGFzr6Ewhs6PX4Xz9EbVgu5jKO8Ti41jeg8rD9w
	yqzXNFdSZpWF60ka7sEBzMwqB83+aADyuUtT88tHyAFkOduUSCUmQpaC5MaoTOl+qco3FoHLOkEIV
	sgHXmQqQ==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v0RCm-009LbD-2a;
	Sun, 21 Sep 2025 23:02:44 +0200
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
Subject: [PATCH 0/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Sun, 21 Sep 2025 23:01:40 +0200
Message-ID: <20250921210237.943370-1-aurelien@aurel32.net>
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

Aurelien Jarno (3):
  riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
  riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
  riscv: dts: spacemit: add i2c aliases on BPI-F3

 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 19 ++++++++++++++++++-
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 13 +++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.47.2


