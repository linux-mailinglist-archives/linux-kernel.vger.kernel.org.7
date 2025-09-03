Return-Path: <linux-kernel+bounces-798359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF06B41CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8A1751BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC326F2A8;
	Wed,  3 Sep 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHiH2qMy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433481A76BB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898180; cv=none; b=aPAkHmDeS5tfktHXuXwHC5qADDmRL2yvt2e6d27xQfw9ynSm0jWHHaUOJOObKoT5vWOwmkNfQPLff/gKR/VdNzltyfnygWyjCZkLV75EfLn+LHXiG+eGQkMW/5o+WHWDg2hcNEWVm/9PUOj2U2CQgGCehWOwi5T0n/2JLfrrvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898180; c=relaxed/simple;
	bh=J9NK4fLqHaAYdEhT4UhzIhpuuhnmYT6Q7PMGcMC8ypk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA0ubCkRkP6Pn/axkhhmVbQqgtr8rbczM1pSJPNZUDWCr0DbJ3+Z+sPSbFYmDVXT7a4xmK0pk4ZH3AKsMOCrJ8IhrTn3kac78/1qQplZgI/55B5M7HzTkv3S2oeYf9TQw8jh+D21Oqw5yLhUQey2hMWZ593jF/7K6lMoG7EgtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHiH2qMy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d44d734cabso2568865f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756898177; x=1757502977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lABkHSnvIXMnQ3mvHA4p3Yj4MTD8nCbzazJj3CjC75I=;
        b=UHiH2qMysK24qpCQ8sZAVjwAlVz2kkCZhZyXmxxSnmbO+uHoN3HvYAV0H0vvVEYqtN
         K4RNf/HqBhf5zwhJ0JpPetrk/t+6uSYx2/UIaEKtiwr5gCw7gn9MM0Su5YZO/35XMnrA
         DanDP6Jz6VpenEDoirQR4awjE9L1xW9O7ulaMbDDiNilCZTuXmbpc1RJT6sXC7qu6QBq
         SCXxccjBTxGgHoCXK1BdyhtGT4cPSf5TQ/Ob60B/9N8ll/lMy1L5IvlrDS35eGQ48et0
         Z22ciFMVuXWxRuxJMxCHtWlBtK8frzpmI1Kl99md+8plfIZt0Z6DfbPXtJ4cqpieAy5F
         DnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898177; x=1757502977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lABkHSnvIXMnQ3mvHA4p3Yj4MTD8nCbzazJj3CjC75I=;
        b=RYNMFKSqN6SSImqSabdIldcYliC61kJHSIfYKROJ07rEsddV2Rws05QVPG8OHF9TmY
         LDbmnJCThySZsu+eiK5b5ETu3zGDPU1H8SdVkdBSEF94ZDZiu4eMoqKvLgWCMBiLimEL
         TbmB50REIRJwckHuEEuMFOj00+cz77WKnq6y0DwkbS00efL+yGE5aUjI/FlBijh/61LB
         btz11toKZ+rxhLoP8Jqda9D+cZk0uzS1Pjg3yREz1o8mk4I1qJcGFd8Od2dSobarHTut
         /1rLOCKvs/31IhughzG+jPFjv6l3cabmS/0jz73njLKTX45wqgnzDEu1KnrDe1E4EVto
         up+g==
X-Forwarded-Encrypted: i=1; AJvYcCWx5+Oq5BiknqF6mXug7DHURVyrgLtnbVXuo6XqRAHZ85ORrYc5EMDTNS/dzKriGUs+zPccsNR7+Q5qBag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+trIVdQYWSCYXsR0emW+2Ra6/CRhQvtC+skWgZM6UGtqQ1Z51
	FuL6U1bdwTvNg3MRruUlqnwwIx9YxJG+U00MIGxnz+qXqvKeqk07C4T3
X-Gm-Gg: ASbGncswhlPdTwNU0OsORg4oat9EYIfp3XY2ykpk2N3T9Qmy/BKWg4HqQqbvOOBalOT
	fHc1zvHO18sufqRxaUmSbAV3PM6T283cmtJZv4yW0MD/2QbIpuKbz6CAWT8T9d28UOCJxcVKoRO
	AFohuKLiwiID0FoV609TDwNpfRmUo2pFSfyC+W0xYVfB8nvwJfFpjryw01nRmL9Jj1ntZfGeC/U
	ifcPzWjl1ZuNgmMqoyj15ui72wDXLy4epZc3lA4fqUfQa3Q62AE0ZEQhiRfTMz4Yx1dvid6rK/0
	p+V4sLIUAhXVGurRYHmJGOf4tQEIxdVz1Z+azVfMAGkMoJe+ZYI6BVnAVJQWrVCvrTYGpAiQkY+
	rrIgD7M5evdhKXQ==
X-Google-Smtp-Source: AGHT+IGyItH6fhxqweNdBqrIhVxCLFxL0ES/3HbetquX8Ifljh6FJc6e7DueFc9I4VoDCyRFj9PknQ==
X-Received: by 2002:a05:6000:4203:b0:3dd:ab51:d979 with SMTP id ffacd0b85a97d-3ddab51daacmr1895384f8f.10.1756898177219;
        Wed, 03 Sep 2025 04:16:17 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db72983560sm4717559f8f.1.2025.09.03.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:16:16 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/show_mem: Dump the status of the mem alloc profiling  before printing
Date: Wed,  3 Sep 2025 04:16:13 -0700
Message-ID: <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756897825.git.pyyjason@gmail.com>
References: <cover.1756897825.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch prints the status of the memory allocation profiling
before __show_mem actually prints the detailed allocation info.
This way will let us know the `0B` we saw in allocation info is
because the profiling is disabled or the allocation is actually
0B.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/show_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index ecf20a93ea54..fd85a028a926 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -427,7 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 
 		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
 		if (nr) {
-			pr_notice("Memory allocations:\n");
+			pr_notice("Memory allocations (profiling is currently turned %s):\n",
+				mem_alloc_profiling_enabled() ? "on" : "off");
 			for (i = 0; i < nr; i++) {
 				struct codetag *ct = tags[i].ct;
 				struct alloc_tag *tag = ct_to_alloc_tag(ct);
-- 
2.47.3


