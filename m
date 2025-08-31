Return-Path: <linux-kernel+bounces-793298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C8B3D1A8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148A93A6128
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8009256C76;
	Sun, 31 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lw1p0RtE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223525394A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633183; cv=none; b=c123yEbSTcXvzmpEIEPVrKQH1hkjIv0UhVrcOOb2y3I7tMwMmONC5tzm+YoGQOhQiGHaZ+8W/NSfCPe1VDRqww2StT0CN9nYVFMuAEY4Xp2E27oRrz6r+5riZ2AtytKMk0/eUGdy47WM4fHCCHCkBNUUSeGryKZNApbesRTNBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633183; c=relaxed/simple;
	bh=oJIpLLq8mn4y7wdscckPv1cTmoMWyeuhyGuMWqlHISg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyb9grdB1/v+tqPbBX+Qyzl1qFmd166Vb60ATiprLedoxd1wjrEsPPJsRkXZwQDnZwPwd46VkbgaNTxfE6kcAj6PRQ+LweHB0ASAgtmTuQDya+DodNYkgZJ27z3FoEFZ5zoB7QDlaE9+0j6MpRyIgbTCyBEzUuaNVg7TpT94ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lw1p0RtE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb6856dfbso616337566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633179; x=1757237979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpCkz1SZAm30DtLN9HzajIn9qKAPCWS80gkzy9YwyJg=;
        b=Lw1p0RtEs/r6JO6OwF9D5b9438IJu/MKtwa2L4/NJlTUVcanNYLjUWQ9ANhfZg99L+
         HifI2sYFcJEh1/Us9/qUwFqAMUqVG/FV11KCM3tBDJpzwiykOqMZZC0YNkMrRJu8qll6
         y8QbcCKAibTBQCcOecJwGeAk5gcR7sbhUrRPuQWU4gllyQsmA8iQ3iL/p9m2wJe8Qsp4
         xqqDDKRJUCch5cQp9vtUCV19WKsLrKXPqFr1wzwJ8qFr8CHlqGbvlFWpcSH9aQMvbeeu
         oIUDpL+Jnq/z6RfvSCAzqV42XdVEeCLingriAmrKK9k6E+wjr34w0L0R9NCXM+qFfEix
         xZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633179; x=1757237979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpCkz1SZAm30DtLN9HzajIn9qKAPCWS80gkzy9YwyJg=;
        b=cZ/QyVwC2y2KRBoC+cICE7JkagInoQvbdAn9gHPI5quZkPGuNg9hG5yUBbxBGEDZRQ
         ROxTMwJeo26mOkwR33hddhyd6Ja5/+O0902VEyIu7r+xtllOfUxq3Qkn6udXOcdpCMBL
         rn4+7aPdN4J00uAzMSa7SlHQauAMIUatNwdor39D0u48jFQzCh+iOmYdD6FKWy18kSLx
         3s0KtZvaaGt6hQdN1nTYyjzMOm1pZuaIvx9ff1Abc4BTH5jznLo/yZAWH4DOkl4HRMUR
         RgIw85FjV3Ddgno6fVzFe2fo/vpEK4a5yA1Mwathz/OISHZZbh8NG+9pLWJBv95Dnq1S
         C6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXhUp7aahzrdtiWbi/3MJYdYzPR0Zbl3K1DLGwBbPyM+Cxp0yK0Y79OqeO3lmXena5Ta+UTvSMX5Dv08jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdq/4xiO/OxywK4ktmSC+XTreI/oFx9lKbquyEzJLFLIJkyNb
	STWUrTbalkccVNsaooNAvxY9ivc0qwB5ewdkP1yBBlyR5whTpb4s9z+S5hcPgFBVjrw=
X-Gm-Gg: ASbGncus6lEnLjWDw+j3adhInk+n1Zz+xVVZ3G95l+V1d/xRYweGPCyB4mhihs9qvR8
	rTLHFBRWSysTKrRbSDTFa39JNDBDpmcoXPBu/Y679tKo8lGRPG0NAmdBAs8sLQOVUwxcrY/Z2jB
	oXZFiK/TcBv3La7bqittTUyKJ2a9NWewZTVu949blsiJ04JXvXqFYwuW2i5SXz31EdICvwJry//
	aKKBCdRI3dWgtRuMijDcJzfwqsI6DzFKoqny3H0WMSPAq5ds6lm3z3ID4lSGBfVtqi3f9zAs3G8
	1TnmSUBkZEfU/Tkcy0tLR+3KwfWE5IChhC2lTs76KiJO3u6sAGHqf26h+SoqNmg6px+TOpNUOXj
	qncW4mOVZolqy1o8f45lC2IEz+HwUCDMrJgYVEC60txupJ8Pe0o0qagTIbBQVB5pbuSkqW3m6oR
	D8TIxAD+Nv7mZmKG+gXSb6BZv39omJ4f5r
X-Google-Smtp-Source: AGHT+IGWqt+KVEWKYlHvaHszGcGmjarqiU1Lz88YHviAJZBcg99riD3I5jJ1gwoVHFqFNrl1LVVPOw==
X-Received: by 2002:a17:907:3f07:b0:afe:de1b:26cd with SMTP id a640c23a62f3a-b01d8a52c71mr478093666b.6.1756633179563;
        Sun, 31 Aug 2025 02:39:39 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:39 -0700 (PDT)
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
Subject: [PATCH v2 04/12] include/fs.h: add `const` to several pointer parameters
Date: Sun, 31 Aug 2025 11:39:10 +0200
Message-ID: <20250831093918.2815332-5-max.kellermann@ionos.com>
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

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


