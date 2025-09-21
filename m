Return-Path: <linux-kernel+bounces-826198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B254EB8DCF8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A53BBC01
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC971624E9;
	Sun, 21 Sep 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gei8tqbQ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149334BA28
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758466506; cv=none; b=rlrN/vSc9ouKbrD0HSJGCxdoyADz+cW+8gckr9wBULq6j9sDxNR21N9FyJ/v42mgWE/4xfRA987PagwoJPhN/V7g7/6Oh/4yFm5J2+zWeNUu5bN42xvm1g49nE0Lqj92bXE6tCFbKBh6uiXsjETXGSq0niCR52zZCkzWNphM3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758466506; c=relaxed/simple;
	bh=glaso6ateZF7I8GRgupqxyPX/ZQ2qFynyUuNaxxrxsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kh8PuQXEjmqQXgzSQQ4oisHEHtdf9RUV997T1rFv3C79qdAIueCtFhgw4IjxWSzkXK/9YbzlwNU62dYMlcJveMOFioGT+0NMPe8VH0ju6MESo+nYSVC2AqG2jVfrpJVMjb5ifpGZFbBIzyPLlgKMjZIHdKoKAjQFf8zxvYCkMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gei8tqbQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f2077d1c8so627307b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758466504; x=1759071304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJFv3ChPUzhn9GkGU13hJh9Fbrlocc4W2rtrc3dBgJk=;
        b=gei8tqbQbo0oygxGqFL1q/A4k+OXeHlhnlYGVCqJ/Ic17l6eYjbfyL9ScJzJ6+E7OI
         i/eKI5epiY91LaiyKD6H4L7HDZK/9sjDsrp9nWWNIUFnWjnfJGHyjGepr2YW0GWJ8RTV
         FWqXmMmJXKs7Dt86nnQ+g8QJykNJEg4ZuA5tT2Bl85MTGe+1mX94d8/wAcn/E2Pjr6AA
         lOwAbLQp05rMb6Dk5uWBWM7ss0uwEEKJFGwTpdz9i6FOv0jF4/KabFk2LkjjLFX+3Gzf
         SWjFsICifcgZXagVIKDS0nVeDs9KyyZdO4ktah2bih28Rp89nvAZLSmQXUxP26/4XCkL
         QoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758466504; x=1759071304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJFv3ChPUzhn9GkGU13hJh9Fbrlocc4W2rtrc3dBgJk=;
        b=J1eTumQX/aR4igE+Zr1nHAA7Z4hQ6jrwnxfp2La0/0Qhu2VymMiLa/p60Wv0Db/wnp
         D1v3PKR28lDETEBmt6qEKUL4TNe7JPNpaydYf8Ar2utzaGDA+LnIpOy45nPdDGaXfvPY
         AVBLn4/XjRreRVqI9z7vxEH8NOV6DfsAbDBApfM2OJtsjk8WrmlDl/pyfpw+0Y7yisa+
         vE7levTe1pDDH6/iCEWLH+JlpI9HEeTzlJfTgc7uEVG9g/AM5HqTQYCftuDVvsTJcaSt
         RaTuaivOny4SHn1otmMTA4+cfE6YbptjeSj6iMEVsv/nPutWmGqeJdflNDluC7bL1sQP
         B1iw==
X-Forwarded-Encrypted: i=1; AJvYcCV4I/xHlRamBXSXNimx9UQSgeHkcrey6ioh5vqviaPv5wKqFqczS9hKmUQ44vYjBsZlwlu5iPYGXk6SuMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xeQhHjVqOzEeh14jsdITJZZFKBFJOtzZjzmzXFtq07xCV1DZ
	kRiRmDWAHESbwFa9SShwzdePfjW/YVhWjOFhTCsayewPrAlqvJZK5ikQ
X-Gm-Gg: ASbGncuVc8/I6G7Mc+UkKCOgrYBGci3magxiGLEEtgSSAq1iRfwrvJfDEVIirkKRSi6
	1Lmsrcl1lJWkOrPHz1/u5/YAimYi9rVjpX0ZCDk2uUNaIq4QG0bX+bhP9ye7V9TwdJ5bbDUct2B
	HX/woDAOeM9NFvfo2jbPreaQuevW+jSuu9Gsvrqw29cif0jEGxskIWJt9tzFkYt5CWJUmqio7uP
	KfPudAUzjK52cG8KTIOzfkslUI0PcHyExq0EkwnuX0SUEOcB4DPbU5L7Tz5s6iM+jK3wXglMFUI
	ZG6BqqyTfcBYBKoWiuPhSQPt1qEDB/tTapCyHJ5GPLrRKi02cmwMDaX0R6PyA1kSMd6/NmqYFzO
	p6Vuco9+eWqAMABz+YeHzcWcujQ/EAeRvQjfVd4IeLRk=
X-Google-Smtp-Source: AGHT+IGlGOrrC1qELYieezel6ZZpPzpPTwUZ/Hjhxs33BYHvkYGq6FWqHUkdWrQ5M/94vUUoWCRMpA==
X-Received: by 2002:a05:6a20:3945:b0:262:af30:e3c with SMTP id adf61e73a8af0-2921cafa18amr14329391637.28.1758466504480;
        Sun, 21 Sep 2025 07:55:04 -0700 (PDT)
Received: from asahi.bialairport.com ([103.241.193.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7aad7sm10415321b3a.12.2025.09.21.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 07:55:03 -0700 (PDT)
From: Shreyas Muppana <shreyasmuppana@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shreyas Muppana <shreyasmuppana@gmail.com>
Subject: [PATCH] drm/amdgpu: remove leading space before square bracket
Date: Sun, 21 Sep 2025 20:24:01 +0530
Message-ID: <20250921145401.22654-1-shreyasmuppana@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove a space before an open square bracket,
fixes a linter error

Signed-off-by: Shreyas Muppana <shreyasmuppana@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cbc40cad5..8f3a31952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -26,7 +26,7 @@
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 
-#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] = {hwid, mcatype}
+#define ACA_BANK_HWID(type, hwid, mcatype)[ACA_HWIP_TYPE_##type] = {hwid, mcatype}
 
 typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type, void *data);
 
-- 
2.51.0


