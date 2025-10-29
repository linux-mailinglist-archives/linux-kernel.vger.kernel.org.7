Return-Path: <linux-kernel+bounces-876367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D1C1B844
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 072434F3407
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BF5288C27;
	Wed, 29 Oct 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vidcva6t"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B785189B84
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748599; cv=none; b=XjzmDpr+UHpN4wQlsCnupwUD6qAB6LTi8oTT+Rc1FsvLxQp1Ke22MmBCYd9WdfWTexUxUnABYDELXhovw4VTks50tgZJQ5usib445dEsjU22aA4P6pRGMJQEe/GjX7SYqzMY/eaOl1gZNsTP3M3TYxeNn5v2elvLvcTC9tLEdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748599; c=relaxed/simple;
	bh=oHJlg5Z1ODa4YRFNqoiOQMwC4YO9v08tbXK53/bV4NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blrej5Ytv3nddnNqeIRpWUyHWD1QpQLrpuoIQTt3L+pNhkICnkRlpCbGc8cU2f4gW1Np28D+MnkCrAC93qdI4fAVcQ27oaLB2PuOu88scIu+1scytHBKZEA3nIlFKlXDeIc3eIe1NqmAE3RvKn7tA0fNL7JejiFaYW+mETiXCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vidcva6t; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3615d93c3d1so7077721fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748596; x=1762353396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMm3nDEHqh0Duo/pCGz7alBh4a7cGfmIeQ4bIaczRPI=;
        b=Vidcva6tSsDhOx3m6P/dXqjxH6nAYRuqIhBAxEWHw7j06mk7WHikQP2DdT/7PXdi+Q
         5ylcocJLpaWQC7vYPyBmEZkwZS0t73Zq1HF5R/oRJFaibbTtqVL4gQyr/t0JQCbf1BbN
         mtqYWH7qyGUSMjACwX5+xCmRlTyea8Z2ph9iywc4viRoeLJyypTybCG1PxmvCfp0nbYE
         3KSiXZJSRvySN36l8GtL8tfryL8tWypUtUs3aTXPiKvEm0okaba+zZA6sk5nK17+0/eK
         pYeoIogpeU7TNMZ1k0iwPkWCjHkrByP51G2xE5F/amydjNzQShUdgGXJk9GSgq3GJ5om
         Vg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748596; x=1762353396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMm3nDEHqh0Duo/pCGz7alBh4a7cGfmIeQ4bIaczRPI=;
        b=qgRFhXeSxp6c+cwXVyK/IhJy5rx3wRjPMvs2OArmbQfe9tBJqZ9skfKaq8s5y1XG7Z
         OGbbf6uOnoObJsKZwMTlZZfzHXnjnofoPTtz4986iCUNhw/QXo85g+o/LuQAiXqQ1paf
         N0RdWLq3qxxKMN8T/fHvbrkXhAcnTWZN/ZSBBUcRlQbDqxfFJl1f5gxAyH/wXFCCRiw0
         8CEqv1lI6p1klxMyaD6+5bwZGvaGBQ/YluCg7DczcXNCR3X2XEKqbKm1isLnLy7JvEgC
         gZ7q/PBzO+gMRZN6i7ABMcx1gt+LbmZ9XIcD69xvGtOtLNa+FvYU3T8jNOTYtF4LY6Ab
         10eA==
X-Forwarded-Encrypted: i=1; AJvYcCXqsru1+CpwASIZkutIPnwW317xmnqP8Q20kawI29R1IbkEk8862ILyUfubIcz1m7EnpMGw179B1uJmO4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1jyqyl/g5iaZ+m5GAaaLELa0kPOd0eRLfVy/zDl+jHLebwHw
	3bAbPNQrJGqRHlaM5PeV+fvfWEiCjhLluOe26LJqTrUPuv+K1nZwNpND
X-Gm-Gg: ASbGncuOoPCVOC7s3/SfGkORBBEthOhoOs/o3a3x04MAMpyr2Mvzv7veVWDt0w6rkMU
	z1lnepXNEpXqeP/ZusWun/r69qRkDA5lfJ64VGlG5r2N/Q1UgTUvQPISZMwo+p9waSe/tlewouz
	V0Iicx9+h/mOne1zpOlfieynekF5nReBbH4EwUagEkivDSW4ofhNcrHWXTiWZ/sMe8TGfEyvpVN
	lNfPg9Nz1RU20uhMNpbbgRP/LocbY6ZQmMrhdNpEW6CuWjLEtGaOf3A77+ohOZsn9WGX6UKo4kO
	eOPPReoVeTfNSuy1EE7N8LAiT0QYWMzKGeGxsAJcviEiCAGbzFym9fRyrVyECIxVajMhFqbzYWB
	yu87+d4pWd0BpNZpOzoT83tX6i6N3w2U+7GgPRIyGKQUj0+y64HLdJK48mcbjFK91WoMkoglypj
	z27YY99fHKpFsTQjwu
X-Google-Smtp-Source: AGHT+IFLiz5xmWOhoWEAxRsXVnqSuOwatKraLudgPyAUhj3vj9LKZLHRoICq06za6lOxdckgCWiUCg==
X-Received: by 2002:a05:6512:3f0e:b0:57d:720:9eb0 with SMTP id 2adb3069b0e04-594128e00b4mr758281e87.10.1761748595850;
        Wed, 29 Oct 2025 07:36:35 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f700fbsm3962183e87.81.2025.10.29.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:36:35 -0700 (PDT)
Message-ID: <1bc9a01a-24b3-40a0-838c-9337151e55c5@gmail.com>
Date: Wed, 29 Oct 2025 15:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/slab: ensure all metadata in slab object are
 word-aligned
To: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
 Alexander Potapenko <glider@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Feng Tang <feng.79.tang@gmail.com>, Christoph Lameter <cl@gentwo.org>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 linux-mm@kvack.org, Pedro Falcato <pfalcato@suse.de>,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 stable@vger.kernel.org
References: <20251027120028.228375-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20251027120028.228375-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 1:00 PM, Harry Yoo wrote:
> When the SLAB_STORE_USER debug flag is used, any metadata placed after
> the original kmalloc request size (orig_size) is not properly aligned
> on 64-bit architectures because its type is unsigned int. When both KASAN
> and SLAB_STORE_USER are enabled, kasan_alloc_meta is misaligned.
> 

kasan_alloc_meta is properly aligned. It consists of 4 32-bit words,
so the proper alignment is 32bit regardless of architecture bitness.

kasan_free_meta however requires 'unsigned long' alignment
and could be misaligned if placed at 32-bit boundary on 64-bit arch

> Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> are assumed to require 64-bit accesses to be 64-bit aligned.
> See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
> 
> Because not all architectures support unaligned memory accesses,
> ensure that all metadata (track, orig_size, kasan_{alloc,free}_meta)
> in a slab object are word-aligned. struct track, kasan_{alloc,free}_meta
> are aligned by adding __aligned(__alignof__(unsigned long)).
> 

__aligned() attribute ensures nothing. It tells compiler what alignment to expect
and affects compiler controlled placement of struct in memory (e.g. stack/.bss/.data)
But it can't enforce placement in dynamic memory.

Also for struct kasan_free_meta, struct track alignof(unsigned long) already dictated
by C standard, so adding this __aligned() have zero effect.
And there is no reason to increase alignment requirement for kasan_alloc_meta struct.

> For orig_size, use ALIGN(sizeof(unsigned int), sizeof(unsigned long)) to
> make clear that its size remains unsigned int but it must be aligned to
> a word boundary. On 64-bit architectures, this reserves 8 bytes for
> orig_size, which is acceptable since kmalloc's original request size
> tracking is intended for debugging rather than production use.
I would suggest to use 'unsigned long' for orig_size. It changes nothing for 32-bit,
and it shouldn't increase memory usage for 64-bit since we currently wasting it anyway
to align next object to ARCH_KMALLOC_MINALIGN.

