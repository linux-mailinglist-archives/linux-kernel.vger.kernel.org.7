Return-Path: <linux-kernel+bounces-824996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB6B8AA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE603B7107
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC7258ED6;
	Fri, 19 Sep 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVkxSd11"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECB78F5D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301083; cv=none; b=PUs5q1TQcFTlJibURj6ZvnmV/713XK4Nqy49BR+ZJLLPTO1mG8Pe8cShaUZTLRYcbKqmHn1Zsf2WquKbWVqeqGlZNPYmHUcxwsLKqO7tVqUFeARllSrrwo13GzAMrwgC7A+gGfBmFl4KRQ/bjHZbxHTUd/qbGIiFYTHte+FqzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301083; c=relaxed/simple;
	bh=LkXiNYVmYy45PbtQp4w3oidCzbB9YyGL7WOlczqslRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lL+R2cgeDjOQkeO8fleMnHhtP2gZ0wMtEBynKz1El531kcyXpCo7h5V3TOHDTuPjeYDQ+ZMmIAk32hvAljWlalasiwU5cueS4y4Gj2SMQ1kNhPD7OSFvTLADkksrmYW9IxVWp1O0C2B0gn6z1CM9CbS3TLDYjlGezG37mjvvmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVkxSd11; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso18771455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758301081; x=1758905881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHGlmanb8gaPkMmh9rY2xAoH7nIapmCNS2c1Geon5Qs=;
        b=FVkxSd11McjzefB8Ll8uU1936gI8oS7ah3PJUPFjaJ/xDSp41scvUqinCh9Ys/ZzZ3
         FLcAoZqOqMBblRNqSP/uHvsCWt43SjsnzR+3e2fYlCQenDjXDX9OENgd6F71PDe36SS5
         ztNEKcYZrthA/ILnKBhCCHFL7Jp2RI6MkoPJ3c1UyPgZ9q3vHJQ+R3R7G3WK090Cn+2g
         qSjY/wZUPd5QrZ8u6HIkrEY1Z8c02/sRRO3+N/cn8n40kjtqkUTn5ObHgZM2yBrLedv/
         qKBt+adnAriUM0sQxks2SH+YbZBvJqeCgfhtwHOJG34DaR5KRJIDKLhyTmsAX19tl7eO
         ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301081; x=1758905881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHGlmanb8gaPkMmh9rY2xAoH7nIapmCNS2c1Geon5Qs=;
        b=qwS7xh/3V7H+s3ykKg55ZFQ6Z8/1Lq4FWhtsOVqRNnlESKJJRYeDPVztcVZeeN7Sf3
         lKXcRXpmtAZHOuqDOG1LBu1dy4db0rhX29/JZogwil23EqK2crtnRs55nlPQIdjxE+vN
         ELEB+2noNwT+8HJIU2sHbRKK5LcKZ0Ake3MYgmxupQDawWWzKV0T2YkMW7hMl69Pbl26
         Y059QDR9AXoZgekOgrfvPOzwyh1e6Us5g4oHEYpVTauy2c4CoWVJNhKNwejTmDJJE0yW
         /8//u2joRD7AzdfpF/bSb9M5J9uY2vU1GJAjTJrtruRctGZfgNHDHXQIfAuSItofO3u8
         f7oA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfeYQZaWYNzdKAWF4Jmz/AbYUiWeasocl0LSx3mkxJ4doBAGPD6Gl0L/2SDKGTx2Gmv8lTqkjFZwpL/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhqD1OK4S8sgnIsj4DZJZynZhAwKNs3F8gDIRuhQgAhuHB/ch
	FOpYjA+/sJRvoIh3JunuaB/ZBQVY8MpxxPod5W9BBKQxSaPA+s2DCx+I
X-Gm-Gg: ASbGncvknehG7I3LfVEcEMCp61N+1rYfDWdggfAA6Rr2NkkNWf6ph8DNDYd3sfz9rqg
	3caX0V7Uj3eUjvJvTr7soH4lKUd3Dhx5UPar5hVj65FmxMKHQjurZ0WEGBZdiQlaz785cMF6KbA
	9Fc/j3+ALcnujkMcjc6mm0zcgBODOAXCf7dr81LqOUeU5qjU8O5/j0xksATCs07Q2CicE3FDErT
	Gknvw2ZHPaR5KFPAERxWYt8Cf957g+vHN/CfSteVZRhKC2pqzd6Av3M8KO+JeQkbrV0wyS7L22A
	UuwIR39Z3hET9zwhhyo+s6Y8nF/xKKfCHwCTnCcU0GcdEI3lpBYhuq5u9M9TnROI2/P0Xz4D/cI
	ZSRHuZOzUEORKOnBv2TiHvA==
X-Google-Smtp-Source: AGHT+IHRuVYN4oeI6DMvgCDuUp6xTSHvjNQAT0yQq+8tmYwKdcvpMDomyJYfc7kVeI7DWpy6ZIZ2sw==
X-Received: by 2002:a05:600c:1d12:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-467ebacab73mr30669845e9.11.1758301080265;
        Fri, 19 Sep 2025 09:58:00 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f4f6asm8171331f8f.6.2025.09.19.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:57:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftest/futex: Fix spelling mistake "boundarie" -> "boundary"
Date: Fri, 19 Sep 2025 17:57:11 +0100
Message-ID: <20250919165711.557272-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a test message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 722427fe90bf..3a71ab93db72 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -206,7 +206,7 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
 
-	ksft_test_result_pass("futex2 memory boundarie tests passed\n");
+	ksft_test_result_pass("futex2 memory boundary tests passed\n");
 
 	/* MPOL test. Does not work as expected */
 #ifdef LIBNUMA_VER_SUFFICIENT
-- 
2.51.0


