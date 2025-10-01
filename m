Return-Path: <linux-kernel+bounces-839295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1285FBB1453
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629EC4A22C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE82773F3;
	Wed,  1 Oct 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pIK+xUiS"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D244288AD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336900; cv=none; b=P42wLHht2iMqcbmBPy2YtkgwZsy2EDLZejWwtyrJh3yylJGz2D/8SGIr/yNdeDciTWmQ6Y8DMfuaRU/X8reHfloT8222w96nSJCRJaTVbjWGuGDC28OXiY+DZVosM5qrwdXXKhQYYwCeIWL1bNtM0XtWj+cWvjXsSPAUqwS4cDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336900; c=relaxed/simple;
	bh=a1XoZxtaZXzc8savHnGOQOVy8U9jDAKbQJJWbfvFnHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ+rNJnAJnV970U9EvPFDI0aqsuLd/CtfnmOWIKfna1/9qYn4ht6OMLID+vT9PyQr2ixONzIwojX1dauqfAURN+C6r00Qg144RWyiVzB7OrJPom7PwhG2vpXKuCtghzaZ1o3WU6PC6Q9fuNpcVa0imcu0KP2mLZ3tTsaxfKW0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pIK+xUiS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ddf60466d4so564991cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1759336896; x=1759941696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Pdh4UPxBNFa+jIlOxZr+0N7CcxwrBzi/u8gKDgJeo=;
        b=pIK+xUiSd+4SmGlRfnZwSqHstmXUrPLo2VGzgmbOJFExLiD2HgP8nYDLMBOg9FbxHz
         oAWrb/BjFohZ4tIk0mEMpqVUSbvofJed4u2sSipMpm1+BWPshr7q+tMS/g94Pb1fZ957
         U1gk/CDAqt4pJGd+2uFM+156tsuLRQGCvTexvrWzxX5+GvLrvQumQTY0yOhl2BqTrR9E
         N5I+v9QdMArXRUVvk2jvH80e972vSbrmh1V3fgpzVmKDtDa8HPrZDjG0zSgDA5mIy1XB
         iUr27J60OTQHRi9OVqR1sL4QJZ3hm0yJjvnaJMzTwtAIziJlp08MBgUNEgvG0exuP1T5
         eaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336896; x=1759941696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Pdh4UPxBNFa+jIlOxZr+0N7CcxwrBzi/u8gKDgJeo=;
        b=vwELocxfnOPVIRDPKso9lBX9uYFG2fGdlU+p25eQigRSOLkyJShoFH7CP8wZEDFKKm
         4q2fk4iVDKaP9cHWQVXd/cBtt2arqwyL3rkKbdpdr+MlW239huFl1A34M0Y59IrtqcRi
         MiyjySRmwnWdqFrooa6uXMw6dUHDnE9ggbnXnvS58ziSuRB6vyTioMZBjGuY1lx0JM8X
         tJE7vhhXLGZtOUpHze6VE5i8wJ+UIYLEEyE1z09YHiEKW2sRfZJE75Fx0Xs6hAehKzYY
         NMQSFjueJUfwFnViyZa6+LsEsyJ5jl7ymrH5UYsCtixjXmyhiZ71y4zxTkdkILsjNHgy
         2kgw==
X-Forwarded-Encrypted: i=1; AJvYcCVeYLumMOf2zfG5sm/cVN1XFZBiRoa7RVVUL7sP3Fgp0oJMd0tpLe4s95oaiJtsQFf4pk/IBhOgR3zh/NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeBAg4TAXWPpbSN1adNWsD0aEo3yOC1KH0dF/IJe8ma5AsAB9
	wS0IaVgdoOfxQOBqqVeKURu/gN32oADFSSpM3SkzhBXmQjW69AIw4rFQKJiOPuXOTI4=
X-Gm-Gg: ASbGnctjD95N6yQnsko+hGLxMM2WJOgwRQEgDxLtRhwesN5egL+cnu4MrCoJ2Jg7fTf
	IiEQoQycQoQi4vj7wkuOUhQzazfQHWZTZ/1LCDfAuhg0mcypWLD0+2+VaY0vOok6BlSgbuFQCK3
	oygtxq6a24zhJnlysB38mManBkHn54fs8kEYrLXlcdvfyNF6/oxXpmnmCF4U8xu0QLnmAWpWpcA
	ynSEVeLfeccI4WySIqB1NricJQxK0kMascvAxbhS0RV6DXT6lGVDr3E2tts/XKL72+AjjJidOdS
	1ok/qtLj8RlHtStd0phLXE49n61ZoI+Kog82R7AcAIGCSoMYaQ8GwtBriM3SYz9qOt353lzFFx8
	DpEm7d+a2gf2bVnUea3T7SV9vgDxhBKZ9rKFyu10+VT9guw==
X-Google-Smtp-Source: AGHT+IGPb0Edu1K4J4/cuc8wtsu5FZIIzXcuwfIai0CmgIW3O2Li8d+X8dt0nP89wSlyBM1hFk3zHQ==
X-Received: by 2002:a05:622a:2cf:b0:4b7:81df:95e2 with SMTP id d75a77b69052e-4e41ea16a29mr49675751cf.40.1759336896110;
        Wed, 01 Oct 2025 09:41:36 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-877796a1c72sm8001285a.46.2025.10.01.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:41:35 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:41:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] mm: page_alloc: avoid kswapd thrashing due to NUMA
 restrictions
Message-ID: <20251001164131.GB1597553@cmpxchg.org>
References: <20250919162134.1098208-1-hannes@cmpxchg.org>
 <4a793133-6cb3-42d4-948f-84eae6fa7df3@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a793133-6cb3-42d4-948f-84eae6fa7df3@suse.cz>

On Wed, Oct 01, 2025 at 04:59:02PM +0200, Vlastimil Babka wrote:
> On 9/19/25 6:21 PM, Johannes Weiner wrote:
> > On NUMA systems without bindings, allocations check all nodes for free
> > space, then wake up the kswapds on all nodes and retry. This ensures
> > all available space is evenly used before reclaim begins. However,
> > when one process or certain allocations have node restrictions, they
> > can cause kswapds on only a subset of nodes to be woken up.
> > 
> > Since kswapd hysteresis targets watermarks that are *higher* than
> > needed for allocation, even *unrestricted* allocations can now get
> > suckered onto such nodes that are already pressured. This ends up
> > concentrating all allocations on them, even when there are idle nodes
> > available for the unrestricted requests.
> > 
> > This was observed with two numa nodes, where node0 is normal and node1
> > is ZONE_MOVABLE to facilitate hotplugging: a kernel allocation wakes
> > kswapd on node0 only (since node1 is not eligible); once kswapd0 is
> > active, the watermarks hover between low and high, and then even the
> > movable allocations end up on node0, only to be kicked out again;
> > meanwhile node1 is empty and idle.
> 
> Is this because node1 is slow tier as Zi suggested, or we're talking
> about allocations that are from node0's cpu, while allocations on
> node1's cpu would be fine?

It applies in either case. The impetus for this fix was from behavior
in a tiered system, but this seems like a general NUMA problem to me.

Say you have a VM where you use an extra node for runtime resizing,
making it ZONE_MOVABLE to keep it hotpluggable.

> > Similar behavior is possible when a process with NUMA bindings is
> > causing selective kswapd wakeups.
> > 
> > To fix this, on NUMA systems augment the (misleading) watermark test
> > with a check for whether kswapd is already active during the first
> > iteration through the zonelist. If this fails to place the request,
> > kswapd must be running everywhere already, and the watermark test is
> > good enough to decide placement.
> 
> Suppose kswapd finished reclaim already, so this check wouldn't kick in.
> Wouldn't we be over-pressuring node0 still, just somewhat less?

Yes. And we've seen that to a degree, where kswapd goes to sleep
intermittently and the occasional (high - low) batch of fresh pages
makes it into node0 until kswapd is woken up again.

It still fixed the big picture pathological case, though, where
*everything* was just concentrated on node0. So I figured why
complicate it. But there would be room for some hysteresis.

Another option could be, instead of checking kswapds, to check the
watermarks against the high thresholds on that first zonelist
iteration. After all, that's where a recently-gone-to-sleep would
leave the watermark level.

But it would need a fudge factor too, to account for the fact that
kswapd might overreclaim past the high watermark. And the overreclaim
factor is something that has historically fluctuated quite a bit
between systems and kernel versions. So this could be too
fragile. Kswapd being active is a very definitive signal comparably.

