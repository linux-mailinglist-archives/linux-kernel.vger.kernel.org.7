Return-Path: <linux-kernel+bounces-850053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA789BD1B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46D5B4EC2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE112E7BB2;
	Mon, 13 Oct 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="rVTq/r+s"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612E2E6CCE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338765; cv=none; b=p0FKNt0vpNYrFRmygRByWN+PkzOJXau0kUgh6ewimwRe7r8QkcVD28OF4hm5ziTnvf9sPu+UTtMorITFUHXofpdtxJd0lF/n+TJ2WV9VeaXtfengonPu6RFd5fjE05YljwOpPY71AFNq72D05NoiUcqMWdbgCLj7/X7jMk8Vkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338765; c=relaxed/simple;
	bh=xWlK53CaSwa6hnr5xS+FvtF+Rl9CsmDftNxczEkSap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxB5RyxTuVTD5O5jmJ8bgAdMWfkF6Qnpb64GP4CfgaemgSpRYj8UgQkFF6lZeLceccUu10LSC9ChccbSZgK/zz7FT5Kr4U5iIVWrnHBLqtHfxVMIhH7uDSAJy4QNL0vnFDc8IgWJjB9v3IyqXEFcTyM/f42s5zWUYRBwzD6jEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=rVTq/r+s; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 22D7C240101
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760338761; bh=vdFSblBB+c7p7EwEPuHzEd2UFn5pK5CI5ZtkGJjeLYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=rVTq/r+saw25YvR8I4nYxqSrJIAt8Jwfg0NrcTm63W4Krooumov39yCewdAaffSXI
	 HX/pcK25ZRhuqZDNlbOC5Q3DA39ryuVYRXk70Qpiy538XrdRzJ/TTihYE0fcu58D4B
	 t/8je7qT0+9Ko7LVZxVROSiKjCafSojQgwQo9pkWtqG+Y5XdLfXZmFO0JUHBSDvvDJ
	 tuhBKf7isd9p/mi8wL4lobFQfWU/+hFPmZEN703FTHM+YXx2TxlBuoS8vZI2/1BSY6
	 N2vZI392CEri2ixBy8Rz/i4ijY2mh7QEX1gBI5DyanGuVEG9ZGTCM4zP8nrHadKElg
	 Iftd1IstiQ5vg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4clSrR5tZBz6v1j;
	Mon, 13 Oct 2025 08:59:19 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH v2 2/2] arm64: dts: imx8mp: add cpuidle cooling device to the alert trip point
Date: Mon, 13 Oct 2025 06:59:20 +0000
Message-ID: <20251013065903.35216-2-martink@posteo.de>
In-Reply-To: <20251013065903.35216-1-martink@posteo.de>
References: <20251013065903.35216-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Idle-inject up to 50% of all cpu's time in order to help cpufreq
to keep the temperature below the trip points.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b59f53952d5..7ab321af9e15 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -347,7 +347,11 @@ map0 {
 						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu3d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu2d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu0_therm 0 50>,
+						<&cpu1_therm 0 50>,
+						<&cpu2_therm 0 50>,
+						<&cpu3_therm 0 50>;
 				};
 			};
 		};
@@ -380,7 +384,11 @@ map0 {
 						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu3d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu2d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu0_therm 0 50>,
+						<&cpu1_therm 0 50>,
+						<&cpu2_therm 0 50>,
+						<&cpu3_therm 0 50>;
 				};
 			};
 		};
-- 
2.47.3


