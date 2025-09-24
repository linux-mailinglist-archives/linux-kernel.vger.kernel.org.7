Return-Path: <linux-kernel+bounces-830754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35BB9A731
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B04C167990
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65630FF10;
	Wed, 24 Sep 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WREefWG3"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25C30EF99
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726022; cv=none; b=U9ol4un+Bhtk/TziMBBq/D06mT1xquTEiUjvrs9FJ8N3MWJRdUVtnNWJB0jkKRw+ktxKgHmCYfwyDU9pkLIXVH3hZh0KVDlKdOXWB7kL52Q5UXEcJe2/RxTDBFYVK0og1pTb9AkJn2eEX30gZA+ssnDHethjsOp5GBkLqwh9KAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726022; c=relaxed/simple;
	bh=KLFMQaBWl73ZWJXS226eqBexHzAr7X49UHgW7C8dm18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yrj5JHCnW7YIVcO48XIBIQCOhkfAA0JlNDy4MDR7jr3aQVYrRjNZtAdoWxrZTlJTp4ITFuuBKqVEXTKJW4AViSiL+KIrISwsa7f8oK2YyUimyJ4b9EQyuvfx3UGKgZjEpc6MsK7cB4quS935TiJ7KMz5KNBc13DvVsECmsdNo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WREefWG3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso54922975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726017; x=1759330817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxm1+BttfzZabXPoYExS0LpEIkdqq5ptW85BH8SIzIM=;
        b=WREefWG3WFkiH469MlE9hhepBcPy28lUNMckXDR/1be7G7fEwGsRbafn30PYBx5ngL
         lX4CvW5fKoHUKOrpCpcUEyhJd4f2k/q5qAtf2XGvUtcy12CRFu/889FK+Mi1VRcNQC+c
         rszjbElU+9tkUe64SDlk4640Pr2xgVVET7eTntnB9Z0NZacAdI6AHPQLcUUa2qbZLP3h
         aW7YCLYjEutJorLdoCLBbrw+ZQSopREWDanWOygFiE3eCtZ9n7DffjqA+8MHbwlq9Xl7
         aYQqRPt3WdVX0KUgI1+bOdmOKO4Zk3mLIimLVZR451L0q3R1PmQSa1mw8qca2XAhzmZp
         fEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726017; x=1759330817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxm1+BttfzZabXPoYExS0LpEIkdqq5ptW85BH8SIzIM=;
        b=PaSzQeZgFue579vI9UQFedrFlHpKETEUb02kEjEAh4lxZBbmonqA0FbdzxW1mEqSCv
         PnwX6iJ3OibRcT9pho4amXo/CbHafoR0yFDwRmB9vC6RnrKboI8ZK9i37N7zv6LYa89J
         1229Ao/X+3Z6xLahWcWmsK5WySPQmw8BHyyuhk8wwBzBTUlVO3KpHN9izxskLWHMhOhL
         1Adqx2ygRMjchbbGc+zrC2+dTQD2bsAgHi7DWLEMSsh3aF+8BEuPWa+AZrRAFFqKm8Ay
         BSEF28fXAOTo3i80pPityAKO5vf/OMr1jPwZXNXgtk2eGWv2DK4BNnf5/A6HdTem2Pwx
         lCzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9StF/ItKdLHgADExDcK1L2xKOVc7DUFM6w41qjijsyzEsYVZ9iPRDHEhMZUu1X/Hod5y3mu9xS10Tn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzBtyBTjfl2ZlpPTxf8i6KdBZ6jdV0cJwwk6MB5Q/GtOm3KR6
	XMjsqOejtwpL/xKj0tQ4EGwLfrLUDz7Vkgb1yn0QMRFS+/YU0bTjopuCpLo9Mxo4wGZ8gDRGTZs
	a34+uZYn0IRvElw==
X-Google-Smtp-Source: AGHT+IFbV4XCppcQcBh4YT0+YYYGbMDe4to2Az87MctcSzey34CxXXjmAG4jYevOjLMuvS5zxWssC7rPfCkOlw==
X-Received: from wmpz21.prod.google.com ([2002:a05:600c:a15:b0:46e:2f78:5910])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420e:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-40e43b08a86mr265628f8f.16.1758726016966;
 Wed, 24 Sep 2025 08:00:16 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:44 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-9-2d861768041f@google.com>
Subject: [PATCH 09/21] mm/page_alloc: Invert is_check_pages_enabled() check
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

A later patch will expand this function, making it ugly that the whole
body sits inside a conditional.

In preparation, invert it to de-indent the main logic. Separate commit
to make review easier.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a1db87488296a6d2d91a1be8d4d202f1841c4dfd..10757410da2127b0488c99c5933422fc649f9a1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1752,13 +1752,14 @@ static bool check_new_page(struct page *page)
 
 static inline bool check_new_pages(struct page *page, unsigned int order)
 {
-	if (is_check_pages_enabled()) {
-		for (int i = 0; i < (1 << order); i++) {
-			struct page *p = page + i;
+	if (!is_check_pages_enabled())
+		return false;
 
-			if (check_new_page(p))
-				return true;
-		}
+	for (int i = 0; i < (1 << order); i++) {
+		struct page *p = page + i;
+
+		if (check_new_page(p))
+			return true;
 	}
 
 	return false;

-- 
2.50.1


