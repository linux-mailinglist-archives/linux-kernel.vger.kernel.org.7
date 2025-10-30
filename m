Return-Path: <linux-kernel+bounces-877548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EDC1E66E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF4D1891FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280232A3D8;
	Thu, 30 Oct 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfVXhoZu"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF771F4631
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801496; cv=none; b=AR7KODYI52IgfZj9ifxfEhd3KiGli0ha1UH44u0xD1Wtvy42dsLx9dKz/NM6kmjADcWyvzOzBaNq2YCoLOaW9vXDJntoIQRuCv5gahXlRx4W/aoDPEcMUUEgs9e8bwfq6thAz3eBy+SGtc7whBuUEbBpOhNXDMD1OUydA/rv6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801496; c=relaxed/simple;
	bh=yTB2Ypsw7haBzkxm1rv/lmJKPxOzHQ8R5zcpQamqQkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvunlFjy3qXtHXJpZopzXIRK+Dd/i34YK+QgxR13jKSdk3kZxO0rfUNaHLdm6wA+AEPzSs1+C3CFtEeO98IEo/MYg8Rqla42KlOmiywFSRAu2AwA1mfCp0pYseIV7hXOE/a+KIsSwnxUjfDtZIqchwOS/McDw0qOhFFFUnOZHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfVXhoZu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7810289cd4bso768681b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761801494; x=1762406294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74tfITgN+jliSCJFJEsvOUjVL101aogmvXZmW0Fyfy8=;
        b=PfVXhoZu69k8RxK/on8OOFYZeTwNGTCM/LYeKCRXkjtwdnePnOr0EsyCmV0s2Znxgg
         h2drZpduXpahge3oVBDwptf8J5LjdkFH8/LcrQmttdzdMnhT68EvWzlf2xMWV2eSpb7F
         0p6qixOewFa2NYD6RyQ5dm64GOeDmhh3w52bTImuxgeLCJnk5+l+jrFlBEVzawYUYPFi
         YlM/9r7/3/98XmBPTyiiGfp+dCCLMiea3vwJ7PjXxMNqPgsp110r+JSyUoYA76e0jkx2
         2/SbNhJWD1NkdQOlV+A+eOTM+t24rdI2x785HRsWbPBq0sMos1k5NgVWty4luMkhnujd
         nbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761801494; x=1762406294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74tfITgN+jliSCJFJEsvOUjVL101aogmvXZmW0Fyfy8=;
        b=nBOXbFdKubi3HGKboR2JfdRz7GIcLT/8hKWaG+mD46dAUnSufEs50NFUC16bug1jBQ
         +AzzCM/6NDgwm0Wysu8YZtYcc5qAsS6jZp14NCfozSGnFXvUbknftR8smn5Ee46vAK05
         xC8c/+h2CcJhPPXPFFu+jIC8EUMwo2KcL1GrVpAyv0Fxb1qXeprcZsTqiehET/DNOpgo
         bctuyWh4Bz4EFQNeb4QOLG4QMorD/7XpinMplCCRjX1UE05yVmHnOiPn4WTSk/ZMpgyZ
         JP3sbF3F0w3h+I3BZfsr4diVcTNkLpfkaO2nC1DLRzooAG0cWu8ypi7YUrpukcUd7uIP
         z7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUnTd1+lsEhISvBTXdzJ4H4afq3osgFx9HaXG/xsEYXDhE3Xlvco42OplkYQ/ZMo16Sd1GRLFB5a0VoQCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLvm6WLub8dwmILMRFs96cxxla0gO3GlPx4SOIkdJSZiWVKy3
	t/HrBEKC6XzYkLfDl6Lvm3vdahgLwsxRn6r7fimkOd1C7Z3a5ioKYykX
X-Gm-Gg: ASbGncuXN35m5qAF8Bb+0uXSi7v8NxzyNHRmxNO5UnWcF5XVgveWE6sFLeRJ6Xd68cW
	DUWpESXXtgkRJPM1IwN4do14CyrBCI4eQuy0/Tq8AgYUegoI7NxbvWKtPsEAnf/4VXiReNZuQ+O
	xKtgRxc13aePkrG5NOhwiFDhARi02IrKYaJSuY0J63FCpjheirTQ0hTky52GzPdGbMOhhD41Ztf
	hDxfSJ353/XM2pYTo1ntwTZuHAtM548da5tQa9g9hb75rWmMvUfEf95G5lZoDL0Zvc8SRs4lj38
	57gU6qjY2BiNiEdXWgSwobqIBtqz7uINn9QbtgDvogj203bZ3lEZKJtPCLHp1zWjqTW1XNzVCp9
	hif7Ni3ev4BOMrklRtOnVVyVqVmqdoT7qVEPbGdHB5l0uyvDW6sAn/M9gyXzCZH5lbs0wch/RMT
	30JC1tESEKy+fULmBbYi+L8RGKVEnJqwrP
X-Google-Smtp-Source: AGHT+IEhzK1oEYrUQqCBBSqPHXsRDk4cferL/O21CP4C7/ru0ksQFcHNu9ziLSsqEz7nZQmTjmZx7A==
X-Received: by 2002:a05:6a00:3988:b0:7a2:183a:924f with SMTP id d2e1a72fcca58-7a62cc6de7cmr2012742b3a.31.1761801494420;
        Wed, 29 Oct 2025 22:18:14 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm17445157b3a.43.2025.10.29.22.18.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:18:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geliang Tang <geliang@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: add input size check in ofdt_write
Date: Thu, 30 Oct 2025 13:17:55 +0800
Message-Id: <20251030051759.93014-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")

Found via static analysis and code review.

Fixes: 3783225130f0 ("powerpc/pseries: use memdup_user_nul")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 599bd2c78514..b6bc1d8b2207 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -366,6 +366,9 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
 	if (rv)
 		return rv;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	kbuf = memdup_user_nul(buf, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
-- 
2.39.5 (Apple Git-154)


