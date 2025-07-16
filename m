Return-Path: <linux-kernel+bounces-733922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AEB07AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D925649E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF732F5320;
	Wed, 16 Jul 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Kr5bivfh"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063B1A238C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682110; cv=none; b=eDrkgTGjcXZSnujgfLKEUagekJ4iBvGYA42PSlKuRGFfBhT9zLhqkvLGSUzjahC+4CIfhBH7foKAkl5L48IF/RongudjckEV+23m7TKfelIsbHbpMfNG9JyKpj5S7P0iCQv56Y6m2TzFQ7kmMHNRhH6llsxE1sDou3xd5r7UXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682110; c=relaxed/simple;
	bh=138O41aLRx0C8uQ8nmwfBEUvIe2sl/hAJ18didtPlt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOu3iZHCIRgysVIx6tWb/6/O7Dylj7AarxLcA2UVGGbWjKPjsybSzfC89iYmCDZEHloNU76xk5AqZFNKdVN6Fb4HDyWuybpUjma1FUpEXwWqCo+0xB6CuotDPLMrEM4/8aU4FdnNM2SXXNXt88v66uedboS9bLeVkvDMyRzIrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Kr5bivfh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a575a988f9so20836f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1752682107; x=1753286907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UH/b0M0CbuYl0NcdEzspfACZMj+PvWET/pTymQ83mm0=;
        b=Kr5bivfhpGyX1p2RXnhfH9d2U+fqt7eueaJW8cR9orSkAbfP3+svPhpmV8Kc9wMAbN
         Q+L1H1UCxFcNtvXtyGuC7fyuOoO5wPZlNMfPh1NH/JFOHGcZ2/iMR/waKypVMQ5NNyBj
         +jZ7L8svVlUBWS410D5Jw5l2H/KeqGOkFjyYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682107; x=1753286907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH/b0M0CbuYl0NcdEzspfACZMj+PvWET/pTymQ83mm0=;
        b=srV8RDQOT4h6Sa6ae4ZhrOuq6EZBQW5uzJUpFIR0bUwlfaIMWYaOVzOaoxX9MBlslp
         Pf1tlk73827dhUad/1aE92/hXWOv0dPPR1TLG+qG/UiVOIGLIHIHuHLN+r7hxDFjmn9l
         xR2l0/szeAnNkDlnc6I6AVsmJaFiDwRkKdF0nfZ5aQA/E7lElNPvsWAj6dnu2WFDS7Xv
         UqiqCtEQEzP9H9WKw7DAsOQXRqjak7EjSi5hQa/okjJRUwTy4JFG0nkCQ9F0tvOT3SOh
         SWF5mpeJpvk7sVWf+C2G+3HWfX7O38iS3ko60M4AOstLKyGJ+92BED+3XIhP2k+dB7qv
         8FEQ==
X-Gm-Message-State: AOJu0YzMIwzFdGSgRoBNRgs5teEfRTL12fGEk97BmxQFCBuxmoByA3kE
	PsfnWtbzZRcIe7uPcVpqj2A32ug3x+AS5NUZ/RBw5IUgVNgSSIbuP/hrdoVapD+zARhXykpeJS5
	fs9h+SxggDg==
X-Gm-Gg: ASbGncux1EOAO8psZsCE+KPX2HezczqDu7bXqBiQZkl6gZTYVyObk0kwU1fvdglWpWi
	I87ZWZKd7o6s9lnGh0vs3LvrRbyjxhLRk2Ms9NhdCRXKLFpYEN/YVGdDPVwEIcXM0SdnmPe3ply
	0eJOL7usigU5iO0aXMLLoo+RTnQ+Ex4QnSQ7pWifd5jE/7XpGChP7t6+KR+gqkL1qiSsPF0xJAD
	brd/GihJ2z23qRC37JyJPNuL20bt6JGwkdoTKPM4bxxDJwg+Gs1CARFGRG0k/AJp3s3LoBD9aQN
	QZ/5HasT4bzYs//xa1sM22+tLYY4YF9FhnhI2oKvIzudjUyh2jE8q3oTxUGUsvgIZck4tffRcMh
	kBAFWX8vkTVUvRAJxvM4Lp3bueMqAB+niCJJtnz6tOfqybNelX+o7UusYPmxaAsFS91mlQfbowr
	jT
X-Google-Smtp-Source: AGHT+IGZut6UJbwTROIQOJAVttYNFrbwGkPjtWqxofeCL3J9C6TqdZ4W8y9PmuJpVrHyeesGriixlw==
X-Received: by 2002:adf:c789:0:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3b60dd8dce2mr2126777f8f.49.1752682107058;
        Wed, 16 Jul 2025 09:08:27 -0700 (PDT)
Received: from localhost.localdomain (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91d8sm18033125f8f.42.2025.07.16.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:08:26 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yuntao Wang <yuntao.wang@linux.dev>,
	Zhang Rui <rui.zhang@intel.com>
Subject: x86/apic: Drop useless CXL/CPX row from the TSC deadline errata table
Date: Wed, 16 Jul 2025 17:08:24 +0100
Message-Id: <20250716160824.2167709-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A microcode revision of 0 is guaranteed to exit apic_validate_deadline_timer()
early, but a better way is with no row at all.

No functional change.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Sohil Mehta <sohil.mehta@intel.com>
CC: Yuntao Wang <yuntao.wang@linux.dev>
CC: Zhang Rui <rui.zhang@intel.com>
CC: linux-kernel@vger.kernel.org

Strictly speaking, this is:

  Fixes: 66abf2388331 ("x86/apic: Convert the TSC deadline timer matching to steppings macro")

but I really don't think it's interesting to backport.

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d73ba5a7b623..6ace71c52bee 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -522,7 +522,6 @@ static const struct x86_cpu_id deadline_match[] __initconst = {
 
 	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x3, 0x3, 0x01000136),
 	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x4, 0x4, 0x02000014),
-	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x5, 0xf, 0),
 
 	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
 	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),

