Return-Path: <linux-kernel+bounces-725351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A5AFFDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFACA1886C87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C92951B5;
	Thu, 10 Jul 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cjcv1tv6"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA4293C66;
	Thu, 10 Jul 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139321; cv=none; b=DY55UbX9LHte8MkxzXeg+PXGpJyKMqIGipvNCcD02OpZXcS2roui+WEqGUDYjI42OtXfTmGbEfKi93h+sErUr1kyV3bi5LCP5bAyA3/avStruSSa3o6nbsVaeaEd+K5V/zBjRSyAjsg0K0NEcEU+vSfjr72ywe9Gx/6ScgiJ320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139321; c=relaxed/simple;
	bh=uBESpV6VYmtMf5c0jfO84+kgeOgfAvmMmBPnGttkCe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajpnDo7AE1g4ESoYuJTGcWbUq7MKXfyoqyMKjcNgKHdLYBPe9yoOdhXCdbXl1FjsGzZJIB5tJZwMoUJlCCjGl+YFOmqgme0a8wOwDCP95X5VQBxeva6ILUmIbFJigf4//P8so3ragkRSO+YzQ+51N2fJoq/iyH16QXidN9lJiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cjcv1tv6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2E8FF20A48;
	Thu, 10 Jul 2025 11:21:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPJcxE4Y_BvH; Thu, 10 Jul 2025 11:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752139310; bh=uBESpV6VYmtMf5c0jfO84+kgeOgfAvmMmBPnGttkCe8=;
	h=From:To:Cc:Subject:Date;
	b=cjcv1tv623srhANAPtOsUskYP/Y7EolbRFoS7GkiKFnEgzTCR+WIpuHeei/xmQMUK
	 5/GP4XWiuCt/7cF7xasp8Lr2QM+9+gWhKmwOE6ZH5T/P92A541JMSkk+ThNb6LDCZs
	 Q8bac9sasMULCQnalWf8u7ZMhBWT7kLqBCptYp5WJudHxSwjr3viuHh4uuwTwQyBcZ
	 m92m382TfUt5CBnsPJi99jaFzfXtmhdokC7qLXMZpXpxibnE7ghrUTjPq9mbCeifXW
	 C9D+TwvY//m63g56GEig6Tya0LnqNORknzdR8HKVvm0qnPShK5ntxKUIJP/DUFxB6C
	 6xw13hUBYeeUA==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 0/2] Fix orphan clocks in clk-th1520-ap driver
Date: Thu, 10 Jul 2025 09:21:33 +0000
Message-ID: <20250710092135.61049-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_orphan_dump shows two suspicious orphan clocks on TH1520 when
booting the kernel with mainline U-Boot,

        $ cat /sys/kernel/debug/clk/clk_orphan_dump | jq 'keys'
        [
          "c910",
          "osc_12m"
        ]

where the correct parents should be c910-i0 for c910, and osc_24m for
osc_12m.

Note that the c910's case cannot be reproduced with vendor U-Boot,
which always reparents c910 to its second parent, cpu-pll1. Another way
to confirm the bug is to examine
/sys/kernel/debug/clk/c910/clk_possible_parents, which obviously doesn't
match c910's definition.

This series corrects the parent description of these two clocks to
eliminate the orphans.

Changed from v1
- Split the two fixes into separate patches
- Add a static qualifier for the new definition of osc_12m
- Link to v1: https://lore.kernel.org/all/20250705052028.24611-1-ziyao@disroot.org/

Thanks for your time and review.

Yao Zi (2):
  clk: thead: th1520-ap: Correctly refer the parent of osc_12m
  clk: thead: th1520-ap: Correctly refer the parent of c910-i0

 drivers/clk/thead/clk-th1520-ap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.50.0


