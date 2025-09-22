Return-Path: <linux-kernel+bounces-827763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC8B92AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F98A1904CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2431A545;
	Mon, 22 Sep 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxxVcq9N"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD27275860
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567412; cv=none; b=ui4Jal1pzfyaN9JUs9MbmWhiQvGV8X4m6F9muuFl99ccg05yjC2PE7ohGLPRZCn7BHB9fZh9WZ+phvPPKMLJ/W82buUMI+tb27xu8x4biVtqmd26aAJ/D1vMCLwoS831v4R0XFYHwro+cTMVebO1GZpJ5nuX1dVOLvCuYodnJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567412; c=relaxed/simple;
	bh=pmtmdIqpwp48d4/s32BjyKje6zxImLmxuZ9drhEB0mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s+ZHhvQvp8fofFJoqR6VoSKJ7WkonQMPw9OJo5qovcShP4NTZRQnaQkZjdGtCDq6//ennw0XBasy3PZgprbYD38Bb6jbSwObvMifexizX7i1xk5DhOw229MUMFIyM1VMCSovcL2wINR12SA9F5jULiWgXaVKjkS0IHn/jkg6Jh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxxVcq9N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4694ac46ae0so32164225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758567409; x=1759172209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyJq43O++KjLnjYoBP21Xp+znz9y7wC4OFS1xU5rHgk=;
        b=GxxVcq9NFCqKCAmT2QXd/Yh/WXiENWQf2S/43QLJ6oZNDNUVuJGNVlBKdDC4aM+M6m
         66oP1j1AElAsO5Xal9YYfcWnIts1QO+SNw+vCYTPkV96gMNUnULoR9T+R+9ruQn4B3zc
         dqYEoLoQ3ruphy/S7jwjPZHFO5q8scaTd5M21eYm6cCgK5Yuf/f73aMcNbm2Bujr67dF
         4rmL2KNTJHYD/ocAozHw6iyBs8zlZbNDYFddgRoZFBicuzgIa1ZoBakAJtTrofmtUFGm
         cj4ZFMPGfYeDCoft5/D+LfrGaaqBiHZbLPTOtJ4GzHffnEdAcu7Yw9ICmlbcScQRUiDG
         5+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758567409; x=1759172209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyJq43O++KjLnjYoBP21Xp+znz9y7wC4OFS1xU5rHgk=;
        b=ELg5gleDN1IRqwJpgjuhjEuVcQoe/4SGHOiG1BaIaWqtZbORRim72CNwRGdoNrbMCb
         +nCO7/7Yk/KUiSFkCw4wlI7jWis24e621hntn9fnh29jABpPdVh7HtHdBq9vCxuw2fJd
         IXE3gFw0m4hN/Cymqe49YayZaesqBcIf3EBYwc1gCl6Yzo5SRM2hVHo/g+FGlCYXhGLz
         hRl4AA0Q5LwpVWNqxr23SGnIFxJBhAw8Unb0cdPRbH6vDAdLh/ONt+lrj3+Xd6DRn0as
         2GhHU6ptyEtEF7N8bnrvVOfIFwYWPZcF4Et5RQWee/vuqsnQGykFxvqLrB4scvUa6X/Z
         zrdA==
X-Forwarded-Encrypted: i=1; AJvYcCW9bdRMJ7wlooOmrK5APBP8ZGOmHGMqbeQonoMIhr6u+VBqD3kkA11LfJE7turQA5g2e8pnD96hVtfOzx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOIAES1rHXWMqaPpxmEd0S0NFj8lsVScIAG9qGaG22GMru0HD
	sHz+JJBo1E2eeznCQ/ch2TqwdnYeVftTfOFZV6Lwxn8DTFZo2+GwClHV
X-Gm-Gg: ASbGncuqhBoie3vxVJqKGAKppMyWjdcqVGoIIZuS39s9hEXCTHctB5fOuZrk0k87cA2
	WG/IS6q5QC0HLD6EkWNbnLjKpaPsekH1ds43qweSQGkcXF2EgvyN773H9vGwmHvXOREizYmNEqT
	atcZoW2LGUptU6ETBtn9f8WP4CDdFp0j1fR9gzubiE+Coz+tbh6eYk8Iqq8ZyTqdSmF924K4es3
	FbSM0AI7+LiGxpBOiCsUVVCUL/1hkcI8AV7Rj44xifSZ9vR9WT2elT5Mau3gzFMo7S4QwTiH9R7
	EBEvPBoaKsGAYYBjJxQsx4FMZ9MxwYjMPfq0YUtXg4uEPM/UQhkE9/4UGotREHxiV7wbSWD3Fhx
	d0xDToy8JChvBwOSycQXXwLRpeHCQ3Nk=
X-Google-Smtp-Source: AGHT+IE2hNAByN1u+WlmeKvdGqq3iQsBllgNjf2IKG0z3jtosjk7L/KvCjfFpn/X7tEHILQPO5GNNQ==
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr134177295e9.33.1758567408745;
        Mon, 22 Sep 2025 11:56:48 -0700 (PDT)
Received: from moktar-desktop.. ([102.31.181.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm241209755e9.5.2025.09.22.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:56:48 -0700 (PDT)
From: Moktar SELLAMI <smokthar925@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	lijo.lazar@amd.com,
	ganglxie@amd.com,
	victor.skvortsov@amd.com,
	candice.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: Moktar SELLAMI <smokthar925@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: use kmalloc_array instead of kmalloc
Date: Mon, 22 Sep 2025 19:56:35 +0100
Message-Id: <20250922185635.50828-1-smokthar925@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc -> kmalloc_array in drm/amd/amdgpu/amdgpu_ras.c .

As per said in the Documentation/process/deprecated.rst, dynamic size
calculation should not be performed in memory allocator function
arguments due to the risk of overflow.

Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 540817e296da..8dbb9e349a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2566,7 +2566,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 		goto out;
 	}
 
-	*bps = kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KERNEL);
+	*bps = kmalloc_array(data->count, sizeof(struct ras_badpage), GFP_KERNEL);
 	if (!*bps) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.34.1


