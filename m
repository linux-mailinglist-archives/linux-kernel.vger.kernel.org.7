Return-Path: <linux-kernel+bounces-870066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 579C6C09D25
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9CD9508974
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1C31A562;
	Sat, 25 Oct 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmdkCzlR"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED031A050
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410489; cv=none; b=eQwU0+cgFxQnhAaPYDwuGCzl67latUtbwa1UCeJFHAac3Z3WGUfxmNjvd3ldJfJp/r3vA+YfRDps8w8V1I7MOdzo0Jl4wJ4VahMfHitR3Aa6N4lgtm5TfsZX6Awl1MhoqzlNa5xWtwYHf7AC0//PqbQMzpQ5d8p2bwl5iXegCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410489; c=relaxed/simple;
	bh=W0pTJAcfrpLd3MSeWjU9C4zToTzxqvWOKJPAJegCRgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae+Sz/K0cRpAFGt4amAYboiTq5QBJd3aUupDU4nflaOjoe7PbFKPUT4F7rOyL+vmkmNik/6/qjwdhfo83AiqokNbFqjVXsQtjH50fKDVeumAI/3PFJS6+yVNGjH9O/Q2tpcSnx2PO/hgver/wyY723K7QuNPqx7+JCzpS6PA1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmdkCzlR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89048f76ec2so357616185a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410486; x=1762015286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCukDE2Wz/llmJRA1Dhhk+dKRYCeKOkr6t5vR7uoeBo=;
        b=HmdkCzlR2ZV181sY1F/mM051AIewCxk4RD++RSXV/4eyJ6IOO5xFkp5K47ZeLSxExR
         CVKkV49imAR9XLihFoy26xUnIm/67GwVVbS8GkCY4t2LuFdAI+n48O5Dn/jX3KrOaeJb
         VppNAKgxyJGqSMPRcUyIpouAMTXEuxbkOwTzqv3MySV8rXeDShyYkdl4fWUYxJWId6s3
         4wrATqS3p6T3HaITk/P8lWs5zRlOKFnEWfKP+aE7oKmbm/kewrPkES4JDuZNXTqU0ePM
         wx5uIhsmoo1R3Wuid/0fLO5+82UkdRowsq+JEWeQoDYOs8BFfS3a79DI7SZGW6FU1Qio
         +b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410486; x=1762015286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCukDE2Wz/llmJRA1Dhhk+dKRYCeKOkr6t5vR7uoeBo=;
        b=YUVn5Nk8UrzRC70EIkSYdBAXsIRtTKnAVPjZRjtvcDp3R9CZFABphOcGcYAqZd2Dhf
         FWWGFB0FwRpLukd8sq5zOLZ+mtoyoNfCbRYdDBSmVMImE8l0Lbu7Pl8sWc21p4fkYeF1
         QseLTexLVOzILgQ+FtS9hDme8/8i/k6XqxLmzStaVy9aE5afLHrppYpl653vMHC/DOzQ
         sTRn9UcNSoDkE4KCEXUk3p4EawCKnTByZSX9XrQ2TS4eWDo2bdM0RI/R6QntpPje1sQx
         bgL1YWJHUSDhVZfBnC/7Eye0hpAsOOhZo/aWjmQBvSSigykPXE2jO+3TX3WQalhm0tWj
         bqRw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjeSBqnw/mp0q4yasqepC8B4Qd1Evlf9LGOyO/8hKwr9tG1qr3IlcZx7pqFNDt2Lz67zdAYl6ujBQ0IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXGin7sSAmoYPOWMmuZd6gOjKh02hq6abBkvRpJo5FMdU0cJ8
	vXXzH6TOGop/7S1tANlTEQuljNsPYNUk7Ac604LbEoWMuFbr87VC0+AqU3BKkA==
X-Gm-Gg: ASbGncuRARTKOxBIGAvPz3k296uNSeXxsjIKp0zfZNMfqMGuXgHp46D98m9/2VeDkRX
	/lwcy7cTI5cBwcNxTT2IkOM7XDBSIPK69HKMfHVjZ4pg0MrxJLW19nTAsQXo7YcWhGET0JA34p7
	RmNQ8RTlT998++s3br33XpgSdihC0wpjg1V8I/5GbeS0Z42HdV3BdS3d7zqUyxSiGBL0n4K6ZNu
	tHx8I4dZu6ayTmM2oeMTKr90ND6+e5qREMB3nVDAk74ZuHnE4mTQMqIFNj1bxFhO4wX4LUN8aJo
	UojxhWJ7TGuUg5Bpb9VI/T41jUUAKMvcENRt6TMkq+xzSCCNPkYRZdTyyt8z5tFd7iuuUl83sjY
	SEDcpry9UAO915eMfZ59n7FT9XK8f7dQN30C8AauE0W64T6+sJ8O+JbgLXTG/qejbZ8zM2BYS
X-Google-Smtp-Source: AGHT+IEqr7DdALG20ZOSBwW3gigwHtT069Vv0Qyq2izolgtR2Xh/1150BfEGa5vrjghcvepsgiDnaQ==
X-Received: by 2002:a05:620a:40c3:b0:85e:429b:b5c9 with SMTP id af79cd13be357-890712b9494mr3891854585a.83.1761410486528;
        Sat, 25 Oct 2025 09:41:26 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37d72ecsm15371681cf.9.2025.10.25.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 21/21] Docs: add Functions parameters order section
Date: Sat, 25 Oct 2025 12:40:20 -0400
Message-ID: <20251025164023.308884-22-yury.norov@gmail.com>
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

Standardize parameters ordering in some typical cases to minimize
confusion.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 Documentation/process/coding-style.rst | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index d1a8e5465ed9..dde24148305c 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -523,6 +523,54 @@ below, compared to the **declaration** example above)::
 	...
  }
 
+6.2) Function parameters order
+------------------------------
+
+The order of parameters is important both for code generation and readability.
+Passing parameters in an unusual order is a common source of bugs. Listing
+them in standard widely adopted order helps to avoid confusion.
+
+Many ABIs put first function parameter and return value in R0. If your
+function returns one of its parameters, passing it at the very beginning
+would lead to a better code generation. For example::
+
+        void *memset64(uint64_t *s, uint64_t v, size_t count);
+        void *memcpy(void *dest, const void *src, size_t count);
+
+If your function doesn't propagate a parameter, but has a meaning of copying
+and/or processing data, the best practice is following the traditional order:
+destination, source, options, flags.
+
+for_each()-like iterators should take an enumerator the first. For example::
+
+        for_each_set_bit(bit, mask, nbits);
+                do_something(bit);
+
+        list_for_each_entry(pos, head, member);
+                do_something(pos);
+
+If function operates on a range or ranges of data, corresponding parameters
+may be described as ``start - end`` or ``start - size`` pairs. In both cases,
+the parameters should follow each other. For example::
+
+        int
+        check_range(unsigned long vstart, unsigned long vend,
+                    unsigned long kstart, unsigned long kend);
+
+        static inline void flush_icache_range(unsigned long start, unsigned long end);
+
+        static inline void flush_icache_user_page(struct vm_area_struct *vma,
+                                            struct page *page,
+                                            unsigned long addr, int len);
+
+Both ``start`` and ``end`` of the interval are inclusive.
+
+Describing intervals in order ``end - start`` is unfavorable. One notable
+example is the ``GENMASK(high, low)`` macro. While such a notation is popular
+in hardware context, particularly to describe registers structure, in context
+of software development it looks counter intuitive and confusing. Please switch
+to an equivalent ``BITS(low, high)`` version.
+
 7) Centralized exiting of functions
 -----------------------------------
 
-- 
2.43.0


