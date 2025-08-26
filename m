Return-Path: <linux-kernel+bounces-787218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53BB37323
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A11BA60DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6027F171;
	Tue, 26 Aug 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efJU/Kqh"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7092286D75
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236838; cv=none; b=cKDCKpxYh0Mt4TcN+Yi6Dnt2kcy650nqqZjQnuFMTXR1JcQXPP0kDHZQREwRjhJcAMzSBg7LDW04d+GZMEGTjb9yqNtWudpCVtgB+oej2KSPBZG6a1yS/LeDUIsrVvd+kf7DZBnlmlEBEwBneKmybAgMOfqno1VDa0oZEFXxAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236838; c=relaxed/simple;
	bh=XEUtA178Np+YuNPcMuKC0ZZIcWb4D73TaClMxlLUWj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouq5YcymHYyrAwQJv/xeb11p4sY89kyMJZsFMwc4PgrEd1L7adKNGsHOzXug+FlXTmiO97buG3HY3oEIQP+PeKl9KUF9MThJxftKPzTfxLHxp/RWpkxLzkLQ2c8OwW+zDjoMWalMatsc7se1qYFpGz5xNx9UMMpvP3VHLvRjfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efJU/Kqh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771f69fd6feso1723223b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236836; x=1756841636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csL4vcqUsLMqelmQE03dlwxPXsPoNvqKRUsp+93HhyE=;
        b=efJU/KqhYt/RMs0QZYk6h7RIs4Wa2hpbkVOF+TYxDr5halKH+qFAccrE6+kDRq+9W1
         Y1Wx/rvigFyhGkoheKJnmxj6aR/1Vis2q4tEAVTUHoFkB9ObnB8rl8YDzLChS1DP+BRR
         V2mgBTe46js3JB2KW7SK0lveTQed0XSDsyv3IaSR5MFhc30/ZlYX3G9vBLk2fq6h5d+b
         C8gLns1g3zSCfe98L2/QvWW54WN9x8WL4BmzLCoQoaaiomnM7zgoCF4Xb3BDMlvqbbES
         FhumJ3xEP5JqqYqJSBpfjEctvEcV9QIb2KiwFTddUEFPAP81IeqDraRrN06VkPBwDtdH
         s8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236836; x=1756841636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csL4vcqUsLMqelmQE03dlwxPXsPoNvqKRUsp+93HhyE=;
        b=SslKYuAHaAO1PqjKzWnOns3FXdIm86D0I8rQkNOccJ1qQLsCZDV3EvcHNCdgUrie00
         MKvMJC+g+MF1hX8YecZWoo/hCOlzAfCm18OJJIDvditBx/CpL7jYttuAvSKNkqcK2xfF
         3aAeDPru7uUJoQ2yE+S+z9eAHW0tee0LHqsM8iEeCwl+Hx2nM4SGUCXLAHdxaFHmcRY8
         HBqLbtu3M/4AcRaAxnABII7MMDghFhO0LajCLXB+dSC8DojCrHmnJ7Rugn7IN4BwPGHK
         fdNKdUD9n+fy/sM+aDZnhokYvqPcSu+5n/cMiWOqQh79qHDqBLFNJ0PByLEe5ZddZMut
         /YMg==
X-Gm-Message-State: AOJu0YwKPhcyDw/JWFiWv6Bd78L6jiRbFxO8z6CKtRea5TxUBT/b6phh
	mw06/um/qZrTnMgT5Z5ia+Dt7tWkQ4tdMVFNsrMi4l1CxB7yoFbT5wVq
X-Gm-Gg: ASbGncsMQUEedJW95Ra9IUJisOwMAKAw9U/uVaOxB3DiBXrPhjTzISJaaYKR+hxuiSB
	Wp52zS4EHC8J5LxJuo39EGtsM82xlkI8JUtrB9rD8c7FRhGyZwibDcAXR2jrQgf9GSC5bsbFFn4
	IRfYQC0b9B808GFWdotbWZflwdZanoOxoEpTUmnovm3HYXeeAVZGaS4gir+kv9JoP3rUErTyjA/
	aN4UO9zW5k9WcwhQrvvkg7XPA+nyxz0xs9iPlsroRFvUzWV2sn5Xl6uGOlIiY7dLGIU3UNrJkso
	qSxXGU12L51+K+Pof5Z1G1a26aAQbsDbnau1QLcSEZjNJMDwR2SRf+PE/yoCxXVgwqO8DAaXdom
	Q8fULLyO4iRt9U6aalBS2Q4RdD0Mlwjk1DBnKTxlBIYSGwFdvfwbiHg==
X-Google-Smtp-Source: AGHT+IFvzr6myYSmZn7HrektYJv4R8WVw1CR1DW/e8DWy+bQK20FC1CA0a5NGejv86A+cns81qBXwA==
X-Received: by 2002:a05:6a00:2991:b0:770:374c:6c60 with SMTP id d2e1a72fcca58-770375bb1b7mr20607989b3a.12.1756236836077;
        Tue, 26 Aug 2025 12:33:56 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:33:55 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Date: Tue, 26 Aug 2025 12:32:52 -0700
Message-ID: <20250826193258.902608-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826193258.902608-1-vishal.moola@gmail.com>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-docs to free_pages(). This will help callers understand when
to use it instead of __free_pages().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index baead29b3e67..6ee8f450c078 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5270,6 +5270,15 @@ void free_pages_nolock(struct page *page, unsigned int order)
 	___free_pages(page, order, FPI_TRYLOCK);
 }
 
+/**
+ * free_pages - Free pages allocated with alloc_pages().
+ * @addr: The virtual address tied to a page returned from alloc_pages().
+ * @order: The order of the allocation.
+ *
+ * This function behaves the same as __free_pages(). Use this function
+ * to free pages when you only have a valid virtual address. If you have
+ * the page, call __free_pages() instead.
+ */
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.51.0


