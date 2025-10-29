Return-Path: <linux-kernel+bounces-876033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB62C1A7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01E9D5670DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB03385B8;
	Wed, 29 Oct 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlTsM2Mb"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538A33A026
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741282; cv=none; b=JsIOS+yyylKeHrdWdstvHHt8NvuaPlp6WydZVWU8CfVydANJ4ohQyu28bUO01V3zgO4QW11erqJV5z6zvuJhnd3PPBT2ibb+E4/Q9M2hW/ErugU2In/a61HEynspRc1kGuDGfbh82jwPqpbSO7Mdsq8nzbbirHjyQdgnU2LpDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741282; c=relaxed/simple;
	bh=MXV1J4/+oon+M/oX4IvFjQMNXVSF1SduLg0p6csa7Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNIZHkwT4GWhlt6x8nlh7et2hjNyWAL5dlc3tOLtk3FHniCr3K9ZR6wboEy7LzQiiMSmraD8Fm3kx+PPcY/XupMP6rmGvMMwbDgfdmzYthNNR9StaQTYogTbKIA1bIHMRMhSqkEmaEG9APmkWmr3ioqs2x3oCTyPjkCnM0QqEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlTsM2Mb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781997d195aso5170577b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761741280; x=1762346080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLbzXZCnL4JaNq6mgAHYUsHmpe2Hmi5djVf9Q/V9xNE=;
        b=YlTsM2MbR9EeECgQHr8kew7suP6O6K5qbkyH953T16wNEaAsdkyw1xC3Qah/vaKFRS
         uyPRip5w2rqcd2yRBia98hutLBpQ0PoSOSbX2UQlPjIxdVqEmmiTypqaHR3QZfZcVuwe
         vAuJXF2j2MdlZBTDnjwpkdSO1u8/bGYFnd6r33yMgFJ+IOAtSkQ0W9NwmMMb5bPwKUBq
         Ap1FFQc7VYsoTNNoajcmeNrfIMhaCeJTUUD/C471jonCD8/nFIunNDJDGKS78SBH409u
         FhD/HFFeo6UV4Mn5UUGVXE2OBYn4VhrcDp68yTn4zObfEj7XVy9V4FB3P5eS+Yi6rE9a
         g9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741280; x=1762346080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLbzXZCnL4JaNq6mgAHYUsHmpe2Hmi5djVf9Q/V9xNE=;
        b=bWaCI8BmdzCqPdPpyPgZ/Ds3mJsuKrfxYqzQbiXBf04PCr9ChpHuwPyLTLkoiKTuLK
         5rI/y3H3lv82hImH8whT1rgLswY1vkOVgkImlDeskXpREWJCx+UVjcjeOwMu5iGbOJrZ
         T8SC+/JgAxve21mSN5P3Nv+6LPJb6wOKh2nxDQcsUewYpUl+TpDpTA9F8DZsrsWc/kwI
         3GHu2t+YvEI0IpzZ9q/5KRQDdMwJt+WaM0MlDkkSrN2EvFC4Ivm8zujfQ1gWN9W1hwr7
         itrgy11WPQBmQpOy5WucVwVn3mMv1xMxBAdZgkWBPGx7jFlergaejgm4MdLXicJAjRlq
         8WvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVusOKfbMEICMGMR8KuBvarGCE2L8aUw5HgHP1j+E5VYkiNNrIQaIr32dSG7Rv2kNm0FJoR69dDkd/KS/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYNILjoO8eR1G9RgTLOyVc3MBDW2umrKaKcTEr7egoFpRfAC/
	IKFxJpo8+pyf3I4BJED+beez+RblBgzacKqK8c7UPlCmxlykAihrO8kR
X-Gm-Gg: ASbGncvUFJq8DPCownA/EjnHAUAnrEJWsHxo+Z7ByVRU3O5pGK4AXwBeJqKErEhrmTr
	l+vUqgt/FB7wTBqnZyhDDLNpRMcEozM+PGkbCTYRM7O6rN2fYyeJ7ywuZOX2+g5NVA3AaqMC7n+
	BEReQT1kNMY+qqusBLoBCH0uO4Kt0E1NUPboTJMh5CzYZquAcSbtljF93rokTWPANeH970ONPSX
	PyaFdH3cSjGYt6HN0IgvL5iOHOMI+TC5E48j9MRtSpx0u/SPb9RyoYhwOdTALoMFoj+sqseLhHZ
	xp1LjnjLeOsROz5p+K2yBMiiYTWqR8Aniyd9VD3gdmU7JRfb+A30dhEy0oVFnj6QbXYckWql94r
	xM865/kX6PhoWXeu50RmcPk5hR0dcN/n07HXnwtFTG/WtQPG4kL0K1iTKIWx2Lq9rdUulgWMSmj
	aWuJzBNSFhk5BdmUPNnJRY6A==
X-Google-Smtp-Source: AGHT+IF5zDqYY2uyyaccHKjplnekkK2/6d+ShgjS5kIKOgPfbgi53OKTaTURa3EPvj0xY3duZVdWCQ==
X-Received: by 2002:a05:6a00:b51:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a4e2dfbfc0mr3441055b3a.13.1761741279605;
        Wed, 29 Oct 2025 05:34:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm15206397b3a.64.2025.10.29.05.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 05:34:39 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] dma: qcom: gpi: Fix memory leak in gpi_peripheral_config()
Date: Wed, 29 Oct 2025 20:34:19 +0800
Message-Id: <20251029123421.91973-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a memory leak in gpi_peripheral_config() where the original memory
pointed to by gchan->config could be lost if krealloc() fails.

The issue occurs when:
1. gchan->config points to previously allocated memory
2. krealloc() fails and returns NULL
3. The function directly assigns NULL to gchan->config, losing the
   reference to the original memory
4. The original memory becomes unreachable and cannot be freed

Fix this by using a temporary variable to hold the krealloc() result
and only updating gchan->config when the allocation succeeds.

Found via static analysis and code review.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/qcom/gpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8e87738086b2..8908b7c71900 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1605,14 +1605,16 @@ static int
 gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 {
 	struct gchan *gchan = to_gchan(chan);
+	void *new_config;
 
 	if (!config->peripheral_config)
 		return -EINVAL;
 
-	gchan->config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
-	if (!gchan->config)
+	new_config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
+	if (!new_config)
 		return -ENOMEM;
 
+	gchan->config = new_config;
 	memcpy(gchan->config, config->peripheral_config, config->peripheral_size);
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


