Return-Path: <linux-kernel+bounces-746959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608AAB12D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F09540294
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519E157A72;
	Sun, 27 Jul 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GubimWiC"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C788376F1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583498; cv=none; b=MOUbOExUFJ/uk46GUoGJ1/U1Mec7SRKWygNnofG8HmCbYifia8B8j1cqoxBE5ij8Aw2VZqHJqmtbrXlrAON6E/8D0EHSDJs28wXpMjKuFQszA0dBHS/YwfAB8Yki9PWSRupmUWrNn+9ruQ7yz7Jtfr11AecYe8rreJveVFWcFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583498; c=relaxed/simple;
	bh=+tuen5gvuGv9dfFpXjWpFeJsp9Wuzsi/4JS4iLW00a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE0D/MuHBOrwc/TbuapQQCmuPeh8x703qP1yAc/m0dpzS30XMiZrFZGcZHKGwEaHDuFcrVhpc1+es3klgmZABGERLE+/WE/Si2fPjUVJVgxQ0ee2d+Olh2rPdwoFMe9YkeYMnwnDXj0Iyctg9wM5RCVEgmQvPcnxY5K7mHpvs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GubimWiC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso278794a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583496; x=1754188296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RTepvH69krE4tydXzcnsM5xz/+ohuOPpHI35ALn5iU=;
        b=GubimWiCZ50/fRnZ1XXq/xor9sGAi1BnF6gwZvOAWyntxESt8UeFHarCRIX8UxkR8/
         xMNH9o3l29CndbRR/a9UwRGgECeSQ7yqWnyFWmg8wZNsIJz5S9/wik3fNjuW+poQ95gO
         43FVwT5siImaAgi1RiFtdD5w8zAiq4I0n/mABwbZX3eItotBKB5LHNyF6oINbeaYI4gb
         Xeo5BLHRy+4J392t75jfUSi6H4NgKOhJxfetXDq+Grz0n7sO+vRBCg+w1LCEuL5WToo1
         DkPWoscz/G43bFob71GM0ja8s4r1oXTJFVRWhhtJFDM+21VLhq/8Fp69yVENoW4/NyLM
         ow4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583496; x=1754188296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RTepvH69krE4tydXzcnsM5xz/+ohuOPpHI35ALn5iU=;
        b=NywzFY0zxgT0sbg3mrj4VtcB0LW+wBpYDVcmpad+FFmS0EELOkAYlmuEWKA875I1ue
         315VM2EDyhYxTyYaGqcDhgmuQIAaZV1OvcHQDwj1e7j2wH9xMRYWLvTj8kAtZCvfz7B8
         +C9I2E7b3lYAEUV0eT4qWV6woT3cuCZ1y0bfUAgNMwAT+4MmJ/v+FB0PL+JggTFN/9of
         qPfxyhKhbf/ca+lgaOBXn/oixBVhQgRTLq8dQ+L/mB3dWWYWKfUySma4Vx8VM7yDSwG1
         OjwNd3pMtUTgmB8GdEn3EzMoK+81631V2b+opxMLs1NV2BLzKLNknwJlLZ30vkSTQdgK
         OxEQ==
X-Gm-Message-State: AOJu0YxyGFyo3Rlrqgqu0g8pgdwJuPuQqBo364umRYOQiedyK/L06lj4
	ny5x8DS5hlNwEgZk3E4VXjnW2RJrD3/WKa7++XO1yWEmTcVKlv7Y8oV2aPRRudKp
X-Gm-Gg: ASbGncvSDaj5bRgFNEJtj6mkpFzU2SGhJacTCAldwbL7Uzazc2BAR+AtABD4eMvA3KT
	dTAz8S2fOTly5PNbMZGcKvfejqdCrPp2HDLlsB5OeHzsYmIaOXl4ItlmxXkn7Q90+sH5ueU85fB
	HZ+R8MlGJut3BHerbxcbmjqPd9iKkQ6MOiP4h0Vq4O4rzmu1fuK/Lw+6xkR7glGJugvAoshRt/M
	Bt/S6GUC73UKan4JvhMY1gmBWe9v5VBupmlubkwJb82N2nZncbkLCK11rYx5zbEo2My+Dkxaz/+
	pzBZ3iGm3MPvx4MpA3P0SlZoKIX6NaYdjH0wmO9VEdgwq2MQUGyjT/8NvscuVP0y+rIxBcj6MLq
	3ViYw1oehjKIpgHbKIm9Nf7xBtOZ/ReFd8148W4az4BtNdBLTPBw3laco
X-Google-Smtp-Source: AGHT+IGPAevCakfbADB8KV5enG84k39VspukFF8CZmOniE6SPn/Ty4xQ+rnXXfKHWs8Uv6DeyWwOZA==
X-Received: by 2002:a17:90a:8c15:b0:313:33ca:3b8b with SMTP id 98e67ed59e1d1-31e7785de0amr8257403a91.9.1753583496427;
        Sat, 26 Jul 2025 19:31:36 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bdebsm25841125ad.10.2025.07.26.19.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:36 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/media/tuners: Fix typo 'isnt' -> 'isn't'
Date: Sat, 26 Jul 2025 22:31:41 -0400
Message-ID: <20250727023141.82569-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/media/tuners/qm1d1b0004.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/qm1d1b0004.c b/drivers/media/tuners/qm1d1b0004.c
index c53aeb558..49acdcf9b 100644
--- a/drivers/media/tuners/qm1d1b0004.c
+++ b/drivers/media/tuners/qm1d1b0004.c
@@ -123,7 +123,7 @@ static int qm1d1b0004_set_params(struct dvb_frontend *fe)
 	/* step.1: set frequency with BG:2, TM:0(4MHZ), LPF:4MHz */
 	buf[0] = 0x40 | word >> 8;
 	buf[1] = word;
-	/* inconsisnten with the above I/F doc. maybe the doc is wrong */
+	/* inconsisn'ten with the above I/F doc. maybe the doc is wrong */
 	buf[2] = 0xe0 | state->cfg.half_step;
 	buf[3] = cb;
 	ret = i2c_master_send(state->i2c, buf, 4);
-- 
2.50.1


