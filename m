Return-Path: <linux-kernel+bounces-870048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3164C09D43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C00F34F0C14
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F53093BD;
	Sat, 25 Oct 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsmtDUEl"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE32308F1B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410437; cv=none; b=H4wCxxdwuelndVF7CJVQSu+gCbdof80OFXrgFseD7ZLBwiade3hJDKwWdOMKljJdOaxROoYm+NsHkw7hROTqVoeXOVxCQOeoq02I4Lsaeb/bt3Bmj7/tolgD7wsVrcMH6mU/u00B+TUICPgHyKbxyYwVdlaAQFJIwGXe/D0ceTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410437; c=relaxed/simple;
	bh=zAr2NN3Jns2OMOMJhebylpaZ7+Fr+NR7SMgQK33hi4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKTI1IGB/eqUJDnSyZPgoKHxDI6wDV0mdPtfLxlxO2ae3UOEwWayT2wmNuSe3YNW15e1pbNhvdCSYHQiDchV63YZLShKYa1oKvC8jn526mAe8oBeLfwQaJgvutOVQ4FF8sUfEHZVsYFMw/W9LHOQtiVDpCP8pZpbQ6LXxfWgkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsmtDUEl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e88a1bbf5fso34500631cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410435; x=1762015235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=BsmtDUElEEHd7wsJHh8jVIKKqXTIIb0JCzAZ7T1NHZJtkr4OUMtnb2U7NW30yvJSP+
         Okeg2HgeZc8I+qUbWfcOvzLUkWYDIHOb5oFSJzOhmgRTjATGWoq68gw2LJtTswHzkBPY
         GlwlGcF2hQlfiUcSjS3pN6lnSbRHT6FtMnX+hDkA4B7h4YuJ4EaRWH+TsznlSyiDpIw6
         9GHIbLgZB3oCA55AOsiU3RnCWfemfhxBy0Bxcd/WjagLptzDZjLhi7ppR3XRv9bN4m7V
         HR199Zfw37czgFaP0nZMH+P6Bjp9Mxqe1yiAYTpF1z7mXJvlTLMbzw66QFfRhV6KqYeu
         HvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410435; x=1762015235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=sgwBsbnh+VFULqzFwQVKk0GicoJVi7KLw+jrx3qmPEtop+ldt6IT67BHQ1VVYEanIx
         bK33yH5qf6D0DEG1gdVCIanKjfWBEUzLYvJYBeLBM9MUlnYK8xccTrQbVJ//MsO4hm6A
         a4O275Xf9SB5DSX/ov2RSmIPzCDNRl6Pz6vYj63hyMpHPPwGu7YxfH1KmLtaNeA0+sCy
         QNjVWJxV1nzY35o2BmJirGWj93hZatzSU5/XZPepU38lEUXTdZlv1wlgwS8nQiIIDf/a
         JiO5yxjk1Oh+8lqPo2xhasEFZXuEoUIeHanvn0CJ2TcS7qtUhaFIBkAzr9ih1sgV76Yn
         FDSg==
X-Forwarded-Encrypted: i=1; AJvYcCVWs9vTD67nql7wwRDYtOdYScRyPmmpN33yZx/lbK/e0swKIV9bDNKg7eHM+eL5HHe0eByROnHhs++6y1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/n+Xjt8R8UMNi6zyrJlX7M0vfxNUH5cQ8AJsvOhX/hRaBQta
	1N+W9h6Cj6S6zz6PBFTzd+qmAw50w+EnuX172bUjL6VTVubmdjEIjnnSEz66sg==
X-Gm-Gg: ASbGnctEnGOgua276QmclVkQ0dfQbGh+Mp7meSNfL01b9/lNlhDG5cF0G+bFyQ5Djv0
	ncTbhzxy7kQMvfM4JOu1BniPWkzhqAEb9k5wHKbonvoUFg+Z+Xw6KcepYn2IAIU5zIHBvHzgYIn
	pQac1MIdjmZTikFQSE7gzRD41YDyPZlbkpQyaYq6p9Wy3jGq34vBdA7jrpjeCpq6oikqJjWcBaA
	wq6/fVBrXvm4ODOa7nNrGDULGgW/irPf9fsdMUsVXe/uoCBAVy7aBUzbis7QeVcP5p9icUOYUpw
	yLbhudcYjkxj4/bIyJA72fbXLzZNbCY++552u5tIq/gN60aHl2QqU/YeJwZb+hepyHp+joYt4Sf
	qemBuFZUXboBTJA0ywpAce4RamDuYDSJ6UUw+NfCymWcF1+hGqzK4gVkxOIDXQii/QU4QCTtG6o
	lM1ITxYxw=
X-Google-Smtp-Source: AGHT+IHB7MFietozAVdiQPNgtEHZprXNbg0Ck/iHgJxOsJrH00g2y91+bZyBuwOOlRMQWPVBX5Z1jA==
X-Received: by 2002:a05:622a:1a97:b0:4ec:a568:7b1c with SMTP id d75a77b69052e-4eca5688377mr14668911cf.21.1761410434693;
        Sat, 25 Oct 2025 09:40:34 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3e193bdsm14687091cf.10.2025.10.25.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:33 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/21] select: rename BITS() to FDS_BITS()
Date: Sat, 25 Oct 2025 12:40:02 -0400
Message-ID: <20251025164023.308884-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/select.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e23..ad5bfb4907ea 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -412,7 +412,7 @@ void zero_fd_set(unsigned long nr, unsigned long *fdset)
 #define FDS_OUT(fds, n)		(fds->out + n)
 #define FDS_EX(fds, n)		(fds->ex + n)
 
-#define BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
+#define FDS_BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
 
 static int max_select_fd(unsigned long n, fd_set_bits *fds)
 {
@@ -428,7 +428,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	open_fds = fdt->open_fds + n;
 	max = 0;
 	if (set) {
-		set &= BITS(fds, n);
+		set &= FDS_BITS(fds, n);
 		if (set) {
 			if (!(set & ~*open_fds))
 				goto get_max;
@@ -438,7 +438,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	while (n) {
 		open_fds--;
 		n--;
-		set = BITS(fds, n);
+		set = FDS_BITS(fds, n);
 		if (!set)
 			continue;
 		if (set & ~*open_fds)
-- 
2.43.0


