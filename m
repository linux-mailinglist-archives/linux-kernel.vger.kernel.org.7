Return-Path: <linux-kernel+bounces-768469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD0B26168
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEA25E14C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A42E7184;
	Thu, 14 Aug 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzZ0Ixp5"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876552E9752
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164316; cv=none; b=i+ZME0swISswcoOVmHZ8qioYdD+W6rNSGkjGFDA5bYMpAmxZqpQ27aNq7dWC79v2aKlvY8IPe4Ncart347qjJB9BPbuxSNRpChW3/fma8Xz878lu0YI9tWCn52y38D2JcHghzGAC0nJuM99TsrAbj0HV0DAzv65kfhSEUHXOTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164316; c=relaxed/simple;
	bh=y82OKNC3cPTYUm3lzqxc3yCWzX2KyCRnyITs/rWxdzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDzMGV8Gjei2lnncHcxEg2sqMzqut353vztiZ41fO/yHnMCePI213ggn4xmfmFkSdh73ZDjf1hjmsogx/wPP8J96mpvsZk9u2Jg+2qyWVsmiha8Lu04ICClP80fEp5aVjqrhHnN8Ev3KTRvcSOSSCP11M6++dN573aylGHYPrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzZ0Ixp5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso752747b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755164314; x=1755769114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxQ609SiF79aF+tUZK9EpOz6Eq30AySkPKB8PMqfPL4=;
        b=VzZ0Ixp5ASjyfBCMFbLFWlIH9dPBL9tzCqEn3BrvpD2t/JT1zms+16iy2HSs/48fs/
         oLerWUI7uPdYPRUqqbLD2I5b32b5Prikot8qFSV/G9HP8BcBPi90yRaRPPxJdi26lmN/
         hAEm47dq84dvSjyTfDFurw4q/heB8xipHFbdEErXdV7WWiAa074Fufc72VaZWPfU3/28
         6yUhCJl7tvqFakLHVEknyS3C6l+jBYqUX5IwhPPNB4e6cHcQ7maQsz1HJvOamF/N6r44
         ahHwX3MCpGjaV213yxSiVAnrpeqOf5g5FNhuGYgWexRcC1uuh0WcDX/xD5qzg+aVPwsI
         5Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755164314; x=1755769114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxQ609SiF79aF+tUZK9EpOz6Eq30AySkPKB8PMqfPL4=;
        b=Zr39Ox/KgnfaK3MM6QaRHrLovN+ELNXpPtpDrZJyc2QqXOz7Gqtlxw05bcDbt1azDM
         /V8KE4VXsl4ztvqHF9vNWS3ffZcelAKm+ArDg7rOCC9nInlsIF8bK2iZw2fPEVHoqVGj
         iKBzQPxrUWZWQYTxXXnS0C1dw5ZoItHGxctedn/o7UyvCZwCmkBpR8KZmAo9kFYh733Y
         iyvp3xenOObXfkBRWl8p0mVcXoaLgEp/kZf6GxzlQ5TGg88qV+KtiCzkSYX43liXEDaZ
         0gcwsHLbqZ9Fd1UtvCacHKJnuTVlaIVX9OJtymW5dwqkPKral3TILfTk6XhKrLY8BAtk
         LtlA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1GEfpK/Q0RnbM22JhYumMeUYO2qeE3yXbunefv6Q030X4pnth9/aD4sKOFmNhlD84NC7f3EXEUZr06U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPF1E9F05j9EFZd6SW/7LjLVX7yucImPDVwxoHgoisAgjNDrQq
	Ei8uBc2AzsZtwNxLMJp8m14sm0QPXYwfjXkphbk/Pk1C6cqoJw+f5jOb
X-Gm-Gg: ASbGnctmtgpOzWXcvBqI1Mmuk3fcKk3zii3Zw/vaDLofTpuT7viY/6F9OskeaeyqWfB
	tvA8Si50EbdLtUaL2L/KE8eT4J0qw45bb4FtmpsWtNPzwZgEPQ1wVkKWy/NfxEb3Somk1bN+uet
	uIcXnjg4BDLIaOnHUIHqrV5V5FIs6z4dQVpcvg/8TQcmA66sS6UJYUK+FDRuByiy0vMO45D9D14
	5LJ6meSN1ZXcLo1frAx1zfi6/TkeFSJqz3HmGTCBN1SgBF/HOcE/NClz0mvxlOSdOLeKMoQV4qU
	WpSLaytiMmAfnRDptfxN275VY34xbR7eNK2BvaYeJ7DFwZI3oV53Pn2uAyK4ZDKsEBTXLykgKwe
	5SpBwiEi/tIIFKIciac+B0acPoHqZc/2Q/a7NgWC2Q+/VWkxC9eYJMYfsf4W2Suo=
X-Google-Smtp-Source: AGHT+IGnBBc3PTnIkHOQStT1GfBXOd7Y5JSOH57uU361QnQ+b4clQK59JKzYjcoeMR32zPHfO+e5jQ==
X-Received: by 2002:a05:6a20:6a05:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-240bd06a6abmr3929273637.3.1755164313629;
        Thu, 14 Aug 2025 02:38:33 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42d4b0ed65sm12555730a12.27.2025.08.14.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:38:33 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] alloc_tag: Use str_on_off() helper
Date: Thu, 14 Aug 2025 17:38:27 +0800
Message-Id: <20250814093827.237980-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the ternary (enable ? "on" : "off") with the str_on_off()
helper from string_choices.h. This improves readability by replacing
the three-operand ternary with a single function call, ensures
consistent string output, and allows potential string deduplication
by the linker, resulting in a slightly smaller binary.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Compiled test only.

 lib/alloc_tag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e9b33848700a..d4449205eca2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -9,6 +9,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
 #include <linux/vmalloc.h>
 #include <linux/kmemleak.h>
 
@@ -726,7 +727,7 @@ static int __init setup_early_mem_profiling(char *str)
 		}
 		mem_profiling_support = true;
 		pr_info("Memory allocation profiling is enabled %s compression and is turned %s!\n",
-			compressed ? "with" : "without", enable ? "on" : "off");
+			compressed ? "with" : "without", str_on_off(enable));
 	}
 
 	if (enable != mem_alloc_profiling_enabled()) {
-- 
2.34.1


