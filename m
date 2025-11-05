Return-Path: <linux-kernel+bounces-886761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5642C3678C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3BC7501907
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05332ED45;
	Wed,  5 Nov 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+DRVwMt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707612C0F79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356991; cv=none; b=eVsyrFHtZUB4oIqktvWZTmitx+eIYbY6yr3q0fLi0NLT5IvFQOgh0W9/pzvnW0AiSczGKVZJMlaZ/jkQLte3cfRPUOVfBOIJ4JZB/5kQSA2xKVoNG6WGwlNRV8c/dy37psMvxySsASIzOcQxCqGzNQ6DA1xZ68AAC6Z7qgT8H6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356991; c=relaxed/simple;
	bh=DwpdGk8DQrrNe/uKiOzeaIcOB+1qcn0aryuH8E9eSzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NF71LNg2ArXStMDGaWy/mWr89qvrPiraG5WT/Kc2RypyaHNVjIhLNhTWnt85UFeBfFycvC8pbUE3XN89XXhS1yfbS6oG8m6tg/4CGK6aJ+hgq5f3UpDUZ2/i7Cwqo2vkmYP+PaXVeIW4gMrxW/er38HopdQi6zR3D5dfhs2oMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+DRVwMt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47109187c32so35913795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762356988; x=1762961788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYudu93GVCayz+03i6iP+9i2AlzyUJPPG/ZJivnBUPQ=;
        b=k+DRVwMtSxnqbrAV8aLNRScFb4ZMDhPMiZa5T7/kxle59AFipkhHzl9ywZiSBkIPvE
         /NGUlJxKavrCW00WJhHS77F4gh2evZonywzKfcd7oSjcS1JzryhXld6afNgoImfwIN3H
         tyn5hF5i1x+IWpVRrmFcf2b0oVnbacjPZo7HV2hZLDKF+PMEl9ajBZPRbkNOEsZ8Q9FZ
         Oc5Kmkmp+zLtsSIXqAa/wvKJVnuSK8fBMJuHANG41L1QCTIltc8ImEJH5Bbj11Z5v75w
         vWtJJrKUBXF1xqgjkCgJO1ECBcELWWajD4/Wo11Px1bWP0C5EhnoLHgdtdLCOIAS1sIj
         XtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356988; x=1762961788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYudu93GVCayz+03i6iP+9i2AlzyUJPPG/ZJivnBUPQ=;
        b=d2fYXjP69W26+wfG+yqEk0Pm2g0bNkEgH6+pdZxS0vJAi2N1rvpAgx3HkFgdSgunup
         Eym0aTwbyFNKBXFu+MIeYg3OhmG9mpHTzo/y9LKplW2TwRmqv0py9wlbza55SA7gh0Nz
         vq4mZ2G1NKLHSrprY4/eVZmSv9pXVfERS6OoIxN+TfiIFoKFs4Xt/gTmkQkj0PlLyC8n
         PtyvTn/B7X5XK/rNOA0f0eUJ/lOLiBlLIEDBya6uQiG16MItsHOyZEokaTC4JKp0br9p
         Xg/idQ8Z/N8oftTVwrC2omJ3z+f4t8+v66+fuYCvj4y8CjjDk/rWXslESeFdckwhNarX
         yChw==
X-Forwarded-Encrypted: i=1; AJvYcCVLVO92T9AHENgUrfHYM3CFbWDpi7yzKXusNLYHK27ur1/jl3V91yCqdfAAw9BWgazBn0OkRAQUfbqVExc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdt4Y1D8KBvTXlVJ8LX2O3cQoZ4nUesthE7QDXv+Wm41N9buGt
	zMJNsOrckBWB+rJAgZi8eM6/eTAWTSiH9quQEQHXkahj82HI/u7gy4eX
X-Gm-Gg: ASbGncs8eS51Hciq/PfRtwLg2mSdgHKnlDVUyZnlGY4d7nkon3xARTnFQqD66GjAzlY
	6TogZloemJsB9MMuxqFBY+jWv+d/7YJJSPOlgoMXAkXZ/wBehrOLzQPESVLAA+gi4rW1cf4rDlm
	6qBdhUuyaMMcsRRX3Jxg2x4gwXn3FEW9wd8y5KahpdFeLoHFyEn9+6BFZG2NWp+rAG8UjtihTEx
	CZFj80ZDiIMeiGK07zlzvT+FSCdp6c4/uqG8Jj9/wmcdkdBaXG5/2KQuDWW8alv7udfSDT0vb82
	sMmYPRgL3IndbGCAjIeEmTvgtSy97CbRy2nVj3rFN8d3QtJ8NiQ+peae1b+yLG9IycWRAprLrLl
	k3iu45y8nF8kxAmq2CUnuCt3qDDO7cjFyJ6/soyNT3FlxJKi6VwDhWMpLWlpYxqqOHIa11hO+la
	EiRgyqqzwjMSQdUkQLRPxJg3a+fmm4FURpb4g8DPq8yZmsRxFa
X-Google-Smtp-Source: AGHT+IENpWtT4ZSL+H5XwM1N45FW+HboaVYJ2ML/odNVsJHMO7wJ+lEx1bxqsvFrTW/4FE6rwMMUOw==
X-Received: by 2002:a05:600c:3b0a:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4775ce401ebmr46535385e9.34.1762356987470;
        Wed, 05 Nov 2025 07:36:27 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm11436499f8f.44.2025.11.05.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:36:26 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: hide dentry_cache behind runtime const machinery
Date: Wed,  5 Nov 2025 16:36:22 +0100
Message-ID: <20251105153622.758836-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c                       | 6 ++++--
 include/asm-generic/vmlinux.lds.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..531835e8637c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -86,7 +86,8 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
-static struct kmem_cache *dentry_cache __ro_after_init;
+static struct kmem_cache *__dentry_cache __ro_after_init;
+#define dentry_cache runtime_const_ptr(__dentry_cache)
 
 const struct qstr empty_name = QSTR_INIT("", 0);
 EXPORT_SYMBOL(empty_name);
@@ -3216,9 +3217,10 @@ static void __init dcache_init(void)
 	 * but it is probably not worth it because of the cache nature
 	 * of the dcache.
 	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
+	__dentry_cache = KMEM_CACHE_USERCOPY(dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
+	runtime_const_init(ptr, __dentry_cache);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e04d56a5332e..caef183a73bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -955,7 +955,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, __dentry_cache)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.48.1


