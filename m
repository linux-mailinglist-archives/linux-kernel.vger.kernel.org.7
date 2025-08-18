Return-Path: <linux-kernel+bounces-773038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12332B29ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BF55E4201
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E182797BA;
	Mon, 18 Aug 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knWcbrEr"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663138DF9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501661; cv=none; b=rjy/9oBIYiESk1Mww+bjlGo0g+HnKR3ZSu2NTdFvnXyLF5JXw/+UWkP013voq/85UTeLBXfB7vOPOpaZelxSX+9o6FVnSwf3boK5s2mFh0EBnLBZD+4a+cFfmxt8lStOIvrwxU4qTLHdWJ92HQZX1Kj9ZiMprefnm1iuMz9eY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501661; c=relaxed/simple;
	bh=5GenRPy3baSu3w97PoweP98byWaAto2oBp86y/fbtbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i6wnCBVStNXUtG1CfAd4VU4L2HQB2nvaveGhjmQdj98Mbb83Ygf8h0BWlFLK8jwbQmxRwhhc/+Ru8MW5naCMetv5KbV0DAWFisZX0FOZf498J3p6ZFHUYcgeReTVuM8N3WEOa3iTX64Kr0QGzpYX+jV6YRDE23GDaStPxg/ZU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knWcbrEr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so4918744b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755501660; x=1756106460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1EueC6Fubxsq0K6avHKaMHl/1DnpCdRxvVIl9pCUSY=;
        b=knWcbrErt3vdTo+1JXAW/B3OMry36PJkGEXT28IABvBGP5DWmk+G68aqL+DiWjCOKq
         //DKAwELqPoF4tOc8j5TolhgBkmQSpaap2tOLIDmKy7uf9q+mAA9kfEMvh3Cx+Y8q4JV
         VV8wSQnf5BywmEs81ksA8GQWCCmZeM+VHNxKin8S28cwRnD+PGuvRCxeqhob90cinb2F
         ZJXm9aJLAx4WwL0vAV04AQqULj9pjlP4Ze9XXkfvz7RXG2fhtJixdUfa5IL38WHhfXeK
         Vnvpsopelu+q7OfHxBRHP1mcUJFg24baSpY8iqWJtszd1qDcJd5JnQARwRUkSPoLnAP8
         YChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501660; x=1756106460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1EueC6Fubxsq0K6avHKaMHl/1DnpCdRxvVIl9pCUSY=;
        b=cAfzepOcfkOldnJX3CSUxlumedYQsvfUOCoxW0K5WCPqYWY/gCINrWDlAiRfZARn7D
         pis1QL5kWsM/LCMPQHBHvAZzPyPnm+1beHIgUkSxZKcq6BhG5U1OZhUfnHSgWIdmGiLo
         sBrp/83YLhokBN8Whz0H9PAKN9hKlxggBO+VVVvEQRc0RcSPC/lP7Fa0ob+aEEVbFMxu
         9yFmjmpKhJBHs/N83lxqtw45FxIeHZ+3WxRFN7IHoBpdKOX5CpYrJhgkD4sxTtluVeLU
         Bh3hfi8mTjcN1MiDw3N8SDwuCRwY5Lvev9CN1yB+7bKzV+nqI72mVb0KI/DVm484jFUr
         N9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Y9mhtNSOmhTY/wKDw7w9+K/LlzP7+/hjTNMQ7fgbGeKWef7igWrd6w7Z5Fna5hnVukyVpu1uuSykjR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7S8GqZ2JnLIQysNjTq1FYb3wpt8Zhh7gwjhTF848jlx5ugvIV
	W2f/qZbHhWJGDs5bd96InoNZHL1UEObYQT6UX0rauKsdLcy2OJE4HWZ/
X-Gm-Gg: ASbGnctjdSUAu1EUjEGraQSiPlhI8tmzQWoTInBvTajUNKVxV3AVkZdhQ9xFauKLEoe
	S6FYe5Mxg5G7pM8W63LAGsKciULxFTClmncgYWXA5mXsCYyMLcFY3gI9rOhcMcLeJ7Y0CS/wUYc
	HBzti0brZl9IEPC5nE8Fimw/i+leWHrKqZjRjxuHWWqHM366aobh/HfMSIjvTgXsT84AK4ds6Uw
	zFu/FawKhUIyZsxK8We7fu/EnEutl3OqDFryIiWhnemxlJJ357/HV26zQqe//Sc+sJuDjKU46/M
	T3newnLbLx+UdOreGFrsBelSeEM0up+6ohk/z3Ardy3o9ZLPuGN+6rx1goT6uOVp1iZydiGcN8H
	4hZwef0o4+sAhFtX/0AxE1K7Gj4Nc2ZwXaZJcawNZGSiMZxE=
X-Google-Smtp-Source: AGHT+IESVrvVh+TcBYRzF9y7BmsCm/EL29AU09TeVQWqktjO8x6nSozf5mISthkeTLSWkIFc4/4GAw==
X-Received: by 2002:a05:6a00:3c94:b0:76b:e868:eedd with SMTP id d2e1a72fcca58-76e4481df98mr17296908b3a.24.1755501659513;
        Mon, 18 Aug 2025 00:20:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8899:4b76:ead:acf9:f900:1070])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45268bc5sm6480439b3a.18.2025.08.18.00.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:20:59 -0700 (PDT)
From: darshanrathod475@gmail.com
To: lyude@redhat.com,
	dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] drm/nouveau: avoid assignment in if condition
Date: Mon, 18 Aug 2025 12:50:47 +0530
Message-Id: <20250818072047.376046-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

Move kzalloc assignment out of the if condition to follow
kernel coding style guidelines and improve readability.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c b/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
index fd5ee9f0af36..46273e6b14ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
@@ -262,6 +262,7 @@ nvkm_falcon_init(struct nvkm_engine *engine)
 	/* upload firmware bootloader (or the full code segments) */
 	if (falcon->core) {
 		u64 addr = nvkm_memory_addr(falcon->core);
+
 		if (device->card_type < NV_C0)
 			nvkm_wr32(device, base + 0x618, 0x04000000);
 		else
@@ -341,8 +342,10 @@ nvkm_falcon_new_(const struct nvkm_falcon_func *func, struct nvkm_device *device
 {
 	struct nvkm_falcon *falcon;
 
-	if (!(falcon = kzalloc(sizeof(*falcon), GFP_KERNEL)))
+	falcon = kzalloc(sizeof(*falcon), GFP_KERNEL);
+	if (!falcon)
 		return -ENOMEM;
+
 	falcon->func = func;
 	falcon->addr = addr;
 	falcon->code.data = func->code.data;
-- 
2.25.1


