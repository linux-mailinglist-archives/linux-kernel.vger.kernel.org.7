Return-Path: <linux-kernel+bounces-815012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E696B55E28
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749BD7BA3A4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC561EF0B0;
	Sat, 13 Sep 2025 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXlHd/At"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CE1E8332
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734654; cv=none; b=MpElxTgTJA1jvXQzRC0jm7bAkMtyvqlVx246ZuEOk03SqK2rIWUKBt928++iNFfXsbg2rhK/G9yXBYOA0vTC2ca/WrM23rPSOx/0lCgVsxIjpraXadAiAxsb2ypDJKy2MfXFHvL0hhLY8GVnbGLb+vqov9OsWqj6i94c7o6ktzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734654; c=relaxed/simple;
	bh=i+rdKmNLLqGvwTHxeA8bz7QFUciPCdRQTOlJcDYX+3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GplErAJakJ7mvDnmskGY+wfyCgZBVxsF0e94A0e4cF4ge1jk8ZpmwRcfetQxEUsOmMK2EVGi5IZ0srsrvNfWqAeJi6Lk/MHJVGvNYCG6OSRT6cgjWngh461XqH3Wrgo/KQ6DKG3oL54jbigTOUkZf9gZmhxukb7z985eb0bSaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXlHd/At; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso2078140a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734652; x=1758339452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM1B2JsbtQYQeIjPqUgcbjG7nDJGVMQTVHa4+Nz/+SE=;
        b=hXlHd/Atz/S3XYLrfdlyoRljpyU0hSn4Hnm+dRYp02HpfbqUnvtb1e07g+wC/RRe6V
         L2bIFprYhzi9y0yZbb1BdeVTwzxms14fMTWHwBm+iPW7ijhssNmboS0Omng2dTjmEVr1
         9OsPWHSAowtg3Jh1FPsr3I/N44J82mY1Phj/0/VFhMKPCm42KUo2CQGwPI06NW3sDznv
         GAIwJOej+RoE6qIJRRjQDQPxDi2+yKSzJSpfddLpPvWQpI3qqkBl7eWm1/PccpkZmMC0
         l84d9rYiX+KTC5uesSuiovdboCioJlMM0sp+jUtVYfw6Td4swTp4bWLgtQUE4yH5DnhG
         wuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734652; x=1758339452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM1B2JsbtQYQeIjPqUgcbjG7nDJGVMQTVHa4+Nz/+SE=;
        b=MoOJYjimAhsFBqNb8Z24HlC2F6/GCXthR3v32RJJFxJ8BIlEYmHhkzw4g6xzcOvGuD
         IUL9u2bb2ijBLVMTuNMpHfkUQVYZ7XTIGumzPs+b7cobYrAJdFwfloNrkGoomB4vj65f
         1ukMbhbJtXtwXWeylNrgmCgcGAAxFWbZBoiXCemKP3KhcOWipz2DKVoyNeEIm4brgNSB
         aVrrRGD313MuItihLps5gznlxcwnthPC/lTA0rYfM6f+PlF5p6+eOfV9QqE8wqJ+p2Vj
         TYVf24OUxQRZ0L4h3/lAi32LHGFTUzqrLEjHlUt1tquNJYCBXd8NNi3dCEHce1hv1pL4
         kpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb2pWW0UeXpfxfY8Np+zOCbq1m/GFQk0fM6pEIHuFXCkuN6B2nHwkMF2YwndewUru9k0055OzPBjxzs38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O5N/+94ClskO2dooGTtS3MlpAGbpPXsUqUjU0Bcu8idCFYfW
	pbZlkrx8lAF7Ix5hllFFIezA9cdxaXVo/vo29wfSdAhZPFIu2JRBv3JutRLJ5Yz1
X-Gm-Gg: ASbGnctXDb8Uf4AOgpLBTWEvUGMIeRUyLVmNurH0s7NPdcBM+8h6yo8YUm7iL9AvwAS
	zD+dSZwbGvXNHX0+59YT9AuU0fisPPdlO7Kg9DJavDodDHaDurbvMeShLVarmP31ljy/jG3cLX8
	ggc6zVYnO1Ob7WUTZlZ2dixOjTTdlaRS0C9U1d6MiCA9Ov/zWWyTYxuNDljI18LhnL30t6U7TNq
	94BG1F4iV+eZqm2H+KO6aYhTaCp1YmTndZ3ghDOUpIEdfIj4xCS7lFvYNg+NqJWcPmd0KQJKqqa
	5la9Dggq4H9MFaHqBbWEbroo2CNxSI0KutMoMkF+BBvY/S50gYH0GHzUOma4bTuMMHINZsIHKfI
	I/Yx6GGGwb58DnLT4n/T0PCyFdnUGju++bhvA7BWfKQDp
X-Google-Smtp-Source: AGHT+IEOeHsLPRMfra6unUs5NfyVRITba83xdMVSRQfiY2OhYU1gf7ElboHBu/sxYisDe0m7N+j1HQ==
X-Received: by 2002:a17:90a:d603:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-32de4c33d5emr5685465a91.10.1757734652269;
        Fri, 12 Sep 2025 20:37:32 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:31 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 2/4] iomap: move iter revert case out of the unwritten branch
Date: Sat, 13 Sep 2025 11:37:16 +0800
Message-ID: <20250913033718.2800561-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

The commit e1f453d4336d ("iomap: do some small logical cleanup in
buffered write") merged iomap_write_failed() and iov_iter_revert()
into the branch with written == 0. Because, at the time,
iomap_write_end() could never return a partial write length.

In the subsequent patch, iomap_write_end() will be modified to allow
to return block-aligned partial write length (partial write length
here is relative to the folio-sized write), which violated the above
patch's assumption.

This patch moves it back out to prepare for the subsequent patches.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0c38333933c6..109c3bad6ccf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1019,6 +1019,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
+		if (written < bytes)
+			iomap_write_failed(iter->inode, pos + written,
+					   bytes - written);
+		if (unlikely(copied != written))
+			iov_iter_revert(i, copied - written);
 
 		cond_resched();
 		if (unlikely(written == 0)) {
@@ -1028,9 +1033,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			iomap_write_failed(iter->inode, pos, bytes);
-			iov_iter_revert(i, copied);
-
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
 			if (copied) {
-- 
2.49.0


