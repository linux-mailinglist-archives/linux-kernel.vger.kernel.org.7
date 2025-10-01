Return-Path: <linux-kernel+bounces-838307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C0BAEEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D544D4E01ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9872367D1;
	Wed,  1 Oct 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY+d0cNy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7122AEF5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280417; cv=none; b=mzv6rrGAkt0Hg7xA5xE2d+jC+YUhLLexJwUmcKB/XLZrEo//ZGHDgPNK2kX2OGKaoM39NpgYvMdKU0xyWEvOc6wsSJ6opCOU5Zn74FQSpGY9CKGyV9KOfJMGqGtXukDLJpFUPc0pEecZCj6+hDKkbaR0DDwYaE2YAlxcK8xLtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280417; c=relaxed/simple;
	bh=6jXxieDqFD8fazb/6FJlIG0MiiYnqGvFkdIC+NnRbnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsVwqCayqkjFzWyL8dKHH1JxbRZ064LpCiDyrCiD6U0i+4qPCUtPpy8eYKufRgG06qF4wFIpi4NNMqKfabTsm99d4prMYt7JySGKRcYh5mblxVWHQ25qLfKacFU5rL90mao1uAeXcisl92Bdg1mGJ6M+CvexxL9hiygiJ2uIrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY+d0cNy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso44782115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759280414; x=1759885214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCvWtFisL/5u6+Z59vMZno7OXVHIR/I5WLUeHX/+HKo=;
        b=YY+d0cNyzGEQfdBce34CnY8Y5J0nP6MHNXNoHn/YixzcOFLd+SR9NgoJBy0PPOURB2
         JXhjTrcMblGwUX9mZIXoftj9SBuwk8ywxzgcHZu6Pv2+xFTJ/91jHS9DfI4vqWfVJW3b
         DPujH12xm7XUmqmzwWoCxs8RGWj6zb/aM6K8bR2cbyURjTErna8D6kZU57Xb5zmK2GBF
         L30jTbNB9IZRMRq7RGtyzCC3+nBhl1VqdeTeQYqGKADTgsk0vGmd5So0oLd5HRFLRuQV
         ECwZPDHPsfBMiXtCh4J9tJd+2h4RkcoMUxYaj5OSwl+2VOK9shk1pNIHLZxwlvCGS6de
         d6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759280414; x=1759885214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCvWtFisL/5u6+Z59vMZno7OXVHIR/I5WLUeHX/+HKo=;
        b=gmyHKvuuylJbtBjfDP4u7jLb68HqiG68u3rxxatX43N1J50iLErLOF68N6+BszudP5
         brb/+tVPkZPOC7LYnDL9qQPUQdvORrgThD9zJMCk6iW/X8q/DgcQEg6REs0PYzwj4ZIo
         qG2J3fCSMd7DlF5UZpUNA89nPFhYDEKWJhmoGxFJlPun12WTwwOIz+hPBv/TJEiC0owi
         5o1wgrPCfNsSX15n7Yw7UTDzlQuAhej5zVgt31qbLz8kl2h5QNfdKdHNeM4rRFWWj/cS
         OI5sWWDbp/UgO0GhsUr0Suodsoc1Yxn5xGnM99cMDkLbYSOD2YuYUABSXGii4XX4MayQ
         yk1A==
X-Forwarded-Encrypted: i=1; AJvYcCXX7qPoKyKAppkrcjf/XXWD+TYLL8N3PSQFwnK2xxPQriJIJG5m4jz/s/NwhobW/4Cz/9Qhy7DPDV2V0x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynm7vyvGllP3XjvI3BQAutLPOEmk7NUSvBrXlJwXeVpL4fJo1R
	AtSFnmOOoPYCJYbEt7J2rz9tyMhzkdOQp6ZL3lDhPX2ZwhFjRyRGoev/
X-Gm-Gg: ASbGnctc/OoDQ1I3qv7/kYiqiHOUm/XDxtK8qsIYBwr79d9ujeBT2wc8UFihVs/1CgA
	SALfBAzkTMjzVWTw4Du1EH+gCYVV1bhTTOADp1e92FR5X2Btp27NGA999cuwp7cdViCUJ0tvXiT
	O08eOME7MisDe5/FweEkNTLVP++fzycC9PAEnJpEru71/UPakboGbtIQ4b5UMmcVaDneo82kZnc
	0IDdf58yyDS81etXiFVRTHP+2xcOom+/JKmJsTls2HpGNtlN387kZ6RPobcpU1LJE1qph710FTg
	5HDHS74VB4VoqHEakhzVzbAYwc7/I9AMg3t3QzQq2hBViIhRcm43BC5sQlNASXZIO/t8PNt7gD0
	TTnN3DxvF+QHzXG2FIx6ffg5G/Ud4G9KPTgLauWouQsdwbSr8VFNOc1YAEbHb9t9a5CE2xXKbMt
	xEu0gE3MfPoHWnSyt6Y2athWc=
X-Google-Smtp-Source: AGHT+IEKINZ8voVJfqELLMtiD76UXBJ16fK/Vnhpwcd4y7UWCbT3YRZ4FZ+yoP1+6vpFBcsBZnBwNg==
X-Received: by 2002:a05:600c:3543:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-46e612e3f92mr13029195e9.37.1759280414007;
        Tue, 30 Sep 2025 18:00:14 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b9c88sm14576005e9.22.2025.09.30.18.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 18:00:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: assert on ->i_count in iput_final()
Date: Wed,  1 Oct 2025 03:00:10 +0200
Message-ID: <20251001010010.9967-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notably make sure the count is 0 after the return from ->drop_inode(),
provided we are going to drop.

Inspired by suspicious games played by f2fs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

boots on ext4 without splats

 fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..fa82cb810af4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
 	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
@@ -1893,6 +1894,12 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	/*
+	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
+	 * Note we only execute this if the verdict was to drop the inode.
+	 */
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+
 	state = inode->i_state;
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
-- 
2.34.1


