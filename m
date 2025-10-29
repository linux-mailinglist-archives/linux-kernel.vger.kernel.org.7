Return-Path: <linux-kernel+bounces-876941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1469AC1CD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F441890704
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6F35772F;
	Wed, 29 Oct 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd16Sndz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F535772B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763568; cv=none; b=mpNJ+joWTNw5VH1TGkwkVbyqAk25qFvFZl/5dXxMtghpx00IpmscCGtD3zVUtY/XmT/fU1Pf+kF2CNZHBDr/xyr2hXeqOI2vr01JlUmCrpJ5/kewawi8LVx9JMK43pUSR73YAuyq8P2+B/ZSeD5p+dwkgr+rkRMHew5lzP0INkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763568; c=relaxed/simple;
	bh=OrWlJ6JZLo/BrlSCnylCjyhXG4lAUpfhVMbOLTF90HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhmOQ5RIiwTYHg4aY8QsSu8ZUeH6BQyP2OvmrPJLRvcOrznX5BvyfqJa9Q3IxchwBHyWNSLXd4PY08JQgsUZ3C6TULB2wUCEe8qrlB5a7pIXzbyY5yDpnaSsXqSPr9JP67PQRndRgh6ZU5eyO+GWwSW42JK/Zm7HY2cnljq97gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd16Sndz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592f4e622c6so14380e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761763559; x=1762368359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWrPcr+YHQwlDYGWW/C60xpax+dwnoF3boq6mvUGiOQ=;
        b=Qd16Sndztk8IIVz1rCM7JHnkKcdoEtitrpyjt883YBevgoMP4CS/Pl3sRifi/FLUxV
         CKkVhBmAXCwlVdveB2cnGchhM57qldVOiABHaDNa7PR611LnGN6HWIOzVQrD7nj+6ls/
         g520fcSyWC8wp1YfbtOLkYAqKBxhiF1PO+UYAVlq6YvxYmWLuzj9davXzPgYNfs8YsRB
         r4wJEXhFvcgcIO1rSqoFT71szRljIjsIvuCA5JRng/Xu2jI4yWOujerYmChLGdibdicv
         Szs9svoflbXABPwaparVy/Yp/cFY1DgVb5Q83Edur26ntyrlFBTJHoGlz6rltvlx4oC1
         64ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763559; x=1762368359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWrPcr+YHQwlDYGWW/C60xpax+dwnoF3boq6mvUGiOQ=;
        b=Bdl5UaqpcuaCGdkROY+52iMHLwxAclLdv0gakJ8YoiOF6unsSc2mKFH6wnemsJ9qwg
         SWLacS+3ZBMVR3LK+eJOixh1o8FduhhdOEyeWn/TKUAkpq/2s4/iyhumhrCNr6aiIPm4
         OOZIJKUQyO2x0bL6LjWX8m6f9NNypQbDwUUtKHZmdds5LfmjWqojbFYD3o+CwpXRt/iz
         04pD6WKySC7RIGRH73qSsrBpYwuZrcy5zTpN1AMVYWem2U+4PO3B8D6fvHhgICKmd8EQ
         llnE1ftSTGl4ipncHCp+lvAT8ek25LoBFZS56GFofAq8881lXVeHQ0lF1B3UOMtjfVtC
         JYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp3jYjqHbEvAd1M42UHi825bHvgt5qMuHm2pMm+f8V/Dy7jbwSOgzieZx1MgTSIgC7mtuOupbEVjavUFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSbzLhKWw/rP05lGMKduekSBSd0Rd8jcyOAU/LvweIaz8GerE
	GyqdzNQINOCRfGcEC1dhZvC7d4TdNmzeBbodJZJzogqr/s6pTU8kNbla
X-Gm-Gg: ASbGncvAIcIhAWaVEhwtpJeUKOEYgyKFv8nB2pMt0pVymiyVe6sQkuYHDAWmPj+ahTk
	JOJB7eXiPutEhE2XwAhBWQSi0v+ou+E/aV6DnkFW9hvshnVBKhGbo0iS7VT+0ttWGXKJVL7S4o9
	+8dEYTa6pLOdaO10C8KNnf/3PZ5Kr5tl3siKs+NNfNewP/6Y+4tuQGou3YG/2unJ++y11MdPKQr
	R5+a/p2yqvJ50BDFFkCwnzJtRzv/9yp4Pht2+OKuagzPxm3YLsx1uaSVCAKwCsfOdpt4uVT9PdY
	pHbR2WwKCoFKPzWBKOzR5Kb/hLP4JKLRVwxo7EDDXG1cD3PxtNLqF9AljW2Lq9V+CquKqXH1rq5
	xCkd3pVLHm33ucjRg1XCM2r6jsME8yGWwWbz9tIkvaAItrvljYxowJx3Y5Tok/Pp6696NZuAELf
	y0bFZncw==
X-Google-Smtp-Source: AGHT+IGuEzsNziCkBkpixVM7TgXRYPDuuncHpPEAXKQDJA0pf9GlMeK+fWS7c2BxL9a+qZkeWch5IQ==
X-Received: by 2002:a05:6512:2246:b0:579:2ddf:996d with SMTP id 2adb3069b0e04-5941286a767mr855964e87.3.1761763558572;
        Wed, 29 Oct 2025 11:45:58 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5098bsm4044641e87.40.2025.10.29.11.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:45:51 -0700 (PDT)
Message-ID: <c8f89f0a-a327-441e-9bd6-17523c5fa65c@gmail.com>
Date: Wed, 29 Oct 2025 19:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 6/7] mm/slab: save memory by allocating slabobj_ext
 array from leftover
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-7-harry.yoo@oracle.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20251027122847.320924-7-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 1:28 PM, Harry Yoo wrote:

>  
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +
> +/*
> + * Check if memory cgroup or memory allocation profiling is enabled.
> + * If enabled, SLUB tries to reduce memory overhead of accounting
> + * slab objects. If neither is enabled when this function is called,
> + * the optimization is simply skipped to avoid affecting caches that do not
> + * need slabobj_ext metadata.
> + *
> + * However, this may disable optimization when memory cgroup or memory
> + * allocation profiling is used, but slabs are created too early
> + * even before those subsystems are initialized.
> + */
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	if (!mem_cgroup_disabled() && (s->flags & SLAB_ACCOUNT))

Shouldn't this be !memcg_kmem_online() check?
In case of disabled kmem accounting via 'cgroup.memory=nokmem'

> +		return true;
> +
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +
> +	return false;
> +}
> +

