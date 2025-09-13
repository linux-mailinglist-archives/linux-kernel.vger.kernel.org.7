Return-Path: <linux-kernel+bounces-815331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B0B562E4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69794178E11
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C725CC6C;
	Sat, 13 Sep 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkH9y2yb"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899032582
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757794615; cv=none; b=rRHJwjRsqHMA6Z/Gx6DUX1xxqon1TTboSa3kj2pGidBMaa5TmJzK/zErDgRA5SsisOx98LMHLHjGHM+RqygmKkz89MmZxziSsLk4Us+5s1ZsSRvDOZ16NJefQeadHlq/IRgvhUMNPlZNUhG4CbvFke+llKm9z3TW40R3yH2J/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757794615; c=relaxed/simple;
	bh=FWdFpDZXgweIgfaXmSGMrKPTFYGwmCSWLoLB9qphSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEz0MePbqsWYRZ549m/UWHvmRUFfBWB2oK7iNnyuorfF4ZsygQw1LiS2C6fhlOSXNTLv0uT5Gd2yfKuAyn7T3KnyyDjn2SPt1ndiP3rScIv9OY956kquJuauWBg7wWjfubC4V8oBsAWFcod4zwKDyPfDgjxLPUduXNWdERnKIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkH9y2yb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso23046105e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757794612; x=1758399412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=FkH9y2ybKE18FNKhDndmsYxvTYUISKvPx3eEZ7WQVsHSgzAdAorQifVzsdSRggBIlA
         iIxScMSQ92KDtJeuWeEThjPFq8e6jqQTqkO0UCWvFzrVAjb0YE6w9v8QODeoltrHJqoJ
         +sOnxmxYS58h4zs6l7flow3rJxF4s7zvIjJvTJvqaiIvRyo0KC/drWpO5ZfeqAX8Hr8P
         9tYQVweKAdbC4+TgJMPZEQIh2Mul7f0LDGS/I5QljP39XqZgexQ0hRkneZ8r/CxEewJY
         hW8R6L6JTil/vlHHMTfdfTAcyQgZ/EnbVdKaE9QgHMwSao2VgkTtUgBpg4OA1vS+fOAr
         75XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757794612; x=1758399412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=J2/kbxG5OK3Bk2IEVbF++mvq9MhIqrQ2D8ZwxFXo1gi0RajuyAOLgdKJgZ4JRALf5u
         KTkQOVYWld/ugIpx5PMBmNf+0IGxsLo9LHN+Jfp/+mtoT32WUr7bC8naDjXnj4cVvAdr
         QkAAjeH/eT5jSFoQ+JQSCQQ3bbleii6LYuCbIxePHVwvNLs6M8QHjlmpn/9OvMQt9l8z
         kga3sroWb7PPeJSa4T4kayB/IxUj4BAjwC8lvRJFEqljro3Qr5SJ3NTED50gLIuC3vUz
         taepF9pnug/XvI3/F32Szghn1GeCMSdiqy2IiqI4NgS1VF0vGcdc0Uh78NXGRqU3BW79
         nG3g==
X-Forwarded-Encrypted: i=1; AJvYcCXVWrCotcuiTM8fWRMvaXx0hsxGwzLrls28LlKQWvifsG0+se5Srdp/62vBsLecxx2sXr/sWeVgcw6omps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ195S7LJkFJkfl5AihNIUwoD9rTvcArCXoX+MGrhuJpuqtBD9
	DXQHE5miwiyveseJNslIZ98Z67p+OquWMvpAWHiKRykBsWEl/eFIAOSu
X-Gm-Gg: ASbGnctM4EWQ6hyyQcwJF1VJZbqgJ7dxQ2ut4Zr67tpzyWQZ6GitlaeLTvhGGid8pBz
	ZOdWxq+9A/r10E9dfk0PVfMvQQxaw/ZTfOWhsemSGNhL0TOgk2AYJwZRsGyq534xFRN1anKMYvM
	865fOxhPe4MB0nZjQlaLdMWign/lSQqc/81Gb8OeIKtvsMCR0jXbAVvq6hwIaeGtwxGGQpCOjoL
	1hdGC71XiNjFo/SC7+rjJgUw4wuQY9sPXbXsiCd46HpYj+xC5ahNSpk04zMJWSZduZAcfr8LmWK
	+mvQnrF55ryBrpFsZCrvhvDT/YFnc5MksBIZMO/f0HOcZeGO/Cp+YpRU/h2zpYYLtZv/vNSqOlc
	8YFJPD9WMvt7JwXXxdKTSKD7yOOA1qjk6
X-Google-Smtp-Source: AGHT+IHM94ZQbz7LSAD6t0BWLw0dw4XltmvObHjg9ikAWt94vPnfOCsjro/zNpc96RTnU6ULUDYJDg==
X-Received: by 2002:a05:600c:1d29:b0:45f:2aa0:cc07 with SMTP id 5b1f17b1804b1-45f2af44393mr1464885e9.29.1757794611659;
        Sat, 13 Sep 2025 13:16:51 -0700 (PDT)
Received: from localhost ([185.63.82.103])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e015bf73csm57532735e9.11.2025.09.13.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:16:51 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: amlogic: Fix error checking on regmap_write call
Date: Sat, 13 Sep 2025 21:15:58 +0100
Message-ID: <20250913201558.1338180-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a call to regmap_write is not being error checked because the
return checke is being performed on the variable ret and this variable
is not assigned the return value from the regmap_write call. Fix this
by adding in the missing assignment.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


