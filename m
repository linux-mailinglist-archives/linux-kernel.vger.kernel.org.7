Return-Path: <linux-kernel+bounces-796256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C9B3FDEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0560F7AB940
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A302F7473;
	Tue,  2 Sep 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfesF2SB"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B32F6184;
	Tue,  2 Sep 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813089; cv=none; b=Kc2KA8K72GClkQ1+MheNMWCAF/9B09NJgAvWbWZd2+Zi6j6uTGHftbbZHRGf5nSQiBP4zKcb7p/T84e54BarIfubA1wqiPAhKNpPOSpHpQrIe1R8ynjojCoVug/lCb6DuxVwDfOXN5d/N1j2ui10gPNVx4ex/56wx4h4AvUzegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813089; c=relaxed/simple;
	bh=0BNOk7DnQ2gU2VX2qS4vwjfLRZlRufEDebb3I0x8mRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+GceuDk87tN62c9uzG5gwaLLhYpuezr4PP0PlYu8AJ7qdj/mHpxfXd89nqPpmzP+u2v28JHk/3OUTxDcDMHZYeleRWZnieTs83W5O3FpRc4kmCJcjj12Jm4vAjC9aRc2cnzbJzR1o5hFa1NFAz70dz/Xeahtnr7omJJIrI2JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfesF2SB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so19562775e9.1;
        Tue, 02 Sep 2025 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756813086; x=1757417886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hif5qXX07CwCuvRH4KJg3lnRIVJYk/NjSXdW5z+Xpyc=;
        b=nfesF2SBrGrShypW4eqHvhiJOyrPxtVS0EZF1fKKMgBc1Sb6QyZSvokpikRamPc99W
         HeGHMjDku9OdWQpDJvUVIaKLvTuNp5k55ROvPdJKo0N+hgG2WDMjLe/YB38WncuE9AR8
         6lzbZX3seQOWgnx/r9GVKYBJgZJgvwqjeDr0YeKd7j4Xga0p2CHl+5srfleWH8ZAL5mm
         YnOtC2fcbHjA7YingUknC/ay/kQ70OSLZvz8h2FIY2WaijBQaGBiFsF9Qhc6G4Zkppts
         lHMS1nOCTQow02na/2QR3iaThQL/jd/gPsV9eLg69cJs1hcA+usiKlSv2gHX9Bb65DaO
         Vg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813086; x=1757417886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hif5qXX07CwCuvRH4KJg3lnRIVJYk/NjSXdW5z+Xpyc=;
        b=QCTJGRAB1gDLfp+E21iWFTIvScOpAtQ8qu/wHmsXway+ZCIjwGiM3aEzJ3Xvs4cllL
         Vn07276vkkrUTFPw4WdPfYRLRXlncYR3aZ8bbNUbiW7Fdke18GkftkNglxf0oCTMd0dA
         6G3QfBH0guf6WDKamC6lke4r6gHtYuUnCJIJmnyHNifE/13yu+tdA7Sx7XsKTLfu8BUc
         nUwxRvEBIBZPS2HpXOm14VBE6OcQtTbmeIFr3Zs5bMZ5t7jv2ZXMeQO9ufV/Xaf9DrtU
         dst9AHayG7XZjkW1F1xFHP4Un6GguzkF9bS/UDJkhC8zq3gnp84y8snT/LVPc/MIxDU1
         ucUw==
X-Forwarded-Encrypted: i=1; AJvYcCVnMMm7CXQ26+kQuoCvqcejO/fpbgKWeR6N2rI9J6+mCS+ujdHqA4Hq8klgvmgpq2XtyzFMOkBABHezMes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKXxS8DHHudi4UAZvul1gV2OlmZWBkzeSczsUUlezq5ISes0w
	E2P/CmVSnDHPZVH+KixfMrh50EZhYbRLUtLUUI+ZIb6P+y7hwB3TmFzD
X-Gm-Gg: ASbGncsc/Fe5jflqxrekHDMBDh4hxU9WaosbZsBjV7yyJz1AwOAPDOzxnq2fIPpSaj2
	rejnSrm7np3asgFsjRaIVeEm0jphrMhR2LolWo1MHhQitYiFj+4HSuR3U70l8XUmOeDW2PusRh5
	9IDMy3BFZwadKF8M/6k2fcTfyUjng8KMP+0UZ6NWqKdNTRaHLHwYIedMMG/2y25Z2BzSztHUwFi
	WA+8ybamXDZH9S1Ey/YPY/rCMWaurCll3qeB/n4sJYc0HN8XSDFIrWXHl5vvOY4i4t2H6h39oL0
	2sgkeiahUYJ24WB0fOmiC0GdICeh6SICUuYaObXU41lX1PdYYnECIaq/Wg9HRUIgfckMxDg3CZL
	GHVxVAGeEP4pG+gOmkdQyOCN7qz0k78s=
X-Google-Smtp-Source: AGHT+IHcV/9faJbkF3oU/t83AxJYwzufI3Tcr6M5GPVjIfyHH0cuQJMiFSAt9b12CujybJnM2GhUTg==
X-Received: by 2002:a05:600c:1ca8:b0:45b:90fc:1ede with SMTP id 5b1f17b1804b1-45b90fc20bemr33624985e9.6.1756813086184;
        Tue, 02 Sep 2025 04:38:06 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d9f3c36a78sm3202310f8f.48.2025.09.02.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:37:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Frank Haverkamp <haver@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] misc: genwqe: Fix incorrect cmd field being reported in error
Date: Tue,  2 Sep 2025 12:37:12 +0100
Message-ID: <20250902113712.2624743-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a dev_err message that is reporting the value of
cmd->asiv_length when it should be reporting cmd->asv_length
instead. Fix this.

Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/genwqe/card_ddcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 500b1feaf1f6..fd7d5cd50d39 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -923,7 +923,7 @@ int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
 	}
 	if (cmd->asv_length > DDCB_ASV_LENGTH) {
 		dev_err(&pci_dev->dev, "[%s] err: wrong asv_length of %d\n",
-			__func__, cmd->asiv_length);
+			__func__, cmd->asv_length);
 		return -EINVAL;
 	}
 	rc = __genwqe_enqueue_ddcb(cd, req, f_flags);
-- 
2.51.0


