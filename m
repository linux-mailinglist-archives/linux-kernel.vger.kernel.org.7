Return-Path: <linux-kernel+bounces-831983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EBB9E120
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A31C4C3842
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A427281C;
	Thu, 25 Sep 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHGxhLTz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0962627EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789299; cv=none; b=QhyXXqtjMWLkXazuLOrphBkd6wBQqeqAv25CdUr252yVPxbHN9r7m8hTI4JVDU25ArLkney3X74Bn3KfKKXB/7uj+GGDj7ZimyNjRBkHIW8oRSdh7MnZiYqv1ZM+8Kig+bO1Q3KQWBuMKlZ45HWYbr0lzQJsAWpfFYGvefLtIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789299; c=relaxed/simple;
	bh=dR9HvHfHzV5hVg4Iha4WhjFXHQAZs6uoAgAxoasItxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPS6OYT73M2yeOkYF6AtKo1kbKMY0Et1gSq6Zs3JIUAhbOycWy1GPdQn2LgIrAsSQ7KVI9wEUsOidw1pQH+G5oG5my1Z87zr0z9DT2tnguWvFA/AlsiO+lFx5K6TwODlIrJGIVe7E7gj47uDoDGBxc74MHEqsr1m/4S/BbYZ848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHGxhLTz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271067d66fbso7472455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758789297; x=1759394097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANURo4OHkdn7BKDpsP9ExEgq+Ssd6myz7qjxoL3I7J4=;
        b=nHGxhLTzvviemgCuBUsD54z2mqOAOKs2ORV8PhCQo0bIznUisH+VPBnKcyHWqKeWRw
         lvnpHTFUFdbB06YPLg61/drrMUXj4tNyyWlE2CvDwDfzGtBbRTpkaK4Y7fCNiFOaMo5I
         1JGbJl8ZA0DdtP+WA3a500KIgdNnIAj/pNLDBsiSUH5Z03eQA1QehP32/1CMKp2S+BBk
         /NroH6BL4LuYKbvbq9VFUD3+HA78P1MuGyLLOaX2T7pc1T7W7u1xoYd6vqu0Bhyu8BXM
         erCnW4pzgaZYYRDfJ9uBoA/G+PcCA/tHrwssCvrMD00qrr8Td9aIO8nNNWanlPeRrd+0
         DQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789297; x=1759394097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANURo4OHkdn7BKDpsP9ExEgq+Ssd6myz7qjxoL3I7J4=;
        b=lkWwk67/LpVY06nQ/yJHHt/xL2hp2TReDueJu+ZsA7n9WQRV4OFugZkuWM6K05Nv9L
         i5hKcwSWQbn6K+zk+fEN2f76nAGQHBmVvW9uH0DjQEjz53RqgQ1V7o8G1gqRLDOiNdIC
         7cshqA4PCQW7mdhQyHDKIsvx+0Q/Al37oLGTF3ScjRAnvPPv4yAFhbRBdvTbGMNLsFZ1
         FFyzA98BpMU+uCMu6BCi9QopuRxxhEObev/MAVAyl/mheRibhRFvvn7vhjpD8jDgait2
         shqBRyWqfueIDgF/EL1r2zFLxY9jEgLmbdo913WvlUmJJzpaBD4v4Xmec475oqxAS7il
         Ezdg==
X-Gm-Message-State: AOJu0YxSIR1rCOTia8SJcQPjMTWbCMfixf+NAggx2ReJwbC5gMO5pyNa
	dSp4tmruYG8mmSYxwwabLxKm5561KmWpztwGgGpQYCRDVuAl5etdmXrd
X-Gm-Gg: ASbGncuqK/K95r8vlVjkzKEh/OwcQbzjV0sFKe5MWSQefTLBgRAnOfztvrqF6w9AJI9
	WYCPuP9GvzGdrq6FMu9+EtXfINy4EdNCphdLpQN46ReyNbFo+evADInceCEzyUEnwmvT1IqtAyB
	zV43HpxE86mtsv5bC2qJ+hrO45K3fnpPBkRNTBy1O1rIUZm/MhaLTXBey9KJgdvILHhPGd4hrSQ
	chrRRq6dHEn5tM7o0+5SzEMl9c1mYSB87mJR+wh+HD8UKQl2AhxgfJDpjod5+uVNcL8wXV8sGTs
	5wzWnblLKb5JpkGzxXiRqkvc6cQMwCKhhXSrI5lWWsSsgBJBMcVWy3eRbaVgzvLPIPMRAZ26ZsP
	DJ4Avp0cpUw4bQbQ8SrKyS8D0
X-Google-Smtp-Source: AGHT+IEghCqMvbpQ7NSTeFZYT5TtvoDl+pDo1IUEeJM38YNrD436IjzQoFGNOiihOzECHF1lqKgKHw==
X-Received: by 2002:a17:902:dac5:b0:272:a900:c42e with SMTP id d9443c01a7336-27ed4a59fb5mr26826105ad.35.1758789296937;
        Thu, 25 Sep 2025 01:34:56 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b269sm1567305a91.8.2025.09.25.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:34:56 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	madhurkumar004@gmail.com,
	shuah@kernel.org
Subject: [PATCH v2 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Thu, 25 Sep 2025 14:04:45 +0530
Message-ID: <20250925083445.172571-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
References: <d8df684e-0c09-44ea-87a4-cdbaf65ab0b8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kselftests generate temporary binaries that are not tracked
by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
during `make kselftest-clean`.

v2:
- Fix newline issue at end of Makefile (caused add/delete in git diff)
- Code otherwise unchanged

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/acct/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..fd14128bbddb 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
 CFLAGS += -Wall
+EXTRA_CLEAN := process_log
 
 include ../lib.mk
\ No newline at end of file
-- 
2.51.0


