Return-Path: <linux-kernel+bounces-863987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFEBF9A83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6DD3A9329
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8220C029;
	Wed, 22 Oct 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUh8V7wO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D941FE451
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098056; cv=none; b=dd6FZtY0nPJ0vOfGuTtY1Bw4iwYmDU00yiu25rKqKrhz8Y6oshjxk3GmQLdJVYVtdxVl5a/qf+WM+tUu8Z8sv6zf/Vaoue22FtfR2ve+Fz56hTq1jKdgrM1VaLl1RC6ubIPzG3ozJf3pN3NeOnWRZXff6h5LnxqWdU2elF5BJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098056; c=relaxed/simple;
	bh=7SWJW/bStU/PcvTcsMTdRhwzcQsK6wMyBdkCxjenGzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXOv96mtUCBBXyESf85A0i/kkL7ezqFQ7CdPHy27ECawdpifmgttfDGWH1I7NZuo2RQuYTqTEKiRkc6YYkHPXaziNfRTHM6g+fWlqGjc/HTulF04jYxE2r5uoDEmT+pUM7YJAx+c+CWk/7wNT02kgNTVVXGfUzrjlCl9Cz0R4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUh8V7wO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso56780535e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098053; x=1761702853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdEInNnnI8mUaV9oHcjuBVGjC97eLQH2pPXt+cVP+WI=;
        b=jUh8V7wO1dka79EH6/thwZ3obJCFmx8aVfelpWXXzfEovxpOu44fuAdYR9aK39fK6h
         m1YQfogdEXwVOxjqBAzXh3yYgHqgq8Zntzc/TNxiUP3tPIwkOyWI9m8BdbQdUSuLVMPv
         HC6jrN0t8SvY4DsaIKrj9BJ7nsDAAITDjZ8Ijv/H0aTLjSKWq0LVsbiqdFgoHS0h6eNd
         NPnsfR4G4IeV9Kujag+QA4Pq2xov1pBhe3QS2FSLP30clc6gyjdpL8fX1kbioCu1Q/9F
         c6sYwq34NKlCNjQRn80/gSEwBtSCYeW9zTLe85w1XrgDIQ0Z+HmQ0fDlfAqkNVWwp+Ph
         9RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098053; x=1761702853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdEInNnnI8mUaV9oHcjuBVGjC97eLQH2pPXt+cVP+WI=;
        b=GRisYPrbgUexLv/9+mZzmyaA18C3IzW6Kp7Nul/ErPOdozfNWMiXYOK8vfhUwzPGCH
         18hCISaTo0gAXHlRe3HqyHsP6n+17GhzLa4zRaw+QPO78e+kAU13bmx/tQs0/oChX2Ai
         dLHLsSeuDYiTas2JXrstJnTrN+x7KLTDhVSHjYEmKGnmS3c4yOwknHIKySY9ebmg7bb0
         k4N8MflgAySxRmZVRTW9NJhztaEfr90KHo9aKexPLh0LGuPeXeNd55n9U/rcUdUg0act
         hd87lmCHhBoBN6ulvbum1G+MI9TyZsrFRAnExMqa60e7Rrrk9ZXrhnwb7jYBaKbvwP6G
         oxkA==
X-Forwarded-Encrypted: i=1; AJvYcCWUlndt8Pac6IAB7peDsoNpVhk9FOBKktBfKtpDdcDg9cF514ZodhDqtFbDK8H00bB5lIfgifiiKmto9Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpJPx656T39oM2qAnfevXvulFW9MDF3MipO+W3MCImrd0w8dd
	3WE8/8h1YaoUugWvjG1GhvJ6me800/K6gqa0JfQGn/cgC6+5zIc5Z6gb
X-Gm-Gg: ASbGncucEC0SG42et5nEUEjjgJyCZLG5VvG0gnQ+mxhN1EIgyQYIq+uQory0NSvQBQo
	lG3Z3a0QF64si6Di3RWFp/8TAb8vfFwhAPydAQKVfHIswe27kUWUP7Jb/pj8Cdj/YyGa5iZ2Y3U
	sX39Da6pVDyRdaizP0C9OImYeON67wBPh/NhG7bVV9/iQ8N82aR59uf7UH+ryahHCJwhyeLD04l
	ifGu2lvm9xsrzVy3Do49H9mrvm6bHSVmYKuJu7IFZn0k4LH8m5IjS/MSUViM2JRH+WqRnaXLwiY
	GKwCBVFHbQRdmAr8DteYvsR+rdtnMYm+aSBgH9oB28kXcuAzGtlOoAxUVjn5p/FyOJWUImsn67N
	Fu8uDlnU+7Va46pPcG3dDJL8D1GJZ7G6w39g4ewa0sq537AbWSa0B+6MOP1hwu4+9PiCBRbdJ83
	ztUZl5/vyj4cGQabo=
X-Google-Smtp-Source: AGHT+IG+iNm8EjeDp0NASCXQRsYB7vpkeyR3u30iI3VIRokzzDe0B+HNAmeJ4eO8dQkgDFLMnmcAGA==
X-Received: by 2002:a05:600c:858c:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-47117917bb6mr124309795e9.32.1761098052918;
        Tue, 21 Oct 2025 18:54:12 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4281314sm19309395e9.4.2025.10.21.18.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 18:54:12 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH] i2c: pcf8584: Make pcf_doAddress() function void
Date: Wed, 22 Oct 2025 04:54:05 +0300
Message-ID: <20251022015405.7082-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pcf_doAddress() function's type from int to void as it is always
returns 0. This way there is no need for extra assignment and extra checks
when the function is called.
Remove assignment of pcf_doAddress() and replace it with a simple function
call.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index d1b0e55fd871..7e4a6d19494b 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -253,7 +253,7 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 }
 
 
-static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
+static void pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned char addr = i2c_8bit_addr_from_msg(msg);
@@ -261,8 +261,6 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
-
-	return 0;
 }
 
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
@@ -288,7 +286,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		int ret;
 
 		pmsg = &msgs[i];
-		ret = pcf_doAddress(adap, pmsg);
+		pcf_doAddress(adap, pmsg);
 
 		/* Send START */
 		if (i == 0)
-- 
2.43.0


