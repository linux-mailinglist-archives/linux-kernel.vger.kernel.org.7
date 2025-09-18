Return-Path: <linux-kernel+bounces-823063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D2B856CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4B4A6307
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F10E30DD07;
	Thu, 18 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYjWbxCo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EC30CB25
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207678; cv=none; b=TVejd/bUDJaOjQiNosYistWnuFceSnYrZ9oZkVHPoFGWtPohWGvEdkjVG3PXYuHK5mgeL6+HYZ6lklKMX8vFQMpr9BtRqcE9y8jIyIRQuEwnroQEXu4Z3argOcyawtsk9EeaA8Ycsoz5IFUuwSVk874xSJ3YLuQkxoqs2+Qtt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207678; c=relaxed/simple;
	bh=Kd85ZUqbXMXjSsnseasdGJ1OpbHCYbM/zpeXnU30bB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHnJQust6AYxW1NqK+L3blAr4yHM1nF/bV2lFEF4xq7h8cHYjy1kFED9/6XGlOVWkQJqhYnGMqixV1C795/zeUM6rkmlkMhEWsdcajftNSneOWfMTJe8/VFC5UVZ4H3FZ9JyD2WxbQKSI1YkU9bp8Z9In559eldqeCkz1Y6y5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYjWbxCo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77615d6af4fso1562838b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207676; x=1758812476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbpUNPOiDYoiEn45wuc0crNJHXScwpSkJ4TCqMU8+dk=;
        b=HYjWbxCoZZKc5mice91v6AUfGrFqZv6ZeRdiSmoSq8+2E3hm6x1LPQ+KbSQPFElhb3
         PiTMdc/XlUsK4JfuphO7G61iDe1l+cWCDI+GLFFVL5bd+pislLD6zJ7/5y+ecibrOebE
         e1l40sy7gnZ1hn+8XNnhwzpB5ILlWsBe8+YZLfxgtqUUABL7HfIhp6WRX11S3zEF6PJ9
         RC/u1AR+cp2u/Wla6HkTU93C5BAGelrgbKpO7TF/JuatOYEYsjqXKYjuxM52A0gW6SLK
         4LkvXJLbTvzBlSkQ6WawlhZLhD9ktEtqC7+sb+8c9xKv24Z4dqA2fTmOAARc9x6ZreuU
         sCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207676; x=1758812476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbpUNPOiDYoiEn45wuc0crNJHXScwpSkJ4TCqMU8+dk=;
        b=nsGWUyvUwWGFJVYboRPppA74WJAMLNNQa3NpXBUqJZQOvxQNq+jHJE9OF7YcvzOT2J
         EJ1Z9LEZUEFDieCb9TuqtQ8xrAPrKdbYaTJHiv5snDxtUi/51vZ1tpKD/GEhq6mpa3Ae
         9/nQMGX46k5Ee2ikgobZQjoCydbLYW6VkTWy2ukTNSaH4yNb94rkO3oiFpYB3UMHeImA
         V6rbz9tStNXeWHjQf3iZnW09l8ML8Q13/Hf2kO/6fh528cVKABePi88wmBazZsCn0Wra
         9wnVLeOddgcvKw8Bq0sJAua/g7hU1f2y3FqVt2GWTrZHwXUnlodoyO0BJlbQlEKbnl2i
         T9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7MPETq+Tkz9J98wgVQ4xO25lpH8RT9vH+VSdagQKkC/Qkg0oiyO4dGqtYxjarbuZCeMkYmZSIY1Lv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn097pI7bd51nMEOxH3qxsXVWCazmEJdgrSoAT3f7gzGIozgKi
	zLB+zj1ArNJPJiYooVFfAbnt2yFwr2Ze8g/ZpDr9RND8vfdRx/NoqEyP
X-Gm-Gg: ASbGnctKHQqcxGVcW14hG9Y3iCa2V5urMccZ6B/v0VtIKs5aWayiEYP7TYAlERqW7yY
	KCNxo46RiCYSayQSR+X3hHfBGclKBdCUdVd5oejFWg6gdXUaH9ELMKacxZBiK58I0jjjq1AaPds
	3U0j2113EaZudZWozUVjtqrKpR8alCts5VSqlFxy7iywCLHlst87blQda7uArGjzDFoMKtBEVuS
	d8uBf7lWrv9Dw8x5bIuK129v1wKwCWi2IjYgEGAxDgCVh7gY/hllLjFrbQsb7++KaJ6WXrOc3oO
	hwwLPryvU9hixuRs6wAQt7Eu4ZTn59Q85DeFlDhYn61sGxsjfF6fuzYtcQbMN0aBMvzCdfgcAQb
	ki36LpGl9/cZYj9y3Z7HD/RmrfPVLiSqKl/QJPP6rhu+sMAKTq0Zc8ncAL2TmKgP3TA==
X-Google-Smtp-Source: AGHT+IErSIYbBjTISh274TM0XQdjLCNlviEsTm6HU/bE+ESPLBBXm3Y78kyPvgMPCcKp5u/y/AKUxw==
X-Received: by 2002:a17:903:230a:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-268137f1e73mr70081335ad.34.1758207675702;
        Thu, 18 Sep 2025 08:01:15 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:07 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 3/5] x86/hyperv: Don't use auto-eoi when Secure AVIC is available
Date: Thu, 18 Sep 2025 11:00:21 -0400
Message-Id: <20250918150023.474021-4-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
to force writing the EOI register after handling an interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..6dd3ae66a646 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -464,6 +464,9 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
 		pr_info("Hyper-V: running on a nested hypervisor\n");
-- 
2.25.1


