Return-Path: <linux-kernel+bounces-837412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B98BAC439
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FFE3AC870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8E29A326;
	Tue, 30 Sep 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwh04kjL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5320468D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224218; cv=none; b=LsAFpvd3OMV1dJAj+eulobLJePPzzg5ZbuCQer542n0je+4WaIm/HlfAucRWTmKBvY9fbCjMeaMZP5dMpCX0nxlSKTSQF0ge9lwxx2Dis6SyYXwId5/sBXfs489zTEzoZzbjOjoUf/pKnYaZ6fYjC/9/9s6YtvIbwryK9YHYg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224218; c=relaxed/simple;
	bh=Kbs8JGrFduOaI/hjUJ5wKXWK6sCYJBvlyr+v6bAjmus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtwxWhI908ZOF9d5zFVGvhlwQuUdeiO5cXFb0+GucB20MRB7ewSiDYTCz/C8pev4Bh+wo0W03jCm/vOjhKCKLXKZp+SV6KGdZb325k2F0dpIxcQ2hvfidbeTflC2zOnpTkkFhdvwJiVK06IyrFIOr8zOu90onz2QkabwWWOdU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwh04kjL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e44310dbeso4044495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759224215; x=1759829015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TekYocA3NFc6wJkBn4hXZq1fAbBiTi5Aoq7kBmK0gRY=;
        b=Rwh04kjL50Mr9rZgrrxO9muhseM7YMzYtM6LpQAOdkX1tu8jM/hGtk6kxAvBGOmUux
         /W6a9EdODU5BHVBZj2mHZIP/emVBkTB6n+a1jYQWbGFynPQZRgJ/YJbJpPYcztIm3gfn
         n0usipM0Gz2uHaNcBmpRM9LWbkpCzm9EURGI3qrKSzgAtWGyx429qkMl0/YFF0tM/wss
         IIsuOvQVf0DquM/CmCaGrb87F3k1SfGFubEU0azgtjIQIHR96lj2H5qUbLunlQa7KKtl
         HLCRiVG8vovTV+opvwBwIOyWUgoJ4crcq8ib8huUoXq6yTvMgi1Y9vc3RvzYBfmMb11x
         0ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224215; x=1759829015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TekYocA3NFc6wJkBn4hXZq1fAbBiTi5Aoq7kBmK0gRY=;
        b=HebwwDAoHKm7cSg9ThRCkKSjX0wnBJD2S/iqkEj7IjQZPfaC4Eh75wu0C73f4H1t11
         tckPAkAhL7NYcxRf6cdMQBCEhbMTdPdipAv12A10PUujbqO4HifHAE+o2EDh6W6q/xqg
         JYbk0dIT4kHNPqWL5FeexZV5Urx+sbkUlgJlFGqDasyL3VNC0M1zVLnnZQGpeMPIgnk0
         i+AQE4S9Q/ulDUFFfRyUQuCN2hR/YbnPvNWb89ivwueSZHkyuUqW4htoAGPsg27ooDfU
         3kkDYUsCVEGIrYjMaZbUWxxc0ES3iRQM8IOzGiQW8PDU8It76IXT8nAGbauKZcr4V72U
         +D7g==
X-Gm-Message-State: AOJu0Yxgw5VCDTQ5ixf7pVv8rgPdZYP2GUfF5RuY9GTd0hBc3spTzQ0C
	+1rpHmAPt+q7jZHIyNVAbzwpTni/jh3wiGt1HFrGT/iGIiyddezI19pD
X-Gm-Gg: ASbGncsuTc9li3IPXMzvKiqZ2Q2/UYLH51VNtwex34xj4nlecX60zFI9WMZbAUFdVgD
	mQQ0D6ggV8maHO6h4Oir1eiGLKnciTBpHXhIQN950ja3fiIBG15C9s3R89C5YkvK/DplzLrXHNS
	SwZ5U9kkuKAPhxIQJBmKFxO2kvvIxY9S/UxMmyUvhNwViXWQWkNIDZycdStd4KvqCWrS58drGUX
	D0D9AqYHzjYHuMqNuO9Fv2kpb8Zs/18SJVMZT4kqSD/82C39dc1d4setuUSCFiFYuOwNhc+CogK
	iOByJ35nl1Axx+pN18r0PKGHbpZkaemyPds9dmlUnZGz2MDYTETHJusa9RLJHN89qtS7nMsd3mE
	tJC4RmsIdEaVvDoz1shASZWUtopDmCI+90Qv0/qlPBxuYA4x5Xt6nBtZLtmWDsFL9
X-Google-Smtp-Source: AGHT+IFPizRa0ASKtki+ckYZRe6BE0jI/MUqHU6/hP1U8hUcZW/DR6Ot/O1lMO4myHbm/wTeveLEEw==
X-Received: by 2002:a05:600c:4f91:b0:46e:43f0:6181 with SMTP id 5b1f17b1804b1-46e43f065afmr70284335e9.7.1759224214578;
        Tue, 30 Sep 2025 02:23:34 -0700 (PDT)
Received: from bhk.router ([102.171.36.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-410f2007372sm21062808f8f.16.2025.09.30.02.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:23:34 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in kzalloc()
Date: Tue, 30 Sep 2025 10:23:12 +0100
Message-ID: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap allocation size calculation in size_add() and size_mul() to avoid
any potential overflow.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 lib/cpu_rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f03d9be3f06b..18b2146a73d2 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -36,7 +36,7 @@ struct cpu_rmap *alloc_cpu_rmap(unsigned int size, gfp_t flags)
 	obj_offset = ALIGN(offsetof(struct cpu_rmap, near[nr_cpu_ids]),
 			   sizeof(void *));
 
-	rmap = kzalloc(obj_offset + size * sizeof(rmap->obj[0]), flags);
+	rmap = kzalloc(size_add(obj_offset, size_mul(size, sizeof(rmap->obj[0]))), flags);
 	if (!rmap)
 		return NULL;
 
-- 
2.51.0


