Return-Path: <linux-kernel+bounces-856772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA1BE508E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A6554598D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910E0225785;
	Thu, 16 Oct 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GgO485pV"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD843169
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638875; cv=none; b=c1wWBgtsnZ2+jtCfFFpkGhJQvDfhURPCkEZPtNTbNACWikse67tTXztkRyszaaWLpGBtd8QUA75XzEJhGApvFJKtd6DEELruECfct+GMBbLqHLvjZDAp4SfGicPZCQIFLg2sEljGUvNHp4/ybVa1VMMMleQnQOJHVuplJ/iQ5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638875; c=relaxed/simple;
	bh=V2FJygK4tm6d+BNOHTFEBXBfyauSBNwCr0QuV4KtwWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9XrAN8Zqht4JH4evDuHx+Ob6JfeoTO6gMhgq7RowJtbshcUx1qUBj0SdZdK0YxuEE9C+QY0fajv+Y1wMkUe7mw2vNVbBksEznAnB24C0UHsicQ5CLnhXchIsZNoLk5pXfiJPjnuEXxyNmaLOL65+SqtN8ZFyZAXdY+22FTd9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GgO485pV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88e68c0a7bfso206798085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760638873; x=1761243673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wK9rv8bnxc5kePV0bpDPajUBfSnKZNLkpRxpW0G7YuY=;
        b=GgO485pVFRV7dBmO8528CSZ9M9eMQLfzgZXf2TgcuUz090p09fpkr5l6i0m0XZWw7y
         KStD5woSII5QR6+V4UMT5cfBn1rbkLBHXbMLVRRLMgOIFU+8ySPCgAICxIuhZH4IFpFu
         RMtO8XWnfoJt0wIA0obMZI3iWlxvvkhtucOHsv3qv1ocZdD4KyNmqw/b3TpaMfbrIVJC
         oyvx871MXIGd5w850jmXCinJcCH4bqWvGAbueQF/zwQbnwiadi1+iPYx855C8PJTpb2/
         RiVJ3G6bzGteIywVFInv7naSIGesEpDhiL+Z3Mxy+sAVZbLwl/C0BWecjgJ+rZN7auG3
         56cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760638873; x=1761243673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wK9rv8bnxc5kePV0bpDPajUBfSnKZNLkpRxpW0G7YuY=;
        b=fzkHciXlLzDBcaqFTgaTZkUi1eFxPV6bPoxiuWsBszibRCkcVnfOdrLsth8MVqhVBK
         6UgjXAp+i1hASf+nRQ9O44BRere78U9VhC+Aq5k/xYs/WmvOTv1lSIyf0crzMSPZpLEu
         2/GIUu4FhNJX9yOSahv7wlSDX+ILSZ9gxMNFUxIJCdWDgw7b199iga9MHTM77RqgBbLA
         qNiU570eQeVk1NEF04swqDjztTPUDngfVGWo0KhWteJaHljZ/B2+n3jfSH+6ra8b1uiN
         7Io+J2XnR9S6A1k/5jfgKKdHqehc4hjqYYghghi1uPEScXZ0lYccwe22gi70W32U1qoe
         YrKA==
X-Gm-Message-State: AOJu0Yy5G214dP3Uga4H9eTwV+n9TUkKVf9i4TFB3wEthfNxqalZXNRD
	n8uLAMk/E+sqxVTDtBO3MBq5AKAXAXeqxF+FK0yDcMrH1NVH7tC3UoJj3xmrg3tXvjLFUhgnhMy
	Tx7g9
X-Gm-Gg: ASbGncvw2H/lwa0oLR9ZOjanXgwW+swK0CdKrmDttXropsnZs8eSE8OE81lOgXcfH23
	JgiqB6a4+uyzh04WebkPZLn07hDAcJukjfLqX/eM1mvRM21Jhx9x6MzM4khcTHgI2e5koY8NKfq
	zZ1ejVovf45SkUpu3OHePfrVddv+/x5OGD7UhBCXa14ZlrIgP9hCYT9RzADbaXwabBr84/1EJ+p
	ZhhJNCVQLig9NNVqQ8pfyZy0R8sCPcKSND8Z4N4MkoSs4GhNCS6oHFtl6fZmLjVCp6IXDNrdeFG
	QQqLc6QvcWejyRvaZP1/cS/knnqkqA5mPmTVpDF9ElQVHU3YExYz8bRv2Y4nnYbDtWoQsLXWJNa
	zcqiM28/7FX7aY+emSaY545pVPOOpi21LH70HID9tC89hy0gko5SzNcc2YdmqvPRgGoFD67Ck5E
	BUPvbkWSqx03iCkJYYshUbv2Hq6LLjgez/v1bc5cMX51Nf+O2ZlG4uqJP+HvS0Z8sJ9aJ4eAhei
	Kw72nYhwnvTWw==
X-Google-Smtp-Source: AGHT+IFYlmMMl8rx4JxMEWSlfLPkfLpLDj2C06fOso9GkUbdFSRTp9eVd2E+73dhiieMn0BcTJ8/vg==
X-Received: by 2002:a05:620a:1919:b0:870:6891:9c1c with SMTP id af79cd13be357-8906eb93bfdmr146403785a.35.1760638872644;
        Thu, 16 Oct 2025 11:21:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f35c67577sm253174685a.25.2025.10.16.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:21:12 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peterz@infradead.org,
	mario.limonciello@amd.com,
	riel@surriel.com,
	yazen.ghannam@amd.com,
	me@mixaill.net,
	kai.huang@intel.com,
	sandipan.das@amd.com,
	darwi@linutronix.de,
	stable@kernel.org
Subject: [PATCH] x86/amd: Disable RDSEED on AMD Zen5 Turin because of an error.
Date: Thu, 16 Oct 2025 14:21:07 -0400
Message-ID: <20251016182107.3496116-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under unknown architectural conditions, Zen5 chips running rdseed
can produce (val=0,CF=1) as a "random" result over 10% of the time
(when rdseed is successful).  CF=1 indicates success, while val=0
is typically only produced when rdseed fails (CF=0).

This suggests there is an architectural issue which causes rdseed
to misclassify a failure as a success under unknown conditions.

This was reproduced reliably by launching 2-threads per available
core, 1-thread per for hamming on RDSEED, and 1-thread per core
collectively eating and hammering on ~90% of memory.

Fix was modeled after a different RDSEED issue in Zen2 Cyan Skillfish.

Link: https://lore.kernel.org/all/20250715130819.461718765@linuxfoundation.org/
Cc: <stable@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/kernel/cpu/amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5398db4dedb4..9c3b2f010f8c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1037,6 +1037,12 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
+	/* Disable RDSEED on AMD Turin because of an error. */
+	if (c->x86_model == 0x11 && c->x86_stepping == 0x0) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
+	}
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
-- 
2.51.0


