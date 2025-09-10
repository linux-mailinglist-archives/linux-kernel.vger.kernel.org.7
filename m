Return-Path: <linux-kernel+bounces-810813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E111B51FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8657BBFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06AB33A006;
	Wed, 10 Sep 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxNtZegD"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79C3376A7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527593; cv=none; b=RC1EvwzrRntOXZTYe2wuedb2pMtuiM4QF+FRa5lwynPPdsXtI2TgAWDU2s+u9HF+gOmH2AfnoZWvdX/xNWgHxToyD+xuwidb9OziFH9OBEiEUkf0xH+Km+V2UqwvjXpE7z4vkrtMtdMk3gPThr/fS00MzuwSyljEN22ie07xfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527593; c=relaxed/simple;
	bh=p1K1r7QiSjUuPGqQLi4Dtbb3OFi1h0fLaBfxqHPJQcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el47CyYKf6IzLbDplbPdgE7CSf6IqF6KR8O+4itD94wQHMxPFu3Enmg+JRj+EzhvNytCUNb7LAuQGCccznWeCHgmutirPPQ0mQ+gZeheXPLiAk42MD/jQgc8NCaK2QTE96v8WhOoRIdbsFU2cAxqipoDLiuQgDC7QLdzhng37Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxNtZegD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-325006ff07eso611497a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757527591; x=1758132391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGGo2FqzU3GfR0P/K8YS6WMuWrLlPcudWZNlFzJbBN0=;
        b=XxNtZegDm6GNBs35QuoMYQ5zD/WgnTH6obcTb5lOfuVgoVpRmjZWpEcC2uZkfR6D4v
         Kno/wDxqp74EKwfnfJb/zxaTbvfj2LzEWLUV0tIxrYthwR5kHdRGdOA9vslnaNGhvxPX
         cxXyglSroDn2yoAdRXO9mrvy0oL74011noweqN9BGK7S1PdtLyESypDaIJeRu69H3QMB
         5CeIpmgkwaKSJGRB6/L6vQ4lSWX6iU0lzecOoYc0Dwx0iksYGtW584wbTBSf3UrwiXAq
         JFWt9pK8jznBTwYGIbkxgDuUrKLlCIkYN24CPOyakm8A/4YkRJTxhIu4Em/aVRUT4f1O
         mU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757527591; x=1758132391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGGo2FqzU3GfR0P/K8YS6WMuWrLlPcudWZNlFzJbBN0=;
        b=JIzBf9MuY6xz+AOPmqiKPOppToWJ+/8JxNsIGTTZkDKq2ueTmpzAhN0hP2rwyinfwP
         zlVzNMcj1NyNnn8vfaxM+sb2cl3ZTH9XAMqmeqGQxWvbfIkRRQEi6ZpShsIKV4EhPX5n
         GTXza/Rr5yAzWtKRbjz2cxZ+eZyhDB0nMYFBAA1OHhAlMXcqdlJAi003Z0Lc5XRiC/jT
         mJXVAqC6JthMg47lN16TG1aSRK+RZS9/MW55NWn3jdUn2VV0JIBxsEKeHx3yL1FDSApT
         USTOqNqzN64OZdGG788Sg1Tk29xKuH9/aWqEbI9ey+JCjs7l5pLI0QBARJXX2Ol7owOY
         i9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmuUznjSUSXO+AwgpW0TfRkEEpT1/zeNt6zRHKLh2zmNwGZbGJNojqxmx5fmzn4k4lfGpRlIfA/v60R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjjJAHNbyBCZf9iaPP4CFA7c6WeIARcrUfzWCIYnuTS/PpTJy
	Ysmnj8PcLl4Mrcv3meUnrNCswyqIiOl4dYtivx2VNgFtBhmSBrK7KBhy
X-Gm-Gg: ASbGncuStehgwHp5n+R04pJa+BQrtdzA6Gt0rohsyDddzUAXdPY2koW4uLoQSUxjcxU
	X5fiKbTG6BN5QhWyydYXA09GYIahfMpfp2Jq3fNEGowh+CyW6+8SneW2YS7Yk1IDWp8Wz2iud4i
	dXHLDoy5w/8s5Tj7VUZ8jt33xEXHcVFYAjrYGDKsCuQX7FpZbmuK308o4OhmT04/Pa3ETGx23UP
	oVGvQDrqZ4usTc24vAKDTBfWAfZ3PiE9wgNmNIqIHadI1f1Nt3vl/ZYkzN5ZRNuNIMvQxfw7ccS
	QGtwKi7LvzOlXf7mdz1h3gcUJVCaWJLyVqyszA/eJbYKB6mrbkm/tLSd1F2ll08mMc68WmR+fK3
	cBtn+5MI03O2xradSZLhgTW7Q1/pGCA==
X-Google-Smtp-Source: AGHT+IEzw+HMhtbClo177HVd/w1cVZeS4EdrLYZApgOY0nZ482UsPgyuJQa51LNrMY3+KaXBnksi2g==
X-Received: by 2002:a17:90b:180d:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-32d43fb8b5amr13570751a91.5.1757527591266;
        Wed, 10 Sep 2025 11:06:31 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:777f:f183:f24a:5cd4:ead3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb313dafsm3279188a91.6.2025.09.10.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:06:30 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: vnranganath.20@gmail.com
Cc: brauner@kernel.org,
	broonie@kernel.org,
	jlayton@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Wed, 10 Sep 2025 23:36:15 +0530
Message-ID: <20250910180616.4324-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730192748.39517-1-vnranganath.20@gmail.com>
References: <20250730192748.39517-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>clang warning null passed where non-null argument is expected.
>
>anon_inode_test.c:45:19: warning: argument 3 null where non-null expected [-Wnonnull]
>   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
>      |                   ^~~~~~~~
>
>Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>---
> tools/testing/selftests/filesystems/anon_inode_test.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
>index 73e0a4d4fb2f..f796dad679db 100644
>--- a/tools/testing/selftests/filesystems/anon_inode_test.c
>+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
>@@ -38,11 +38,13 @@ TEST(anon_inode_no_chmod)
> TEST(anon_inode_no_exec)
> {
> 	int fd_context;
>+	static char *argv[] = { NULL };
>+	static char *envp[] = { NULL };
> 
> 	fd_context = sys_fsopen("tmpfs", 0);
> 	ASSERT_GE(fd_context, 0);
> 
>-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
>+	ASSERT_LT(execveat(fd_context, "", argv, envp, AT_EMPTY_PATH), 0);
> 	ASSERT_EQ(errno, EACCES);
> 
> 	EXPECT_EQ(close(fd_context), 0);

Hi,
Please let me know the feedback for this patch.

Thanks,
Ranganath

