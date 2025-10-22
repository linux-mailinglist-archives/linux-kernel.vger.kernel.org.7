Return-Path: <linux-kernel+bounces-864105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7958BF9EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F02482E75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB262D2481;
	Wed, 22 Oct 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayY85GMb"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFB199E9D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106392; cv=none; b=PAbp/98Gjih84x1A5yeMS1fqXOzCxF4NV4crMYFcdkvMZGfP5qs8WvgtMhEot/Vn8KsxLeQSzBc6Z/+mEn5A9iGYQRlUK/49e9sqzp/sHHM5os1yoDTIGGB0C5sU1OSDdLjO3BkoNBr0xsrXSp/pKWUDdGTqcX2B8NcxwpKJ3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106392; c=relaxed/simple;
	bh=wMdXKUhX7T4LxRey1VbyhcyL/HYUi2WjbP9WuaJWrIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYEXzg73PLrC8n5gBUqLVDRny9sdYoCWKxJywBBYyvbrFzNjfNUmr/e1T4LBNKBA8DtjFQEgwHQTU44cMXeEJwgHJTqQPJnC2hDY/WwGSI3RtXNeU72PuE6fqWxWruhVe0KNVDt8QxGB9a1FhUsznmVUO3MqQLauv7iASJRWRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayY85GMb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57a960fe78fso8191603e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106386; x=1761711186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTarvr5NQrK1UQUHCo4kav4SXNLG6y74vPoWa3KRT+Q=;
        b=ayY85GMbLkl/vTjQqmo1YAsRADU5+fht7FZ5Em3bkWJQao8obgh2ttp+V2wAzb8f4p
         KMWubZVPCIm6DCLzkG75NMh+O/sRkrAaHnEm1Rj65gozcsEkBzWCINGeN/cdkRL3MJPM
         6oyRl9fiiT24qWkCakPO9PGhnsV7PnTMZYPqUfkmuTEByFtpNE5nH0V7Jlis1eNdUG9l
         90z4MMiM6H3DgNyi/DNbI+OVSs2R4msKvK0AlcJOpLW2kaTGzkmVieUGOwtrKc8ErZ5m
         Vf+hmvqhWY8E8WM2Axm4uHDyUVTXFD5se/aeaYAZKallC8hzVkJ6gk8imPCbxsywEEDD
         MmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106386; x=1761711186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTarvr5NQrK1UQUHCo4kav4SXNLG6y74vPoWa3KRT+Q=;
        b=UE+MFyinjdfxZu1he9k0KjPJUbVUsLb9TxjBDtJ8Jt4xSi1ri8ASPUmJ4UigsWHBk3
         cZ3hlxwiJgkZo/oNJeSFxSxliH7dZsTaD8GeUsH/yqn63itayCbeKFPR5keb2V+LyFbw
         HIofk61AfeSbfFWya3CPyhLggZTlKHUFKGu9uw/nInc4X5c0NNi9i23nTI88pQeCdLl8
         /uiJy7xM4vpmC0jp9rypx+8FgwvY1xsVwMoOf7o/da4i0+qgOI9Jbyn0Ic7dJpMjiSRQ
         BVTQn1bHA7o+kPGr94C6afG15NU65A/RzbdhCZzCu9JjevGhKIeniq1Rf9xf0cRQs+vM
         VtIw==
X-Forwarded-Encrypted: i=1; AJvYcCXCPl6cu1uOAFaXCR+CJE462wpjBSOcKW+d/ESpZ6KJlI18hgAk5NUALQdX2/7eefkYx07/31p9ZSGtXi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKLieQDdbWU+LeboG0GZgTU8zeB286uXiF89QezOBsrk3uuSi
	8e1AdMLXghja9R/7Bp6htY2Rqw6byfDXKBSTFX4FeRfYbSPZYPLrXK18
X-Gm-Gg: ASbGnctMe20UlTeBKXi7hYZjd1/5pNnfUJYYOOm91F0B0dE99Ran+DQRQIXkBFb7em6
	aN6GBTwfyv3TDFa56TaLpMUV6f7i78J9SVRos53OiQau9P1wY/Nwd9L3cS6szL2d2Q0aRcikN7z
	qEhetFTgyoUAM+BZcLuW034ShjbGwCaF1uqbAmL+KexFhtZnh+tWHfyi9JV4nBhBkh3wX4+9b4J
	cIQnnpUGOrZrbWReSFpD2PCdjK6hoBM8ZPkpxpMWTdwCjG26ybE+k7ksVCwvDSrq6kAxMwM2aBi
	7lyk9soX58fPGgfqSGRfEQ8GBBG0kx0e6BSxriVhrRobwuV5g84YSIo06wJxEqlnb/K1kyjUlld
	n72eBqvcS8A3RznIXIf4Vj+yZ4UmJY0f6EnI31MzMWdoc84ni3F7VUgJvk6RL2fBMnecdpUIw15
	3KqkOQI7HeW5OTga5Lk/yBnMONlgjXwDSJsdXTAQX5moJ0lWEN1puQuJBSDv9WxbgFg7zC+Qg/5
	MuYji1d
X-Google-Smtp-Source: AGHT+IHY7I4DBmj7a1FpDVM7msh9gcYm7KPVmZxtgTaCyBA4vmSmAHD2ToTDDsFBgGtcjxwcP6lO+w==
X-Received: by 2002:a05:6512:220f:b0:567:ef90:f519 with SMTP id 2adb3069b0e04-591d850d08fmr6278217e87.12.1761106385519;
        Tue, 21 Oct 2025 21:13:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf6e2sm4252192e87.32.2025.10.21.21.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:13:05 -0700 (PDT)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Ben Skeggs <bskeggs@redhat.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/nouveau: handle division by zero and overflow in nouveau_bo_fixup_align()
Date: Wed, 22 Oct 2025 07:12:59 +0300
Message-ID: <20251022041302.13-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression 64 * nvbo->mode can evaluate to 0 when 
nvbo->mode = U32_MAX/64, which results in division by zero 
in the do_div() function. A value greater than U32_MAX/64 
causes a u32 overflow, and the division result may be 
incorrect. The nvbo->mode value depends on the data 
passed from the user via ioctl. Generally, the kernel 
should distrust userspace data (an attacker could operate 
from there, and there's no guarantee that mesa and similar 
software are bug-free) and validate it to avoid crashing.

Found by Linux Verification Center (linuxtesting.org) with svace.

Fixes: a0af9add499c ("drm/nouveau: Make the MM aware of pre-G80 tiling.")

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7daa12eec01b..afe4e73b6190 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -168,7 +168,7 @@ nouveau_bo_fixup_align(struct nouveau_bo *nvbo, int *align, u64 *size)
 	struct nvif_device *device = &drm->client.device;
 
 	if (device->info.family < NV_DEVICE_INFO_V0_TESLA) {
-		if (nvbo->mode) {
+		if (nvbo->mode && nvbo->mode < U32_MAX / 64) {
 			if (device->info.chipset >= 0x40) {
 				*align = 65536;
 				*size = roundup_64(*size, 64 * nvbo->mode);
-- 
2.43.0


