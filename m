Return-Path: <linux-kernel+bounces-788575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF32B386B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E496C162286
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28429B8F8;
	Wed, 27 Aug 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1V7Ry/Y"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B52C2368
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308631; cv=none; b=d/U/I+ZXsYhwLNAcIycjGByLZqaT0OUy7sz1/qMtEsrZgVxhdGQL4yIiOk/cP2LOL0xzTsnvG73xCWBVH13YdvW0HF5sHTrz6mPqfbLWj7yLVen0/YfRauNnQBQ0O5MOc4Qd4gMkiPAkjrI0RXR2oCtPG6r1pIoj2tBvsh84R84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308631; c=relaxed/simple;
	bh=nRBXuJZ3I5e1TctbwJST9Ghq/VA5jwV1pNUBnMqDY1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=snQrYt+xToQuh/Dyw4YZFm9y33IOR5fibISmfqKzeFuXd71mtFxgMuJdBzxdOZ+nnjZYDitGEI27zITKdS7Ydb6nHWk4HRe4I7DNFr7E8PZFeTpBazECt2p54MuOCcTDQNKj8vDYPOQzs+82Cnw79gZVgfXiq/CZg5aqQoIl7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1V7Ry/Y; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so47813435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756308628; x=1756913428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2lcoD1SkCJi8dEvMItuNydCcCeq1NBdI+5d9T3pGQk=;
        b=N1V7Ry/YVS8gEtFnR9CYMo+CuWALymfZv0zi3fB80/hpMmgfmpX/L3DcjC3YEUMuPe
         yz6aL9GhND10gnUsm/BxRDNKasLJYIrj7gxD3xb0IAkwUpJtAEYT7rOPM4MFwzTxfK+Q
         s4laPfAxmR69Va8LKz7Yidsi4YuMePm3Tn9me50vqeKAsAmQcLcds+fwvgtyfdh7sfn6
         PXoC6IUJuwbgg3bifBjnKH4Zx4JjYWuzGYXtt4ghLf6sG5A+M+h2agBulPUup13heTpL
         N0X4FP6y9DVubpEz2RjWiRCiFc509JOhTTBgMU+Vrz0K0eSpW0MD9Mi7MRqpSg8stinC
         eRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308628; x=1756913428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2lcoD1SkCJi8dEvMItuNydCcCeq1NBdI+5d9T3pGQk=;
        b=qMoPaid8WBgV6XWXy/hx5mSB/f1JMDhDvMcCv9FMVAfscyIcQ1dtprj+G+mdMTlQi1
         /d6h8PAK84NGkEb8gc9luCoEXR5IGGx4CpvD9vqEa+jMTbc1IOfmYrEKhDliNPP/c/4r
         FsQwD2qCylIsvVZxeyAJ+aijk5bCdtHz8//O6xtfhD3eRN5/j3prTbsrN+u9dJyEjA87
         22St476TUw/eYFzQmOf9LK5APQIJ1nD6NbLNgiOPDTJMXymgC5cyNRtCOWvaLALHkpBX
         SLHifm2wUPrRv8RtRugUQJ19QGJxH0/3w5ImR3Q4MZDbybf5Mx0st2kZz2eW2f0Mx62Z
         YsoA==
X-Forwarded-Encrypted: i=1; AJvYcCWTE0rKEiBxzEsxTPGQHyYWv50CZL0KGsgnFgqcRnSbShPwuK2oeW9s6DIatfDVKE4myq7Z4hhIdOPs4r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImnodkk7qvVIB6FK2BXuEvjtu/+2bxYJgzw07PPIl+hkkfY5m
	gOc5qcP7tcEQToU7FHlcaaiYFEJSqb7Tx0Y4aQp9lrky9SR4pkXf3COfM4nu854fo/wb77sFdLX
	j/rPOSCcdbW1/tA==
X-Google-Smtp-Source: AGHT+IEvXocNCcysmhKTOTVqBVS/7zQEmjrI1mwpeLDOcAO5bM1y/TcdWjOA2UfYgroW31bB46gdDNVFr0ea3Q==
X-Received: from wmte19.prod.google.com ([2002:a05:600c:8b33:b0:45b:73cf:2862])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1994:b0:45b:7185:9e4 with SMTP id 5b1f17b1804b1-45b71850b8cmr27223015e9.11.1756308628229;
 Wed, 27 Aug 2025 08:30:28 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:30:27 +0000
In-Reply-To: <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826-cleanup-should_compact_retry-v1-1-d2ca89727fcf@google.com>
 <20250826191320.d5aa551eb5abef316de41175@linux-foundation.org>
X-Mailer: aerc 0.20.1
Message-ID: <DCDBG4WR1ZDF.23COVR1IO2OSJ@google.com>
Subject: Re: [PATCH] mm/page_alloc: Harmonize should_compact_retry() type
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Aug 27, 2025 at 2:13 AM UTC, Andrew Morton wrote:
> On Tue, 26 Aug 2025 14:06:54 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
>> Currently order is signed in one version of the function and unsigned in
>> the other. Tidy that up.
>> 
>> In page_alloc.c, order is unsigned in the vast majority of cases. But,
>> there is a cluster of exceptions in compaction-related code (probably
>> stemming from the fact that compact_control.order is signed). So, prefer
>> local consistency and make this one signed too.
>> 
>
> grumble, pet peeve.  Negative orders make no sense.  Can we make
> cc->order unsigned in order (heh) to make everything nice?

I think we can't "just" do that:

/*
 * order == -1 is expected when compacting proactively via
 * 1. /proc/sys/vm/compact_memory
 * 2. /sys/devices/system/node/nodex/compact
 * 3. /proc/sys/vm/compaction_proactiveness
 */
static inline bool is_via_compact_memory(int order)
{
	return order == -1;
}

