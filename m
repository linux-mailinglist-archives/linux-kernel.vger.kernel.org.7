Return-Path: <linux-kernel+bounces-768076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B9B25CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058E1171133
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2D263C8E;
	Thu, 14 Aug 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="CeKvNwY0"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB4258CED;
	Thu, 14 Aug 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155315; cv=pass; b=UhOkvtcJXmHYHCpUImX+iNa2IhOcQtezniEcSKKD7/qLsE8Eo8OVJAGhbcfX53qx6z4by9abaGy6cxNm5VMoT4Z1N8TdwR0bBJFpwBNPd6SEip9qUEEHtf/5i2Tp1QPNXF3fJYPtG9WHuaW+9ozRpBbr6DY4oAfn5TKZ7K8uj+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155315; c=relaxed/simple;
	bh=ec0qTtXxUWiQyjB2QnXHBQKn3t6mlx6SPmhmXo6RUVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9Lh0CrP3QamJ0kHtAMMmMYt/rjVXKORySZ/uFl0Ir82ajOmbgF6yH+cxuU/eQS8Rwvf6Bf7wqFpDHiw3z3geG8tyWWidqD2ihzxX5o/9ZYLs2wGiZ3G0k9p8GOB36EP5uHmEshDQvtbfsmjJerBAW93h9gYc0Bg3tLHsSk5nyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=CeKvNwY0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755155298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IY0TyYGEnYgW6vCsjXDw/T/qi49rCrlXY2ZhA7XIn36zbQAwmONr43oUlDHv7eGihoGWvEfNpvjtY6B7GoISZzOKIRxo30TzXq95uxO66Krhb5MY9v6NFWQq6tdVeKQGrZDQPqfai9KRiUY0Ri9TbuA8bjt0hIvI1Mnct4/5iPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755155298; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5EDAGFHJuC9tPrNz6YQCZPVDFGTy8SOuvDsgiiHyCxU=; 
	b=X5CoDENaz14mkXuNh7l6nUEjtxk6NcaRNIoTqBD6OVvqn56xfREzLmD17FaDfJLYMReigYbh/+OGcevfuU4IVPT5/qrP2N28qVj7rRSMOrqoLL3r9zn5va++771Al/01YUMwHp0cMx0ckA3dP3wCBKKOoHS64YZHnLs8xWjqeMI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755155298;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5EDAGFHJuC9tPrNz6YQCZPVDFGTy8SOuvDsgiiHyCxU=;
	b=CeKvNwY0RoVu+SSNWIhoN7JBCB3euGdh7/JdgG/E8gqCLd5kdzmqYAqFBQzOfiVd
	J+/ZBmOgwOxO2IZqWR06Hm1LtfaTtmpFIFjVPZl67CmXfapjodttx0vFMuTt286eymO
	RGYMPCMvIIU0x/UwZhO4cxAt3PygyckJ4fTkhd2u3l5HfMIr2DiKCWyGbPudKr6jaic
	Tzi188EP5jr0Gas4X39o3uDpO3PkjGGx55OgsZUb1nRXgTXEQUH4hquDnJxClLu2tyi
	sxQgbQnvYzi6nxGAe38jpAn7AgvwxTDbawCr6lkBBIpLUmGd4LlTAeaTZKVtJHjmwfh
	oIm2LrGGpA==
Received: by mx.zohomail.com with SMTPS id 1755155296251591.0287398528361;
	Thu, 14 Aug 2025 00:08:16 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 0/4] riscv: dts: thead: th1520: Add mailbox for SBI-to-AON comm
Date: Thu, 14 Aug 2025 15:07:53 +0800
Message-ID: <20250814070757.2267325-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In order to make system suspend / CPU hotplugging to work, the BSP
OpenSBI wants to talk to the AON firmware, and will parse the
information needed for this communication from the device tree.

This patchset tries to retrofit the thead,th1520-mbox binding for the
C910R mailbox, and assign it for SBI-to-AON communication.

The binding seems to be badly designed, and the retrofitting process
looks quite dirty. Should we just abandon the current compatible and
make a new one with a more proper binding?

Icenowy Zheng (4):
  dt-bindings: mailbox: thead,th1520-mbox: retrofit for other mailboxes
  dt-bindings: firmware: thead,th1520-aon: add a mailbox name for SBI
  riscv: dts: thead: th1520: add reserved node for C910R mailbox
  riscv: dts: thead: th1520: add mailbox channel for SBI-to-AON comm

 .../bindings/firmware/thead,th1520-aon.yaml   |  7 +--
 .../bindings/mailbox/thead,th1520-mbox.yaml   | 49 ++++++++++++++-----
 arch/riscv/boot/dts/thead/th1520.dtsi         | 20 +++++++-
 3 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.50.1


