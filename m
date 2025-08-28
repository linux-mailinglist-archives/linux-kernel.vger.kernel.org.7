Return-Path: <linux-kernel+bounces-789954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55ACB39D49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6F1C25F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034D30F936;
	Thu, 28 Aug 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EElO/fW7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036F30F81F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384091; cv=none; b=GXuZIqvkCaLPr1Za2RKJswBajKoP99mMfaViPBxnZD6er9Ft+E4eG7T2tLzFEMHnmARNSfxM86caOwT/ngrrNYTKNEdReXNwN/GPFVETufDklWD4OMGuI6RvfeJ3C6qbmhGHzIBWK/kx0k9qRRC0jBrirrtPFj8Fy/ubrH/SndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384091; c=relaxed/simple;
	bh=vQkMd7Qf2k97SxOL52I26gjziGPAAlEoamanWdcsTro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E6oUzGCVRImprGJ+V5HQdsv04Ei4IYN2CEBOM+tsXydUIdNY6PJ1v40Tl/rcq6SOwRneRybO8byYEXOrtZz1Qa9OMebEni/ta8fyHH8ZLRPPgy7MCyawR9QgcLICf36k7CBhoFLOcktULt9W3IoUUVO79G8rsO00eYH5JO5I2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EElO/fW7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so5624775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384088; x=1756988888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6dT2kIzhUObfcC4J3vqd7faAhyAUusYo8WMwaL7OG0=;
        b=EElO/fW7nJ9YMS2sfKjZs3SZTn36+jeozx3WnFPOsNbfJ3tMJL7iNOWJ545EDNQgrs
         bSvOUZF3339ystO4txowJFAXWpEBKHs2eDYAlKwcQBrQ7OWf0O/yqKOSudapYlT9qdId
         vguUEIzq8i7n7+Nl3EIHjJSyv2flE4iBjlhX3ng525jhHBzgXyAc0si6cbt9kvg8pQiF
         tqIJSYzTEepraqWkqxW+sy04VURrAbT+icOVI6N7H7IhggtAh7d+xinXkxcjCRDyxz4U
         Kt83SrniIrBIm3YnghdLTxQgZ6K2w7Qd63ROARf8OkJbFIJnINecqLph8cbiKOnNl+1e
         nsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384088; x=1756988888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6dT2kIzhUObfcC4J3vqd7faAhyAUusYo8WMwaL7OG0=;
        b=hn1DGWhssmJthkYQ7oJ6xPb3sgjne44KWa0ka1tSEFijNrCvCALK3jShrZErIxxt8S
         tCPyNbhDU7R6RmRERd/2Cz6Zx5bJWrIYr1T7M24pCT2/0ENeoT0nUjQYlQXZt0cPPWcy
         ImAHJmCd67rFuXqCh/VcGQRDsm6Nx2/4ln6GOatDMrlMTj8k3z3GCMylxcIQCTKVVk8b
         aiGT81fWyyRl2GXn0WZnhILtRirhbQMGPMw1m5Rt3PNQTf91x6pj3WxlW2w2ARe+vtxR
         7y96crtE/U0b0vs8G5lZGpk6D5v+nUzC1HU5ciF28wgGcovRRSWIbcQhBNthFG43gpbq
         1daw==
X-Gm-Message-State: AOJu0Yy0qxEhtDg3ZB2pBm2aBXd0Y6glFVfTAv807qQm3jGxkgrnJ5kD
	zoU8eNfl9fjbDOOVeEFdF1VaUC9CHkn+dsGxNpSJ/979NftAwxnYdP/bFw0tY2mcUqJdPXb5h/I
	cjqTERmMSuvyzpQ==
X-Google-Smtp-Source: AGHT+IHKlzslKK7RObgYwxB2Fi8fBbrlynksOPFwGRWJ5LPhLhzhqfjYPPoqRNKcPdh8DdvfOT2SAEyk1oi/WQ==
X-Received: from wmbay6.prod.google.com ([2002:a05:600c:1e06:b0:459:e01c:3d6d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b15:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b517d4580mr224468945e9.30.1756384088185;
 Thu, 28 Aug 2025 05:28:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:28:00 +0000
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250828-b4-vma-no-atomic-h-v2-3-02d146a58ed2@google.com>
Subject: [PATCH v2 3/4] tools: testing: Support EXTRA_CFLAGS in shared.mk
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

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
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


