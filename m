Return-Path: <linux-kernel+bounces-838556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6FBAF846
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B78A1926BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5E279355;
	Wed,  1 Oct 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNlXwBQ5"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C12571DD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305510; cv=none; b=nnN2qyWuOG0rZfbxjXmwqm5WH+LyraSjqj/wW4dHwaJtTTphVNcOSDoQZgp4YxOfAscmipr9x5I0RdPvaERTbEEZhWVQF0P+KQQwNGT93U4LoHkOta7GzrNgsERq1Mn1b4q5v8lTnS5CiXP8/Hylp/RsSSJB1+D2piYbPcjbJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305510; c=relaxed/simple;
	bh=N2I1H/EgePZbtvBo25uP3wJB4pP+Q3rAkJ0WZH591WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rw+VLrm4ELOr/mGn6pLx60esfKbJbaHOovIVPgmKwFyCp8+1QN8AkFkYCmdVhr4VP+9ERKzdZ6fQXvzdzCkJ6WiKFgr8yMRYZT5FPMp4jBFDdUygywV0vVKuGHqLF3clOgfKB6PSVvItp/97CK2SnDxUtPoQn3l+EJ3sq/2D9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNlXwBQ5; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso6025381a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759305507; x=1759910307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnIZ0TeoMvk9CCEY2SlnV7jnxp2bLVOIPlczZP3SYN8=;
        b=TNlXwBQ563KTLHRxyvkdiTAlr+jU/r6+RC+t34TPgvF8pu98+G+jWHyTSBwNVrIhh+
         0f2qyJYyR+HZ60l5rwfSABH1T9Kj6KyzLJnHpeDw6ukCQwovDhrFqSu4+eBqGl5tuo98
         UmC0voXBVTUo1Chd0Dize5mJ++KdWmkd7mfhZdc+w+t5fd69ntHALQLVeOAvBzkO3YGo
         ior5vqLbV1QVmWr/njikCXIH3QA+UsuNLdhTTLkGqte/zUKQXTI7zJrXjSK69vNvdPGw
         FfE7B9hgX032B4ToyT29/61PWL11KR1D+tNHcECfgdHQiCC5OmqyEIp3ouWafZGm8WoF
         gAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305507; x=1759910307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnIZ0TeoMvk9CCEY2SlnV7jnxp2bLVOIPlczZP3SYN8=;
        b=B8vBE2IZXx/ignXkQykaGfvE537fAUa/Myu0A7eBQ/0/anfkwN53ZfFt7OzDBgWN2l
         f9HSIfrOhtNQZFESahXxXI0dKqsTe2PhMXQoWSR3KucOdS6pJIvgw+WSoS8pwL9Ghyuu
         aWgj+7/ZhqSh3undH88N12Ql7rSQOzixttVYT+EJOvsPFWIIlRuJy+cyIZqirml5dwLA
         EqXXrhDEJchA9gpdRnRBRqkwrNZn5ugq6ePvyci1un7KooYbZWWWUBLsH/qe0e4V2Tzi
         sdFvUAQ1nK03lo+Z4BeM5D9kDUA3IDg8Hg26t5il50sPEFZsSrnXiHIVxp8O9lYa77RZ
         RnaA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1525s7gqrPTlr9LJdenRyu1WueSIxtVvMZluMAd44yyYQDCqoOGDYcVv/8jqGun3hGR4sOWx+5TOQEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8Kuu9a8bZmKoGLHjm3PULKiVaUNjPY5wp0eTYhyc7nmrEUBE
	gV53jw1EZ1hK6l97NsSO7s8Xt6iRBuFF7Dp/yCj+eVLI5RJwMp31MizP7yleJkQRUPMcQA==
X-Gm-Gg: ASbGnctNZ02goHl5MZlqWwPEZBKeiVqHj4BbhZnIZdDftuwvzYctaKQ8oCO2Rxx16Yc
	VMqUPPFJMKHVgJThRW6TCimWQFinS5aB1KD0aN+DI3Wqf0imYtfwHAnQPJpowlBPhy5q+azPwa3
	lk2fMys8KM/nykceBMgagXL29vIQI3+mC4iCYIoIH+FSRFGoJQjvdZUJQUsG5jXyExn//P+sp4b
	fryMYbvqz91zMX2N2Aa8o2G3nImI+haZa0Nmh8Ewu+jbsQk6mwT/QCSui5HO9O0PKn8hdlR34Iu
	i4cMO4RYihUh9e42RolaTK0K5g2lwY6tHjCHt5/vQynNL3G/koIwY2KalOXpEdZEXFEtWy1fipY
	7AxpHmswJxGufpyq5dQ+YFzeBOAEhtA==
X-Google-Smtp-Source: AGHT+IEgSy3v/uPt+4KvsdPnlOkJBed4MJ2OgBhCzYLrYHtZnwDHH0pn2KL1G/JaRiDosOce0dljsw==
X-Received: by 2002:a17:903:40cc:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-28e7f16795emr32870995ad.1.1759305507128;
        Wed, 01 Oct 2025 00:58:27 -0700 (PDT)
Received: from archlinux ([2a09:bac6:d739:1232::1d0:a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cfdcfsm180806485ad.26.2025.10.01.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:58:26 -0700 (PDT)
From: kfatyuip@gmail.com
To: thomas.lendacky@amd.com,
	john.allen@amd.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH] crypto: ccp/sfs - Use DIV_ROUND_UP for set_memory_uc() size calculation
Date: Wed,  1 Oct 2025 15:58:20 +0800
Message-ID: <20251001075820.185748-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kieran Moy <kfatyuip@gmail.com>

The SFS driver allocates a 2MB command buffer using snp_alloc_hv_fixed_pages(),
but set_memory_uc() is called with SFS_NUM_PAGES_CMDBUF which assumes 4KB pages.
This mismatch could lead to incomplete cache attribute updates on the buffer if
the payload size is not strictly page-aligned.

Switch to using DIV_ROUND_UP(SFS_MAX_PAYLOAD_SIZE, PAGE_SIZE) to calculate the
number of pages required for the attribute update. This approach follows kernel
coding best practices, improves code robustness, and ensures that all buffer
regions are properly covered regardless of current or future PAGE_SIZE values.

Using DIV_ROUND_UP is also consistent with Linux kernel style for page counting,
which avoids hidden bugs in case the payload size ever changes and is not a
multiple of PAGE_SIZE, or if the kernel is built with a non-default page size.

Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
---
 drivers/crypto/ccp/sfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sfs.c b/drivers/crypto/ccp/sfs.c
index 2f4beaafe7ec..3397895160c0 100644
--- a/drivers/crypto/ccp/sfs.c
+++ b/drivers/crypto/ccp/sfs.c
@@ -277,7 +277,8 @@ int sfs_dev_init(struct psp_device *psp)
 	/*
 	* SFS command buffer must be mapped as non-cacheable.
 	*/
-	ret = set_memory_uc((unsigned long)sfs_dev->command_buf, SFS_NUM_PAGES_CMDBUF);
+	ret = set_memory_uc((unsigned long)sfs_dev->command_buf,
+			   DIV_ROUND_UP(SFS_MAX_PAYLOAD_SIZE, PAGE_SIZE));
 	if (ret) {
 		dev_dbg(dev, "Set memory uc failed\n");
 		goto cleanup_cmd_buf;
-- 
2.51.0

