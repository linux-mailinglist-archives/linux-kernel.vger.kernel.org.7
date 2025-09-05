Return-Path: <linux-kernel+bounces-802973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36DB45911
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055017C1407
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712F352FF2;
	Fri,  5 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtvAR4/W"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE25352076
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079050; cv=none; b=QrTaCA2esjXEEAKvec+Em8MPggY/kH8/DOi/TGGpmkKu50ORp+qEKguDLPOlKqA4zsfGq5VVNJ+N3tQF9lner+WW8X4fWkncWAMAgYerkAPBQtbdRF7AEQWOZTRw2qYZsFOkgOh0ljkiZqs91mMHxsAakoeQba41MuVzxpqkZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079050; c=relaxed/simple;
	bh=ECzWVd+AzMHGkO1axC4Nxd2WiHY2CoMBXtmHlgaGTvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GffghDlw0juRggT6hrSrMJmXb510OljLlQKbopN8En/MXU0F6iEwfRujiO1ZD/jAA+Fmrk5lItxXTzKj/75uaLrbbH9Yj+BA6U0YdqIorJFhERZs80rm+o8A4UOwfNm2AdxtELYVe3VUpM7Xd+YjUGZ9zafwONSQ9X/siO8DgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtvAR4/W; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso14204745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079047; x=1757683847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUi3FlPm9KOXLVkivG1TPAn4U/BsKfwoh1VfKcakJg=;
        b=LtvAR4/WArVQW1TnlYFCe/2oMHGblFXcqmpbcORaMDW8BmbYYVGxY1VA8sSIXH3zP8
         XNLPcyg2xUzO5op/qC3u4P2F9aq1fD/OBY2HDUql2wzHzI7o74ywaelMUE0S9b5dvtkt
         aNdRXPafJf7Rm65g9sgv1WTg79dvsC6XvmCh/R/9+Gd+Y7XO+ouMZrsBGdUE+dKwmBaS
         yedP6cvdZziv8YiF6reueLrnB2pcDFS6eyk6xTMpHa4T7qhBehE/Rfo5bIiN75MiOytm
         lK0a6yziAtk8Q8Q4Pv86lFMcOkD5H7LYGT9oJIDTydbsRI2O07MYET5h1KSV17VWudqW
         v2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079047; x=1757683847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUi3FlPm9KOXLVkivG1TPAn4U/BsKfwoh1VfKcakJg=;
        b=LUjWRHaN1e5+hBshkQfhOwu4BDU/VzmqhlahYlnInNo3dokKMWGwVmDxiPgC7B88dy
         GPwpbtjS482Z0QOP5WFmfho7r7Nk4DHUYg/8eusoV7kk+eCYMbgVX0gq3l+OSTEILUqh
         JpfXYRA5J9H3NalBVpy7Jz0MoRb5OJNsm4HIhfnkm0JKoDapU2QcEdXDaVCYyFXpypos
         aG2MXaJNfyAtlLGwH3Ui1q5nT6S5TMRtMMPttRm7CQ5J9jEGEG6OXRSmTUS+OsjULTnu
         jlLvl8DqIO2Jiuxn/MlGSZUcTzTCUf6tpY6FjuBQQ/wnclbZMD5QP9kEm7QkiMRGaKS+
         VcEg==
X-Gm-Message-State: AOJu0YzPsDA5RqgWIvaNjlCdOz0EjU4bmKip55TN5b1UfXa69WzbbidI
	ki1wEtv0R3flfAVItuefm2I0BH88QjKEG9pfgFs9b8udAMmRqTjIhgvs/1SeE439EKf3ELEdFA=
	=
X-Google-Smtp-Source: AGHT+IGf+vRi3XmR/QGP16LgsrUNxoVVujkhlQmO0eAfjGcLlZWZe2h4Qdaq8UaJGcAf86n7aeIE74J6
X-Received: from wmbez15.prod.google.com ([2002:a05:600c:83cf:b0:45d:d3ef:abb8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35d4:b0:45d:d259:9a48
 with SMTP id 5b1f17b1804b1-45dd5b456c0mr26381175e9.9.1757079046680; Fri, 05
 Sep 2025 06:30:46 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:37 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=RXdT7wNu/pdGAxus7uiLMzLf2wBNTNItEYxQJXgozmU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX07+PF7pdfzyJ+/va/jMpCWVesYfLU/VO3srL2bJD/
 4fqsgueHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAilj8YGT493y9u4lk5z1xi
 txTTy/Lzcl7Ji9u4P7zflnZWYklnqS/DP93qaRt32exPZ3yexOYXL//w9rNPK+5sdlVi/yC+SiB rAicA
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-10-ardb+git@google.com>
Subject: [PATCH v2 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
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
2.51.0.355.g5224444f11-goog


