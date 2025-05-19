Return-Path: <linux-kernel+bounces-652980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED01FABB316
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 04:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC03B6FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76FC1DF273;
	Mon, 19 May 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBVLFfrG"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892411D7E42
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620333; cv=none; b=CsOGuieUwQJL5RV4OU20DEdd9CXIOYNE/n8KzWY0BbzNPddBHFePE1R9/lN6gikcnwvCnyYFU/+TP52A18Itw04ddhJepn190cvFo8l08huCKX8w9fARldarGVjyxS2w7W2bJwB2x1cKaCHe58ntzTRqTUiu3JKsCzvm019zMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620333; c=relaxed/simple;
	bh=cgC2bKbGN145SIzxxROu9xdk0UstJ+Mxq5okATrOS2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dtFb6oBuZZXWzfIxUqOK2Gg7GOd0HHKGfIKsvFsyKbTRvscvIWoC+3fyMLQKZ8pEAdQTRaG7e7whkQ4vNKtHgrTyidIK7gfyb2zaEkl0ReNc3DAVg72SCfV8IJZk12zE9PRGLxhqzlICeIMut9BYeJJEiysWPDDxZMwaIJZn7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBVLFfrG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231d7a20b31so24226075ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620331; x=1748225131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5D9tZ7lGJ/V+3LuhRgNag3WNMa+YH+Lpwj9LaaZAW9A=;
        b=wBVLFfrG5lIaVHc99KkdwexZnm5gjc6vVk8hBAoxIRWhdJP0YkBN272+PFwxK8pZPT
         IxKCGMbZf/Avxj/GJevPe8i/RoxVwlfNZhcTKMh6GF4oUk4ywL5CcHMzCseO2sOyuYL3
         23LYo8S1avrJ3dQJZbjBpMiV45a+8k3OdvWgorWTj+JAiAG+iXrYeRCsOQDiipgw11LM
         5xXU760FUVQysESXan1iVeiehzraOExVj624s4t/CJnZQ1PKN2j2Im5mKfmFYSLkugk9
         K0wF/6Pm2NpnCakdHVLUk+Gre+D9PnhGZ2C73zLAAkt01cZFI6gjK/I6JpuNmne/Da9/
         gIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620331; x=1748225131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D9tZ7lGJ/V+3LuhRgNag3WNMa+YH+Lpwj9LaaZAW9A=;
        b=VQOzZeUMMRDFgciWzGkaCWBcyCUosKT4OwfI4gCKxvMdxRLklG0rqFdvgtKLUzxmlg
         0e2pZ6cFNIY4mZVGeXuWsGth+noz+fURHi3BA5Zrwv0CWlqzo5xi8pQtuQ1KurCDFs7o
         NSTCbVIxaz/N26E+N1054sdUdNp+0IjBN9Bos63XxDZrnFnFDxDSPmXiFjRDy97njX3r
         xkY6p8NX8Ic1DAzeU6pPR9WQELKryF4tIWxAcnSAHR7yfI/gC8mEQaoDqhvGu2GSLx1x
         T77n6Ctnw8h6OnlDA+0NG1G/6H5OHHd2c9XVleYphOr/QUsNSM5nTwhMfXZZwHB84RAS
         naSw==
X-Forwarded-Encrypted: i=1; AJvYcCV6fc9ErKJSIdqWjXdqi59FeTaGF/Q2WrjriTfUuob2cHuLixfoq6XPx4H0B1vHsucflVkGpIbLMs4Qgpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMaSDYPftqFw6N0O1R8OHef85XSVWhuYX/zBhtpFgx4JkUV9p
	nK5k9AXkkezcZXcEypqAVTyYHW/k2wH7uIImPwsevdZguvAABW6fwPDCj7DvBcNGK7D7gIK66JH
	ml7NZFt/JAQfQ5ejLAE5Xjw==
X-Google-Smtp-Source: AGHT+IG3j7Do7IbGAZ3dDiD1KauPj9WTYzC2ZDbZxcTdDrHtGWx9FYXjV4NnDyYft8gZpoX+CDyliCNybh6S3Nzg
X-Received: from plki13.prod.google.com ([2002:a17:903:1a0d:b0:231:f3aa:e763])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a68:b0:227:ac2a:1dd6 with SMTP id d9443c01a7336-231d45273c6mr192805125ad.24.1747620330803;
 Sun, 18 May 2025 19:05:30 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:46 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <0e5332f7758ad24cc5bca36671fd811c87881db7.1747619816.git.ericflorin@google.com>
Subject: [PATCH 3/9] staging: sm750fb: rename `hw_sm750le_deWait`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750le_deWait` to `hw_sm750le_de_wait` to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750le_deWait>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6a6b48254af8..9c62adec9914 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -609,7 +609,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 				 hw_sm750le_setBLANK : hw_sm750_setBLANK;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
-				    hw_sm750le_deWait : hw_sm750_de_wait;
+				    hw_sm750le_de_wait : hw_sm750_de_wait;
 	switch (sm750_dev->dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index e24ec6a9799e..7de3a3d44dce 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -195,7 +195,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
 int hw_sm750_de_wait(void);
-int hw_sm750le_deWait(void);
+int hw_sm750le_de_wait(void);
 
 int hw_sm750_output_setMode(struct lynxfb_output *output,
 			    struct fb_var_screeninfo *var,
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 5a6ee02bb95f..49b0d5b91183 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -504,7 +504,7 @@ void hw_sm750_init_accel(struct sm750_dev *sm750_dev)
 	sm750_dev->accel.de_init(&sm750_dev->accel);
 }
 
-int hw_sm750le_deWait(void)
+int hw_sm750le_de_wait(void)
 {
 	int i = 0x10000000;
 	unsigned int mask = DE_STATE2_DE_STATUS_BUSY | DE_STATE2_DE_FIFO_EMPTY |
-- 
2.49.0.1112.g889b7c5bd8-goog


