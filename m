Return-Path: <linux-kernel+bounces-870041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C6C09B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC79A1AA20DF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6F314A6B;
	Sat, 25 Oct 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3GxsZcQ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0313148AC
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410025; cv=none; b=VJfrBjI7dw1PxyxOGAxNYkTgQkmYHZi6NMVJml7y08zK/e/bB4nPXLBmG1+byUmqqycGI3YpvPUUoF/I/wDukHhjUTFX+Wp800AKjYdqDcEGvjkaU8BJQg39g14NNlavkHDjM2HDAJDkZd/H4O7y4Bh+rI/i+gT2sqY/NnDtVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410025; c=relaxed/simple;
	bh=W0pTJAcfrpLd3MSeWjU9C4zToTzxqvWOKJPAJegCRgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzr4XyN14qmNPuadTwb5p0D6mfNJhcdzAS+FNqS18ENBo+AU+igNXV0YZtXk3iV91uXSX9trKT+QUmYRnpoRgoZAgVTk+xA75yUdMZ14LQqMY7pdfbwRoNW2dmIIngHH38QZ6isnyGfmouQKd7oFnGhatKNCSA1W/LoolZGdVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3GxsZcQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-89f4779fe03so75235085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410021; x=1762014821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCukDE2Wz/llmJRA1Dhhk+dKRYCeKOkr6t5vR7uoeBo=;
        b=W3GxsZcQ0AjbfViWXfh+9q20Q/hqRqnWMrVwf3Lu3jxrZlLYZzR8fqV64fofyiCOsc
         AQycqC1WssYOjDuAsqnRJoC21rHmhmQI0ZmOVelCYow4SxouzLe2dGOcW2rGPuX0ytRy
         mP0nhuwEiE6cQuHjJrkETrZf3zbhEjyq+Ed3jQapIMRSiNNrHhXXzvgYmE/cs5qtEkcZ
         fafAAxxSj7k25jMJvEzRtknXyICbUpOo2GZphZh5Pw3/1bb9lfiJI/eW6y6RcHwgHiyP
         O7/JvbzuIlG4lvE168bPoIxVmpT8Cp441DPOVQmHnfT0bqaaWiYcPVebjmY/mzSojYlD
         YCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410021; x=1762014821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCukDE2Wz/llmJRA1Dhhk+dKRYCeKOkr6t5vR7uoeBo=;
        b=pxUASSoJvxm8UICvz6Ony15ItthSs+ieVb0EsHCoakfI21kexco7GPVGM9bQLDhqux
         mgqIbJu2TD+3NgCCSoOasp5Fq0UA1/bqBWciZcJnB4WwWXquMKXrGuOPE+8M0tsK3Paz
         auq2ICQqw1aVfJPkWLzt0Hmh+uvUKOt06vJratb80lWMgfOTxxhRIBCoXAy2Hp0f4+wm
         5z0oSq2aelwAkES+mVk4pKE4cMqigDZUdc6vXsjGQYZLMU5hSudDcMi/lcdT2hDS53NX
         oi3MId/UEy72QxylGJa1l9WSpMiode9uMJtwicFYfv09/RxExYtNdeP4HCePWmqS3PZ1
         xPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyL7vlU4Zu/n0+0uUI6WcyiHmI3OyZPXb9RIXhZpxruT8hN58Eso58rBqk3E1FvAITY0s0BQSY++9a7yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCE4VFyWHRuZyk2LosO3hNItQ5TaGVi4I35Eiv0SqKsoPmKFM
	igvUDuS/x8bKMNFDHeYi2/LXhpHRFRmZwDboDorfWr8oPGGu2nwpLXRH
X-Gm-Gg: ASbGncu8Oo6J6K7QId3bG1oNcsLmf+9Ye9LsXEYxLrJr/PSIMrLJdNYnF7w/MOknEGo
	3b45MOFDoqgARLifCtkraP3FLYHd7DSPUnIEWBRAuitiF+GylNU32NKtaROJjYpRfxC5b3X5Rm7
	2wgCjXg95YGxpUdkKMgFrHRnj1Zz7uLXtJ5yBwkXg15lAPpYcj5038lU2lSYvdiYuFsN6/s1q51
	yj2YTMqXr1ajvHmtnaq1TNW8pI8CIKgLPR0TC9a1LZS8aL5T0SfIyjBXZaSRh1P3r8I8Nz1E72n
	gP0yNpaCCPUAGmDn6+solH8tZl3wQ8fKIEilrsxIxGU9ZWZ2lWdRSpK7MIqXRVFtD34RyeAtHH0
	H0LPnOLWnVxdjPWU8C1SKBCrm/IaylH6kIy2owEHButVh1/25xVl6OgFQ65epQARnRXg+jO4bHL
	NDrE0cCEE=
X-Google-Smtp-Source: AGHT+IFZUXzUCKjX2GS7KVjFpxXVayhaSU18PSnROxCbmg4ehcl8/3L/N8ey4/nagW/qyG5Qi/ofXg==
X-Received: by 2002:a05:620a:2990:b0:829:b669:c791 with SMTP id af79cd13be357-890712b8ca4mr3694996585a.78.1761410021395;
        Sat, 25 Oct 2025 09:33:41 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a41cdsm172336185a.29.2025.10.25.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:40 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 21/21] Docs: add Functions parameters order section
Date: Sat, 25 Oct 2025 12:33:03 -0400
Message-ID: <20251025163305.306787-14-yury.norov@gmail.com>
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


