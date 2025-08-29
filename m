Return-Path: <linux-kernel+bounces-791441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE8B3B6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9DF3A1FED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA32F3C3D;
	Fri, 29 Aug 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ewACIXGu"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2512D8DAA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458889; cv=none; b=gCf3jx/9gfI9UpcwFunKeDdxQpnpvtv4Xn0SEi97G6R0G4jqEfkaHxZtiptSspo68q9neZMjXDLvNoOsR6eFA1JaXIu+zCdib0Er+mvYyNIAFEj8kEElhc+Q6qFhxOBWJVi4fQg7gkM8rId/PH1E3Ihyhx/uQvuuwBcKYAXKFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458889; c=relaxed/simple;
	bh=GYhKNJswLW4IPBl68A6X78Ts9TSiGfI+3AkJiv3sW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ITsD4YvEbXVbAiThEuL/kAqT1m5keUNY5G56aBdVfMs7nSgBXEkXW9hSNBPAr3qNcPFqs72oGrOQqVZWu53/4RZQuiTCtvIal/7yqdH+/xI1jhIHBe/xLWmlbTP72eLYFGM8AKJQChVFmFfBqQ4Rgp3YPaImUa9/NxT/su25Xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ewACIXGu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afec56519c4so236617666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756458885; x=1757063685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmQAx6HSRLTh/zFI/3605hgJxHe7kWmftVvK8IMvrA8=;
        b=ewACIXGuiS8ISqMpUa44ednytVJqDvZ3AJVF9o6yBO6al/A3Trq2yw56kTn2Joqnvg
         6QmKENJD/U5zFv0juGv7Z+2x8U3x9sgToIh3VrVfUU+w895COnoC2CpHRKIwAq5sGvcC
         gqSwJHuGyOa5pAfVmE5I2DIK2vbez32FHsV0uHRKc9Zq9uJY/Ep4jf/Fn2JexxHA6joB
         O06pIHwrf7UxgwBuVUreE5oyltsFt8YG9YoN945AVXM+BOKpmwry1nWzZvLfrj75MNix
         psZku6mehpzitTAevKf5PLHJoatHCYGcUBVD2eExyW2aCutLFV23jTj7Jn0lAbx7+Dwr
         kpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756458885; x=1757063685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmQAx6HSRLTh/zFI/3605hgJxHe7kWmftVvK8IMvrA8=;
        b=djJCaLRraFy+ZtEl9IIbwxQBvTvtd3nru08OOCSgZx8vqXDqdisM4yP2z46Tb28fQX
         3paXC7hKhdmbiHr6ZkFlS7dOyO2BQRxZYW+rexSTd1UySpuWqZXTtiT2vZ4CHqQ10rHi
         MBlUlRgxvDUmX6+/V/qkgbHncCqY9EI7gH42WQVrBxr6pVaEPf55jco/D7J+Boc/bOXJ
         bOdZ3QnqY4I6ggm+Oaupr7l13RLCElfx+xR5i/2REVFRBAWYNNQzCcG7ea+3OfMfdii1
         lN3GpSWmHrw+6sQkHMbNIJ3Q3MrtgQeCVzmgex1GtQlr3bmdZY6kZkqCzwqcFmym1NBe
         GoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3YFbXB7n9q1MHYxGDNlySVO5gRgEwfJgmS+NJgbQPZ5xAq+nHFcnnokNIwRTsyRWOLJl4nJ+/Z1byIrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqnOwNlKJZDzKqwsYhz5lwysya/VpOBMI/S+22i1n2GztKHCR
	8VOFb9qwWyzou+/b/vCTxGzfTYnLaDIQxlVWpVjOMMUGjFUJRcoXsJcVGyCOnl7k8I8=
X-Gm-Gg: ASbGncvvzI5Ghb9MpkrxI2UOiwMLAKdpiZ725sYaGjvxrqK1RTZYp2m9hGTfsxuQM5y
	7LrnW3z9hj+tXhRvjEIEpR8rlpmdNU84TxBOWCt3RHlNlgX+PcerzWxFhj2InbEDWKGRxKrB6/a
	LucFvhGjtC0Ie2zl8aOkdgjg8P1rL7+1Ir72qhiAShWSdk95LsEg7GG55myuPKppixKNla9Y6LH
	9e6Tfby2PjQec5/P6+UHzDVAUScXIkzkblBgeByoxabN1xwot8TfKO6kExJv7kS9p+mIW/x4jMz
	KJj6qxoIvHpho9n31Uf7/6zdJAPY4XG8kfbKPE0cjpH7iF0HNX8Kij8EdmXPcQ9P9gNCb9kHnqK
	UgDUJByLcYPC9mLXET4kGRLOtZZlDlMwouSsk+uP9uXvaH/OdnNqCzk/lU+NMZA4Yz5SmAMO4es
	9pLGnznMuTt0X+bTjZG+qPJUOhhn5gspFuGv8ojT9Bpps=
X-Google-Smtp-Source: AGHT+IGB6p+wPGwqWVIJ1QllB0JDRnXeqTx87rRflV/WMVzo3i+xyRYddtAINLfaY7h5KL2CUoUzXA==
X-Received: by 2002:a17:907:6093:b0:afe:da1c:880b with SMTP id a640c23a62f3a-afeda1c8a77mr563396966b.15.1756458884864;
        Fri, 29 Aug 2025 02:14:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c52fsm161630266b.73.2025.08.29.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:14:44 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akshay.gupta@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	naveenkrishna.chatradhi@amd.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C
Date: Fri, 29 Aug 2025 11:14:41 +0200
Message-ID: <20250829091442.1112106-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without CONFIG_REGMAP, rmi-i2c.c fails to build because struct
regmap_config is not defined:

 drivers/misc/amd-sbi/rmi-i2c.c: In function ‘sbrmi_i2c_probe’:
 drivers/misc/amd-sbi/rmi-i2c.c:57:16: error: variable ‘sbrmi_i2c_regmap_config’ has initializer but incomplete type
    57 |         struct regmap_config sbrmi_i2c_regmap_config = {
       |                ^~~~~~~~~~~~~

Additionally, CONFIG_REGMAP_I2C is needed for devm_regmap_init_i2c():

 ld: drivers/misc/amd-sbi/rmi-i2c.o: in function `sbrmi_i2c_probe':
 drivers/misc/amd-sbi/rmi-i2c.c:69:(.text+0x1c0): undefined reference to `__devm_regmap_init_i2c'

Fixes: 013f7e7131bd ("misc: amd-sbi: Use regmap subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/misc/amd-sbi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84ca..4aae0733d0fc 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -2,6 +2,7 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
-- 
2.47.2


