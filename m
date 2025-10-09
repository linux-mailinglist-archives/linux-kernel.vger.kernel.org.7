Return-Path: <linux-kernel+bounces-847396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25890BCAB47
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B8484292
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5E25C81F;
	Thu,  9 Oct 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJR4E7vC"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC62258EC1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038183; cv=none; b=i/SzvZtE5/XLT6IXRTji/39Whjh7tQst2CD3Z97EDUtk6OGJk3eqVMe9Ql35jXfYatAhQLXkjxd+iTFEyKoqLMitB4RiQ1/anodrqNKWJxOtBKeFmTe+ujKuL8A0nvJmtftgwETasqpArTQd7XYZ8rf33/bKA9ZLTp4hJBorCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038183; c=relaxed/simple;
	bh=0M1TfKPyLUh2sBmaPQn+5lO4SJZCKYXkEbKMBqrUShk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJUtxLwc+2U8t9wAevy6d617FBA3GhrYX+D6RIvV1nc/MZFYIt73yacK5xznpgzqK8CFtiwA1XmHiy2C62yY1j2tc0WmnSzQ6CGSX0BzPY+YkZDTO0OM1DOSw8Wvk+YL6xiXdLeHEDfvk373SWul6pymzN3ljA6vbaWSKU/XrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJR4E7vC; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-73f20120601so13806577b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760038177; x=1760642977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VEjyNy7tN64B8nrQS8xzAtMWitrLYtXSjniZj3owvA=;
        b=CJR4E7vCXXMMQL4gnsOzxSK1HfhbVS68K3bRLuNSaxWR3PFK1NoDP/mYUcBZbpGzA0
         PPqkc7JBZ/rpDCpKlwbd/fzjGC9MZi10ptPOKPFox4FOetOvoWQuv4QoG2cTAExv17EZ
         4mgZudCRcBiTQMqCG3FF/2T6uYgzXoXSAsY0LOg0dkJEcRRQE+D6h5dD7gqDNpFXQMjU
         LsuwBZASf3egm+sxgsT3gNINdX1lz/lsnB6gZAEQHZDspUJHqR3FaSR1EB6esYYZGCfG
         0yzScqKp7vSW7pRgXwvIN+Lt6F/q/Cfm/LYm/7WbZq+8vtZOUzyyKHSdObvPtUxmaIdT
         P1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760038177; x=1760642977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VEjyNy7tN64B8nrQS8xzAtMWitrLYtXSjniZj3owvA=;
        b=na/jQApafm8PrhG8W1mJ5tIGsMkH4iIrOFaJIA/6X0ORY5MoiC8jviqZwNLO2jn0mJ
         DneXQ14WLeC7vjsDPbhGqiBisB5wJRxUJY2N8yw6r4zI+KCI+/y0hDN+thmMqucd56xV
         q92/y++y/IDChIWbfOkbyo8cVcevbb4RJKZc1sOExjZdYMbRY4g9rmKR15Ydrga/j6iw
         yleZH+8BPbS/d/q8xoFrPLQ9xQrBsfUEdcjQ06xWNHim/CJZX5KdSETh+bpOVxCWYLUI
         lYaoGVEMgPBg3MetBRW3koEZ2MRmZTCzBBd+qGdoS9yO5SqR/TevBLcHo4TAkkS72M6W
         FSkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQZMiSbqJ38IBEM1TXtsNxGWAwaNI7A4jQAsf3mUYrE0nJ0kzfAVBhPZ2Xl2Ms90rwJv+3ru0F40/LUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+yiEziULJej+UwaDqf47NNDu40CP6BPmMgfhQ5Icxo1Rk4Gc
	2ljM8mnE9arloQv4GWuXUdhM+lf+xDTOLtHNExRlyzVcysE7GWzDrAi9
X-Gm-Gg: ASbGncuzz+5lHtBlT+r5t3ubugKuFM6rLIb5OABJeoCE9OTB/aYw890KUVsKhi3WEOV
	FgDTXWDzQYUTAio4h85XL0ueKNRC4OdpW3IOpsK7oB0SBefYG2ikEUrfyIA7f39+Dzw+SAtXem0
	xA52psIYy68KOSnKfid6nmQSVConDkUbmPCnCtw20nrB0RJ+eTDzgj9qPmJGXvVBobax/iPriuT
	OTpDY1FwlVtuxxN6iKHARvZyZixhjrH1QJAfvHCmPBQOlyrZ/mFqiewtLcADg3/ApKXcoyDdmsd
	FLmSjeN1adB4h7KJNOvJataxD5ryHNyF+8JwicJ2ze7ib7enmOGk1XV8UhOaiZrs05euA6nT9sh
	9mg7hN/iE10yT9Ok9Cs4aR0X6qoLgR8TaHt3WZjzwzhif0itZBKoYUQulMgCHXQmmap03IMS7G9
	Ol2IET0PBEYDzH
X-Google-Smtp-Source: AGHT+IEgIaAl0gJP13GfBH3rrO9w0VcepI90WGQQz/0Jf7R5/XJoVA5nO6QCWLHKqqeDofhf8Vg/xA==
X-Received: by 2002:a53:c04e:0:20b0:63c:e0bb:2e96 with SMTP id 956f58d0204a3-63ce0bb3b00mr1965060d50.9.1760038176568;
        Thu, 09 Oct 2025 12:29:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63ceb928a99sm37037d50.18.2025.10.09.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:29:36 -0700 (PDT)
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
Subject: [PATCH v2 1/2] mm/page_alloc: Clarify batch tuning in zone_batchsize
Date: Thu,  9 Oct 2025 12:29:30 -0700
Message-ID: <20251009192933.3756712-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009192933.3756712-1-joshua.hahnjy@gmail.com>
References: <20251009192933.3756712-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently while working on another patch about batching
free_pcppages_bulk [1], I was curious why pcp->batch was always 63 on my
machine. This led me to zone_batchsize(), where I found this set of
lines to determine what the batch size should be for the host:

	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
	batch /= 4;		/* We effectively *= 4 below */
	if (batch < 1)
		batch = 1;

All of this is good, except the comment above which says "We effectively
*= 4 below". Nowhere else in the function zone_batchsize(), is there a
corresponding multipliation by 4. Looking into the history of this, it
seems like Dave Hansen had also noticed this back in 2013 [1]. Turns out
there *used* to be a corresponding *= 4, which was turned into a *= 6
later on to be used in pageset_setup_from_batch_size(), which no longer
exists.

Despite this mismatch not being corrected in the comments, it seems that
getting rid of the /= 4 leads to a performance regression on machines
with less than 250G memory and 176 processors. As such, let us preserve
the functionality but clean up the comments.

Fold the /= 4 into the calculation above: bitshift by 10+2=12, and
instead of dividing 1MB, divide 256KB and adjust the comments
accordingly. No functional change intended.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/all/20251002204636.4016712-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/linux-mm/20131015203547.8724C69C@viggo.jf.intel.com/
---
 mm/page_alloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..39368cdc953d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5860,13 +5860,12 @@ static int zone_batchsize(struct zone *zone)
 	int batch;
 
 	/*
-	 * The number of pages to batch allocate is either ~0.1%
-	 * of the zone or 1MB, whichever is smaller. The batch
+	 * The number of pages to batch allocate is either ~0.025%
+	 * of the zone or 256KB, whichever is smaller. The batch
 	 * size is striking a balance between allocation latency
 	 * and zone lock contention.
 	 */
-	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
-	batch /= 4;		/* We effectively *= 4 below */
+	batch = min(zone_managed_pages(zone) >> 12, SZ_256K / PAGE_SIZE);
 	if (batch < 1)
 		batch = 1;
 
-- 
2.47.3

