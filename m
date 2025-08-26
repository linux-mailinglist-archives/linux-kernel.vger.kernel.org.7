Return-Path: <linux-kernel+bounces-786799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B6B36A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE36E5855F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D4350843;
	Tue, 26 Aug 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9fbn4ra"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C322370D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218318; cv=none; b=pMqaV28bBsjP2z1I2ZoWUbSmgbq7owRpjv8SF9wDb1y68v1s9+Hnxs8AZWXbDwU+7OO0z2MqSE2Q3lK5lqwrbFQnZRd6f/L4f8Uo2WWhI65fD5lKr9dcb0nG9nML08B00Nqy3hueGHWOY0tYUdnG1GNvzTvEdguvXYGRp6x6t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218318; c=relaxed/simple;
	bh=I7bDc4WqYiG+vllVsQHOIvFsu1R6QvxlldywBYYQq5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyK9ILE6goWw/eOmulHfpQ/CzrXB2QxKIgX+MZLiU75nqzThXSBhEBYFXwTFnZPoy5lUDcHDEQH23yF4xbMBS1uYv4Dw8AIQu9V/jA1KzXrVGeEAmzipoUqwPKAL9ykV8g0Pz4ZUkRs2sLSCkN3mXQeYRuq6mzryl7c0DXhCCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9fbn4ra; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso48843835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756218315; x=1756823115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ29nA28fV8jWOvE7iiCVT8Z+RtPNGlmB4/I1fLRsz8=;
        b=w9fbn4raVQmJVdlPXPWEyiVTrLseAaK4L+IDJmOClu0qeRxRzGHgnfW02U+bB7WvW0
         x2UXphxT2dYd60rz/Xh9Aa/38oj9xl3zIfPPBKEF/0HEbowGCcKDzaXYvfrXIeBKFZjE
         vSTEQFtEZzICm4pyq0YPUnhVdu73LXmR4ll18ksWyeAie0Z45LiZIfTcxrau0UnniC7j
         1T5IrXXcUNXB06tYH0UaeYLkjjeOrASWV0hxWZQEVm6aRvTTXRb+Px02tx1jQACSyVpE
         sg6QdBRPn6DYiEUGdZgTyoInj4ziSPW/DwrmXpd9aWQsvlHkEAkCEQjJvlerTpt/w8HI
         qObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218315; x=1756823115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ29nA28fV8jWOvE7iiCVT8Z+RtPNGlmB4/I1fLRsz8=;
        b=p+x77hTSJxgC9JK+p/wrOkGPAfSr+p6f4Ipf7c4LPPvQbxvWjYePupjjrdQNv74xqI
         bAMrsdxwlBKyct2gcM8Ybo1Q5+x7E5jmDGLlITmKhemqGw/9OhHn1yREWF30inqc9FHp
         Qm3EzLVSUf0K1kzj0yr08HGk9K30yFoJQHXMTUR9SY+oTuTB6QznbOaojD/68g81FEcg
         /7241dCP75zxcOAjo5aQYLYBlvdxRIF9F/66+kf3IBnwqbgTilLO5C4kNpzTGfunxUBn
         dEtPKnQ0Tzi3tWsNRLbwei1c30G++6QdgnETFR76EEuydqL7jGXqnD6QesKYML8pg+Su
         +ZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3eshoD39psS2yOkqwRyPTOwxxL8JPpCHCpzMLdD/7swjaTbGbpYvaaDJAChmzsUSQ18Uis0K/NzI5D+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuti06ekxUIjAWKnrL4nPYPV56iNc3o9U+oTdRlhOEhMEs7MvT
	wc4ZGeS2LId4vKR5cFdJw+FAOtT2TkbyZoymAXnheoGhDtW2p+zcCGGG7Uc1Vf1371k=
X-Gm-Gg: ASbGncsY0RWRoJCRoi+sfBvfkyI/U546lCR1bX80CdOtvZGQaTjWP0bQmflelNe/jAk
	0Vwds/GkztKe2hQm9rWmHRHKhwQDPAXLCQmBMs1jQM+9NmL6YufCg2kDEnCy/VdKPCSv7GPxfTO
	AGBm7dMo06dfIDb5hMA5dPiPIDWsUU5IbhI0jNiw59+2OdPvoIaiquqc4rZsYnn/hQMwcfb7O+L
	3+SA+fb0uq9wHals8RmgLV7/jvnxDxK3Da7IcER1j2iKSfe7jcdq5WsUAjH1LYKRKzobDfRN38V
	FKkBpwjWyMNusVS95hPI7GIWGNQdlZqJ7FM6PhJl9Hg8q6tfDxCpIo+C5hT4YpP7au63oXVYbIq
	QviCrLE4Pg32BgH+xnmo+rgp1FJk=
X-Google-Smtp-Source: AGHT+IGCQWWhoHPwOeoa0nwPXfab485TR9lFZBegMY6v+Zw5RTwOLAS3yNSXzzaFFagSDdR0esZWNw==
X-Received: by 2002:a05:6000:1881:b0:3c9:28f1:d858 with SMTP id ffacd0b85a97d-3c928f1dd27mr6086188f8f.22.1756218314802;
        Tue, 26 Aug 2025 07:25:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c70e4b9d30sm16199896f8f.13.2025.08.26.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:25:14 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:25:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Cynthia Huang <cynthia@andestech.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/futex: fix futex_wait() for 32bit ARM
Message-ID: <ebd4a415169f9a3153bbd3c1fe6244511c9d1cb3.1756217858.git.dan.carpenter@linaro.org>
References: <cover.1756217858.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756217858.git.dan.carpenter@linaro.org>

On 32bit ARM systems gcc-12 will use 32bit timestamps while gcc-13 and
later will use 64bit timestamps.  The problem is that SYS_futex will
continue pointing at the 32bit system call.  This makes the futex_wait
test fail like this:

waiter failed errno 110
not ok 1 futex_wake private returned: 0 Success
waiter failed errno 110
not ok 2 futex_wake shared (page anon) returned: 0 Success
waiter failed errno 110
not ok 3 futex_wake shared (file backed) returned: 0 Success

Instead of compiling differently depending on the gcc version, use the
-D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 options to ensure that we are
building with 64bit timestamps.  Then use ifdefs to make SYS_futex point
to the 64bit system call.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/futex/functional/Makefile |  2 +-
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 8cfb87f7f7c5..ddfa61d857b9 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt -lnuma
 
 LOCAL_HDRS := \
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index 7a5fd1d5355e..3d48e9789d9f 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -58,6 +58,17 @@ typedef volatile u_int32_t futex_t;
 #define SYS_futex SYS_futex_time64
 #endif
 
+/*
+ * On 32bit systems if we use "-D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64" or if
+ * we are using a newer compiler then the size of the timestamps will be 64bit,
+ * however, the SYS_futex will still point to the 32bit futex system call.
+ */
+#if __SIZEOF_POINTER__ == 4 && defined(SYS_futex_time64) && \
+	defined(_TIME_BITS) && _TIME_BITS == 64
+# undef SYS_futex
+# define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
-- 
2.47.2


