Return-Path: <linux-kernel+bounces-793301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41370B3D1AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FF31890177
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628525394A;
	Sun, 31 Aug 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eaDFSude"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CC2571B8
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633186; cv=none; b=vC+GrXoq3cEF+gvFwH8TdNftDnndTvKzu1PwbE1CtpTFa2VUe3eTQ1nfUS9qnZIOYcc2Y7J6lrCOz1uVnupZjrgua3JXp0qWoY9tdPopOlfdAy+R2QnVsSOUumO7KtXrkTGm9hBdE84ElPTs/8rcyiEYhgMIZrmzpebO3/RTIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633186; c=relaxed/simple;
	bh=BfourEiQytOZURa51girR3hCEwPjkmcFXu9c4X2cuw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsecR0ZJc4LAB6VUeZajhV4o/tVISX0iG6boCEhtKs30GZFqjkNPBz3ZcSudgL5aU3zViwKqCpo59madlAYLEa6aL5ccg8I5B0IaQrtZCPLRjKMpjz2shiNhL75Enk6T6/Q/ZFisl9MYfU4BZi4ZI9eU9ohXaybu/nLjCX6Ovnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eaDFSude; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb731caaaso523556866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633182; x=1757237982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+6TrnZpXfWUfs5R5hmEGqosfCHRnwv9JCMokN8V3u0=;
        b=eaDFSudeE5BZ6x9Wfa8m9/TWT5TO4qKrlz7QMJ849LVN/TzSNvIfZGoEKOKFnjq+Tp
         McZuerH6rUTqP0rVo2zTjfIsXyIe/1nCDtdAWOmwCUcLqGrN1v6MocyZJtQMN+2j1dKl
         ontpP8RCt4N5y71U/VmGSwEB9ARZGelKH9xTnQSH5QRnPtOhM7Vly8DcPAoRwJ68kGy9
         BTRALVqKaTIFyA4aGZ+8iugIZEFAw7xUkn/kjdhBSSnESSGGbx9izB8/NRX0CR6YQjH+
         78sRBj7XxxS7ntscjzcif5IZX6vl6DnxyTyVjEHuSz4gJ6KNQWQ3TyeYDqJWDx67TE2n
         Zp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633182; x=1757237982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+6TrnZpXfWUfs5R5hmEGqosfCHRnwv9JCMokN8V3u0=;
        b=aOJx9iRsbKUhGebtbVBIifzX3QTwMh/hYd2w7sL0BMVRwKckSwScEW3+92m4IFcDxH
         xvchSgwxNxART4jL4ECM/UsmSOGiHuHaPKL9K7D5laXliXiDc9x6dRrOQ2z1Zg9s/kAX
         g9WnPoXXzMZxPeH+CT7Ax+l2AY/7jbATD2i3wu+l5A6zYaL8RzMWLEugvlWcZql9DBom
         Kxrii2iGpVaERnFePM23//2t2ERMZNu13BJ4uk4hN2sp5BLLUMNsOd04wSAI6mNeAZkY
         vOKreZqTmYwyK7QgYTUi/MpqzGOJlgyIUQf7ATsmKx/Vzu9Qqid8OGbjceuNPrfXbpcP
         qCIw==
X-Forwarded-Encrypted: i=1; AJvYcCVCPb0zjG0XF23P5Wz976KVmc2c+uWJMLQc8hRadHMJWuTnd5rZfTcP/ZKXbAlBNk1dMwgGgj5s2NOWqDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl/OyGZ9z1reXvAjKP1pVGpK9cP19v7LiU2WIymNwk9Xx6KPv
	0WS5uUJzGayXTmhQtohJHQ84Wk7i6+62WEFNWb/L1RPy9B9dXZNlwY41XF15rEWgEcs=
X-Gm-Gg: ASbGnctR0aXUkejRzZR5Vlc4801lha0WgxRqNxjvBetqHX5sMYYm859nnSrxk82kTJ6
	7yIA2LMtrymvukhBzQOXgcFU/hdMmzn73/We4D+SeAUWQ6oXmkF+BCM6OB1xbpsghlS5lP/AHPA
	Ecps+qXXqITq8AejWEgYVmuxWy9BNrhCFTX3oWWKHGkUf22BaaqV8jMhAtIhZDNrBg5OpgLE1jN
	Eu+3s2SWQIExQGF7Pjf0wr0AQJx2O5dBtpLRz95Kv2DN63BpkPnuQLRgSl84oBaLHpTcem6jhK8
	MLRRzNcCDVZEApEa/fvYq6uWcSWVXK8IVzlYkPTkc1GZRh7je/QV8dJm29ddtQXYCBFY9qImFZJ
	e/F6Yif2o4l4Ul/wLYb8oVaWG60GfsFn1dAPLOn3dzuDlphZtOgdaGuA0NJR8ht9Q1h5tWCG25O
	oOHPBVzwLKvLr240WfFQnki2Hj25rIv26cmEaSfmpnFsU=
X-Google-Smtp-Source: AGHT+IGKkYjGFHect88v3nBapIIglEjinBdFDzqUzlkxH0/8a2RUDjlFw52sTmajInsUVkVgdBglUA==
X-Received: by 2002:a17:906:2692:b0:b04:1896:1236 with SMTP id a640c23a62f3a-b0418961257mr125476166b.22.1756633182252;
        Sun, 31 Aug 2025 02:39:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:41 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 07/12] parisc/sys_parisc.c: add `const` to mmap_upper_limit() parameter
Date: Sun, 31 Aug 2025 11:39:13 +0200
Message-ID: <20250831093918.2815332-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.  This piece is necessary to make the
`rlim_stack` parameter to mmap_base() const.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/parisc/include/asm/processor.h | 2 +-
 arch/parisc/kernel/sys_parisc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 4c14bde39aac..dd0b5e199559 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -48,7 +48,7 @@
 #ifndef __ASSEMBLER__
 
 struct rlimit;
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..c2bbaef7e6b7 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *const rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2


