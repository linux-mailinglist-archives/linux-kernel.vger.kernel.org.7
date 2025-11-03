Return-Path: <linux-kernel+bounces-883808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E3C2E7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842523ABCB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC330F7FC;
	Mon,  3 Nov 2025 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aA55i6rk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61929B20A;
	Mon,  3 Nov 2025 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213776; cv=none; b=OsRuI+wO3mJOaLbzlT9oVKJjid+ezcVoIGoDRH5sK+hOkyUJlgrHhaFOA1uHZMigCEPbNSLutiDrfRGLTuydAndn6848OLVD90Lu3NJlYwp2+O9NrtmgsaVKT0eU0MMB00yToGCseqHtStS3KjSIwQGeSrAZciUsXp8r+SUefXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213776; c=relaxed/simple;
	bh=2Gk2S1eeC1Ad3WZacnqCvQJkaH2CrT8fs5CC0S6GVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giE4DFLFk3KISVEaSxgSANWa8B3zekuLqu+c7QoafjEvFI5DoKf3JLJLwKnbf2saJcuoYgHEgl81CC/9BZpnbnqXaAPv2MwSx5Hw7KbCG/DTEtnI61bcOTtjm6i9ofO6lk9PR06Ilx+PUkKV6SDjv5AYSUlL9TfYlmWs6TGHoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aA55i6rk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=ow42XSSS62Xe13Q+xB3zV8SuFB8IbXgX8m/GeyD8hWo=; b=aA55i6rk4l/b1l8B/8wSmhzcuN
	kUb3M+yCS4u7TzUA2TZUZJr3CdICOYcI6JvsohJJwKmQGPdbBnUKVZ1EZ5ieIapRGcCkgi5mAlDXc
	wsP+wHxU7rwIH/EpQf9ErzUoNifptPnDIbDA0i2rb/cKel3ICGfDStAs9CqwXQW+fIzpKQ7v3ALMQ
	vHY8Hm5rbFY9uDOtj8ww7PDSiGRv4SR7pPgYQOXDab+PORBuWlgscOBcT/CikpmX3qWRWtmey4GVW
	Xo07aSlGdSSHK78kAqUG2Y5+aAIB4IVvcY4JsFnhZaSacdVNAa5fXwGfDbJ4zRgaYh65svkC5+p0N
	82EFC3Gg==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4Ij-0007vT-To; Tue, 04 Nov 2025 00:49:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 1/3] dt-bindings: clock: rk3568: Add SCMI clock ids
Date: Tue,  4 Nov 2025 00:49:24 +0100
Message-ID: <20251103234926.416137-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234926.416137-1-heiko@sntech.de>
References: <20251103234926.416137-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Trusted Firmware on RK3568 exposes 3 clocks via the SCMI clock
interface. Add descriptive IDs for them.

The clock ids are used in both the older vendor-binary TF-A, as well
as the recently merged upstream SCMI clock implementation.

Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/31265
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3568-cru.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
index f01f0e9ce8f1..1e0aef8a645d 100644
--- a/include/dt-bindings/clock/rk3568-cru.h
+++ b/include/dt-bindings/clock/rk3568-cru.h
@@ -483,6 +483,12 @@
 
 #define PCLK_CORE_PVTM		450
 
+/* scmi-clocks indices */
+
+#define SCMI_CLK_CPU		0
+#define SCMI_CLK_GPU		1
+#define SCMI_CLK_NPU		2
+
 /* pmu soft-reset indices */
 /* pmucru_softrst_con0 */
 #define SRST_P_PDPMU_NIU	0
-- 
2.47.2


