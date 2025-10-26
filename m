Return-Path: <linux-kernel+bounces-870687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D926C0B741
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387FD3B7DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA23002AA;
	Sun, 26 Oct 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUGu5kuo"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FA13B797
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761521700; cv=none; b=Arw8jiGpZKpUnvImNK1//PcLii8/KLuUf+Yads/EJkSMOZTC3ayDy9sRuht6Jzgfe2lBlujEbsl9kgOYtGTvrpyaS9WDA56Ya2kCtDqKknxLnNMzYLMT6EdnVHTtDAYOFZ8ZpcPmNOn8o9gRthPjJNkIoI1Bnj41VEnzVi/exfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761521700; c=relaxed/simple;
	bh=at/67SzS/p3gsLpJ5YF0J/wwgPW9IOdgdRXKzYCWyc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pn2LdIoeGkvl1QMM0lxGhmNqM2eGW30hM/KZ+4md8dzRYGKflQqTW6Pq9JCpMA7/5arWPierJs/434J9Cj66m657yg/mGw+1niIBUNaFMzaQhsFYm11M8VSbLeDsqSroNNLYej4djFAvzr41HZv6E40bCdnecrhDWwnvqH3ffk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUGu5kuo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c53908e8b5so562213a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761521698; x=1762126498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjXmcOnCPMZhVr3FarSjpJslIfc1BLVEl3PoT/jHhcQ=;
        b=NUGu5kuoD8yLc3pGsGS/0F3+5rhS8YdjqTOx249l5dG03TzEg+MB35wS4gc+i4EZWo
         8ES4GSHyhd9oxJVMfUSign0guAD33MxLeyPY0miSZ1m0NzlP4BzlESh7wrWfJv4aD172
         lWZyyzywmXb6Ui5X+CqTyqRW5jk4kzJI/NTOgqBLUS5/lkbgoLTuJWHzQcjTj0KurS1d
         h1jW8xIbQA8bN8mmLG17i+yCzp17OTaCfcAHDxeO32cGWC8J7LhIy/txCfCsmiqutD8Q
         sxT/ZGTKKgEGXkmlP/cGNOyjQTrdZen5Un4EvRJnn3C4T4UK9ppKNqikgFSadQm1Mtyu
         a2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761521698; x=1762126498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjXmcOnCPMZhVr3FarSjpJslIfc1BLVEl3PoT/jHhcQ=;
        b=ssK+BKxq/sHUB7N/36zgdkAZFhbVsUrZlmUorlZX+WKw1m8pXzNxZiqremJwXAkXTl
         RAXY6OQzOcZq0kFbzUrj39DVllN9c7Qa1vjrr/VUitmkzpZlAnmm8BtSMfLuyvkZgVNy
         XAZZ6kyL9yAf6aFyC4HtudIRpjJunkjLmLCO5HQMFpPWXghNZvWURo30a4SOESMFNfM1
         2fh/nusgbIygwYfWJOMz+G/U37OwnNN4iAT1vQ5eEoZdjvooQZ0K688sqNpBrcQJm26W
         reReC3FGpDSlEsC4GtqWZuG/sF8xUrHihzGMJG/iVsPV3549l5h8VrBSsZL/iWGxNFRG
         usJA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ro/xl/qwknvSb9re47k3s3IGbMG3CaUQTLkiyHFxY8awnu1AULqxJ4gAzCLi/LBsdbLDk1KaJvu9IQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNgQEb2CcPeo9OwV1OunzQtOVoExebgKvntv4+OtrRMlIJvHw
	XHH8RBevpdvHWSTFPxS8T5hdbTf3tV1m5/NOW4HizE8fQ7YJlnywLJH/
X-Gm-Gg: ASbGncsoy+nbw2maCya7ww65DWfQTlrXjgPwNF7n9xzL57k0rJ/MmtLpZ/Vodhf8oHK
	PeOadJVVc8SxSt9/MqPdwqyL7pWG1wmon3fQqAdLPASmitO79T3ncMO4N9tihASR6CFisBd021N
	92kRrVIIDxk0GZrSQCNat37PB7LknJpAXboC82yM3h6hxHV78YljOvD2v+iI/2BCy8bIZTlQTJL
	eeEyQ9j4ZNswfueYw3gNdZj1+ljjIatwg3jBcINaf3luDugvgVfpGu9KvRzZeaHspErHo5daVe5
	xG0QBD3lLjzPY8EI9bjUXrBrpOlU/pO+xh4stnIHl+01A04vvUvsdKxByZNbaTio9PoimivQfGN
	3ZXy1TUV33J44+POK6x4D42K3TcY5SyvzyoOXIogxaZI9e8arjHJ6cUKxOdnjTZVtigIE78YDSE
	n75dIhZ1NvBhpB2K2hvDRA0vGk8RGQ+Xxo
X-Google-Smtp-Source: AGHT+IFRoVxA8JDxaqFZaD1Z5ybzyAsPgQl8ptpUfUhfppOKQNfzWK4qTEYWo1gQA8fuuCYqe0XEzQ==
X-Received: by 2002:a05:6830:83ab:b0:7c5:3aa3:4927 with SMTP id 46e09a7af769-7c53aa3554emr1369347a34.25.1761521698127;
        Sun, 26 Oct 2025 16:34:58 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c530134ddbsm1691602a34.8.2025.10.26.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:34:56 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode0 an array of const pointers
Date: Mon, 27 Oct 2025 00:34:32 +0100
Message-Id: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change g_fbmode0 from 'static const char *' to 'static const char * const'
so that both the array and its elements are const. This addresses a
checkpatch warning and matches intended usage.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..ceb89ee99ce0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.34.1


