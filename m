Return-Path: <linux-kernel+bounces-891266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53735C42494
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F48B3B1074
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FF2C3745;
	Sat,  8 Nov 2025 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZa6YgVO"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B02C21E1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568662; cv=none; b=rJROxssDjMh7FdXJCB8wds6Y7K45wFMvvZG6EInC4zIJgrBlbu9lqu+5ScI8koUKG3SIMpSylrTD6RWiufqC8XiWV6BP+VISK7vpU9v+RwAjBGg8tVXVJ9oV1Zbd3cIITGrSGSuO9rcpBYU5XOLfO6KBsWfwN8tJCI1H4OClsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568662; c=relaxed/simple;
	bh=d9SrSYWM65FvANtjCRZH20jaMwWMEvqOX3ASx9KKEhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snLDDxuo10JAFp2hKUq6Nih2dA2P3E9sMoF0x6FixCzFKGhckVksy2GA98e9tr5gvoHY7zlsxM5R+XkpkJCxVcF8svU/QL+VFduwXznSfMdWeFTt6q3h4LzsqMV7VDsjWLECjKLEkFbI8GFKnt7d3ZLzA4/lDYJ7POJgS9fF0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZa6YgVO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87a092251eeso15816596d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762568660; x=1763173460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NY2LbgvIY/fMzsfOBXS1nVDAgZLdeObOtoX1Ris2Kn0=;
        b=AZa6YgVO852B6/IOxIe4qiCntkNK3F5a4iFfjCJaVA8/topGuWMcpj/Y0H/QHYQaCu
         WOlzcaXRdjEzo2in++ZsttFVHIpyWyb7zbhXj94px15mvP1mJRX469a7v1kWPPFg8a8R
         Us/LBupsN66c/ZyG+wFLseONt3nXNh2FLDXTJvqDB7KalVzB3rS68z/VSO0bSqVj+oV5
         a8DUWFlDqtZ8K6PPKCep7W+rNMzKONH/98Qy8dPNQuS3j4mTeHB7U2JfxCGWKdg2zjCn
         mVgSFGhqKnrOMbYnICTyFHC1rohsm2xC07d8GBmGawJ9BThwsTdln89lvvGbeCQ0tvrh
         YOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762568660; x=1763173460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY2LbgvIY/fMzsfOBXS1nVDAgZLdeObOtoX1Ris2Kn0=;
        b=qa/qyNzwMhOHmRRJGc9KEiyjbxCO4p7/n8Klm+0u4KvhljStG5xfvxBG80qeJu1+2x
         InhpjjbGb4LOM9HbrTLsc8mAoBk1WNzRyUKV0UMhXPPLO4o8EJ5bCRuUczPKh3ugVIna
         8/bJ/+mSaNQU2WmfgP7XKmhAEzp+oHu4aShpNGhLLM1RbN9pjaU6LHRCx98W7d7As3HH
         OAC3x1Zjy658lvfugd5MbXUdD7+hK5l1lS86cd3kVgj6xO+3QEVPQwHeXeTZuD76Kcdk
         R+NH6jTpr+qcE6LzTLLMnVtlepeU8PyIc66aXE8u+TbikJV40VNPQTEzT4QV6uoKKPbP
         Exww==
X-Forwarded-Encrypted: i=1; AJvYcCUU7oIB4BaRoxfecAteT6hnfBgLFfjewXUtLerKiDR1hokmweOIMjq5hSyxkjv06pmmzRpViaOn1YfSpVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPIAgDJcvbp0ZbW2SfR+VUPBbVmBTZqfWH8ZpwT/OtZImSs21
	geSRiZ81nNLW01f+SiUEp0qwV/PKXyL4Dgjg86inuWzqGKnuU1aWqKMAlZpxcw==
X-Gm-Gg: ASbGncv+icSHnDPjVVT2g1IOD82dx064zbLdR4qTl9cQAdGjBuT3qAlnsvAIAUa2NGx
	iVJFMidzZwl0RZ9hyA9ajb/f92llKB3/m6/nxtuSx8xs95+BMKvAbRWy91Y+9YEojev3kUa9UlE
	jF4yvJ35Z4Z6di/O3i6TOlbp4vNacDGKYcwfzU5qQOXNvRhnZlyntP9DY1+aoHGrcu56ir9rAyy
	g5mZ4TbUQB2w4iEzM6DUNfso2MAQvLSUM4Eo6RBv9SC4O3ogpctXV7IlSoKf8uU0DI+JjGvilcN
	wAjMzWx6F8SnIDGYkCdOncwTi2W7ZePyF3CXjh9jD1dJjNgjZmdi0a+67YfnnXXDUBa3AJLf9Ng
	xhOXsI+TfvN5f17pwBq0weocb0fUw3Qs1kcWGeVUSCN7zNic=
X-Google-Smtp-Source: AGHT+IFg9wz6lhJl8Q0/MXiDVkvZKRCFkQJ5hkPlMaUqnbTVBXvIucOF1fAknSssoiuUZ/XVQ1oB7g==
X-Received: by 2002:a05:6214:2aad:b0:880:580f:27c8 with SMTP id 6a1803df08f44-8822f4d3cbemr47329436d6.6.1762568659947;
        Fri, 07 Nov 2025 18:24:19 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238928af8sm7493646d6.6.2025.11.07.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 18:24:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amd/display:: fix designated initializer error
Date: Fri,  7 Nov 2025 18:24:01 -0800
Message-ID: <20251108022401.270909-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

{} instead of {0} avoids the error with W=1

error: positional initialization of field in ‘struct’ declared
with ‘designated_init’ attribute [-Werror=designated-init]

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f8996ee2856b..574618d5d4a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1568,7 +1568,7 @@ void dce110_stream_encoder_construct(
 	enc110->se_mask = se_mask;
 }
 
-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
 
 void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
-- 
2.51.2


