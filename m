Return-Path: <linux-kernel+bounces-878631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD046C21226
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384423B4F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FB366FBA;
	Thu, 30 Oct 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT9fqYEx"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4E2E8B66
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841254; cv=none; b=PdQSm6dC/DHw8u58zBg9Zq/WrlD73FJ87VwUWKU/yCADyjggm0A2Yy8H3p7pfNlvt+I5JZFV6GnyYPE5aDi6W1fcZYBEOnGxuHp/QjTIqyDSbpCgMFwyeZ15jkyOi+zAYDDkLFOzm98qY/atjjeBa4uqziJHxiYUPSBkiwAetew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841254; c=relaxed/simple;
	bh=yhBI48V0wmlBwA6nlzAZ6b3XU7gtXK748W7KsFub0fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfvQ1LsrU+76Rbcj6jTmohpEKQVIZFoRVgzy+CrvRpx0paLxhe2iGDm0XsMXxpX9uVjB2iNrXjKZ7flUVL0XTjxkA+Mbh7qzG0Iof7xGKNauVq7cqNf1Gok1odK74s9ZhY9cUlUtA+vsH0twApqkNsDyCtZtsuDZxbPStXwqtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT9fqYEx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so1704364b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761841252; x=1762446052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr4bXWVpbyanB9ZmKdE3YKsrObBxhl3NbLS1jm+yp90=;
        b=JT9fqYExO84Tph7HSEdypj+icxo5p7hYsqU6koEg3OjUY8zdHoA5mGLoZrpx2MBfz3
         YiefvSO3z5yYhTaODh2tzGZy2RrNZw1lWTZXhDAr+y3S+Py8Nuwt4HbFbnz6i+eqTz+x
         qNLWsPHsJEaOK6f0Xbi1NinUPX/h/S11ctwDmE6/LrvuQxZK1SaC05JBN94CQpQqpuqM
         /usfPOZemkQqXq8AxnxAO5G6+NNuf79efOcpEuR6zJFythcDowbgWIkfbGvF6DdwT1Y6
         Ox4ClFJrwxflX656uFshFEKaSUlme453LdFhKJjebmoIOw1xrzMduRivwvh2rAzh8PRW
         3XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841252; x=1762446052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr4bXWVpbyanB9ZmKdE3YKsrObBxhl3NbLS1jm+yp90=;
        b=REUuvg8RM7JWSrorEJR3KfZQgOxbivh5vxDlpKmaJzH3H8rXxqy1lzbggJibWMsvSW
         7PLGk/Oy90NQK2OvjQP+5Dh19hE7PCBOwlLlsV2xrrNRG64rvIgiQuwkMeJw6m+mmIPA
         dJdjAL7R16ehOfWtShJcPHghY+RmBg4WqCmNJ7YRnlSYMwFsHy8MBtfRFoUsNjQOrYkl
         TBI150D3RH1hW+vjjWmYcdUJWVeL0426Qb9kFOXWTsI3ZT1VbvBA8JSYLbpm1V+b9u/W
         WuiR1CBLhJ3JENSfbMchlaKExNy2FitVSgyYklMa/vh+ZUa3kEtwOeOlzsttDKScvGAP
         V2PA==
X-Forwarded-Encrypted: i=1; AJvYcCUoBgzNSPIHHc9G3md/6twMoEQdxUKeaO+F+TCOITzlFoVe3Q6kQ4Jvv3+cJRpW3GjSEdgMdCizs4wY6QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5lNfKakJtAPAR/jHWSFi/EHgf7Vf0DKeE/79eLaH7DfrolJP
	AzF9VUX09GlABK5K0F8sQAe2XdfL0GxRQHQlBvloBTdQcertjQGUYNW4JSF6RcfR
X-Gm-Gg: ASbGncueTMW7iEPIuyd6IqtYBCbUhKaCgw2Pqs7QI9dxLUM+wtE4TV4fpQsvjxsfami
	eEb0fK0wPadKc+p1bRPgWitPoJIqcgdXP3bOOn7CTCAD1nLhod2GdFOed8++4NafTVgWUUp26UL
	Y3eYYa30DkSmFjrLsbSMn0vmixkMsw0OfGLbqRRrQojQEKANq2I1A7gJEXS7r/t0A5++wWPKHhd
	YC9Fd9B+T0kCRvTeof2+ht7jVnxDWeBD+h1gMNO3XYZLK6vsA/uPolU3Gh7uhthyQBKap208LR8
	85RIq6NqfJ0v5iD2tj8QCMO1XmXyJ3pLMvU0IOcjrNwwE8Y7AkTJkHnniKI2Zr98cVdkQ2e4fMD
	+PtckceT8VSahfs2R1VmQzDYXcsSxUr4I+RrEiH9YUbBMqQ+FFH/yHF3aAk2D+2q4bLx4tdkUUX
	fwLXSjZqMRCA==
X-Google-Smtp-Source: AGHT+IF+ELkof7ycUjT9m5QQlipuUDB6aaber6YXfw5ImcMWfAD7q2Det7dq77zeD9X5Z1cHTeAHSg==
X-Received: by 2002:a05:6a20:734b:b0:33e:6d4b:608c with SMTP id adf61e73a8af0-348cc3d95d9mr217460637.40.1761841252189;
        Thu, 30 Oct 2025 09:20:52 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140530d3sm19534338b3a.40.2025.10.30.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:20:51 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	YangWen <anmuxixixi@gmail.com>,
	syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Subject: [PATCH] [PATCH] ntfs3: fix double free of sbi->options->nls and clarify ownership of fc->fs_private
Date: Fri, 31 Oct 2025 00:20:45 +0800
Message-ID: <20251030162045.27813-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 02f312754c87 ("ntfs3: fix use-after-free of sbi->options in cmp_fnames") introduced a use-after-free bug
due to improper handling of sbi->options in error paths. This resulted in crashes when superblock cleanup
is performed in ntfs_put_super.

This patch ensures that the options structure and its subfields are properly freed, preventing the memory
corruption and use-after-free errors.

Reported-by: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Signed-off-by: YangWen <anmuxixixi@gmail.com>
---
 fs/ntfs3/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index aae1f32f4dab..5d4ca4c10116 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -705,7 +705,7 @@ static void ntfs_put_super(struct super_block *sb)
 
 	if (sbi->options) {
 		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls);
+		kfree(sbi->options->nls_name);
 		kfree(sbi->options);
 		sbi->options = NULL;
 	}
@@ -1246,6 +1246,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 	sbi->options = options;
+	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
@@ -1671,7 +1672,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 out:
 	if (sbi && sbi->options) {
 		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls);
+		kfree(sbi->options->nls_name);
 		kfree(sbi->options);
 		sbi->options = NULL;
 	}
-- 
2.43.0


