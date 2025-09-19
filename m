Return-Path: <linux-kernel+bounces-824089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05770B88175
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD4567B78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1132C0263;
	Fri, 19 Sep 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzrZNS68"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D1280017
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265451; cv=none; b=t/E20+j9o3m3+6FrQ0CYC5kSKQ8sVV/pHxzERtd4M1vbjEN18mpM1Mmfo0xrlQ3Z5SKJT/JZbOGg2NDBig8KCUXNcWKqpeZOmFfOYpAONs6v5DKRUKMGtzsLfCSgcKdzvoy8pT2WI76RUKVrh1y6T5jS8Oig9POlYM3VE6zL09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265451; c=relaxed/simple;
	bh=KU1h4VV1wMSXyouVUU/UtVsEOnDbsRNg47FkuVn8FTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3fgzbPKel++g4pC2SmTg/zZcTgepjL9EBtrnY6hXFq6uE16+IsP3MTtpbFYyfRyXvzeJzQ/zbiLMdJ7DXAln7Eg3CEA27q2WfQ2XUBgFfXjkceRWil7ZG4cYmDZBDT2LwWaZNzNQjB+eFbyTgfPD66KbNuGzDpEgQR8Ew3zoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzrZNS68; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698384978dso14182305ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265449; x=1758870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MttuRBNzmVWlDOV3YcR48SUIZiA43H+TnBEZ6HIEHsY=;
        b=OzrZNS68mz+PIPyaM81sbLGB5y5v8vsXu1g26zvIavhw3I3ye6C1pokThF4wWgmrhj
         e7k7EFfskWG7PM/jvNWd8di+refLbmwQitMCjvehw3/iyobmCOsxLyOBGJQsAoca5iIh
         qMofjGYqf0TZRGgHsn99KUz0/U1DVECUyQ47qIXN2HLs1y2dooJAlkb3p4XZfL3CUmQc
         65srKaYbwD2pH8eHC/jsdvycj+P3TGdw0AkvK5/EsQi0ooDiZTzzfMSxuknKf0B8qEEs
         T7uNcR/wwYNZZfEQdjOCLKO+ach0AeTNA6OZ632FsBchxELbfFomnu/C+qihaTex1Csa
         50oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265449; x=1758870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MttuRBNzmVWlDOV3YcR48SUIZiA43H+TnBEZ6HIEHsY=;
        b=I5XwOMyh0BoILgJ1pLAVsMEL6GJwOlWRr2QRePFf+UR+wXkJEPp/RNqS4G+QQl0SEd
         ew5PBhJycUvGalIJZe91F8bfuiW8c3TzATScVja3jyNknJQiEZhHKs9Y+EVjc9ePPHct
         Sb6bHaVrf0r6Z8agaVEQzlsBM1+1aREypYIuy7SS1DuLrwoJQAvQILxp8k8MdEYSL+lu
         K5aArqLIFE1av0UtLzFVZpKSykTYpoMpn4V56XTRjn2cwQoJWIIiu6wp8n/9PPwGw3+9
         rEaPIwqp58ArNWP4APu7Ueo9wmADX+eKA9ZQTik3e1rqBGqoIvNIIKwCBYgWp8URn3rs
         ieIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN9yYUwqypclkxJcV6weMEgScKsqHxMnOsYkvHY8ZebLKnXwmMa38PSP9vhZvTQE/r1FVPB5xj00hU97Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY1K7oEngIKhwcisTPbp//I/IQeoruc4WnQiEzS0crculNpXg
	QGHULGpXLQsMwFwoJeG7ZK/aq2neP9kmJskD8BEYcRcpmmBwbDdVPOx6ScgziL7OUj00
X-Gm-Gg: ASbGncu2MnTtZOhYRR9879pfZ08m1if9E1HHrUj4aGNQZ0OfdoX/QxoPzFBLt/n2Vu8
	eAh+pUaOpcOkAa4TxOfjgQodWq/cBeM62xwVaNEJ12PrwVRG2cMK9SGzCtQaFeH32V7WcSR+Hia
	FwDF3rNbv5Ozh3aYtbyGCW1qOMbWaLzTYFWOdTdMZtBvh2oDQx9dcKu6eHeEi77ZcjH2Xu5m7mH
	5+Oo/XRE4UPgTje+TtosIWt3mdrTbMyuslXMVBFzFNssV1InQ0i+cA+DadcLlH0UY8toYM4sD4b
	bBhtY/EH6XPAf2hyfOqJQdYfX1C7PnPN+kZC7tE8q3qep5WdH90pqiJDIOIaGP8G7qFtfCB7mXb
	C4mFLpR02Pvlc0rnO4n3Dk+wWJFo=
X-Google-Smtp-Source: AGHT+IHmJKuv+e96jX+1MZEwkVy5fSIJUGxs/wGDLFbRe5tki3wCVU5d+tEKvL9/S3U78ckwSQcHnA==
X-Received: by 2002:a17:903:110c:b0:240:9dd8:219b with SMTP id d9443c01a7336-269ba53e4bfmr31773705ad.49.1758265448958;
        Fri, 19 Sep 2025 00:04:08 -0700 (PDT)
Received: from karyapc.. ([103.105.227.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm45519755ad.86.2025.09.19.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:04:08 -0700 (PDT)
From: Soumya Ranjan Patnaik <soumyaranjan1812@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Soumya Ranjan Patnaik <soumyaranjan1812@gmail.com>
Subject: [PATCH] staging: gpib: enclose macro values in parentheses
Date: Fri, 19 Sep 2025 12:33:48 +0530
Message-ID: <20250919070351.586981-1-soumyaranjan1812@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macros with complex values should be enclosed in parentheses to avoid
unexpected behavior due to operator precedence or macro expansion issues.
This change wraps the LINVAL macro values in parentheses to comply with
kernel coding style and improve code safety.

Signed-off-by: Soumya Ranjan Patnaik <soumyaranjan1812@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 17884810f..ad82be69d 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -47,10 +47,10 @@
 			dev_dbg(board->gpib_dev, frm, ## __VA_ARGS__); } \
 	while (0)

-#define LINVAL gpiod_get_value(DAV),		\
+#define LINVAL (gpiod_get_value(DAV),		\
 		gpiod_get_value(NRFD),		\
 		gpiod_get_value(NDAC),		\
-		gpiod_get_value(SRQ)
+		gpiod_get_value(SRQ))
 #define LINFMT "DAV: %d	 NRFD:%d  NDAC: %d SRQ: %d"

 #include "gpibP.h"
--
2.47.2


