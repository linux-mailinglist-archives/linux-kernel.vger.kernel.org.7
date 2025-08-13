Return-Path: <linux-kernel+bounces-765992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452FB240F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30521894A48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867762C15B5;
	Wed, 13 Aug 2025 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bspXHo5I"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076823D7C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065037; cv=none; b=p0MKlOFFD3bMt6oWxE8HVnZLrrG0BV3xEVJCnDXHrPzTHGnvL10v8aIFPdn/ykyANNseoniAgL0uOktyM8wKVzOfZiqRALKNC61fZPmiHkzaEtZO9fhymTs0rQa5pmm4griMJ3rSshqHoXGnHizPtW+5V95EhfXCkusv/ayqBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065037; c=relaxed/simple;
	bh=UeXlHfCjEZZ+zffjGmSWvLo/6vWoWI8Rd0/rywmOTyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xvdyn3GrQQIJnHLRLsmY5GYHzN8KPA7Qg1tJWTrrCRqswNqDXHTTb+XnXWQ/T7EGyCrc+x0zj3k6Pd/8XIBDy/6nw18DaazGQKPzQqy5+jkSt7FWbkDss7ZaffnW50DTjQNK+EOkIHtv0jcyeeuWgkzsRxBiQzdd0zVAmxykLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bspXHo5I; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so7062806a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755065033; x=1755669833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9RDpqZGncYw4GV9WsRoAupSSI2K1DVKB1tocQmYgMc=;
        b=bspXHo5Izbg4C60wgzVQQzZWiBHDbhKv1N7B25bPYfuVwO0t2qQk/WvDVU+zkT43KG
         7GP6wy587o3Rf9jCFFpvIX0ZROE3XJnrG4rrY0tgVAXk0q7WtEDBhLUEKU21HtyJ399F
         4eHNRGVMQSJekRNqNGNDu2PbB6lkh4dG+e3i686HLuwQHtB0LD6r7zFFG3AavkQCZwco
         8DnZUn5yFazLKJW9fE26qz/IjhVsO5gLzYUogLv6T9TMAtG+lSEH8R9/SuruUOdTq4LZ
         Zl2TpPiHF9HCLqiMElwxV5AqJ9le11dyvVSw2QIn7e7T0k0n1OP8vD2Fvxx32p3zf84v
         cD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065033; x=1755669833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9RDpqZGncYw4GV9WsRoAupSSI2K1DVKB1tocQmYgMc=;
        b=tjd9KEjXea8FYj7mtZ/PikRye0praXValpKQ42y1L2I+yTszcml4LG1p30yWIhb57r
         pXbyNOSGbwyP4jjnSZVgPDwKfnbVbeBCuajZjLaevrlFov3lFHIxzKJ9QyyTDBNJl+MF
         D6FpF1e2nsKzx/Fg7yoGb3up6rx/fFZxR6DkBCZqY+bF6WoC/Jp98lBPgud6PMX8pr2q
         sR71B76COd0AczXro8LQJXjc7SYml8xvTNELuJZq9QwEMi9UYx31E/DlrdLnbzvu2l24
         VxbgDPecaSHEIy7iK1GktXf933D+wUVgpiZXQ+tiutRT4r1Cn/SlPsytZEnZyZV1LUDB
         VG/Q==
X-Gm-Message-State: AOJu0Yzxm8I+gQ9izs86cYrBxpdGPss7sBUUf/g8AoIRXdhn0mP5Y9wJ
	4OROduCHWsAd9XX/3wOPRbfYGWt2juqJEn/VO0cNrdDhUuFAt+NgYXHZfPKiyKc1X0ycYuuWXkp
	/6nNE86o=
X-Gm-Gg: ASbGnct2CFDvZ8xzI8Ss5td0LWtKKbU21W9oiaexhe/ICY9r32g7t2BaBpEEJJFUJhG
	yoQh54DvkfhrY8vFTzPR7iqeUc1spbLVzE3FBH62SnudtwFEJcyM7JOKDK6O/FGE265z0b0tK39
	ZDbTWWklLq567uqlDoTzw2SBWwPZ5Wwt/kAkzDQp61naKYDLc+NIReLnO7ZD8cxnEZu6gv1WaPK
	uWmqzoF3w10pUbg1yYiHQEwHiGXTdv5UqPNS5W6RRAb05bW+7LGQVrCxrSOUPIK013C2+koi2CB
	ZmOknPhAB3+/bMYPlAq/6h7tYgqYZvHMw4rtvh+PM2wv6HRzVqcpRc0ywH+FJkYzCirlJi9JU1s
	L+MvieUIFBm9fsJwh+urUJGP/9hxvwgua34YhVws0Metresq/oP6f2wNooWSA0foe8YD9nKCXt9
	w=
X-Google-Smtp-Source: AGHT+IHPDW4Qxib/c3fl/QvNCJB64Z5YGN/d1oTyw+2Hx0fudTx9zXp/j1zq+pONC9zrU1nldBcONA==
X-Received: by 2002:a05:6402:22cc:b0:618:534:550a with SMTP id 4fb4d7f45d1cf-6186c000f03mr916573a12.24.1755065033114;
        Tue, 12 Aug 2025 23:03:53 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm21498679a12.25.2025.08.12.23.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:03:52 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	robin.murphy@arm.com,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
Date: Wed, 13 Aug 2025 08:02:51 +0200
Message-ID: <20250813060339.2977604-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813060339.2977604-1-jens.wiklander@linaro.org>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the dma-buf heap functions to allow them to be used by the OP-TEE
driver. The OP-TEE driver wants to register and manage specific secure
DMA heaps with it.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/dma-buf/dma-heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 3cbe87d4a464..cdddf0e24dce 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 {
 	return heap->priv;
 }
+EXPORT_SYMBOL(dma_heap_get_drvdata);
 
 /**
  * dma_heap_get_name - get heap name
@@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 {
 	return heap->name;
 }
+EXPORT_SYMBOL(dma_heap_get_name);
 
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
@@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	kfree(heap);
 	return err_ret;
 }
+EXPORT_SYMBOL(dma_heap_add);
 
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
-- 
2.43.0


