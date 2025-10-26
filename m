Return-Path: <linux-kernel+bounces-870544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68016C0B184
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C707189876F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010725A2DD;
	Sun, 26 Oct 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZvNlD0Y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9AF2417C6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508739; cv=none; b=ACYT9PLCUVCZMaRcr/dZVeLPqcKZykoaPwPeMkT8fX6rF9ce9pMm/GObMEkBOpTOiGAid/b9akdK13KKZJJEdU3cdly3mxb3sSL9p2kDc8WrqUw5rJnUj6lChPdPR4CqyxBfn6fIh8Zj4CErztmGCAmfplDyKXePsM6NgelOX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508739; c=relaxed/simple;
	bh=QBZOFso+rikTeqOfG5xslpmr/o1dWQgIjC9jRe5aqxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ml6cPK2gKLwQxXn4dd+l9Q71lMhLmFTn8J8jtsZwwsR0WKJBDNpsN2tPXlX+ag8fCHl4Z8zHFxgDfAkbzkWud/Xg/8K42r3ac1MTXkV7InEa0A3Uk8OyM06poSNghDtOPLQbDFf5pDL2y1ZjMQQ4jziLVrIu6lM/cGmLN4iViVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZvNlD0Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592ee9a16adso6722990e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761508736; x=1762113536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9BW4FFJcxwWu2CsyinUCr/KixoJIv7Wl/ptnFvZ10Zo=;
        b=kZvNlD0YmOCJnNIR5I6b6ooc6sYJ/PnrnO8BLcdvQgfr2iSNjHHkdh2SEAcRhJ1Z4q
         I8pBJ1w8gkgInQ7bEKC5wu/oNWBR42TiPEKRSwcvmjbLMLE4DO5APp87IhLnN86i+WEE
         ACtFl8DY+19IR9gQJg3jf7uDKif8hfuV6ss6R8pzL2bUzgzZS1qBkUNgFvhopCLkOwb6
         uhgzeFzMlWDGuZniwvVsdW/izabTfY2V6wK6z2c0NkW9Bqbt1kucubQcMgH71GlCSVJ9
         U4e6c6qVpeuqkxw2+kkvb1L1qMfe82czxUuU4fs5RI6ehV+A3WdgRpDJCGioSVke8z0A
         YHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761508736; x=1762113536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BW4FFJcxwWu2CsyinUCr/KixoJIv7Wl/ptnFvZ10Zo=;
        b=sKdpq+Y1jS/oo78DfGuG9PzvbWzqFKkIbpsFX7Mq/2pCiL0crkTy1IRGS5+TGk0RiZ
         xk5CB7EbsRRYwTnaHXX3hUppyGXxF7k+8X2C4WX6IAz2cs9PKOgeQlxtvPTSrclV+bCV
         Z5vjmSzez9gUXJ4OoBebBh2CyX0UeFRgTEKe5ml9WY71q4XLoEqhnW/C4zWyMULGmQqQ
         ijtWKd0GecnAo2LaW/49H73wrqM4fBSWoxhK9QLt3Rmqmj9sKfz8CI59sagMA3mXRVmL
         prvJ82r0AHv/7FF/1mefyyOlCZD86q4p2rfftUHgKPEWQVeDlvmNK9GFQXYDXlRN0qUm
         N95g==
X-Forwarded-Encrypted: i=1; AJvYcCU36xKVtmx8O7WfO+4vZuXDKSy0tw9hUoayY9k4WwXCUZURKeG3WaK6ihXm6Mwl64ON2VGsz5qaBSuNuh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCYpjJVjySDf7zdA8jnsgWeuMQA4mNBjdGQvkeWbKvDidN0cD
	Z8VI4a0Qf/mD8Np7r6F8rOxgoeFqnX3ec1iM4Q9TJyVVC3dl8QioFXMc
X-Gm-Gg: ASbGncsClIquRKc7EzJt+W6BX70uq3vWjXTg9g7ReNn9OUeBvsn0AMRWC9LYqsFN+3c
	7faWZjnhpT4O7cjPTRdf59MM4WfyQiLUF0nSwibxbGyhX0d+ihXF0uk/nxrhdbwJp0Ialdc0t2d
	tGJsyX7X0QIzJ0WG54sSNsu+WcSbJzTrU7sg78sr1o9vMViZe+3K7wo76MYCmTLOKhRQY0f3tTq
	M+NJcV5ka3Y4QxsFbW4cxdGqSX9MLLYuQmKeASQEQkXs+vGx1uHDsHVH4mIstO+GVP09gbUW/tt
	LmrBUKymAjy2BU6sSemIClGiVV/FnO5oC7AevGepZqqeBUyXsZAtLDJJgzJSBS2KHq3uk0ye4DC
	HN7U6x312k1d4ukm6sNQ/kCYKBp6Z4wstlnR6xMSYqcD+9fmPhPfHfOwcn6NQxN0pcJW3VnAbJ3
	4wMnbfdz9tghiCaYNknfVBOiddV1zL0Wb9XizReNkl+GHM6vx+yqi8iXbAoMoh2AZTK5e5ZWOph
	nzkE1YZG651NZDuDuNIcWA=
X-Google-Smtp-Source: AGHT+IE9Z30YetmF5ZoMGNO3uDtCKPnBzSiGPDkXuike/MPa9JFCNcZ7+akwrlNqk9Sg7uQ2GYVu/w==
X-Received: by 2002:a05:6512:1106:b0:58b:114:b7e2 with SMTP id 2adb3069b0e04-591d8546250mr12024526e87.32.1761508735657;
        Sun, 26 Oct 2025 12:58:55 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-e3bd-e249-333e-6a5a.rev.dnainternet.fi. [2001:14ba:6e:3100:e3bd:e249:333e:6a5a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f83c96sm1773523e87.101.2025.10.26.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:58:54 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: akpm@linux-foundation.org
Cc: kees@kernel.org,
	gustavoars@kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH] headers: Add check for C standard version
Date: Sun, 26 Oct 2025 21:58:46 +0200
Message-ID: <20251026195846.69740-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling the kernel with GCC 15 results in errors, as with GCC 15
the default language version for C compilation has been changed from
-std=gnu17 to -std=gnu23 - unless the language version has been
changed using

    KBUILD_CFLAGS += -std=gnu17

or earlier.

C23 includes new keywords 'bool', 'true' and 'false', which cause
compilation errors in Linux headers:

    ./include/linux/types.h:30:33: error: ‘bool’ cannot be defined
        via ‘typedef’

    ./include/linux/stddef.h:11:9: error: cannot use keyword ‘false’
        as enumeration constant

Add check for C Standard's version in the header files to be able
to compile the kernel with C23.

Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 include/linux/stddef.h | 2 ++
 include/linux/types.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 80b6bfb944f0..aa2cb3db3c06 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -7,10 +7,12 @@
 #undef NULL
 #define NULL ((void *)0)
 
+#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 202311L
 enum {
 	false	= 0,
 	true	= 1
 };
+#endif
 
 #undef offsetof
 #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..931db48a7a09 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -32,7 +32,9 @@ typedef __kernel_timer_t	timer_t;
 typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
+#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 202311L
 typedef _Bool			bool;
+#endif
 
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
-- 
2.51.0


