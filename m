Return-Path: <linux-kernel+bounces-764035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4513EB21D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E281905761
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054029BDBC;
	Tue, 12 Aug 2025 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="A+1wIpON"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168F29BD96;
	Tue, 12 Aug 2025 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977416; cv=pass; b=YR6DjlzL73BTvVHMxKt6Rdg0ru/82T6Ew6JhGHirDad/BvrwrG1dYg3tKAyXbnqF1uxPcC8Csu+Op+Qn/vhiOxxIGcZqsw63hKGihkk8sz+/b8UjuREzreL+W+FULYYcZoFvcMz28TzD9OX9crlGRV2JLlsVMXiBpY5N6i2jzrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977416; c=relaxed/simple;
	bh=bh/Db1KHs7GNIXYtK735ef/NGxKQRs0jn6cR78ocYNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOopFud4XMb/3LSgVBjIyUFkWNSLU3WEGIwcU/SG2k0xajviLBZkRFh5/nyiRDv+1ux6yaRS/ZI/fnocqR+55VsOyLLqxkfMxMLyIM/kpRs1YmWCtJwgStI1wjMWkMVF7BbivnBpa4zIHgR5OGTcgbn4uW4OdKGhNwGKloBSnNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=A+1wIpON; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1754977396; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BrBGm/vA4NzG7o7uj5qjFNzDvDw74Kmterqa2XgiiCV2Ho1W4tlrgiERdmGuXls+AGbR3V5UvXGfhBJvKRTeR5MbzO5ga/i2pdmMfVUhwDObPf56Ez0c6cswE1THgC03TP0dAEW4ZwGKaOxoYYQFcULrBh/9BWsd9dVpZTq101w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754977396; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pA524d/aKpZyY20fSlZrDb9/G4WDB7CsquWn7adUTYc=; 
	b=n/mdmUFuumwC68cdBL2WocQOVOfclfkDGDV6WA359thzGSWpzsGKzzVyPTvleumAoCRcxomhopVpgN5v+p0pQq/o8IaYfL98zy2rfx6V1ugD28IEqko1UniZ8PCoQFduBVj/iX8+1PQRYG7ZorbJnIOGHsw8hui6CdodAjFES6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754977396;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pA524d/aKpZyY20fSlZrDb9/G4WDB7CsquWn7adUTYc=;
	b=A+1wIpONbt6KdAeW2suguNZ5G+FXc24a7PTbFjOCPIcrWTLFv+mVKK8fS67ydlzw
	CMvwCoQQbyJDfbG6IqK6IGdDzMlN6OS5YKNqCMz2pZGAjHpbjLE+N35W5MDq2iK2/04
	YsdaInTGFCsVzYZusnD/J2Q8A4mNoK2nQHfMeEloQUCQ5WYw6V8jZI+/dufXBp1RKPG
	UaG3DJmLDoCPcJpQokWD7C1b3E14JlOcBoDNtoi8P5FSgj38m6YXlbjwj+BzUaqhtCt
	fyW3mmA3sh3nSIiiRsUeIKEWla6e3WJ5N44qgLthSL5brQookr/cDAkTUfbKZzogmhv
	xlsNMVxKTQ==
Received: by mx.zohomail.com with SMTPS id 1754977393951539.500568194191;
	Mon, 11 Aug 2025 22:43:13 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/4] clk: thead: Misc changes to TH1520 clock driver
Date: Tue, 12 Aug 2025 13:42:54 +0800
Message-ID: <20250812054258.1968351-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset is my changes to the TH1520 clock driver, mainly for
supporting the display controller (the first 3).

The first two are functionality additions, with the first one adding
support for enabling/disabling PLLs (for DPU PLL) and the second one
adding support for changing DPU dividers.

The 3rd one is to address hang issues met when testing the DPU driver
w/o clk_ignore_unused command line option.

The 4th one has no relationship to display, and only exists for my need
to change an arbitrary GPIO (well, GPIO3_3, the one controlling the fan
on Lichee Pi 4A) with gpioset.

This patchset has a dependency (a 0th one) [1].

[1] https://lore.kernel.org/linux-riscv/20250809-fix_clocks_thead_aug_9-v1-1-299c33d7a593@samsung.com/

Icenowy Zheng (4):
  clk: thead: add support for enabling/disabling PLLs
  clk: thead: support changing DPU pixel clock rate
  clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL
  clk: thead: th1520-ap: fix parent of padctrl0 clock

 drivers/clk/thead/clk-th1520-ap.c | 174 ++++++++++++++++++++++++------
 1 file changed, 143 insertions(+), 31 deletions(-)

-- 
2.50.1


