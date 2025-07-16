Return-Path: <linux-kernel+bounces-733749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C2B07894
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3D116EA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB52F50B2;
	Wed, 16 Jul 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5PJ1oiH"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F72F49F9;
	Wed, 16 Jul 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677316; cv=none; b=eHlOsB1nKw8aI8R1+hxi6pfVdX1MG4+qt+BqUVnf/lRKyoVvVRnrwEteY3PeMcpKrsSjMPItKE/HydffDRIf1r+DY5Svxy0Z+r6A9iH3nT4Zc+xabM5j9jvTE1CN+AuDHD3dH3A1a7sIuRN6nQ4ohAnclbNu0TdodYUlmUet9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677316; c=relaxed/simple;
	bh=c93WGgKYxxfp29gg7nVWXDMCrBR0xTxkMXa0yPKlAWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdgYAhdYj/kji7j5/iqtrrC/hR3RY3yXpjdAzEHGc1+GR8jXS3rPseYpQq12JC3IirRxfJ+TCMD+b8Nbgxv6q/OSc/WbJjU9RLfZdPyz2P9R3V/zOt6f1eyMpVbmUqJ9QQDFfzKj3YGD137QY01metBnB6DO5AY3HcEXmrF+6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5PJ1oiH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e182e4171bso411978885a.3;
        Wed, 16 Jul 2025 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677314; x=1753282114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBuMiP9J3S+amcQToXLO1ox+SOurYbRlNCMZZESBjh4=;
        b=V5PJ1oiHX8aeUW/q28JNJFVTj5VHAXkM6w7/a++B4BCxUkwjQsLlmxx7mBvj6LPGPB
         YDwFB0GM4lB5VnbRFAuRMEHA86dMrMBNic6YXgGx7TBObhsAGr4eGVGPVSUL4OEboMky
         0ASE2mZRuqQ7rFEYgeBFaP43cs0yp8qMwpcTZ1pYmvpAy5BjAnaEzb+rx6HRRYauAQ+6
         SVILojjJr6WME7iLt/NUhkkD+p6fMJh+yKgrn1IbyvEgC+wtwt+xn3EFcBF6k2lMfirJ
         UfFRir8xLZWLBXrq3tgVlYuuQJ6oLjoQEsB0bmTB9pnoWWruKdx0FIuLD+/8DVy0gX1W
         9MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677314; x=1753282114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBuMiP9J3S+amcQToXLO1ox+SOurYbRlNCMZZESBjh4=;
        b=L0UGqWtEPvCuOElyecd/gp2b5LRlq6QEDiJGne0OCDxXDJ/Z0cA74Wsea1EeT2YqGF
         1v5y2OgxRek/8G1fPqKqcqYcaqNwkq/pGccpXelGXEJxY/VM7VbvHCNGVQEDjTEzI4RV
         VHVwile5gtEfdz1a2zwyfoGmeVGR7GYZV8Laa6P5FWwRiJ5K7Zxak1pf70UP88GlKuGC
         pCPbpJROt1OzUsKqV+mQVXBMjGNBEVZfmc+MJIgWVISzgcOntTM0Hhs/cO1dgVEDLGOI
         GIur3+E6N0efJXHppFiJjKswpv202h5leLE4THpBQZzOuk48bul0/Ff2HTvlyMYHT99m
         cpow==
X-Forwarded-Encrypted: i=1; AJvYcCW7MW8X2Wv+F6ODlhFGa4aaJ8w2IrGVtigX5oQfaGCXU3EmcJKwDatbANhaS6NagnLlnr3rKngIHDzLnfSm+Fs=@vger.kernel.org, AJvYcCWnVQ2vgfbdlZd39OrKg6lG1/9aY/pZLegdxwzT9nBuzIcpBprVgRMWqoRfOqt/wOpn7XysjjfzMY2zKl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+s69TriVaHb5fQtyaeFoRMI+n4ktg2rlZyaj4R0+op+p2LHg
	7fzOi0Ng/2L+f5juEVpydIE9V7/EK/iNuKqIVGF8nr/UoJ9XK8wbit3f
X-Gm-Gg: ASbGncvLDvZPL6w6vBZLWw8Lzv19ZLklVam+7YINNulr0kP2jM5ZlPVaOZsJhyadAPM
	iPmBuw9O8qe4hg0R0elfcvve5oAMsCKwWg4+caTfA3GKiaBDc+zMlXFFo9L+S5ONfw2+J1LuxFB
	EnEAyYh5FW8R58JN6byWMxBJ4Jja40Ye6MSESF7Qxsr2sYH+PnL/ZcJTMZ1ENYdsZvSCb5H891E
	lYZzRSq2NO1DxVzKuzxmqO3rwwcS/ILVm2DMkq7vJR94aGT17Pc+aVUHJpfTKqmz2eSHNXkWBKo
	OAyJ3JjC/Y6tGmNtfn8o9AGP8W0C+NSuzEh00rCTIKnnzi4hfv2NR3v/4l+BdOZhC9w8FOi2biY
	AweNDtOLTkR5a+cl2HgCelkbi1sd5SwrYbRI8mEjdaFc666s96eabtv4asveaaNZWVSXAN0DoQU
	Jm0SrJan689atoh6rTfQhP1W0=
X-Google-Smtp-Source: AGHT+IEen7sPVbHbDqBtNGbQuhJK4XW27jvvypw9rDsAuEfM7VbAAdq+pEloPKU7fDtN8JUoXwY6gQ==
X-Received: by 2002:a05:620a:468e:b0:7e3:3065:a6b9 with SMTP id af79cd13be357-7e3433486d1mr433575985a.7.1752677314073;
        Wed, 16 Jul 2025 07:48:34 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e337c96341sm238036085a.5.2025.07.16.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:33 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3096AF40068;
	Wed, 16 Jul 2025 10:48:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 16 Jul 2025 10:48:33 -0400
X-ME-Sender: <xms:wbt3aIhTlknM7acTca9p9VKt4oKWM9q_TBwNkpZhPQCk-pvVKihbxg>
    <xme:wbt3aFlU6TfrZVc6P5ngNywzBThreAXh1dDnYRhTA0kKvkjJ4scSx9z6fVZTW-2iw
    iIAGMcSZduu63kPrg>
X-ME-Received: <xmr:wbt3aNNfDaG6kBR31WTfgpWnysI7iKYAvB3eG34ANNyGg6u_8hMW5gSpOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegffejudegueejjeeivdeuteejvdduvdduvdefledugeejhfelieduhffggffg
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrg
    hnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:wbt3aAHwCCrLwzbu1c1xEovqEh1seW4MhClDmViN0K0fx9sbHNy3QA>
    <xmx:wbt3aDsrkJN-WqKg0uJsVp9SPpT5E_XkoGSKOuEbKfaGzY9Z9-QfRg>
    <xmx:wbt3aAQKZAzhbShQOaaZH2Lug4eXU8JGWyDmB7NJcO7ywg7Sl1Zskw>
    <xmx:wbt3aNP_rvZF8QA-QdoEoGpZgnYZIStZ-sLMOOzJKi50ghfPVOa-Aw>
    <xmx:wbt3aO6DCaf8gsA6WJxVI5_rMXKy9hD5Y_q3Uc-wKd9E5CzkyKxq3FJe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:31 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 3/9] locking/mutex: Mark devm_mutex_init() as __must_check
Date: Wed, 16 Jul 2025 07:48:12 -0700
Message-Id: <20250716144818.47650-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716144818.47650-1-boqun.feng@gmail.com>
References: <20250716144818.47650-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
marked as unusable and trigger errors on usage.
Enforce all callers check the return value through the compiler.

As devm_mutex_init() itself is a macro, it can not be annotated
directly. Annotate __devm_mutex_init() instead.
Unfortunately __must_check/warn_unused_result don't propagate through
statement expression. So move the statement expression into the argument
list of the call to __devm_mutex_init() through a helper macro.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net
---
 include/linux/mutex.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a039fa8c1780..00afd341d293 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -126,11 +126,11 @@ do {							\
 
 #ifdef CONFIG_DEBUG_MUTEXES
 
-int __devm_mutex_init(struct device *dev, struct mutex *lock);
+int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock);
 
 #else
 
-static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
+static inline int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock)
 {
 	/*
 	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
@@ -141,14 +141,17 @@ static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
 
 #endif
 
-#define devm_mutex_init(dev, mutex)			\
+#define __mutex_init_ret(mutex)				\
 ({							\
 	typeof(mutex) mutex_ = (mutex);			\
 							\
 	mutex_init(mutex_);				\
-	__devm_mutex_init(dev, mutex_);			\
+	mutex_;						\
 })
 
+#define devm_mutex_init(dev, mutex) \
+	__devm_mutex_init(dev, __mutex_init_ret(mutex))
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
-- 
2.39.5 (Apple Git-154)


