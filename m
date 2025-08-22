Return-Path: <linux-kernel+bounces-782600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77FB32290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71AD189CBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EF2D23B5;
	Fri, 22 Aug 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k0Yu2GqY"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DA2D190C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889318; cv=none; b=o3onK0P8hf78kT4gppBnNrgg88xLTx+QPGi0dp5AdzdaWu8zC2ai/L+uP5t+cSXC04Url7FlIkHXzsuOxw91qsPhehhW8onVYXos48uE24GGLR4DTUWiTv4pV46Tlj5+1B4xqfwjg4pr+mdIVzAbG4gqTrmjyvuqnPP9a4dtWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889318; c=relaxed/simple;
	bh=Z9+YIhD1uTOT5saJkNAsez0Hs6ARMCMfX4GIc4ITcto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FclqWrKea9F/pSYChd7/rplhqBT58ko0SCOPhZIW2atPfjOpFF6q5DsrU4X020saiidE+G1dOKpp3cLwPXodJghmQs/mo65H8HujFTyw5SfPeBbqMBlJVc+w3GFQquLIU5VTKh2ybeC0mr8Gzjy/iP3pXl+aP3dELR3ptPm5mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k0Yu2GqY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso2026758a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889316; x=1756494116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysw+3hrIgiJrYdQABB3+Dt5DgMOw9tDOT9yOl9vUjGI=;
        b=k0Yu2GqYzip6XibRR2bsbzbHDosvwNLw/QIWNcCeGnor08Kpu7TEc+iPR3qLEfwoDT
         D2zgIey6Hv+3HkYouZcWD3M7h5z8h0A9Bdhh4kF0zKTgYAe0PnsrIVP86yenoFiGbeOx
         NYE8x2OX/Nldivgptk10mEhmdSWY//gFq1QhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889316; x=1756494116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysw+3hrIgiJrYdQABB3+Dt5DgMOw9tDOT9yOl9vUjGI=;
        b=cwRooqWYBufOfadqBPrvqcLmeyaUlk6p4zMi1PDKeI6XWgHtyP+wJDXSHA8Xduqu15
         cu0S9ui9xwtys+adCsKTVBlJGFdgemzMH92HNIjO8XmYBgZ9OI0etbvxTTN5b3iqzC8m
         cqB+68DiRq6uVTFMqOWvPR29IYl5Hm0B5Ui6oGzwvKNIQZ8GjX5oWL1ci7i5IOXaz5P3
         ceJqvxHxPlinUBpqBxSFxYEGxq1QUsC5vlaGCeTL2X0I+jDjeEN9Hcl2M3Sd2A5HjrKR
         MvLKrehbAMWL/2+JDuNjtOtdgFnmC95mqBVwQbz3U7C4DuV6NITOIn5tp/85czMPxcB/
         XGQA==
X-Forwarded-Encrypted: i=1; AJvYcCWqM3jCNSVGWEauzLSE4CMIzbF+8Vd/SgM8XXo/dMzuXGN5EitQbZAl6O/vJAsPn9K58eYkUsDvhPAp7Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnxTqtahhH6KBxn3/aXwDlQK5oN5Xmi0RJbx75859Dz6/jtQj
	rKinbo+jpI6Aw8M5eXCrSF/tpWHdErB2hphlu6tM/z/KeuFUSBpZrKSsd5uUP+mA5w==
X-Gm-Gg: ASbGncvixsoocp64U5pMlqYpY9z3SfmdrBgsTRZF9uur/3mtAcKIB0IrNQw9B9BrcJi
	TNnwKNrWjttpw5j5QxSW1pBju15M2tj2zX2exR9hgn1lVQOc1eHh3Bk77qEFd4DJSvBUIeiZIFz
	yZAgr18NMxkFGgvgkSvmNttnghtDb5oW35w2zju/MxCN27yw6+nX2wt7D2hoJ3CZFDjXYqs7qS1
	7YlwBVUJYJoVLdQepFJk7TeGg9dUfIQOCQ6lXwqvjjZnFqKTSD6VwJT8Qrh5s5xxPZhCQhRvK/5
	/WF0RfyOQc5KC0iUk8y6R3iSt76VcDjXRgTWYV9w/gEpS1orxzhO/ceA9uai7Eqa/DZEeuBS1+f
	HFMIn803wUVtwwGEH1xXKfjKgZgXlVtH2pXJBOi2czSALM25cqfQZtxMjGZLVwFnODe2opQ==
X-Google-Smtp-Source: AGHT+IEqFAw76Lki0zkjH8qAF8RoMhFiXS9rdvzirdsLGc0PWioCNOpwr2TSYXdI2BqzX0XONe8bMQ==
X-Received: by 2002:a17:90b:1dce:b0:315:af43:12ee with SMTP id 98e67ed59e1d1-32515ef8aebmr6307614a91.16.1755889315976;
        Fri, 22 Aug 2025 12:01:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254ae898fdsm401806a91.7.2025.08.22.12.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:55 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
Date: Fri, 22 Aug 2025 11:59:05 -0700
Message-ID: <20250822190140.2154646-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
References: <20250822190140.2154646-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures have a rather static IRQ layout, with a limited
NR_IRQS. Without SPARSE_IRQ, we may not be able to allocate any new fake
IRQs, and the test will fail. (This occurs on ARCH=m68k, for example.)

Additionally, managed-affinity is only supported with
CONFIG_SPARSE_IRQ=y, so irq_shutdown_depth_test() and
irq_cpuhotplug_test() would fail without it.

Add a 'SPARSE_IRQ' dependency to avoid these problems.

Many architectures 'select SPARSE_IRQ', so this is easy to miss.

Notably, this also excludes ARCH=um from running any of these tests,
even though some of them might work.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Make all tests depend on SPARSE_IRQ, not just a few (resolves
   ARCH=m68k issues)

 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 08088b8e95ae..a75df2bb9db6 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -147,6 +147,7 @@ config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	depends on SPARSE_IRQ
 	default KUNIT_ALL_TESTS
 	select IRQ_DOMAIN
 	imply SMP
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


