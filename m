Return-Path: <linux-kernel+bounces-870028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70613C09B42
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B101F1C82D96
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049DA3043B5;
	Sat, 25 Oct 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njZ5IjSe"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E61302170
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409992; cv=none; b=uXdop49EABUPr2qPizABRtQAMfee6IfXlmbK0LCmaRWOu6H0dklmSXdnVR3ixunM+HyuTt0p78GSuCI96S9/pWxr2VvSJNcuJ7zzSW7oaddSj63a5VyeRUKicFsINR/NT908Ob5ZpFfneC6lA9EjjPzYqRfXPAO34gFK1sjL6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409992; c=relaxed/simple;
	bh=+heAOJdpmDquFU3lSVmqK3nMR1KJgJ3fOnV2yC6kTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOPvlDzIatJzAadlFoemKbezTOweEVtDwjwLLlIbz9rKcXz5HIRDEHoVf0+OD9EfnKuoco68T41Yf/seIs3BF6h6p5KX1VSe08fGYiTNEdfh5DFWh2LxIRqjSwx/Iv6ltwc44IFwV0Y7mWiQ0hhQowfHU5Z9Zfpc8TReEZQRr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njZ5IjSe; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87d8fa51993so36647126d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409989; x=1762014789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoCiVofkihU7HPUi3IX0CnSOHLAMfManJqPdcZxdW10=;
        b=njZ5IjSeYG1umnUTL7lttRp/9FMj0M/kJUZHTdbav5i/qM0Xf9IgUzK8oo4JLaWYdb
         aRNgiZXwToiRS53eWX0EpuRe9hPfm4bJDbfgU2YLQeigKpcpLwdHscivxWQRBaY+VXbv
         DZsVdODpTuKAm5NmxP4xauZzvXxUOeWXDRDXcluN4udt5YcnvYN1Jmhm4dvZ86UMZdEN
         sD53zHn0gRxfmCM61Ug1U+vEpPwmER0PKD2CiKyMkISDdqQGlriBloiUgSBS5+NbqhoT
         NkBu+5+U/RL+hZCY+9CQZ61il78Wc6qiQlRc1Iy4S7JalqTFyTaQsomslfLfNe5q2Rcd
         lujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409989; x=1762014789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoCiVofkihU7HPUi3IX0CnSOHLAMfManJqPdcZxdW10=;
        b=sV5yOVdbfvT0aCfgFxG+q2hzcZSBLiRI7ilD1EzvN+mnsbAtzz9QgKl/poLibSrnA2
         d86llKP860G8Fgmo2eV5NuevHSR1TsNRVDVYiILc1kWIqHSGmQNMuwigutX+Qq+kiTCh
         My39bPsCZrO+Tlzjav7YS75DEG/hD1sks+qiNLM+OxOEvUJpQvNhkvl4yLxxEZORTFJ4
         QF+6L9alQofVCBjrLN9bCKWUg1Rabtf3Pb9jVEbGvGEJG4I+QePMshRPRLx085i1EtFx
         sJIIo7lek5IFOe6ZvAUoDJgUgmG2pcz457sHzaSTH/reCxLJkB1gUqTKbPH987NBOVRr
         ZnSg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIwVoDF55Vn9sPdF3yuYgGbfivYrzEIhiHSxgPnGp8ZNMwOTCq43bMuisUnNoplLx5PviVAPWiD8mKBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykeflrDNdmHyoYLEYF/F+DdqGmazPK7JdURx1ekuiy2IHVLv+
	f+AnBSLNFGRk+vdb0NR9mpBISK1LGlQ5nrri18J1Dx+okajrqokB7rQFrXUZNg==
X-Gm-Gg: ASbGncsML2ttrIfnw4GqNFRTVHj6x4afU0vaV3GMpL8c15v7hhGOxH+Z2fY5WrUG3j3
	eluQ7AbOmdeUrrLivgHs0S2CNbn3BdCck/TYeUhmfIAapxtm/7mH2B6ckpAI/ckPJUcOe2wLbMB
	QbGZ3GQzJIJE69tTUqUryFTixaqxNIKRY8WTC6osdm70gKKd70GFzCXJJi8YSgU7XuTUpexs9QS
	IiQhy91MC8uaxVa7rA0RdgcItgDbBNAK7mh/FOudqwzx5FbUAjEU+4bu3aFIntKCz1yQdNBV8Le
	KgMfk9eNRagzSZYKz9KqT/IL9YL3ST/yRkm7bTKmMVuRvwuXdAj5Di6K8Gr7ksbFRYqQv0RCNOh
	IVancJUDAK6PsFgBdvYfFIPfFCQpJrXe4p+pyWglUP9MBWXyAKLjnlW4rpfDFMKq+x7PXc0wg
X-Google-Smtp-Source: AGHT+IGH02bA/hRDTKDZFiOYcreM6dX0URruEDzc6HE9hqOeDZU2lVRtUdzNlu49mj64aBg33Sqn1g==
X-Received: by 2002:a05:6214:4e01:b0:87c:21db:cbbe with SMTP id 6a1803df08f44-87c21dbcdfamr369300846d6.26.1761409988610;
        Sat, 25 Oct 2025 09:33:08 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49ee9a0sm16415796d6.60.2025.10.25.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:08 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 08/21] mfd: drop local BITS() macro
Date: Sat, 25 Oct 2025 12:32:50 -0400
Message-ID: <20251025163305.306787-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that generic BITS() is introduced, drop the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/mfd/db8500-prcmu-regs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
index 25d2d5966211..c2bbf325efb9 100644
--- a/drivers/mfd/db8500-prcmu-regs.h
+++ b/drivers/mfd/db8500-prcmu-regs.h
@@ -12,9 +12,6 @@
 #ifndef __DB8500_PRCMU_REGS_H
 #define __DB8500_PRCMU_REGS_H
 
-#undef BITS
-#define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
-
 #define PRCM_ACLK_MGT		(0x004)
 #define PRCM_SVAMMCSPCLK_MGT	(0x008)
 #define PRCM_SIAMMDSPCLK_MGT	(0x00C)
-- 
2.43.0


