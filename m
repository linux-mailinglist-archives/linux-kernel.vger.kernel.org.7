Return-Path: <linux-kernel+bounces-870037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6CFC09B70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6781AA7729
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2830F7F1;
	Sat, 25 Oct 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CezVpZbP"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD230F532
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410014; cv=none; b=LJKyyTNKGAKY0BWNKZEUsB1+CHf4Ev+hMUndOLBk8bsnfivmq/VaSF947wif6VOGC3II72uWDIgwBBv09kBzAbSujTBHxIJyq2jFdmZ6ZFnWcRl3bhz6D435wAUcI1roWwKzmSiz+D0hnqhbQ5oaPCz9/QE0lVNjyCFYfC3VFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410014; c=relaxed/simple;
	bh=1bcynx9xewGI6dVd6TNDYQ5HTZ9qbz+hT47nRzvSCxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0kIzq73Zd9KskKM/mGNVNS7rPILEfCXB+lbN3V49QbLtP+cAYPydWCs7tk8Qo+mvMnblwMdgeOeaCD8bFfNmneJWwyVc9Um8b9/d4KcKczXylbD4f1Nq0HQMmVunFNmSqNt6nWEqf06C4h4ed6QPGyNnghbQtrVE8rsB5/mn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CezVpZbP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c1f607e72so36389766d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410011; x=1762014811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GldqH8fEtUrzkHne1rF5BgiofNp7hGD1Vw1w37mqgw=;
        b=CezVpZbP3pH5LRxpguyNt/Z4ptFP/nfVlKj9ioNKbrVfmu+Vi/QdWgM2GeHRux+eL6
         mTItHuU94j53UEz+AmG6ta5NYFLnxwWW/K+/TR8nGVDKsqCMXMX7ruG2Kug7TIfwsETe
         6aAEQuqRdsc1bXK7zT1pvlNYubjv+M8v1bVg8SCZQcSL2ejGYhkcjMbrgfWklB6lmV8O
         27CsuB4osWquggTchYt8AapkX3z5WQcqJYIdLPfjlP7Kp93D+rQqgBCu4ebkcuCyAfqc
         f4ba+MSGAZL4CkgagsJTuUqxOt+CuMTeBg7x7cALg7HVE8046LIAlFwYIpRkxkOtkWgC
         HWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410011; x=1762014811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GldqH8fEtUrzkHne1rF5BgiofNp7hGD1Vw1w37mqgw=;
        b=WP88khh2gGn56h7L/qHFRJwYvXUADhg6ZXvRaTqEOMSndVXW//AQq8oNf5kqH8Lnjy
         qlJmUumSi/h6XgQtxEs6UR8o+cW5WLN0w2wmw6pQjpMUo/6IQR4Su5MEtAcSKkCgiPy5
         x9R6BV/OirpPnL4RSDKEIItzig+byBPl03PvC01x9XDP4EUR/gHaG7aCc9clQZs8Mm8a
         AUKyUj9uCOgPGHa2pEIgx2+/uzYLVlgCy2hvhN3ldw5lsEznLT3TJSQnNwBqNt4s4Uk3
         ezomKwYdbD5+fuM9c85z97WgP6uLE5OVSx+P3Qpi4sJ9MoRV6cVLUI2pRg8lCGi5Vr2Q
         jwMw==
X-Forwarded-Encrypted: i=1; AJvYcCVdOK8wULHtwWzmUZWvo27G7L1mXXKdK5WNG8ea6DIpBGDtOuUMMNR4QqFYmnkW0MQUDZm7+l5vJ0lMkbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpJPcG7Srq4Y3kem9QgbTempbWsUX0DmA04dVbbei6XEv5az0
	m2cxShZ8ujLqTE44yQgmRrevFg0Ske3ZZyrVtrf5kV4dNueMhXXXYikG
X-Gm-Gg: ASbGncs5vQ6N4rDHeZgrW2zjBjVPUK2VJveuhVndXhz/2XlWA0WZ0JflNf2ILZZ2APe
	hmep+BIPlVHoW4RMToZnHSgNrXlYjO6mLXZou/CJLU8L5ObnBCWgonwe1RsRdHpGhwlP6bdM5QJ
	zOmlITibe4yx4UyX6oFWxofiG2vODx0gzAgtaIna3mYV4L94QpDJpEG8uUbM6SFWEHjhEqjn9/m
	3+VBP5UKc9I5KS7NI6yxLMZ1kfzUU0RukAypW7PxxhKTGfQ89a9TEVSY00zDj+R5HfvdZbFw8HI
	ojVlYIfvMZzTDBHxGpNdaOAaClkZhXTjXM7XNPqvFNQyYNlmzPG7IqmUCG75Yyf5I6rNVfw0G2v
	cA8hA8iipELHEARUnjUWhaBLY/xLIyJezAm2GRM75EgKeFv9tGi+2bkndPXfpiOudsQxP38FIRn
	/ifGXiwqw=
X-Google-Smtp-Source: AGHT+IF5C8Vr5mRwg1oABB1oICMMdDXxfhjBtJc4JAfiQSgZg7djSzMhTj3NDF8UyFf8e6ttXMnqDg==
X-Received: by 2002:ad4:5d67:0:b0:78f:48ef:d8c with SMTP id 6a1803df08f44-87fb40f481emr83956716d6.22.1761410011494;
        Sat, 25 Oct 2025 09:33:31 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a7467sm16284746d6.5.2025.10.25.09.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:30 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 17/21] mm: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:59 -0400
Message-ID: <20251025163305.306787-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST_BITS() is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 mm/debug_vm_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..b722dc3c091b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -40,7 +40,7 @@
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
  */
-#define RANDOM_NZVALUE	GENMASK(7, 0)
+#define RANDOM_NZVALUE	FIRST_BITS(8)
 
 struct pgtable_debug_args {
 	struct mm_struct	*mm;
-- 
2.43.0


