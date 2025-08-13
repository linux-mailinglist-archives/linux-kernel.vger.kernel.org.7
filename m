Return-Path: <linux-kernel+bounces-767540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EEB255C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D338724D38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AE3009EA;
	Wed, 13 Aug 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N3/8Ha0y"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AF3009D1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121342; cv=none; b=dzGl8Fy0lswYqgxDmQTV/dQIfM8wcsc2qsk1eMhXKrsXAka9Uuu5mqxMdBN8DWseYYdK3cHaEijcew/8AW5Ty0ZqoOTHOfMKTi7KOfab34PeOpuzVNebO1zKBv4x7rggbU3eQ3xMX1r3EZoFhnDcve6trkL4u85IKHmFnQ36sPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121342; c=relaxed/simple;
	bh=mmkO5T63OUN+grA8UT7sY7wpCkdHqG1yq3BsZK+INMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N89MVDTl6jaM0Tsy/oWDdrOGXqSHUnTQSlxZRG7yqBOvbNcTQdfJKd+3syRF7zmc8pN31flpETrYEjxIikkyq4AVlx4PRbH++uvZt1ntjKqPDacpeIpVAowg1QJY7ysTdD2Zoh3I1WgRgA9ejNj+GFwOmUF5EwRpLfxTcUtjuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N3/8Ha0y; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfec32238051;
	Wed, 13 Aug 2025 16:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121300;
	bh=QCw9ZRUBeub09uFvPQECFJsWt5dS1/m+zZsohfeUKA8=;
	h=From:To:CC:Subject:Date;
	b=N3/8Ha0yi8GyRekTCrFV3yVdC13AEQGJfrlGGkSszmDEXeGSfWR0n3sObGPfi8ct5
	 1ML7k6o5iT3P7wp78uc0k2v0NOlqUPiAH3zapHt9OWD/Y0PPPTmj1k/t3zuaF0YZf7
	 sKz5bjmhoEOsAk+WoZTHIuK/+z/WJv1N6nRpkng0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLferc1363621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:39 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNF2611079;
	Wed, 13 Aug 2025 16:41:39 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/6] Remove register_restart_handler() from drivers/reset
Date: Wed, 13 Aug 2025 16:41:32 -0500
Message-ID: <20250813214138.477659-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello all,

Continuing to remove users of register_restart_handler(), this series
removes the remaining uses in the driver/reset subsystem.

Build tested, but I don't have any of these platforms, so some
sanity testing always welcome :)

Thanks,
Andrew

Andrew Davis (6):
  reset: ath79: Use devm_register_restart_handler()
  reset: intel: Use devm_register_restart_handler()
  reset: lpc18xx: Use devm_register_sys_off_handler()
  reset: ma35d1: Use devm_register_sys_off_handler()
  reset: npcm: Use devm_register_sys_off_handler()
  reset: sunplus: Use devm_register_sys_off_handler()

 drivers/reset/reset-ath79.c    | 12 +++---------
 drivers/reset/reset-intel-gw.c | 11 +++--------
 drivers/reset/reset-lpc18xx.c  | 12 ++++--------
 drivers/reset/reset-ma35d1.c   | 11 ++++-------
 drivers/reset/reset-npcm.c     | 12 ++++--------
 drivers/reset/reset-sunplus.c  | 12 ++++--------
 6 files changed, 22 insertions(+), 48 deletions(-)

-- 
2.39.2


