Return-Path: <linux-kernel+bounces-847394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB09BCAB41
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A594F3F77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC82594BE;
	Thu,  9 Oct 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elCnkUT+"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1797257852
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038178; cv=none; b=XgzS6DKgu/ojtmGtyd90kJcuhrjxC0y5hNanCBF1dZh6gpK2yAa/HkvHsVWBOYgQumCFfELJFcRtzdQdraWPblXeIzFGmnYVT4x+sgVYF41trRILmBE8PNYPcEa6ZYRR6RxD4goc0qjkpEIxoCPxPz5o+O2mGFxIIRnA77yhk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038178; c=relaxed/simple;
	bh=KXJPBGs1YcYhQHePlm1fs3pOJ7hOLwlS67jygBzBZkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1r3q7AsqmslBHKqGClv1xujF8q3pAxw3GywKm9P/dcTXE/fn2d1GjvQoPHazwZQcC/MBLmUisfK2lT1OqwHaRevi4dz9GmBIhyW0mWkSJZ06SCiUH9FglOzP9AgY4D3euMK2F3vTr9DaHyc1lKtRhLfMtUhtgppL5aSalSe3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elCnkUT+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-74f6974175dso14919387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760038176; x=1760642976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4JVrDAekAXuIrNrwEZUDzZE6GN5LqvSaIQ8Jq5w7+s=;
        b=elCnkUT+UBJUaNvqzRX3HUjiesX6glbTxcXKZ+UxejJvnnDPmcGVR6DBVI0xWLQg93
         Y2XaeLppUMseYSL18z2pn4aBnc5kiZMRcsihfPVlPahCn1gOt801scCMJv1Cf4s8gxcu
         yCJR8s2l57tHKHfjQKDZC9/gKDlHXHAi8NZd+MDqTNnZATxW7cuG0P3M5qDYDNX7HxXf
         RBMKsaBZfZO/Y9S83IjJiJTjsyU18cXTF7jqPAnAkTasiFBBfdgXjUeNAp8PbAANZXm4
         qWtjDbsPm/W8FA4zWQu672vcuy62YYwaWfkppvELAn60VgQgGnH9lYjqLp1uisLD/hcA
         JsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760038176; x=1760642976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4JVrDAekAXuIrNrwEZUDzZE6GN5LqvSaIQ8Jq5w7+s=;
        b=wd1hDgd7Gre4ru3JHxWWuwne6kmnksVzJPCewhnjsJl8+CBHfSVdAjpLHhcolEpaLP
         Jf3RKjzcj1BUohs2k2d0AWsEafkMysRL2BI1G5zWAevUj0bBES8GiM7T8ckd1cbXINOW
         JuNV5DNbypO6VwhUgs8LhkL85nxWZsZurzvKOQfM57HwuuIN0focd9v79AYpJt9J5PG5
         jqk+4/+ZJ9ClIR8Zb3oonyLkb95x0U3JOuLWZaJ3PJTEqzBv9LeAwhdHfzuJg2QGe3iX
         pBzLbKGmMeEUeH75Qv4vZJoA3AfiMeteM01F9vo4N/yr5xT4ktjs5OqVb/hFR1lp45hs
         PtoA==
X-Forwarded-Encrypted: i=1; AJvYcCVia6behUFKIfsSRBJ6pFWwG1X7T+XMVdXBoWEPnuNfkvX/T7KJOTHT4+toFNYaELlEojTD7ZFsZiOlvDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFQ7DnQVT5S/YiywJT3CPNJtDLeJl3SJqIUCKDELBJNJYJ2r5
	+g1OOR5IkhLJ3Kvtw7Rs1NPLUjcifrJVTydTCmg3FYSxeXuAs5D9LvFy
X-Gm-Gg: ASbGnctmF7sLpeukFOwgNNkcZpkL853jqEmNhZBRq8QAW0U7RiEs4IX+jVyDkqUQ4TT
	9AOCUY5Y1YuMMRmemepr7fUX5L+liozl7NffzmPws73OuSwPw3rY8+8tuTE1WGB+18ytwiVOOMO
	/LKZc8btCt1m1798nPYy+5B5CkrEHURVs9EIk+s/HmxRZKA+UdvLiMPDZqdox5myaBJeqdsuFOF
	PRqFjMEgOpSYYSC3ydGl4wvHBOEcdy4b4PJ6dT61ZwKcLvW7/N1wcpPzF2RV10Z8ZrZe9NObk3+
	lsxrakUxWzYQu9SB++6SMwzyKs2qTGwF7jXfVWG4PRpD/2nBcaTfm0qS5Vj2JbNmYNtVNdkTGkK
	slBdaKFDatqDMWYDGNpS6gSLKs1dgEcpKpY1Ptb4c+dZV+yp+9yZl84c33TBlX6Xd5D15aQG/ud
	VeJLxmjawLdgQWkQ==
X-Google-Smtp-Source: AGHT+IGiOdw5BMKTynbrKMyeKesCVN1/w5QDieM/W6PlPmireD6c4K/lhK4RmxdY1glQnGT/XKIxJQ==
X-Received: by 2002:a05:690c:6612:b0:781:2a:93f5 with SMTP id 00721157ae682-781002a9ceemr27506087b3.33.1760038175527;
        Thu, 09 Oct 2025 12:29:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78107263387sm889967b3.50.2025.10.09.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:29:34 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] mm/page_alloc: pcp->batch cleanups
Date: Thu,  9 Oct 2025 12:29:29 -0700
Message-ID: <20251009192933.3756712-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small cleanups for mm/page_alloc.

Patch 1 cleans up a misleading comment about how pcp->batch is calculated,
and folds in the calculation to increase clarity. No functional change
intended.

Patch 2 corrects zones from reporting that their pcp->batch is 0 when it
is actually 1. Namely, corrects ZONE_DMA from reporting that its batch
size is 0.

Joshua Hahn (2):
  mm/page_alloc: Clarify batch tuning in zone_batchsize
  mm/page_alloc: Prevent reporting pcp->batch = 0

 mm/page_alloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)


base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
-- 
2.47.3

