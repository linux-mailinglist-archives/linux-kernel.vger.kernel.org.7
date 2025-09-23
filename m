Return-Path: <linux-kernel+bounces-829643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD9B97868
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EC23AEE34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8D30BBB2;
	Tue, 23 Sep 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="LxDvNElP"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A502773C1;
	Tue, 23 Sep 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660655; cv=none; b=On+RcnunckSapbRIRlpLDBTqZywSEcuSXFpcEfKZMF9p/JKsKk7PLUZCIAPYRQQOYD/jnFz5k1bil9coLouSRA2WICcJNUgBd+lUuZj7c5GRB0NYfJFUsg23UP1lzIgflA2ha09RntY29ix9G4bTQJcmLxmRwUkcqDRNeMsVJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660655; c=relaxed/simple;
	bh=k2jzIDDmspjwXyj4GUO5SC1gH9x7vbHoHrWV1a9+8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgHpqt3SUFfh3nSrKyNPDsPoWMFEyXZsCTVxOlArQz8DjVjyMZXFKh9pnjBIrRgdAqmQsYSm3hI52SKszT0ePMw4nXTYEAAQcPFjnQ9YiEWu5us7Pqtg269jWgJCv5oD0JuOKhhRKL9LUuAAkfq6KnzUNGkCSV2w7sMuhq+wNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=LxDvNElP; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
	Content-Description:In-Reply-To:References:X-Debbugs-Cc;
	bh=S782zCaiS6n+iFj//HOlJ9oomrbwBysU57bfvWdg/Ng=; b=LxDvNElPgk5gLFeu6Kcq74YXve
	7aeh0EZNYcnYz7ScFUCjqwjqHhzLdJjVBUUP4puXPvT69tg6GN11GGyGy0+JhPqAYEchlNdeK1Zre
	iPCVWpQagZAh1neyLI4flPI1NTHOdMyuHIHbYHr/i5Nc2HSp54pMpmnql9DMv673xIkE8uDqDrAHB
	y4jNuo/TTeCI5oSw2tllsod/24V7PCiRRxx8ZLdF9+aeVRhxghvrlf/7fjz5zUOjA4+OWNq2sK2xo
	Uc8Jmf0lepEToiP7o3Wl8MqFaFmjXM4Qdda5MxGIZle6e/3Z29Bvi4A6P/aHZzedO61hIYN7354bM
	uQF1bzyQ==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v19yH-00CFUe-1x;
	Tue, 23 Sep 2025 22:50:45 +0200
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
Subject: [PATCH v2 0/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Date: Tue, 23 Sep 2025 21:45:40 +0200
Message-ID: <20250923205028.2355244-1-aurelien@aurel32.net>
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

Version 2 incorporates changes suggested during review of v1.

Changes between version 1 and version 2:
 - Rename i2c2-0-cfg and i2c2-0-pins into i2c2-4-cfg and i2c2-4-pins to match
   the naming convention encoding the function number in the second cell.
 - Rename the 24c02 supply name label to buck3_1v8
 - Add a onie,tlv-layout nvmem layout describing the content of the 24c02 eeprom

---

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


