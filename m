Return-Path: <linux-kernel+bounces-825149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C1B8B1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98027BA073
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840C32144A;
	Fri, 19 Sep 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO/FHyLK"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB32BEC27
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311549; cv=none; b=S6UT3pXD54L1M+toCq8Ed54A6rwWV0feIPWoMqm+Y0mq8P71xNBngTf46+nemP5Y7J+IDs6WeSMMB5THyqX7Eko4E49kUBWwAZxhWtwu9/tC71J4r3opEEQTDqBD0pdAVYKDPexBlCofufJwexiWu34fNCNEm1SPlxMBZE+eF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311549; c=relaxed/simple;
	bh=42+eESs+hNHeT/GrhhilKtr9b3BDoXjdJa2yGQYtxfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJvhPLkJKQkPVrY+x+Zuik6FNLgQ7WdW4vl0MbtHyWxooFCwMnmYizH7Y8P3qlc19oiMDTnptu2eI6xZOvAyDdN7vH/Q2tPB6mmMnS+27XD5prcFyt93RmIOiEMw5zgcniks4hJzRIz8vYyiovnE9S6mWtpPqdBmep+mfUJ+Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO/FHyLK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72e565bf2f0so21305807b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311547; x=1758916347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRPftj4LaqpBRfvv5a/Vndy5zTyggHCJw7J9EdAecUc=;
        b=nO/FHyLKhKTWszg0s8XVUsgLLVQmDHtPeNZKK0q6bd6tH5AmvxlhCMzGIFL6J+plEn
         MXP/K59joYB0T2Aio5H+NTcOUYzAX8a5qwTED9LpF6q9MZGFsHhmyRtXkA+H7Ztoae7M
         1TK2T477QRj4Mhp7rs9jdxEYabWJwbI+RxZzC5QNWF+bI7s75mn6a/qPrGsvTJpHb9ds
         23tMs6iFXx9emwldPDeohIHmAjIfaAalaIOwlEDluj7XEDufwMHAiK//TPO6BbHHoiDH
         dVIQnIwxi+XVWcOmiUk4EgyX8DBT4Ot4y0CL6fAog+oR/c+7MMBJGcs4LSDgHtRoTIZT
         KP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311547; x=1758916347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRPftj4LaqpBRfvv5a/Vndy5zTyggHCJw7J9EdAecUc=;
        b=Dvc/51ZDv/KQYPWbwzOgsMnRHMo5PLljCypk7BH0OeM53lwjoprDnDrIkoY2/gNtau
         bytnba4FtTzLZmRBEc2EcE3jrHb//uqZJf5CT6ytqSH7QUdo3k2aQvHzcloIE2CO55Ml
         Uhakh6cnjG+bbgoxeEU5RKoIfEMs0x1tZagntci5kP2fyNxJ9QeC9AWNYcpu9L59QKAI
         BjwAsfixPE0oV5ZHuyq+rOrcV5324D6/4qTIvXeTj7Zhs2/311ihtmEOFY5YA+wfzV2P
         odvcXWjvpbjK5UtSC9Lr8yPKrnP0fz9YFDr9pNPd/ACVI0erAtbkCeiekdvj7NWYV1j6
         67Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVINBLAqZNIICWRvCRnLyNsyqE5JxX/reJdjOLgrlyMU5IWCVxytqXJLT/Ug94VTvEn8y7rJb9T1yqW4zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCydVHV+DEe1Pb8tFNrBJEw1pQ8WCwmhalqZKEq4DLCj7Gv2ef
	yzGOUf9VWhqOROOA/0wvuOjYSVzRhls8mOVVOSyFNpn1bAKaf5tMAgMN
X-Gm-Gg: ASbGnctCwCRZuHNzQlN+9E/URnh3UcTSgpavgPDhcBMmjLDRWKS9MJEGC645GNr/RYv
	k03vNYplGomUcx0DcrpXhL9MQRLpTuXHY6CQKrOq3gY8axrWUjiue7H6pmT34kMlGo8Z6ReDoxx
	0VG5E45RCex9MIhLTc8Kgl2KHRl+WuKKlL55l25pb0XdA9Pe48pk0gslu2fEfr0Z4Lqmy8H77v6
	ADcSedCZypBvjmRUhJov9aodsdjiXADgs6G9FKkjoLPshMqI42yWQwMtzj0yPJv9RIikaXc2eHJ
	4Ah5Fg9fWkMRCtTe8WB1EP74ouMhh1L+y5mEwpGc3n0UvjP/gcuotR87tFmfS1vjZSJYgbNcx0x
	k/RZIxvgeT8nJcdmqHWzGjin2c4GTJO5+T/ja7nqSqM0cyT04Y7Cg2g==
X-Google-Smtp-Source: AGHT+IEdgDrFewuDJoDd3/cY/EMbtsLE4/UlFxrWj3yry9gWHcvbmUqj/wKnoUCikShDc6KxoRtvUg==
X-Received: by 2002:a05:690c:3507:b0:729:df2d:4a23 with SMTP id 00721157ae682-73d3a52a51amr39975377b3.32.1758311546930;
        Fri, 19 Sep 2025 12:52:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716f35c5sm16631707b3.22.2025.09.19.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:52:26 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Fri, 19 Sep 2025 12:52:20 -0700
Message-ID: <20250919195223.1560636-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
References: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drain_pages_zone completely drains a zone of its pcp free pages by
repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
In this loop, it already performs batched calls to ensure that
free_pcppages_bulk isn't called to free too many pages at once, and
relinquishes & reacquires the lock between each call to prevent
lock starvation from other processes.

However, the current batching does not prevent lock starvation. The
current implementation creates batches of
pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
Meta workloads to be up to 64 << 5 == 2048 pages.

While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
indeed can be adjusted by the system admin to be any number from
0 to 6, it's default value of 5 is still too high to be reasonable for
any system.

Instead, let's create batches of pcp->batch pages, which gives a more
reasonable 64 pages per call to free_pcppages_bulk. This gives other
processes a chance to grab the lock and prevents starvation. Each
individual call to drain_pages_zone may take longer, but we avoid the
worst case scenario of completely starving out other system-critical
threads from acquiring the pcp lock while 2048 pages are freed
one-by-one.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77e7d9a5f149..b861b647f184 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 		spin_lock(&pcp->lock);
 		count = pcp->count;
 		if (count) {
-			int to_drain = min(count,
-				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+			int to_drain = min(count, pcp->batch);
 
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
-- 
2.47.3

