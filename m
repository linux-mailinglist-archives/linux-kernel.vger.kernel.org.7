Return-Path: <linux-kernel+bounces-746952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1BB12D96
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD63189E221
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB457DA6C;
	Sun, 27 Jul 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKDLXkmw"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E11EEC3
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583436; cv=none; b=JmBl7rviztDwieYNznQQZwACKbBnh3eUkYeEqh1SdlXc7XgeqPhBLgWonZf7DPwc023nuU6rK5+K5smsfWH/uqpqqIUgOu/Ci32PUXcQJ2bci5/TR7ooWPbO62uF+zmRTR8gRhbQ7l5rvG16qVZYCjTr/nuzf0U0ooe1FRZYUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583436; c=relaxed/simple;
	bh=0I9fxR58nJZcAz3pQpeOHjHheTqWjmwCMjN8lQii77k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AopoIThpwhpJz57LJtMORk6j+FgTP8Pi2b9XuvUjIqb4DEuv373sWy1ac0HSW8H2fxLZlFyf8dQt4egMRUf1qKBtIFC+5vz7dk3yRDMMoclRyYjtF7pulOA8Z+RS0LIIjDvkL+ncE8zWrlzp8oiyHR2lF3TGK4kcmr5dyykrYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKDLXkmw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1990454b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583434; x=1754188234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDF8r9LlV6PDOkNzVojFEekcnssv1MTFYu7kS3ri1nA=;
        b=jKDLXkmwHdnhrQu8czkOW3MkSNrYOLlpwe1BNcdHREHqx+irandxMYw/ThnE21Zx6w
         xkmR4qTG6NcyapAzmD9qF9jXopULLjIuPj9aarTLM6QYYyJfUm4XppvOy5mVfbv8Gn5a
         faCV1zERwyb2wuDNb9dgFnV7pQ0dWuLPcEtaB3BQke2teWE/BdJw5ftuWKaOWqcgCEPT
         rb7yhxdeRvq3P7EmdFz9gFsDdj2yglTRIDFosU7ADE9acN0j3X6sZfdcDI68xFlFm1mm
         NwHvYYaZjUCkv6cLVHXg6+xvWcv5wdKh15RVqxXoUXYVxWVmAYhFhNgymPPdgGvWo4DN
         JhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583434; x=1754188234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDF8r9LlV6PDOkNzVojFEekcnssv1MTFYu7kS3ri1nA=;
        b=PJUm2WuoPVPY/tAl9WSvIbKXqRnh20goMqy0YNSitBd2FR0Vg3nQR9ynhjso/bdym8
         Q29Va9xTIf2aPcvaP6KcAGIc8Vi8cr7ENDizf9jJX7irmOuNTNZmLaazFsxxnp46+nxY
         qutPGavymzTHyKXctp+t0B6CEUXUiE2oN3qV/iyDKflzdNxFN8fj/loCL8VDzfCSqbCw
         LEfZadxSIYHnOQdQ4MD+p5DbuQw3ospFat82FV4adGHfHgsJQpkuZHPH4k/xzPRWlN+V
         FL+2SxNNsVpQ1xoqvJWpH4PEojf8KhfVhphvesUZatMf0Nllr+Jl0MV2pnkOrV3Idjqz
         zlsg==
X-Gm-Message-State: AOJu0Yzj1FPwZA+/RbgTNnBaZ8C44KJAxxGZOM7nqEBqtJmjWYPkRLsT
	Z5JAFT9K6GfM8ya0XcLrG8if1HCqA7izA+sRNx2TnSjJtiOHhPkfTja5G9BQpmDT
X-Gm-Gg: ASbGncvCDT5CP5UZJMggnyp7AwQ6PM5m9vi8WDh7ISWpLzmW4B/bSzqVNR1yL4M8J0F
	TS7cC8p1m0G1zCg4+GiBX1QXU4tgNGVTLXGSpis5YQa85uKg/pCHVvqdOkeoR0l9QDx2x7G3Dd+
	YYiMK60oL9C8etrgjatlczfY/jrwskH/jD3aRsZBkQ+qXdPOITB7rVJp2QWXldDWrun/jaPrvg/
	gnqnyTKiZLeBkxG55QnkNbnWdOwYZScdK8No439sDl1E6eNV1O2gEVpQ1a0yxCfRlUfnxiJeVUs
	SbDgQ71RaCMMfZbUWPDElukQQtLB4/7+RAmdMm08zVqG1cE5LfUsmsor7XatgMt8ZrklUYfB3r8
	SzOxXLsmuW0zcFZ8mrfdl7izNPbWMLFOVOzLXRKlWYgUcCZ32a3rSNC+j
X-Google-Smtp-Source: AGHT+IHs2E0jbOvneDxSKUpPrnZHY6kyHEBav64is1eywK8FQ10UeYMwwnrF7WKvjO0ra5jLcyWKHQ==
X-Received: by 2002:a05:6a00:3984:b0:742:aecc:c472 with SMTP id d2e1a72fcca58-76332282d12mr10030352b3a.2.1753583434132;
        Sat, 26 Jul 2025 19:30:34 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfc239sm2612911b3a.86.2025.07.26.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:30:33 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/cxl/cxlmem.h: Fix typo 'occured' -> 'occurred'
Date: Sat, 26 Jul 2025 22:30:37 -0400
Message-ID: <20250727023037.82319-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f5b20641e..2cda61806 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -155,7 +155,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
 	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
 	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
-	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
+	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
 	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
 	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
 	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
-- 
2.50.1


