Return-Path: <linux-kernel+bounces-855284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891DBE0BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F7219A6EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23532D5C7A;
	Wed, 15 Oct 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hafDm8Wm"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712461C84AB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562066; cv=none; b=m883CIvYpJC3u6lmoWJonLY/22ep1rybAzLMv4y9dGdODGt9NZzuoVfhf0oZwnRNVWh6mFf313DVu3MzNZWtRgeebEMjNZ8oAYzpwt5jp40pjgC8/uGye7yVldlsZC2ZHB9Z2z9Ud8RAyIEqJZki3+LufiALJw5RAWsbM0K7Px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562066; c=relaxed/simple;
	bh=bNZ5nGNUpC8e2pvYUVL99aPY0d8SHeaESMtukQB/3XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZPBuf+wbMI0kFJctE6ZDbTcwy3NS/tExBy3gEQCNb0vrxWmEYALEZMhatuRdJKQ/P3PmTnSN+oSdtAi0wv9Ya1fZnB6L11OYPjcC1oamldMl7BPf+RtTVbMmLiBIvfTAn91RK1UdrpHOFg5owHxl1KYDk/P7UVlWb14Kp4x7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hafDm8Wm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1198333f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562063; x=1761166863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka9acDfWYNVlXTADikeAWQzZKPfls3YVu38LVwS+Ync=;
        b=hafDm8Wm9R1j2wleWPCIBHHpvUR0ANn9ufO+biLcxPUXEAux2L9IOtrX3Vhp19rFPZ
         qjQPNVq5bfe3HGSYVSLwwoS829dFnddsNDbDWSd0TPUjLbFmNbUY30DJyFitUpDBYHG0
         x8APgU618N9ghMX7ffE6Iu+STeMOKFvW2SrT7wwaNTYXWcQhRnaURbFe3hNht/pFtXeb
         5Q3u/0hMxSjInTuFvHv0Fgoyylx91QgabimnMxrWRZEpStRoRnU0hVAMjv4eC/oz2tJ4
         VEra1YLB0BzLrCTwK3hhQjL0DiW4cx5DkmqN+POgi7HMNhpFGCZOrmaWu0HDX3kXZpZC
         z+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562063; x=1761166863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka9acDfWYNVlXTADikeAWQzZKPfls3YVu38LVwS+Ync=;
        b=WmEKCyQd9B0IZ3suAMdsm3Xu/rRucHiMLgUv4NBlyz5tqwL5Hv26qYj8vOp+PqZgVq
         aosbJobsR19rssIanTyh4VjV7YD+DjZa4Y1NkN7fkEDWmv/jbpBNy5o0twr8FTIIl4g/
         9pY9PeGyEqCbbOacG0DJeW8QtHgiPtPI2Hyb3Bd/9w2cynQmjuIb38AxxWE39B/+Kn7q
         9KxTa1sgrzRcsPT2umNFj0XXmWp4a4Okkv+pGXZZDG1DVxb8SPRXRPn4EgSZuAjgEIe5
         k9+CGVtxbz1HGy4rzxXfnsac74EzjdJ0A0bmAmaVwvC25ILVBw4IL85YH35sPyXy2yEh
         FldA==
X-Gm-Message-State: AOJu0YwPiZsz6gfYVsWQ0FhFEsdhAHSMWHHnlsl2bgy1AtXfA1KAs17r
	1xnSh2FYes8LGO4EaW+hrlnMxJTSRYj3bHKFSAhtQzdi2wSLsc2n9pJ3gd4BIdv/f2Y0jGLYeg=
	=
X-Google-Smtp-Source: AGHT+IFKTW/66VSsBVsAUER/FDq7sYd1YbEd3eoZpeBB4yPvhP9MMDUr1WYotgBpEovQntSXolk5aG9w
X-Received: from wrbbs13.prod.google.com ([2002:a05:6000:70d:b0:425:f04a:4d86])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4608:b0:426:fc52:cca6
 with SMTP id ffacd0b85a97d-426fc52ce1amr745223f8f.7.1760562062643; Wed, 15
 Oct 2025 14:01:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:36 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=JyRr6WrjNMazb438tuZ9KzQEKZXISsNH26aHqvF27Qc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV2tC1n7FDTPeV2T5Cns9OHybTyotoSC/MG9h28E9c
 6e9XhzRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbibs7IcOb7w1WO7Qs+rOkM
 ELf0rhGcYyJ5Y9+Kya9PRiVKqrEftmf4Zx95zqD/wkvN1ftm2b2fulPT5faOaY7fu9K+9XRNYPV R5QIA
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-10-ardb+git@google.com>
Subject: [PATCH v4 resend 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1ce428e2ac8a..fc407d891348 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,6 +74,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.51.0.869.ge66316f041-goog


