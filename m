Return-Path: <linux-kernel+bounces-896022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4AC4F816
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB023BD62A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A52C325A;
	Tue, 11 Nov 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky4/3czG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098F29E11B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887013; cv=none; b=ThMlDWeluJc69s7cFOK+AqfiqCR4xxeNrkFWHShwsiHNk5eu6SqUZgms6kBNPbl0Zkd31c27MH7hOEnZAM0bIR+2Fiu9Q5/dykLggmnDmV06LT0venn5Jg0RM06DDqHYt7qMtaadSCk/udBwUvuvxpbsL5G/yeQ40h/6ETTwuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887013; c=relaxed/simple;
	bh=zh5qlv2jzu5zwpymlV61eYkKmky2VbNHJ19tw5WJCzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gC4GeBvh5KZ5uKJoySvJ0Hlr9EtxrmAcojLSdv8Lg0vSNFxCWGqaYh988J3Rjd/s7RHMQy8tQK2WWlAgYKraH54WXhtTJ89KbDwKGtvPDFKtMO5lyyQBCNLN0n65siE1h9Mh+aQ9NRCmzQiETKzR08jNzRsJLiJNqyOncGn0kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky4/3czG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso697f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762887010; x=1763491810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hecw6SGTcbrCqUAbSZzj/G3btrpHikJf1SssivaJbCA=;
        b=Ky4/3czGv47FCFu5Y9jU/Z/CcdGoWi+T0jaRVGre+5Uq5cfDDf/VVeuhveSejgSY2M
         s0LrgzAN5tn312rxluPLGZFhacDbHJsdxfVjWbVsQA1m7QVsMuyw37jgJ6OYEl4/cYI2
         GD29f5CsisgPiELwb0uPwc9WSHQl5MP076jFPV7HDcZCuD1u5Z0/bwOWM8a0q4pNl5a1
         RfXvYAQYDsHFof+xuEWMWgkQAD0DhHgEeQSICIRRz2BQ70OCp6zELB5rlpPADZeDYNDK
         0vuxETY/t4k946kiZg7jWbF+8hiJDfHAuMGMPUpRG7geU8rl3EllgzUPAtR2hRyD062F
         Lx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762887010; x=1763491810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hecw6SGTcbrCqUAbSZzj/G3btrpHikJf1SssivaJbCA=;
        b=NDEsXnvJioLzyU1uYnG5COduPQlxdwl444D4N9CfUDNBfnCgppO9/2beDVGtOtoKTC
         VeyoB/aH/h1PqMtZId+EbAF87s00KMTzLumTNvWdsd7POz6SwumKQFxpVfBBE/A2aujk
         /99hKqmm9Mxkf6OFuWw3bOfaiIp6xrcBO5vIk/8mo4LXUpY2BzwRIhivRe1Li1iuyi8s
         hbGgq0HZ/xN4PWcX0VQ+ytHd6EeiEcbMul2UskiQ29YI2vKeqBf96f4exU9Oq8r6sD7d
         OuYnXoLnq6mfOKV+Vup1lhXVD5El6v33GJpbecVo8tIW8Bx6adnhSsQAbH7/wjFVyTA8
         LNug==
X-Forwarded-Encrypted: i=1; AJvYcCX6776eEusg3vO16H4FTlZwTWUw73LZn6YcDVoyAuOuNqeQHI9lFYPw1+2eG1WpZ7NFvkKsZDHjwkVjE9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZPRDU3AIWg+td0rRQ+dhY2ghMKWxUbOKEp0cI8zW5bbg3xq8
	GXHoC4QwEOhfofeIpWKI2OxiNMFrofYYtXJYjBKi2B4aanIpu2AP1dRV
X-Gm-Gg: ASbGncufkCC1qnaGyH5cxjQCbebQxxODuhNzghuzHEDDsOQXQ9IcFJngV3VgmVPmDTE
	NLiXa8g02fZCvaigbqMh94kUXQa4w58trtbBOTbJzuX4KAB9AX7ddkTqc7matWG+ZWIOfV/Usfn
	/pT6uE9nLLr5reMW5QqUND2yIJaFZoaRaWVMMCyCq7MvmpTe6JEwhmJkwY8PezZ2LlpKYZEL6+6
	jItM0BZhvKrg0+0nU+yB3IhYDxwb36mVXaT0os/+x1+/8M60F91DOcSA9Mvrkm/oc1xGb+s96Q2
	CyaOXwbDsgnUNU+Zf9ryjYZZRImLbSZEEQO/aUKNEznT3JtgC2D8AzgdJumW0Whbwrtmm2TTZT+
	UTYQEbAe+GoXIyrf++rBHefNpRpUxHkPeoKkhYcHIHoA/nMUvuoNaVLIN2/K7Tyb4kCMb/9LzJj
	EeUCbsBhzLjvOJ
X-Google-Smtp-Source: AGHT+IFSvM2CsB+t9jolqji5xVyqJeQrmqnCERVjosfYiifdGVyx1RnjwV0p/nlqbwxmejN0WMpo8w==
X-Received: by 2002:a05:6000:26d2:b0:42b:396e:2817 with SMTP id ffacd0b85a97d-42b4bd9b823mr211802f8f.40.1762887009974;
        Tue, 11 Nov 2025 10:50:09 -0800 (PST)
Received: from osama.. ([41.236.140.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm18787142f8f.0.2025.11.11.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:50:09 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] KVM: arm64:  drop sysreg init error log
Date: Tue, 11 Nov 2025 20:50:05 +0200
Message-ID: <20251111185005.12842-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failure paths inside kvm_sys_reg_table_init() already emit
excessive error messages. The additional kvm_info() in the caller
is therefore redundant, so remove it.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kvm/arm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 870953b4a8a7..af2fe3cb3356 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2844,10 +2844,8 @@ static __init int kvm_arm_init(void)
 	}
 
 	err = kvm_sys_reg_table_init();
-	if (err) {
-		kvm_info("Error initializing system register tables");
+	if (err)
 		return err;
-	}
 
 	in_hyp_mode = is_kernel_in_hyp_mode();
 
-- 
2.43.0


