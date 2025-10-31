Return-Path: <linux-kernel+bounces-879520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22FC234C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F50734DCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289C2D838F;
	Fri, 31 Oct 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0ePt8LYZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1B2D6639
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889287; cv=none; b=nKxwcwX8U+6Ig2VxI+4oU1gBS1/23OMyGqkmWAoRq86pKoRwnV7/JfWqYMpMUzNRKEcka2tQilsg9KIr/V0biCFn87Ru/W54YBie9bW9h5uNL2F0ktfO6ITYsS2V1le6rtY4FIByc5KzSg6pvsYV2Jouwlz/0dHJExZswwZTGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889287; c=relaxed/simple;
	bh=ptpR3t9yhr/icYn9KOzUfGf3yZw68P61v8s2Z4MoVZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFLy5CHsxgFj+UUPUGNmI0zeCMVkgU2fVwZCgCXzLew3acWUwsSX4C/GPaiZx/+842BnuhlocwKuuN9wj7S2m7T2CYGKXZGyvAThnHvJ1SppKVmqXe9VQV8s5SH+FZRQ0JyEuoxlWutzP6MiLe2oNsHcK79QZvxLKRB7bhwmbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0ePt8LYZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xxDBOK5+bxiu2IhCreH5O5yOABZ9/mrk1d6bX5zFEFY=; b=0ePt8LYZBtL3MXGmNHU0Y6ouSB
	L54OW0dZX/sbl1RgYSrACNBOQocozvoeMAqw6Bh0CYraC1COo87y/jqUl4+dG8peuOVFba8PNUt1+
	k1GglBzhAyUQkmveB0syXY383LqOnMGOFCeXHus+lFu01nQ5OpMRxPoEkTY0hflSLuUSiIJBojltI
	9pXjGUiC3adLC3Fd4Ug2shw8zDrzW2H9H0qf6PIddTWOK30v8QpL116YaWphSKrTj4o1YjZCrVWb8
	wiAF9h1AyITibKL8AAfkRh/MooYiYSfbRdolZbdVSfoPBOv4yEPXjix3qx7jbBqYLyGU6oNzQ7QR9
	squNRKXQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEht1-00000005Q8w-1Cmn;
	Fri, 31 Oct 2025 05:41:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spear_smi: fix kernel-doc warnings <linux/mtd/spear_smi.h>
Date: Thu, 30 Oct 2025 22:41:18 -0700
Message-ID: <20251031054118.1402280-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct most kernel-doc warnings in include/linux/mtd/spear_smi.h
by adding a leading '@' to the description of struct members.
Add a new description for the missing @np member.

Warning: spear_smi.h:48 struct member 'name' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:48 struct member 'mem_base' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:48 struct member 'size' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:48 struct member 'partitions' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:48 struct member 'nr_partitions' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:48 struct member 'fast_mode' not described
 in 'spear_smi_flash_info'
Warning: spear_smi.h:62 struct member 'clk_rate' not described
 in 'spear_smi_plat_data'
Warning: spear_smi.h:62 struct member 'num_flashes' not described
 in 'spear_smi_plat_data'
Warning: spear_smi.h:62 struct member 'board_flash_info' not described
 in 'spear_smi_plat_data'
Warning: spear_smi.h:62 struct member 'np' not described
 in 'spear_smi_plat_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 include/linux/mtd/spear_smi.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- linux-next-20251029.orig/include/linux/mtd/spear_smi.h
+++ linux-next-20251029/include/linux/mtd/spear_smi.h
@@ -31,12 +31,12 @@
  * struct spear_smi_flash_info - platform structure for passing flash
  * information
  *
- * name: name of the serial nor flash for identification
- * mem_base: the memory base on which the flash is mapped
- * size: size of the flash in bytes
- * partitions: parition details
- * nr_partitions: number of partitions
- * fast_mode: whether flash supports fast mode
+ * @name: name of the serial nor flash for identification
+ * @mem_base: the memory base on which the flash is mapped
+ * @size: size of the flash in bytes
+ * @partitions: parition details
+ * @nr_partitions: number of partitions
+ * @fast_mode: whether flash supports fast mode
  */
 
 struct spear_smi_flash_info {
@@ -51,9 +51,10 @@ struct spear_smi_flash_info {
 /**
  * struct spear_smi_plat_data - platform structure for configuring smi
  *
- * clk_rate: clk rate at which SMI must operate
- * num_flashes: number of flashes present on board
- * board_flash_info: specific details of each flash present on board
+ * @clk_rate: clk rate at which SMI must operate
+ * @num_flashes: number of flashes present on board
+ * @board_flash_info: specific details of each flash present on board
+ * @np: array of DT node pointers for all possible flash chip devices
  */
 struct spear_smi_plat_data {
 	unsigned long clk_rate;

