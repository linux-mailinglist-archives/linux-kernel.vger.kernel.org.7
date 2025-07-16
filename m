Return-Path: <linux-kernel+bounces-732963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7454B06E38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8086B5003D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E380285CA5;
	Wed, 16 Jul 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et88Ca0c"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C482AD0B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648553; cv=none; b=RkfQDfVCjZNuUpUvaVP/xJURep3drJfDL5VRF7QkkEmIw/v590183on3beh5Yy10QorQcqLoCHghyq03A2OiGjOzdWvN3fMQZENa+QL4ffjtBNTnnPMDio2Oxp7NitYqGKwjZE3fiDJ+bb4cDGVjPnoX9+b/RxIjA0W2ZNF8wNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648553; c=relaxed/simple;
	bh=eod/wmVUOGbgIl5/CrDR366hD+D3H9tKO4+uFMa3+Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9ZD5BLrZUZpcy4CJr4NSbgNKrhguAWCURLfwcXDvWBsa8lwyuV3dcxKldPfwTv+jNtEHFwUZD6Nef3yenJC/wddM71XuiYupohD8/s0YRY3UPNlmMi9GIghsxYS8MgpR4KANuC+YmFvw5KZQSbrwR77g9BastuwQAJIOtKhQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Et88Ca0c; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso894106f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752648550; x=1753253350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hIgRND/kgTK+Uu5kTClO4Ajyo6XJhL11o2zXAzcLkM=;
        b=Et88Ca0cQQTgdSYulI7LxT/nJnGLRmz9eCP8+BOl60PRbOEylCFmcTNat33ufoxmWX
         yGUkliQpiUpcape5r4nTxTcAWkfXJ73aZP7QxITzgi5fVe7U5zppMcXfYP340ucHaoIC
         nGhnMdZuSCYj0xWqMW05dhD4DxI7Ot34FSZlJlpyV6jUPOXy9bsrgweCPtwe89UH/IxG
         1dM9Prf9PIoQAq7urCvmD8lNbD72hZqCZe+OAmXrFC/YHjIh4Z5fbd2cUah3bAc8nYNX
         izD8zhB1SX+YPJbXJsCx58mPkec7sUSKc3/PhLHBcI21ha1TCP1F8R+OlwbgZE1mjlvL
         y5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648550; x=1753253350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hIgRND/kgTK+Uu5kTClO4Ajyo6XJhL11o2zXAzcLkM=;
        b=wnekQYVoMYOhPETpkRHzGxsL+GbS3L4X10W3IHLCQ+EMH4AqhhSF+1ctqoMZDs1xn2
         fW8JNhmEyRbASOyXraLZGn1UMZAKkKAvxHfee+gh1lI3/+OHaDQ3EzWM0HqK7SRCeGOP
         MTEMDmFoWKTgf3zkzlaUZ+55TWfRe9HpNogW6hunburSSM7xdOVoZWmY47m8tqhpO5Q2
         kq110vrAz/pMn0/iv84vXq5bMaNP8P3ud4uJuMZj9p7ZNRbnDDRcYLXcboUwCnbD+Osy
         EKhOCufGwKFtQ9NejjjbCmq1KQZ0Geqhe3TjPmZ1+G6YSrSqkmsJAvqYA9ojz3x8KRlf
         jyaA==
X-Forwarded-Encrypted: i=1; AJvYcCUVC8qOyYJooveZRiINw0Y0hjX/lnS8atyBOLot+yFGVmDxHxmH/YSj8adCFmgLGOrZsNYycuRu0Xp1O2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMryHs2F8UwHamYDRRw2EcPRiAB+bx38HrzVOtZOC48Qntlme8
	ofW6U4Il22SDDzlJ87YDyGBC6IvNXQqXjl+N4h0yTtOXYI2P1VTZ4wR4c39iCNi1sjtRwp1sf7/
	Pvg1x
X-Gm-Gg: ASbGncu4TF+S5aII3Xb1IxtHS0BjwaqHfO7Y61ntAF2kPUm0MB3CF8lDvkAf97wyv3m
	CZTDtdn9Kl4zbzVrolU3pdV2RjJgYJmVaTmXpqAqITFleBF0mogRbcqC0qMBIC9eEfaiy6koGSn
	bBEB9G6MU0WcTqFshkhlAswpHTo5q50PX3Nl/c+tMkK7Ghv8Oq2hpGMnylBLSteRJF+ThzidAZI
	xjM0V2NTeek7rPNJbBGnmPBr5HAfQMJmwQ2MJs3GVk6cPTNuAW9mz3hOQV+qgrW+3jY7Ey55bgK
	yzq/i6sHaRzrMwo3VAMKX5hRq7ZmO0LFwwyoZCod1X/FzqyRxcMquB48EVq0YSHI4aced7xnaJ6
	wFybgL1MIz0MXL+8JnFJ/ykcowVgTevZTmXw=
X-Google-Smtp-Source: AGHT+IEuIg3c5wRFSsVOrhUB5ninrAbasZgWByLB1PQKMayupzuVIAlVKtDbkntiUqVhlwRbVDDXjQ==
X-Received: by 2002:a05:600c:548b:b0:456:23d4:4ef9 with SMTP id 5b1f17b1804b1-4562e0462d4mr5962165e9.3.1752648550068;
        Tue, 15 Jul 2025 23:49:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562eb63551sm10366865e9.24.2025.07.15.23.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:49:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
Date: Wed, 16 Jul 2025 08:49:04 +0200
Message-ID: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=eod/wmVUOGbgIl5/CrDR366hD+D3H9tKO4+uFMa3+Mo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBod0tfdUUYRJ+08hLNvRtPMJeL3f9+czcvjsV0k
 87VpRqoaGiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHdLXwAKCRDBN2bmhouD
 11X6EACbRd05q5MJru62yf++romqY4T0F6gIeLoBPFs65R4AfdmMTyC81Q6R6gmIoxhKYVjh6U0
 7qjhPPu/Hm12BMFLi6LjC3ej6753amQHac+XbIMiTc4BJqkCGPHyRkK//EXhmWQgycSGuhYh/Q+
 4q1EaGuxdl7P0F6IREHueZ/g4TWq4WdF0YBX+f4MRuhUk44Ja1eseY1YPNHn+mxerqIo9aMqPvj
 vWc+io23N1AuLaUZlgPOW8vdboizNzYqKxGhWC3QaYwE7henTVJ4zEZ6RxMzvfjLhazVQUUeXHz
 MGLRA+fgnkKEwqci0XJ+ZD88XDvits6ImTUobAAIr7VOjGAz2CGZtyoyKz1X0tn+TERa2sY37gm
 9sfW+Lipxv2tTeJE6SlJxvuxuEniKGwZTAnBLSwqNuJvnhJTTMf5H4y/Y9XIAZ5wOCdCa6FTNt1
 fJHQuCGiON02/qimHETtNz1dK3WIYtWQ99yBNEJj0wfiJyNf5HuYOdPjZlvFY3NfBoy35uzdmmo
 gUJapGhFXIZ7YkMQJWW8+AAvfTBcL/HTRc864+pjUkwnyLE6CexSfEeiHyg81n5DLv0pUg6c6yB
 CdNhy4WKQv+PnJvgUCQ9oA28+JhZzWaYYGCFhlxBAZovdl98KWZ/xr2QgSwkj0yytCkaFdrjFmf cuPcmOPXry1/xaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

CDX_BUS driver uses msi_setup_device_data() which is selected by
GENERIC_MSI_IRQ, thus compile testing without the latter failed:

  /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
  build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cdx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index 1f1e360507d7..3af41f51cf38 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -8,6 +8,7 @@
 config CDX_BUS
 	bool "CDX Bus driver"
 	depends on OF && ARM64 || COMPILE_TEST
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
-- 
2.43.0


