Return-Path: <linux-kernel+bounces-843563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C37BBFBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6218982BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB61E47C5;
	Mon,  6 Oct 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="obL33BdZ"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5613AC1
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791766; cv=none; b=ik+0fHomtOOAY+/ggbNE3OxNERU3BzxYHz9DB858W1FCn8bVJI6W3fvWR1xa37ZVCXEjI6lbwn6pGD2Tl2dxOXCCDevK6n85a/xQq5/T+WMhqYHRE75PH2a83lDZJascW5qYck2KLn7w/XA6N2gy4eaELoR6Kj+m9T4+xnmVSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791766; c=relaxed/simple;
	bh=STKB9sgJnmofsdL/CTVfyDM6IGK8+0SCv9N/ZkvCAiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chGiNZ5p4gtL+yI+jOugBvhvzgChWTmrminzVd5TF4GsonIpT9MjdBby71qM6zOHYAxpxM1AjTLDM+3P56nbVgPhAFblUBJXx3GkG/cGczYoTxf2nt+1kw1DT2s8QjPU6fMhM/DiEmC9Wvh9Bq31Uxk3O/n8gffUGEGfnf9KxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=obL33BdZ; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-911afafcc20so219673839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791763; x=1760396563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/04FcGUHZ4AKn3TuM7bYMUdqJTWV25qYG6FlFl5oan4=;
        b=obL33BdZKpbNvdZvJO51sB0ddOlQv04s/ntvMcnaq7IILPWkLPofGLZmQGbnZ1CXcc
         FvDxg4mena/seQ+hKwyRNaZNp8LTGcGmBnDkMak9VJsNoV4m/j5RF8pilLcPoSlXc0M6
         03U7BPhCfAIf6+r0b1R8s/Pm3Hp25OR+Iw9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791763; x=1760396563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/04FcGUHZ4AKn3TuM7bYMUdqJTWV25qYG6FlFl5oan4=;
        b=Ic1xlS+x79IWbeRsvJehpPLoE8+DXqwMgaMww0ilembzIvTRuMUXfWmLXPtp0Rf8YP
         +0pYPGC/wVVH1iUiwjtlScTyl0/gD05ALEDhxbSCsVRlf+JYR2g0X46QJ097dml9o6+Z
         VaEJkchDxpSAsmgCxBx3gPObznweFytn03ROVYR0+jgCfn15H2NazLVP3Hii+FRCNzpP
         v+qq7jiyYTWDoQW77ZmlzA87PFlAxsXZsqT2Umx4oa92NwDI1FvhrrmS9wuZNMDrKyDb
         39H+AgEC4OSBcSwht160jERgCvcRpNOh75WrQjvHkhaY90awRlfSPBGgfuFt6LmPJ4vW
         bNIw==
X-Forwarded-Encrypted: i=1; AJvYcCVvoFEtGoTE2UAmIP5ZwvrwH3wh6OMAbHYwDDzjDlIImykq8C8vyx4DT4Ot6ogdjfdZJ7ml/rup4f3Z25k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyinPvyndMWPQ5A4LaMh8HTOpeQG9hCptl/ZxspVxhp0zRlaMnT
	weIQYPmn2eh7y4T7CmvvQoLAIat0tVb6rvmUGAj2DrmbbGpaodHnFsMr5xRAQit3mw==
X-Gm-Gg: ASbGncvT2OKkIlpjYmv14VWyHM9fx/iaUOpCI6qGFereOOe/UdHIfgZQD4KoX9SuXeY
	dyM16ra5uzgeaZaiF5Umct6KHClLqsdulleFvnwDnQ8mwq4saAibXoR5vLdYeGzGnNA5e90VeDI
	GUdps9DfmUoUV962MHmzNBKFp4gvnAAk2LN2R1NkxYJO8Zs1kdDzZtmKP/lrb1aIgZyTrlT3nYC
	hAu+5QaYEBI31Jsz23tx3Q96hwqnzFsRP5Zv9aV5L1oT3FWJ+FGgctgPUbH0Xwrg8DkAj7R9CqH
	s5HNBrguOo+I7AQlI5nj6nZtMZHK5pIx5cWyeNOoCpoGnTyZyhijvLsxpF4oq9uSVpOKhBLvo9v
	mFf0GKZJ+82GQ5SUxDY3G/QOh7rMnLyxf1yKk2DX6Q4s=
X-Google-Smtp-Source: AGHT+IHT2eZsuDBZCCUdTjmcq+oBn1mLiCVw4dyHErxCXf+keS4Z7nRDbUIXhcGV5W24pJMpa8mJ3g==
X-Received: by 2002:a05:6602:484:b0:887:56f5:26a2 with SMTP id ca18e2360f4ac-93b96a9952cmr1753381039f.14.1759791763505;
        Mon, 06 Oct 2025 16:02:43 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] scripts/make_fit: Speed up operation
Date: Mon,  6 Oct 2025 17:01:52 -0600
Message-ID: <20251006230205.521341-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251006230205.521341-1-sjg@chromium.org>
References: <20251006230205.521341-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel is likely at least 16MB so we may as well use that as a step
size when reallocating space for the FIT in memory. Pack the FIT at the
end, so there is no wasted space.

This reduces the time to pack by an order of magnitude, or so.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Move the ramdisk chunk into the correct patch

 scripts/make_fit.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 1683e5ec6e67..0f5e7c4b8aed 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -98,7 +98,7 @@ def setup_fit(fsw, name):
         fsw (libfdt.FdtSw): Object to use for writing
         name (str): Name of kernel image
     """
-    fsw.INC_SIZE = 65536
+    fsw.INC_SIZE = 16 << 20
     fsw.finish_reservemap()
     fsw.begin_node('')
     fsw.property_string('description', f'{name} with devicetree set')
@@ -299,7 +299,9 @@ def build_fit(args):
     finish_fit(fsw, entries)
 
     # Include the kernel itself in the returned file count
-    return fsw.as_fdt().as_bytearray(), seq + 1, size
+    fdt = fsw.as_fdt()
+    fdt.pack()
+    return fdt.as_bytearray(), seq + 1, size
 
 
 def run_make_fit():
-- 
2.43.0


