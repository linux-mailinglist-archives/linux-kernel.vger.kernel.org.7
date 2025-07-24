Return-Path: <linux-kernel+bounces-744870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE938B111EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874A0B0266C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4B21C9F5;
	Thu, 24 Jul 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L94wEsaZ"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE242E371D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387170; cv=none; b=ZNvXylqrz7rnbB3nM1rT9oDkoTAi1mMoKunK+L/KyHoEaH1YaxLFU4JIBkgYXG65X2ExmxdCrOhpVfgnXRjaoG5tunGnrsas1llCL6uEUAoCX4iAyQHfcOHXxvONfxuGObp/vKj1aya/JV0816oJOw4mh7oKlGVgj3NBKkAteHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387170; c=relaxed/simple;
	bh=7uw+N2n80so9IO/BOeLli7VGFLgigSPSuvlKtmDdScA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFfquTD5U2py1hv6ue9x29xGcGsK6mNZ15WOsQLC5uCrGzg8BINPjIKHSmOTXJHcqMY7APHAu27GDLg7RW0NtyS2nwoOCFsaXxEf+eg8gkTLXOWI9LhZlNvVuMC4ne3PrS+w6Ssw/MHhP3OXuz8bWq8wacFgypBb6dCe+DdSdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L94wEsaZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e62a1cbf83so136935985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753387168; x=1753991968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2glPXiLDXj+7i+zys0K4XQZSPXsH6Jhnylbt4ZU6Pz8=;
        b=L94wEsaZKNpJiIV4nuZyF5/eZ4b5wNewttVNS8pmAkGB+fAl5ymOBlcnFvkldPpxxZ
         OlyhnVv12xV03o59qIZk0kmMphJsu7AkVZx+gCglkVvYWJv6rFC0BnmKoDW7BdNuJzJs
         CPKnx7DDkgBOHjkBPq/2OiH3n5Wz+2/+rRAMtuWyGtVS4wA5d9bY04VbT4JN1nE+ccSf
         vdjGhpV5PuBYeIPNv+0A7i5GXHr1NoprnOxLGKv69Hcwix6282T77gfdE4jX4oX8Y0+g
         TXH5YYITO7KXqXb3wLp4Fm0zVFqCBV/Ee+KB7GtLrQ4yNLr8D3h67UBD5SpnhJ4INDJV
         SJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753387168; x=1753991968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2glPXiLDXj+7i+zys0K4XQZSPXsH6Jhnylbt4ZU6Pz8=;
        b=agvE+5fjzEBLPakHnnCmkcdqCTHtRBm4QaJllQool7oP3hT0x6w3538WSLVs9dlQkL
         22+uIfjEaKVV8BDIJ4I4JJKDkLowObyJOzYfaoVLOineqfnIYJyn74BMf+IoVBP7IBoz
         DDaxP0c3iYg1nOpiwcoCfDl8aAVHMB/ILn3nlgvf7wTmkQMgGaQAP9dOvB1OAgV9PdDt
         S623Q/P3r8BPbb3kAiJSSd9Vei9ZsWa1FbbNuSlXw9+QOXCoC5sdfpBOjZ4wKpFWnUNY
         Kw1L3b2UZoOy2pOksU6yI5jaZcXkaIO87JhC25uNcBoOh/Qd5sltbUY5pC4wTw5Q3F2k
         yVfA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/TzqwHmwvXI2E9ttioNLq5uaDYSEKJyx40tNmjYyFobh1euA8Y8+5NWq/Q7dNkxf2/h04zJ60JKMKCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALDSzbtmkJgS/IM+K+zuvi8LERba9qdPopNL36nIbmhpw4Xfy
	bZNs+0tTJlzaGNRBNYIFYG5SAmgzd3Blc3BSeBr93jO4KdkmVrsh2of0EaqnRK18
X-Gm-Gg: ASbGncvf2RmGKlop8psYYQG8e7vRZ42TDvNacENn0Xc/bKwzt1r4Ux73wtE3jWnoUux
	4bdiPCze9F3MSE8kLoFDfXnE7CweqNqsErL5lBQRIpU+PjIBPjV/g9BOlI/SlK+r15TpMtcKARM
	zX97ohVLXsYpGMevB6C7GHs+eKDcM7nyfW1N12v+QFfyHlcIj0oyAKnVYjXBTd8eTmEdNQDGFV3
	5E0ig9r2aLDmT2L2dmY2afp+msy4UnXp4sn33MMudmnX2lo0zTPowY53T/ysGHX8HUtH2GJ7dh+
	nfHZaGGVli30N4DE0WEUPLWvoobJaiFGq/CivX9BO4rW0k1hIOieNZ1X3KKDFOE9wkt6oEe7Hw/
	DxxrMCq6sMcYnwxgNEGwYDw==
X-Google-Smtp-Source: AGHT+IE8tiKXPF+rPmVC2uaEgbgWJXzxROd8gqRk6866T7szqRWjDH57DUs1ux8XzdCpbhD/gUk/rg==
X-Received: by 2002:a05:620a:306:b0:7d4:4e42:7b43 with SMTP id af79cd13be357-7e62a17cd67mr977879985a.30.1753387167675;
        Thu, 24 Jul 2025 12:59:27 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e1a687sm165994985a.50.2025.07.24.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:59:27 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: lyude@redhat.com,
	dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()
Date: Thu, 24 Jul 2025 15:59:13 -0400
Message-ID: <20250724195913.60742-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() returns the number of characters that *would* have been
written, which can overestimate how much you actually wrote to the
buffer in case of truncation. That leads to 'data += this' advancing
the pointer past the end of the buffer and size going negative.

Switching to scnprintf() prevents potential buffer overflows and ensures
consistent behavior when building the output string.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/core/enum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/enum.c b/drivers/gpu/drm/nouveau/nvkm/core/enum.c
index b9581feb24cc..a23b40b27b81 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/enum.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/enum.c
@@ -44,7 +44,7 @@ nvkm_snprintbf(char *data, int size, const struct nvkm_bitfield *bf, u32 value)
 	bool space = false;
 	while (size >= 1 && bf->name) {
 		if (value & bf->mask) {
-			int this = snprintf(data, size, "%s%s",
+			int this = scnprintf(data, size, "%s%s",
 					    space ? " " : "", bf->name);
 			size -= this;
 			data += this;
-- 
2.50.1


