Return-Path: <linux-kernel+bounces-744827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A92B1114F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96A35A74FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50A2EA733;
	Thu, 24 Jul 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDbbsQXz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B92ED151
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383601; cv=none; b=XOUn/rCnsGqZEJHSq8ikw55j6eYR3bnNHH9NXn8v/9jItSwG+Qn3fkT9VjavGfaLvUDEfD7GAXdB3rXynSTGAF42oYdRZHZ4mYzMyQ3uWghpCZVTLZQBJXPWrKqHYdNy/lmvraM/iukTCWzq3o0YB/3oxcSm1kwo+zz9H5m9N4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383601; c=relaxed/simple;
	bh=w3B6eMOHBjLahJirDSZ+qk4aNUA7eTY19kZ8xkUuHVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhOrzzAg076KS5FOpDbeQKN+HlkobEsEAH2v81H6vCuiCjPLh8IXMJzaDrn0s7TfCO885bKy0Uhc+nxjykh7Qemw/thg9UpREMVsZiUiyFMS8x6fjDxUhUae7EnrrU+/EoA3kaqroKAPRcgiolDrFzfCUKXvt4qlXBB42dHCapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDbbsQXz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so1178156a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383599; x=1753988399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=MDbbsQXz7SrhjWMZtLw+00dvixeovCdUXkMAdtUcPQ95XFzNEEa/3o///0vaxQ5VJ1
         X1NWrVjZPYnqDnD/pXyXhsJG7bJA+YkW9wYf2o4cJ2JLIB67pMTtylQt/pLYzugU8oMg
         yOlP9dyf4gOrKc/iY09qha1qK5NNjTXPf3uDOk9Rhaf1YwIgYqWo2n7i2Il5dmlDZlwJ
         7h0Nm5Woa9hMcbcWyrYVALMTT5ak1YTUJyxkblu5tdiT9SQ1vBcSB+BCR9WIeSj9ftrC
         lRMVlJzf97T0o+7NoIEYTN+uPiWcA2oLu9Bkt9vcNlq1ymCqRbH9gf5ia31xNlXc7emZ
         Rjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383599; x=1753988399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=i/Zwi3j4ZtMR/XAjidXPf39zik3QCSqN35XsSLwtUuAltgMUWCZY7YDMUR2UtGtVhX
         kWkUdkUukSW3Td3RdvpPNxBxSsoiYpiqrrj+snPFnDalhWnKs4KC+zQqx+A9yzRXDMYZ
         cUMaici08K++1EzBkZneV1AfX4QPXfzE9VsnVziDvw2FaatxK9vL1L5BHBDrGLx6dFUC
         liP/HNhfIv0XrUGb9edlhdqjQxPwoHbCY0mNebhQgIXc5o5bZrXXtI83rT4IMfqZfUDw
         +vs0Rtoz0/mWO/q/GVjzpbBN4I+KGXEYk1Fkrg2R4Xp6YmAeqjHvQp/3a4vmD/Pw1xE+
         VWlw==
X-Forwarded-Encrypted: i=1; AJvYcCXVzfhepqEQN3ADz6/zP239InwAoLTqYUAdUXU4/Bd3KD2190CS6RxoIjik18AKp0zoiDfavk/qcUdjwRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGHLdsCTdGN2+HImr3SqnqmFlQe4wxIpZF5g6x2D6oBU76lbj
	/EG+gH7LFPTYLSZpRIWrelRf0Y7Y2O50KvmDRjGTJq51Y57Dgs083yL19Hf8Z9/mIXFrMqRP2ti
	CKRx8iH9nDCQUOA==
X-Google-Smtp-Source: AGHT+IHdSmYA7tBV+nhnrXBegpyUFMJCJUqsFgS7Y3VIienq0ec66CAODnssF5FCA5QAA0NO/7OfjfuiK5hPRw==
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:312:1af5:98c9])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e88:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31e507e916emr10640089a91.33.1753383599400;
 Thu, 24 Jul 2025 11:59:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:58 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-5-cmllamas@google.com>
Subject: [PATCH v18 4/5] binder: add transaction_report feature entry
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Li Li <dualli@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>, 
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


