Return-Path: <linux-kernel+bounces-827558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2EB92136
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209E21903EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5FE2D29AA;
	Mon, 22 Sep 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL+zgoWg"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED566302164
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556428; cv=none; b=OldinEvgMyktISwxSrMA8YFWNoxPSBeVwEsoxYgKVznKEEUQ1qdaXrakshTa0OmD8adk6YTSeW4zcyCOiCcB7bSc77G5+tKY1A1ozGWmmStwhkB7dELvhETyDJOCZ22JMDxVcoZj1UURUEXdFP8ESIBvxOoyz0jOYvtSXKlgw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556428; c=relaxed/simple;
	bh=xmpykvsefbZg4Z3d0+EhES58b/1383121uJSOrYR/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy4lv32tlhVDZLgJl+7GZNwv/Hs18fseu8poZnmUwl63nNk9WY5LMhke2FIizfwj21y34PpcRfadfeZ2k1imW3+zDArdJagTYMV5ltbQ1vyc3gn1QXxAPsZB0h+gSOquJkC9aSKg3MnTp9W4DO+IsrOSAPxbwCJnL2bR5pw1rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL+zgoWg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3744435b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758556426; x=1759161226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q61xyED0iZHvT227a823myA5nC6Bd8yB77AGxFVjBQs=;
        b=iL+zgoWgN6zTX8jArXdOFpzYAiiPU2CQfKhPcEMUtVmH+8xWKGs+ftHIwq+TdcKHmm
         SCDeaBxoGfR6RIcEH5uHXTCS/Z6awE65ZDx/3LFgkKma0FNLQxT2SttGujckCvEwO/3c
         BsxGaqNdl0d6MTzEd10JHCfNbGgoJCZOh5a6ySYjfmMmH8KxNJYyZK1BepWjIEkeypZx
         kHczk+rfU5kmvgdOPu6IbuSdC+hunG+nuQ5RIn5TCzKZH1Qo9PHzM9zCyzngtT+MuVvs
         Fq1inofVb42mIPmqPKW2FEEcRKSl56ee8xUYoBfjNx0YJzJzZsSma9f2HkhpXdUx9/RP
         KciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556426; x=1759161226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q61xyED0iZHvT227a823myA5nC6Bd8yB77AGxFVjBQs=;
        b=kY+FITBlIHRHjr6APL5rSLqmalEgPL+Ha6wx8zlqKKzSCaeu12SILpa3FYu3tBU7yf
         ivoVwMl5PSAAkmrJeFSkxok8DfuQQ3Vgr4WX9yPkc3dqKNdcyKcca8mQDdawqsqAvKBX
         8XX0LKHtoB/J0YLTmM5UHiujuntsTUrA7shnWqm4F4Pwgj5UAuRDOhUHtA9wm4gjBxl+
         IVXIs+lmXc8feAg2A8yRX44WVnt4I0HPpCKHuhOwzxu7D6gNM4lfhHuku4FQSJc3MjLC
         P6OGXPHDHU0WKWPXJkLwjhWSOlAMWNqnC5xoIb9AjCohZugTw6Bmy2x1RSRsrcVQF+jA
         6XXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDHIxsIkz8RmMwIKLL150zeWb66pi5oGmKxl8qlrGaxZLqoYwIAmz6JwoYYSUph1pqwsUZuPQKRgO06g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEWJJckVstNAL3tepvFw7Vejx5QI6MBrIGXCxWUMCcaMRXfDo
	x96lfaKFOzTpnpkWDfR4Nugt2ZMEv/skLigohzH8HHk9nGX10uU/xVPW
X-Gm-Gg: ASbGncst7BxJtk21aeMX0zCIu0QGaU4751WQPwBcN7h2YomNpeKNrimFK96TZO9Vew3
	5cMSPegddF8D9n3zfYIKledHmRHWMGai8bFGClal+jBz6aaHUr1AJyRL5f3AOMv6/4uXxp0ZUKz
	ovNDap5z0w3EpS6Wa72kqCDyJ+RCpurvoTMIZsWnNUnqDsHpmyPRqS6fCCzdlFSTkjR7d5qEYBo
	29Ugndo3u59TiB7LmaILtM0nVZmbHc2QttGJdL541gv2sCaJXmDhZUwoUe2qBKY5u8wfBdWU7lS
	z/rC6IzaN9H4EfDo6vpltSyyTGh1XlDVsh6u3KTPRL1AWJROsN06vii4gMOedPDAPls66lynTwc
	4m7nzJk488deFmuruL1kZ0Tqg
X-Google-Smtp-Source: AGHT+IGEGQomxsa7WNV0T03rhAK/xcvrrheXR+pMEm9N4EM2OSbc4zcfLSj+YjG8nGLLs8dfNA9reg==
X-Received: by 2002:a17:902:cec4:b0:275:2328:5d3e with SMTP id d9443c01a7336-275232861e2mr82210535ad.18.1758556426155;
        Mon, 22 Sep 2025 08:53:46 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:3d9f:679e:4ddb:a104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf96sm133924265ad.38.2025.09.22.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:53:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: caam: Add check for kcalloc() in test_len()
Date: Mon, 22 Sep 2025 23:53:22 +0800
Message-ID: <20250922155322.1825714-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read().

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
---
changelog:
v2:
- Return -ENOMEM directly on allocation failure.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/caam/caamrng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..357860ee532c 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -182,6 +182,9 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
 
+	if (!buf) {
+		return -ENOMEM;
+	}
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


