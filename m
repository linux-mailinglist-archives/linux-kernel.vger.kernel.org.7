Return-Path: <linux-kernel+bounces-749800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1FEB15303
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8277A3402
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1892BCF75;
	Tue, 29 Jul 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chU/7+ya"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E22BCF5D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814484; cv=none; b=LRhuhdJCyAgjybV+Xk3WuRk68HHLPBUuKod0//vLwmsk+6jBiN4p/9NqgpLfoHE5rDkFg3uKCezZoa8IBpAfO2UVoHcsiuKbWcc1gV7ngL52IBZb4gpSgowgHzSxhWQ5w9jd9IWlgMGU552Y2dGurPsWEn7eXSC9oX4YwrE5TPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814484; c=relaxed/simple;
	bh=nzfpYYUW0g+FvF4H2c4e9dRyq2BbdJhYOMQXnDhfEck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7+kyu7edGiwleWIoN51Eh+PdunlStGZmu6aA5mqyJZNZ53bi0u6fWZpzyXLLzY9Ie1gEuCO1Xv+dsw0y0zzKAi3hycbK4cyvXpSKYwVdqfLLWNomX31jcHKrLJXfeg79Lr2Q5NXIduMikQBELWJXj5Mj6k2MY009+S2gs7JGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chU/7+ya; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso1602946a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753814482; x=1754419282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3a4DFiy6vzRoiBRM40jvEbJAbVFfBcQs6ZeA9cSkgmw=;
        b=chU/7+yapNAOpEW+MEC2UOPvcA9Y/pvlGUJT+yGDNj8eL4i7vtE5Cik7utJTOuR+2Q
         qIV8sE66rWJImBPfl6xTTcDDVZeirKMcOPo1Mp+RmBtDhaYNw1dxqf0lnExdLpefS7tN
         sk1EufV0fT7L6z8MjcUj6V54o7zsZyxeW52EG/ZqxZG0xYfse6wfoEzUyhwHSjrl22NI
         g4x1UfaTIKo+iSIthklI2QpzuF3LecNOIqMVl9HNr/lr8ViM5XikB5t1t4NTFtOF0Ypg
         sKnukn9sRmHefetcWaYUPdfnO9TwYXAAeiuiLwI8IT4HtrePg4uOqS72R3OopfJGW2Dy
         Vm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814482; x=1754419282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3a4DFiy6vzRoiBRM40jvEbJAbVFfBcQs6ZeA9cSkgmw=;
        b=FpYzrew6z3bhyEdbtrbmcih9WgOZOKrdzTgGXbvGPifZjzM8drFsWNMi76JtbxagHw
         0pScJi94aGAl0bS9MQxP/mYorizMF+vaDYAkfZg3BBxPltFMMeEY5O0YYWxM8q7etAJl
         hVvLRnfypt5JzbnRmiC4gEFJ8JYp2i8HzxtEHfqJeE8Yy+gahYbiA22FaSRGKc48+8Nx
         xB2HaHA9R/dAtQX9FioKqYFkwnTMB4Ot+13HyiV9mRtK53DimfXNBJYgk1rZ1iIDOKhW
         FCmD4IcCpiEB8rr96S8m2COMaMQM+GnNBXxVj9s9zhpNeFz4pAyZoy2dFErs9oU3yAzB
         bE5g==
X-Gm-Message-State: AOJu0YyVr9i5YQiFkzseKrzgawIxia+E9BGCeTipb7Pg/R9SZOr6SN7V
	FAHTgY9IXUQ+mLm6ORofV6jwGsjMDCF2OIvdfNKZR9IWjmJg5d1lSRk4zOoILA==
X-Gm-Gg: ASbGncvhaV3qxmeKjBkzcekdkMciQ9uaTdkg+ucsOo/E3WHKnVdIGV0dbBAQya8TVlR
	Cw7ajtAiKG/m9n+jLzpMAu7Set4vvcNGPsoiU2C5Y/CQCJoTvYY1d65CG91fJYw2BjZdtv42/K7
	KblRXATsMH5SG3ftfI6hwwn8hKj+Y3MWgpksYLkgsohnZo+EiYaCjvwJktp52WvuXunRiTqrIbo
	hrI4Un898IgnhWU+Hx5ElGUpkdQ3gAPWDDSGLlqqILdhnX8+Q/ajTqBaMgcDE1XD7GL1dgY6Eiw
	G8jeFD4ZTndZZ2n5Xd3B4/ysnTP1RRbawBLN35L6CKgk2/V5h/tCLyB/3FCj6jBVVznPuUICfsu
	QbOp51fLxh1nLiFJ1rlAviQ==
X-Google-Smtp-Source: AGHT+IFxK7eCdsL05Atg5I80s492d9k/69irTuX+9tz7GqB/IE0OA6vSBTPqutkxoxNDiJAPYTxESg==
X-Received: by 2002:a17:90b:17ca:b0:31e:94d2:c36f with SMTP id 98e67ed59e1d1-31f5ddb5201mr783433a91.8.1753814481693;
        Tue, 29 Jul 2025 11:41:21 -0700 (PDT)
Received: from fedora ([200.111.160.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f2ef2462fsm1688843a91.0.2025.07.29.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:41:21 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/misc/vmw_vmci: Fix typo 'recieve' -> 'receive'
Date: Tue, 29 Jul 2025 14:41:23 -0400
Message-ID: <20250729184123.160500-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in comment of vmci_context.h.
The typo is in a comment, no functional impact.

This is a trivial fix that improves code readability.
No functional changes.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.h b/drivers/misc/vmw_vmci/vmci_context.h
index 980fdece0..083effa08 100644
--- a/drivers/misc/vmw_vmci/vmci_context.h
+++ b/drivers/misc/vmw_vmci/vmci_context.h
@@ -98,7 +98,7 @@ struct vmci_ctx_chkpt_buf_info {
 };
 
 /*
- * VMCINotificationReceiveInfo: Used to recieve pending notifications
+ * VMCINotificationReceiveInfo: Used to receive pending notifications
  * for doorbells and queue pairs.
  */
 struct vmci_ctx_notify_recv_info {
-- 
2.50.1


