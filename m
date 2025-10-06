Return-Path: <linux-kernel+bounces-842654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E2BBD3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56C2F34924E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C32580F3;
	Mon,  6 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsBXezeB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B82566F7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736601; cv=none; b=RqE2NXTOnII+xWWbj2JtTbJsPKU5GeQOdJ+vgggbnXrrwGwTNoZKVsGS/R5bbybMKIej3LEjxdcDMvGpVrnHufgA2ny6LuGd2+AoY9j3YQqBsCZaQ34eTNJfa0YwDMXYoyTZZBJ2U3/X0bCIXeRFOwyZapOqvVZ+aT/4g8WMq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736601; c=relaxed/simple;
	bh=C/mZn+WHYcVqu0T+c/x5PT79Zv6hxCKk90h2Bfu7lJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LExbDngp3yU2zYCk3cpGpUsMRCDyZOmfMEBHk9tJj3Zl60i+nJZb6rEkNTq7yJqBosdKxkMeHok5Z5W8gd5MENOyCU3S4SxmkOCcyYm/y8Lp7kZ/4LspkC4SOraFuhgr8MnZTMYtO3h4o4ibuc/G7QYRj+mFMRvHhP29fnrttVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsBXezeB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781254d146eso280161b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759736599; x=1760341399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw/9lPWHfMPkffQmkaSdCiEp9p7tCzCfQj89DSw96nE=;
        b=PsBXezeBPjtNKFZQydDkaSEOoVwb8gMYwStiQMFyIn4rvT2IusPOgz0dp7JM67eDiv
         RYefwi+HLiiTMUcHNYPpQj8sycZlkgcF2rlZ9eRHFq+1v+VIlauQhRPZsabSsU4X89lC
         +D15vfJp0XEUYUir0KlByxYEDCkFVAs+sgwXXq1uJRtAROGhpwdTw3eStK7qsjoEmO14
         bejL75YKRlwgPA9JhgPjavrK2+h7nKXP6ua+EKccxucQ27Kuw51QNAeJIG9BieeKECrC
         OTx8B4HBRnYGJNCNokUjyvhTLPzxisUfJNA5hYEG8X9NdhCdf0vCcrC/bQgEDzcuDfTm
         AUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736599; x=1760341399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw/9lPWHfMPkffQmkaSdCiEp9p7tCzCfQj89DSw96nE=;
        b=aksuWkA2gtaY+Ns4aA6oBEVUOi7r8HGUb6TKDS2f29Ez0SEV36OmpnKBco0tuBvQqV
         zLZbklQh7yrg6Xhacv9uFURCXQ8y1Mxy6eM90PYpRZxnYJ+BCE/Ta2dLoHrg6YFcR26d
         4B1p60cvhRt4xo05hejwSXWAGHqJ49BdLUD8UqCgim2zRmjAhm/WRe7p6QPzEBJEN+n8
         uDwKKbhJG/BTBsBHOx5RUw3OL+mIqS/dZl02U+G5WqAG1wFqgejijSjDp0pzMF+Bi25y
         pdPTZNbyBozhhx/GGwJFFWjnCjUFtEjyQ3MRkuW6WkObKF3MC9ORghxiwW6S2zE/RUhy
         wvUg==
X-Forwarded-Encrypted: i=1; AJvYcCVIrAjqx+v5P9zK1jFIDWxdFaaxzB+338iAkZMFz49NzwH5bvfYynRF3uGMEEb7MltEriZQS/DNemg7s18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cf0yI4aLWE9f0dteBBxrve9ucRsNu9mnQu8+hgXMoId+O2g8
	OoApqqtPabGW+dd9SPOEjYjifXEl66hnNzptsCdPV6hLGVVFCC5Fs/52
X-Gm-Gg: ASbGncv95DSPJYly0vXBUxTt04YqA+yrL/Hf4xlSDQIjy2qbunPb4dNtPVdtVg0l/8+
	S6UnQdW6rnRWryyMZVj8+D6GC6SeWoIcGMyqU7B049lyskBwjRYx5sBsH1JmTYDBkKcSXxpGoJW
	I2OObZN3u064tf1vvU3pVwSk48lfVU5pL5Xfaw6ij08BF06OdKxeQc/wMV0Z0n0gMMbulpdp8nz
	WUxRAFbMET1RMPFgfD1adkHuBSGo/LghEkjW2JxB7dy8nb0DUdaCrLudNmx+t+kzvsLgh6eXoy8
	2gf0wpXn5R4i1TZt7Z28cfDNShGIMNEDXtyus4pF15MgFzL/OT4plCuAYMMb7V6WJEfswiagCaW
	ig2aaY1WhoNQT0ANwxZiPMGOggvWdmU9C4KiPePjw6KvbaqxFhycQSdA=
X-Google-Smtp-Source: AGHT+IEMB07ViPSEotVWrOcwSD9ma9t+HQ//zB3NHR8w0pPltXfnUy8JcwvN3opxQHM+UsEYUSNjJw==
X-Received: by 2002:a05:6300:6675:b0:2bd:d83a:d1b3 with SMTP id adf61e73a8af0-32b61b2e1ecmr8038240637.0.1759736598836;
        Mon, 06 Oct 2025 00:43:18 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:f9ad:a206:7416:2450:6aa2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f58ac2sm11231639a12.35.2025.10.06.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:43:18 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: brauner@kernel.org,
	broonie@kernel.org,
	jlayton@kernel.org,
	shuah@kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Mon,  6 Oct 2025 13:13:08 +0530
Message-ID: <20251006074309.4348-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919104948.67953-1-vnranganath.20@gmail.com>
References: <20250919104948.67953-1-vnranganath.20@gmail.com>
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
>Adding missed mainters to the patch
>
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

Hi Christian Brauner,

I just wanted to kindlyfollow up on this patch.
I'd appreicate any feedback or comments when you have chance.

Regards,
Rangaanth

