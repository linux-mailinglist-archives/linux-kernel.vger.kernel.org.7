Return-Path: <linux-kernel+bounces-826284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553DB8E154
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DD178666
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45B2522B4;
	Sun, 21 Sep 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idLMGeGM"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CC1B87E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474529; cv=none; b=FJ/l61rELlIZTpnsRFiCvE0j/enD/Vvgp3KLHCa1TArDYnVYozHmbjkkgInCkIo/rw3nC7obwXo3LnvhgsXmPCheBh4f/9LIxzT5AeXLCkbcNu8+qKdZbvOCzi6xoJ+/hqeJtHQLhTeJcouUB1l1OkSD49+iX/AcimyShrOtPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474529; c=relaxed/simple;
	bh=ESfysI5irpo6VI6OY3A7TqZpje6xY/bTUCQuouqbaKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OT++hHJMcIDE+DfCXAqpr8tcXkAzGyjiV9QdmHPSZw337FWLY1/ub0AoKMOEbmhzBi2g6DnNo98TLavOIky/DY7fzG94ze5HSD9lTR+jkAjsdskiBE2eJdaEwsFcXytS4B/2SoZAH9oyaZ1mmYB85grUJ5xp8OZcMSzxjws++Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idLMGeGM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so2410302b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758474526; x=1759079326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AosUgctyk0Qt1mPt3eaELkb0eU1eJkHfAr6DxGd6drg=;
        b=idLMGeGMFWaFiWIy4D4ZwFH5YK5bWmYXpb6GVzOSe9+l79+s3pU6wICDp+Qfka9KZ9
         uljIyca2I+9Ksnl37QXpxk7NDCyCQ59HmDWQrYq1QgkPITHCW9A2GK58h0mpimiWvoMH
         BJWqr+CpIyka4QvDW85hpGaYYssOfvEosM6nFLFCJikOBvRMxry1H6AuhOo7ltc0mj9o
         6UI2gCqCXVWrP6Jqb14LvNVX0oyuzMrmULsMFGWrqaDpuwZXoG7qJGMZJHh4kTufHOPe
         o/Pdz8UPjoQC4mLbH534zXc+4REJjq58A5qbn4MBpFIMito4tgUOdvaa7Yc3Miq5pIAy
         rqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758474526; x=1759079326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AosUgctyk0Qt1mPt3eaELkb0eU1eJkHfAr6DxGd6drg=;
        b=U3RTVbUvhqvDpVfuEPtd6vHmImmiFo9Ko7IGZHPk3RNfiTPA74f03QLQGbtWybp1eX
         qbfFswkCqJRHvf/OmImAMpgi4DCoKvMz9V84Q9ptuBYs1z2YNaXkdjOShwg90zVDBVo5
         /7LYnGG2K7Y57eLefEody0yuwdJO76bTxCkAvTUOTVhdatGlK8mIhFSySRMgGksZAQoZ
         TFcPYEYjto6IjRUbdTbiUKdbI05NNhC3WqUpRfMweVlDm21bQ22l9Kn/GdnQ44nWNKL8
         pdDdOVxFU1rdgopenf76bqcXdlTqUdATIFA79yzQb7SSDA6b0Xnj2RXSA1zp09hCh/pN
         VcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpzM7DJPVuwTBpQXLHe47TQJjMTJhAUQIf2N5YVnUwH1tw1/ItNnU/XjE3raIQVD2ROLRBAFvn3OIMO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwartlAjcVsmnuS8gV7Mpuitkr6r7QhMlXHYu3ApD7nUleXX0UG
	1hUUZqd1bt+arL/gqN7M60e4sSRA+luj3mddYZEyPsifj0IKlDpFMKliyAe/NLPe
X-Gm-Gg: ASbGncut9HB/q1xbVlXgZ8S8VXE4d0keQKoNu2nbO9Pe6Dxh8PPqJuZwrMl5r+Ehods
	m8YHqVeyxA+gwuZAahZZurU6062vLZh7Q3kJ7kVAErcKSDWvynbkisrDVq/8OSw4ntihgVJw5FN
	UBDWJciKcXwJuAVtnmd2F/wr6gv7ru5JwO7Mxzd5/hkbnnRMsmFK1U5R7ImHTRVqaLJhhdThAU5
	6SN+GWb+vmHVMHaWEdcgo7tQXzYl6hOqHRLTuIK3Atbnz7S7jxMUQ4dfFek6hXYI+h1B0D42/Oj
	FB1HC3UwHJNTj+BKJ6smu6hQtlP6HR/ChOYjov/Aoxcxhr8XGM9o8dTVYsJjMzTV5gpCS3b7Ca4
	qp0O1i79HTrIGHwaPe4gJcKLP
X-Google-Smtp-Source: AGHT+IEQ034Dvlapqua1Ol0l76xVGanSAHuXZKyAmv1ht8l8P4mc9lf/Zvupo6s8uK1lRZkuCiFDlQ==
X-Received: by 2002:a05:6a00:4502:b0:77e:f03b:d49a with SMTP id d2e1a72fcca58-77ef03bd586mr10241915b3a.19.1758474525898;
        Sun, 21 Sep 2025 10:08:45 -0700 (PDT)
Received: from archlinux ([36.255.84.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d7b79bd7fsm9701096b3a.77.2025.09.21.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:08:45 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] selftests/cachestat: Add file tmpshmcstat to .gitignore
Date: Sun, 21 Sep 2025 22:38:31 +0530
Message-ID: <20250921170831.71609-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpshmcstat file is generated with kselftest run but was not
ignored, leading to it appearing as untracked in git status.
Add it to .gitignore to silence the warning.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
index d6c30b43a4bb..abbb13b6e96b 100644
--- a/tools/testing/selftests/cachestat/.gitignore
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_cachestat
+tmpshmcstat
-- 
2.51.0


