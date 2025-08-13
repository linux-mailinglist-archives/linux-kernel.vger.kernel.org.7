Return-Path: <linux-kernel+bounces-766229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A04B24431
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B277BBA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB12EFDAF;
	Wed, 13 Aug 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="kTZc51Lu"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E32ED179;
	Wed, 13 Aug 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073086; cv=pass; b=tZ8W9RpGnkHSYsjO+1CXs3Fk0YZDVxiGSzy410+9wjVDSpZTUI5yes+7wLzMbLeKYo7rdOC/l4YoOg9gYt43emg6BgaaaELccRcG1UFIqX/vS0mYi134kNZ97dmch4NWxEmeCK26DRnVJzCggu8KBj1SxlWyPbpa0BydryR10BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073086; c=relaxed/simple;
	bh=S/cGmcgmgtLw1MMNY1010tx7wa7EffyPnUFP9h2Dt8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btsBmzSEnSmmyGN0GumwKWL6e9JJUZkU+wtug6ajQ56iem50mZb9pVGhHcKBWumLx4TuHVEMwLpsrzJTR24NqPJPvnZhEAHMMOG29/mZ0viuYpAhfQhogGLutj9qaEN3BooTIamS0m+qzPu7frxcdlRHpvurQzS6AQ3WnUbUJNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=kTZc51Lu; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755073067; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XA36Ve/0/S62HqzFuuX6quZURG5COE8P/83tYLKioDeEMzH/n5lM947IZotfAfg0N1OmtAEhLmyp3Df/nE9VYp4lJW0yURJVSR8Og/uE8o4u+SwAmiQwYB0EgbA3VX5aBsilzRIXkwsHSDIzo96E7TmGFCyoRXudtd10cvXECm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755073067; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gEWMFY8tHqWtDUaEv22ptG9h5sOHmM29oTvYBwnxA9I=; 
	b=OLZPWZaOL3+7zjgNy7nTle77QKMoSsPgPpas596L8cXvMbMlpZ/nzSOiYVh2sf3/UO/QqArWitxNRQn5muY9yHh/+90fINqR7UzklomKArp0Joua1AzbTJ2I4GMGteNDKfShV1y3UT/0gk8XwKmES+disQLjpz6AV0W5i6FATb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755073067;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gEWMFY8tHqWtDUaEv22ptG9h5sOHmM29oTvYBwnxA9I=;
	b=kTZc51Luw9RUNQ97EftVX1tS6gYNhJMMIplio+lMxJOMvmkoAQK6gvd5xWRNK3Km
	lk5HMv4p6+/eBdBYgTGLscszl8Hy2eOnlOJM+aG2TvHTL2GdDbLCL71AktgJn6qfMUg
	Ki6QdPfChr2m94Jhb/9zfOaxRGT0tL1vADrj7diXNfh/QvAWLKAGWAkw8gDGnQGyQQr
	qSTZe9gMfkZhgj5uRIxDNhcTCW9saYen6+YBLji3/Vz1pelUww5IOhCkxNOxUmiXOjr
	UNfSAo8h+SX5thyu9NxOk01xZZzxonn7QsSGS3K1l3lWIc1Mlav1avlSU6w5Ovs3PTX
	YgehTpbTYg==
Received: by mx.zohomail.com with SMTPS id 1755073065363841.0786632079869;
	Wed, 13 Aug 2025 01:17:45 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] dt-bindings: reset: thead,th1520-reset: add more VOSYS resets
Date: Wed, 13 Aug 2025 16:17:15 +0800
Message-ID: <20250813081716.2181843-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813081716.2181843-1-uwu@icenowy.me>
References: <20250813081716.2181843-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

VOSYS contains more resets for a display pipeline, includes ones for the
display controller (called DPU in the manual), the HDMI controller and 2
MIPI DSI controllers.

Allocate IDs for these resets in the dt binding header file.

Now all peripheral related VOSYS reset controls are here, only the bus
matrix / IOPMP ones are missing, which shouldn't be messed with.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 include/dt-bindings/reset/thead,th1520-reset.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
index 00459f1604897..ee799286c1754 100644
--- a/include/dt-bindings/reset/thead,th1520-reset.h
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -12,5 +12,12 @@
 #define TH1520_RESET_ID_NPU		2
 #define TH1520_RESET_ID_WDT0		3
 #define TH1520_RESET_ID_WDT1		4
+#define TH1520_RESET_ID_DPU_AHB		5
+#define TH1520_RESET_ID_DPU_AXI		6
+#define TH1520_RESET_ID_DPU_CORE	7
+#define TH1520_RESET_ID_DSI0_APB	8
+#define TH1520_RESET_ID_DSI1_APB	9
+#define TH1520_RESET_ID_HDMI		10
+#define TH1520_RESET_ID_HDMI_APB	11
 
 #endif /* _DT_BINDINGS_TH1520_RESET_H */
-- 
2.50.1


