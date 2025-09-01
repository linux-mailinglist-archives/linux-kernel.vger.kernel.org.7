Return-Path: <linux-kernel+bounces-793786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795AB3D831
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102C77A447A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99811223707;
	Mon,  1 Sep 2025 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="X6QJh1Bq"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6C1DEFDD;
	Mon,  1 Sep 2025 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700639; cv=none; b=ubN32nvVc+zTCHtk2Ial4TQW8IseDSGBu+UgSiRSRyk86bIHjdMOy/5jlK27vV/85WDnR6RK2kEeOz0y6khr0YFz+Uao0I+EK3M0nGvlgXc8G2sm7e/gLXdB5Xho13QCVSF0GckF9zKO4cFu3N1/0WZ6T8dJ7555kHdsqnec0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700639; c=relaxed/simple;
	bh=h8irg1+qrtdt4GYLBVX3WcdvSdq4JPFr1Ov37zh6/xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koqNshCJifZU7+IBmWo3Pe8G8VMTbmLcO8bBNqUayxRw/Apra9NFfUFvKFEETM1sdGnPxckPcRv5o75ON44cRLmgwCRpzMqwezvxpgqdVRIQzmwy5kgU/jjDPjQn/OASfvj3JL+lqfBunf/nYCcstjOeVAdO0T9oZ4riguXZX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=X6QJh1Bq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 97FD422DE4;
	Mon,  1 Sep 2025 06:23:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICk8xOlxs98S; Mon,  1 Sep 2025 06:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756700633; bh=h8irg1+qrtdt4GYLBVX3WcdvSdq4JPFr1Ov37zh6/xc=;
	h=From:To:Cc:Subject:Date;
	b=X6QJh1Bq87FrQRGhg7J+UyVbvgZx/QZhNsxUij15wfNNSgePu1xWE3erysbJlEjD0
	 i2GQz5wo+SxoI6j97TvUdkkJlWBaW4PfM0La6neo/8HULNwCu5YnSLKQTmJPnWKXLL
	 CKcpr4t8ujj/NO5+cvGBVZQRfoprpGD1yxMg+uiEL3DwoJjpM7u+FI1pNTXMjxC4Ur
	 BSC2kJkWAHHLd/xVAB5JbVhwvpt+727G05RsJQzN8yNYPBmB0B8dt7WKWDXYQY7gOb
	 r+RMLboP5jq9Ev2E29amedxa2Co5utItJApl3KMa9OmtQuqhp2P7c9dy3vvP7T68ef
	 LIfCdcENaZb6A==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/4] Add reset controllers for other TH1520 subsystems
Date: Mon,  1 Sep 2025 04:23:16 +0000
Message-ID: <20250901042320.22865-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TH1520 SoC is split into several subsystems, and each of them comes with
distinct reset controllers. We've already had the one for VO subsystem
documented as "thead,th1520-reset" and supported, and this series adds
support for others, including AO, VI, MISC, AP, DSP and VO.

Note the reset controller for AO subsystem is marked as "reserved" in
devicetree since AON firmware may make use of it and access in Linux
side may cause races.

This series is based on next-20250829, thanks for your time and review.

Yao Zi (4):
  dt-bindings: reset: thead,th1520-reset: Add controllers for more
    subsys
  reset: th1520: Prepare for supporting multiple controllers
  reset: th1520: Support reset controllers in more subsystems
  riscv: dts: thead: Add reset controllers of more subsystems for TH1520

 .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
 arch/riscv/boot/dts/thead/th1520.dtsi         |  37 +
 drivers/reset/reset-th1520.c                  | 835 +++++++++++++++++-
 .../dt-bindings/reset/thead,th1520-reset.h    | 219 ++++-
 4 files changed, 1083 insertions(+), 16 deletions(-)

-- 
2.50.1


