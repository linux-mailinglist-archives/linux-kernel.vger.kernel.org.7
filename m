Return-Path: <linux-kernel+bounces-792302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A17B3C280
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F087BDC96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D335084E;
	Fri, 29 Aug 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Qn5c2sLh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3C34AB16
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492338; cv=none; b=H6ReJkeHat/27BnLrQ7q47qzmUalgh/PJLhhw+fBMeXjhSK9zZmnXmLJmxplKiD1/8mOJXkJ1P4V4tZVhNjZL4rUZv/GoXm63Xb41E8qmY7sfb4uE58AU93YKa+ySmtTn5OvzcicprhrtR1SByAmFePq+imGpfV9dVJZik+lgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492338; c=relaxed/simple;
	bh=Y3Nk7gBkgF6N9c5VY7zLBMy3y2VCalDEY+iT3K3gDGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqoUM3hmV4KlaNbrNTbOyqURzSnkQHUUKZJyZGQ7OaNfiXPrd7hqBCgvl+MBZn2h7D6oiumeywBjH+chTjOgJQA+pIsqwdMW4LWP9RbozaDB/Dr7TTspiDaCQqn62CbtSIJ8hHpaLNF1YKoWsxjqp596hhzemywOZIuZMvqhAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Qn5c2sLh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afeba8e759eso370260966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492335; x=1757097135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YptetONu60ua7xKiQIttVSTb9jDe2/acm4my/H0afc4=;
        b=Qn5c2sLhpNaDpV+OtRexXk1D+3ai4LDKNEZ8N9yiZYrpbKabcDQTu5jX0nMfvlwiJL
         cAlmWASuJa0/zA3evnxKuKbzAA9fIzPE+8liI6buUoxJvks15kscKRpchr0UdL+bB5hw
         sjXsisGWgLBepKPQgKcopcJJl/vrmwBZACXwkbvcZcwE7nffPFgPb0lCNZqYriJqJ+Dh
         p9+s8DltqwX/iU9Nf583QIIu7zN03uPu6SoCOLxU1LMxxHuxtzYSX6LZ7qQhVePQzoha
         LNikdYbbIhc4+n3yPQ3UVJc2iZ3CZDwxjVwqmgPICUlm9lO/FNBup01SbICd7CEbD1Qk
         xQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492335; x=1757097135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YptetONu60ua7xKiQIttVSTb9jDe2/acm4my/H0afc4=;
        b=gahGqFs0n0i/NFG0YV0Bwr8EKZMFHU+UZnojmTar/IOsD1DgRMvV95Rewv3lJ64WK2
         SHeUIGSkSDSoY/6OsDOp8S6qsCGt19Zos23hmQMPjKNsk1sBAnZi5popwp9H6/5plob2
         kq0QPigQQuFcvV/YSi0Iq8gI1/SSDJMFBNN4YCpYcVW1k/lB+mOqJDGwTbLC7XRknw7y
         /HrJroENF8a1VNk/2WZft6na/PZMy8/TVr9ymOSm2jZgT47Zsmttcj+WVU8gJolOgL1k
         sIf53EdikURqFdmV4uGPGhKKBORShr4MS6Ql08lmWWV+b/Zmq5KSpTzbEm2OTaYXdwIg
         caDg==
X-Forwarded-Encrypted: i=1; AJvYcCUF6dqYbLHqi0EFWsBHVkidS2Cz31ib8mRoz1nxak7Q1/4ew/F8TpeB21jk1X3z5Uo9oYkELHSbBZAmrEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQO9Xh1zGPqrcFW5GBcXexvvrbLibtWo9ZjWqu9hMlXnmFE4h
	Ocv4amtwERuWBjPSHeUtCh0pz+I/vzhoKHPPVB1Hx22m4gbQGimPK3Yg6JiHKbtbQLo=
X-Gm-Gg: ASbGncu3S6s6Fow44Vblq1/DjfynXnVgm8IyJ8dglZt7PQQf4BAjip4vvpNZtMaRZSc
	m/7FPIWGBX2cL/Czd5eZfjrYgTmrj73s6+4UOEW6ekt1juSxDkeexb1rYOHf6KruvhEnoCjN/SR
	Qo2u9RPk8hUd8aXdA0xnUhjkX1g1Rdeb4K4rEGYI9gBjhPYJJKK8wW6eh2TYhUNdXXMCywVpAk8
	geNBM6slP4FBC8AYJfPCC063z3cgS1ezARD1PDT0XEDCyV3z2d+fujOrxbdwY+zzphqH2WrDbgQ
	0mfIjPeKT8SLNB6g8eJDmoc0lzmKexdpTokcew2gGtfcYuimKJjbUsa3Feg+KEj1QPkEipc9AsA
	X0kxUUHnMxIiPSpHrLqcaFBQTuEjoFglXQfTHCG/aD0AeZSRqqdBkcb1IJeGvQ2VIYrPZLNnUpc
	WhpuAVVKx7NoeXEenZDZCRUypM8lqHO87f
X-Google-Smtp-Source: AGHT+IH+NuMFRsuGd4PF0q6uCIHQQAJ7dt/ECx++1eqEWlkBezyQqdi5BEB6pNrdcyXSk7s4aAAuHg==
X-Received: by 2002:a17:907:2d21:b0:afe:f7ae:112e with SMTP id a640c23a62f3a-afef7ae11fbmr572057966b.41.1756492335238;
        Fri, 29 Aug 2025 11:32:15 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:14 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 09/12] include/mm_types.h: add `const` to several pointer parameters
Date: Fri, 29 Aug 2025 20:31:56 +0200
Message-ID: <20250829183159.2223948-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..275e8060d918 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *folio)
 {
 	return folio->private;
 }
-- 
2.47.2


