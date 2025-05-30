Return-Path: <linux-kernel+bounces-667359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD9AC8444
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 00:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D331BC59E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FD21E091;
	Thu, 29 May 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bo1cbFTC"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF122127A
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557459; cv=none; b=fKtPLVbbEzcrcyB4LuAGtSlmeYgpsVIRzZgc3CRAhrTLimNkqUBmuE3jlFjDWX/cGIOlfVfgabfqourU8MGrGX8KsDzMN5ZvVUJIv/odsHQBwOUfp9Uzyr6w5MxjSMlN9sfZ0JGVo7+c4k5VoqMLlkx4KfwBsV850ysmWWh+UzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557459; c=relaxed/simple;
	bh=8ehvIhyMSQqVR119BSQV9qbRojv4D1Uow/adRa6T4EY=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=FfxsycywyO1B8U/Uyslk99Mcz7CKJC9jNcdGBnckNNdSRfkgfz2uhrq5DTO723R5caGbr0+/kse/PxqBjhhZA9p9ycaAp7JvrqNnwdKBiLegg29l8eHlCTQxg+UjYIAURediVKA7ub5VjeawsjM7M734PXkqG79zc6HqKqpZRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Bo1cbFTC; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222409euoutp01da886e1316cacc1fb6feb7ce9ad11173~EH7xxO1Fh2316423164euoutp012
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 22:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250529222409euoutp01da886e1316cacc1fb6feb7ce9ad11173~EH7xxO1Fh2316423164euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557449;
	bh=UtMJUuq6/j+HHS1BRexsXIMJEKVh/fKMbHv0hDIc9WQ=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Bo1cbFTC/L2jtBQzgLE4qcGuhQaPqUydLGvl1eR5kYcegBYAbznwVpewNQjOM+yLp
	 ChI8ODy+AELbT5s2uhpaO5+kogdPSCMAnn0n7Xlp2TAfEuLBdDDyMcftnrkQffezDa
	 ToCcohPrYIOFrDPqBDdbftHrF4VTUawqSTw8bmBE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265~EH7wSHjOI1565715657eucas1p2_;
	Thu, 29 May 2025 22:24:07 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222406eusmtip29a64f97e4cb0480e499cfbe8b47ef396~EH7vU3Abr3031530315eusmtip2M;
	Thu, 29 May 2025 22:24:06 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:52 +0200
Subject: [PATCH v3 5/8] riscv: dts: thead: th1520: Add missing reset
 controller header include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-5-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265
X-EPHeader: CA
X-CMS-RootMailID: 20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265@eucas1p2.samsung.com>

TH1520_RESET_ID_GPU_CLKGEN and TH1520_RESET_ID_GPU are required for GPU
power sequencing to work.  To make these symbols available, add the
necessary include for the T-HEAD TH1520 reset controller bindings.

This change was dropped during conflict resolution [1].

[1] - https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..bdbb1b985b0b76cf669a9bf40c6ec37258329056 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk-ap.h>
 #include <dt-bindings/power/thead,th1520-power.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";

-- 
2.34.1


