Return-Path: <linux-kernel+bounces-838406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4FBAF1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7B1921B65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26F2D7DE4;
	Wed,  1 Oct 2025 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUBQtry0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F12D780A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759294321; cv=none; b=gdJDmupLLcfeKd61Jr4Q/1wS+8INdj6u6ApMGJEVudIM7rJ+YA9Z1A9/c3ukP5bcmIZ8aPNn11Tp9XyXq57FQRlyKv4CJPoYa/5QrnZuGfdJBwolDZAj5hblooIDliJI4OEVvqgkwyetfvZewlr86eI5j0E5XLtM7YreGhUufPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759294321; c=relaxed/simple;
	bh=Xi3sngh/ESvc/OjSXlVhjejbTfpEsJErTXCfIyPX8vE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiWT0JrkVBLbjWVm0cZ8Wpyp+IOE1Dp76PVkLgUe0jvBFtp64szyAke3fCVt2jvfnuDjIHzzgG528EVV7J6W9Mx06om+2TJvrXsx0OMiW0e36jy5Bvf8Ycg4FDzZJBytiLZTfgNnm9oW76d+vXj8rdHHhgHUefSwG7vnDmnpgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUBQtry0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so514420b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759294319; x=1759899119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YxxylV2QdTKzsnwpKABHPsiuZJtTvT85irex76OJUc=;
        b=XUBQtry0f7KHeJEfp7fz9M9fT0I3bUkptmR2zlAqNZNpQOFhotHJ4hVAntK2cBdKEW
         OUftRHIukK7y3sSOrZxBCYDoBTfskAZKf6wsqvFZPCy4fLRKZqqhWPZ5kRV7vOQK0pYa
         96cLJ6T4mVln4BhXTYk0yj8Yr/QH5MFtBAhygggfyqVuzoWsBWkekndBfgWoBytzyBfG
         eNqMF2u2AR1MbqXDfMUdtFZ/yKdWNkI2WJ5Dy2MpA9a5Kd1OeoiDgDqxR0EezcJdLZhB
         9gouZInbw01+YPiKQ8RrTiawAZyBIsIIbzdrZll4p9jQ8VRrggUAOTuNeoIHM3vEkIWJ
         GNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759294319; x=1759899119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YxxylV2QdTKzsnwpKABHPsiuZJtTvT85irex76OJUc=;
        b=MHxPYxnl9r7Z7m2s1EZ+uzjrkHaRZQiw4XAIzk2Pxl9UTsLVZBNB5o2GMgsfP456mH
         R/o1zP/Ts3ExvfwgmzUxTspv6hPAf7VNCEjGrz0bAKo7paj18H5vFxvH7QmE7900Xpe+
         l2CbJ0IRIa8dNAwbzGvc57j7P7UYLzxoygqSvudmqvCMu6WQuKbf6vbmeRMLy83dSSAG
         uCCZbcvFKqZtNOq4QubAI5NpTgq0ibvBWVkhXvJUntTqIzVnfjle4W1lv/BjtSOUGugP
         BpzJBuZmL5oJgBoGxLFt6mqqBi0IW/YjafrAYCWxdHZL32bCMb+nbu69lSoC7MNQilUl
         oCjg==
X-Forwarded-Encrypted: i=1; AJvYcCVgeysPP4sD5TVyUsvDXhnN74sO3SLw6l4Wvi/kI+FaiahntkgWOY/PcH714bj+h7nxfkoehVj7/7x9pnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJsz3ub0BnEftX6IyowkIQ1K7THptn4XDe5eHfiJanta7TjC3
	p283F7LIuU2kSMKpNvjfdxUnkqpsld29e9YW/ZZ6CCVH3EU3DqDar2G9
X-Gm-Gg: ASbGncv/7vpJDiVDD2ooAXU7SD9S5dhb2at7tVq8nXh/z9TALWh/iGEG70OAQivrc0e
	NGyRlV4ITUZbWg9EmmArg3iAGrhcR2I0h4M/kf98pXh4z22V6TFV4vPw3YP2m7PGlTH9ua0USyf
	e9NI7TX56eOlBat0LDPFmCbBo2eOBoMC+WRwvGaKkXc/IiJ6pMD4Xm7yO2TnDDMiJlRKkb2ucBR
	2VB9WxO49AzAD7AfCsMd5WuexxRxJHmVJfJd8R4Yp5BebLt0fmPnkc5EavmmutHZyiX4txV4JKd
	XToDiuMytQ5d46CxX2uaziHRF5ibgY9bh0+pdWad1iShiGyXJmwJLJslG198mzLl0o7ALFdScnS
	9rCrEWqBnXPHP502sfCYPZ/o9Dz0cgre+0hha7LvhrqIhOetJxlnlOP9T0ipgAE8UVtny11y3yw
	==
X-Google-Smtp-Source: AGHT+IEXQ3Op/9SH+Fhecn/Owy5mVU4g1feXLP5wCv6r+OnKqJrWMPLneISTKEa7/cfBfujnpvtAwg==
X-Received: by 2002:a05:6a21:3510:b0:2ce:67b2:3c41 with SMTP id adf61e73a8af0-3218b74ba56mr3301300637.5.1759294319458;
        Tue, 30 Sep 2025 21:51:59 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.97.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23092sm15347225b3a.60.2025.09.30.21.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 21:51:59 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kaixiong Yu <yukaixiong@huawei.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Omar Sandoval <osandov@fb.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: dcache: Fixed typo in doc comments
Date: Wed,  1 Oct 2025 10:21:45 +0530
Message-Id: <20251001045145.38769-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resonsibility => responsibility

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No functionality change is intended.
 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..17640d7a45aa 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -312,7 +312,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
  *
  * Given a live dentry, increment the reference count and return the dentry.
  * Caller must hold @dentry->d_lock.  Making sure that dentry is alive is
- * caller's resonsibility.  There are many conditions sufficient to guarantee
+ * caller's responsibility.  There are many conditions sufficient to guarantee
  * that; e.g. anything with non-negative refcount is alive, so's anything
  * hashed, anything positive, anyone's parent, etc.
  */
-- 
2.34.1


