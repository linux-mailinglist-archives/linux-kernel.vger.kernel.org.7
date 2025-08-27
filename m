Return-Path: <linux-kernel+bounces-788377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF2B38387
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035A75E71F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759535207A;
	Wed, 27 Aug 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KDtFnkJV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809B350D5D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300495; cv=none; b=PG+68q/TwjsWKimJwhVdJAcwd560UlORnuiMj5VjLzTnaRQYtkUaeqqVYz1eb03bcQLBnonvyWyqBTKkY5Uag2YppcOFE1E0JSlXE+UbJqU5JIHTAi+dspzN6peB0E7dktGh06ofnZu79fbiOIJZK0IAe1z5RL7uxYcJH87uv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300495; c=relaxed/simple;
	bh=XlrT2E+0EqiFNR1hEH5nB82abOyfahUQ86asrTTYTQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KbfVzKXYrtrpuHOpWCnI01C+MFTGescsdLNTUJpvnNNoNvo9qmGCqAc/viSWnoZIgMNNB7XxS142t1vLn3gvyNgyg4AzsGBIcVIZrsPNzmwjPiBN6lJ5bdSrFAv2XVC2cfPbdmpmRApYMNynuqWaUrwXKyodHt/dCHKC8d0Br2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KDtFnkJV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771f90a45easo1792291b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756300493; x=1756905293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCxRte1NKL129p1JRrceqHgF7Qvqda0vWRAw+nicxSk=;
        b=KDtFnkJV8Ch+ul2nmOkjAdTlZiPAscP+H8Wpnq8GTr4r12zSR7c5IZSHeFb0i8sl3w
         mIHWOAbzGpdk/Tza07ZVpinMR4pzx9Kgwg86ICzRxU/ngzDsFFcbhyRPlb9/31iGJ18x
         q1Xmn2GAf/BoTy253yGICQHg5evMyvVLpNW6cfMdjoToa0gWLSfJBmGHc5Nk374Espg2
         OOAkIv0d1Ug+x41IOYbAHtVgYVWjBjESq8uUNpd+UJFwJihKmo7is9jznGbGiIWmOWj9
         zxLMCpwJHQEv/YPq103SJZxvHXsXVQDP4PnOESP75AOvbx08qRn2bUxgHdMysYyY0eW0
         xZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300493; x=1756905293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCxRte1NKL129p1JRrceqHgF7Qvqda0vWRAw+nicxSk=;
        b=ImQZJUHiM6NJdqXHcjbELKzBbyMA7UAIkPdru0BXEQCtWUStZcXJDLnh0D/FgaXzvL
         WYHWtNk4hoEThOCIHiHLGX3Sjjh4kErVRRmhdVIkfIqaGpX2xQ9d8vlBDVGggW7zN8PD
         YYkP+t1PrwbHTcT3ZRCGGArcvzUwNeKwgS3yMwx2qJoqvZgZOJXOyJD86cTp/8KpFA/m
         yx1XHo6jDmxcGgFgL/aPIUPa0SevFRs3s2e0U/vaSavbU5SC2ELMuThbyJymluODq7td
         dLjJMTfwXNm2aNj/7x9yhsE82UMI3Ed30S2FBF2znQ0XPb/NZX3Cup1lLBPekbYry1O/
         gV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXrPthx/4ft5xRIyR024IIqizMDwcapk7j77SguhxdxXuj4/wYG3mcQsEZV74KrxJSf17/lRWy2LDDjTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKaJj698L6iLp7TybGtmnT9db2tvaOBNbudNESKofTEpEr55T
	UtvGASxOGnvt62L5sPVlzX7iFo9QHsChpYfkQkNmn8a/Rqt+Tjq+JgGq/wVX1S53k6w=
X-Gm-Gg: ASbGncuQVESO7ltmGmdbDD3qjuCBCI8XiJT5Ec3yOYnKKmv4F9/hF1hOd8IrG9koQrf
	WtclMv5c9vls6l9rg5QBPhegqevErfH3rGeM8bAjBg/DUu/vCxQuISNCNbngy18v7J28QDPZ/V8
	9aYpxKr7uH1nu2FdKjYS8Zhlr81df/NgZ51UMlo9q62yMAAIidcYsXmFZy7uJSrNdyCqHy475hh
	M6Yc4QAjHMBpKYZy7cOCLj8whzbTqwe9YpndpRwIL0+Y6PKwoRHjBSUyN1PaGpQAOwgGuG7VBma
	xBoL4W8XtI/muZLokBjM67neWQCoO8xHc3ZIkNKchytdXYjFzkncZAbIywbHGqjEJF97AEKshZR
	DXjHF+UcoV0pB+/wgNYyKHe45puDQtp7yR1eplMh/jlj94C79QKyr2mv0ftQKJ3jLRh9ELtzCLY
	KMHa0mG7I4d5Zy4mBSbMjEGTVkKogs439WboAM/cOSTHdHYSNIRhM0aA==
X-Google-Smtp-Source: AGHT+IE9Z9uwps9teZ7+rUSweDOW5bYCtsaiBl+SAyE6ivlD/53vpBspXgu/zAQMACgkcs+vVWkSbQ==
X-Received: by 2002:a05:6a21:6d94:b0:243:7617:7fb5 with SMTP id adf61e73a8af0-243761783a4mr15224789637.12.1756300492788;
        Wed, 27 Aug 2025 06:14:52 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772017f538esm3172443b3a.21.2025.08.27.06.14.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 06:14:52 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 0/2] riscv: mm: Some optimizations for tlb flush
Date: Wed, 27 Aug 2025 21:14:42 +0800
Message-Id: <20250827131444.23893-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some optimizations for tlb flush on RISC-V smp:

1. Apply Svinval in update_mmu_cache().
2. Clear bit of current cpu in mm_cpumask after
local_flush_tlb_all_asid().

Xu Lu (2):
  riscv: mm: Apply svinval in update_mmu_cache()
  riscv: mm: Clear cpu in mm_cpumask after local_flush_tlb_all_asid

 arch/riscv/include/asm/pgtable.h  | 16 +++++++-
 arch/riscv/include/asm/tlbflush.h | 23 +++++++++++
 arch/riscv/mm/tlbflush.c          | 64 ++++++++++++-------------------
 3 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.20.1


