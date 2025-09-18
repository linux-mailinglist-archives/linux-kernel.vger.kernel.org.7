Return-Path: <linux-kernel+bounces-821859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C196B8278E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CCD3BD4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB41F4701;
	Thu, 18 Sep 2025 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQLsCafi"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A71DF748
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157747; cv=none; b=j1Cksed/nYLjTbPimBxx/6T73BEDqJb6dR+CUGa5Wau1NoDx3aWENG9xprkblKiKkKdTM2mNIdRzQvN7oesIcByyw4R0Xy87QmasAFPKafcGP/1cj5Q7+TdMTqcFEsm9aOOAzXqOh8fal4G6BHlolQs9AqI1raqT9do+8yo1m6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157747; c=relaxed/simple;
	bh=9P3nK7KV8J73AZhnweqFBC1fyBtgUxeHctZkxwZz33s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhJORJd6gDnJWURE1l1Qt+NptsiMHsGZfE2d823TAaNEu115EBN1/q4Oh/DfRbfOYgN7ZyfFBrInJIF+qmjhdvV5F7l4LauzBQZxza+4y1Wdrrh5wtwNlwoZ29GDe+CDK/jrJRU1mq3at9KgcoyW1bVmsZmTW38rmJ4J34OdcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQLsCafi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso297509a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758157745; x=1758762545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHJ7zjhTR9v7nxYizl0r/XT118ERd6F82Pwgt1ZYl/s=;
        b=TQLsCafiYHrSlAVVZm6Zj8Cch6nM2+Xm//vK9suMSe8fIfNaz/QhNxDE3LTr9+NUZq
         OTo3ipo4/OXycfuIicpCtR/5f30jhAoZDVmN/p+X3+3PvF8gTx+UAsemrORcX0t50vAn
         uB1FbkkyZ4BGHazouE+RHYc0bxSdXM4vgi/Zde64gLq4cSw8meTL+3TXY2LuPRtE4KXn
         F3MRSkXAIj2lk12uuyoPwj9UgOebSaT1PNQZTJ6R7Jv+7oQbYotZS0XetOUJ+aqLrlJy
         OcXKh77PM+NKOHr6N5n4d8E1Ivo3AV3W+ga8Hh74dc5qOjjokfLgyz4xfwErFj7le+zb
         MupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157745; x=1758762545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHJ7zjhTR9v7nxYizl0r/XT118ERd6F82Pwgt1ZYl/s=;
        b=YVtiN1JZ/JT3bZh/6gr7KoxQdgZ+Gg29h1Iq/IIvwK9LMRCuAwp3zr8UhG+TymkVIr
         9WU9p1KhR5DRgfmjd6l5Oi8Td25ATpMX3eMnR57Rq0QB4R1SNzOJ8if/6JU3zTJclOKE
         IP+zJwK7btOnDEbGcSC3rRlSWl1sKdDm0ml+AW2Yepx+Hl0+w5fOcK/rGMz4PmVCjhRK
         pnCSqcCbYErIBq6JGgb0ERbK0hxSkfPZCfc1oxU5sh3WMsPq16frhIc8IyxnmBHfp0xP
         Tw2oPh7zxZNC0Dij1MsKKDvKuuK5jkqKGb3XtWCetdYSpvqR2NBbqJh3vJ6K/XvgDFNE
         BA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX86/hRPJZkzw+HE+Xk5ZGgwOjaryWvfiTp/ed1RRVrbgjmxsMMZxUv1EYz6yQRewS31MeJ+P16topMGxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkGl6iZ01qyqE87qwH+mXGRYlHVhwfk1XQBumSaogYKn440K4
	fxBe2QQ/gcwx7sxKx8Tt1RJO7AKIjGh992WiBdCxqiMx7wtQSnmpzx7O
X-Gm-Gg: ASbGnctxyW1zt6EuIeExQHCai/LqiFb3L5v3ivPW2ioDFCuQFCMJ5TuCwkFBrsfCUFa
	PWbdkJWymosLWiM4y3fAtAqldMKdQ95sGIRdoBEXfze370F8ZKrzKfdKLlWGypYTOvq+sF2CuFl
	ihu+jiDL6eoEdkEtCuoDOUd3POe7ZL8/uIwlcYuXQQJOP6lBZk/qIFk+if7oAh1wCqE/6hjDq8S
	FM4YVVbgGSRybL3a28VDIcIYWJq3SQs2PMhJhMTJ05cwXthcvqfLN4s8GixBPofRNnPDPNKzlhm
	mmkAytBaWrtE3SefEt2wEsU4SIykS22FsSWSHZLNfJBBKBCD41fy3sqAxFEyHICPeDfb5NHH5wh
	++JOpDch1H3JjrzNm2wJ16LyYivmakodTYFJac1kaA0AQKUTV0f7rSvfZ8bdfEVuOC2C+f+F6v5
	3KRCG4CWWrNihoxTg/zxpD
X-Google-Smtp-Source: AGHT+IHuTybFeutlNUcFFDtekJviKXLRz++GzvphkgU6pKLG0Unl/lf+rV9kfu1ChnsFkO4xf4Ybow==
X-Received: by 2002:a17:90b:51ca:b0:32e:345c:54fe with SMTP id 98e67ed59e1d1-32ee3f759aamr4709290a91.20.1758157745183;
        Wed, 17 Sep 2025 18:09:05 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bb5asm3550089a91.0.2025.09.17.18.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:09:04 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: w@1wt.eu,
	linux@weissschuh.net,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers
Date: Thu, 18 Sep 2025 01:08:33 +0000
Message-Id: <20250918010833.2760723-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 
d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
made nolibc use the kernel's time type so that `time_t` matches
`timespec::tv_sec` on all ABIs (notably x32).    

Some distributions (e.g. Ubuntu 20.04 on ppc64le with older
exported headers under /usr/include) do not expose
`__kernel_old_time_t`, causing nolibc builds that rely on host
headers to fail (I discovered this when doing RCU torture test in
PPC VM of Open Source Lab of Oregon State University).
        
Keep the new behavior, but add a small compatibility shim:
if `__kernel_old_time_t` is not available, fall back to
 `signed long`

This preserves the intent of d5094bcb5bfd while letting nolibc
build on systems with older exported headers.

Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>    
---
 tools/include/nolibc/std.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index ba950f0e7338..ea225a0b16e9 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,10 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
+#ifndef __kernel_old_time_t
+typedef   signed long        time_t;
+#else
 typedef __kernel_old_time_t  time_t;
+#endif
 
 #endif /* _NOLIBC_STD_H */
-- 
2.25.1


