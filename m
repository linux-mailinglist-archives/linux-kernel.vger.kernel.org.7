Return-Path: <linux-kernel+bounces-789737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB9B399C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6401A1C809F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074A31062E;
	Thu, 28 Aug 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEatw1Yg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337630FF3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376583; cv=none; b=AY5+LaXpB/4u7FDjszKJ64XEa50ngNLO5faHk3Z5GObunXmUnP1ksIB2ctyVmwEBawjBz18TMZPStVzW0d3o/+XEtDXfEULKTxaZnM59fG7piv9qMMkZ37A9tuiiT8Bj+d8IZjhYOzNN2+RUSSdF5u490JCZCEjW9+qm1/CWWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376583; c=relaxed/simple;
	bh=ATa5Ur6QwnSv625zc1IS75BRih4YDr/zqVuLMWsD/FU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lG9iF7mrS04VXeQ+vfuVKONyOsPbJhPbLByIS/F1C1t0b+vDterjbL0ey7myhb2f0e3l+iEOOyikP4Xe5ErxFJ/f2mSRrxOfai3xvBAZ3NK4bf5bYaEULHN8IDUiWd94me4nEJNxsLdgUdROAPlcZMLgpIS8Qy/jATWSxgndZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEatw1Yg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b7bb85e90so2801975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376580; x=1756981380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXWw7Y+UJdSBQLh/fhRl4MOI8sJec2OYFK+QWdBoYgg=;
        b=ZEatw1Ygo6QL8JbR5vrgYLebi6gyXwu758M9Lgfxcbz8L9eI8g/QfyXIeseza+4sOw
         3SoClks4X4ysztZ64LpDA0Eaps64mrcTLwIlFmeV2A1Ocyb9pB7WVTIRSGJKqH7Niayo
         nItfqW76kpuzESUujUebGEVGYze/a9pWF0hPMzqOUFDDRkgdvY00SoHMBOwqq+CjiXzB
         ZkgV2JRJI/8XZfbC9ViLc+ObI/ZJNhEoFjfHSURFqPyF5QzbZDFsyagk2RitdfEp3Xny
         F1bFGvW93aShbvoKP6LKrUnHCkgFMmJ8WTOcMVE5RYbYMzHA2deoJsuqtiQorMlXmNan
         ddpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376580; x=1756981380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXWw7Y+UJdSBQLh/fhRl4MOI8sJec2OYFK+QWdBoYgg=;
        b=RcO8QTQeqbzA/fa2XA0vWEg0eogrW6C9cA8DU8HZb5da3wXuF+hB/sag+hfpP1vTDB
         t4CzuGkh26LtFcNyflA3Z8e7/NvsbSSS80d03XWMfFxyCbvwfu1pB1hxKc+piqGwmeD5
         xUNHwA3Woxcc7BWYcmnSNtGUYF75LFPlej7L96vXxLata0174K3BGRmp0qqQf/QNnC4v
         Yvd/4v4/yukGRJcO73plWy6MvJdwnOljq9rpXq4+dW7j/+ouuuboslF3KYRdRGjUQiNZ
         ui90CfomEh3Lqth+HJu158mXz2xQJrdIn96PE7MGy6j0CR4MsybMggSLYxX6fWeNBBPg
         LInQ==
X-Gm-Message-State: AOJu0YyuMYACZXDBLAqTMMgBEW4gvRCnDn3zZyf9w2mx2vlnDCoWw8RI
	g8OCoLB/qJ4dqgXLuL/ARC68V7fLXbeSiV6u/OEuCW+sZfuZ59pVWqhQa25+WkKfrQArV49esCN
	ES0OpfjSoFuZCvVaf7hiUstpo7r6XuPZoCh/zbFJq9SBLSsv0heNiIjoFFgvTF1UFN58sG7eyRo
	9XLc6diroMWRbLISDJZs4CdRO0pab7S59Bqw==
X-Google-Smtp-Source: AGHT+IHbmcTa9uXOzfLKVnm4w8QZ3oOsJ/lxXH29qLLzB/tlHHWIOyMrZTudC5l76tIEXZKxSGIjjFAr
X-Received: from wmsd11.prod.google.com ([2002:a05:600c:3acb:b0:45b:5f83:6ae4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1387:b0:458:b8b0:6338
 with SMTP id 5b1f17b1804b1-45b6870e70bmr89819895e9.6.1756376580490; Thu, 28
 Aug 2025 03:23:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:25 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=ardb@kernel.org;
 h=from:subject; bh=/jCcOYfML0JH2E5FHnI0zJ4gY10zGaxYfVZWNXUzEkw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7tMH2RyFtySk5UujLB6vfVR4hjsk57HGk6q6T+8be
 cuay552lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm0VDP8T/fqbUpg7ot4cIX3
 Ls8hm2nrXuXcn3/fZgJr+SozrVytVob/4d7xE0xtPa//CrC89Pte1+V9fs46W1SVBT87CFztezC LDQA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-46-ardb+git@google.com>
Subject: [PATCH v7 22/22] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4277efb26358..d7af4a64c211 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text = 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.51.0.268.g9569e192d0-goog


