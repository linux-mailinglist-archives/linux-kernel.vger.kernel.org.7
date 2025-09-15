Return-Path: <linux-kernel+bounces-817730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E62B585B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60F51AA2B26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F270028CF7C;
	Mon, 15 Sep 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2sSuvkv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F028CF5D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966968; cv=none; b=JfcPFBy7PtoL98sh50JoyK2ebo91VdKHjC/358x4deogxlNTflMhP9kVd7umhT+x2oyZKEhf2JuD0xTUxmhgZJAfp4rvtEyuj9Gg4QCs6TuIsxsq2fGppjAEhSvKzd9jwTmXWJ+fGExMpA5OjmgvfbejUORcUC5FXqcw8h6UWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966968; c=relaxed/simple;
	bh=77t96hOaTl3mMLmTlusEoP+rCh6LcSN9TjqYu/CWHEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6sF/BxTSkjpbG33I/cNw3Z3JhXsD4VqknECwq94TOc+GBsm+ny10jpnkErNJwG1Y7xtGQcU9uEw/K3SNKcPhVg0QsPz+otgP+79Eaq4e4HE4bcRW4up0KGHUlrJuXgarBNjSiUBArULFl0zNdRCbZSf9NkBvDsNPVRRFIgYsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2sSuvkv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e3c3e748dso1222652a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757966966; x=1758571766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1irnAaC7Dgk7HdImUgdg3erV0zSH2B8o0J/F+rFZfQ=;
        b=i2sSuvkv99ir/sx98CDiGAjB0qVQy9XIOi79I7pOeAnPY4nxz5f10neTL/ZW9kvwpz
         7Ja/hsdVUDuCOp06BL+D+XyEzlcx0hmUpO+a8abRmzFyEvWTF/o3y1H0gZSr5YWmrVBd
         MiW9BxkHLcRNK9VQLwGyr7hFFroQ3MOk7ESxUFqL6rqCrILJD1CHErP8NkDVnZFgxiS2
         X9co992y+d/PRHb0CoqbcACBT5nb50FP2Z9ImkBAQt2bkjEvHPwhHO+tBF3hOU05Dd+q
         5GxB8ih73LD0Irk6Fa6UoeyHGwbRA8De+YsMkqmRweJgoEQ6+RJ+qgXPOSlOmL2N5ba0
         AVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966966; x=1758571766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1irnAaC7Dgk7HdImUgdg3erV0zSH2B8o0J/F+rFZfQ=;
        b=Tz0cetdU4Io4YgwUa9LPWkwxIcueSKtVAviuCK6QEOSsQ+NLa0Dpbe4W6ZEiEgZSOO
         1LFWd5X/tjq+B9aNzc3aUuufZgb+8NiOn6V++/yMUGxIPqxoRIAtG3I1IZZLIu1y9fgt
         RyqWLwI/UvCWZmGYOB5tHHcuE3WgUTxR0uxtXQu9NEWqoyeYZX6DEZpDavY/FEGOdfd+
         Nj6A55yIZG4+s9v1VrcyNnH4OStDiFfpeFgTQ8vgimoqI4bYtS0y/J7qJHNte4yOc+an
         ZsLwCiXxXPoj73BD1QzaYUtQ0sXW3Yo29oCNIQwit7izvEAbMdnnGJsl33TZU3uZWD09
         5PLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxHWYI5Pz0y8uCzvqcma45xAOtmRjAl3cUDe/F4gIZsB//az8gA1GJDQdUj+d6AT+1GS815jswgIKevxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FjIvkIyMz3ip2zZxriGs5AyqM1pL+SIEhUFZ0ljtRPBX+Tn1
	ZpOZAgObw5HEO7Koown26pvzO0haRY7eNh9iNptEDYX9ImogwyAZiQeZ0Jd2LtK8T/o6JbivxD6
	X58Id0g==
X-Google-Smtp-Source: AGHT+IGvKewiOGnHoWDqmlqcJxcDGi3xUQdfSPuLW445AIGj+JDuHNOrwmjURPZbSnfYa96dSkMxZkvKBCg=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:321:c441:a0a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5743:b0:32d:601d:f718
 with SMTP id 98e67ed59e1d1-32de4facb32mr15187043a91.31.1757966966323; Mon, 15
 Sep 2025 13:09:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:09:18 -0700
In-Reply-To: <20250915200918.3855580-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915200918.3855580-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915200918.3855580-3-surenb@google.com>
Subject: [PATCH 2/2] slab: mark slab->obj_exts allocation failures unconditionally
From: Suren Baghdasaryan <surenb@google.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, 
	souravpanda@google.com, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

alloc_slab_obj_exts() should mark failed obj_exts vector allocations
independent on whether the vector is being allocated for a new or an
existing slab. Current implementation skips doing this for existing
slabs. Fix this by marking failed allocations unconditionally.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
Closes: https://lore.kernel.org/all/avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10+
---
 mm/slub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index af343ca570b5..cab4e7822393 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2029,8 +2029,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			   slab_nid(slab));
 	if (!vec) {
 		/* Mark vectors which failed to allocate */
-		if (new_slab)
-			mark_failed_objexts_alloc(slab);
+		mark_failed_objexts_alloc(slab);
 
 		return -ENOMEM;
 	}
-- 
2.51.0.384.g4c02a37b29-goog


