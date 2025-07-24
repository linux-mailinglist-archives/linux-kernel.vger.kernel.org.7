Return-Path: <linux-kernel+bounces-744169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B57B108F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4A81885963
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8326CE33;
	Thu, 24 Jul 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6P7hR8t"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021482E36FA;
	Thu, 24 Jul 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355871; cv=none; b=VrsP/PwQbXV4Dmk46Rr6ZsfeOXchq5h8A4/bVgVuKDG/2/XhHYt6RQVlgBSje8OEHzuw8QPvVcr2kU47iorsuQwCDe1/ko35NjAYDCgTq0wFrKVysgFs/Jy4JMaMrDTNCLF0H9zuektAiXKkkCCSjKVwAxKBzoO6Zvlty/Epfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355871; c=relaxed/simple;
	bh=zdYKkQU5vl5TMa9x0pjosTlLnSzhnbtBHscU8qg9EwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEjShYJ9HfoHXQhnPVRKE0ufX9UXU8kiZ0hSsrMbPGIkCXi89qTEAmBqPzfBJuuQBpooTtdExG+zlecrkzsTr47nmIJUCT+TJRweouMm6tBwbV51VVbDPnSycqQi3UesnK3UqR3JavksJyrLjqG09z+TehI6+xA9mNLQkzqPql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6P7hR8t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so8687465e9.3;
        Thu, 24 Jul 2025 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753355868; x=1753960668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRkq59B9tEhDiSKqsUIn5B4LQk35QuTRo9wZHWurgss=;
        b=G6P7hR8tkoJyquzEvRXVNFsBBW2kOrHZ43UXAQJNbhwxOWEkhEoKW5zbZqe1UeXOpK
         /8v1yhmK5GkcoLSCOeWeKiH6ZisxxxABIvj6jcBvFv1xbaah4BGOD9/iFSfF4HfT9uXb
         uGkYsYjFiymKdduVOuyeClS54y+u73vMiT+Ecf+sQRXI/nsE39pvgaNxUyKf7EkOUIM1
         PKWVS68PYWQKinvKkADdpMlKZl8bMLeRryBZ5E+/ay1DT6zjyoM4yA2JjBwzKNp771RN
         Il9NORA5pbm0GsWd7HlkS3IGsrOMvXJuBZzO/4E2SBu6/8cpS03DJwUqT9ItkP53B7lW
         IadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355868; x=1753960668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRkq59B9tEhDiSKqsUIn5B4LQk35QuTRo9wZHWurgss=;
        b=WczfrqJGHc6iURqMZHY6I6iSS4pg/ukraKe4luNyIAtHbaJMKR/bKQ8Pjj4oLMEdQe
         WSw+BbxbryKnnpbb2bT6qDb6ROObhhlej5eRWpt1gXgA+/6NUX1TdFearXWYSaPWWkTB
         az46ZYBWoj+Pxu1E08Yu0mcqP8xEXmSZKw7sMfBvMd7fU6QfVb2rrivNVv8gPdyvEESr
         UNqD/Va6qOfocUYmf6zOs5u+Mjm0toqQ7fbYmYHd6gOMizGQNP2rB6e9euxjx/ARcG6V
         7CsUQMSD+9/sWz9Tww8MTo6qVKdb8S54iI/gXouIUYD/3nAeB+wJHry7i3GzsJ6eIr4K
         AFlA==
X-Forwarded-Encrypted: i=1; AJvYcCXgcXWJdn/tnXcJjEzUu98pMUREyQ6VjWwZZN3JpKrQGxdNmXilLvFR1XsNUdo4sHYT0otYVnm5nkMWeJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KQoPxzqW5iGxZ+5+Rdk7dEW64MeFs/U1Scs/NSi9onVQJEmC
	+fxbW8TirJO+FZW23C5Sf+K+zJKlnvWa1/iETU9y5kMimU5CzifLkHQj
X-Gm-Gg: ASbGncs5v6N+195R9CMfNxB1sCyfAIjeaf7NLeJPdq0BIpx6WGNNLjKxX1mdC+MmBhs
	X3Wd2q4c5kxhXEIT3CxfbFEKA8geQpU7q7KXuoAYPFfGrUQ0wpU2UtvxG4l5hCTtLyq5CdIgTWR
	5tLCUNaDb9grNGtawI5sSnJ6YX3S+5u0tzs20NI0Ml+QJxtOyYkuW3m7zzlXFBmMz+s2rNKJw21
	ASq3gp/hoWZsLJbveXL2RL5ruQAQKeedYoiIovDUIUehhflrG/4KcpGkBH9DCw34Wlmv45AqOTC
	TiC9Q51PybuZroiNVfn8SNSQcwoo1hst5wVtHofsP3nfWIIAj5Bzy908VpbvzCZG6oMFijWc/qz
	BNRjCsLvJ6ipqV2AzMDJSS3ZBIuHIeTQ=
X-Google-Smtp-Source: AGHT+IFqYVFEtFdYzuAzSZtDXC2/WuGJGZhj3nj6BsxTlezVi1ODdAz5VQHu2zo5uCw6kexFMNw+0Q==
X-Received: by 2002:a05:6000:2905:b0:3a5:21c8:af31 with SMTP id ffacd0b85a97d-3b768caff9amr5879531f8f.16.1753355867768;
        Thu, 24 Jul 2025 04:17:47 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fcb966bsm1819952f8f.64.2025.07.24.04.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:17:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] samples: Kconfig: Fix spelling mistake "instancess" -> "instances"
Date: Thu, 24 Jul 2025 12:17:15 +0100
Message-ID: <20250724111715.141826-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the SAMPLE_TRACE_ARRAY config. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index a8880c62d4c8..6e072a5f1ed8 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -54,7 +54,7 @@ config SAMPLE_FTRACE_OPS
 	  measures the time taken to invoke one function a number of times.
 
 config SAMPLE_TRACE_ARRAY
-        tristate "Build sample module for kernel access to Ftrace instancess"
+        tristate "Build sample module for kernel access to Ftrace instances"
 	depends on EVENT_TRACING && m
 	help
 	 This builds a module that demonstrates the use of various APIs to
-- 
2.50.0


