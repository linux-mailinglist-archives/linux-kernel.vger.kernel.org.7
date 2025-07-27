Return-Path: <linux-kernel+bounces-747229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99146B13133
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B2B7AB693
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D02225401;
	Sun, 27 Jul 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgvT6aLX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310B220F49
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641086; cv=none; b=TEy+8WsgY6IEthtDJqZZrAWLYem21oNqkt/o7LPq2MiwsBb6ckjlM7/Sy8E7sTFgDfaeuwFMTUxV9nSWNhK3U0TI5nzu1WW1AIrzxqEtl7r+EZgkl0MdfmolB79NKn81Et6ecWT/InymL/9Ap3uXH3Svw6H8wo2pYzTWnKQLQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641086; c=relaxed/simple;
	bh=w3B6eMOHBjLahJirDSZ+qk4aNUA7eTY19kZ8xkUuHVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kzs9bjzqm46C+9ATos+dlWX+/xn505eeYoUFa8q5VsT2kruKUQ8ylI7/3YBZz3UYX7FKX6SrJmdafku4o+eoa7u8HlWlUy+jmgFFns+f1aPdst2qffsVxTNH0h7NBU0jYdY8+t3yny0HKAFkfW3WzM4izxqpGY8ppjxEIUOCDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgvT6aLX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so2316319a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641085; x=1754245885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=LgvT6aLX9lsPIXqZIjYWKgCOwnW1+MqOHBPv03ZfDNxQrvhaqAKgV3K9AHTcsRRKt4
         Jb17xAjhTT3N6ZkmwQaQGwsvrjIgalfGU7FWKAK75LGFTONRw0XSYDXKv5qlsEtM/AxA
         M43KknNvk8lWHLNKMKDoYbVTqEX839w8w1dngBoBxbmhfvkLnUcOAdVHtSHRS74l90Rv
         aMN571ypy4qc6B5Tru47ixNonbgxAYtcEAJmAibNmX5UA0FkmXNVQcYXHgzUKqL+THRC
         6iOu82W3MoHCW65t0zffOR0n0sOaMA5aMXdEssqAljBvRVPOOdV0bRFbCJ0j+dJl0h7J
         7r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641085; x=1754245885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=aGQ0G3j0xqA9HgucRpcirVTtb0h9zsoKluav32TF24i+e/sHBMgQaEBNHRfkTpQPDX
         3dYy9lax+/LGEFMV+zVOcZ+JPN2qZ7kqR4n/xEeDWpN2lbVyx9QVKbxqUQPB5ExlaxSq
         SSoX+nN/d2J+0gZfL/hdulimjdD3UewIXmkYKd2LCm37imb++7zFTwdwvMdTNPjUf4ea
         weTocLfRvhU7gUexxRPlox9aNvg7EVc+t4XEOmD4hg8L5hSu28ktpPXAh0Pv1Qw3IMKg
         +JwU1+8tLW7k2FHQSCzwYjwcoAstCeB+iWA7g0G18e4j9JL7ZRbkNFDmnFvw51paqUk6
         iq6g==
X-Forwarded-Encrypted: i=1; AJvYcCUnsZpBrrYpuK36534FON6kydEKXTnp1Mwy9zItMGQu7y8YUt8x41W34ZnVEML/Vk9zTStK0gBC94COQ2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmA+zIqe4PvsOmmEmmyoANnDNeTOCIJbIhN/1l2n+4Kh4MLzga
	IvzZTV6vS3jquwDQdJ38OqeyjefZ4l6UtEoAQR2sgWAn1cryN6Zqdi0YRQ0xvKTu2cflF+CLd4K
	lqEfBpQcAHyEJvw==
X-Google-Smtp-Source: AGHT+IEQHqngoylopHIEAU2iEAMut1Zbzg+THKSOuB5j9p86YjEG5k2zNo4IKpW3ZITBc5cTnIROU4PiqQ1e0g==
X-Received: from pgar12.prod.google.com ([2002:a05:6a02:2e8c:b0:b31:c7e5:6665])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:430f:b0:222:d191:5bbd with SMTP id adf61e73a8af0-23d70217188mr14873947637.39.1753641084705;
 Sun, 27 Jul 2025 11:31:24 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:07 +0000
In-Reply-To: <20250727182932.2499194-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250727182932.2499194-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-5-cmllamas@google.com>
Subject: [PATCH v20 4/5] binder: add transaction_report feature entry
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Yu-Ting Tseng <yutingtseng@google.com>, Li Li <dualli@google.com>, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Li Li <dualli@google.com>

Add "transaction_report" to the binderfs feature list, to help userspace
determine if the "BINDER_CMD_REPORT" generic netlink api is supported by
the binder driver.

Signed-off-by: Li Li <dualli@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 4f827152d18e..f74a7e380261 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -616,6 +618,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..39a68078a79b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"transaction_report",
 	};
 
 	change_mountns(_metadata);
-- 
2.50.1.470.g6ba607880d-goog


