Return-Path: <linux-kernel+bounces-797647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D29B412E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9541B24428
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B82D060C;
	Wed,  3 Sep 2025 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LuGX1/Pn"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504232C2361
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870022; cv=none; b=WrZDFXpkraXA0q40YWVb7bh0T69FQRz/SJUdFdOnRqJbObAD6DfmzfjmPhthJv6k7+GEugEfDmhLmWzGKE1t6Xt4XbVCrTkGwDYSfdmwVKfhwcI6wvXS0TSX5BGCQpG6VYaGfN4IkGCMsJaQa/60oqRcS7YwGNyucml/hLw1ZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870022; c=relaxed/simple;
	bh=vT37VwGjZOyCl9u5Iz9sHTvtTUWCCe6Xb+1IziJLUvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBv/5bQMF+GScTCouDX2jgqcTkMtUQ9CY1PGT40LeiZt6Cyav84A/KqOiAfdUF50m/p0gxKTPbR/rO56FOHhqFyzYV6wZYDKLDJq4LYzSVTzntnbMkfLH94qarv86Vx+R0zOyseHBgrJH8QXZy7iXwWMg8S4QvzOrCjE5JFUCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LuGX1/Pn; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-88470af157bso5874739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756870019; x=1757474819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/lOOvLhOLy/sorN2ba6lIemJd4kQXZprLIftfp53Us=;
        b=LuGX1/PnYywp65OygFqFuKoe8cbMSZnDmR/5RYZdkgbivLBbyGQrG3uovIEpVhQupT
         5s7PqJ2HZDKG8odigdx7qF7ibegml1gAL7OhI6nRWYHjaRVIBoBo+Hwe0U+qiHWoscyo
         5WbIbUm13RJgiP3ZCjLl/ZEuErIozFlFHo9/JPl/I4waI3gZqF7xdMXpLKFp+m4Gg3nc
         +9DqR6yroOxuNM1KaFmrD/vOyzEzjqy/CIdB11GqtPeJo9J+f8Dw0muIMycfP7QdSOG9
         Rxkq4jK3TKJX2HwQ+oTkAJAupkBN+p0Bfzg95RhDuiteKIa/xPuGhW18edKA9ty1skMt
         THcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756870019; x=1757474819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/lOOvLhOLy/sorN2ba6lIemJd4kQXZprLIftfp53Us=;
        b=dyqckRDDjmNzCbjshmShNAMmaheB2iNzuJ1szR7wsGmSQMUgY7B4hpu/HWIzBO+nt+
         4ijs1k5eRyvjdFrLijhKLpzrqdhvadLA7BPC27/NgRIJrp+ZFMg0DuyHYnDZFbPspkKb
         bxRGT6U6gatEjSyrQW8gjnEcEugci7Lv81UvgsJtBMgyI9tvDtw+06txb/E/zK2BCYmN
         1EfIYWuisd7/Je4DbvfH1UJ4wlLkdtbyN/FdepUI/bNRiyUMfTi1QhkmUddaS5CEdeRK
         B43LrP45/FTX2eI6Zo3g5QAlHDtY8jFg000Dqw/hDfEzoxtvBVuEKbZsHFraawuEPj5s
         08zg==
X-Forwarded-Encrypted: i=1; AJvYcCUh/wSySblCsN9vNPxShHJSGyQbPiuIjhI20J6hzQ8RqAgpJpo9jJQXdXeZWBhMRR9EGI7tsqXhd0LinUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9mBxJV3n/NQSDKzbm31c+1R2PSfi+c+js9k+XKp6UETWT4xO
	r54ipz/wQaDHvUhFCkYVDRrOKxnG3RkgISjt0cgVBrRY5Ojr+h9eXlZtJJch/MiIQ8POTBnPczk
	luel/7EugSixdMUdm5c+aQ4XaklkOQl0SYwqyhWP81jrrJmbk0sbA
X-Gm-Gg: ASbGncsCqK3kNltSgj+IYUKzfHkzH/rrWxD9Z5fhA1GaTWBqyhW5peok0e/HKZL6vQx
	I15HZ/P5IkqwxU/QhWu3k5Iia9YSiECrPgKyW7EZL/d+qKV/35RrFuhW9jen5duxNXvdo/YyPZH
	3867atSVEWfeOxCN/sjk2Zw+dulPvRGq4GZM/9sARbvjOTIYmA7gkAcBiiE5IzP48v3SlDBJPbt
	/g98Rd1col3eXa8cby8lnaX6XSGUxN4Y8QSb8BqiatzlN+b3gQi9OvmvMyLhhquycDRfrp92IGv
	/izY2Gn/BvTGyr77jOGardb5Xa9Pf336hgJWl0rg6Jyqvu1VOfycIPBj3Q==
X-Google-Smtp-Source: AGHT+IG6TC1qm4eO2jp6q81u7BtA9gndoChMx4n9tAGaldjwUIcSFnLmfQ16RVQQVkcE5oHUy/Sqof2Cdqst
X-Received: by 2002:a05:6e02:1fc5:b0:3ef:beb7:dba4 with SMTP id e9e14a558f8ab-3f321afda65mr110085785ab.2.1756870019411;
        Tue, 02 Sep 2025 20:26:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f31b06bsm723181173.48.2025.09.02.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 20:26:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C06EF34029E;
	Tue,  2 Sep 2025 21:26:58 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BD418E41964; Tue,  2 Sep 2025 21:26:58 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/4] io_uring/rsrc: respect submitter_task in io_register_clone_buffers()
Date: Tue,  2 Sep 2025 21:26:54 -0600
Message-ID: <20250903032656.2012337-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250903032656.2012337-1-csander@purestorage.com>
References: <20250903032656.2012337-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_ring_ctx's enabled with IORING_SETUP_SINGLE_ISSUER are only allowed
a single task submitting to the ctx. Although the documentation only
mentions this restriction applying to io_uring_enter() syscalls,
commit d7cce96c449e ("io_uring: limit registration w/ SINGLE_ISSUER")
extends it to io_uring_register(). Ensuring only one task interacts
with the io_ring_ctx will be important to allow this task to avoid
taking the uring_lock.
There is, however, one gap in these checks: io_register_clone_buffers()
may take the uring_lock on a second (source) io_ring_ctx, but
__io_uring_register() only checks the current thread against the
*destination* io_ring_ctx's submitter_task. Fail the
IORING_REGISTER_CLONE_BUFFERS with -EEXIST if the source io_ring_ctx has
a registered submitter_task other than the current task.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 2d15b8785a95..1e5b7833076a 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1298,14 +1298,21 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 
 	src_ctx = file->private_data;
 	if (src_ctx != ctx) {
 		mutex_unlock(&ctx->uring_lock);
 		lock_two_rings(ctx, src_ctx);
+
+		if (src_ctx->submitter_task && 
+		    src_ctx->submitter_task != current) {
+			ret = -EEXIST;
+			goto out;
+		}
 	}
 
 	ret = io_clone_buffers(ctx, src_ctx, &buf);
 
+out:
 	if (src_ctx != ctx)
 		mutex_unlock(&src_ctx->uring_lock);
 
 	fput(file);
 	return ret;
-- 
2.45.2


