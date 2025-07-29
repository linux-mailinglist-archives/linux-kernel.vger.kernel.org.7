Return-Path: <linux-kernel+bounces-749801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7339B1530F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6005A4640
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C62512C3;
	Tue, 29 Jul 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inRvrZCY"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBB288CB7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814500; cv=none; b=pvzuzEyjT+StQA7GjFnOeX+208H43YFd3GR5JLnY6UTGNgN1nqwjuYZPzDqTMhLWTx4gWYKyhsn+/9AjY8THQt8kxqTakn27YZhLt+yar2f0kW7ftPCOuHQLItzZwNwoIc3B5cdpb6HbSFWTAzYWPNWYgapw8u2NY0ZSarQV3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814500; c=relaxed/simple;
	bh=K8FwAuXl2tAaeaXZjzJyZSNvcAqWgNpGAXne/KMns2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFU8Zn6Ukbeq3kyfGQK4MzcgtaE3+qJ1wmCUqiXSPJfVdQ5VD1ZB460PnnyVHltoAtmtEaH/7F3wl4LcEVDwtdqRy+eETWS/+AzyOV3iCrClz8CNI6nBq8S292hDpdBSx/WHILqkthvizyC34b/ulZtyZeOTC8EyXBNLCzNRQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inRvrZCY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490acf57b9so4041291b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753814498; x=1754419298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfUIrVpEQOM0T5tWbNj1GsfFx23vEuxov+ArCEUUrNA=;
        b=inRvrZCYhi5xgDbOx7f1F9K7P1JFMkejuqHheIO/nW/bPhYKBJ/RuWca/h5iRbfaBt
         tUSP/onVXkRvZH5TkFe8F6UlU/xDDbEYJkfh/qVa7NqtrPhQhhrLpFDQgxvE0JWNoVWS
         TU7MdhlUapcNTppKKpQs/mIVQPg3szpfxrDkgjUFafI2YRd8peYstwlQzIOOWFLVsoz+
         lCR8B99y7ZD1hRWrR/NstgCiX17vTzzJ/CN/TC+vovjbYUf2bOJjTCesmBNvI7mvgSjH
         kLpsMcg4HlGPVJ3w/7OJbfugUv1D5B7kWIS42oDjhhQ7pC1kWX9OBdN6nFVFc/lvDJ83
         sOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814498; x=1754419298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfUIrVpEQOM0T5tWbNj1GsfFx23vEuxov+ArCEUUrNA=;
        b=Kc3jj+fmXlYPeguohzJ76Es4XSor43M9q8EKWu1vS75lb2dOUG34YPGgI47YB/zJfo
         Ewkj5M7BmpSMrk6c4FEfP3xvIvoGR//Zs6vbJfoDzwSTRR2V9OOTPDEH5GEwALXAyJp8
         31kbuNtRJ8G8JzIb+0f1Caae0YkeMsOAGoL0m8DyFsJNMGfa0tU1Jbfh+NZpmnDNHZ/l
         22f5kU2D9ZOz45c8825mve1i5gZ1AI5+wSsaYLrThrNKuEqWM5qB8hoaI1MGIPNlLPa/
         3vBHvua+CB3Vtm5aE+W1Rw8Pj4Qa5lzWVPd2aaYzZg6W8LvSNmfwnm5uSZjeVuZRNk32
         MJTA==
X-Gm-Message-State: AOJu0YzPPLw6REs1ZDKGZyhKdcnxHyRh9CsZ1E6/9rgFsUHIy7YV0ea9
	V7kcDG+1W1yCBOcl6PjFN7DmlJX3zpH17eFbR/UqDYguHv8t3jK3k3pTCLmgDA==
X-Gm-Gg: ASbGncvrrI+TbKXIdWtiGh5gWde3cMGJnRrTtmwnoiGXWjbQqFWfzbOueoTcMAxa1nq
	EFZ70WQDRqNrKQIoM/mQ9JkWu1Pm+uW/MD6DUjVEedfWXK13c13cU6BVNkEX0dgdhNuGcLBYLHz
	zhYQBgOXS+jfknTmpv5zCzxVMlKzeYRU8hMeW6tgofve9y4qxxYoWZBFhBRdWmslYOUL9mtk3hM
	n/JZz6Dm05p6X+6DJnlJRPUJqm1F/hOvJC373iviMVu6z2D7Ov3Hj+HLE4C4objzRDDfcAayF7P
	FLomsn8a7nzpT2bd7AiLFgh3Wwvao34nc1k0vRm00PQKQ6D+Yr5sKGZj4dFaPOPQChqkSVlNwP+
	0j/dvRK+MD4w5p3aPLGkUtg==
X-Google-Smtp-Source: AGHT+IEZixwDu/PXPpZff2F9/gWDJVgxf6CBCAA1yUvJQsBpUgCxgXCF+lOF8gx0DnWxkz0xEnl5Rg==
X-Received: by 2002:a05:6a21:9999:b0:234:c6a0:8a0f with SMTP id adf61e73a8af0-23dc10a608cmr551341637.41.1753814497892;
        Tue, 29 Jul 2025 11:41:37 -0700 (PDT)
Received: from fedora ([200.111.160.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfbfc2sm8712490b3a.90.2025.07.29.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:41:37 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] fs/dlm: Fix typo 'definate' -> 'definite'
Date: Tue, 29 Jul 2025 14:41:36 -0400
Message-ID: <20250729184136.160577-1-ignacio.pena87@gmail.com>
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
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524c..d5fa498c3 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2305,7 +2305,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 * 6-5: But the default algorithm for deciding whether to grant or
 	 * queue conversion requests does not by itself guarantee that such
 	 * requests are serviced on a "first come first serve" basis.  This, in
-	 * turn, can lead to a phenomenon known as "indefinate postponement".
+	 * turn, can lead to a phenomenon known as "indefinite postponement".
 	 *
 	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
 	 * the system service employed to request a lock conversion.  This flag
-- 
2.50.1


