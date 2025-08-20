Return-Path: <linux-kernel+bounces-776914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6928B2D2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ECB62843D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C125244693;
	Wed, 20 Aug 2025 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="Sqk71vEa"
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AB241664;
	Wed, 20 Aug 2025 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755663797; cv=none; b=MQkDMBBy7Wej+n3/fwtnkyFpNbHqQWd2RyWDt0vQc6gyIUfKiMz7pab7Ps8BvnBkqQCni6Jq7rHAqNqKob16+MUccV4wO+SCX2c/jpuaDBF+tece8ryUzDRpSHan638+GyD/dJXeh4ipYn6yT/zN1GdeRcXx5KDUZcXjtcKpmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755663797; c=relaxed/simple;
	bh=1sLVmJEVELm+3EaQx5S5Fb5yqH/hy5nMB0COk6qZdDw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dAOzoUPvdx2X3TnSuILA87C8td28+v9RDu+/CKK044FcAm8ge3Cd/b9A8BIxVAqxVynBxasaqSbxP7bWi0/8NQEWNcv/a7AqV7rp+ZtUd+CwEvXxxQe5U9rZ5ffPdEybXfhcl4DxLLg5Zk9uVJtWAZeyl4DPs8lLqwaS7Mum91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=Sqk71vEa; arc=none smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=
	1755663782;x=1756873382;bh=1sLVmJEVELm+3EaQx5S5Fb5yqH/hy5nMB0COk6qZdDw=;b=Sqk
	71vEahlIjYAB6jJU5K3fqbBg04X8dM6fUUDTP8Z5/VeP1PJZj2sE91UgTdiX+szGZTCl+/MzTG9+U
	Q71klbwyazhPx5Wm3d+xka7xt1WeEC5fvSLN/pY/pHi60aWl67BcIjQ4vrMTQiuT9T6T7NUbFCLAl
	dQQ6AtwgeNadcluUj+YNNZSeBTdXJ2dSSZcjG9KeCfl6m+aLkuSaXnFoeNKlASr8Rh7yvByFAZNnd
	j82fOw26SyrKfNMph6f0RkTqc+vLsSwEZrvoFGxEc4W4XC34sRxtFNWmvqDph8ReZYsRSeaWKrbXN
	gJlRrdgoiMwNKH47Wizlfmvz08ggS1A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57K4N2KP2103061; Wed, 20 Aug 2025 13:23:02 +0900
X-Iguazu-Qid: 2yAbaKzOl4H8PZRSai
X-Iguazu-QSIG: v=2; s=0; t=1755663781; q=2yAbaKzOl4H8PZRSai; m=AQ2Y70863fIkF40ki8y3XRx/yrNIO1xMVjEI7bcmleU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 57K4Mx7T1451794
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 13:23:00 +0900
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH] MAINTAINERS: Update Nobuhiro Iwamatsu's email address
Date: Wed, 20 Aug 2025 13:22:47 +0900
X-TSB-HOP2: ON
Message-Id: <1755663767-1612-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The company's email address has been changed, so update my email
address in MAINTAINERS and .mailmap files.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 4bb3a7f253b9b..328b04f82dac7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -585,6 +585,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
+Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro 1.iwamatsu@toshiba.co.jp>
 Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>
 Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5ad..47d059d5878a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3431,7 +3431,7 @@ F:	Documentation/devicetree/bindings/arm/ti/nspire.yaml
 F:	arch/arm/boot/dts/nspire/
 
 ARM/TOSHIBA VISCONTI ARCHITECTURE
-M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+M:	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
-- 
2.50.0



