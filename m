Return-Path: <linux-kernel+bounces-776096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC0B2C88D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB9E16D3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C424293C;
	Tue, 19 Aug 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkbvX0dM"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE323E32B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617709; cv=none; b=WdDIF8+1KoNt94XzeaGNc8rOB5VG0d4qAIz7FC+uaM9LhbFoIeqgukqyG0o0UvCMW/V+kmBp4WXf//fhODQyEY1yafXOiRJe8sfRJRCdxKbDuUaG0ahaExQdFAxpBheRws+d1GXdaVjsnX98gGpP37bQkZzpXY651T1cMCC2g8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617709; c=relaxed/simple;
	bh=YbKVVp5XW5JPy9bOlKFFoWHR7JMTF6NzhCaopFeyV8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scT3bP8kVqdeqocWusUYgGAmKLJfuvY4k5DNeziWpGfYsVSEMSZ8WZJMsJHsKSnxssV91lc63p6pIMkz64OWwX3Jfc431Nm0Ci/pIOYYXfDrMbsRrYTNcYwLpRGAV4+2BQp8xeHkZJ84Hv4gZuLxNWC4UaJdZwAo+2a4iEfHfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkbvX0dM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d5fb5e34cso10497b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755617707; x=1756222507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toKbDYdLo7GMyEuHj4fkAjUxHgInySnwv2jgwao8mo4=;
        b=GkbvX0dMr2SefIm4liCL/46hmhu1nuG1N4evm/lIU3p+ZZ8Mm9GUdop4+m5t21AHCW
         aCDcrHbowSmDZwUKUBIFP6MWeR7FfZwQy4KO7MpNNYOMP633+93dmFVui3a+JxNMbWxJ
         PxKeXqYWzbZy0vSApA4GufSNuKIQRUlEwskQ1eLt1098+NEk1LJW71CzTIr+VV8qYPnC
         nDXVjVeoSJK2fcq1JOlB9vEsmIJtPynPqBTQes9nfDgAeRInXFecgGT3wLK5Q18t9TAm
         aOATcOPDGg7jYoqoshF6XITY+ZQEX3P5jS86KAOhluSViwOeCClBjqFLRBavRBES/uI6
         i3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755617707; x=1756222507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toKbDYdLo7GMyEuHj4fkAjUxHgInySnwv2jgwao8mo4=;
        b=c6nusQgkxTzvsjaUj4/x5Mh0pBwAXHB3Tv8JCluoCV0yLboudR4H4GAtEPJg5h3eyA
         ldyBQ7SK7mrO8ay89vwyPtRTaOCykb77/DN4jmHxvivK//RNbT3CNrx/H+SpHVl/pmo9
         dxtXWhGHjwtroBrGFDySRIN4i5zZlMTGQqmX8ysRkEhNjsdh/btlCKYG/X6zE2ABiaaI
         dbUhfVxCNQUiHku7//SNy9s2ZPEuJIrjoovBxCL5CkUCcNpgMgzsUprApa2alva1Azyp
         uZ/qnMhNieN2nS1pCEOkZmS+kbsVabOppJ9MkG2K6aIBFZLcs8U34SKi67dHNH/JErBL
         IsCw==
X-Forwarded-Encrypted: i=1; AJvYcCWxQJD6RrWeNS5yRmzpZj6Fz5PSmq0UOQPwQIp1kbm0y8gfTowapCOAi3MMCweXLy3JFqbfVqhNhQpuoGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwALjx/9+qaJGGoDY6wDDtRAGMLn258kBqChUECvKUSZSqPaEM
	93VCWs41RtJZGz7gkGyDMisKBv+wZC49cgc1gatsch+7T1qKt0ycgHDr
X-Gm-Gg: ASbGncsLWNpTm6TLSR6gZoLCpZRlTnUyBHikSlsT+oormRwYyRATrpPi25RBFsmZY/+
	LrC3zAPTybIw2PaV+olxyIh/XVab3hO/6v7Jha/aOep0NcZJ4tJ4liQXPY5UtFUgxg53jtbAj1F
	QqjYxYsUiIxf+fiWw9E//+gwB6DjgE9nIqnK+uz98QK97EJrUclOpfRFNWCMbukEwvGM0DsSZsi
	qpCz/LuII9KIk1UErNwBQgarPgoGoqT3GyUzsfQlxpIj44IByJN4rsdiELDqztK6Kp+kgh5nzMr
	y46HAeCrxkM2i6vndYQWqJCaUqhzg6+eIW+LrgHxItwCDV12b6ypnSgu2jVdbZWQ65lJh1xfESL
	qwUo8X7C+BhfNQLc8AbX6
X-Google-Smtp-Source: AGHT+IEcsXkf1MXgz2gagCv3ucD7FmAzuq2fNp88Yg3wSNNkHMeDfXEGHBsVAKWR4yZOpHcUg+CgXg==
X-Received: by 2002:a05:690c:6d07:b0:71a:2d5f:49b3 with SMTP id 00721157ae682-71f9e9583acmr27292797b3.6.1755617706448;
        Tue, 19 Aug 2025 08:35:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0aa17csm29743707b3.57.2025.08.19.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:35:05 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Tue, 19 Aug 2025 08:34:58 -0700
Message-ID: <20250819153459.2088221-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Cc-ing Suren, who works at Google, not Gogle. Sorry for the typo!
Joshua

> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed.
> 
> Instead of holding the lock for the entirety of the freeing, check to see if
> the zone lock is contended every pcp->batch pages. If there is contention,
> relinquish the lock so that other processors have a change to grab the lock
> and perform critical work.
> 
> In our fleet, we have seen that performing batched lock freeing has led to
> significantly lower rates of softlockups, while incurring relatively small
> regressions (relative to the workload and relative to the variation).

