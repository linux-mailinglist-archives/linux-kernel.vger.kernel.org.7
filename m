Return-Path: <linux-kernel+bounces-752040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F0B170B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AEC1AA8615
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5752D1F59;
	Thu, 31 Jul 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwopOJKd"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E962D1F45
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962742; cv=none; b=LLqLN65OCVPaJDb4dMZLNyMseFpHSi0jOZ5GFgYt9cC8ejBEZy1/sV0aoYfeTi4jvqMsSSlNrTA4a7NdaCZk5wubKeK8R6xzWY54sBb4k/p4PagnhWzmhOWXEU5ThERgckOJHwq0jOVuZXwmqIxfIiabLKIIhbvAywFUDYKOK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962742; c=relaxed/simple;
	bh=ex7aFGh63rGWYKE0ZLNtL5d8gBsPWNlimliemfap3Gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eKb4UYJOxtoWIyoyBptKsqbmUPO2C91Xj/zSkIHnlKwROR+crUYtYK76Gu6qpBimeUPrAJXhE/LawHPkH6kX47fGETzvr8Xl7vQp31ovQRBF73jhw7xOxtrXoVSUz2uhUhOn5QzCVefabdNbTJy6pehFqxtY7HyX4zmqFjN9Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwopOJKd; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78329f180so540856f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962739; x=1754567539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GI7pfDzbEZpzy7S8dcB3cJkLd1K2BcoBH+xtJGm4Rs=;
        b=kwopOJKdzIeU8Jd4lyJaAiVJLm9+09OVCn6aYrLsqOyBjJp9tddlNcFXoSAV/j7OqX
         iei5zsNUAbbujbR+w2g9CWfSLwof8mlbmtmCgtqftDcDjszGGbHvV14AxnbSGNGDGOKI
         fBnrpKdpxrfF7fi0v2yd0yFDMWKY5N43vYRKxGkcmGmTP2U7KGWFE76GFTearRQ65P/9
         0tbqs5hNw8L+sf616ham7M0Uk+zJ6kxO0HDAJxZV8brvJAgS6bIq/lMP3UQpYM/iLEtv
         wfdqBGY/kdQV0c+RB+NmavNeuteuQ0sGU5D4dMk7AIx/K3LxN2sV/ajHfsWZM58zhHSw
         80Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962739; x=1754567539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GI7pfDzbEZpzy7S8dcB3cJkLd1K2BcoBH+xtJGm4Rs=;
        b=Jlk/E+nqWz+XLhTOdJ/oOSYkK7o06E2omQivj9bT0QRGQ6xLKD0Gh6mGnoO9XJ3azF
         9MB4ECECHpaiAoEQ+QZS03s+323wg3OztNc96uJI2ZXU3Ta1c3vHBtGK5JJeOlPCDLP4
         m4RpmfsAE8gzKKz1ndPSPQup+O14mmF4tHq3A2rXC3xkVsvIMAu+JccR1YXGO8xYMEO7
         92syqjSJunuIvJjxaHgAVxWWnpOpCPzTowXAII18Z7gRACU2iwruU2ea0H7fLHDVt3Li
         tlKx/+h70muq6kAj/ZipqkHyMVX/FYPpudPW+k8b9XaKEWv9avLG2w71EPHmaeTAmRWC
         FpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmkjKiuGsLqkZiYtdxCBiBg1WOtsVFvSPLuTUv0A2HzzIiAm0T49u1ZQ2aw0yNkTQF3nRBxOXu2zhLco0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPmr2WNVwKe1SSabxrzWxKUsWXWwZkjp4PgZw29PAy3vOzdz8
	1b2G3L/EYjgJv/OAh/iidyE9+fS0Q5Pq3vhzZafJHyGHZMxuaxACUFB+mVFkY+q+GSrl+CatfNT
	xmHqRog==
X-Google-Smtp-Source: AGHT+IFxNdx6ot8g09Y+M8mgdTgi7og9gyB3PqBmK8AEtcJUb3tDZZzVDcF7OxHvGDSE1S7lhA5lxiojGaU=
X-Received: from wmbgv7.prod.google.com ([2002:a05:600c:80c7:b0:458:a7ae:4acf])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2912:b0:3b3:9ca4:ac8e
 with SMTP id ffacd0b85a97d-3b794ff878amr5465479f8f.44.1753962739364; Thu, 31
 Jul 2025 04:52:19 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:39 +0200
In-Reply-To: <20250731115139.3035888-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731115139.3035888-1-glider@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-11-glider@google.com>
Subject: [PATCH v4 10/10] kcov: use enum kcov_mode in kcov_mode_enabled()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Replace the remaining declarations of `unsigned int mode` with
`enum kcov_mode mode`. No functional change.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

---
v4:
 - Add Reviewed-by: Dmitry Vyukov

Change-Id: I739b293c1f689cc99ef4adbe38bdac5813802efe
---
 kernel/kcov.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 82ed4c6150c54..6b7c21280fcd5 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -949,7 +949,7 @@ static const struct file_operations kcov_fops = {
  * collecting coverage and copies all collected coverage into the kcov area.
  */
 
-static inline bool kcov_mode_enabled(unsigned int mode)
+static inline bool kcov_mode_enabled(enum kcov_mode mode)
 {
 	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
 }
@@ -957,7 +957,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 static void kcov_remote_softirq_start(struct task_struct *t)
 {
 	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
-	unsigned int mode;
+	enum kcov_mode mode;
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
@@ -1134,7 +1134,7 @@ void kcov_remote_stop(void)
 {
 	struct task_struct *t = current;
 	struct kcov *kcov;
-	unsigned int mode;
+	enum kcov_mode mode;
 	void *area;
 	unsigned int size;
 	int sequence;
-- 
2.50.1.552.g942d659e1b-goog


