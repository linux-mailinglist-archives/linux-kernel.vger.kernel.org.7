Return-Path: <linux-kernel+bounces-698181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E315AE3E58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016993B2897
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7424A06B;
	Mon, 23 Jun 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ge4HZvEr"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89997248861
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679081; cv=none; b=ii2GinElZcNyAcmCMIQrNNGlIOAhKUw4D61sPROOZ5tpsYWArJtJptGRrgVKMEuMSZwA7l0bZnPUV06adj+Mv0aRq8OFdwh+KC9POf+1k9g15jqoa9i/41FCJXgiAWEWaC3XIkJSWom/vUvf+H07fyjvjJSlMdHqKcPRXdmQYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679081; c=relaxed/simple;
	bh=QaYHOSDDu7fbrFvehF8aDqW5RrZCjwiIdiqznONtKz0=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=hTTOCSwoZ5jq8yAMxo1N6sA/3DC9a+rK248xxxNQrxY8A6N2U4iug5rV5Ye9y8dyC84voZxjTdIuh/RvUYQRMvJ1+utkxESoOT+w4fptPyrsgbuRf+/pnuSYpeDv/YyPB+q7U9aiWVZiHbak7baPiTSxLNoHSYEAM5sRfPEkPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ge4HZvEr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623114438euoutp01329f0129439bd031b98325eeb0619be1~LqViVMf3q0074900749euoutp01b
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 11:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623114438euoutp01329f0129439bd031b98325eeb0619be1~LqViVMf3q0074900749euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750679078;
	bh=Oics6uJobKbENIaO6NLm2nxzuP4RRsijLK+rKJOLJ9o=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Ge4HZvErJ8bGg7pCq0YX6vFXOLJZDdkORx2h+35yheJGqqJC1IQo5/cPNjFxtOTZj
	 Sp/2GTVXZEKFYKwPcqeCmTGW0bw0l5RCPVwtZcrpBfoydEjhtonuqbrqzFM4op7+oQ
	 rAGmV/mjyzF6fepUJIsTKQcTnVS8nuROoGHi+MiI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114437eucas1p153a063e2f6e34f349c5e5b12a5a32707~LqVhuTnuU1390213902eucas1p1S;
	Mon, 23 Jun 2025 11:44:37 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114436eusmtip1881294de4a8782598c48caa73711624f~LqVgtjFwi2309023090eusmtip1-;
	Mon, 23 Jun 2025 11:44:36 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 13:42:44 +0200
Subject: [PATCH v6 6/8] riscv: dts: thead: th1520: Add GPU clkgen reset to
 AON node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-apr_14_for_sending-v6-6-6583ce0f6c25@samsung.com>
In-Reply-To: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
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
	dri-devel@lists.freedesktop.org,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250623114437eucas1p153a063e2f6e34f349c5e5b12a5a32707
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623114437eucas1p153a063e2f6e34f349c5e5b12a5a32707
X-EPHeader: CA
X-CMS-RootMailID: 20250623114437eucas1p153a063e2f6e34f349c5e5b12a5a32707
References: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
	<CGME20250623114437eucas1p153a063e2f6e34f349c5e5b12a5a32707@eucas1p1.samsung.com>

Add the "gpu-clkgen" reset property to the AON device tree node. This
allows the AON power domain driver to detect the capability to power
sequence the GPU and spawn the necessary pwrseq-thead-gpu auxiliary
driver for managing the GPU's complex power sequence.

This commit also adds the prerequisite
dt-bindings/reset/thead,th1520-reset.h include to make the
TH1520_RESET_ID_GPU_CLKGEN available. This include was previously
dropped during a conflict resolution [1].

Link: https://lore.kernel.org/all/aAvfn2mq0Ksi8DF2@x1/ [1]

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Drew Fustini <drew@pdp7.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..f3f5db0201ab8c0306d4d63072a1573431e51893 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk-ap.h>
 #include <dt-bindings/power/thead,th1520-power.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";
@@ -234,6 +235,8 @@ aon: aon {
 		compatible = "thead,th1520-aon";
 		mboxes = <&mbox_910t 1>;
 		mbox-names = "aon";
+		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
+		reset-names = "gpu-clkgen";
 		#power-domain-cells = <1>;
 	};
 

-- 
2.34.1


