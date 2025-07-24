Return-Path: <linux-kernel+bounces-744419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADFB10C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8838AE0F72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB032ECE81;
	Thu, 24 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpN1qSTE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8F2EA730
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365409; cv=none; b=XlruGDjcoLgSjKpjW82ZeuW0JeHzZu5TXc0Lkv8d4xhApIRk5Ty3QL+0Nkf4D4LWC8iwr37DrfdvCELLcx4rLjYNQveFOmBKaX59BWmKbM6YZZHUeE1a04rEjlLpTamqgIu76rXKa3iLuoLmppEzcFuJ2kIjHinzec6LbxosLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365409; c=relaxed/simple;
	bh=DC8BX+UCsCDL0s+QjMq45E4j2zLW64ooBSHspomP5gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQw3BgCDT4dSHd9XFpDhssa1KE1o4fSoV2LydbUHfuzmNyJpPJKgWL/X5z/n4NiE8ZrRabg6GLCkP+y0nC7lwdcVvh+Yc7lZb+09TvZJl0w45qR9xp+eXNBbDfsTvFICP6TwFiozWAvnDWKpFXSuxdJ0jrEgEcbyXGozCSFZDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpN1qSTE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1287801f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365405; x=1753970205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAPeYZVy8llrcCGwu3MIGe2nhyxNrtHRlXTr72itWZc=;
        b=bpN1qSTE5qttk/lJ/GnHbd0ERBi37+C3fAMBhgPXYw+BVR/WyOg0llV5z/0JJ7K2sm
         bDTGWXiQz/1Y6EShBsHND4rx8+2J9ALqjcHQvZA9S8raNMW9NIGuUxAR45E8oD5KIj3k
         MMeACj8mR3w8DdB1YvvhdJf0G1TcovVBN41fR8+CdmgJDlu7U4BinEBWL2j6PfzZmR1R
         WhGUVRXll9Qk0QS+28daFSbHOaE3DdEp/1s9q5S2tmvIzjk+efVkVWvH7AQ7oukiDmiM
         t3AyKk1j4j7YI6a84OnDQdFVn+XSH2YYYTVUJfV2hAAjoDwVPKh8P+A5rJcLcChPYEtp
         Z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365405; x=1753970205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAPeYZVy8llrcCGwu3MIGe2nhyxNrtHRlXTr72itWZc=;
        b=M7afl3m5kpSvJ/BsCrJ9qRBN9vU+T4MxkKf+xy8c9iXvxkpT3D9RlwsOmu1a+EeXh/
         iLHWOZ51cpTITW7Hp3Ilo7d4ZTUNzytPbAzXNES4AmqXu5KB49gXBlro0wIuU228si9A
         HL4ivpcFhQci1jUoykUEgAkyfHSG49fJlcYOxhZiBN8cJ/DOArL1hihe1GdMzT5Fl6sV
         35YKKhVYS6RXOPj/ZjhiX7bBcVSgPcJxeMlZgQ3cNE8t4BUEeqTyW3d/uubAHtOQ6vIZ
         3hYs14V6xOK+7NOIA8NLBidTDbjOydPEfuMlYXgrkVwNsqB8jMz33OlO2BvGQfQOLpHv
         B2SA==
X-Gm-Message-State: AOJu0Yybqa7RbJuBP7BQ0HWVcKpD/+RJVuAA8a62umdXa7tXAtjzbXUD
	kFA5nAiMreBTHcxHsSaaAQtIfFMYbeE1mBWUHEG0Q2abvbNppctcJxsBpgPeL1ChQ8siyxAiNnu
	55P9lTQU=
X-Gm-Gg: ASbGncsWq9Hr/DbYx9PmQRGJT/lNCJQjG9AbZ7F7YjlabUQvuE4qHzUm5Zp4nUr/sbL
	nXrCwJt8TlzpWVDwC5FSNALWxOdxjghpBbcmcjwPjecDxNZXIRq29XITOqVDGx6oFmka2kbABHP
	37XJnbv6xatd9FdcP/sSz4ghHl7IDhb6525trZfVd2nqwkL5P/3NvBqSwrhlP10eN0eBkH3iHyY
	BD/ZOzelp6HTtpOixIjyUAPs9d++3b0/hCfoen1W5xuGDK5OjgqRmCDrsi0hamh1Uu2aHr1NlbA
	BBRMSHwfotpjGlnGTCYHYhJQ0IX3Ji0E54l3J99JyAVnW2yVn+3e1ENL5vftPzCewjrSGYIYX9p
	nRMYihTqpFEkBACxzZExgzmPQ0CYpGiDnzg5wVkSFTuimvU9vUvBvRTW0ekP5Wb583uuWDbmM/k
	A6n2PQJdRqQ2d1
X-Google-Smtp-Source: AGHT+IE/tOxCaZJgBIx1z77DRVJHCm2c/RVz26viacIOb6VPqsOvedK5J5brFqoj/rS9r4t912qyvQ==
X-Received: by 2002:a05:6000:2482:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3b771356cacmr1929316f8f.17.1753365404772;
        Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 25/29] kmemdump: Add additional symbols to the coreimage
Date: Thu, 24 Jul 2025 16:55:08 +0300
Message-ID: <20250724135512.518487-26-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional symbols which are required by specific platforms
firmware for dumping an image.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/kmemdump.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/kmemdump.h b/include/linux/kmemdump.h
index 7933915c2c78..94493297d643 100644
--- a/include/linux/kmemdump.h
+++ b/include/linux/kmemdump.h
@@ -35,6 +35,22 @@ enum kmemdump_uid {
 	KMEMDUMP_ID_COREIMAGE_high_memory,
 	KMEMDUMP_ID_COREIMAGE_init_mm,
 	KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
+	KMEMDUMP_ID_COREIMAGE__sinittext,
+	KMEMDUMP_ID_COREIMAGE__einittext,
+	KMEMDUMP_ID_COREIMAGE__end,
+	KMEMDUMP_ID_COREIMAGE__text,
+	KMEMDUMP_ID_COREIMAGE__stext,
+	KMEMDUMP_ID_COREIMAGE__etext,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_num_syms,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_relative_base,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_offsets,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_names,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_table,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_index,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_markers,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_seqs_of_names,
+	KMEMDUMP_ID_COREIMAGE_swapper_pg_dir,
+	KMEMDUMP_ID_COREIMAGE_init_uts_ns_name,
 	KMEMDUMP_ID_USER_START,
 	KMEMDUMP_ID_USER_END,
 	KMEMDUMP_ID_NO_ID,
-- 
2.43.0


