Return-Path: <linux-kernel+bounces-777092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9AB2D51B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47EB4E0ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7F264624;
	Wed, 20 Aug 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KoIPgeBC"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D41C2DB2;
	Wed, 20 Aug 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675790; cv=none; b=u4VhmhM/AsUYvZtgY+BFjFLJ1wlLh7uJbmJdJzYjDkJhcjFZbHyI+vfkOD+e+CVShD7G14vpnaHKYP8seV4R8s2QNxg3+qe1plQd5CcI3RRbIpIykvplYES5DivJn8Jh2szYzmjewAsO9pm2xhccdyi7FZ6sIRQWjJ4I3rYi1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675790; c=relaxed/simple;
	bh=P8veYh6gqApO82yJJe+m7t0wzfjcOUl63n9yTtWKqKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rA+bCDQz4DhhOF18ApaI136YFHOUqJm3SrajTu4CJwvvGVyRw5vS0J7pjGKNFrXip1Q02wxQwnz6aS49QnQFPglW6C7WoPHuYdq54mzdmEGFfn/kq8/RevoJ63lbeiZ4Bb4a7yAsMD2uxDjfltJoMd/DqkjPjDMkio6K08YK3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KoIPgeBC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D0A6820D9E;
	Wed, 20 Aug 2025 09:43:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9woW5s42fAIz; Wed, 20 Aug 2025 09:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755675786; bh=P8veYh6gqApO82yJJe+m7t0wzfjcOUl63n9yTtWKqKo=;
	h=From:To:Cc:Subject:Date;
	b=KoIPgeBCeFzJnioLHkrdO5SJbjwjUvd6Ha8yC2W2/m91IshHhmUU7EOYsVK6gBPxx
	 AHONKz/mXH2RO7f3HIPasV5DSSGbLqi/wodQHQBoV1EXhZYB6sJGDwoLmT6DVNgT40
	 uGDo4OdQYrne305FMWNkYoiHRscAf8rHVUgAQ8+ChyMQHo8YSkJxxzP/5b+Oq1kyC5
	 LLkZ3aa4UXgLtCnLHrGGeyNwOKZpieA6FJObChZxb08dLff2J2RWPmPN77hcHiL/t2
	 Pxp8By5aqPWir18gMUeb7qapQLoxhLhDbUGAGMbnTsg0Wp471pxPoJ31/L6L6lXsAb
	 d3/gCMtFlk1gw==
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
Subject: [PATCH v2 0/3] Scope TH1520 reset driver to VO subsystem
Date: Wed, 20 Aug 2025 07:42:42 +0000
Message-ID: <20250820074245.16613-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T-Head TH1520 SoC integrates nine distinct reset controllers (AON, AP,
DDR, MISC, VI, VO, VP, DSP and AUDIO). Currently only the reset
controller for the VO (Video Output) subsystem is implemented in
mainline Linux.

However, the controller is described with a generic compatible string
"thead,th1520-reset", which may imply control over all reset signals
on the SoC and thus is confusing. It may also cause conflicts when
reset support for other subsystems are introduced.

This series deprecates the generic "thead,th1520-reset" compatible
string, documents a new one, "thead,th1520-reset-vo", which explicitly
describes scope of the reset controller, and converts driver and
devicetree to use the new one.

Krzysztof and Drew, I agree that we should document the bindings for
other reset controllers in TH1520 ASAP, but this requires a lot of new
code: taking TEE-only ones into account, there're eight new controllers
to be documented. Since this is a fix series that may be backported, it
think it may help to keep it small, thus decided to make a separate
series for the new reset controllers.

Changed from v1
- Split the original patch
- Deprecate the old compatible instead of removing it in dt-binding
- Drop the redundant label and outer SoC node for the dt-binding
  example
  - Keep the old compatible in driver for compatibility
  - Link to v1: https://lore.kernel.org/all/20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com/

Yao Zi (3):
  dt-bindings: reset: Scope the compatible to VO subsystem explicitly
  reset: th1520: Support the new compatible for VO-subsystem controller
  riscv: dts: thead: Scope the reset controller to VO for TH1520

 .../bindings/reset/thead,th1520-reset.yaml      | 17 ++++++++---------
 arch/riscv/boot/dts/thead/th1520.dtsi           |  6 +++---
 drivers/reset/reset-th1520.c                    |  1 +
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.50.1


