Return-Path: <linux-kernel+bounces-899423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A771C57B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967E04E6636
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131F1B87C0;
	Thu, 13 Nov 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDR36fjc"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0D2030A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040817; cv=none; b=uBsURW/JP82UTaXzbg2sW1VTXmFMiCdjE7+tHWQesAY7Mlqe9BkalZXN0tFCCUSaXSh5HzebXF2jcxOTn7wrapZppD1QRf00F2YKKFdfI/NDxiSNm0N2uVFD658z0T4qJgUtmzLZjqiBFxXIe/kuPi543e0kfaxAxPvY2aPcKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040817; c=relaxed/simple;
	bh=JoJN7+tJKIXlTim12KYLa40sY14YfzETVU9Njrvls9M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuqJeJYuA/dbX3obEDETIucEIvCr7jMG9iOE7gDp4OZg3Qaky7IU/sjBV+lYjPNiHq0ZgAwz9S+1vic6Fc8gGUO1nI8FQ8WhGKeIr7/ZdhmhX8PAXO/7SgMAAuGiF8UzRC7jc529iEUQWCqfM7X/V4pSlSBVkJBzd82t1SwWZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDR36fjc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59431f57bf6so781840e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040814; x=1763645614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhHd/vd5PilZlak+JY6GVryWSDKciGyRf9y3293OwHk=;
        b=fDR36fjcNzE29GbFRA23uEauf9E9Q3PWB1nLgYmuxEomGjsajArzKz4fqA4+bSTWRV
         EB/5ZLXNPWUjrVpF5NSaPGe56opEG+VuEWqtHKfy3pwImYP7x6B0JpXGIuiaQPDAfnR4
         fBd3ZM9GMdnrdmgxbTRF+F+HdOtdDRWFHiOHZVSRTpx04D2Ytyjpp5TXG2q8lKKDobPx
         YLBRxYr/k+XUI4DTPk1BURRTTi6xBnYi3JEVN1ChHf8xMOh0kt2Ex1SovA0Io8u7cV+V
         tpApVj/xo7ZiWd0HJiLAuIhEjmPKOXuknKFAnKtUhxmTNEK42o7YN1MPgOGQdGq1YlmQ
         5Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040814; x=1763645614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhHd/vd5PilZlak+JY6GVryWSDKciGyRf9y3293OwHk=;
        b=drjPgLi+5rWZe9ACsCwb2L3RNod8Zl0tzNPM5GCivnEuvTB4kKXfm2+m6CgRJsopsA
         y7m8Pjv1dUDQAfHRjuttKrmRT9vdGYzbDj29uHQyZ5K8Xy3RjTAM6FCMMEWyLig2iog6
         jewfuFHh+HbxWFp4RDqN7vikHDIfoLZ9NJF67PobBpZJ2bs2gnCRTGB21PyeTKQdDgp0
         jpTD5hhDZ/kmdmBAe3n5NQWqQMH7fXM+xbhA4E51GSuokU/LBOKqRABGqWoH+rKSbldt
         ySOGXYlG0yJWVGGmvuKvbUKYG3PuSsi7XdaTmSLMWR5FER63398b3jORYv2bo6mDp5pA
         74RA==
X-Forwarded-Encrypted: i=1; AJvYcCVW0hO7TJw44MUuIHbajduzSfpACaVs7S93vXf0cw31BoKawmiWZ17kKzFvdQWEDGk6orZhOTFQwws8g+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmZItUMd1dyYQrJkenkdk6YfAQFPcBPRiVFYaKv+A3eNPPnZR
	iTssqqLJWIcJG4MuT/oOcJxyqyu7APvoeAqW1gUn+aE9qVikgZDOEQu2
X-Gm-Gg: ASbGncvCQ40xefC8HsG4iMohbUUZHSG8bqIH5Yj32Hn3K7W4HmTjd6vKMNif7TPpHrZ
	b10JfCPqaMLAnkSwuKGCfVD/e0PcPWUZNXeuMokQZ0+1gXhpP8N6o7Fbx4FHglJBRMx/ZNdHeSr
	KvaHCO+ZCs2FbyFqGsx+vYj8HstnoolJzVsDwzXLScFWpuo0zQJ7tsTVrtdn5uIcq2e7njqvvyO
	vKoM/BvsETI4Q5wY22HLYM2KMdyKALNJlEhi2Gi355K5qYLttOw2OCu5ePfUw3jbHTwvWK7AYRU
	Ij4IHPZclHk2QWhCDPrpbL/4cpVVtCJfQdI7RMO4EuuyzAopP6hUzCnYmQ+7vIQCv1pKWAaDKpi
	xujgGPcur6JywMqVguZl0XJ2WOYbTAeT0H+fgcqzAjfE=
X-Google-Smtp-Source: AGHT+IGUL4qC6K+DHAMyAznh1nPqOVVG3vBedGscK4G1HhCq8iWh/Gjrhh8TEulXo726uPx2/aO9Jg==
X-Received: by 2002:a05:6512:b85:b0:594:34b9:a817 with SMTP id 2adb3069b0e04-59576e19be4mr2460400e87.33.1763040813955;
        Thu, 13 Nov 2025 05:33:33 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804128c6sm394619e87.111.2025.11.13.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:33:33 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 13 Nov 2025 14:33:31 +0100
To: vishal.moola@gmail.com
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, hch@infradead.org,
	hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	urezki@gmail.com, vishal.moola@gmail.com, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRXeK_C44xGb3ovg@milan>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
 <69158bb1.a70a0220.3124cb.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69158bb1.a70a0220.3124cb.001e.GAE@google.com>

On Wed, Nov 12, 2025 at 11:41:37PM -0800, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v2] make vmalloc gfp flags usage more apparent
> https://lore.kernel.org/all/20251112185834.32487-1-vishal.moola@gmail.com
> * [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
> * [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
> * [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
> * [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
> 
> and found the following issue:
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> Full report is available here:
> https://ci.syzbot.org/series/46d6cb1a-188d-4ff5-8fab-9c58465d74d3
> 
> ***
> 
> WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      b179ce312bafcb8c68dc718e015aee79b7939ff0
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/3449e2a5-35e0-4eac-86c6-97ca0ec741d7/config
> 
> ------------[ cut here ]------------
> Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0, CPU#1: syz-executor/6079
> Modules linked in:
>
Again bpf :)

GFP_KERNEL_ACCOUNT? I saw there have been __GFP_HARDWALL added already,
IMO it is worth to replace it by "high level flag", which is GFP_USER.

--
Uladzislau Rezki

