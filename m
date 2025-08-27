Return-Path: <linux-kernel+bounces-788161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F98B38080
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70700189D98E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8734DCFD;
	Wed, 27 Aug 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7CglR45"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA02C08CA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292691; cv=none; b=AnzbXwUARpX/zwPNqO8sljZvAmJL/dhH0bYV8HoVp8QivSlovu/NtEnyBNEIyrvwB3BmVp1ubxiV9ylpF0R0lQtACHpJtNLCWWQ2FybIImfcwrjij8K1/b+arArZmrDeYrTWc/jgr9XSs3ZVDKhaEzazVO0nqDXrqKfW8snqdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292691; c=relaxed/simple;
	bh=9Kd9r8EWcGhXM9Z0go2oGM47zU0PnGfjgD38W5EqGLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNrtg1w6y4NquKFSeCxJG3iqy0QoDWo8MCqOHVPZ8NRmL3zTnCY8mFMGJHxVUYBZ9hcv81mJmRPEQm7V0ohIOe6r/UExtyiiYUFomFi3F8QCW2yQ06F5nTehO8bHDRgULb1KAtshxEpJIfsfp85oce4SpgWyMHc0JRxFaVVDR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7CglR45; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61c524e33d9so3409545a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756292688; x=1756897488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nf4CiXWHDpJDlUPbhGw995yPVPVvyqVPHVSb+srJYto=;
        b=y7CglR45+wclbtO8eHXbKeSdReA96QxHd++QE5gcPamd5qmaJNGj3Ve7b3PYASfAKt
         2cGRSXa3Yol7eIboCw9v+3CGZWAauyY/qyh5nvzjZWOZh6++/PzjXI4GkTcgD80eNraF
         51Yv4OCgU4kviycu/EU4x5PmV3mb0GxSpvmCywlzHprhywEm5hCMYDDVgVDixLiwpB8f
         kBDfp+0XfU3+gbdK5A014b0TJkIVAGCmELQLWzcA2wgSVdJRuHDBwcVUBWlCkWEiGDkc
         QELi+mOlXjDPXa05vIw+PIVwmIiRB6v6WYxIf2VWPuiuWsz/F3zYmppVqfanRCVtkGsK
         vCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292688; x=1756897488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf4CiXWHDpJDlUPbhGw995yPVPVvyqVPHVSb+srJYto=;
        b=JRwm4VzgbohetgfYtUPWjx/FdtoJ8vVLBEbg4avBLh4N7hLKV2VUwitOb0plivuQKC
         s+50klOC8djPikSzyHHINwq6hLRRnmiN5cMCJEXmm/cHQLkCfEgO5SXTAMqipRbI6308
         J6pxSJo1ZEw5fIQDUD7B+lZLIZeKfHZ8mKy0/JmjBikyGxX5mivXd5P3KGxvWyV89ui/
         J++uwqD8MKCugJVyq4sd16W7vQ8d5oAViJn1rKQ+2bTUQsO242d2j8kWflseSKunK5Ok
         ovGeT0j3LoizmSVG8JAoNeyOeBFWRSbOHSpt5TDygqq6l9MkzOXKPNTUsAfIwFgBwtOB
         29VA==
X-Gm-Message-State: AOJu0YzFfzWq2wZPuL011sI/fke+7vFpf6V7S6dGm/xucj5b+u9VwlFS
	FUKmvYa9sEOKH19T+2m2sg0dAh+bqanFgp3a8QP6xcP4NDEoSz8VPAMFBL8k+z//AoNzwOkKm4B
	DhY71FPIIsaI8jQ==
X-Google-Smtp-Source: AGHT+IHrZXwCVvuqupUKpT95XmcWj4Xa/7qE/DbFzWdo9LcsAOtZKdLGvcR+C3sRuAOM6hlRZPCPsneY5yWc2w==
X-Received: from edbes5.prod.google.com ([2002:a05:6402:3805:b0:61c:8c63:a94d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50d1:b0:61c:b951:adb with SMTP id 4fb4d7f45d1cf-61cb9510f08mr777554a12.9.1756292688190;
 Wed, 27 Aug 2025 04:04:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:04:43 +0000
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
Subject: [PATCH 3/3] tools: testing: Support EXTRA_CFLAGS in shared.mk
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This allows the user to set cflags when building tests that use this
shared build infrastructure.

For example, it enables building with -Werror so that patch-check
scripts will fail:

	make -C tools/testing/vma -j EXTRA_CFLAGS=-Werror

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/shared/shared.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index 937aaa7623320da1085a8e0f43f6a728ddd3ab1c..5bcdf26c8a9d51ab2cbd264f2f8a7445d7c036e3 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -4,6 +4,7 @@ include ../../scripts/Makefile.arch
 CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
 	  -I../../../lib -g -Og -Wall \
 	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
+CFLAGS += $(EXTRA_CFLAGS)
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS += -lpthread -lurcu
 LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o

-- 
2.50.1


