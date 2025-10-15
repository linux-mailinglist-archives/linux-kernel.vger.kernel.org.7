Return-Path: <linux-kernel+bounces-853560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E11BDBFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B14420792
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC341C71;
	Wed, 15 Oct 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlx1tl4h"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64332C2372
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491783; cv=none; b=KqfGw7wy6sFTs3YQjJnCBaRDubFGFMV6sMwRvrsQQup1zSuEeV3aln4yGqT1MpJwz/qFMqYIast6Dg0Gi+C07puH5KH7t4ZuHpvJxSCeZ+iK9slWkvmdDd7GlyLndZ2TjHKePuv3Qh+YConDVzSIdTAYdB1MtzGmIkL+YYYqYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491783; c=relaxed/simple;
	bh=EkDTdmk7VtedbDx8TuiDmQUnQUo94nagjsaRQEZkOHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tluFo+L55e74kOkf8DRHOkcBS/ioPWCCWe/Y1QEtU0FUTmVNFUMcWLNptZoChSvWCTYfucimYu0Rr2XtYL7L8msHDMbvpkEZZ/bHPnSTXXDVyIbbgbLjMdwb8dS5ipca/FPJkOdVS9VL2fce5I4tJX9egz+VxZcECA8ASXxAjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wlx1tl4h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698e4795ebso58482135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760491780; x=1761096580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fvYbXimvUZhpQiNzNTlCeS9B/GqAi72nC59INjCGqc=;
        b=Wlx1tl4h/Qv9WqX9xaAg20hc84AIE4gnWq0jAT+Uq4GdyRwdJUQ9UNC8Lpahizjt2N
         smvNiPvztxGXTEfH6leWPntx1a/GPQsdr/5NHquuk5Mc55iEyYDbMCba/lMjbXPFKFCo
         kV+NDJr3m6yM9BPFZwC20QPlMwahCj8xxzNQcKfj75vmxo5sY6Ap/CVzPeXgHJKr3iUV
         hLxO4xv+/M5l9JdWMKC/g/PuGKWNWG9YkuPK3FbureJU7/yfQ6Xfc+eU4IONhxG+QRRg
         Gy51yWv6e2HQjN8gonJZ8n5dJSR+u7YRC6AsSa/6HiPkHs3gsWXFMldABlkIx9wg93a9
         rsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491780; x=1761096580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fvYbXimvUZhpQiNzNTlCeS9B/GqAi72nC59INjCGqc=;
        b=gDgc9y1LPI2uDzoXfEmgKWj6bF2zSffUr211L055+ScVRVHvYzXOlVya7KIyct8gTt
         ZbYQ1yfqD/Z4eZY7uYttMArZ/776Hf3IcrLlho8wLrVJ87kK8ftJvn2ZSBL3LCMSuoUI
         mpY6IBjpQD3QJa3NNp9/p/jouxs8ltMdDxfftOExNwSXZUo+F2z6z1b9mtuRX4BTum/C
         JpAx+6CTEJoaud9qgP5cnqIs1//dacY6ibWA4NhsQAYoynjz5e/8oG6TAogYR7Mvhg6B
         pIKAafLyKeC79QQa7iDfztYR7mEDlLTAHw8jivs8lrqZxXMYAuCE1uZNbQu/t7OdUsRI
         TzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0CodqCTpBHaJxJwN+kfhI/hLAxkeCW4/OshfaKKveHkXOTNhell/2paDwHMsKRtuvpHtSt7JwvrIfov8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv3p0TW2T8qucGLq14hTX57Bnxb0i4mIVJJgStHulDYpKGrEa
	mIaIIucIRFIyn6XcMndOCgpPECa8NXTMGxAAK9vhQxOBBZptJgRInAiv
X-Gm-Gg: ASbGnctloEAMJbRbPPVawpDDqsHjVDbA93kFF9iyb3PG6QR43ofmoyRv6MscRnqWzmv
	H4SUrkDO+00J+FR742ojVbTyKw89vuyT+zCrVL4s9qDFehRpjXJZanpTH0JO468Smzj+VU8FA3k
	X5LQ9gIRokYDdiTucHxDASy5wGLmsF+WmObldbkO1Mcckig1kfDqMojWvDNafX27guwzABftWlh
	lAsGSG0IW4FxE7kzkR96B9IXHvFkerpSwP2HoBiHhDvok1YPVYQcfmNbI0spcpmT3KVFTfxeOox
	CTGFvOoKwAv7axb/1rZpeS1NGKpyJ8DjAJ809u4kqqS8ayl/iuyNV0lXuwYDK69J+okL5r7IfJF
	VsGlUbzomqgoi/kBYT6xx/+A7wIMn6sdreJqv+B1+hAPtwbBnnw/jA/dH6FBBWrrpZheaIodUlR
	fInHH6AQ==
X-Google-Smtp-Source: AGHT+IETwzTDN79xce98tBpGmn6d5BjHIybgvoONdJrdp+zyqvV2gOBUk6dEmaq5sMqA1PTfzaY8Iw==
X-Received: by 2002:a17:902:e78f:b0:269:74bf:f19a with SMTP id d9443c01a7336-2902735639emr331745545ad.11.1760491779973;
        Tue, 14 Oct 2025 18:29:39 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.123.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deb0e7sm177275485ad.11.2025.10.14.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:29:39 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH] docs: Makefile: Sort Documentation targets case-insensitively in make help
Date: Wed, 15 Oct 2025 06:59:22 +0530
Message-Id: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid case-sensitive sorting when listing Documentation targets in make help.
Previously, targets like PCI and RCU appeared ahead of others due to uppercase
names.

Normalize casing during _SPHINXDIRS generation to ensure consistent and
intuitive ordering.

Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Notes
 - Patch is tested with make help command.
 - Verified case-insensitive sorting.

 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3609cb86137b..00c81e7947a9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,7 +23,7 @@ SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
-_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
+_SPHINXDIRS   = $(shell printf "%s\n" $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)) | sort -f)
 SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output
-- 
2.34.1


