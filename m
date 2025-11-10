Return-Path: <linux-kernel+bounces-892836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A51C45EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6921887917
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E430BF52;
	Mon, 10 Nov 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEr6z6fS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986030BB8F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770328; cv=none; b=aMZNcPljrreXVG5B0dC/xuGlz1MNNKXwsWj0sApQfEeyxqDbph9EA5IxllMgXvqYqfabklNjx+5PRJG5gDiotBplRdZJIMJ6xL5uSsl4ZfyQD1ejxdAX5Vbs07NWaHAMU59InjrMJ/DQWkI4nfKHQu3b6UkSEjy0UKOx+JzBx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770328; c=relaxed/simple;
	bh=8lQxcKvouaei16FqYGY0RR8AerBRZPOQndfjxzjaGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czlUxpnjn35qPXRS/tPZmBZWrzOcCX2ZidboV0LdACjzUkEvzOoD8oXanxIU9Dln3i5c5VqpFhPRI+aGCUUCsIhj3bhR57C9VwplFeHaDM3GVSq1IQCsFQdLsC6s2G88xV1L8K3kMV6UQbhLoNB7Q5vV7o4pVv1IUu5xkhgudVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEr6z6fS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47755de027eso19181135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770324; x=1763375124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=KEr6z6fSsUjRrhQJ8RWb+1FQYuuueiFa+KE7UfFOvruiGMXOPr3GJ8wbsyMkaVz3uz
         lHClhqlT6Xn4VzUcdTPJXJcbf0puI2v//sLIycqzF+qToO+rvsthhFoJGOW/XmwM1WSB
         JMSoKcW1oZO7DrD/v3bGbtTeMdSL87ty+gFYkh4htC7ythk2JAX18pQa2rLuKY4AzTYC
         QCB7X+rtoPhbIn5ZzSvML+kffP7nV9rSMw3FTY7sDKc/c/JJeA3BqPgyofbl01qonkpt
         cmDrvabxXDXDl1IBItP4Vxn6aKseBr0j5W5UlGxi573VISKf+rDd9R3yVBQAwMfNd4hy
         I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770324; x=1763375124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=GnQx5N1MKF8ItNaoqZVwHEqrCvGsk4mwCiY04HPBaNdQaJieYb/cXnXCG0h3SBvtRN
         hJFjT4OtRoRAT55HfWlTiKboPWszgz6mk1crursmX0RurciU8vn7ba29cWvB8nsTvomn
         VCDpnDjOHSLFfM2KhiT/BPOMF/QEo6kr4w76Ar/7AAIMnS0iwo8CaDp2REnYLJFpQZbd
         3YWm1AUJBKm7oGHC41opskr/5MMq2hLiNqRIu6HvYWaL5NFjBZ2J05RAWO4yl+MbYLWR
         reCzZrgpX0watn4mJKnoB+V95CVrA/lmk9Il8YMVkKyu2e5e9lqih0QTF7AJhL+lt9c/
         f+ww==
X-Forwarded-Encrypted: i=1; AJvYcCXsAAcMMNfuNpO1UB9rTAQcLXWsQ256IqxaSxUh7rhgRbj+0Ndh66Nq0zK2CKzb800h39zIo4unuh8GzDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZikY8VHfRWEeaOybZ0Uw+DlImYA3W+aYw5p7xfnobGf1ZBNG
	xdWAQLrVhjkOp5tPUY52JoTqigXaHWV8u5oBMNJVpLdPB9nfC58QGmDR
X-Gm-Gg: ASbGnctMWK/VqeB5BxJpocWrMf/Nzurh/wR1SmZaBaxbpuU23raCJ64ebOPa2CBt5zb
	ZTa2V8z1aW9vsafOBdr6s6J6sxwKX+7UkW8tjzsDgSJd+rGCEzrDIbjBQMLpXngXr4o2CS2hO9b
	hOcufSApHCyAzuBQ8lrmTJl4L1DFkSFm8Mmwa2sOH4hQOi6XrsMMupBbY88UTj2/6ou7Gr7Jh3T
	TiGH8BSvEs7FoADKcLsj4LbOvx5lYzsi6e7VQEzZZfKUXv74J3dGrLmL3+yThxWtj9J8yIlUVxs
	Kklj2PlkIKMJSml8gYh1LINk3y1UGqESrbBaws9QbFC2DG9NVYnIhqZeOc/U2nr6588CmDFegc+
	QiBPAkJbZV6HoVS6xpYIz7s6WaH7liPKv02D6Iy1yJgCpNont4SQuuB044U1D/F3X44CpCejfel
	yb5CpFgSlgC8xh/Xb9xS2B4GmwMcU=
X-Google-Smtp-Source: AGHT+IEovL52sPcrk0L/fm9pL8qE9L2wC+LWVPWdlPGj2ws0AjCVdIuLEVdInh8JsskX8jb99cc9NA==
X-Received: by 2002:a05:600c:c4b7:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-4777327b254mr82401535e9.32.1762770322510;
        Mon, 10 Nov 2025 02:25:22 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:22 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 05/11] staging: gpib: Update TODO file
Date: Mon, 10 Nov 2025 11:25:01 +0100
Message-ID: <20251110102507.1445-6-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments have now been fixed so remove the item about
comments from the TODO file.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/TODO | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
index ab41a7f9ca5b..ac07dd90b4ef 100644
--- a/drivers/staging/gpib/TODO
+++ b/drivers/staging/gpib/TODO
@@ -4,20 +4,6 @@ TODO:
     CHECK:ALLOC_SIZEOF_STRUCT: Prefer kmalloc(sizeof(*board->private_data)...) over kmalloc(sizeof(struct xxx_priv)...)
     ./gpio/gpib_bitbang.c:50: ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parenthese
   This warning will be addressed later:  WARNING:UNDOCUMENTED_DT_STRING: DT compatible string
-- tidy-up comments:
-  - there are some "//comments" and "// comments" scattered around
-  - sometimes they are misaligned
-  - sometimes "// comments" are interleaved with "/* comments */"
-  - multiline comments should start with initial almost-blank line:
-    /*
-     * Good
-     * multiline
-     * comment
-     */
-    /* Bad
-     * multiline
-     * comment
-     */
 - resolve XXX notes where possible
 - fix FIXME notes
 - clean-up commented-out code
-- 
2.51.2


