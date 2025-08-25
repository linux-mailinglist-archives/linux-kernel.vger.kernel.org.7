Return-Path: <linux-kernel+bounces-785454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E6B34AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8757E5E617A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B92820D5;
	Mon, 25 Aug 2025 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmDG1+8v"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625621FF25
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150397; cv=none; b=fwGey1qowfGU4eD51cR/rV7vUR7uR52qyW1pE0ykWSivrEhbx7Zyk7aiYz2xpLEjHgRnrEsU1GdsgSQu5qVcZPchErJRp05L/VBi8A8yMNPUWJL2hQLXw76J+ATb5KAf2IujBAEW6MfNQaavOIrcMZTMM/TfCTdrwyz+Z80zlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150397; c=relaxed/simple;
	bh=p3TU9mTxSIdQt9ysk7U84CSDNHVoqEThie5EVGDfhOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEuKpoBaSs+7FJalfd2n1zqi3jWlMVDWUVwhaqVQtxR+rz3laf4h94w1x7RInFMX5CW25Xnndrg7im36DuQYmNJIx1G/DjFDdysbpwT7D8hK2f0My1rjkUXn4Zp+sx3kvaEVNprJnwtWW9EZjGA9Yr/pkwHEdDKTpm6KI07DMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmDG1+8v; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cb096c52a3so51156f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150394; x=1756755194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QHlVkkaseu8HgvkDGo4UUAKEoUIx8XaB00oWO6P7ng=;
        b=cmDG1+8vH8rGBICqysnOx4aglfryqlHRBEvdx8OkG0htkikujZxlNuM2ZH0wjfTEzB
         GI++d+YIE2s+Xi7pw1S6g4uClLlWuqmQBUMGXIRSNTKw6q7hOUTVAD/rhyn9r7rWlSID
         AmHbwR1CEpLOT+ksAKDvkMReMpWjs1rcCUrlCIxm1DgZXbC0ppng3QLYiDYYCjB7kRfb
         zC/9SFXXNsvqEjIf+t+xt3Go+Ox2IFrtVhqybF6aaR7/qDJll+ERi9fkRqBKt4yXt/Gy
         Tl2YJPu8H/05K/xB8BV5xaKUtxm0tkIF1syCAe0kZ+4bXsL6oz/mIhBeOryxJVeXv3pG
         AQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150394; x=1756755194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QHlVkkaseu8HgvkDGo4UUAKEoUIx8XaB00oWO6P7ng=;
        b=vpn4u1MFZfJqlXKt4ikdP7QwXruNv85DunPxCHDfobv7v+omYGM9q1MAArOCOgPApP
         Mr6ki2hxv8LGG1vOMaoxY0Y90cIxHqzuxONoFYVJvEbAJY4+BZOSeR0JMZy1OdyhX4KN
         qUhTEfmbQrDchiOBH38lo3aCMVA2bD8ox9YPKzH2cvhkPQ7F46wSuCKKFo4g31eI0Pl4
         2991BXF9MJ9oQuMXFPlKILwsjUDYD8Lfli371RCiIYya0gwmcRhABalUrh2FBebslDPo
         v8uuMCk7daFu/Jf8Br+o8iV64lEJriVT6CIbcYgKd3Z98E3DyqzYLdmpKBocprkBF8YT
         mKsQ==
X-Gm-Message-State: AOJu0YyHcXS4XmQdUt5xFQCuGIWMuxZhVY/yWQK6/HLIVSBJQTxIWCiE
	YhvDwkqxMNSsT51Meo26MZVZiKiFXS0tWvXrPIPeEg24mSlSHM1oPNNKj10bxRJpXVY=
X-Gm-Gg: ASbGncvebak19AeWZa2Q/88rVSh22brOvrZ7o1gXKY5DziLTs1gUg/2IbKITi72hZoD
	YoUn8GX/e5NBgEd6udX75q+eg8pI+NXu2MbOrKbPJMreF4YIRYxxQSXykaHEPJOPlp2zeW/LDDz
	KR3OTW5e91KyEhd/PKbR4RdAn8DpAoxlXOLGNZ3tBXsCUqL8s8NTFFa18ONIG33yDaQ+rmxesuC
	ktYpW9jSfzwnq+GLF5npfhkMO0vgvT8RLj170j6NsHURfOEZltA0V4ODZ6quk3CMUPzTZZpR2RQ
	AOX2zQsBdagFFpzxKsNm/Bum4It1tX9QYKxqKuPvl4aHUkvOuKQaECoMPzFjrdqw0Q4lZF4ZHKC
	RvuiSw882vBEy6O9d1u/ZGJLP7cx34wuBA54v5ZuAn3j5Jg==
X-Google-Smtp-Source: AGHT+IHyI61ZhNycdeCbbHy+iag2OkNqlkiWdsJGn06gEVxXGybkSnillSLwzuQUfjHYdTfughvL4A==
X-Received: by 2002:a05:6000:2089:b0:3b8:d12f:67f4 with SMTP id ffacd0b85a97d-3c5dcff537cmr4689313f8f.8.1756150394072;
        Mon, 25 Aug 2025 12:33:14 -0700 (PDT)
Received: from gnulinux.home ([2a00:23cc:ee22:4f01:7e07:36b4:64f2:8b5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7119c4200sm12671709f8f.53.2025.08.25.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:33:13 -0700 (PDT)
From: Harry Fellowes <harryfellowes1@gmail.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	Harry Fellowes <harryfellowes1@gmail.com>
Subject: [PATCH] x86/boot: clean up whitespace in a20.c (v2)
Date: Mon, 25 Aug 2025 20:28:34 +0100
Message-ID: <20250825192832.6444-3-harryfellowes1@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version fixes indentation problems introduced in the previous patch
while still removing trailing whitespace only.

Apologies for the previous version which seemed to have accidentally removed
indentation on several lines.

Signed-off-by: Harry Fellowes <harryfellowes1@gmail.com>
---
 arch/x86/boot/a20.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b428922a..bda042933a05 100644
--- a/arch/x86/boot/a20.c
+++ b/arch/x86/boot/a20.c
@@ -135,29 +135,29 @@ int enable_a20(void)
 		  (legacy free, etc.) */
 	       if (a20_test_short())
 		       return 0;
-	       
+
 	       /* Next, try the BIOS (INT 0x15, AX=0x2401) */
 	       enable_a20_bios();
 	       if (a20_test_short())
 		       return 0;
-	       
+
 	       /* Try enabling A20 through the keyboard controller */
 	       kbc_err = empty_8042();
 
 	       if (a20_test_short())
 		       return 0; /* BIOS worked, but with delayed reaction */
-	
+
 	       if (!kbc_err) {
 		       enable_a20_kbc();
 		       if (a20_test_long())
 			       return 0;
 	       }
-	       
+
 	       /* Finally, try enabling the "fast A20 gate" */
 	       enable_a20_fast();
 	       if (a20_test_long())
 		       return 0;
        }
-       
+
        return -1;
 }
-- 
2.51.0


