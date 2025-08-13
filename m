Return-Path: <linux-kernel+bounces-767250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27895B251F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2D83A9A47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB13298CB1;
	Wed, 13 Aug 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="A1s8g9WQ"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD2303C82;
	Wed, 13 Aug 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105129; cv=pass; b=Wk6zO7zktdfDKO7r7xMGjE/z/36jdQdmx+GS3z8v9LofpSzlYCOFy7sqwEyzZtKmC+VNV5gg08s7EH5pxdTySwJg8caa3ag8i2jqjnz9nLdvs+mUDkQDD4KTA78/a82t35oSYxBEQeNkJRU71pHHaVhjfpcaTAljuzh75dHQg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105129; c=relaxed/simple;
	bh=i7fid87W70fK4CzBn3krAYPVNQU2X1jSAX4qIn4Q3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JT9h12cpcmXgXNjhZEql9DU9b/SrBrJr4URkNUXEoiGqPfZcSlRr1d8J6OeEoDCsnThCloxL02DVvxJHAjLXg6jr5O1gpC2MKspHzUqYP9INnmMJz6uqTfIaE15fTKeMAtOylJKDMuy/L4oDhznlYTHti81P3mj+qiRRw3i7yOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=A1s8g9WQ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755105111; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ez9de+bl1zbWJs25nq3JZ+PtT03BosVR4OIDayRTfmi8+diJ1oe31vO8jF/ePc0C2UFtd+Fq1fbpSG3aIXBaosQKEyqJPeRX03Qqu4aMkGw6h3P7c+GBiOlPCu+iV7fo2eEBrrcdd6hELybG6TzJfM9DQOGgajCnJLapx6RRFNc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755105111; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hwMVPhatoPN6SXxmbJBqlOp2xrUdMJia+ktm5ztecWo=; 
	b=OrqD72pgxpAJdMPt1nAIHSU7IKPw2XihMYbpWW6XiKfU9/ENS8kdtUc8KllpsMZX3DZSdnJnid1z6QClzLzn1pz43fXCklCKpfVYNHWHLNbL1TVfrRIuuBWfvnTVpyfWXxE6CveVfGN2IFN4/9caPDW+R3ll5qmwToIzm0U2/00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755105111;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hwMVPhatoPN6SXxmbJBqlOp2xrUdMJia+ktm5ztecWo=;
	b=A1s8g9WQ5FaONit9656PyKMlEZfJRVfNUS+0mEac9WcIRKcXY7Ub6p1Plbj9nU8r
	KkYOBhfMd/AMKwfjiS/R5jTHi6u6+xKtnV6wsEH2fgUZ5RLIxtXZqyl+AYZsaNcxDA/
	yzjGiO8YTaq7IWSohDnPvg45ogAhEBwDu7+Le21IFUbgoxfTp5pObIBiW9jHj5qca5Z
	OZfoVc0iXS7hgVSy8/3Y27wEABNtY+HuH6fuWQWDA85bb38C3kTbmV7/eY3RHFGQ4ld
	TBmBTaFSrIkssYP/czipSU6KM7BrwRbFEbwrO2n16uf9VMm+vGsAt9xs8c1feFgTcM6
	z7NE/FpIvQ==
Received: by mx.zohomail.com with SMTPS id 1755105109586432.8546456456073;
	Wed, 13 Aug 2025 10:11:49 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] clk: thead: th1520-ap: allow gate cascade and fix padctrl0
Date: Thu, 14 Aug 2025 01:11:34 +0800
Message-ID: <20250813171136.2213309-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Current ccu_gate implementation does not easily allow gates to be clock
parents because of the waste of struct clk_hw in struct ccu_gate;
however it's found that the padctrl0 apb clock gate seems to be
downstream of perisys-apb4-hclk, gating the latter w/o gating the former
makes the padctrl0 registers inaccessible too.

Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
gate.

This patchset depends on the display clock patchset at [1], although a
rebasing to get rid of this dependency is possible.

[1] https://lore.kernel.org/linux-riscv/20250813072702.2176993-1-uwu@icenowy.me/

Icenowy Zheng (2):
  clk: thead: th1520-ap: describe gate clocks with clk_gate
  clk: thead: th1520-ap: fix parent of padctrl0 clock

 drivers/clk/thead/clk-th1520-ap.c | 385 +++++++++++++++---------------
 1 file changed, 188 insertions(+), 197 deletions(-)

-- 
2.50.1


