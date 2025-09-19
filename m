Return-Path: <linux-kernel+bounces-824539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381ECB89816
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0591C287FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFA1FBEB9;
	Fri, 19 Sep 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCljUI7S"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E91F8723
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285761; cv=none; b=hZE0L6vXdSqzspp8ayjV4EiOKzn6R7P1AVMw02LSIvOAhJqTUL51ZSI1+PItDUtabqp8SSZ9Dsx4Nhu1tP4e0IEFD6Hhq/n40IibNUBbrRXOznV+yTo/+B6SlbdERt6iSmvmeWoNp0uZRNWcwh7Uc7iPhevCHC2xPnbJ3nyJHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285761; c=relaxed/simple;
	bh=JORA1gDfS/Nfb7H4WI1KAIpM6/cjUQBA5RYJUWYUP9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb0X6dEysZREhEfpYU46pRDps1I+pkAZAPI3/AjEhSTgVJA62v4SzWHkcIMwjTfCfHtO+OyZtPmH9EqW2DIN7/bRsVFVmPztUb3IZqwwmliEiA87MD4qulenEhkgDbB4AwS8PbvYXmlnPupMAxViQpptbVqMFJ0sGMRYvzJHy1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCljUI7S; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so307222966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758285757; x=1758890557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=aCljUI7STkPyEukgZZAazRPsrTzQEjbXQEU6IzopLcU+4Hr1YOYw/ixEpVvlR4HTdg
         MfVwABzulYp49S0vJeRxHQx6PtSfH9RAhuQk/WEFAOsuuqhnGwBwRtOLlMOnasTMGLqE
         +sQUysf2+9H415KMdNcXwlCNhXiZL54wZiAjDTUnWSRQd0ZnkW7u8fTcYNlLT9unFtBq
         aCGkvh8ly7ei7v8BVcHdBHdKjk95u6+y6UNNA7ZY8VFdSB1nYeSQRfvN0kp1GSzOI6to
         /YP42qwD186nLOLVb3lb+/ki2thixPOTVAFQ/jZm1DRqu9sQqfGCl67r5uqEyBWZdrlg
         WoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285757; x=1758890557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=uVgMbFDQz0h+pmr100MzkJtKr2/7qHpFzaq4gk9Q+hOVVeZ3h9Jl3+Fimgt9GBl9Q/
         PFzuvbpyIi0NziYGTj5/+9arxBZVhqwgo6ylNbyZxNegRDBKwwl8NeyxqjZTnfUBIXfa
         505COHMLDS9skk+a6+V9mZQ6/ryQpoo9qqnw6V9Vy/5IIS2kktKrO/tbsXJQniu6N67M
         KeFvBD3uIVwrQ+8Psv9EGFEtQJ3sEaH0G2aUFkKFlMwgFqMZ60/f9fevJgPJEA6fGI/2
         orqAeHe8c7XVT5XnIH1ns40PI7nEjpV+tfvtjKsUR1K09PJpRritlhpjznIYisEPiHfe
         Z+vA==
X-Gm-Message-State: AOJu0Yz0Awq6Q9rfSPFs9Fs5SAfFpzPRWqZv2x1WGCgCFpPEvWWdUFkt
	iQyVd5RoP4O6m/Klw89WckXHzlt6OTz/SPkpwZEja761+P/99CsXTxCDpu5ErcGx6YokovrJ1MH
	0pgdsOi4=
X-Gm-Gg: ASbGnct+pAS1xCXmR9Zt96UHeHNg8D57oFrTGWPHezkKeaBlwO6jgJ6ZsEe3+OP7ROk
	6p+rZcYBy8cV5h8WUM6+TivOf2flLOziMTyhZr48qo4hCc3eLdEMB4OYv80+1268kl6hHZSQFEE
	pNgv/AYdHQlBbe6vHN7hcBPJsBUIjZ1uVGupY1nW+7hfkqD67zvQP9pk3Xf1o/E8H/vWw/i5N89
	DzVmVrjyuzXpszl33Cs+cxJIkM4V/OykNgEz8n+Tb8ccYh8qPcA8VqtCh2FatOS/scmHb7jK6/P
	rnbE1l5lMa4P7fr0EgTf1J34B1S9IBm4VEyc5Ruhc0/avZJuiXWRMAkak+eUDtO8Xcge4+rfSPB
	0S2qDmFvPsbKFFM0VEv5S/FYvt8oVCNn5egZ9mUG81wt89fKyZiXEYqdSPrOlaP+R8VwlK00P6B
	c=
X-Google-Smtp-Source: AGHT+IFr1BTounEptyjlbKSLG3yb0rrKq8OODXhqwAInRGVZzvO/n5qSDVMOGac6sdWkTXPIaFNEFQ==
X-Received: by 2002:a17:907:2da2:b0:b04:6e60:4df1 with SMTP id a640c23a62f3a-b24f50aa963mr308717466b.53.1758285757281;
        Fri, 19 Sep 2025 05:42:37 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd262993asm429170166b.94.2025.09.19.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:42:36 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	stable@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH] tee: fix register_shm_helper()
Date: Fri, 19 Sep 2025 14:40:16 +0200
Message-ID: <20250919124217.2934718-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_shm_helper(), fix incorrect error handling for a call to
iov_iter_extract_pages(). A case is missing for when
iov_iter_extract_pages() only got some pages and return a number larger
than 0, but not the requested amount.

This fixes a possible NULL pointer dereference following a bad input from
ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.

Cc: stable@vger.kernel.org
Reported-by: Masami Ichikawa <masami256@gmail.com>
Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..6ed7d030f4ed 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 
 	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
 				     &off);
-	if (unlikely(len <= 0)) {
+	if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		if (len > 0) {
+			/*
+			 * If we only got a few pages, update to release
+			 * the correct amount below.
+			 */
+			shm->num_pages = len / PAGE_SIZE;
+			ret = ERR_PTR(-ENOMEM);
+			goto err_put_shm_pages;
+		}
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
 	}
-- 
2.43.0


