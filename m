Return-Path: <linux-kernel+bounces-809152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B0B5094A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7E03A789A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82763289E06;
	Tue,  9 Sep 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiUJjQD9"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D228853A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460858; cv=none; b=fU+WB/CeDaF6txzF8h/Bz8eFyNDcP0pYutXTbmnX9g435BcrmHLAaI5a/xIeALoMqUL2SBFwGL2JPB8CG6Bz6EFjHahT7MfxNTIvrboTu/Yb2StnOMj5sBXcLSl3PnZUl26HJlkqChkUmrVdxwRC6u4gvJ27NSU5Owd7FMrzdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460858; c=relaxed/simple;
	bh=z45BL1hbRzWmiV9tDqYSyXHWrtt4agT84wCssQaRrK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXcSsct1TUhO+3qXDB0WIAeQtyxpnkkrfXioiH0ocCyibfbnoDN38nyGy1BbSpGM74uTA2K4ClsshDiBxvxlQIOiPyP5ZvaZOvIE6kFplSDvCYVeezDpWkdfvrtDQ7WheYyGsQQdTiqBcjx1RPsRoD7ep8HsMXejET42SomTDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiUJjQD9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724688833bso6470954b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757460856; x=1758065656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p94KfP38ehFFAQzIc4UYzAxhmkH/aHIfMEPOUg/9po0=;
        b=NiUJjQD9ooyqUoJyU1rod/PXOitAUnLpI4TZg9sMGhB1i3qQVzuJ/ApUJtaPwYggZo
         PoLaFLMHVBjGhOp0G3sX09TZM+DH49H2e2NgAjj+2WoiRbzWqt8el1ZMnSJPRfgx7Rnb
         c0KZW82+2a1A+9Vd2Iu2P2XMLLXQH0/lUftnTa3GJek2NEaURmex4hOqDV5vn8mxxFaA
         pNBqFlajs/9Cido1qGG6Uox/UaGjc+8Y2WjkfBQj7MP3X4RDYdyi6kpy72TCKnewlCo1
         ZScMvc0zPvep++lxtieATHfs2ncRik+eJMRoYF04mC5T7xIhgmTMa9W7QlhgkGOonf50
         dBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460856; x=1758065656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p94KfP38ehFFAQzIc4UYzAxhmkH/aHIfMEPOUg/9po0=;
        b=oeVv04kRUwPvlDWpjVPyf3EJXqy/a2+QX3n2Tql4v+hjvunPlbkMpmh8odzIYeGDzf
         tvXs7gA7SZbKHTmUYQ2AT/qCj5YnMfGCjS1y/PEu8oYhSnxWN2izCw7G0ttj+DAwtKnu
         ItAt9vqXEYnyVKcIavoES+gWSnR8+BU8X1w0AbQ2pw+L38G7cGAAOaBupzs2Xdahivo+
         oDL0GgcSoRDhwll28pkxtp42qVIjxaZxlat+sqUkwjPct+dFsIbg+/Vx93Zdr4nc62t2
         3eN5uJeJvwTTa6MpmIQ0vhZUhnR9rxZFSrF27EFrkCfIqNKls2gCZvd43fGl6jH3uGU3
         EBcw==
X-Forwarded-Encrypted: i=1; AJvYcCU1dCefXD5LRB93IV/43FgfFgdBTKvfqSBWL3g37f9hk7pweOWkJkaOXzHn9YAmWPWYkAxLU8YE1wp8guc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZaiqWM6SSQekyAeNF7Z14fw/XCshfO9SP3BZaskYM7pWbC7K
	N0OLEMP7Vo4b8u2ujGlJjglvuIqEKBg03YkqGYF6Qwn3I8fNLjWbeRTnOjgT89o8ayjyWpPaCTG
	l8ROMbQ==
X-Google-Smtp-Source: AGHT+IHe9jU/ZXDF3VrMHA2zefxE/BkTlf3fesT6KUXKBfH1fEUS5JMtiAufZ6h2wVl/I0nMlsowMm3ygQk=
X-Received: from pfbbm11.prod.google.com ([2002:a05:6a00:320b:b0:76e:8d8d:6652])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8f:b0:76b:ec81:bcc9
 with SMTP id d2e1a72fcca58-7742ddf0f22mr17694356b3a.21.1757460855691; Tue, 09
 Sep 2025 16:34:15 -0700 (PDT)
Date: Tue,  9 Sep 2025 16:34:07 -0700
In-Reply-To: <20250909233409.1013367-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909233409.1013367-2-surenb@google.com>
Subject: [PATCH 1/3] alloc_tag: use release_pages() in the cleanup path
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When bulk-freeing an array of pages use release_pages() instead of freeing
them page-by-page:

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e9b33848700a..95688c4cba7a 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -438,9 +438,10 @@ static int vm_module_tags_populate(void)
 		if (nr < more_pages ||
 		    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT), PAGE_KERNEL,
 				     next_page, PAGE_SHIFT) < 0) {
+			release_pages_arg arg = { .pages = next_page };
+
 			/* Clean up and error out */
-			for (int i = 0; i < nr; i++)
-				__free_page(next_page[i]);
+			release_pages(arg, nr);
 			return -ENOMEM;
 		}
 
-- 
2.51.0.384.g4c02a37b29-goog


